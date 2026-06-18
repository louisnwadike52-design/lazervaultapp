import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/core/utils/user_search_query.dart';
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

        final localeManager = serviceLocator<LocaleManager>();

        // Sync registration country (set by _saveSession) to backend preference.
        // Never override locale here — _saveSession already set it correctly.
        try {
          final countryFromLocale = localeManager.currentCountry;
          if (countryFromLocale.isNotEmpty &&
              countryFromLocale != preferences.activeCountry) {
            final result = await _repository.updatePreferences(
              activeCountry: countryFromLocale,
            );
            result.fold(
              (_) {},
              (updatedPrefs) {
                if (!isClosed && state is ProfileLoaded) {
                  emit((state as ProfileLoaded).copyWith(preferences: updatedPrefs));
                }
              },
            );
          }
        } catch (e) {
          // Silently fail — locale sync is best effort
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

          // Keep LocaleManager in sync when country changes via profile update
          if (user.country != null && user.country!.isNotEmpty) {
            final localeManager = serviceLocator<LocaleManager>();
            // user.country is a country name (e.g. "United Kingdom"), look up by name
            try {
              final countryLocale = CountryLocales.all.firstWhere(
                (c) => c.countryName == user.country,
              );
              localeManager.setCountry(countryLocale.countryCode);
            } catch (_) {
              // Country not found in CountryLocales, skip sync
            }
          }
        }
      },
    );
  }

  /// Upload a new profile picture from either a [File] (camera/gallery
  /// path) or raw [bytes] (already-loaded XFile). Persists the resulting
  /// public URL on the user record and pushes the updated [User] into
  /// the [AuthenticationCubit] so the dashboard + passcode-screen
  /// avatars refresh immediately.
  Future<void> uploadProfilePicture({
    File? file,
    Uint8List? bytes,
    String? filename,
  }) async {
    if (isClosed) return;
    final previous = state;
    emit(const ProfilePictureUploading());

    final result = await _repository.uploadProfilePicture(
      file: file,
      bytes: bytes,
      filename: filename,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
        // Re-emit the previous loaded state so the UI doesn't get stuck
        // on the transient uploading state.
        if (previous is ProfileLoaded) {
          emit(previous);
        }
      },
      (user) async {
        final currentState = previous;
        if (currentState is ProfileLoaded) {
          emit(ProfileLoaded(
            user: user,
            preferences: currentState.preferences,
          ));
        }
        emit(const ProfileUpdateSuccess('Profile picture updated'));
        await _syncAvatarWithAuth(user);
      },
    );
  }

  /// Remove the user's profile picture. Sends the `__REMOVE__` sentinel
  /// through UpdateProfile so auth-service clears
  /// `users.profile_picture` (an empty string is a no-op for parity
  /// with other partial-update fields).
  Future<void> removeProfilePicture() async {
    if (isClosed) return;
    final previous = state;
    emit(const ProfilePictureUploading());

    final result = await _repository.removeProfilePicture();

    if (isClosed) return;
    result.fold(
      (failure) {
        emit(ProfileError(failure.message));
        if (previous is ProfileLoaded) {
          emit(previous);
        }
      },
      (user) async {
        // The backend may echo back the previous URL when the sentinel
        // wasn't honoured; force-clear locally so the UI matches the
        // user's intent and the next GetMe round-trip reconciles.
        final cleared = user.copyWith(profilePicture: null);
        final currentState = previous;
        if (currentState is ProfileLoaded) {
          emit(ProfileLoaded(
            user: cleared,
            preferences: currentState.preferences,
          ));
        }
        emit(const ProfileUpdateSuccess('Profile picture removed'));
        await _syncAvatarWithAuth(cleared);
      },
    );
  }

  /// Push the updated [user] into [AuthenticationCubit] so every other
  /// screen (dashboard header, drawer, passcode screen via secure
  /// storage) picks up the new avatar without a manual refresh. Also
  /// updates the `user_avatar_url` secure-storage key the passcode
  /// screen reads on cold start.
  Future<void> _syncAvatarWithAuth(User user) async {
    try {
      if (serviceLocator.isRegistered<AuthenticationCubit>()) {
        serviceLocator<AuthenticationCubit>().updateCurrentUser(user);
      }
      final storage = serviceLocator.isRegistered<FlutterSecureStorage>()
          ? serviceLocator<FlutterSecureStorage>()
          : const FlutterSecureStorage();
      final pic = user.profilePicture;
      if (pic != null && pic.isNotEmpty) {
        await storage.write(key: 'user_avatar_url', value: pic);
      } else {
        await storage.delete(key: 'user_avatar_url');
      }
    } catch (e) {
      // Never let a downstream cache update break the success flow.
      print('Failed to sync avatar with AuthenticationCubit: $e');
    }
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

  Future<List<UserSearchResultEntity>> searchUsers(
    String query, {
    int limit = 10,
    int offset = 0,
  }) async {
    final q = normalizeLazerVaultUserSearchQuery(query);
    if (q.length < 2) {
      return [];
    }
    return _repository.searchUsers(query: q, limit: limit, offset: offset);
  }

  void resetState() {
    if (isClosed) return;
    emit(const ProfileInitial());
  }
}
