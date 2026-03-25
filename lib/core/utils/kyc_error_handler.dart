import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_upgrade_modal.dart';

/// Checks if a gRPC error is KYC-tier-related and shows the upgrade modal.
///
/// Returns `true` if the error was KYC-related and the modal was shown.
/// Call from any payment cubit's error handler:
/// ```dart
/// } on GrpcError catch (e) {
///   if (handleKYCError(e, context, 'send money')) return;
///   // handle other errors...
/// }
/// ```
bool handleKYCError(
  dynamic error,
  BuildContext context,
  String operationName,
) {
  String? errorMessage;

  if (error is GrpcError) {
    errorMessage = error.message ?? '';
  } else {
    errorMessage = error.toString();
  }

  if (errorMessage == null || errorMessage.isEmpty) return false;

  // Check for KYC_TIER_INSUFFICIENT error code from accounts-service
  if (!errorMessage.contains('KYC_TIER_INSUFFICIENT') &&
      !errorMessage.contains('kyc_tier')) {
    return false;
  }

  // Parse current tier from error message
  int currentTier = 1;
  final tierMatch = RegExp(r'kyc_tier:\s*(\d+)').firstMatch(errorMessage);
  if (tierMatch != null) {
    final group = tierMatch.group(1);
    if (group != null) {
      currentTier = int.tryParse(group) ?? 1;
    }
  }

  // Cap requiredTier at 3
  final requiredTier = currentTier < 3 ? currentTier + 1 : 3;

  // Show upgrade modal
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => KYCUpgradeModal(
      currentTier: currentTier,
      requiredTier: requiredTier,
      operationName: operationName,
    ),
  );

  return true;
}

/// Check if an error message indicates a KYC limit issue (for use in cubits
/// that don't have BuildContext access).
bool isKYCLimitError(String? errorMessage) {
  if (errorMessage == null) return false;
  return errorMessage.contains('KYC_TIER_INSUFFICIENT');
}
