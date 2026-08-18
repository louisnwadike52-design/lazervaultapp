import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import '../../../../../core/utils/friendly_error.dart';
import '../../domain/repositories/bulk_sms_repository.dart';
import 'bulk_sms_state.dart';

class BulkSmsCubit extends Cubit<BulkSmsState> {
  final BulkSmsRepository repository;

  BulkSmsCubit({required this.repository}) : super(const BulkSmsState());

  // ── Reads ────────────────────────────────────────────────────────────
  Future<void> loadProviders({String country = 'NG'}) async {
    if (isClosed) return;
    emit(state.copyWith(providersStatus: SectionStatus.loading));
    try {
      final providers = await repository.getProviders(country: country);
      if (isClosed) return;
      emit(state.copyWith(
          providersStatus: SectionStatus.loaded, providers: providers));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          providersStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadBalance({String providerName = ''}) async {
    if (isClosed) return;
    emit(state.copyWith(balanceStatus: SectionStatus.loading));
    try {
      final balance = await repository.getBalance(providerName: providerName);
      if (isClosed) return;
      emit(state.copyWith(
          balanceStatus: SectionStatus.loaded, balance: balance));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          balanceStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadPackages({String country = 'NG', String currency = 'NGN'}) async {
    if (isClosed) return;
    emit(state.copyWith(packagesStatus: SectionStatus.loading));
    try {
      final packages =
          await repository.getPackages(country: country, currency: currency);
      if (isClosed) return;
      emit(state.copyWith(
          packagesStatus: SectionStatus.loaded, packages: packages));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          packagesStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadSenderIds() async {
    if (isClosed) return;
    emit(state.copyWith(senderIdsStatus: SectionStatus.loading));
    try {
      final ids = await repository.getSenderIds();
      if (isClosed) return;
      emit(state.copyWith(
          senderIdsStatus: SectionStatus.loaded, senderIds: ids));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          senderIdsStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadHistory({int page = 1, int pageSize = 20, String statusFilter = ''}) async {
    if (isClosed) return;
    emit(state.copyWith(historyStatus: SectionStatus.loading));
    try {
      final history = await repository.getHistory(
          page: page, pageSize: pageSize, statusFilter: statusFilter);
      if (isClosed) return;
      emit(state.copyWith(
          historyStatus: SectionStatus.loaded, history: history));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          historyStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadCampaignStatus(String campaignId) async {
    if (isClosed) return;
    emit(state.copyWith(campaignStatus: SectionStatus.loading));
    try {
      final campaign = await repository.getCampaignStatus(campaignId);
      if (isClosed) return;
      emit(state.copyWith(
          campaignStatus: SectionStatus.loaded, campaign: campaign));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          campaignStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> loadDeliveryReport(String campaignId, {String statusFilter = ''}) async {
    if (isClosed) return;
    emit(state.copyWith(reportStatus: SectionStatus.loading));
    try {
      final reports = await repository.getDeliveryReport(
          campaignId: campaignId, statusFilter: statusFilter);
      if (isClosed) return;
      emit(state.copyWith(
          reportStatus: SectionStatus.loaded, reports: reports));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          reportStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  // ── Money moves (PIN already validated by the caller) ────────────────
  Future<void> buyCredits({
    required String packageId,
    required String providerName,
    required String currency,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(purchaseStatus: ActionStatus.processing));
    try {
      final result = await repository.purchaseCredits(
        packageId: packageId,
        providerName: providerName,
        currency: currency,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      if (isClosed) return;
      emit(state.copyWith(
        purchaseStatus: ActionStatus.success,
        purchaseResult: result,
        // Reflect the fresh balance right away on the landing card.
        balance: SmsBalanceEntity(
          creditsRemaining: result.newCreditBalance,
          providerName: providerName,
          lastPurchaseAt: DateTime.now(),
        ),
        balanceStatus: SectionStatus.loaded,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          purchaseStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  Future<void> sendCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(
        sendStatus: ActionStatus.processing, lastSendWasScheduled: false));
    try {
      final result = await repository.sendCampaign(
        providerName: providerName,
        senderId: senderId,
        messageTemplate: messageTemplate,
        recipients: recipients,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      if (isClosed) return;
      emit(state.copyWith(
        sendStatus: ActionStatus.success,
        sendResult: result,
        lastSendWasScheduled: false,
        balance: SmsBalanceEntity(
          creditsRemaining: result.newCreditBalance,
          providerName: providerName,
          lastPurchaseAt: state.balance?.lastPurchaseAt,
        ),
        balanceStatus: SectionStatus.loaded,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          sendStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  Future<void> scheduleCampaign({
    required String providerName,
    required String senderId,
    required String messageTemplate,
    required List<SmsRecipientEntity> recipients,
    required DateTime scheduledAt,
    required String transactionId,
    required String verificationToken,
    required String idempotencyKey,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(
        sendStatus: ActionStatus.processing, lastSendWasScheduled: true));
    try {
      final result = await repository.scheduleCampaign(
        providerName: providerName,
        senderId: senderId,
        messageTemplate: messageTemplate,
        recipients: recipients,
        scheduledAt: scheduledAt,
        transactionId: transactionId,
        verificationToken: verificationToken,
        idempotencyKey: idempotencyKey,
      );
      if (isClosed) return;
      emit(state.copyWith(
        sendStatus: ActionStatus.success,
        sendResult: result,
        lastSendWasScheduled: true,
        balance: SmsBalanceEntity(
          creditsRemaining: result.newCreditBalance,
          providerName: providerName,
          lastPurchaseAt: state.balance?.lastPurchaseAt,
        ),
        balanceStatus: SectionStatus.loaded,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          sendStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  Future<void> cancelScheduled(String campaignId) async {
    if (isClosed) return;
    emit(state.copyWith(cancelStatus: ActionStatus.processing));
    try {
      final result = await repository.cancelScheduledSms(campaignId);
      if (isClosed) return;
      emit(state.copyWith(
          cancelStatus: ActionStatus.success, cancelResult: result));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          cancelStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  Future<void> requestSenderId({
    required String senderId,
    required String country,
    required String purpose,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(senderIdRequestStatus: ActionStatus.processing));
    try {
      final result = await repository.requestSenderId(
          senderId: senderId, country: country, purpose: purpose);
      if (isClosed) return;
      emit(state.copyWith(
          senderIdRequestStatus: ActionStatus.success,
          requestedSenderId: result));
      // Refresh the list so the new pending id shows immediately.
      await loadSenderIds();
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          senderIdRequestStatus: ActionStatus.failed,
          errorMessage: _friendly(e)));
    }
  }

  // ── Saved recipient groups (no money move) ───────────────────────────
  Future<void> loadGroups() async {
    if (isClosed) return;
    emit(state.copyWith(groupsStatus: SectionStatus.loading));
    try {
      final groups = await repository.listGroups();
      if (isClosed) return;
      emit(state.copyWith(
          groupsStatus: SectionStatus.loaded, groups: groups));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          groupsStatus: SectionStatus.error, errorMessage: _friendly(e)));
    }
  }

  Future<void> createGroup({
    required String name,
    required List<SmsRecipientEntity> recipients,
  }) async {
    if (isClosed) return;
    emit(state.copyWith(groupActionStatus: ActionStatus.processing));
    try {
      final group =
          await repository.createGroup(name: name, recipients: recipients);
      if (isClosed) return;
      // Prepend so the fresh group shows at the top immediately.
      emit(state.copyWith(
        groupActionStatus: ActionStatus.success,
        groups: [group, ...state.groups],
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          groupActionStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  /// Fetches a saved group's full members. The list endpoint omits members for
  /// payload size, so the picker resolves them on tap. Returns `[]` on failure
  /// (with [BulkSmsState.errorMessage] set for the caller to surface).
  Future<List<SmsRecipientEntity>> resolveGroupMembers(String groupId) async {
    try {
      final group = await repository.getGroup(groupId);
      return group.members;
    } catch (e) {
      if (!isClosed) emit(state.copyWith(errorMessage: _friendly(e)));
      return const [];
    }
  }

  Future<void> deleteGroup(String groupId) async {
    if (isClosed) return;
    emit(state.copyWith(groupActionStatus: ActionStatus.processing));
    try {
      await repository.deleteGroup(groupId);
      if (isClosed) return;
      emit(state.copyWith(
        groupActionStatus: ActionStatus.success,
        groups: state.groups.where((g) => g.id != groupId).toList(),
      ));
    } catch (e) {
      if (isClosed) return;
      emit(state.copyWith(
          groupActionStatus: ActionStatus.failed, errorMessage: _friendly(e)));
    }
  }

  /// Reset the transient action statuses back to idle (call after a screen has
  /// consumed a success/failure so re-entering doesn't re-trigger navigation).
  void resetActions() {
    if (isClosed) return;
    emit(state.copyWith(
      purchaseStatus: ActionStatus.idle,
      sendStatus: ActionStatus.idle,
      cancelStatus: ActionStatus.idle,
      senderIdRequestStatus: ActionStatus.idle,
      groupActionStatus: ActionStatus.idle,
    ));
  }

  /// Canonical error mapping (see `core/utils/friendly_error.dart`). Raw gRPC
  /// text never reaches the UI.
  String _friendly(dynamic error) {
    if (isNetworkError(error)) return networkErrorMessage;
    if (isFrozenAccountError(error)) return frozenAccountMessage;
    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.unauthenticated:
          return 'Your session has expired. Please sign in again.';
        case StatusCode.permissionDenied:
          return 'Not authorized. Please verify your PIN and try again.';
        case StatusCode.resourceExhausted:
          return 'Too many requests. Please wait a moment and try again.';
        case StatusCode.failedPrecondition:
        case StatusCode.invalidArgument:
          return sanitizeUserFacingError(error.message);
        default:
          return 'Something went wrong. Please try again.';
      }
    }
    return sanitizeUserFacingError(error.toString());
  }
}
