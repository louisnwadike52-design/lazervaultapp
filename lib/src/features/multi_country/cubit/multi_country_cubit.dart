import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/repositories/i_multi_country_repository.dart';
import 'multi_country_state.dart';

class MultiCountryCubit extends Cubit<MultiCountryState> {
  final IMultiCountryRepository _repository;

  MultiCountryCubit(this._repository) : super(MultiCountryInitial());

  /// Fetch all accounts grouped by locale
  Future<void> fetchAccountsByLocale() async {
    emit(MultiCountryLoading());

    final result = await _repository.getAccountsByLocale();
    if (isClosed) return;

    result.fold(
      (failure) => emit(MultiCountryError(failure.message)),
      (data) => emit(MultiCountryLoaded(
        locales: data.locales,
        activeLocale: data.activeLocale,
        signupLocale: data.signupLocale,
      )),
    );
  }

  /// Create an account for a specific locale (when user taps "Create Account")
  Future<void> createLocaleAccount(String locale) async {
    emit(LocaleAccountCreating(locale));

    final result = await _repository.createLocaleAccount(locale: locale);
    if (isClosed) return;

    result.fold(
      (failure) => emit(LocaleAccountCreateError(failure.message)),
      (account) {
        emit(LocaleAccountCreated(
          account: account,
          message: 'Account created for ${account.currency}',
        ));
        // Refresh the full list to reflect new account
        fetchAccountsByLocale();
      },
    );
  }

  /// Set user's active locale (when switching country from dashboard)
  Future<void> setActiveLocale(String locale) async {
    final result = await _repository.setUserLocale(locale);
    if (isClosed) return;

    result.fold(
      (failure) => emit(MultiCountryError(failure.message)),
      (_) => fetchAccountsByLocale(),
    );
  }
}
