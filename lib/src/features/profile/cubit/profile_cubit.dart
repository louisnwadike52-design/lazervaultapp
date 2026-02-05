import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository _repository;
  final CurrencySyncService _currencySyncService;

  ProfileCubit({
    required IProfileRepository repository,
    required CurrencySyncService currencySyncService,
  })  : _repository = repository,
        _currencySyncService = currencySyncService,
        super(const ProfileInitial());

  Future<void> getUserProfile() async {
    if (isClosed) return;
    emit(const ProfileLoading());
    final result = await _repository.getUserProfile();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (data) async {
        final user = data['user'];
        final preferences = data['preferences'];

        // Emit ProfileLoaded so the UI is unblocked
        emit(ProfileLoaded(user: user, preferences: preferences));

        // Best-effort sync: persist activeCountry from LocaleManager
        // without going through state-emitting updatePreferences(),
        // so a backend failure doesn't clobber the ProfileLoaded state.
        if (preferences.activeCountry.isEmpty) {
          try {
            final localeManager = serviceLocator<LocaleManager>();
            final countryFromLocale = localeManager.currentCountry;
            if (countryFromLocale.isNotEmpty) {
              final result = await _repository.updatePreferences(
                activeCountry: countryFromLocale,
              );
              result.fold(
                (_) {}, // silently ignore failure
                (updatedPrefs) {
                  if (!isClosed && state is ProfileLoaded) {
                    emit((state as ProfileLoaded).copyWith(preferences: updatedPrefs));
                  }
                },
              );
            }
          } catch (e) {
            // Silently fail - locale sync is best effort
          }
        }
      },
    );
  }

  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? username,
    String? phoneNumber,
    String? language,
    String? currency,
    String? country,
    String? profilePicture,
  }) async {
    if (state is! ProfileLoaded) return;

    if (isClosed) return;
    emit(const ProfileLoading());
    final result = await _repository.updateUserProfile(
      firstName: firstName,
      lastName: lastName,
      username: username,
      phoneNumber: phoneNumber,
      language: language,
      currency: currency,
      country: country,
      profilePicture: profilePicture,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (user) {
        final currentState = state;
        if (currentState is ProfileLoaded) {
          emit(ProfileLoaded(
            user: user,
            preferences: currentState.preferences,
          ));
          emit(const ProfileUpdateSuccess('Profile updated successfully'));
        }
      },
    );
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    if (isClosed) return;
    emit(const ProfileLoading());
    final result = await _repository.updatePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(const PasswordUpdateSuccess('Password updated successfully')),
    );
  }

  Future<void> updatePreferences({
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
    bool? darkMode,
    String? language,
    String? currency,
    List<String>? preferredCountries,
    String? activeCountry,
  }) async {
    if (state is! ProfileLoaded) return;

    if (isClosed) return;
    emit(const ProfileLoading());

    // If currency is being updated, sync it with CurrencySyncService
    if (currency != null) {
      await _currencySyncService.updateCurrency(currency);
    }

    final result = await _repository.updatePreferences(
      pushNotifications: pushNotifications,
      emailNotifications: emailNotifications,
      smsNotifications: smsNotifications,
      darkMode: darkMode,
      language: language,
      currency: currency,
      preferredCountries: preferredCountries,
      activeCountry: activeCountry,
    );

    if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (preferences) {
        final currentState = state;
        if (currentState is ProfileLoaded) {
          emit(ProfileLoaded(
            user: currentState.user,
            preferences: preferences,
          ));
        }
      },
    );
  }

  Future<void> addPreferredCountry(String countryCode) async {
    if (state is! ProfileLoaded) return;
    final currentState = state as ProfileLoaded;

    final updatedCountries = List<String>.from(currentState.preferences.preferredCountries);
    if (!updatedCountries.contains(countryCode)) {
      updatedCountries.add(countryCode);
      await updatePreferences(
        preferredCountries: updatedCountries,
        activeCountry: countryCode, // Set as active when added
      );
    }
  }

  Future<void> removePreferredCountry(String countryCode) async {
    if (state is! ProfileLoaded) return;
    final currentState = state as ProfileLoaded;

    final updatedCountries = List<String>.from(currentState.preferences.preferredCountries);
    updatedCountries.remove(countryCode);

    // If removing active country, set first country as active
    String newActiveCountry = currentState.preferences.activeCountry;
    if (newActiveCountry == countryCode) {
      newActiveCountry = updatedCountries.isNotEmpty ? updatedCountries.first : '';
    }

    await updatePreferences(
      preferredCountries: updatedCountries,
      activeCountry: newActiveCountry,
    );
  }

  Future<void> setActiveCountry(String countryCode) async {
    if (state is! ProfileLoaded) return;
    await updatePreferences(activeCountry: countryCode);
  }

  Future<List<UserSearchResultEntity>> searchUsers(String query, {int limit = 10}) async {
    return await _repository.searchUsersByUsername(query: query, limit: limit);
  }

  void resetState() {
    if (isClosed) return;
    emit(const ProfileInitial());
  }
}
