import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/verification_badge.dart';
import 'package:lazervault/core/shared_widgets/app_loading_button.dart';

/// Progressive KYC onboarding screen
/// Allows users to complete verification at their own pace
class ProgressiveKYCScreen extends StatefulWidget {
  const ProgressiveKYCScreen({super.key});

  static const String route = '/kyc/progressive';

  @override
  State<ProgressiveKYCScreen> createState() => _ProgressiveKYCScreenState();
}

class _ProgressiveKYCScreenState extends State<ProgressiveKYCScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        elevation: 0,
      ),
      body: BlocConsumer<KYCCubit, KYCState>(
        listener: (context, state) {
          if (state is IDVerificationSuccess) {
            _showVerificationSuccessDialog(context, state.response);
          } else if (state is KYCError) {
            _showErrorDialog(context, state);
          } else if (state is KYCSkipped) {
            _showSkippedDialog(context, state.response);
          }
        },
        builder: (context, state) {
          if (state is KYCLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is KYCStatusLoaded) {
            return _buildContent(context, state.profile);
          }

          return _buildInitialContent(context);
        },
      ),
    );
  }

  Widget _buildInitialContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildBenefits(context),
          const SizedBox(height: 32),
          _buildActionButtons(context),
          const SizedBox(height: 24),
          _buildSkipOption(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context, UserKYCProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatusHeader(context, profile),
          const SizedBox(height: 24),
          TierProgressIndicator(
            currentTier: profile.currentTier,
            onTierTap: () => _showUpgradeDialog(context, profile),
          ),
          const SizedBox(height: 24),
          if (profile.nextTier != null) _buildUpgradeCard(context, profile),
          const SizedBox(height: 16),
          if (profile.documents.isNotEmpty) _buildDocumentsSection(context, profile),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            Icons.verified_user,
            size: 40,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Verify Your Identity',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Complete your verification to unlock higher transaction limits and access all features.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusHeader(BuildContext context, UserKYCProfile profile) {
    final theme = Theme.of(context);
    final color = Color(int.parse(profile.getStatusColor().replaceFirst('#', '0xFF')));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color, width: 1),
      ),
      child: Row(
        children: [
          VerificationBadgeIcon(
            tier: profile.currentTier,
            status: profile.status,
            size: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _getStatusTitle(profile.status),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getStatusMessage(profile),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          if (profile.status == KYCStatus.approved)
            Icon(
              Icons.check_circle,
              color: color,
              size: 32,
            )
          else if (profile.status == KYCStatus.inProgress ||
              profile.status == KYCStatus.pendingReview)
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBenefits(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why Verify?',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            _buildBenefit(
              context,
              icon: Icons.account_balance_wallet,
              title: 'Higher Limits',
              description: 'Send up to ₦500,000 daily after verification',
            ),
            const SizedBox(height: 12),
            _buildBenefit(
              context,
              icon: Icons.security,
              title: 'Enhanced Security',
              description: 'Keep your account safe with verified identity',
            ),
            const SizedBox(height: 12),
            _buildBenefit(
              context,
              icon: Icons.verified,
              title: 'Full Access',
              description: 'Unlock all features and services',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefit(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.colorScheme.primary.withOpacity(0.1),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AppLoadingButton(
            onPressed: () => _startVerification(context),
            text: 'Start Verification',
          ),
        ),
      ],
    );
  }

  Widget _buildSkipOption(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => _skipForNow(context),
        child: Text(
          'Skip for now',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradeCard(BuildContext context, UserKYCProfile profile) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      color: theme.colorScheme.primary.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.primary, width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.trending_up,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Upgrade to Tier ${profile.nextTier?.index ?? 2}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Complete additional verification to increase your limits.',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _startVerification(context),
                child: const Text('Upgrade Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentsSection(BuildContext context, UserKYCProfile profile) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.dividerColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Documents',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            ...profile.documents.map((doc) => _buildDocumentTile(context, doc)),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context, VerificationDocument doc) {
    final theme = Theme.of(context);
    final statusColor = _getDocumentStatusColor(doc.status);

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: statusColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          _getDocumentIcon(doc.documentType),
          color: statusColor,
        ),
      ),
      title: Text(
        doc.documentType.displayName,
        style: theme.textTheme.labelLarge,
      ),
      subtitle: Text(
        _getDocumentStatusText(doc.status),
        style: theme.textTheme.bodySmall?.copyWith(
          color: statusColor,
        ),
      ),
      trailing: Icon(
        _getDocumentStatusIcon(doc.status),
        color: statusColor,
        size: 20,
      ),
    );
  }

  Color _getDocumentStatusColor(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return const Color(0xFF4CAF50);
      case DocumentStatus.underReview:
      case DocumentStatus.uploaded:
        return const Color(0xFFFF9800);
      case DocumentStatus.rejected:
        return const Color(0xFFF44336);
      default:
        return const Color(0xFF9E9E9E);
    }
  }

  IconData _getDocumentIcon(IDType type) {
    switch (type) {
      case IDType.bvn:
        return Icons.account_balance;
      case IDType.nin:
        return Icons.badge;
      case IDType.internationalPassport:
        return Icons.card_membership;
      case IDType.ghanaCard:
        return Icons.credit_card;
      case IDType.kenyaNationalId:
        return Icons.contact_page;
      case IDType.saIdCard:
        return Icons.credit_card;
      case IDType.driversLicense:
        return Icons.drive_eta;
      default:
        return Icons.description;
    }
  }

  String _getDocumentStatusText(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.pendingUpload:
        return 'Pending upload';
      case DocumentStatus.uploaded:
        return 'Uploaded';
      case DocumentStatus.underReview:
        return 'Under review';
      case DocumentStatus.approved:
        return 'Approved';
      case DocumentStatus.rejected:
        return 'Rejected';
      default:
        return 'Unknown';
    }
  }

  IconData _getDocumentStatusIcon(DocumentStatus status) {
    switch (status) {
      case DocumentStatus.approved:
        return Icons.check_circle;
      case DocumentStatus.underReview:
      case DocumentStatus.uploaded:
        return Icons.pending;
      case DocumentStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.help_outline;
    }
  }

  String _getStatusTitle(KYCStatus status) {
    switch (status) {
      case KYCStatus.approved:
        return 'Verification Complete';
      case KYCStatus.inProgress:
        return 'Verification In Progress';
      case KYCStatus.pendingReview:
        return 'Pending Review';
      case KYCStatus.rejected:
        return 'Verification Failed';
      case KYCStatus.expired:
        return 'Verification Expired';
      default:
        return 'Not Verified';
    }
  }

  String _getStatusMessage(UserKYCProfile profile) {
    if (profile.rejectionReason != null) {
      return profile.rejectionReason!;
    }

    switch (profile.status) {
      case KYCStatus.approved:
        return 'Your identity has been verified';
      case KYCStatus.inProgress:
        return 'Your verification is being processed';
      case KYCStatus.pendingReview:
        return 'We are reviewing your documents';
      case KYCStatus.rejected:
        return 'Please try again with correct information';
      case KYCStatus.expired:
        return 'Please update your verification';
      default:
        return 'Complete verification to unlock all features';
    }
  }

  void _startVerification(BuildContext context) {
    Navigator.of(context).pushNamed('/kyc/verify-id');
  }

  void _skipForNow(BuildContext context) {
    final cubit = context.read<KYCCubit>();
    // Use a dummy user ID for now - in real app, get from auth state
    cubit.skipKYCUpgrade(userId: 'current_user_id', skipTier2: true);
  }

  void _showUpgradeDialog(BuildContext context, UserKYCProfile profile) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Upgrade to Tier ${profile.nextTier?.index ?? 2}'),
        content: Text(
          'To upgrade, you\'ll need to provide additional verification documents.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _startVerification(context);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showVerificationSuccessDialog(
    BuildContext context,
    VerifyIDResponse response,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        icon: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green.withOpacity(0.1),
          ),
          child: const Icon(
            Icons.check,
            color: Colors.green,
            size: 30,
          ),
        ),
        title: const Text('Verification Submitted'),
        content: const Text(
          'Your information has been submitted for verification. We\'ll notify you once it\'s approved.',
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, KYCError state) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red.withOpacity(0.1),
          ),
          child: const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 30,
          ),
        ),
        title: const Text('Verification Failed'),
        content: Text(state.userMessage ?? state.failure.message),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showSkippedDialog(BuildContext context, SkipKYCResponse response) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response.message),
        backgroundColor: Colors.orange,
        action: SnackBarAction(
          label: 'Complete Later',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
