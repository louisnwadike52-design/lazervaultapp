# Passcode Authentication Implementation Guide

## Overview
This document outlines the implementation of passcode-based authentication in LazerVault, including the remaining steps needed to complete the feature.

## Completed Work

### Backend (Already Implemented)
- ✅ `LoginWithPasscodeRequest` and `LoginWithPasscode` RPC in auth.proto
- ✅ Backend handler in `auth_controller.go:77-122`
- ✅ Auth service implementation for passcode login
- ✅ User model supports `login_passcode` field

### Frontend (Completed in this session)
1. ✅ Created `lib/src/features/authentication/presentation/views/passcode_setup_screen.dart`
   - 6-digit passcode entry with confirmation
   - Saves passcode to secure storage
   - Option to skip

2. ✅ Created `lib/src/features/authentication/presentation/views/passcode_login_screen.dart`
   - 6-digit passcode entry for returning users
   - Shows stored email
   - Option to switch to email/password login

3. ✅ Added `loginWithPasscode` method to repository interface and implementation
4. ✅ Created `LoginWithPasscodeUseCase`

## Remaining Tasks

### 1. Update Authentication Cubit

Add to `lib/src/features/authentication/cubit/authentication_cubit.dart`:

```dart
// Add import
import '../domain/usecases/login_with_passcode_usecase.dart';

// Add to class fields
final LoginWithPasscodeUseCase _loginWithPasscodeUseCase;

// Add to constructor parameters
required LoginWithPasscodeUseCase loginWithPasscode,

// Initialize in constructor
_loginWithPasscodeUseCase = loginWithPasscode,

// Add method
Future<void> loginWithPasscode({
  required String email,
  required String passcode,
}) async {
  emit(SigningInUser());

  final result = await _loginWithPasscodeUseCase(
    email: email,
    passcode: passcode,
  );

  result.fold(
    (failure) {
      emit(AuthenticationError(failure.message));
    },
    (profile) async {
      await _saveSession(profile);
      // Store login method preference
      await _storage.write(key: 'login_method', value: 'passcode');
      await _storage.write(key: 'stored_email', value: email);
      emit(AuthenticationSuccess(profile: profile));
    },
  );
}
```

### 2. Update Injection Container

Add to `lib/core/services/injection_container.dart`:

```dart
// Register LoginWithPasscodeUseCase
serviceLocator.registerLazySingleton<LoginWithPasscodeUseCase>(
  () => LoginWithPasscodeUseCase(
    serviceLocator<IAuthRepository>(),
  ),
);

// Update AuthenticationCubit registration to include new usecase
serviceLocator.registerFactory<AuthenticationCubit>(
  () => AuthenticationCubit(
    login: serviceLocator<LoginUseCase>(),
    signUp: serviceLocator<SignUpUseCase>(),
    signInWithGoogle: serviceLocator<SignInWithGoogleUseCase>(),
    signInWithApple: serviceLocator<SignInWithAppleUseCase>(),
    forgotPassword: serviceLocator<ForgotPasswordUseCase>(),
    verifyEmail: serviceLocator<VerifyEmailUseCase>(),
    resendVerification: serviceLocator<ResendVerificationUseCase>(),
    checkEmailAvailability: serviceLocator<CheckEmailAvailabilityUseCase>(),
    loginWithPasscode: serviceLocator<LoginWithPasscodeUseCase>(), // ADD THIS
  ),
);
```

### 3. Update Email Verification Screen

Modify `lib/src/features/authentication/presentation/views/email_verification_screen.dart`:

After successful verification or on skip, navigate to passcode setup:

```dart
// Replace navigation to dashboard with:
Get.offAllNamed(AppRoutes.passcodeSetup);
```

### 4. Update App Routes

Add to `lib/core/types/app_routes.dart`:

```dart
static const String passcodeSetup = '/passcode-setup';
static const String passcodeLogin = '/passcode-login';
```

### 5. Update Main App Routing

Modify `lib/main.dart` or your routing configuration:

```dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// In your main app initialization, check login preference
Future<String> _determineInitialRoute() async {
  const storage = FlutterSecureStorage();

  // Check if user has logged in before
  final loginMethod = await storage.read(key: 'login_method');
  final storedEmail = await storage.read(key: 'stored_email');
  final accessToken = await storage.read(key: 'access_token');

  // If has valid session, go to dashboard
  if (accessToken != null && accessToken.isNotEmpty) {
    // TODO: Validate token with backend
    return AppRoutes.dashboard;
  }

  // If has passcode login set up, show passcode login
  if (loginMethod == 'passcode' && storedEmail != null) {
    return AppRoutes.passcodeLogin;
  }

  // Otherwise show email/password login
  return AppRoutes.emailSignIn;
}

// Update GetMaterialApp or MaterialApp
GetMaterialApp(
  initialRoute: await _determineInitialRoute(),
  getPages: [
    // ... existing routes
    GetPage(name: AppRoutes.passcodeSetup, page: () => const PasscodeSetupScreen()),
    GetPage(name: AppRoutes.passcodeLogin, page: () => const PasscodeLoginScreen()),
  ],
)
```

### 6. Generate Proto Files

Run proto generation to ensure Flutter has the latest proto definitions:

```bash
cd /Users/louislawrence/Music/apps/stack/lazervaultapp
./generate_proto.sh
```

Or if using makefile:
```bash
make proto
```

### 7. Update Email Sign-In Screen

Add option to switch to passcode login if user has it set up:

```dart
// In email sign-in screen, add a button:
TextButton(
  onPressed: () async {
    const storage = FlutterSecureStorage();
    final storedEmail = await storage.read(key: 'stored_email');
    if (storedEmail != null) {
      Get.offAllNamed(AppRoutes.passcodeLogin);
    }
  },
  child: const Text('Use Passcode Instead'),
)
```

## Testing Checklist

- [ ] New user can set up passcode after email verification
- [ ] New user can skip passcode setup
- [ ] Returning user sees passcode login screen on app start
- [ ] Passcode login successfully authenticates user
- [ ] Failed passcode login shows error and clears fields
- [ ] User can switch from passcode to email login
- [ ] User can switch from email to passcode login (if set up)
- [ ] Passcode is securely stored
- [ ] Login method preference persists across app restarts

## Security Considerations

### Current Implementation (Development)
- Passcode is stored in plain text in secure storage
- For DEVELOPMENT ONLY

### Production Requirements
- **Hash passcodes** using bcrypt or argon2 before storing
- **Consider biometric authentication** as additional security layer
- **Implement passcode retry limits** (e.g., 5 attempts then require email login)
- **Add passcode reset flow** via email verification
- **Store passcode on backend** (hashed) for multi-device support

## Future Enhancements

1. **Biometric Authentication**
   - Use `local_auth` package
   - Allow Face ID/Touch ID/Fingerprint as alternative to passcode

2. **Passcode Settings**
   - Allow user to change passcode
   - Allow user to disable passcode
   - Require password confirmation before changes

3. **Multi-Device Support**
   - Store hashed passcode on backend
   - Sync passcode across devices

4. **Enhanced Security**
   - Failed attempt tracking
   - Account lockout after multiple failures
   - Passcode expiration (require change every N days)

## Files Modified/Created

### Created
- `lib/src/features/authentication/presentation/views/passcode_setup_screen.dart`
- `lib/src/features/authentication/presentation/views/passcode_login_screen.dart`
- `lib/src/features/authentication/domain/usecases/login_with_passcode_usecase.dart`

### Modified
- `lib/src/features/authentication/domain/repositories/i_auth_repository.dart`
- `lib/src/features/authentication/data/repositories/auth_repository.dart`

### Need to Modify
- `lib/src/features/authentication/cubit/authentication_cubit.dart`
- `lib/core/services/injection_container.dart`
- `lib/src/features/authentication/presentation/views/email_verification_screen.dart`
- `lib/core/types/app_routes.dart`
- `lib/main.dart` or routing configuration

## Backend Files (Already Implemented)
- `/Users/louislawrence/Music/apps/stack/lazervault-golang/proto/auth.proto`
- `/Users/louislawrence/Music/apps/stack/lazervault-golang/grpcApi/auth_controller.go`
- `/Users/louislawrence/Music/apps/stack/lazervault-golang/services/auth_service.go`
