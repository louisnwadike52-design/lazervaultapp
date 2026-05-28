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
/// Backend RPC status: the `GetExchangeRecipientTrust` RPC is NOT yet exposed
/// on ExchangeServiceClient (no entry in
/// `lib/src/generated/exchange.pbgrpc.dart`). This data source is wired so
/// that the moment the proto is regenerated (after the server-side task
/// lands), only the `_callRpc()` body needs flipping from the documented
/// stub to a real `_client.getExchangeRecipientTrust(...)` call — every
/// other layer (cubit, alert widget, DI, screen wiring) is already in place.
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
  // Held so the day the proto regenerates we can switch the stub body to a
  // real `_client.getExchangeRecipientTrust(...)` call without touching the
  // DI registration or the cubit. See file header.
  // ignore: unused_field
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
      // Build auth headers exactly the same way the rest of exchange flows do.
      // We touch this even on the stub path so that the day the proto
      // regenerates we don't discover a missing auth interceptor.
      await _callOptionsHelper.withAuth(
        CallOptions(timeout: const Duration(seconds: 8)),
      );

      // ----------------------------------------------------------------
      // STUB GUARD — see file header.
      //
      // `ExchangeServiceClient.getExchangeRecipientTrust` does not exist yet
      // in the generated client. Until the server-side task lands and we
      // regenerate the proto, calling it would not compile. We mirror the
      // production "RPC is UNIMPLEMENTED" behaviour by returning null here.
      //
      // When the proto is regenerated, replace this block with:
      //
      //   final response = await _client.getExchangeRecipientTrust(
      //     GetExchangeRecipientTrustRequest(
      //       country: country,
      //       accountOrIban: accountOrIban,
      //       currencyPair: currencyPair,
      //     ),
      //     options: callOptions.mergedWith(
      //       CallOptions(timeout: const Duration(seconds: 8)),
      //     ),
      //   );
      //
      //   final knownSinceUnix = response.recipientKnownSinceUnix.toInt();
      //   return ExchangePredictionEntity(
      //     bankAvailabilityPct: response.bankAvailabilityPct,
      //     bankBand: response.bankBand.isNotEmpty ? response.bankBand : 'unknown',
      //     bankSampleSize: response.bankSampleSize,
      //     recipientTrustBand: response.recipientTrustBand.isNotEmpty
      //         ? response.recipientTrustBand
      //         : 'unknown',
      //     priorExchangeCount: response.priorExchangeCount,
      //     knownSince: knownSinceUnix > 0
      //         ? DateTime.fromMillisecondsSinceEpoch(knownSinceUnix * 1000)
      //         : null,
      //     blocklisted: response.blocklisted,
      //   );
      // ----------------------------------------------------------------
      return null;
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
}
