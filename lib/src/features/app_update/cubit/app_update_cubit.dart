import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lazervault/core/services/app_update_service.dart';

/// State for the app-update surface. Sealed so the UI can switch exhaustively.
sealed class AppUpdateState {
  const AppUpdateState();
}

/// Before the first check completes (nothing shown).
class AppUpdateInitial extends AppUpdateState {
  const AppUpdateInitial();
}

/// Running build is current / unsupported platform / not configured.
class AppUpdateNone extends AppUpdateState {
  const AppUpdateNone();
}

/// A newer build is available but the current one is still supported.
class AppUpdateOptional extends AppUpdateState {
  final AppUpdateInfo info;
  const AppUpdateOptional(this.info);
}

/// Running build is below the minimum supported build — block the app.
class AppUpdateForced extends AppUpdateState {
  final AppUpdateInfo info;
  const AppUpdateForced(this.info);
}

/// Drives the background version check. Reads cached config + local PackageInfo
/// only (no hot-path network call), so [checkNow] is cheap and safe to call on
/// dashboard mount and on app resume.
class AppUpdateCubit extends Cubit<AppUpdateState> {
  final AppUpdateService _service;

  /// Set when the user dismisses the optional banner — keeps it hidden for the
  /// rest of the session even if [checkNow] runs again (e.g. on resume). The
  /// blocking/forced gate ignores this and always re-asserts.
  bool _optionalDismissed = false;

  AppUpdateCubit(this._service) : super(const AppUpdateInitial());

  AppUpdateService get service => _service;

  /// Run a check and emit the resulting state. Never throws.
  Future<void> checkNow() async {
    try {
      final info = await _service.check();
      switch (info.type) {
        case AppUpdateType.forced:
          emit(AppUpdateForced(info));
        case AppUpdateType.optional:
          if (_optionalDismissed) {
            emit(const AppUpdateNone());
          } else {
            emit(AppUpdateOptional(info));
          }
        case AppUpdateType.none:
          emit(const AppUpdateNone());
      }
    } catch (_) {
      emit(const AppUpdateNone());
    }
  }

  /// Hide the optional banner for the rest of this session.
  void dismissOptional() {
    _optionalDismissed = true;
    emit(const AppUpdateNone());
  }
}
