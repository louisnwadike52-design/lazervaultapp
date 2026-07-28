import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/exchange.pbgrpc.dart';

import '../../domain/entities/exchange_prediction_entity.dart';

/// Best-effort, READ-ONLY data source for the exchange success-prediction
/// signals shown on the international transfer confirmation step.
///
/// Contract is identical in shape to the domestic transfer-prediction
/// pattern (see lib/src/features/funds/data/datasources/payments_transfer_data_source.dart
/// — `getTransferSuccessPrediction`). Key properties:
///
///   * Non-blocking: any failure (UNIMPLEMENTED, timeout, parse error, channel
///     issue) returns null. The host widget renders NOTHING in that case.
///   * Bounded latency: 8s timeout matches the transfer pattern.
///   * No exceptions: swallowed and printed. Never throw to the caller.
///
/// Implementation: the recipient-trust band is computed from the user's OWN
/// exchange history via the existing `GetRecentExchanges` RPC — no dedicated
/// backend RPC or proto change required. Prior COMPLETED international
/// transfers to the same recipient account ⇒ "verified"; none ⇒ "new". The
/// corridor-availability band needs server-side aggregate success rates that
/// aren't exposed to the client, so it stays 'unknown' (the widget hides that
/// row); the fraud blocklist is enforced authoritatively by the backend at
/// submit time. If richer server-side signals are wanted later, a dedicated
/// `GetExchangeRecipientTrust` RPC can replace this body without touching the
/// cubit / widget / DI.
///
/// See also: `domain/entities/exchange_prediction_entity.dart` for the full
/// proto contract documentation.
abstract class IExchangePredictionRemoteDataSource {
  /// Returns null when:
  ///   * inputs are empty
  ///   * backend RPC is UNIMPLEMENTED (code 12) — common during rollout
  ///   * RPC fails for any other reason (timeout, channel, parse)
  ///   * source == destination currency (no-op, nothing to predict on)
  Future<ExchangePredictionEntity?> getRecipientTrust({
    required String country,
    required String accountOrIban,
    required String currencyPair,
  });
}

class ExchangePredictionRemoteDataSourceImpl
    implements IExchangePredictionRemoteDataSource {
  final ExchangeServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  ExchangePredictionRemoteDataSourceImpl({
    required ExchangeServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  @override
  Future<ExchangePredictionEntity?> getRecipientTrust({
    required String country,
    required String accountOrIban,
    required String currencyPair,
  }) async {
    // Defensive: empty inputs == nothing to predict on.
    if (country.isEmpty || accountOrIban.isEmpty || currencyPair.isEmpty) {
      return null;
    }

    // Same-currency pair is a conversion no-op; the alert is for cross-border
    // transfers only — bail before hitting the wire.
    final parts = currencyPair.split('_');
    if (parts.length == 2 && parts[0].toUpperCase() == parts[1].toUpperCase()) {
      return null;
    }

    try {
      final callOptions = await _callOptionsHelper.withAuth(
        CallOptions(timeout: const Duration(seconds: 8)),
      );

      // Real recipient-trust signal computed from the user's OWN exchange
      // history (no dedicated backend RPC required, no proto change): count
      // prior COMPLETED international transfers to this exact recipient
      // account. A recipient the user has successfully paid before is
      // "verified"; a first-time recipient is "new". This is the primary,
      // most actionable signal on the confirmation step.
      //
      // The corridor-availability band needs server-side aggregate success
      // rates we don't expose to the client, so it's left 'unknown' (the
      // widget hides that row). Blocklist is enforced authoritatively by the
      // backend at submit time (isDestinationBlocklisted), which returns a
      // clear error — so we don't pre-flag it here.
      final resp = await _client.getRecentExchanges(
        GetRecentExchangesRequest()..pageSize = 100,
        options: callOptions,
      );

      final wanted = _normalizeAccount(accountOrIban);
      int priorCount = 0;
      DateTime? earliest;
      for (final tx in resp.transactions) {
        if (tx.exchangeType != ExchangeType.INTERNATIONAL) continue;
        if (tx.status != ExchangeStatus.COMPLETED) continue;
        if (_normalizeAccount(tx.receiverDetails.accountNumber) != wanted) {
          continue;
        }
        priorCount++;
        if (tx.hasCreatedAt()) {
          final ts = DateTime.fromMillisecondsSinceEpoch(
            tx.createdAt.seconds.toInt() * 1000,
          );
          if (earliest == null || ts.isBefore(earliest)) earliest = ts;
        }
      }

      return ExchangePredictionEntity(
        bankAvailabilityPct: 0,
        bankBand: 'unknown', // corridor aggregate not exposed client-side
        bankSampleSize: 0,
        recipientTrustBand: priorCount >= 1 ? 'verified' : 'new',
        priorExchangeCount: priorCount,
        knownSince: earliest,
        blocklisted: false, // enforced server-side at submit
      );
    } on GrpcError catch (e) {
      // UNIMPLEMENTED (12) is the expected state during rollout, but ANY
      // gRPC failure is treated the same way: render nothing, never block.
      // ignore: avoid_print
      print('exchange prediction RPC failed: ${e.code} ${e.message}');
      return null;
    } catch (e) {
      // ignore: avoid_print
      print('exchange prediction unexpected error: $e');
      return null;
    }
  }

  /// Normalize an account/IBAN for equality: strip spaces, uppercase. Lets
  /// "GB29 NWBK..." match "gb29nwbk..." across entry variants.
  String _normalizeAccount(String v) =>
      v.replaceAll(RegExp(r'\s+'), '').toUpperCase();
}
