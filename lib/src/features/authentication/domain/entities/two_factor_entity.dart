import 'package:equatable/equatable.dart';

/// Two-factor authentication methods available
enum TwoFactorMethod {
  totp('Authenticator App'),
  sms('SMS Verification'),
  email('Email Verification');

  final String displayName;
  const TwoFactorMethod(this.displayName);

  String get value {
    switch (this) {
      case TwoFactorMethod.totp:
        return 'totp';
      case TwoFactorMethod.sms:
        return 'sms';
      case TwoFactorMethod.email:
        return 'email';
    }
  }

  static TwoFactorMethod fromString(String value) {
    return TwoFactorMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () => TwoFactorMethod.totp,
    );
  }
}

/// Entity representing two-factor authentication setup data
class TwoFactorSetup extends Equatable {
  final String secret;
  final String qrCode; // Base64-encoded QR code PNG
  final List<String> backupCodes;
  final TwoFactorMethod method;
  final bool verificationRequired;

  const TwoFactorSetup({
    required this.secret,
    required this.qrCode,
    required this.backupCodes,
    required this.method,
    this.verificationRequired = true,
  });

  const TwoFactorSetup.empty()
      : secret = '',
        qrCode = '',
        backupCodes = const [],
        method = TwoFactorMethod.totp,
        verificationRequired = false;

  @override
  List<Object?> get props => [secret, qrCode, backupCodes, method, verificationRequired];
}

/// Entity representing two-factor authentication status
class TwoFactorStatus extends Equatable {
  final bool enabled;
  final TwoFactorMethod? method;
  final int backupCodesCount;
  final bool hasBackupCodes;

  const TwoFactorStatus({
    required this.enabled,
    this.method,
    this.backupCodesCount = 0,
    this.hasBackupCodes = false,
  });

  const TwoFactorStatus.disabled()
      : enabled = false,
        method = null,
        backupCodesCount = 0,
        hasBackupCodes = false;

  @override
  List<Object?> get props => [enabled, method, backupCodesCount, hasBackupCodes];
}

/// Entity representing a two-factor authentication method with details
class TwoFactorMethodInfo extends Equatable {
  final TwoFactorMethod method;
  final String name;
  final String description;
  final String icon;
  final bool available;

  const TwoFactorMethodInfo({
    required this.method,
    required this.name,
    required this.description,
    required this.icon,
    this.available = true,
  });

  @override
  List<Object?> get props => [method, name, description, icon, available];

  static const List<TwoFactorMethodInfo> availableMethods = [
    TwoFactorMethodInfo(
      method: TwoFactorMethod.totp,
      name: 'Authenticator App',
      description: 'Use Google Authenticator, Microsoft Authenticator, or Authy app to generate verification codes',
      icon: 'shield',
    ),
    TwoFactorMethodInfo(
      method: TwoFactorMethod.sms,
      name: 'SMS Verification',
      description: 'Receive a verification code via text message',
      icon: 'message',
    ),
    TwoFactorMethodInfo(
      method: TwoFactorMethod.email,
      name: 'Email Verification',
      description: 'Receive a verification code via email',
      icon: 'mail',
    ),
  ];
}
