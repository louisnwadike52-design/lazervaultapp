import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';

import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/phone_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_settings_screen.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/presentation/view/device_permissions_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_settings_tile.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/country_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/currency_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:lazervault/src/features/settings/presentation/view/card_settings_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/contact_us_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/help_support_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/privacy_policy_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/terms_conditions_screen.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/view/download_statements_screen.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/screens/per_service_voice_settings_screen.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';

/// Settings hub — single-page accordion. One section open at a time.
///
/// Toggles that hit the backend (push/email/SMS notifications, dark mode,
/// language/currency/country) render INLINE inside their accordion body so
/// the user never leaves this screen for a one-tap change. Multi-step
/// flows (password change, passcode change, transaction PIN, 2FA setup,
/// KYC, banking channels, statements) still navigate.
///
/// Dead rows (Trusted Devices, in-app categories, Data Sharing,
/// Marketing/Analytics opt-in) are feature-flagged off at the top of the
/// file so a single boolean flip re-enables them when the backend lands.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Re-use the global ProfileCubit so verification screens that update
    // the user object are immediately reflected here.
    return const _SettingsView();
  }
}

// ============================================================
// Feature flags — flip when the backend RPCs land. Each row is
// wrapped in `if (_kXxxEnabled)` so the section visually disappears
// without leaving a half-wired tile that pretends to work.
// ============================================================
const bool _kTrustedDevicesEnabled = false; // no rpc
const bool _kLoginActivityEnabled = false; // no rpc
const bool _kDataSharingEnabled = false; // no rpc
const bool _kMarketingOptInEnabled = false; // no rpc
const bool _kAnalyticsOptInEnabled = false; // no rpc
const bool _kInAppCategoriesEnabled = false; // no rpc
const bool _kCardSettingsEnabled = false; // cards feature is off

// Brand colours used throughout the accordion. Kept here so a future
// theme migration can replace them in one place.
const Color _kBrand = Color(0xFF4834D4);
const Color _kAccent = Color(0xFF4E03D0); // legacy brand purple
const Color _kBg = Color(0xFFF9FAFB);
const Color _kCard = Colors.white;
const Color _kTextPrimary = Color(0xFF1F2937);
const Color _kTextSecondary = Color(0xFF6B7280);
const Color _kDivider = Color(0xFFE5E7EB);

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  /// Index of the currently expanded section; -1 = all collapsed.
  /// Tracked in state so opening one section closes its siblings (matches
  /// iOS-Settings behaviour and prevents a tall scroll soup).
  int _expandedIndex = -1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProfileCubit>().getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBg,
      body: Column(
        children: [
          ThemedAppBar(
            title: 'Settings',
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
            ),
          ),
          Expanded(
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: _onProfileState,
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: LazerVaultLoader.small());
                }
                return _buildScroll(state);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onProfileState(BuildContext context, ProfileState state) {
    if (state is ProfileError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } else if (state is PreferencesUpdateSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preferences updated'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      context.read<ProfileCubit>().getUserProfile();
    } else if (state is PasswordUpdateSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    }
  }

  Widget _buildScroll(ProfileState state) {
    // Build the sections list once so indices stay stable for
    // _expandedIndex bookkeeping. Profile (the rich header card) is NOT
    // an accordion — it sits permanently at the top.
    final sections = _sections(state);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          _buildProfileHeader(state),
          SizedBox(height: 16.h),
          for (var i = 0; i < sections.length; i++) ...[
            _AccordionSection(
              key: ValueKey('section-$i-${sections[i].title}'),
              icon: sections[i].icon,
              title: sections[i].title,
              subtitle: sections[i].subtitle,
              expanded: _expandedIndex == i,
              onTap: () => setState(() {
                _expandedIndex = _expandedIndex == i ? -1 : i;
              }),
              child: sections[i].body,
            ),
            SizedBox(height: 12.h),
          ],
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  List<_SectionSpec> _sections(ProfileState state) {
    return [
      _SectionSpec(
        title: 'Verification & Limits',
        icon: Icons.verified_user_outlined,
        body: _verificationBody(),
      ),
      _SectionSpec(
        title: 'Security',
        icon: Icons.security_outlined,
        body: _securityBody(),
      ),
      _SectionSpec(
        title: 'Regional',
        icon: Icons.public_outlined,
        body: _regionalBody(state),
      ),
      _SectionSpec(
        title: 'Notifications & Display',
        icon: Icons.tune_outlined,
        body: _notificationsBody(state),
      ),
      _SectionSpec(
        title: 'Voice & Chat Assistant',
        icon: Icons.record_voice_over_outlined,
        subtitle: 'Saved on this device only',
        body: _voiceAssistantBody(),
      ),
      _SectionSpec(
        title: 'Statements & Data',
        icon: Icons.description_outlined,
        body: _statementsBody(),
      ),
      _SectionSpec(
        title: 'Help & Support',
        icon: Icons.help_outline,
        body: _helpBody(),
      ),
    ];
  }

  // ===== Profile header (always visible — not an accordion) =====

  Widget _buildProfileHeader(ProfileState state) {
    final user = state is ProfileLoaded ? state.user : null;
    final fullName =
        user != null ? '${user.firstName} ${user.lastName}' : 'Loading...';
    final email = user?.email ?? '';
    final username = user?.username;
    final profilePicture = user?.profilePicture;
    final isUploading = state is ProfilePictureUploading;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: user == null || isUploading
                      ? null
                      : () => _showProfilePictureSheet(profilePicture),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      UserAvatar(
                        size: 64.w,
                        imageUrl: profilePicture,
                        firstName: user?.firstName,
                        lastName: user?.lastName,
                        fallbackMode: UserAvatarFallback.initials,
                        borderColor: _kAccent.withValues(alpha: 0.2),
                        borderWidth: 3,
                      ),
                      if (isUploading)
                        Container(
                          width: 64.w,
                          height: 64.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withValues(alpha: 0.45),
                          ),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 20.w,
                            height: 20.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                        )
                      else
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 22.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _kAccent,
                              border:
                                  Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(Icons.camera_alt_rounded,
                                size: 11.sp, color: Colors.white),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: GoogleFonts.inter(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: _kTextPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      if (username != null && username.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: _kAccent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            '@$username',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: _kAccent,
                            ),
                          ),
                        )
                      else
                        GestureDetector(
                          onTap: () => _showEditProfileDialog(user),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '+ Add username',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.amber[800],
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 4.h),
                      Text(
                        email,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: _kTextSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showEditProfileDialog(user),
                  icon: Container(
                    padding: EdgeInsets.all(7.w),
                    decoration: BoxDecoration(
                      color: _kAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(Icons.edit_outlined,
                        size: 16.sp, color: _kAccent),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ===== Accordion bodies =====

  Widget _verificationBody() {
    // The KYC tile owns its own cubit + dialog flow; bringing the matrix
    // inline would double the network calls. Tap-through is intentional.
    return BlocProvider(
      create: (_) => serviceLocator<KYCCubit>(),
      child: const KYCSettingsTile(),
    );
  }

  Widget _securityBody() {
    return Column(
      children: [
        _navTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your account password',
          onTap: () {
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: context.read<ProfileCubit>(),
                child: const ChangePasswordDialog(),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.pin_outlined,
          title: 'Passcode',
          subtitle: 'Set up or change your 6-digit login passcode',
          onTap: () {
            // Unified flow: setup if the user has no passcode yet,
            // change otherwise. Server tells us via ProfileLoaded.user
            // (hasPasscode flag is plumbed through login response).
            final state = context.read<ProfileCubit>().state;
            final hasPasscode =
                state is ProfileLoaded ? state.user.hasPasscode : false;
            Get.toNamed(
              AppRoutes.passcodeFlow,
              arguments: {
                'mode': hasPasscode ? 'change' : 'setup',
              },
            );
          },
        ),
        _navTile(
          icon: Icons.lock_clock_outlined,
          title: 'Transaction PIN',
          subtitle: 'Set or change your 4-digit payment PIN',
          onTap: () => Get.toNamed(AppRoutes.pinManagement),
        ),
        _navTile(
          icon: Icons.swap_horiz_rounded,
          title: 'Banking Channels',
          subtitle: 'Manage WhatsApp, phone & SMS banking',
          onTap: () => Get.toNamed(AppRoutes.channelManagement),
        ),
        _navTile(
          icon: Icons.fingerprint,
          title: 'Biometric Login',
          subtitle: 'Use fingerprint or Face ID to unlock',
          onTap: () => Get.toNamed(AppRoutes.setFingerPrint),
        ),
        _navTile(
          icon: Icons.email_outlined,
          title: 'Verify Email',
          subtitle: 'Verify the email on your account',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) =>
                      serviceLocator<EmailVerificationCubit>(),
                  child: const EmailVerificationScreen(),
                ),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.phone_android_outlined,
          title: 'Verify Phone Number',
          subtitle: 'Verify your phone number',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) =>
                      serviceLocator<PhoneVerificationCubit>(),
                  child: const PhoneVerificationScreen(),
                ),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.vpn_key_outlined,
          title: 'Two-Factor Authentication',
          subtitle: 'Manage TOTP / SMS / email 2FA',
          onTap: () {
            // Pass the existing AuthenticationCubit through — the 2FA
            // settings screen reads `currentProfile` from it for the
            // user id used in EnableTwoFactor.
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<AuthenticationCubit>(),
                  child: const TwoFactorSettingsScreen(),
                ),
              ),
            );
          },
        ),
        if (_kTrustedDevicesEnabled)
          _navTile(
            icon: Icons.devices_outlined,
            title: 'Trusted Devices',
            subtitle: 'Manage devices with access to your account',
            onTap: () {},
          ),
        if (_kLoginActivityEnabled)
          _navTile(
            icon: Icons.history_outlined,
            title: 'Login Activity',
            subtitle: 'Review recent sign-ins',
            onTap: () {},
          ),
        _navTile(
          icon: Icons.admin_panel_settings_outlined,
          title: 'Device Permissions',
          subtitle: 'Camera, mic and contacts access',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => serviceLocator<IdentityCubit>(),
                  child: const DevicePermissionsScreen(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _regionalBody(ProfileState state) {
    // NOTE: the app LANGUAGE picker was removed from Settings — language is now
    // chosen ONLY in "Voice & Languages" (single source of truth), so the two
    // pickers can't conflict.
    final country = state is ProfileLoaded
        ? state.user.country ?? 'United Kingdom'
        : 'United Kingdom';
    final currencySync = serviceLocator<CurrencySyncService>();

    return Column(
      children: [
        _navTile(
          icon: Icons.location_on_outlined,
          title: 'Country',
          subtitle: country,
          onTap: () {
            final currentCountry = state is ProfileLoaded
                ? (state.user.country ?? 'United Kingdom')
                : 'United Kingdom';
            final currentCurrency = state is ProfileLoaded
                ? (state.user.currency ?? 'GBP')
                : 'GBP';
            showDialog<String>(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: context.read<ProfileCubit>(),
                child: CountryPickerDialog(
                  currentCountry: currentCountry,
                  currentCurrency: currentCurrency,
                ),
              ),
            ).then((countryCode) {
              if (!mounted) return;
              if (countryCode == null || countryCode.isEmpty) return;
              final profileState = context.read<ProfileCubit>().state;
              if (profileState is ProfileLoaded) {
                context
                    .read<AccountCardsSummaryCubit>()
                    .fetchAccountSummaries(
                      userId: profileState.user.id,
                      country: countryCode,
                    );
              }
            });
          },
        ),
        StreamBuilder<String>(
          stream: currencySync.currencyStream,
          initialData: currencySync.currentCurrency,
          builder: (context, snapshot) {
            final currentCurrency = snapshot.data ?? 'USD';
            return _navTile(
              icon: Icons.attach_money_outlined,
              title: 'Currency',
              subtitle: currentCurrency,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: CurrencyPickerDialog(
                        currentCurrency: currentCurrency),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _notificationsBody(ProfileState state) {
    final push =
        state is ProfileLoaded ? state.preferences.pushNotifications : true;
    final email =
        state is ProfileLoaded ? state.preferences.emailNotifications : true;
    final sms =
        state is ProfileLoaded ? state.preferences.smsNotifications : false;
    final dark =
        state is ProfileLoaded ? state.preferences.darkMode : false;

    void update({
      bool? push,
      bool? email,
      bool? sms,
      bool? dark,
    }) {
      // Single chokepoint into ProfileCubit.updatePreferences →
      // UpdatePreferences RPC → user_preferences row write. Each toggle
      // is a real persisted change.
      context.read<ProfileCubit>().updatePreferences(
            pushNotifications: push,
            emailNotifications: email,
            smsNotifications: sms,
            darkMode: dark,
          );
    }

    return Column(
      children: [
        _switchTile(
          icon: Icons.notifications_outlined,
          title: 'Push Notifications',
          subtitle: 'Transaction alerts and updates',
          value: push,
          onChanged: (v) => update(push: v),
        ),
        _switchTile(
          icon: Icons.email_outlined,
          title: 'Email Notifications',
          subtitle: 'Receive updates via email',
          value: email,
          onChanged: (v) => update(email: v),
        ),
        _switchTile(
          icon: Icons.sms_outlined,
          title: 'SMS Notifications',
          subtitle: 'Receive updates via SMS',
          value: sms,
          onChanged: (v) => update(sms: v),
        ),
        _switchTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          subtitle: 'Use the dark theme',
          value: dark,
          onChanged: (v) => update(dark: v),
        ),
        if (_kInAppCategoriesEnabled)
          _navTile(
            icon: Icons.category_outlined,
            title: 'In-App Notifications',
            subtitle: 'Choose which categories to receive',
            onTap: () {},
          ),
        if (_kCardSettingsEnabled)
          _navTile(
            icon: Icons.card_membership_outlined,
            title: 'Card Settings',
            subtitle: 'Manage your cards',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CardSettingsScreen(),
                ),
              );
            },
          ),
        if (_kDataSharingEnabled)
          _switchTile(
            icon: Icons.share_outlined,
            title: 'Data Sharing',
            subtitle: 'Share aggregate usage with partners',
            value: false,
            onChanged: (_) {},
          ),
        if (_kMarketingOptInEnabled)
          _switchTile(
            icon: Icons.campaign_outlined,
            title: 'Marketing emails',
            subtitle: 'Promotions and product news',
            value: false,
            onChanged: (_) {},
          ),
        if (_kAnalyticsOptInEnabled)
          _switchTile(
            icon: Icons.analytics_outlined,
            title: 'Analytics',
            subtitle: 'Help us improve the app',
            value: false,
            onChanged: (_) {},
          ),
      ],
    );
  }

  Widget _voiceAssistantBody() {
    const services = <_VoiceServiceTile>[
      _VoiceServiceTile(
          slug: 'transfers',
          label: 'Transfers',
          icon: Icons.swap_horiz_rounded),
      _VoiceServiceTile(
          slug: 'crypto',
          label: 'Crypto',
          icon: Icons.currency_bitcoin),
      _VoiceServiceTile(
          slug: 'exchange',
          label: 'Currency Exchange',
          icon: Icons.swap_calls_rounded),
      _VoiceServiceTile(
          slug: 'insurance',
          label: 'Insurance',
          icon: Icons.shield_outlined),
      _VoiceServiceTile(
          slug: 'expenses',
          label: 'Expenses',
          icon: Icons.receipt_long_outlined),
      _VoiceServiceTile(
          slug: 'business',
          label: 'Business',
          icon: Icons.business_center_outlined),
      _VoiceServiceTile(
          slug: 'investments',
          label: 'Investments',
          icon: Icons.trending_up_rounded),
      _VoiceServiceTile(
          slug: 'banking',
          label: 'Banking',
          icon: Icons.account_balance_outlined),
    ];
    return Column(
      children: [
        for (final s in services)
          _navTile(
            icon: s.icon,
            title: s.label,
            subtitle: 'Language, voice and prompt hints',
            onTap: () => _openVoiceSettingsFor(s.slug),
          ),
      ],
    );
  }

  Widget _statementsBody() {
    return Column(
      children: [
        _navTile(
          icon: Icons.download_outlined,
          title: 'Download Statements',
          subtitle: 'Export PDF/CSV transaction history',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => serviceLocator<StatementCubit>(),
                    ),
                    BlocProvider(
                      create: (_) =>
                          serviceLocator<AccountCardsSummaryCubit>(),
                    ),
                  ],
                  child: const DownloadStatementsScreen(),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _helpBody() {
    return Column(
      children: [
        _navTile(
          icon: Icons.chat_bubble_outline,
          title: 'Help & Support',
          subtitle: 'Submit a support ticket',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const HelpSupportScreen(),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.mail_outline,
          title: 'Contact Us',
          subtitle: 'Get in touch with our team',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ContactUsScreen(),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          subtitle: 'Read our terms of service',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const TermsConditionsScreen(),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Learn how we protect your data',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const PrivacyPolicyScreen(),
              ),
            );
          },
        ),
        _navTile(
          icon: Icons.info_outline,
          title: 'About LazerVault',
          subtitle: 'Version 1.0.0',
          onTap: _showAboutDialog,
        ),
      ],
    );
  }

  // ===== Profile picture sheet (kept inline so we don't ship a new file) =====

  void _showEditProfileDialog(user) {
    if (user == null) return;
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: EditProfileDialog(user: user),
      ),
    ).then((_) {
      if (!mounted) return;
      context.read<ProfileCubit>().getUserProfile();
    });
  }

  void _showProfilePictureSheet(String? currentPicture) {
    final cubit = context.read<ProfileCubit>();
    final hasPicture = currentPicture != null && currentPicture.isNotEmpty;

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    'Profile picture',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: _kTextPrimary,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                _pictureOption(
                  icon: Icons.camera_alt_outlined,
                  title: 'Take Photo',
                  subtitle: 'Use the camera to snap a new picture',
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _pickAndUpload(cubit, ImageSource.camera);
                  },
                ),
                _pictureOption(
                  icon: Icons.photo_library_outlined,
                  title: 'Choose from Gallery',
                  subtitle: 'Pick an image from your photos',
                  onTap: () async {
                    Navigator.pop(sheetContext);
                    await _pickAndUpload(cubit, ImageSource.gallery);
                  },
                ),
                if (hasPicture)
                  _pictureOption(
                    icon: Icons.delete_outline,
                    title: 'Remove Photo',
                    subtitle:
                        'Show your initials on a brand-purple background',
                    onTap: () async {
                      Navigator.pop(sheetContext);
                      await cubit.removeProfilePicture();
                    },
                    destructive: true,
                  ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TextButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _kTextSecondary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pictureOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool destructive = false,
  }) {
    final color = destructive ? const Color(0xFFEF4444) : _kAccent;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.1),
                ),
                child: Icon(icon, size: 22.sp, color: color),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: destructive ? color : _kTextPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: _kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickAndUpload(
      ProfileCubit cubit, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final picked = await picker.pickImage(
        source: source,
        imageQuality: 90,
        maxWidth: 1024,
        maxHeight: 1024,
      );
      if (picked == null) return;
      final bytes = await picked.readAsBytes();
      await cubit.uploadProfilePicture(
        bytes: bytes,
        filename: picked.name,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open image picker: $e'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _openVoiceSettingsFor(String serviceName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PerServiceVoiceSettingsCubit>(
          create: (_) {
            final cubit = PerServiceVoiceSettingsCubit(
              serviceName: serviceName,
              storage: SharedPrefsPerServiceVoiceSettingsStorage(),
            );
            cubit.load();
            return cubit;
          },
          child: PerServiceVoiceSettingsScreen(serviceName: serviceName),
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Column(
          children: [
            Icon(Icons.account_balance_wallet,
                size: 48.sp, color: _kAccent),
            SizedBox(height: 12.h),
            Text('LazerVault',
                style: GoogleFonts.inter(
                    fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Version 1.0.0',
                style: GoogleFonts.inter(
                    fontSize: 14.sp, color: _kTextSecondary)),
            SizedBox(height: 16.h),
            Text(
              'Your trusted financial companion for seamless transactions and secure digital banking.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: _kTextPrimary,
                height: 1.5,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Close',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: _kAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===== Tiny tile helpers used inside accordion bodies =====

  Widget _navTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return _SettingsRow(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      trailing: Icon(Icons.arrow_forward_ios,
          size: 14.sp, color: const Color(0xFF9CA3AF)),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return _SettingsRow(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: _kBrand,
      ),
    );
  }

}

// ============================================================
// Helper widgets
// ============================================================

class _SectionSpec {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget body;
  _SectionSpec({
    required this.title,
    required this.icon,
    required this.body,
    this.subtitle,
  });
}

/// One accordion card. We don't use Flutter's stock `ExpansionTile`
/// because its theming hooks for splash/divider/chevron colour are
/// awkward to override consistently. Instead we render a simple
/// header + `AnimatedSize` body — 250ms ease-out matches the design.
class _AccordionSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool expanded;
  final VoidCallback onTap;
  final Widget child;

  const _AccordionSection({
    super.key,
    required this.icon,
    required this.title,
    required this.expanded,
    required this.onTap,
    required this.child,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: _kBrand.withValues(alpha: 0.1),
              highlightColor: _kBrand.withValues(alpha: 0.05),
              onTap: onTap,
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: _kAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(icon, size: 20.sp, color: _kAccent),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: GoogleFonts.inter(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                              color: _kTextPrimary,
                            ),
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: 2.h),
                            Text(
                              subtitle!,
                              style: GoogleFonts.inter(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w400,
                                color: _kTextSecondary,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Chevron rotates 180° when expanded. The brand
                    // colour pops vs the default Material grey arrow.
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOut,
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: _kBrand,
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Smooth open/close via AnimatedSize. `clipBehavior: hardEdge`
          // on the outer card keeps the bottom rounded corners clean.
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            alignment: Alignment.topCenter,
            child: expanded
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Divider(
                          height: 1, thickness: 1, color: _kDivider),
                      child,
                      SizedBox(height: 4.h),
                    ],
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
        ],
      ),
    );
  }
}

/// A single tappable row inside an accordion body. Public surface is
/// trivial — `onTap` may be null for switch rows where the trailing
/// widget already owns the gesture.
class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: _kAccent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(icon, size: 18.sp, color: _kAccent),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _kTextPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: _kTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}

class _VoiceServiceTile {
  final String slug;
  final String label;
  final IconData icon;
  const _VoiceServiceTile({
    required this.slug,
    required this.label,
    required this.icon,
  });
}
