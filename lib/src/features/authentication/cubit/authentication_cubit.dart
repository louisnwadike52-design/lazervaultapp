import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/sign_up_usecase.dart';
import '../domain/usecases/sign_in_with_google_usecase.dart';
import '../domain/usecases/sign_in_with_apple_usecase.dart';
import 'authentication_state.dart';


class AuthenticationCubit extends Cubit<AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final SignInWithAppleUseCase _signInWithAppleUseCase;

  AuthenticationCubit({
    required LoginUseCase login,
    required SignUpUseCase signUp,
    required SignInWithGoogleUseCase signInWithGoogle,
    required SignInWithAppleUseCase signInWithApple,
  })  : _loginUseCase = login,
        _signUpUseCase = signUp,
        _signInWithGoogleUseCase = signInWithGoogle,
        _signInWithAppleUseCase = signInWithApple,
        super(AuthenticationInitial());

  // --- Main Auth Methods ---
  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(AuthenticationLoading());
    final result = await _loginUseCase(email: email, password: password); // Call use case
    result.fold(
      (failure) => emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (profile) => emit(AuthenticationSuccess(profile)), // Emit profile on success
    );
  }

  // Method to handle sign up
  Future<void> signUpUser({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    String? phoneNumber,
  }) async {
    emit(AuthenticationLoading());
    final result = await _signUpUseCase( // Call use case
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      phoneNumber: phoneNumber,
    );
      result.fold(
      (failure) => emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (profile) => emit(AuthenticationSuccess(profile)), // Emit profile on success
    );
  }

  // Method to handle Google Sign In
  Future<void> signInWithGoogle() async {
    emit(AuthenticationLoading());
    final result = await _signInWithGoogleUseCase(); // Call use case
    result.fold(
      (failure) => emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (profile) => emit(AuthenticationSuccess(profile)), // Emit profile on success
    );
  }

  // Method to handle Apple Sign In
  Future<void> signInWithApple() async {
    emit(AuthenticationLoading());
    final result = await _signInWithAppleUseCase(); // Call use case
    result.fold(
      (failure) => emit(AuthenticationFailure(
        failure.message,
        statusCode: failure.statusCode,
      )),
      (profile) => emit(AuthenticationSuccess(profile)), // Emit profile on success
    );
  }

  // Method to handle logout
  void logout() {
    // TODO: Add logic here to clear any locally stored session/token data
    // e.g., using flutter_secure_storage or shared_preferences
    print("AuthenticationCubit: Logout called");
    emit(AuthenticationInitial()); // Reset state to initial
  }

  // --- Email Sign In Specific Methods (if still used) ---
  // void startEmailSignIn() { /* ... */ }
  // void emailSignInEmailChanged(String value) { /* ... */ }
  // void emailSignInPasswordChanged(String value) { /* ... */ }
  // Future<void> emailSignInSubmitted() async { /* ... */ }

  // --- Sign Up Page Flow Methods ---
  void startSignUp() {
    emit(const SignUpInProgress());
  }

  void cancelSignUp() {
    emit(const AuthenticationInitial());
  }

  void signUpEmailChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(email: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(password: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpConfirmPasswordChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(confirmPassword: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpFirstNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(firstName: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpLastNameChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(lastName: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpDateOfBirthChanged(DateTime? value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(selectedDate: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpPhoneNumberChanged(String value) {
    if (state is SignUpInProgress) {
      final currentState = state as SignUpInProgress;
      emit(currentState.copyWith(phoneNumber: value, clearErrorMessage: true, isLoading: false));
    }
  }

  void signUpNextPage() {
     if (state is SignUpInProgress) {
        final currentState = state as SignUpInProgress;
        if (currentState.currentPage == 0) {
            // Validation for page 0 remains the same (email, passwords)
            if (currentState.email.isEmpty || currentState.password.isEmpty || currentState.confirmPassword.isEmpty) {
                emit(currentState.copyWith(errorMessage: 'Please fill all fields on this page.'));
                return;
            }
            if (currentState.password != currentState.confirmPassword) {
                emit(currentState.copyWith(errorMessage: 'Passwords do not match.'));
                return;
            }
        }
        // Navigation logic remains the same
        if (currentState.currentPage < 1) {
            emit(currentState.copyWith(currentPage: currentState.currentPage + 1, clearErrorMessage: true));
        }
     }
  }

  void signUpPreviousPage() {
     if (state is SignUpInProgress) {
        final currentState = state as SignUpInProgress;
         if (currentState.currentPage > 0) {
            emit(currentState.copyWith(currentPage: currentState.currentPage - 1, clearErrorMessage: true));
         }
     }
  }

  Future<void> signUpSubmitted() async {
     if (state is SignUpInProgress) {
        final currentState = state as SignUpInProgress;

        // Perform validation checks first, using firstName and lastName
        if (currentState.email.isEmpty ||
            currentState.password.isEmpty ||
            currentState.confirmPassword.isEmpty ||
            currentState.firstName.isEmpty || // Check firstName
            currentState.lastName.isEmpty || // Check lastName
            currentState.selectedDate == null ||
            currentState.phoneNumber.isEmpty) {
          emit(currentState.copyWith(errorMessage: 'Please fill all fields.', isLoading: false));
          return;
        }
        if (currentState.password != currentState.confirmPassword) {
            emit(currentState.copyWith(errorMessage: 'Passwords do not match.', isLoading: false));
            return;
        }

        if (currentState.isLoading) return; 
        emit(currentState.copyWith(isLoading: true, clearErrorMessage: true)); 

        // Call the use case with separate names
        final result = await _signUpUseCase( 
            firstName: currentState.firstName,
            lastName: currentState.lastName,
            email: currentState.email,
            password: currentState.password,
            phoneNumber: currentState.phoneNumber,
           // dateOfBirth: currentState.selectedDate!, // Pass DOB if use case requires it
           // role: 'user', // Pass role if use case requires it
          );

        result.fold(
          (failure) {
            print('Error signing up: ${failure.message}');
            // Keep user input on failure
            emit(currentState.copyWith(
              isLoading: false,
              errorMessage: failure.message, 
            ));
          },
          // Success case now handled by the main Auth Cubit methods
          // (profile) => emit(AuthenticationSuccess(profile)), // No longer needed here if signUpUser handles it
           (profile) => emit(AuthenticationSuccess(profile)), // Emit success directly if signUpUser doesn't exist
        );

     } else {
        print('Cannot submit sign up from current state: $state');
         emit(AuthenticationFailure("Cannot submit sign up from current state.", statusCode: 400)); // Use AuthenticationFailure
     }
  }
}
