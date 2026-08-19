import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/onboarding/dashboard_walkthrough.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/presentation/views/notification_screen.dart';
import 'package:lazervault/src/features/notifications/presentation/cubit/notification_badge_cubit.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/country_locale_bottom_sheet.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_cubit.dart';

// Dashboard header with notifications bottomsheet - clean white background
class DashboardHeader extends StatefulWidget {
  final User? currentUser; // Accept optional user data

  const DashboardHeader({super.key, this.currentUser});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  /// Drives the continuous "breathing" glow/halo around the voice mic icon, so
  /// users always notice there's an AI assistant they can talk to.
  AnimationController? _voiceGlowController;
  // Guards the async gap between tapping the mic and the sheet opening, so a
  // rapid double-tap can't launch the voice command sheet twice.
  bool _voiceSheetOpening = false;

  @override
  void initState() {
    super.initState();
    // Continuous pulsing glow around the voice mic so users notice the AI
    // assistant. A faster ~0.7s blink (≈1.4s full cycle) clearly draws the eye;
    // the halo never fully disappears (base > 0) so the icon always looks alive.
    // Driven by a single lightweight AnimatedBuilder.
    _voiceGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    // Kick it off after first frame so the dashboard is visible, then loop.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _voiceGlowController?.repeat(reverse: true);
    });
    // Load the unread-notifications count so the bell badge reflects the
    // server the moment the dashboard paints.
    WidgetsBinding.instance.addObserver(this);
    serviceLocator<NotificationBadgeCubit>().refresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _voiceGlowController?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-sync the bell badge when the app returns to the foreground — a push
    // may have arrived (or notifications been read elsewhere) while backgrounded.
    if (state == AppLifecycleState.resumed) {
      serviceLocator<NotificationBadgeCubit>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Drive the avatar reactively from AuthenticationCubit so that an
    // upload from Settings refreshes the dashboard immediately (without
    // having to re-mount the dashboard). The cubit also receives the
    // initial render via the [currentUser] prop passed by the parent —
    // BlocBuilder takes over on subsequent emissions.
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      buildWhen: (prev, next) =>
          next is AuthenticationSuccess ||
          next is AuthenticationAuthenticated ||
          prev is AuthenticationSuccess ||
          prev is AuthenticationAuthenticated,
      builder: (context, authState) {
        User? user = widget.currentUser;
        if (authState is AuthenticationSuccess) {
          user = authState.profile.user;
        } else if (authState is AuthenticationAuthenticated) {
          user = authState.profile.user;
        }

        return Row(
          children: [
            // Profile Picture - tap opens the app drawer. The profile-picture
            // actions (view full screen / change photo / account / settings)
            // live on the avatar INSIDE the drawer. Renders brand-purple
            // initials when no picture is set.
            DashboardWalkthrough.step(
              key: DashboardWalkthrough.avatarKey,
              title: 'Your profile',
              body:
                  'Tap your photo to open your profile — update your picture, reach settings and support.',
              child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                // Frosted circle to match the notification / mic / settings
                // icon buttons on this purple top bar — a subtle white ring +
                // frosted fill, not a heavy drop-shadow "sticker".
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.25),
                    width: 1.2,
                  ),
                ),
                child: UserAvatar(
                  size: 28.w,
                  imageUrl: user?.profilePicture,
                  firstName: user?.firstName,
                  lastName: user?.lastName,
                  fallbackMode: UserAvatarFallback.initials,
                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
            ),
            Spacer(),
            // Country Selector (the locale dropdown — single source for the
            // active region/currency; the separate currency badge that sat here
            // was redundant with it and was removed).
            _buildCountrySelector(context),
            SizedBox(width: 8.w),
            // Action Icons
            DashboardWalkthrough.step(
              key: DashboardWalkthrough.topIconsKey,
              title: 'Quick access',
              body:
                  'Your voice assistant, notifications and settings all live up here.',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildIconButton(Icons.notifications_outlined, context),
                  SizedBox(width: 8.w),
                  _buildIconButton(Icons.mic_rounded, context),
                  SizedBox(width: 8.w),
                  _buildIconButton(Icons.settings_outlined, context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCountrySelector(BuildContext context) {
    // Use LocaleManager stream for reactive updates
    final localeManager = serviceLocator<LocaleManager>();

    return StreamBuilder<String>(
      stream: localeManager.countryStream,
      initialData: localeManager.currentCountry,
      builder: (context, snapshot) {
        final currentCountry = snapshot.data ?? 'NG';
        final countryLocale = CountryLocales.findByCountryCode(currentCountry);

        return InkWell(
          onTap: () async {
            // Show bottom sheet to select country
            final selectedCountry = await CountryLocaleBottomSheet.show(
              context,
              selectedCountryCode: currentCountry,
            );

            if (selectedCountry != null) {
              // Update locale in LocaleManager (app-wide) — also auto-derives currency
              localeManager.updateLocale(
                locale: selectedCountry.locale,
                country: selectedCountry.countryCode,
              );

              // Update preferences in ProfileCubit
              await context.read<ProfileCubit>().setActiveCountry(
                selectedCountry.countryCode,
              );

              // Update active locale on the server via MultiCountryCubit
              if (context.mounted) {
                context.read<MultiCountryCubit>().setActiveLocale(
                  selectedCountry.locale,
                );
              }

              if (!context.mounted) return;

              // Refresh account data for the new country
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is AuthenticationSuccess) {
                final userId = authState.profile.user.id;
                final accessToken = authState.profile.session.accessToken;

                // Fetch accounts for the newly-selected locale in the BACKGROUND
                // (silent: no loading spinner). Keeping the current cards on screen
                // until the new-locale balances arrive lets the CompactAnimatedBalance
                // flip-counter roll to the updated values instead of flashing a
                // loader — the same auto-refresh+animate behaviour as on login.
                await context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                  userId: userId,
                  accessToken: accessToken,
                  country: selectedCountry.countryCode,
                  silent: true,
                );

                // Check if we got any accounts
                final currentState = context.read<AccountCardsSummaryCubit>().state;
                if (currentState is AccountCardsSummaryLoaded &&
                    currentState.accountSummaries.isEmpty) {
                  print('No accounts found for country: ${selectedCountry.countryCode}');
                }
              }
            }
          },
          child: Container(
            height: 32.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  countryLocale?.flag ?? _getCountryFlag(currentCountry),
                  style: TextStyle(fontSize: 14.sp),
                ),
                SizedBox(width: 6.w),
                Text(
                  currentCountry,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 2.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getCountryFlag(String countryCode) {
    final flags = {
      'US': '🇺🇸',
      'GB': '🇬🇧',
      'EU': '🇪🇺',
      'CA': '🇨🇦',
      'AU': '🇦🇺',
      'NG': '🇳🇬',
      'KE': '🇰🇪',
      'ZA': '🇿🇦',
      'IN': '🇮🇳',
      'CN': '🇨🇳',
      'JP': '🇯🇵',
      'FR': '🇫🇷',
      'DE': '🇩🇪',
      'ES': '🇪🇸',
      'IT': '🇮🇹',
    };
    return flags[countryCode] ?? '🌍';
  }

  Widget _buildIconButton(IconData icon, BuildContext context) {
    final button = Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 16.sp),
        onPressed: () {
          if (icon == Icons.notifications_outlined) {
            _showNotifications(context);
          } else if (icon == Icons.mic_rounded) {
            _showVoiceCommandSheet(context);
          } else if (icon == Icons.settings_outlined) {
            Get.toNamed(AppRoutes.profileSettings);
          }
        },
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );

    // The voice mic icon gets a continuous, gentle glowing "breathe" so users
    // always know there's an AI assistant available. The icon stays fully
    // functional (the IconButton above is untouched) — we just wrap it in a
    // softly pulsing halo.
    if (icon == Icons.mic_rounded && _voiceGlowController != null) {
      return _buildVoiceGlow(button);
    }
    // The notification bell gets an unread-count badge at its top-right, driven
    // by the app-wide NotificationBadgeCubit.
    if (icon == Icons.notifications_outlined) {
      return _buildBellWithBadge(button);
    }
    return button;
  }

  /// Overlays a live unread-count badge on the notification bell. Hidden when
  /// the count is zero; caps the label at "99+". The badge carries a purple
  /// ring so it reads clearly against the purple top bar.
  Widget _buildBellWithBadge(Widget bell) {
    return BlocBuilder<NotificationBadgeCubit, int>(
      bloc: serviceLocator<NotificationBadgeCubit>(),
      builder: (context, count) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            bell,
            if (count > 0)
              Positioned(
                top: -4.h,
                right: -4.w,
                child: Container(
                  constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: const Color(0xFF4E03D0), width: 1.5),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Wraps the voice mic button in a soft, continuously pulsing brand-purple
  /// halo (see initState). The glow "breathes" between a faint base and a
  /// brighter peak and never fully disappears, so the AI indicator always looks
  /// alive.
  Widget _buildVoiceGlow(Widget child) {
    const glowColor = Color(0xFF7C5CFF); // bright voice accent purple
    final controller = _voiceGlowController!;
    return AnimatedBuilder(
      animation: controller,
      builder: (context, inner) {
        // Gentle ease, value 0..1..0 from repeat(reverse).
        final t = Curves.easeInOut.transform(controller.value);
        // Base + pulse so the halo is always visible (never 0) and breathes,
        // but the BRIGHT blink is now much brighter (peak alpha 1.0) with a tight
        // bright core that flares, plus a subtle grow — so it really catches the eye.
        final spread = 1.5 + (5.0 * t); // 1.5 → 6.5
        final blur = 8.0 + (18.0 * t); // 8 → 26
        final scale = 1.0 + (0.07 * t); // subtle grow on the bright blink
        return Transform.scale(
          scale: scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                // Wide soft halo — far brighter at the peak than before.
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.30 + (0.70 * t)), // 0.30 → 1.0
                  blurRadius: blur,
                  spreadRadius: spread,
                ),
                // Tight bright core that flares on the bright blink for punch.
                BoxShadow(
                  color: glowColor.withValues(alpha: 0.55 * t), // 0 → 0.55
                  blurRadius: 4.0 + (6.0 * t),
                  spreadRadius: 0.5 + (1.5 * t),
                ),
              ],
            ),
            child: inner,
          ),
        );
      },
      child: child,
    );
  }

  void _showNotifications(BuildContext context) {
     Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.9,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              const Expanded(
                child: NotificationScreen(),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );
  }

  void _showVoiceCommandSheet(BuildContext context) async {
    // Double-tap / re-entrancy guard: ignore if we're already opening the sheet
    // or a bottom sheet is already on screen.
    if (_voiceSheetOpening || (Get.isBottomSheetOpen ?? false)) return;
    _voiceSheetOpening = true;
    try {
      await _showVoiceCommandSheetInner(context);
    } finally {
      _voiceSheetOpening = false;
    }
  }

  Future<void> _showVoiceCommandSheetInner(BuildContext context) async {
    final activationManager = VoiceActivationManager();

    // Check if voice service is available first
    final isAvailable = await activationManager.isServiceAvailable();
    if (!isAvailable) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The voice assistant is currently turned off. Please use chat instead.',
            style: GoogleFonts.inter(fontSize: 13),
          ),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    // Get user ID from auth state
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    final userId = authState.profile.userId;

    // Classify the enrollment check. An outage / timeout / 5xx must NEVER fall
    // through to the "set up voice" prompt for an already-enrolled user — that
    // shows the shared temporarily-unavailable modal instead (with Retry).
    while (true) {
      final outcome = await activationManager.checkEnrollmentOutcome(userId);
      if (!context.mounted) return;

      if (outcome == VoiceEnrollmentCheck.unavailable) {
        final retry =
            await VoiceActivationManager.showVoiceUnavailableModal(context);
        if (retry && context.mounted) {
          continue; // re-check (unavailable was never cached)
        }
        return;
      }

      if (outcome == VoiceEnrollmentCheck.notEnrolled) {
        // DEFINITIVE not-enrolled → the enrollment prompt is correct here.
        final activated = await activationManager.activateVoice(
          context,
          userId,
        );
        if (!activated || !context.mounted) return;
      }
      break; // enrolled, or enrollment just completed
    }

    // Only open the bottom sheet after enrollment is confirmed.
    // The sheet self-sizes via DraggableScrollableSheet (90% → full screen),
    // so no fixed FractionallySizedBox wrapper here.
    Get.bottomSheet(
      VoiceCommandSheet(skipActivationCheck: true),
      isScrollControlled: true,
      enableDrag: false,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }
} 