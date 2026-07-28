import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
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
      (failure) {
        // statusCode is loosely typed across failure classes (int gRPC code /
        // string / null) — normalize to an int? for the biometric classifier.
        final dynamic code = failure.statusCode;
        emit(ProfileError(
          failure.message,
          statusCode: code is int ? code : int.tryParse('$code'),
        ));
      },
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
      // Capture the PREVIOUS avatar URL before we overwrite the current user —
      // the storage key is derived from the file name, so re-uploading often
      // yields the SAME URL. Without busting the image cache, CachedNetworkImage
      // keeps serving the old bytes and the new picture only appears after a
      // re-login (fresh process). Evicting both the old and new URLs forces a
      // re-download so every avatar surface refreshes immediately.
      String? previousPic;
      if (serviceLocator.isRegistered<AuthenticationCubit>()) {
        final authCubit = serviceLocator<AuthenticationCubit>();
        previousPic = authCubit.currentProfile?.user.profilePicture;
        authCubit.updateCurrentUser(user);
      }

      await _evictAvatarCache(previousPic);
      await _evictAvatarCache(user.profilePicture);
      // Drop any in-memory decoded copies so on-screen avatars repaint fresh
      // (a stable URL would otherwise reuse the live image handle).
      PaintingBinding.instance.imageCache
        ..clear()
        ..clearLiveImages();

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

  /// Evicts [url] from CachedNetworkImage's disk + memory caches so the next
  /// render re-downloads it. No-op for null/empty or non-http (base64) values.
  Future<void> _evictAvatarCache(String? url) async {
    if (url == null || url.isEmpty) return;
    if (!(url.startsWith('http://') || url.startsWith('https://'))) return;
    try {
      await CachedNetworkImage.evictFromCache(url);
    } catch (_) {/* best-effort cache bust */}
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
    final loaded = state;
    if (loaded is! ProfileLoaded) return;
    // Capture the current user + preferences BEFORE emitting Loading — the
    // success branch needs the user, and untouched fields must be MERGED (not
    // reset to defaults) so toggling one channel doesn't clobber the others.
    final user = loaded.user;
    final current = loaded.preferences;

    if (isClosed) return;
    emit(const ProfileLoading());

    // If currency is being updated, sync it with CurrencySyncService
    if (currency != null) {
      await _currencySyncService.updateCurrency(currency);
    }

    final result = await _repository.updatePreferences(
      pushNotifications: pushNotifications ?? current.pushNotifications,
      emailNotifications: emailNotifications ?? current.emailNotifications,
      smsNotifications: smsNotifications ?? current.smsNotifications,
      darkMode: darkMode ?? current.darkMode,
      language: language ?? current.language,
      currency: currency ?? current.currency,
      preferredCountries: preferredCountries ?? current.preferredCountries,
      activeCountry: activeCountry ?? current.activeCountry,
    );

    if (isClosed) return;
    result.fold(
      (failure) {
        // Surface the error, then restore the prior loaded state so the toggle
        // visibly reverts instead of hanging on the loading spinner.
        emit(ProfileError(failure.message));
        emit(ProfileLoaded(user: user, preferences: current));
      },
      (preferences) => emit(ProfileLoaded(user: user, preferences: preferences)),
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
