import 'package:equatable/equatable.dart';

class APIException extends Equatable implements Exception {
  const APIException({
    required this.message,
    required this.statusCode,
    this.code,
  });

  final String message;
  final int statusCode;

  /// Machine-readable error code from the server when it sent one (e.g.
  /// `IDENTITY_DETAILS_MISMATCH`, `NIN_ALREADY_REGISTERED`).
  ///
  /// Optional, and `null` for every caller that does not set it, so this is
  /// additive. It exists because branching on a human-readable `message` is
  /// how error handling silently breaks the next time the copy is reworded —
  /// and some of these branches decide whether a customer is let through
  /// onboarding.
  final String? code;

  @override
  List<Object?> get props => [message, statusCode, code];
}
