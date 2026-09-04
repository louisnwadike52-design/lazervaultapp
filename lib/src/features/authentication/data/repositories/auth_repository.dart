import 'dart:async';
import 'dart:io' show Platform;

// gRPC Imports
import 'package:grpc/grpc.dart';
import 'package:dartz/dartz.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/error/failure.dart';
import 'package:lazervault/src/core/errors/failures.dart' show friendlyGrpcError;
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/services/device_service.dart';
import 'package:lazervault/src/features/authentication/data/models/profile_model.dart';
import 'package:lazervault/src/features/authentication/data/models/session_model.dart';
import 'package:lazervault/src/features/authentication/data/models/user_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/profile_entity.dart';
import 'package:lazervault/src/features/authentication/domain/entities/phone_verification_entity.dart';
import 'package:lazervault/src/features/authentication/data/models/phone_verification_model.dart';
import 'package:lazervault/src/features/authentication/domain/entities/two_factor_entity.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';
import 'package:lazervault/src/features/authentication/domain/usecases/sign_up_usecase.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' hide VirtualAccountInfo;
import 'package:lazervault/src/generated/auth.pbenum.dart' as auth_enum;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_req_resp;
import 'package:lazervault/src/generated/user.pbgrpc.dart';

// Import google_sign_in and sign_in_with_apple if implementing those methods
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthRepositoryImpl implements IAuthRepository {
  // ignore: unused_field
  final UserServiceClient _userServiceClient;
  final AuthServiceClient _authServiceClient;
  final GrpcCallOptionsHelper _callOptionsHelper;
  final DeviceService _deviceService;
  // final GoogleSignIn _googleSignIn = GoogleSignIn(); // Uncomment if using Google Sign In

  AuthRepositoryImpl({
    required UserServiceClient userServiceClient,
    required AuthServiceClient authServiceClient,
    required GrpcCallOptionsHelper callOptionsHelper,
    required DeviceService deviceService,
  })  : _userServiceClient = userServiceClient,
        _authServiceClient = authServiceClient,
        _callOptionsHelper = callOptionsHelper,
        _deviceService = deviceService;

  /// Resolve the stable per-install device id + human-readable name used to
  /// bind logins to a device (backend trusted-device tracking). Replaces the
  /// old hardcoded 'flutter-app'. Never throws — falls back to a safe default.
  Future<({String id, String name})> _deviceFields() async {
    try {
      final id = await _deviceService.getDeviceId();
      final name = await _deviceService.getDeviceName();
      return (id: id, name: name);
    } catch (_) {
      return (id: 'flutter-app', name: 'Flutter App');
    }
  }

  String get _platform => Platform.isIOS
      ? 'ios'
      : Platform.isAndroid
          ? 'android'
          : 'other';

  @override
  Future<Either<Failure, void>> registerDevice() async {
    try {
      final dev = await _deviceFields();
      final request = auth_req_resp.RegisterDeviceRequest(
        deviceUuid: dev.id,
        platform: _platform,
        model: dev.name,
      );
      await _authServiceClient.registerDevice(
        request,
        options: await _callOptionsHelper.withAuth(),
      );
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Request failed.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, List<TrustedDevice>>> listDevices() async {
    try {
      final response = await _authServiceClient.listDevices(
        auth_req_resp.ListDevicesRequest(),
        options: await _callOptionsHelper.withAuth(),
      );
      final localId = await _deviceService.getDeviceId();
      final devices = response.devices.map((d) {
        DateTime? toDate(int secs) =>
            secs > 0 ? DateTime.fromMillisecondsSinceEpoch(secs * 1000) : null;
        return TrustedDevice(
          deviceUuid: d.deviceUuid,
          platform: d.platform,
          model: d.model,
          osVersion: d.osVersion,
          appVersion: d.appVersion,
          trustStatus: d.trustStatus,
          lastIp: d.lastIp,
          lastLocation: d.lastLocation,
          firstSeenAt: toDate(d.firstSeenAt.toInt()),
          lastLoginAt: toDate(d.lastLoginAt.toInt()),
          isCurrent: d.current || d.deviceUuid == localId,
        );
      }).toList();
      return Right(devices);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Request failed.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, void>> revokeDevice({required String deviceUuid}) async {
    try {
      await _authServiceClient.revokeDevice(
        auth_req_resp.RevokeDeviceRequest(deviceUuid: deviceUuid),
        options: await _callOptionsHelper.withAuth(),
      );
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Request failed.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, List<LoginActivity>>> getLoginActivity(
      {int limit = 50, int offset = 0}) async {
    try {
      final response = await _authServiceClient.getLoginHistory(
        auth_req_resp.GetLoginHistoryRequest(limit: limit, offset: offset),
        options: await _callOptionsHelper.withAuth(),
      );
      final items = response.entries.map((e) {
        final secs = e.createdAt.toInt();
        return LoginActivity(
          success: e.success,
          ipAddress: e.ipAddress,
          deviceName: e.deviceName,
          userAgent: e.userAgent,
          failReason: e.failReason,
          at: secs > 0 ? DateTime.fromMillisecondsSinceEpoch(secs * 1000) : null,
        );
      }).toList();
      return Right(items);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Request failed.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  Future<Either<Failure, ProfileEntity>> _processAuthResponse(
      Future<auth_req_resp.LoginResponse> Function() action) async {
    try {
      final response = await action();
      if (response.success &&
          response.hasData() &&
          response.data.hasUser() &&
          response.data.hasSession()) {
        // Note: auth.pb.dart User/Session are different from common.pb.dart types
        // Construct models directly from response fields
        final user = response.data.user;
        final session = response.data.session;

        final userModel = UserModel.fromAuthProto(user)
            .copyWith(
              hasPasscode: response.data.hasPasscode,
              hasTransactionPin: response.data.hasTransactionPin,
              hasPassword: response.data.hasPassword,
            )
            .withRolesFromAccessToken(session.accessToken);

        final now = DateTime.now();
        final expiresAt = session.hasExpiresIn()
            ? now.add(Duration(seconds: session.expiresIn.toInt()))
            : now.add(const Duration(hours: 1)); // Default 1 hour
        final sessionModel = SessionModel(
          id: session.hasUserId() ? session.userId : user.id,
          userId: user.id,
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          accessTokenExpiresAt: expiresAt,
          refreshTokenExpiresAt: expiresAt,
        );

        final profileModel = ProfileModel(user: userModel, session: sessionModel);
        return Right(profileModel); // Explicitly use Right()
      } else if (response.twoFactorRequired) {
        // 2FA enabled: no session yet — route to the 2FA verification flow.
        return Left(TwoFactorRequiredFailure(
          twoFactorToken: response.twoFactorToken,
          method: response.twoFactorMethod.isNotEmpty ? response.twoFactorMethod : 'totp',
        ));
      } else if (response.stepUpRequired) {
        // Risk-based step-up: no session yet — route to the OTP flow.
        return Left(StepUpRequiredFailure(
          stepUpToken: response.stepUpToken,
          stepUpMethod: response.stepUpMethod,
          destination: response.stepUpDestination,
          expiresInSeconds: response.stepUpExpiresIn.toInt(),
        ));
      } else if (response.errorCode.isNotEmpty) {
        // A classified step-up failure. The server's own copy is already
        // user-ready, so it is passed through; the CODE is what the UI branches
        // on to decide whether the user can retry or must sign in again.
        return Left(StepUpVerifyFailure(
          message: response.msg.isNotEmpty
              ? response.msg
              : 'That code could not be verified.',
          code: response.errorCode,
        ));
      } else {
        return Left(ServerFailure(
            message: response.msg.isNotEmpty
                ? response.msg
                : 'Authentication failed.', statusCode: 401));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during authentication: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Authentication failed due to server error.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during authentication: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  /// Asks for a fresh step-up code. Returns the NEW lifetime in seconds so the
  /// screen can restart its countdown from what the server will honour.
  ///
  /// Not routed through _processAuthResponse: a resend deliberately does not
  /// produce a session, so that helper's success path (which requires a user
  /// and a session) would treat every resend as a failure.
  @override
  Future<Either<Failure, int>> resendLoginOtp({
    required String stepUpToken,
  }) async {
    try {
      final response = await _authServiceClient.resendLoginOtp(
        auth_req_resp.ResendLoginOtpRequest(stepUpToken: stepUpToken),
      );
      if (response.success) {
        return Right(response.stepUpExpiresIn.toInt());
      }
      return Left(StepUpVerifyFailure(
        message: response.msg.isNotEmpty
            ? response.msg
            : 'Could not send a new code.',
        code: response.errorCode,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not send a new code.'),
        statusCode: e.code,
      ));
    } catch (_) {
      return Left(ServerFailure(
          message: 'Could not send a new code.', statusCode: 500));
    }
  }

  Future<Either<Failure, ProfileEntity>> verifyLoginOtp({
    required String stepUpToken,
    required String code,
  }) async {
    return _processAuthResponse(() async {
      final dev = await _deviceFields();
      return await _authServiceClient.verifyLoginOtp(
        auth_req_resp.VerifyLoginOtpRequest(
          stepUpToken: stepUpToken,
          code: code,
          deviceId: dev.id,
          deviceName: dev.name,
        ),
      );
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> verifyTwoFactor({
    required String twoFactorToken,
    required String code,
  }) async {
    try {
      // VerifyTwoFactor is authed; during login there is no stored session, so
      // the temp 2FA token is the Bearer (it's a valid access-token-shaped JWT).
      final response = await _authServiceClient.verifyTwoFactor(
        auth_req_resp.VerifyTwoFactorRequest(
          twoFactorToken: twoFactorToken,
          code: code,
        ),
        // Bound the RPC — without a deadline a stalled connection would leave the
        // verification screen's loader spinning forever (the channel keepalive
        // keeps a live-but-idle socket open). On expiry this surfaces as a
        // DEADLINE_EXCEEDED GrpcError → friendlyGrpcError below → clean retry.
        options: CallOptions(
          metadata: {'authorization': 'Bearer $twoFactorToken'},
          timeout: const Duration(seconds: 30),
        ),
      );

      // Copy passcode / transaction-PIN presence from the response (the User
      // proto doesn't carry them) — WITHOUT this both default to false and the
      // post-2FA route resolver wrongly sends the user to passcode setup.
      final userModel = UserModel.fromAuthProto(response.user)
          .copyWith(
            hasPasscode: response.hasPasscode,
            hasTransactionPin: response.hasTransactionPin,
          )
          .withRolesFromAccessToken(response.accessToken);
      final now = DateTime.now();
      final expiresAt = response.expiresIn > 0
          ? now.add(Duration(seconds: response.expiresIn.toInt()))
          : now.add(const Duration(hours: 1));
      final sessionModel = SessionModel(
        id: response.user.id,
        userId: response.user.id,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        accessTokenExpiresAt: expiresAt,
        refreshTokenExpiresAt: expiresAt,
      );
      return Right(ProfileModel(user: userModel, session: sessionModel));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Invalid verification code.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, void>> sendTwoFactorLoginCode({
    String? twoFactorToken,
  }) async {
    try {
      // Login flow: authorise with the temp 2FA token as the Bearer.
      // Setup flow (twoFactorToken == null): the user is already authenticated,
      // so use the normal access-token metadata via withAuth().
      final options = twoFactorToken != null
          ? CallOptions(metadata: {'authorization': 'Bearer $twoFactorToken'})
          : await _callOptionsHelper.withAuth();
      await _authServiceClient.sendTwoFactorCode(
        auth_req_resp.SendTwoFactorCodeRequest(),
        options: options,
      );
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Could not send code.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> login({
    String email = '',
    String phone = '',
    required String password,
  }) async {
    return _processAuthResponse(() async {
      final dev = await _deviceFields();
      final request = auth_req_resp.LoginRequest(
        email: email,
        phone: phone,
        password: password,
        deviceId: dev.id,
        deviceName: dev.name,
      );
      return await _authServiceClient.login(
        request,
        options: await _callOptionsHelper.withAppCheck(),
      );
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> loginWithPasscode({
    required String email,
    required String passcode,
  }) async {
    return _processAuthResponse(() async {
      final request = auth_req_resp.LoginWithPasscodeRequest(
        email: email,
        passcode: passcode,
      );
      return await _authServiceClient.loginWithPasscode(
        request,
        options: await _callOptionsHelper.withAppCheck(),
      );
    });
  }

  // ── Phone + Passcode authentication mode ─────────────────────────────────

  @override
  Future<Either<Failure, String>> getAuthenticationMode() async {
    try {
      final response = await _authServiceClient
          .getAuthenticationConfig(auth_req_resp.GetAuthenticationConfigRequest());
      final mode = response.authenticationMode.isNotEmpty
          ? response.authenticationMode
          : 'phone_passcode';
      // Persist the verification-required toggles that ride the same config call,
      // so FeatureFlags.isEmail/PhoneVerificationRequired are fresh for the
      // onboarding/login/settings UI.
      await FeatureFlags.setVerificationRequirements(
        email: response.emailVerificationRequired,
        phone: response.phoneVerificationRequired,
      );
      return Right(mode);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not load authentication config.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, PhoneSignupOtpResult>> requestSignupPhoneOtp({
    required String phone,
    required String countryCode,
  }) async {
    try {
      final response = await _authServiceClient.requestSignupPhoneOTP(
        auth_req_resp.RequestSignupPhoneOTPRequest(
          phone: phone,
          countryCode: countryCode,
        ),
        options: await _callOptionsHelper.withAppCheck(),
      );
      if (!response.success) {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Could not send code.',
          statusCode: 400,
        ));
      }
      return Right(PhoneSignupOtpResult(
        expiresInSeconds: response.expiresIn.toInt(),
        resendAfterSeconds: response.resendAfterSeconds,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not send verification code.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> verifySignupPhoneOtp({
    required String phone,
    required String code,
  }) async {
    try {
      final response = await _authServiceClient.verifySignupPhoneOTP(
        auth_req_resp.VerifySignupPhoneOTPRequest(phone: phone, code: code),
        options: await _callOptionsHelper.withAppCheck(),
      );
      if (!response.success || response.signupToken.isEmpty) {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Invalid verification code.',
          statusCode: 400,
        ));
      }
      return Right(response.signupToken);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not verify code.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> signUpWithPhone({
    required String phone,
    required String signupToken,
    required String passcode,
    required String firstName,
    required String lastName,
    String? email,
    required String countryCode,
    String? locale,
    String? username,
    String? referralCode,
    String? dateOfBirth,
  }) async {
    return _processAuthResponse(() async {
      final dev = await _deviceFields();
      final request = auth_req_resp.SignupWithPhoneRequest(
        phone: phone,
        signupToken: signupToken,
        passcode: passcode,
        firstName: firstName,
        lastName: lastName,
        email: email ?? '',
        countryCode: countryCode,
        locale: locale ?? '',
        username: username ?? '',
        referralCode: referralCode ?? '',
        dateOfBirth: dateOfBirth ?? '',
        deviceId: dev.id,
        deviceName: dev.name,
      );
      return await _authServiceClient.signupWithPhone(
        request,
        options: await _callOptionsHelper.withAppCheck(),
      );
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> loginWithPhonePasscode({
    required String phone,
    required String passcode,
  }) async {
    return _processAuthResponse(() async {
      final dev = await _deviceFields();
      final request = auth_req_resp.LoginWithPhonePasscodeRequest(
        phone: phone,
        passcode: passcode,
        deviceId: dev.id,
        deviceName: dev.name,
      );
      return await _authServiceClient.loginWithPhonePasscode(
        request,
        options: await _callOptionsHelper.withAppCheck(),
      );
    });
  }

  @override
  Future<Either<Failure, PhoneSignupOtpResult>> requestPasscodeReset({
    required String phone,
    required String countryCode,
  }) async {
    try {
      final response = await _authServiceClient.requestPasscodeReset(
        auth_req_resp.RequestPasscodeResetRequest(
          phone: phone,
          countryCode: countryCode,
        ),
      );
      if (!response.success) {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Could not send code.',
          statusCode: 400,
        ));
      }
      return Right(PhoneSignupOtpResult(
        expiresInSeconds: response.expiresIn.toInt(),
        resendAfterSeconds: response.resendAfterSeconds,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not send verification code.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> verifyPasscodeReset({
    required String phone,
    required String code,
    required String countryCode,
  }) async {
    try {
      final response = await _authServiceClient.verifyPasscodeResetOTP(
        auth_req_resp.VerifyPasscodeResetOTPRequest(
          phone: phone,
          code: code,
          countryCode: countryCode,
        ),
      );
      if (!response.success) {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Invalid or expired code.',
          statusCode: 400,
        ));
      }
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not verify code.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> resetPasscodeWithOtp({
    required String phone,
    required String code,
    required String newPasscode,
  }) async {
    try {
      final response = await _authServiceClient.resetPasscodeWithOTP(
        auth_req_resp.ResetPasscodeWithOTPRequest(
          phone: phone,
          code: code,
          newPasscode: newPasscode,
        ),
      );
      if (!response.success) {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Could not reset passcode.',
          statusCode: 400,
        ));
      }
      return const Right(null);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not reset passcode.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, String>> setPreferredLoginMethod({
    required String method,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.setPreferredLoginMethod(
        auth_req_resp.SetPreferredLoginMethodRequest(method: method),
        options: callOptions,
      );
      if (response.success) {
        return Right(response.preferredLoginMethod.isNotEmpty
            ? response.preferredLoginMethod
            : method);
      }
      return Left(ServerFailure(
        message: response.msg.isNotEmpty
            ? response.msg
            : 'Failed to update login method',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to update login method'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> setPassword({
    required String newPassword,
  }) async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.setPassword(
        auth_req_resp.SetPasswordRequest(newPassword: newPassword),
        options: callOptions,
      );
      if (response.success) {
        return const Right(null);
      }
      return Left(ServerFailure(
        message: response.msg.isNotEmpty ? response.msg : 'Failed to set password',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to set password'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> registerPasscode({
    required String passcode,
  }) async {
    try {
      final request = auth_req_resp.RegisterPasscodeRequest(
        passcode: passcode,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.registerPasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty
              ? response.msg
              : 'Failed to register passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to register passcode'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error during passcode registration: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> changePasscode({
    required String oldPasscode,
    required String newPasscode,
  }) async {
    try {
      final request = auth_req_resp.ChangePasscodeRequest(
        currentPasscode: oldPasscode,
        newPasscode: newPasscode,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.changePasscode(
        request,
        options: callOptions,
      );

      if (response.success) {
        return const Right(null);
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty
              ? response.msg
              : 'Failed to change passcode',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to change passcode'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error during passcode change: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required SignupPrimaryContact primaryContact,
    String? phoneNumber,
    String? username,
    String? referralCode,
    String? locale, // Locale format: "en-NG", "en-US", etc. - we derive country/currency from this
    String? bvn,
    String? nin,
  }) async {
    try {
      // Map domain enum to proto enum
      final protoPrimaryContact = primaryContact == SignupPrimaryContact.phone
          ? auth_enum.PrimaryContactType.PHONE
          : auth_enum.PrimaryContactType.EMAIL;

      // Derive countryCode and currencyCode from locale
      // If locale is not provided, default to Nigeria
      final derivedCountryCode = _getCountryCodeFromLocale(locale);
      final derivedCurrencyCode = _getCurrencyCodeFromLocale(locale);

      print('Signup with locale: $locale -> countryCode: $derivedCountryCode, currencyCode: $derivedCurrencyCode');

      // Use new AuthService.Signup endpoint that returns tokens directly
      final dev = await _deviceFields();
      final signupRequest = auth_req_resp.SignupRequest(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
        phone: phoneNumber ?? '',
        countryCode: derivedCountryCode, // Derived from locale
        deviceId: dev.id,
        deviceName: dev.name,
        primaryContactType: protoPrimaryContact,
        username: username ?? '', // Pass empty string if not provided - backend handles as optional
        referralCode: referralCode ?? '',
      );
      print('Sending gRPC Signup request with countryCode: $derivedCountryCode...');
      final signupResponse = await _authServiceClient.signup(
        signupRequest,
        options: await _callOptionsHelper.withAppCheck(),
      );

      // Check if signup returned tokens
      if (signupResponse.accessToken.isEmpty || signupResponse.refreshToken.isEmpty) {
        print('gRPC Signup succeeded but no tokens returned');
        return Left(ServerFailure(
          message: 'Signup partially failed (no tokens returned).',
          statusCode: 500
        ));
      }

      // Check if user data is present
      if (!signupResponse.hasUser()) {
        print('gRPC Signup succeeded but no user data returned');
        return Left(ServerFailure(
          message: 'Signup partially failed (no user data).',
          statusCode: 500
        ));
      }

      print('gRPC Signup successful. User created with tokens.');

      final userModel = UserModel.fromAuthProto(signupResponse.user)
          .withRolesFromAccessToken(signupResponse.accessToken);

      // Create session model with tokens
      final now = DateTime.now();
      final expiresAt = now.add(Duration(seconds: signupResponse.expiresIn.toInt()));
      final sessionModel = SessionModel(
        id: signupResponse.user.id,
        userId: signupResponse.user.id,
        accessToken: signupResponse.accessToken,
        refreshToken: signupResponse.refreshToken,
        accessTokenExpiresAt: expiresAt,
        refreshTokenExpiresAt: expiresAt,
      );

      final profileModel = ProfileModel(user: userModel, session: sessionModel);

      return Right(profileModel);

    } on GrpcError catch (e) {
      print('gRPC Error during signUp: ${e.codeName} - ${e.message}');
      if (e.code == StatusCode.alreadyExists) {
        return Left(ServerFailure(message: friendlyGrpcError(e, 'Account already exists.'), statusCode: e.code));
      }
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Signup failed due to server error.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during signUp: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred during signup.', statusCode: 500));
    }
  }     

  @override
  Future<Either<Failure, ProfileEntity>> signInWithGoogle() async {
    print('signInWithGoogle called - NOT IMPLEMENTED');
    await Future.delayed(const Duration(milliseconds: 50));
    return Left(ServerFailure(message: 'Google Sign-In not implemented yet.', statusCode: 501));
  }

  @override
  Future<Either<Failure, ProfileEntity>> signInWithApple() async {
    print('signInWithApple called - NOT IMPLEMENTED');
    await Future.delayed(const Duration(milliseconds: 50));
    return Left(ServerFailure(message: 'Apple Sign-In not implemented yet.', statusCode: 501));
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset({required String email}) async {
    try {
      // Use ForgotPassword RPC which sends a reset token via email
      final request = auth_req_resp.ForgotPasswordRequest(email: email);
      print('Sending gRPC ForgotPassword request for email: $email');

      // Get CallOptions with auth and account metadata
      final options = await _callOptionsHelper.withAuth();
      // We ignore the response for security reasons (don't reveal if email exists)
      await _authServiceClient.forgotPassword(request, options: options);

      // ForgotPassword always returns success (security: don't reveal if email exists)
      print('Password reset email sent successfully');
      return const Right(null);
    } on GrpcError catch (e) {
      // For security, still return success even on gRPC error
      // This prevents email enumeration
      print('gRPC Error during forgotPassword: ${e.codeName} - ${e.message}');
      // Still return Right to prevent email enumeration
      return const Right(null);
    } catch (e) {
      print('Unexpected error during forgotPassword: $e');
      // Still return Right to prevent email enumeration
      return const Right(null);
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String email,
    required String token,
    required String newPassword,
  }) async {
    try {
      final request = auth_req_resp.ResetPasswordRequest(
        resetToken: token, // proto uses resetToken, not token
        newPassword: newPassword,
      );
      print('Sending gRPC ResetPassword request with token: ${token.length > 8 ? token.substring(0, 8) : token}...');

      // Get CallOptions with auth and account metadata
      final options = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.resetPassword(request, options: options);

      if (response.success) {
        print('Password reset successful');
        return const Right(null);
      } else {
        print('Password reset failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to reset password.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during resetPassword: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to reset password. The reset token may be invalid or expired.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during resetPassword: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, PasswordResetResult>> requestPasswordResetV2({
    String? email,
    String? phone,
    auth_enum.PasswordResetDeliveryMethod? deliveryMethod,
  }) async {
    try {
      final request = auth_req_resp.ForgotPasswordRequest(
        email: email ?? '',
        phone: phone ?? '',
        deliveryMethod: deliveryMethod ?? auth_enum.PasswordResetDeliveryMethod.DELIVERY_METHOD_UNSPECIFIED,
      );
      print('Sending gRPC ForgotPasswordV2 request: email=$email, phone=$phone, deliveryMethod=$deliveryMethod');

      // Get CallOptions with auth and account metadata
      // Note: For password reset, user may not be logged in, but we pass headers if available
      final options = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.forgotPassword(request, options: options);

      print('Password reset response: success=${response.success}, userFound=${response.hasUserFound() ? response.userFound : false}, deliveryMethod=${response.deliveryMethod}, maskedContact=${response.maskedContact}');

      return Right(PasswordResetResult(
        success: response.success,
        message: response.message,
        deliveryMethod: response.deliveryMethod,
        maskedContact: response.maskedContact,
        expiresInSeconds: response.hasExpiresInSeconds() ? response.expiresInSeconds.toInt() : 900,
        resetToken: null, // resetToken is only returned after verifying the code, not in ForgotPasswordResponse
        userFound: response.hasUserFound() ? response.userFound : true, // Default to true for backward compatibility
      ));
    } on GrpcError catch (e) {
      print('gRPC Error during forgotPassword: ${e.codeName} - ${e.message}');
      // For security, still return a "success" response to prevent enumeration
      return Right(PasswordResetResult(
        success: true,
        message: 'If the contact exists, a reset code has been sent',
        deliveryMethod: 'unknown',
        maskedContact: '',
        expiresInSeconds: 0,
        userFound: false, // Likely not found when gRPC error occurs
      ));
    } catch (e) {
      print('Unexpected error during forgotPassword: $e');
      // Still return success to prevent enumeration
      return Right(PasswordResetResult(
        success: true,
        message: 'If the contact exists, a reset code has been sent',
        deliveryMethod: 'unknown',
        maskedContact: '',
        expiresInSeconds: 0,
        userFound: false, // Likely not found on exception
      ));
    }
  }

  @override
  Future<Either<Failure, PasswordResetVerificationResult>> verifyPasswordResetCode({
    required String contact,
    required String code,
    required auth_enum.PasswordResetDeliveryMethod deliveryMethod,
  }) async {
    try {
      final request = auth_req_resp.VerifyPasswordResetCodeRequest(
        contact: contact,
        code: code,
        deliveryMethod: deliveryMethod,
      );
      print('Sending gRPC VerifyPasswordResetCode request: contact=$contact, deliveryMethod=$deliveryMethod');

      // Get CallOptions with auth and account metadata
      final options = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyPasswordResetCode(request, options: options);

      print('Verify response: success=${response.success}, resetToken=${response.resetToken.isNotEmpty ? response.resetToken.substring(0, 8) : "empty"}...');

      if (response.success) {
        return Right(PasswordResetVerificationResult(
          success: true,
          message: response.message,
          resetToken: response.resetToken,
          expiresInSeconds: response.hasExpiresInSeconds() ? response.expiresInSeconds.toInt() : 900,
        ));
      } else {
        return Left(ServerFailure(
          message: response.message.isNotEmpty ? response.message : 'Failed to verify code',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyPasswordResetCode: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to verify code. Please try again.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyPasswordResetCode: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> resetPasswordWithToken({
    required String resetToken,
    required String newPassword,
  }) async {
    try {
      final request = auth_req_resp.ResetPasswordRequest(
        resetToken: resetToken,
        newPassword: newPassword,
      );
      print('Sending gRPC ResetPasswordWithToken request with token: ${resetToken.substring(0, 8)}...');

      // Get CallOptions with auth and account metadata
      final options = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.resetPassword(request, options: options);

      if (response.success) {
        print('Password reset successful');
        return const Right(null);
      } else {
        print('Password reset failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to reset password.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during resetPasswordWithToken: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to reset password. The reset token may be invalid or expired.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during resetPasswordWithToken: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> verifyEmail({required String verificationCode}) async {
    try {
      final request = auth_req_resp.VerifyEmailRequest(verificationCode: verificationCode);
      print('Sending gRPC VerifyEmail request');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyEmail(request, options: callOptions);

      if (response.success) {
        print('Email verified successfully on backend');

        // Backend has verified the email - no need to call getMe again.
        // Just update the frontend state with isEmailVerified=true using stored user data.
        // On next login, the backend will return the updated state.

        // Get current tokens from storage
        final accessToken = await _callOptionsHelper.storage.read(key: 'access_token');
        final refreshToken = await _callOptionsHelper.storage.read(key: 'refresh_token');

        if (accessToken == null || refreshToken == null) {
          print('Tokens not found in storage after email verification');
          return Left(ServerFailure(
            message: 'Session expired. Please log in again.',
            statusCode: 401,
          ));
        }

        // Read user data from storage (saved during signup)
        final userId = await _callOptionsHelper.storage.read(key: 'user_id');
        final userEmail = await _callOptionsHelper.storage.read(key: 'user_email');
        final userFirstName = await _callOptionsHelper.storage.read(key: 'user_first_name');
        final userLastName = await _callOptionsHelper.storage.read(key: 'user_last_name');
        final userAvatarUrl = await _callOptionsHelper.storage.read(key: 'user_avatar_url');

        if (userId != null && userId.isNotEmpty) {
          // Construct profile with isEmailVerified=true - backend already confirmed it
          final now = DateTime.now();
          final user = UserModel(
            id: userId,
            firstName: userFirstName ?? '',
            lastName: userLastName ?? '',
            email: userEmail ?? '',
            phoneNumber: null,
            username: null,
            role: null,
            verified: false,
            isEmailVerified: true, // Backend verified it, update frontend state
            createdAt: now,
            updatedAt: now,
            profilePicture: userAvatarUrl?.isNotEmpty == true ? userAvatarUrl : null,
          ).withRolesFromAccessToken(accessToken);

          final sessionModel = SessionModel(
            id: userId,
            userId: userId,
            accessToken: accessToken,
            refreshToken: refreshToken,
            accessTokenExpiresAt: now.add(const Duration(hours: 1)),
            refreshTokenExpiresAt: now.add(const Duration(days: 7)),
          );

          final profileModel = ProfileModel(user: user, session: sessionModel);
          print('Email verified - returning updated profile with isEmailVerified=true (no getMe call needed)');
          return Right(profileModel);
        } else {
          // No stored user data - session lost
          print('No user data in storage after email verification');
          return Left(ServerFailure(
            message: 'Session expired. Please log in again.',
            statusCode: 401,
          ));
        }
      } else {
        print('Email verification failed: ${response.msg}');
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to verify email.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyEmail: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to verify email.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyEmail: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, int>> resendVerificationEmail({required String email}) async {
    try {
      final request = auth_req_resp.ResendVerificationEmailRequest(email: email);
      print('Sending gRPC ResendVerificationEmail request for email: $email');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.resendVerificationEmail(request, options: callOptions);

      if (response.success) {
        print('Verification email sent successfully, cooldown: ${response.cooldownSeconds}s');
        // Return the cooldown seconds from the backend (default 60 if not set)
        return Right(response.cooldownSeconds > 0 ? response.cooldownSeconds : 60);
      } else {
        print('Resend verification email failed: ${response.message}');
        // Return the cooldown seconds even on failure (rate limit scenario)
        if (response.cooldownSeconds > 0) {
          return Left(ServerFailure(
            message: response.message.isNotEmpty ? response.message : 'Please wait before requesting another code.',
            statusCode: 429, // Too Many Requests
            cooldownSeconds: response.cooldownSeconds,
          ));
        }
        return Left(ServerFailure(
          message: response.message.isNotEmpty ? response.message : 'Failed to send verification email.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during resendVerificationEmail: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to send verification email.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during resendVerificationEmail: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> refreshToken({required String refreshToken}) async {
    try {
      print('Calling RefreshToken endpoint with token: ${refreshToken.substring(0, 20)}...');
      final request = auth_req_resp.RefreshTokenRequest(refreshToken: refreshToken);
      final response = await _authServiceClient.refreshToken(request);

      print('RefreshToken response received');

      // Check if response has the new tokens
      if (response.hasAccessToken() && response.hasRefreshToken()) {
        print('New tokens received from refresh');

        // Check if user data is present
        UserModel userModel;
        if (response.hasUser()) {
          userModel = UserModel.fromAuthProto(response.user)
              .withRolesFromAccessToken(response.accessToken);
        } else {
          userModel = UserModel(
            id: '',
            email: '',
            firstName: '',
            lastName: '',
            phoneNumber: '',
            verified: false,
            isEmailVerified: false,
            profilePicture: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ).withRolesFromAccessToken(response.accessToken);
        }

        final now = DateTime.now();
        final expiresAt = now.add(Duration(seconds: response.expiresIn.toInt()));
        final sessionModel = SessionModel(
          id: userModel.id,
          userId: userModel.id,
          accessToken: response.accessToken,
          refreshToken: response.refreshToken,
          accessTokenExpiresAt: expiresAt,
          refreshTokenExpiresAt: expiresAt,
        );

        final profileModel = ProfileModel(user: userModel, session: sessionModel);
        print('RefreshToken successful, returning new profile');
        return Right(profileModel);
      } else {
        print('RefreshToken response missing tokens');
        return Left(ServerFailure(
            message: 'Token refresh failed - no tokens returned.', statusCode: 401));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during token refresh: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Token refresh failed due to server error.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during token refresh: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred during token refresh.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, void>> logout({
    required String userId,
    required String refreshToken,
  }) async {
    try {
      final request = auth_req_resp.LogoutRequest(
        userId: userId,
        refreshToken: refreshToken,
      );
      // Authenticated call — the gateway revokes the server-side session for the
      // bearer token. Must run BEFORE the local session is cleared so withAuth()
      // can still attach a valid access token.
      final callOptions = await _callOptionsHelper.withAuth();
      await _authServiceClient.logout(request, options: callOptions);
      print('Logout: server-side session revoked');
      return const Right(null);
    } on GrpcError catch (e) {
      print('gRPC Error during logout: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Logout failed.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during logout: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred during logout.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> validateToken({required String accessToken}) async {
    try {
      final request = auth_req_resp.ValidateTokenRequest(token: accessToken);
      print('Validating access token...');

      final response = await _authServiceClient.validateToken(request);

      if (response.valid) {
        print('Token is valid for user: ${response.email}');

        final userModel = UserModel(
          id: response.userId,
          email: response.email,
          firstName: '', // Not returned in validation response
          lastName: '', // Not returned in validation response
          phoneNumber: '',
          verified: true,
          isEmailVerified: true,
          profilePicture: null,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ).withRolesFromAccessToken(accessToken);

        // Create a minimal session model
        final now = DateTime.now();
        final expiresAt = response.hasExpiresAt()
            ? DateTime.fromMillisecondsSinceEpoch(response.expiresAt.toInt() * 1000)
            : now.add(const Duration(hours: 1));

        final sessionModel = SessionModel(
          id: response.userId,
          userId: response.userId,
          accessToken: accessToken,
          refreshToken: '', // Not returned in validation response
          accessTokenExpiresAt: expiresAt,
          refreshTokenExpiresAt: expiresAt,
        );

        final profileModel = ProfileModel(user: userModel, session: sessionModel);
        return Right(profileModel);
      } else {
        print('Token validation failed: token is invalid');
        return Left(ServerFailure(
          message: 'Token is invalid or expired.',
          statusCode: 401,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during token validation: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Token validation failed.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during token validation: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred during token validation.',
        statusCode: 500,
      ));
    }
  }

  /// Helper method for token rotation - returns tokens as a simple map
  /// This is used by GrpcCallOptionsHelper for automatic token refresh
  @override
  @override
  Future<Either<Failure, DateTime>> requestAccountLock({required int durationSeconds, String? reason}) async {
    try {
      final response = await _authServiceClient.requestAccountLock(
        auth_req_resp.RequestAccountLockRequest(
          durationSeconds: durationSeconds,
          reason: reason ?? '',
        ),
        options: await _callOptionsHelper.withAuth(),
      );
      if (!response.success) {
        return Left(ServerFailure(
            message: response.message.isNotEmpty ? response.message : 'Could not lock your account.',
            statusCode: 400));
      }
      final until = DateTime.tryParse(response.lockedUntil);
      if (until == null) {
        return Left(ServerFailure(message: 'Invalid lock response.', statusCode: 0));
      }
      return Right(until);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Could not lock your account.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, AccountDeletionOutcome>> requestAccountDeletion({String? reason}) async {
    try {
      final response = await _authServiceClient.requestAccountDeletion(
        auth_req_resp.RequestAccountDeletionRequest(reason: reason ?? ''),
        options: await _callOptionsHelper.withAuth(),
      );
      return Right(AccountDeletionOutcome(
        success: response.success,
        status: response.status,
        scheduledAt: response.scheduledAt,
        gracePeriodDays: response.gracePeriodDays,
        message: response.message,
        errorCode: response.errorCode,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Could not delete your account.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Either<Failure, String>> cancelAccountDeletion() async {
    try {
      final response = await _authServiceClient.cancelAccountDeletion(
        auth_req_resp.CancelAccountDeletionRequest(),
        options: await _callOptionsHelper.withAuth(),
      );
      return Right(response.message);
    } on GrpcError catch (e) {
      return Left(ServerFailure(
          message: friendlyGrpcError(e, 'Could not cancel your deletion.'), statusCode: e.code));
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), statusCode: 0));
    }
  }

  @override
  Future<Map<String, String>?> refreshTokensSimple() async {
    // Get refresh token from secure storage (the volatile session key).
    final storage = _callOptionsHelper.storage;
    final refreshToken = await storage.read(key: 'refresh_token');
    if (refreshToken == null || refreshToken.isEmpty) {
      print('No refresh token available for rotation');
      return null;
    }
    return refreshTokensWithToken(refreshToken);
  }

  @override
  Future<({Map<String, String>? tokens, bool authExpired})>
      refreshTokensWithReason() async {
    final storage = _callOptionsHelper.storage;
    final rt = await storage.read(key: 'refresh_token');
    if (rt == null || rt.isEmpty) {
      // Nothing to rotate — treat as a definitive "need to re-auth".
      return (tokens: null, authExpired: true);
    }
    final result = await refreshToken(refreshToken: rt);
    return result.fold(
      (failure) {
        // Classify: was the refresh token actually REJECTED (definitive), or did
        // the request just fail to reach a healthy server (transient)? Only the
        // former means the session is gone. `statusCode` carries the gRPC code
        // (see refreshToken()) or a 401/500 sentinel.
        final code = failure.statusCode;
        final definitive = code == StatusCode.unauthenticated || // 16
            code == StatusCode.permissionDenied || //               7
            code == StatusCode.invalidArgument || //                3
            code == StatusCode.notFound || //                       5
            code == 401;
        return (tokens: null, authExpired: definitive);
      },
      (profile) async {
        final at = profile.session.accessToken;
        final newRt = profile.session.refreshToken;
        if (at.isNotEmpty && newRt.isNotEmpty) {
          // Persist the single, rotated refresh token atomically. There is NO
          // second "durable biometric" copy: the auth-service rotates refresh
          // tokens one-time-use and revokes the WHOLE family on any replay, so
          // two copies would inevitably diverge and trip reuse-detection. The
          // one `refresh_token` here IS the biometric credential.
          await storage.write(key: 'access_token', value: at);
          await storage.write(key: 'refresh_token', value: newRt);
        }
        return (
          tokens: {'accessToken': at, 'refreshToken': newRt},
          authExpired: false,
        );
      },
    );
  }

  @override
  Future<Map<String, String>?> refreshTokensWithToken(
      String refreshToken) async {
    try {
      final storage = _callOptionsHelper.storage;
      if (refreshToken.isEmpty) {
        print('No refresh token supplied for rotation');
        return null;
      }

      final result = await this.refreshToken(refreshToken: refreshToken);

      return await result.fold(
        (failure) async {
          print('Token refresh failed: ${failure.message}');
          return null;
        },
        (profile) async {
          print('Token refresh successful');
          final at = profile.session.accessToken;
          final rt = profile.session.refreshToken;
          // Persist the rotated tokens here so callers that invoke this method
          // DIRECTLY (biometric / voice login) leave a valid, rotated session in
          // storage. Without this, refresh-token rotation would burn the stored
          // refresh token without saving the new one, silently killing the
          // session on the next access-token expiry. Idempotent when this runs as
          // the interceptor's onTokenRefreshNeeded callback — the wrapper writes
          // the same values again. ONE refresh token only: no durable biometric
          // copy (the backend rotates one-time-use with family-kill-on-replay,
          // so a second copy would trip reuse-detection and revoke everything).
          if (at.isNotEmpty && rt.isNotEmpty) {
            await storage.write(key: 'access_token', value: at);
            await storage.write(key: 'refresh_token', value: rt);
          }
          return {
            'accessToken': at,
            'refreshToken': rt,
          };
        },
      );
    } catch (e) {
      print('Error in refreshTokensWithToken: $e');
      return null;
    }
  }

  @override
  Future<Either<Failure, bool>> checkEmailAvailability({required String email}) async {
    try {
      final request = auth_req_resp.CheckEmailAvailabilityRequest(email: email);
      print('Sending gRPC CheckEmailAvailability request for email: $email');

      final response = await _authServiceClient.checkEmailAvailability(request);

      print('Email availability check response: available=${response.available}, msg=${response.msg}');
      return Right(response.available);
    } on GrpcError catch (e) {
      print('gRPC Error during checkEmailAvailability: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to check email availability.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during checkEmailAvailability: $e');
      return Left(ServerFailure(message: 'An unexpected error occurred.', statusCode: 500));
    }
  }

  @override
  Future<Either<Failure, PhoneVerificationEntity>> requestPhoneVerification({
    required String phoneNumber,
  }) async {
    try {
      final request = auth_req_resp.RequestPhoneVerificationRequest(
        phone: phoneNumber,
      );
      print('Sending gRPC RequestPhoneVerification request for: $phoneNumber');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.requestPhoneVerification(request, options: callOptions);

      print('Phone verification request response: success=${response.success}, msg=${response.msg}');

      if (response.success) {
        return Right(PhoneVerificationModel(
          success: true,
          message: response.msg.isNotEmpty ? response.msg : 'Verification code sent to your phone',
          verificationId: response.verificationId,
          expiresIn: response.hasExpiresIn() ? response.expiresIn.toInt() : null,
        ));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to send verification code.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during requestPhoneVerification: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to send verification code.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during requestPhoneVerification: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while sending verification code.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, VerifyPhoneEntity>> verifyPhoneNumber({
    required String phoneNumber,
    required String verificationCode,
  }) async {
    try {
      final request = auth_req_resp.VerifyPhoneNumberRequest(
        phone: phoneNumber,
        code: verificationCode,
      );
      print('Sending gRPC VerifyPhoneNumber request for: $phoneNumber');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyPhoneNumber(request, options: callOptions);

      print('Phone verification response: success=${response.success}, isVerified=${response.isVerified}, msg=${response.msg}');

      if (response.success) {
        return Right(VerifyPhoneModel(
          success: true,
          message: response.msg.isNotEmpty ? response.msg : 'Phone number verified successfully',
          isVerified: response.isVerified,
        ));
      } else {
        return Left(ServerFailure(
          message: response.msg.isNotEmpty ? response.msg : 'Failed to verify phone number.',
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyPhoneNumber: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to verify phone number.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyPhoneNumber: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while verifying phone number.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> requestPhoneChange({
    required String newPhone,
    String countryCode = '',
  }) async {
    try {
      final request = auth_req_resp.RequestPhoneChangeRequest(
        newPhone: newPhone,
        countryCode: countryCode,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _authServiceClient.requestPhoneChange(request, options: callOptions);
      if (response.success) {
        return Right(response.msg.isNotEmpty
            ? response.msg
            : 'A verification code has been sent to the new number');
      }
      return Left(ServerFailure(
        message: response.msg.isNotEmpty ? response.msg : 'Could not start the phone change.',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not start the phone change.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred while changing your number.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, String>> verifyPhoneChange({
    required String newPhone,
    required String code,
    String countryCode = '',
  }) async {
    try {
      final request = auth_req_resp.VerifyPhoneChangeRequest(
        newPhone: newPhone,
        code: code,
        countryCode: countryCode,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response =
          await _authServiceClient.verifyPhoneChange(request, options: callOptions);
      if (response.success) {
        return Right(response.phone.isNotEmpty ? response.phone : newPhone);
      }
      return Left(ServerFailure(
        message: response.msg.isNotEmpty ? response.msg : 'Could not verify the new number.',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Could not verify the new number.'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'An unexpected error occurred while verifying the new number.',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, IdentityVerificationResult>> verifyIdentity({
    required String identityType,
    required String identityNumber,
    required String dateOfBirth,
    String? countryCode,
  }) async {
    try {
      // Map identity type string to proto enum
      // Note: Current proto only supports BVN and NIN. Other identity types
      // (SSN, NI Number, Ghana Card, etc.) will be mapped to NIN as fallback
      // until backend support is added.
      auth_req_resp.IdentityType protoIdentityType;

      final country = countryCode?.toUpperCase() ?? 'NG';

      switch (identityType.toLowerCase()) {
        case 'bvn':
          protoIdentityType = auth_req_resp.IdentityType.IDENTITY_TYPE_BVN;
          break;
        case 'nin':
        case 'ssn':
        case 'ssn_last4':
        case 'ni_number':
        case 'ghana_card':
        case 'national_id':
        default:
          // For now, map all other types to NIN
          // TODO: Update proto to support multi-country identity types
          // Once backend supports SSN, NI_NUMBER, GHANA_CARD, etc., update mapping here
          protoIdentityType = auth_req_resp.IdentityType.IDENTITY_TYPE_NIN;
      }

      final request = auth_req_resp.VerifyIdentityRequest(
        identityType: protoIdentityType,
        identityNumber: identityNumber,
        dateOfBirth: dateOfBirth,
      );

      print('Sending gRPC VerifyIdentity request: type=$identityType, country=$country, number=${identityNumber.length > 4 ? identityNumber.substring(0, 4) : identityNumber}****, dob=$dateOfBirth');

      // Use helper to get call options with authorization header from secure storage
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.verifyIdentity(request, options: callOptions);

      print('VerifyIdentity response: success=${response.success}, verified=${response.verified}');

      if (response.success && response.verified) {
        // Build virtual account info if present
        VirtualAccountInfo? virtualAccount;
        if (response.hasVirtualAccount()) {
          virtualAccount = VirtualAccountInfo(
            accountNumber: response.virtualAccount.accountNumber,
            bankName: response.virtualAccount.bankName,
            bankCode: response.virtualAccount.bankCode,
            accountName: response.virtualAccount.accountName,
            currency: response.virtualAccount.currency,
            provider: response.virtualAccount.provider,
          );
        }

        return Right(IdentityVerificationResult(
          verified: true,
          firstName: response.hasIdentity() ? response.identity.firstName : null,
          lastName: response.hasIdentity() ? response.identity.lastName : null,
          middleName: response.hasIdentity() ? response.identity.middleName : null,
          phoneNumber: response.hasIdentity() ? response.identity.phoneNumber : null,
          dateOfBirth: response.hasIdentity() ? response.identity.dateOfBirth : null,
          gender: response.hasIdentity() ? response.identity.gender : null,
          photoUrl: response.hasIdentity() ? response.identity.photoUrl : null,
          virtualAccount: virtualAccount,
        ));
      } else {
        final errorMsg = response.errorMessage.isNotEmpty
            ? response.errorMessage
            : 'Identity verification failed.';
        return Left(ServerFailure(
          message: errorMsg,
          statusCode: 400,
        ));
      }
    } on GrpcError catch (e) {
      print('gRPC Error during verifyIdentity: ${e.codeName} - ${e.message}');
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to verify identity.'),
        statusCode: e.code,
      ));
    } catch (e) {
      print('Unexpected error during verifyIdentity: $e');
      return Left(ServerFailure(
        message: 'An unexpected error occurred while verifying identity.',
        statusCode: 500,
      ));
    }
  }

  /// Extract country code from locale (e.g., "en-NG" -> "NG")
  /// Defaults to "NG" (Nigeria) if locale is null or invalid
  String _getCountryCodeFromLocale(String? locale) {
    if (locale == null || locale.isEmpty) return 'NG';

    final parts = locale.split('-');
    if (parts.length >= 2) {
      final countryCode = parts.last.toUpperCase();
      // Validate that this is a supported country code
      if (CountryConfigs.isCountrySupported(countryCode)) {
        return countryCode;
      }
    }
    return 'NG'; // Default to Nigeria
  }

  /// Extract currency code from locale (e.g., "en-NG" -> "NGN")
  /// Defaults to "NGN" (Naira) if locale is null or invalid
  String _getCurrencyCodeFromLocale(String? locale) {
    final countryCode = _getCountryCodeFromLocale(locale);
    final config = CountryConfigs.getByCode(countryCode);
    return config?.currency ?? 'NGN';
  }

  // ===== Two-Factor Authentication =====
  //
  // All five RPCs are JWT-authenticated; the backend extracts the user id
  // from the access token. Each call goes through the standard
  // GrpcCallOptionsHelper.withAuth() to attach `authorization: Bearer …`
  // and forward locale/country metadata for audit logs.

  @override
  Future<Either<Failure, TwoFactorStatus>> getTwoFactorStatus() async {
    try {
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.getTwoFactorStatus(
        auth_req_resp.GetTwoFactorStatusRequest(),
        options: callOptions,
      );
      final method = response.method.isEmpty
          ? null
          : TwoFactorMethod.fromString(response.method);
      return Right(TwoFactorStatus(
        enabled: response.enabled,
        method: method,
        backupCodesCount: response.backupCodesCount,
        hasBackupCodes: response.backupCodesCount > 0,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to load 2FA status'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error loading 2FA status: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, TwoFactorSetup>> enableTwoFactor({
    required TwoFactorMethod method,
  }) async {
    try {
      // userId left empty — backend pulls it from the JWT. We pass it only
      // for the proto contract; the server-side handler ignores it when
      // the access token resolves a different user.
      final request = auth_req_resp.EnableTwoFactorRequest(
        method: method.value,
      );
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.enableTwoFactor(
        request,
        options: callOptions,
      );
      return Right(TwoFactorSetup(
        secret: response.secret,
        qrCode: response.qrCode,
        backupCodes: response.backupCodes.toList(),
        method: method,
        verificationRequired: true,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to enable 2FA'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error enabling 2FA: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> completeTwoFactorSetup({
    required String code,
  }) async {
    try {
      final request = auth_req_resp.CompleteTwoFactorSetupRequest(code: code);
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.completeTwoFactorSetup(
        request,
        options: callOptions,
      );
      if (response.success) {
        return const Right(null);
      }
      return Left(ServerFailure(
        message: response.message.isNotEmpty
            ? response.message
            : 'Failed to verify 2FA code',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to verify 2FA code'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error verifying 2FA code: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> disableTwoFactor({
    required String code,
  }) async {
    try {
      final request = auth_req_resp.DisableTwoFactorRequest(code: code);
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.disableTwoFactor(
        request,
        options: callOptions,
      );
      if (response.success) {
        return const Right(null);
      }
      return Left(ServerFailure(
        message: response.message.isNotEmpty
            ? response.message
            : 'Failed to disable 2FA',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to disable 2FA'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error disabling 2FA: $e',
        statusCode: 500,
      ));
    }
  }

  @override
  Future<Either<Failure, List<String>>> regenerateBackupCodes({
    required String code,
  }) async {
    try {
      final request = auth_req_resp.RegenerateBackupCodesRequest(code: code);
      final callOptions = await _callOptionsHelper.withAuth();
      final response = await _authServiceClient.regenerateBackupCodes(
        request,
        options: callOptions,
      );
      if (response.success) {
        return Right(response.backupCodes.toList());
      }
      return Left(ServerFailure(
        message: response.message.isNotEmpty
            ? response.message
            : 'Failed to regenerate backup codes',
        statusCode: 400,
      ));
    } on GrpcError catch (e) {
      return Left(ServerFailure(
        message: friendlyGrpcError(e, 'Failed to regenerate backup codes'),
        statusCode: e.code,
      ));
    } catch (e) {
      return Left(ServerFailure(
        message: 'Unexpected error regenerating backup codes: $e',
        statusCode: 500,
      ));
    }
  }
}
