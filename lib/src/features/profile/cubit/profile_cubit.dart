import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/domain/repositories/i_profile_repository.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final IProfileRepository _repository;

  ProfileCubit({required IProfileRepository repository})
      : _repository = repository,
        super(const ProfileInitial());

  Future<void> getUserProfile() async {
    if (isClosed) return;
    emit(const ProfileLoading());
    final result = await _repository.getUserProfile();

    if (isClosed) return;
    result.fold(
      (failure) => emit(ProfileError(failure.message)),
      (data) {
        final user = data['user'];
        final preferences = data['preferences'];
        emit(ProfileLoaded(user: user, preferences: preferences));
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

  void resetState() {
    if (isClosed) return;
    emit(const ProfileInitial());
  }
}
