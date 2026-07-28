import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/core/network/grpc_client.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/repositories/escrow_repository.dart';

part 'escrow_state.dart';

/// Strips the noisy "Exception: " / gRPC envelope from an error so the UI shows
/// the human-readable service message.
String _clean(Object e) {
  var s = e.toString();
  s = s.replaceAll('Exception: ', '');
  final idx = s.indexOf('message: ');
  if (idx >= 0) s = s.substring(idx + 'message: '.length);
  return s.trim().isEmpty ? 'Something went wrong. Please try again.' : s.trim();
}

class EscrowCubit extends Cubit<EscrowState> {
  final EscrowRepository repository;
  final GrpcClient grpcClient;

  EscrowCubit({required this.repository, required this.grpcClient})
      : super(const EscrowInitial());

  String _currentUserId = '';

  Future<String> _userId() async {
    if (_currentUserId.isNotEmpty) return _currentUserId;
    _currentUserId = (await grpcClient.getCurrentUserId()) ?? '';
    return _currentUserId;
  }

  /// Load the caller's deals. role: "", "buyer", "seller".
  Future<void> loadDeals({String role = '', String status = ''}) async {
    emit(const EscrowLoading());
    try {
      final uid = await _userId();
      final deals = await repository.listMyDeals(role: role, status: status);
      emit(EscrowDealsLoaded(deals, uid));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<void> loadDeal(String dealId) async {
    emit(const EscrowLoading());
    try {
      final uid = await _userId();
      final deal = await repository.getDeal(dealId);
      emit(EscrowDealLoaded(deal, uid));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  /// Fee preview — emits EscrowFeeQuoted without disturbing list/detail state.
  Future<EscrowFeeQuote?> quoteFee(double amount, {String currency = 'NGN'}) async {
    try {
      final q = await repository.quoteFee(amount: amount, currency: currency);
      emit(EscrowFeeQuoted(q));
      return q;
    } catch (_) {
      return null;
    }
  }

  Future<EscrowDealEntity?> createDeal({
    required String buyerAccountId,
    required String sellerQuery,
    required String title,
    String description = '',
    required double amount,
    int deadlineDays = 0,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
    String buyerItemImageUrl = '',
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.createDeal(
        buyerAccountId: buyerAccountId,
        sellerQuery: sellerQuery,
        title: title,
        description: description,
        amount: amount,
        deadlineDays: deadlineDays,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
        buyerItemImageUrl: buyerItemImageUrl,
      );
      emit(EscrowActionSuccess('Deal funded and created', deal));
      return deal;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  Future<void> markDelivered({
    required String dealId,
    String deliveryNote = '',
    String sellerProofImageUrl = '',
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.markDelivered(
        dealId: dealId,
        deliveryNote: deliveryNote,
        sellerProofImageUrl: sellerProofImageUrl,
      );
      emit(EscrowActionSuccess('Marked as delivered', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<EscrowDealEntity?> validateRelease({
    required String dealId,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.validateRelease(
        dealId: dealId,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      emit(EscrowActionSuccess('Funds released to seller', deal));
      return deal;
    } catch (e) {
      emit(EscrowError(_clean(e)));
      return null;
    }
  }

  Future<void> cancelDeal({required String dealId, String reason = '', required String idempotencyKey}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.cancelDeal(dealId: dealId, reason: reason, idempotencyKey: idempotencyKey);
      emit(EscrowActionSuccess('Deal cancelled and refunded', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }

  Future<void> openDispute({required String dealId, required String reason, String evidenceUrl = ''}) async {
    emit(const EscrowActionInProgress());
    try {
      final deal = await repository.openDispute(dealId: dealId, reason: reason, evidenceUrl: evidenceUrl);
      emit(EscrowActionSuccess('Dispute opened — our team will review it', deal));
    } catch (e) {
      emit(EscrowError(_clean(e)));
    }
  }
}
