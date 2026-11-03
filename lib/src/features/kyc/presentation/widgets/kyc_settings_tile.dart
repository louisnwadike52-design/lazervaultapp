import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// KYC Settings Tile Widget
///
/// Shows the user's CURRENT verification standing and routes to the KYC flow.
/// The tier is read from banking-service's Prove status (the source of truth for
/// what the user actually completed) — the SAME source the verification screen
/// uses — so the tile and the detail screen never disagree. It refreshes on
/// return from the flow so a just-completed tier shows immediately.
class KYCSettingsTile extends StatefulWidget {
  const KYCSettingsTile({super.key});

  @override
  State<KYCSettingsTile> createState() => _KYCSettingsTileState();
}

class _KYCSettingsTileState extends State<KYCSettingsTile> {
  late final ProveKycHttpService _prove =
      ProveKycHttpService(serviceLocator<SecureStorageService>());
  ProveKycStatus? _status;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final s = await _prove.status();
      if (mounted) {
        setState(() {
          _status = s;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);
    final tier = _status?.tier ?? 0;
    final verified = _status?.verified ?? false; // Tier 2+
    final isMax = (_status?.isMaxTier) ?? false;

    // Avatar tint: green once verified, amber while basic/unverified.
    final avatarColor = verified ? '#4CAF50' : '#FF9800';

    // Re-read the live tier whenever the auth profile is refreshed (e.g. the
    // KYC flow calls AuthenticationCubit.refreshProfile() on completion, which
    // emits AuthenticationSuccess). This keeps the tile current even when the
    // Settings screen stayed mounted while KYC completed on another route, so
    // it never shows a stale Tier 1 after an upgrade.
    return BlocListener<AuthenticationCubit, AuthenticationState>(
      listenWhen: (_, current) =>
          current is AuthenticationSuccess ||
          current is AuthenticationAuthenticated,
      listener: (_, __) => _load(),
      child:
          _buildTile(responsiveController, tier, verified, isMax, avatarColor),
    );
  }

  Widget _buildTile(
    ResponsiveController responsiveController,
    int tier,
    bool verified,
    bool isMax,
    String avatarColor,
  ) {
    // Left-inset the whole tile so the avatar aligns with the icon column of
    // the other settings sections (which use a 16.w horizontal inset), instead
    // of sitting flush against the accordion card edge.
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 4.w),
      child: Row(
        children: [
          Stack(
            children: [
              RoundedCenteredImage(
                size: responsiveController.isMobile ? 40.w : 48.0,
                backgroundColor: HybridHexColor.fromHex(avatarColor),
                imagePath: 'assets/images/profile/shield-tick.png',
              ),
              if (verified)
                Positioned.fill(
                  child: Align(
                    child: Icon(Icons.check,
                        color: Colors.white,
                        size: responsiveController.isMobile ? 20.w : 24.0),
                  ),
                ),
            ],
          ),
          Expanded(
            child: ListTile(
              onTap: () async {
                await Get.toNamed(AppRoutes.kycBVNVerification);
                // Refresh after the user returns so a new tier reflects at once.
                _load();
              },
              title: const Text('Identity Verification'),
              subtitle: Text(
                kycTileSubtitle(_status),
                style: TextStyle(
                  // Green when done, amber when it needs attention or is
                  // pending — grey reads as "nothing happening here", which
                  // a held verification very much is not.
                  color: kycTileSubtitleIsSettled(_status)
                      ? const Color(0xFF4CAF50)
                      : (_status?.nameUnderReview ?? false) ||
                              (_status?.failureReason.isNotEmpty ?? false)
                          ? const Color(0xFFFF9800)
                          : const Color(0xFF9E9E9E),
                  fontSize: responsiveController.isMobile ? 12.sp : 14,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildBadge(tier, verified),
                  const SizedBox(width: 8),
                  if (_loading)
                    LazerVaultLoader(size: 14)
                  else
                    const Icon(Icons.arrow_forward_ios,
                        size: 16.0, color: Colors.grey),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(int tier, bool verified) {
    final String text = tier <= 0 ? 'Unverified' : 'Tier $tier';
    final Color color = verified
        ? const Color(0xFF4CAF50) // Tier 2+
        : (tier == 1 ? const Color(0xFFFF9800) : const Color(0xFF9E9E9E));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}

/// What this tile says about where the customer stands.
///
/// THE HELD CASE USED TO READ "Tier 1 - add your second ID to raise
/// limits", which is wrong in the way that costs money. That customer has
/// ALREADY finished a verification; it is sitting with a human because the
/// BVN name only partly matched. They have no second ID to add, and doing
/// what the tile told them starts another Mono Prove session — a fresh
/// session fee, landing on the same hold.
///
/// It is also the Settings entry CONTRADICTING the onboarding entry: the
/// verification screen shows the full held state with both names and a way
/// to respond, while Settings said "not verified yet". Same account, same
/// moment, two different stories — the same settings-vs-onboarding
/// divergence that produced the Connect/Prove name-check gap.
///
/// Static and total: every branch returns, and the status carries
/// everything needed, so there is no state this can fail to describe.
String kycTileSubtitle(ProveKycStatus? status) {
  final tier = status?.tier ?? 0;
  final verified = status?.verified ?? false;
  final isMax = status?.isMaxTier ?? false;

  // VERIFIED WINS over any stale failure note. A customer who later earned
  // a tier must never be told their old attempt is under review.
  if (isMax) return 'Fully verified - Tier 3, highest limits';
  if (verified) {
    return 'Verified - Tier $tier. Upgrade to Tier 3 for unlimited limits';
  }

  // Done on their side, waiting on ours. Say so, and do NOT invite a
  // second session.
  if (status?.nameUnderReview ?? false) {
    return status!.nameCorrectionReceived
        ? 'Being reviewed - we have your correction'
        : 'Being reviewed - we will update you shortly';
  }
  switch (status?.failureReason) {
    case 'name_mismatch':
      return 'Couldn\'t verify that BVN - tap to try again';
    case 'cancelled':
      return 'Verification cancelled - tap to finish it';
    case 'expired':
      return 'Verification expired - tap to start again';
  }
  // Still in flight: a session is open and the result has not landed.
  if ((status?.sessionPending ?? false) && tier < 2) {
    return 'Verification in progress';
  }

  if (tier == 1) return 'Tier 1 - add your second ID to raise limits';
  return 'Verify your identity to unlock higher limits';
}

/// Amber while something needs attention or is pending, green once done.
///
/// Grey read as "nothing happening here", which is the one thing a held
/// verification is not.
bool kycTileSubtitleIsSettled(ProveKycStatus? status) =>
    (status?.verified ?? false) || (status?.isMaxTier ?? false);
