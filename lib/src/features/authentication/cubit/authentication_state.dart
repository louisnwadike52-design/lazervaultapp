import 'package:equatable/equatable.dart';
import '../domain/entities/profile_entity.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

// Checking for existing session
class AuthenticationCheckingSession extends AuthenticationState {
  const AuthenticationCheckingSession();
}

// Generic Loading state (can be used for various auth operations)
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

// State indicating successful authentication (login, signup, social)
class AuthenticationSuccess extends AuthenticationState {
  final ProfileEntity profile;

  const AuthenticationSuccess(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Email verified state
class EmailVerified extends AuthenticationState {
  final ProfileEntity profile;

  const EmailVerified(this.profile);

  @override
  List<Object?> get props => [profile];
}

// Password reset email sent
class PasswordResetEmailSent extends AuthenticationState {
  const PasswordResetEmailSent();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class GettingUsers extends AuthenticationState {
  const GettingUsers();
}

class UserCreated extends AuthenticationState {
  const UserCreated();
}

class UsersLoaded extends AuthenticationState {
  const UsersLoaded(this.users);

  final List<ProfileEntity> users;

  @override
  List<Object?> get props => [users];
}

class AuthenticationError extends AuthenticationState {
  const AuthenticationError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class SignUpInProgress extends AuthenticationState {
  const SignUpInProgress({
    this.currentPage = 0,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.selectedDate,
    this.phoneNumber = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final int currentPage;
  final String email;
  final String password;
  final String confirmPassword;
  final String firstName;
  final String lastName;
  final DateTime? selectedDate;
  final String phoneNumber;
  final bool isLoading;
  final String? errorMessage;

  SignUpInProgress copyWith({
    int? currentPage,
    String? email,
    String? password,
    String? confirmPassword,
    String? firstName,
    String? lastName,
    DateTime? selectedDate,
    String? phoneNumber,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return SignUpInProgress(
      currentPage: currentPage ?? this.currentPage,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      selectedDate: selectedDate ?? this.selectedDate,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        currentPage,
        email,
        password,
        confirmPassword,
        firstName,
        lastName,
        selectedDate,
        phoneNumber,
        isLoading,
        errorMessage,
      ];
}

// General Authentication States (can be reused)
class Authenticating extends AuthenticationState {
  const Authenticating();
}

class AuthenticationFailure extends AuthenticationState {
  final String message;
  final int? statusCode;

  const AuthenticationFailure(this.message, {this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
