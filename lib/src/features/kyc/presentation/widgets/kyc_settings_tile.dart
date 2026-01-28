import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/views/progressive_kyc_screen.dart';

/// KYC Settings Tile Widget
/// Shows verification status and allows users to complete KYC
class KYCSettingsTile extends StatefulWidget {
  const KYCSettingsTile({super.key});

  @override
  State<KYCSettingsTile> createState() => _KYCSettingsTileState();
}

class _KYCSettingsTileState extends State<KYCSettingsTile> {
  @override
  void initState() {
    super.initState();
    // Load KYC status when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KYCCubit>().getKYCStatus('current_user_id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KYCCubit, KYCState>(
      builder: (context, state) {
        KYCTier tier = KYCTier.unknown;
        KYCStatus status = KYCStatus.notStarted;

        if (state is KYCStatusLoaded) {
          tier = state.profile.currentTier;
          status = state.profile.status;
        } else if (state is IDVerificationSuccess) {
          tier = state.response.currentTier;
          status = state.response.status;
        }

        return _buildListTile(
          context,
          title: 'Identity Verification',
          imagePath: 'assets/images/profile/verification.png',
          color: status == KYCStatus.approved
              ? '#4CAF50'
              : '#FF9800',
          tier: tier,
          status: status,
          onTap: () {
            Get.toNamed(ProgressiveKYCScreen.route);
          },
        );
      },
    );
  }

  Widget _buildListTile(
    BuildContext context, {
    required String title,
    required String imagePath,
    required String color,
    required KYCTier tier,
    required KYCStatus status,
    VoidCallback? onTap,
  }) {
    final responsiveController = ResponsiveController(context);

    return Row(
      children: [
        Stack(
          children: [
            RoundedCenteredImage(
              size: responsiveController.isMobile ? 40.w : 48.0,
              backgroundColor: HybridHexColor.fromHex(color),
              imagePath: imagePath,
            ),
            if (status == KYCStatus.approved)
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: responsiveController.isMobile ? 20.w : 24.0,
                  ),
                ),
              ),
          ],
        ),
        Expanded(
          child: ListTile(
            onTap: onTap,
            title: Text(title),
            subtitle: Text(
              _getStatusText(tier, status),
              style: TextStyle(
                color: _getStatusColor(status),
                fontSize: responsiveController.isMobile ? 12.sp : 14,
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatusBadge(tier, status),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(KYCTier tier, KYCStatus status) {
    final String badgeText;
    final Color badgeColor;

    if (status == KYCStatus.approved) {
      badgeText = 'Tier ${tier.index}';
      badgeColor = const Color(0xFF4CAF50);
    } else if (status == KYCStatus.inProgress ||
        status == KYCStatus.pendingReview) {
      badgeText = 'Pending';
      badgeColor = const Color(0xFFFF9800);
    } else if (status == KYCStatus.rejected) {
      badgeText = 'Failed';
      badgeColor = const Color(0xFFF44336);
    } else {
      badgeText = 'Tier ${tier.index}';
      badgeColor = const Color(0xFF9E9E9E);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: badgeColor, width: 1),
      ),
      child: Text(
        badgeText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _getStatusText(KYCTier tier, KYCStatus status) {
    switch (status) {
      case KYCStatus.approved:
        return 'Verified - Tier ${tier.index} Account';
      case KYCStatus.inProgress:
        return 'Verification in progress...';
      case KYCStatus.pendingReview:
        return 'Pending review';
      case KYCStatus.rejected:
        return 'Verification failed - Try again';
      case KYCStatus.expired:
        return 'Verification expired - Update now';
      default:
        if (tier == KYCTier.tier1) {
          return 'Basic account - Upgrade for higher limits';
        }
        return 'Not verified - Complete KYC now';
    }
  }

  Color _getStatusColor(KYCStatus status) {
    switch (status) {
      case KYCStatus.approved:
        return const Color(0xFF4CAF50);
      case KYCStatus.inProgress:
      case KYCStatus.pendingReview:
        return const Color(0xFFFF9800);
      case KYCStatus.rejected:
        return const Color(0xFFF44336);
      case KYCStatus.expired:
        return const Color(0xFFE91E63);
      default:
        return const Color(0xFF9E9E9E);
    }
  }
}
