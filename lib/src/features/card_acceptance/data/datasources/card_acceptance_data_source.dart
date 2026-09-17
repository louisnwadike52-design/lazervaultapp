import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import 'package:lazervault/src/core/errors/grpc_exceptions.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/banking.pbgrpc.dart' as banking_pb;
import '../../domain/entities/card_charge_entity.dart';

/// Card acceptance (SoftPOS) over the banking gateway.
///
/// NO CARD DATA PASSES THROUGH HERE. The certified reader SDK produces an
/// encrypted payload which this forwards verbatim; a PAN reaching our own code
/// would drag the app and every service behind it into PCI scope.
class CardAcceptanceDataSource {
  CardAcceptanceDataSource({
    required banking_pb.BankingServiceClient client,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _client = client,
        _callOptionsHelper = callOptionsHelper;

  final banking_pb.BankingServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  /// Whether card payments can be taken, asked before the merchant starts.
  Future<CardAcceptanceStatusEntity> status() async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.getCardAcceptanceStatus(
        banking_pb.GetCardAcceptanceStatusRequest(),
        options: options,
      );
      return CardAcceptanceStatusEntity(
        available: resp.available,
        activeProvider: resp.activeProvider,
        usableProviders: resp.usableProviders.toList(),
        unavailableReason: resp.unavailableReason,
      );
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// Open a sale.
  ///
  /// [reference] must be stable across retries of the SAME sale. The server is
  /// idempotent on it, which is what stops a phone on a bad connection from
  /// charging a customer twice for one tap — so it is generated once when the
  /// merchant confirms the amount, never per attempt.
  Future<CardChargeEntity> createCharge({
    required String reference,
    required int amountMinor,
    required String currency,
    String description = '',
    String terminalId = '',
    String staffUserId = '',
    String devicePayload = '',
  }) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.createCardCharge(
        banking_pb.CreateCardChargeRequest(
          reference: reference,
          amountMinor: Int64(amountMinor),
          currency: currency,
          description: description,
          terminalId: terminalId,
          staffUserId: staffUserId,
          devicePayload: devicePayload,
        ),
        options: options,
      );
      return _toEntity(resp.charge);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// Where a sale has got to. Polled after a tap; the webhook usually beats it.
  Future<CardChargeEntity> chargeStatus(String reference) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.getCardCharge(
        banking_pb.GetCardChargeRequest(reference: reference),
        options: options,
      );
      return _toEntity(resp.charge);
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  /// The merchant's own sales, newest first, with what they are still owed.
  Future<({List<CardChargeEntity> charges, int total, int unsettledMinor})>
      myCharges({String status = '', int limit = 50, int offset = 0}) async {
    try {
      final options = await _callOptionsHelper.withAuth();
      final resp = await _client.listMyCardCharges(
        banking_pb.ListMyCardChargesRequest(
          status: status,
          limit: limit,
          offset: offset,
        ),
        options: options,
      );
      return (
        charges: resp.charges.map(_toEntity).toList(),
        total: resp.total,
        unsettledMinor: resp.unsettledAmountMinor.toInt(),
      );
    } on GrpcError catch (e) {
      throw mapGrpcError(e);
    }
  }

  CardChargeEntity _toEntity(banking_pb.CardCharge c) => CardChargeEntity(
        reference: c.reference,
        status: c.status,
        amountMinor: c.amountMinor.toInt(),
        currency: c.currency.isEmpty ? 'NGN' : c.currency,
        provider: c.provider,
        providerReference: c.providerReference,
        feeMinor: c.feeMinor.toInt(),
        description: c.description,
        terminalId: c.terminalId,
        staffUserId: c.staffUserId,
        cardLast4: c.cardLast4,
        cardBrand: c.cardBrand,
        authCode: c.authCode,
        failureReason: c.failureReason,
        settlementReference: c.settlementReference,
        authorisedAt: _parse(c.authorisedAt),
        settledAt: _parse(c.settledAt),
        createdAt: _parse(c.createdAt),
      );

  /// Timestamps arrive as RFC3339, empty when unset. An unparseable value gives
  /// null rather than 1 Jan 1970, which a receipt would print as a real date.
  DateTime? _parse(String raw) =>
      raw.isEmpty ? null : DateTime.tryParse(raw)?.toLocal();
}
