import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/split_bills/domain/entities/split_bill_entity.dart';
import 'package:lazervault/src/features/split_bills/domain/repositories/split_bill_repository.dart';

/// Lightweight singleton cubit that exposes the number of incoming split bills
/// where the current user is a co-payer still in `pending` status. Drives the
/// notification badge on the "Split Bills" quick action.
///
/// Modelled on [P2PConversationsCubit]: a Cubit whose state is just an int
/// count. `refresh()` is safe to call repeatedly and never throws — on any
/// failure it emits 0 so the badge simply disappears.
class SplitBillCountCubit extends Cubit<int> {
  final SplitBillRepository _repository;

  SplitBillCountCubit({required SplitBillRepository repository})
      : _repository = repository,
        super(0);

  /// Fetches incoming (active) split bills and counts those where the current
  /// user's participant record is still pending. Emits the resulting count.
  Future<void> refresh() async {
    try {
      final userId = await _resolveCurrentUserId();
      if (userId == null || userId.isEmpty) {
        _safeEmit(0);
        return;
      }

      final result = await _repository.getMyIncomingSplitBills(
        limit: 100,
        status: SplitBillStatus.active,
      );

      final count = result.bills
          .where((bill) => bill.participantForUser(userId)?.isPending == true)
          .length;

      _safeEmit(count);
    } catch (e) {
      debugPrint('SplitBillCountCubit: refresh failed: $e');
      _safeEmit(0);
    }
  }

  /// Prefer the in-memory AuthenticationCubit profile; fall back to secure
  /// storage since the locator-provided AuthenticationCubit is a factory and a
  /// fresh instance may not have a hydrated profile yet.
  Future<String?> _resolveCurrentUserId() async {
    try {
      final fromCubit = serviceLocator<AuthenticationCubit>().userId;
      if (fromCubit != null && fromCubit.isNotEmpty) return fromCubit;
    } catch (_) {
      // ignore — fall through to storage
    }
    try {
      return await serviceLocator<SecureStorageService>().getUserId();
    } catch (_) {
      return null;
    }
  }

  void _safeEmit(int count) {
    if (!isClosed) {
      emit(count);
    }
  }
}
