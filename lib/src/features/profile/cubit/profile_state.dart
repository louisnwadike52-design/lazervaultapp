import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final User user;
  final UserPreferences preferences;

  const ProfileLoaded({
    required this.user,
    required this.preferences,
  });

  @override
  List<Object?> get props => [user, preferences];

  ProfileLoaded copyWith({
    User? user,
    UserPreferences? preferences,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      preferences: preferences ?? this.preferences,
    );
  }
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateSuccess extends ProfileState {
  final String message;

  const ProfileUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PasswordUpdateSuccess extends ProfileState {
  final String message;

  const PasswordUpdateSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PreferencesUpdateSuccess extends ProfileState {
  final UserPreferences preferences;

  const PreferencesUpdateSuccess(this.preferences);

  @override
  List<Object?> get props => [preferences];
}
