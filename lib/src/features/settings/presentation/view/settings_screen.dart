import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/chat_sound_settings.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/panic_balance_service.dart';
import 'package:lazervault/src/features/fraud_detection/data/fraud_detection_service.dart';
import 'package:lazervault/core/services/service_usage_service.dart';
import 'package:lazervault/core/theme/theme_controller.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';

import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/login_method_sheet.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/send_money_options_sheet.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/profile_picture_actions.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/settings_tier_badge.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/set_password_sheet.dart';
import 'package:lazervault/src/features/admin_alerts/admin_alerts_screen.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/phone_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/two_factor_settings_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/help_config_service.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/webview_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/domain/repositories/i_identity_repository.dart';
import 'package:lazervault/src/features/identity/presentation/view/device_permissions_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/trusted_devices_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/delete_account_screen.dart';
import 'package:lazervault/src/features/onboarding/dashboard_walkthrough.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/lock_account_sheet.dart';
import 'package:lazervault/src/features/settings/presentation/view/login_activity_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/kyc_settings_tile.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/country_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/currency_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:lazervault/src/features/settings/presentation/view/biometric_login_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/card_settings_screen.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/panic_balance_settings.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/view/download_statements_screen.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/screens/per_service_voice_settings_screen.dart';
import 'package:lazervault/src/features/voice/widgets/voice_txpin_section.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/birthday_celebration_card.dart';
part 'settings_screen_widgets.dart';


// ============================================================
// Feature flags — flip when the backend RPCs land. Each row is
// wrapped in `if (_kXxxEnabled)` so the section visually disappears
// without leaving a half-wired tile that pretends to work.
// ============================================================
const bool _kTrustedDevicesEnabled = true; // backed by AuthService ListDevices/RevokeDevice
const bool _kLoginActivityEnabled = true; // backed by AuthService GetLoginHistory
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

class _SettingsViewState extends State<_SettingsView> {
  /// Index of the currently expanded section; -1 = all collapsed.
  /// Tracked in state so opening one section closes its siblings (matches
  /// iOS-Settings behaviour and prevents a tall scroll soup).
  int _expandedIndex = -1;

  /// Live settings-search query. When non-empty the accordion filters to
  /// matching sections and auto-expands them so the matched item is revealed.
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  /// Last successfully-loaded profile state. Cached so that a background
  /// ProfileLoading (triggered by a preference toggle) does NOT blank the whole
  /// screen — we keep rendering the loaded content and only show the full-screen
  /// loader on the very first load.
  ProfileLoaded? _lastGood;

  /// Optimistic overrides for the notification switches: a tap flips the switch
  /// instantly (no waiting on the round-trip) while the change persists in the
  /// background. Cleared when the server confirms with a fresh ProfileLoaded.
  bool? _pushOverride;
  bool? _emailOverride;
  bool? _smsOverride;

  /// Admin-configured Help & Support content (contact, terms/privacy/about
  /// links, support materials). Starts from the safe fallback so the section
  /// always renders, then refreshes from the admin endpoint.
  HelpConfig _helpConfig = HelpConfig.fallback;

  /// True when this account signed up via the phone+passcode flow (no email/
  /// password credential). Driven by the flow tracked at signup/login —
  /// `login_method == 'phone_passcode'` / a stored phone / the platform mode —
  /// mirroring `PasscodeSignIn._isPasswordless`. Used to hide the "Change
  /// Password" security tile, since a passwordless account has no password.
  bool _isPasswordless = !FeatureFlags.isEmailPasswordLogin;

  /// Whether the account has a password set (mirrored to secure storage on
  /// login as `has_password`). Drives the Change-Password vs Set-Password tile.
  bool _hasPassword = FeatureFlags.isEmailPasswordLogin;

  /// The user's selected login-method preference ("email_password" |
  /// "phone_passcode" | null = follow platform default).
  String? _preferredLoginMethod;

  /// Resolved transfer style: true = classic (short flow), false = standard
  /// (long flow). Seeded from FeatureFlags (per-user override → platform default).
  bool _transferStyleClassic = FeatureFlags.useShortSendFlow;

  /// Dashboard layout: true = showcase (compact services + adverts carousel),
  /// false = classic (current view). Seeded from the per-user preference.
  bool _dashboardShowcase = FeatureFlags.dashboardShowcaseLayout;

  /// Adaptive quick services: reorder the grid by the user's most-used services
  /// (default OFF, opt-in — tracking only runs while on).
  bool _adaptiveQuickServices = FeatureFlags.adaptiveQuickServices;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProfileCubit>().getUserProfile();
    });
    HelpConfigService.instance.ensure().then((cfg) {
      if (mounted) setState(() => _helpConfig = cfg);
    });
    _loadSignupFlow();
    _loadFraudSetting();
  }

  // Fraud-detection opt-out (default ON). Loaded best-effort; failure leaves the
  // toggle showing ON (fail-safe — protection stays on).
  bool _fraudDetectionEnabled = true;
  bool _fraudSettingBusy = false;

  Future<void> _loadFraudSetting() async {
    try {
      final on =
          await serviceLocator<FraudDetectionService>().getEnabled();
      if (mounted) setState(() => _fraudDetectionEnabled = on);
    } catch (_) {/* keep default ON */}
  }

  Future<void> _setFraudSetting(bool enabled) async {
    if (_fraudSettingBusy) return;
    final prev = _fraudDetectionEnabled;
    setState(() {
      _fraudDetectionEnabled = enabled; // optimistic
      _fraudSettingBusy = true;
    });
    try {
      final saved =
          await serviceLocator<FraudDetectionService>().setEnabled(enabled);
      if (mounted) setState(() => _fraudDetectionEnabled = saved);
    } catch (_) {
      if (mounted) {
        setState(() => _fraudDetectionEnabled = prev); // revert on failure
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Couldn't update fraud detection. Please try again."),
        ));
      }
    } finally {
      if (mounted) setState(() => _fraudSettingBusy = false);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadSignupFlow() async {
    try {
      final store = serviceLocator<FlutterSecureStorage>();
      final loginMethod = await store.read(key: 'login_method');
      final storedPhone = await store.read(key: 'stored_phone');
      final hasPasswordRaw = await store.read(key: 'has_password');
      final preferred = await store.read(key: 'preferred_login_method');
      // has_password is authoritative when present; otherwise infer from the
      // canonical login flow (email_password accounts have a password).
      final hasPassword = hasPasswordRaw != null
          ? hasPasswordRaw == 'true'
          : FeatureFlags.isEmailPasswordLogin;
      final passwordless = hasPasswordRaw != null
          ? !hasPassword
          : (loginMethod == 'phone_passcode' ||
              (storedPhone != null && storedPhone.isNotEmpty) ||
              !FeatureFlags.isEmailPasswordLogin);
      if (mounted) {
        setState(() {
          _isPasswordless = passwordless;
          _hasPassword = hasPassword;
          // Show the SAME method the login screen resolves to when the user
          // hasn't made an explicit choice (keeps Settings and login in lockstep).
          _preferredLoginMethod = (preferred != null && preferred.isNotEmpty)
              ? preferred
              : FeatureFlags.loginFlow;
        });
      }
    } catch (_) {
      // Non-fatal: fall back to the platform-mode default.
    }
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
                // Prefer the live loaded state; otherwise fall back to the last
                // good one so a background update (ProfileLoading) never blanks
                // the screen. Only the very first load (no cache) shows a loader.
                final display = state is ProfileLoaded ? state : _lastGood;
                if (display == null) {
                  return const Center(child: LazerVaultLoader.small());
                }
                return _buildScroll(display);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onProfileState(BuildContext context, ProfileState state) {
    // Cache the last good profile + drop optimistic overrides once the server
    // has confirmed (server becomes source of truth again).
    if (state is ProfileLoaded) {
      _lastGood = state;
      _pushOverride = null;
      _emailOverride = null;
      _smsOverride = null;
    }
    if (state is ProfileError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    } else if (state is PreferencesUpdateSuccess) {
      // No full reload here: the optimistic switches already reflect the change
      // and it's persisted server-side. Re-fetching would emit ProfileLoading
      // and (previously) blank the whole screen on every toggle.
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
    final searching = _searchQuery.trim().isNotEmpty;
    // Celebrate on the user's birthday: a confetti banner sits just under the
    // profile header on the day itself. Silently absent every other day.
    // DOB rides the AUTH profile (fromAuthProto) — the settings ProfileState
    // user comes via the common proto, which omits date_of_birth.
    final authUser = context.read<AuthenticationCubit>().currentProfile?.user;
    final birthdayName = (authUser?.firstName ?? '').trim().isNotEmpty
        ? authUser!.firstName
        : (state is ProfileLoaded ? state.user.firstName : '');
    final showBirthday = isBirthdayToday(authUser?.dateOfBirth);

    return RefreshIndicator(
      color: _kAccent,
      onRefresh: () async {
        await context.read<ProfileCubit>().getUserProfile();
        await _loadSignupFlow();
      },
      child: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 16.h),
          _buildProfileHeader(state),
          if (showBirthday) BirthdayCelebrationCard(firstName: birthdayName),
          SizedBox(height: 16.h),
          _buildSearchField(),
          SizedBox(height: 12.h),
          for (var i = 0; i < sections.length; i++)
            // While searching, hide non-matching sections and auto-expand the
            // matches so the item the user searched for is revealed in place.
            if (!searching || sections[i].matches(_searchQuery)) ...[
              _AccordionSection(
                key: ValueKey('section-$i-${sections[i].title}'),
                icon: sections[i].icon,
                title: sections[i].title,
                subtitle: sections[i].subtitle,
                expanded: searching ? true : _expandedIndex == i,
                onTap: searching
                    ? () {} // stays expanded while filtering
                    : () => setState(() {
                          _expandedIndex = _expandedIndex == i ? -1 : i;
                        }),
                child: sections[i].body,
              ),
              SizedBox(height: 12.h),
            ],
          if (searching && !sections.any((s) => s.matches(_searchQuery)))
            _buildNoSearchResults(),
          SizedBox(height: 24.h),
        ],
      ),
      ),
    );
  }

  Widget _buildSearchField() {
    // Light-theme search bar, aligned to the same 16.w side inset as the
    // profile header and accordion cards. White surface with a subtle border +
    // shadow so it lifts off the _kBg page; dark text contrasts the surface.
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: _kCard,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _kDivider),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(width: 14.w),
          Icon(Icons.search_rounded, size: 20.w, color: _kTextSecondary),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: (v) => setState(() => _searchQuery = v),
              textInputAction: TextInputAction.search,
              cursorColor: _kBrand,
              style: GoogleFonts.inter(
                  color: _kTextPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'Search settings',
                hintStyle: GoogleFonts.inter(
                    color: _kTextSecondary, fontSize: 14.sp),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() => _searchQuery = '');
                FocusScope.of(context).unfocus();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Icon(Icons.close_rounded,
                    size: 18.w, color: _kTextSecondary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNoSearchResults() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Icon(Icons.search_off_rounded,
              size: 40.w, color: const Color(0xFF9CA3AF)),
          SizedBox(height: 10.h),
          Text(
            'No settings match "$_searchQuery"',
            style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF), fontSize: 13.sp),
          ),
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
        keywords: const [
          'kyc', 'tier', 'identity', 'bvn', 'nin', 'verification',
          'transaction limits', 'daily limit', 'spending limit', 'upgrade',
        ],
      ),
      _SectionSpec(
        title: 'Security',
        icon: Icons.security_outlined,
        body: _securityBody(),
        keywords: const [
          'passcode', 'change passcode', 'transaction pin', 'payment pin',
          'panic balance', 'decoy', 'banking channels', 'whatsapp banking',
          'sms banking', 'phone banking', 'admin alerts', 'biometric login',
          'fingerprint', 'face id', 'voice login', 'verify email',
          'verify phone number', 'two factor', '2fa', 'mfa', 'otp',
          'authenticator', 'totp', 'update password', 'device permissions',
        ],
      ),
      // Dedicated Account Lock section — a scheduled or emergency self-lock that
      // blocks sign-in and all transactions until the timer elapses (no early
      // unlock). Reflected proactively on both login screens.
      _SectionSpec(
        title: 'Account Lock',
        icon: Icons.lock_clock_outlined,
        body: _accountLockBody(),
        keywords: const [
          'lock account', 'self lock', 'freeze', 'emergency lock',
          'timed lock', 'disable account',
        ],
      ),
      _SectionSpec(
        title: 'Customize',
        icon: Icons.tune_rounded,
        body: _customizeBody(),
        keywords: const [
          'login method', 'email password', 'phone passcode', 'send flow',
          'transfer flow', 'service tiles', 'home tiles', 'entrance animation',
          'appearance', 'preferences', 'send money', 'classic', 'standard',
          'sign in', 'transfer style', 'send funds', 'sendfunds', 'transfer',
        ],
      ),
      _SectionSpec(
        title: 'Regional',
        icon: Icons.public_outlined,
        body: _regionalBody(state),
        keywords: const [
          'country', 'currency', 'language', 'locale', 'region', 'timezone',
          'fx', 'money',
        ],
      ),
      _SectionSpec(
        title: 'Notifications & Display',
        icon: Icons.tune_outlined,
        body: _notificationsBody(state),
        keywords: const [
          'notifications', 'push', 'email notifications', 'sms',
          'dark mode', 'theme', 'display', 'sound', 'alerts',
          'chat sound', 'message sound', 'vibration', 'haptics',
          'balance vibration', 'balance update', 'vibrate on balance',
          'haptic feedback', 'balance animation', 'account update',
        ],
      ),
      // Voice & Chat Assistant — hidden unless the admin enables it via the
      // Feature Flags tab (voice_chat_assistant_section_visible). OFF by default.
      if (FeatureFlags.voiceChatAssistantVisible)
        _SectionSpec(
          title: 'Voice & Chat Assistant',
          icon: Icons.record_voice_over_outlined,
          // No subtitle — the section header stays clean like the other
          // accordion sections; details live inside the body.
          body: _voiceAssistantBody(),
          keywords: const [
            'voice assistant', 'chat assistant', 'ai', 'chatbot', 'voice agent',
            'voice setup', 'voice clone', 'cloning', 'clone my voice',
            'voice enrollment', 'enroll', 'voice recognition', 'my voice',
            'assistant voice', 'tts', 'voice selection', 'voice language',
            // Voice transaction-PIN controls (VoiceTxPinSection).
            'pin', 'transaction pin', 'ask for my pin', 'ask for my pin in voice',
            'require pin', 'voice pin', 'skip pin', 'pin entry', 'say my pin',
            // Per-service tuning entry points.
            'per-service voice', 'per service', 'transfers voice', 'crypto voice',
            'bills voice', 'exchange voice',
          ],
        ),
      _SectionSpec(
        title: 'Statements & Data',
        icon: Icons.description_outlined,
        body: _statementsBody(),
        keywords: const [
          'statement', 'export', 'download data', 'transactions export',
          'delete account', 'privacy', 'data',
        ],
      ),
      _SectionSpec(
        title: 'Help & Support',
        icon: Icons.help_outline,
        body: _helpBody(),
        keywords: const [
          'help', 'support', 'contact', 'faq', 'terms', 'privacy policy',
          'about', 'chat with us', 'ticket', 'logout', 'sign out',
        ],
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
                      : () => showProfilePictureActions(
                            context,
                            imageUrl: profilePicture,
                            profileCubit: context.read<ProfileCubit>(),
                          ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Hero(
                        tag: kProfileAvatarHeroTag,
                        child: UserAvatar(
                          size: 64.w,
                          imageUrl: profilePicture,
                          firstName: user?.firstName,
                          lastName: user?.lastName,
                          fallbackMode: UserAvatarFallback.initials,
                          borderColor: _kAccent.withValues(alpha: 0.2),
                          borderWidth: 3,
                        ),
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
                      if (user != null && user.id.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        SettingsTierBadge(userId: user.id),
                      ],
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

  /// "Customize" section — groups all flow customizations in one place:
  ///  • Send money: transfer style (classic short flow vs standard long flow)
  ///  • Login: login method (email+password vs phone+passcode)
  /// The login-method tile used to live under Security; it's a flow choice, so
  /// it belongs with the other flow customizations here.
  Widget _customizeBody() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: context.read<ProfileCubit>(),
      builder: (context, pState) {
        final user = pState is ProfileLoaded ? pState.user : null;
        // Same login-mode resolution the Security section uses, so the tile
        // subtitle + the sheet's set-password path stay correct.
        final backendPasswordless = user != null &&
            user.email.isEmpty &&
            (user.phoneNumber?.isNotEmpty ?? false);
        final hasPassword = _hasPassword && !backendPasswordless;
        final currentMode = _preferredLoginMethod ??
            ((backendPasswordless || _isPasswordless)
                ? 'phone_passcode'
                : 'email_password');
        final isEmailMode = currentMode == 'email_password';
        final sendMoneyTile = _navTile(
          icon: Icons.bolt_rounded,
          title: 'Send Funds',
          keywords: const [
            'transfer style', 'classic', 'standard', 'send',
            'transfer', 'send funds', 'sendfunds', 'send money',
          ],
          subtitle: _transferStyleClassic
              ? 'Classic — fast, streamlined'
              : 'Standard — full transfer form',
          onTap: _openSendMoneySheet,
        );
        final loginMethodTile = _navTile(
          icon: Icons.login_rounded,
          title: 'Login Method',
          keywords: const ['passcode', 'password', 'email', 'phone', 'sign in'],
          subtitle: isEmailMode
              ? 'Email or phone + password'
              : 'Phone + passcode',
          onTap: () => _openLoginMethodSheet(hasPassword),
        );
        final dashboardLayoutTile = _navTile(
          icon: Icons.dashboard_customize_rounded,
          title: 'Dashboard Layout',
          keywords: const [
            'dashboard',
            'layout',
            'home',
            'adverts',
            'showcase',
            'classic',
          ],
          subtitle: _dashboardShowcase
              ? 'Showcase — compact services + adverts'
              : 'Classic — current view',
          onTap: _openDashboardLayoutSheet,
        );
        final adaptiveServicesTile = _switchTile(
          icon: Icons.auto_awesome_motion_rounded,
          title: 'Adaptive quick services',
          keywords: const [
            'adaptive',
            'quick services',
            'reorder',
            'most used',
            'personalise',
            'personalize',
          ],
          subtitle: 'Reorder services by the ones you use most',
          value: _adaptiveQuickServices,
          onChanged: (v) {
            setState(() => _adaptiveQuickServices = v);
            FeatureFlags.setAdaptiveQuickServices(v);
            if (v) {
              // Seed the local tally from the server (cross-device continuity).
              serviceLocator<ServiceUsageService>().syncFromBackend();
            }
            showAppSnackbar(
              v ? 'Adaptive quick services on' : 'Adaptive quick services off',
              v
                  ? 'Your most-used services will move to the front.'
                  : 'Quick services keep the standard order.',
              type: AppSnackbarType.success,
            );
          },
        );
        // Deposit: re-enable (or hide) the one-time "keep your balance live"
        // guide on the deposit screen. Reads the SAME uid-scoped flag the modal's
        // "Don't show this again" checkbox writes, so the two stay in sync.
        final uid = user?.id ?? '';
        final depositGuideOn =
            uid.isNotEmpty ? FeatureFlags.depositBalanceGuideEnabled(uid) : true;
        final depositTipsTile = _switchTile(
          icon: Icons.tips_and_updates_rounded,
          title: 'Deposit balance tips',
          keywords: const [
            'deposit',
            'balance',
            'refresh',
            'tips',
            'guide',
            'keep balance live',
            'linked bank',
          ],
          subtitle:
              'Show the "keep your balance live" guide on the deposit screen',
          value: depositGuideOn,
          onChanged: (v) async {
            if (uid.isEmpty) return; // no profile yet — nothing to scope to
            await FeatureFlags.setDepositBalanceGuideEnabled(uid, v);
            if (!mounted) return;
            setState(() {});
            showAppSnackbar(
              v ? 'Deposit tips on' : 'Deposit tips off',
              v
                  ? 'The guide will show next time you open Deposit.'
                  : 'The guide stays hidden on the deposit screen.',
              type: AppSnackbarType.success,
            );
          },
        );
        // While searching, drop the group labels/spacing and filter down to the
        // matching tiles (item-level search, consistent with the other
        // sections). Non-searching keeps the grouped, spaced layout with labels.
        if (_searchQuery.trim().isNotEmpty) {
          return _filterableColumn([
            sendMoneyTile,
            dashboardLayoutTile,
            adaptiveServicesTile,
            depositTipsTile,
            loginMethodTile,
          ]);
        }
        // The group labels need the same 16.w side inset the header and nav rows
        // use, so they don't sit flush against the accordion card's edges.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _customizeGroupLabel('Send Funds'),
            ),
            SizedBox(height: 10.h),
            // Transfer style is now chosen in a bottom sheet — same interaction
            // as Login Method below — instead of inline cards.
            sendMoneyTile,
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _customizeGroupLabel('Dashboard'),
            ),
            SizedBox(height: 10.h),
            dashboardLayoutTile,
            SizedBox(height: 10.h),
            adaptiveServicesTile,
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _customizeGroupLabel('Deposit'),
            ),
            SizedBox(height: 10.h),
            depositTipsTile,
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: _customizeGroupLabel('Login'),
            ),
            SizedBox(height: 10.h),
            loginMethodTile,
          ],
        );
      },
    );
  }

  /// Small subsection label inside the Customize accordion.
  Widget _customizeGroupLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: _kTextSecondary,
          letterSpacing: 0.6,
        ),
      ),
    );
  }

  Widget _securityBody() {
    // Rebuild on profile changes so the verification / 2FA tiles reflect the
    // current auth state (Settings ↔ auth sync).
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: context.read<ProfileCubit>(),
      builder: (context, pState) {
        final user = pState is ProfileLoaded ? pState.user : null;
        final emailVerified = user?.isEmailVerified ?? false;
        final phoneVerified = user?.verified ?? false;
        final twoFaOn = user?.twoFactorEnabled ?? false;
        final twoFaMethod = user?.twoFactorMethod;
        // A phone+passcode account has no password to change. Hide the tile when
        // either signal says so: the backend profile (empty email + a phone
        // number) OR the signup-flow tracked locally (login_method /
        // stored_phone / platform mode).
        final backendPasswordless = user != null &&
            user.email.isEmpty &&
            (user.phoneNumber?.isNotEmpty ?? false);
        // Password presence: has_password (mirrored on login) is authoritative;
        // fall back to "not passwordless" for older sessions.
        final hasPassword = _hasPassword && !backendPasswordless;
        // The user's ACTIVE login mode. Password management only belongs to the
        // email+password mode — a phone+passcode user has no password to manage.
        // Setting a first password happens inside the "Login Method" switch flow
        // (switching to email+password), not as a standalone tile here.
        final currentMode = _preferredLoginMethod ??
            ((backendPasswordless || _isPasswordless)
                ? 'phone_passcode'
                : 'email_password');
        final isEmailMode = currentMode == 'email_password';
        return _filterableColumn([
        // Login method now lives under the "Customize" section (it's a flow
        // choice). Security keeps password / passcode / PIN management.
        // Update Password — shown ONLY in email+password mode. Opens the change
        // dialog when a password exists, or the set-password sheet as a safety
        // net (email mode normally implies a password is already set).
        if (isEmailMode)
          _navTile(
            icon: Icons.lock_outline,
            title: 'Update Password',
            subtitle: 'Change your account password',
            onTap: () {
              if (!hasPassword) {
                _openSetPasswordSheet();
                return;
              }
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
          onTap: () => _openPasscodeFlow(context),
        ),
        _switchTile(
          icon: Icons.shield_outlined,
          title: 'Fraud detection',
          subtitle:
              'Automatically pause unusually large transfers on your account for review',
          value: _fraudDetectionEnabled,
          onChanged: _fraudSettingBusy ? (_) {} : _setFraudSetting,
          keywords: const [
            'fraud',
            'fraud detection',
            'security',
            'anomaly',
            'freeze',
            'protection',
          ],
        ),
        _navTile(
          icon: Icons.lock_clock_outlined,
          title: 'Transaction PIN',
          subtitle: 'Set or change your 4-digit payment PIN',
          onTap: () => Get.toNamed(AppRoutes.pinManagement),
        ),
        // Panic Balance now lives under Security (a decoy balance + its
        // triggers/sound are a personal-safety control).
        _navTile(
          icon: Icons.shield_moon_outlined,
          title: 'Panic Balance',
          subtitle: 'Decoy balance, triggers & sound',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PanicBalanceScreen()),
          ),
        ),
        _navTile(
          icon: Icons.swap_horiz_rounded,
          title: 'Banking Channels',
          subtitle: 'Manage WhatsApp, phone & SMS banking',
          onTap: () => Get.toNamed(AppRoutes.channelManagement),
        ),
        // Admin-only: operational alerts (Prometheus/Alertmanager). Hidden from
        // non-admin users; the backend feed is admin-gated too.
        if (isAdminRoles(
            context.read<AuthenticationCubit>().currentProfile?.user.roles))
          _navTile(
            icon: Icons.shield_outlined,
            title: 'Admin Alerts',
            subtitle: 'Operational alerts for system admins',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminAlertsScreen()),
            ),
          ),
        _navTile(
          icon: Icons.fingerprint,
          title: 'Biometric Login',
          subtitle: 'Use fingerprint, Face ID or voice to unlock',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const BiometricLoginScreen(),
            ),
          ),
        ),
        _navTile(
          icon: Icons.email_outlined,
          title: 'Verify Email',
          subtitle: emailVerified
              ? 'Your email is verified'
              : 'Verify the email on your account',
          badge: emailVerified ? 'Verified' : 'Not verified',
          badgeColor: emailVerified
              ? const Color(0xFF10B981)
              : const Color(0xFFFB923C),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) =>
                      serviceLocator<EmailVerificationCubit>(),
                  child: EmailVerificationScreen(
                    email: user?.email,
                    fromSettings: true,
                  ),
                ),
              ),
            );
            if (result == true && context.mounted) {
              context.read<ProfileCubit>().getUserProfile();
            }
          },
        ),
        _navTile(
          icon: Icons.phone_android_outlined,
          title: 'Verify Phone Number',
          subtitle: phoneVerified
              ? 'Your phone number is verified'
              : 'Verify your phone number',
          badge: phoneVerified ? 'Verified' : 'Not verified',
          badgeColor: phoneVerified
              ? const Color(0xFF10B981)
              : const Color(0xFFFB923C),
          onTap: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) =>
                      serviceLocator<PhoneVerificationCubit>(),
                  child: PhoneVerificationScreen(
                    phoneNumber: user?.phoneNumber,
                    fromSettings: true,
                  ),
                ),
              ),
            );
            if (result == true && context.mounted) {
              context.read<ProfileCubit>().getUserProfile();
            }
          },
        ),
        _navTile(
          icon: Icons.vpn_key_outlined,
          keywords: const ['2fa', 'mfa', 'otp', 'authenticator', 'totp'],
          title: 'Two-Factor Authentication',
          subtitle: twoFaOn
              ? 'On${twoFaMethod != null && twoFaMethod.isNotEmpty ? ' · ${twoFaMethod.toUpperCase()}' : ''}. Extra login security'
              : 'Off. Add an extra layer of login security',
          badge: twoFaOn ? 'On' : null,
          badgeColor: const Color(0xFF3B82F6),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const TrustedDevicesScreen(),
                ),
              );
            },
          ),
        if (_kLoginActivityEnabled)
          _navTile(
            icon: Icons.history_outlined,
            title: 'Login Activity',
            subtitle: 'Review recent sign-ins',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LoginActivityScreen()),
              );
            },
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
          ]);
      },
    );
  }

  Widget _regionalBody(ProfileState state) {
    // NOTE: the app LANGUAGE picker was removed from Settings — language is now
    // chosen ONLY in "Voice & Languages" (single source of truth), so the two
    // pickers can't conflict.
    final rawCountry = state is ProfileLoaded
        ? state.user.country ?? 'United Kingdom'
        : 'United Kingdom';
    // `user.country` may be stored as a code ("NG") or a name ("Nigeria") —
    // resolve to the display name so the tile never shows a bare code.
    final country =
        CountryLocales.findByCountryCode(rawCountry)?.countryName ?? rawCountry;
    final currencySync = serviceLocator<CurrencySyncService>();

    return _filterableColumn([
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
        // Wrapped in _FilterableTile so the live StreamBuilder row still
        // participates in item-level search (otherwise a non-_FilterableTile
        // child is always shown, and Regional could never filter down).
        _FilterableTile(
          title: 'Currency',
          subtitle: '',
          keywords: const ['currency', 'money', 'fx'],
          child: StreamBuilder<String>(
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
        ),
      ]);
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

    // Reconcile the live theme with the server preference (cross-device): if the
    // loaded pref differs from the current theme, align it after this frame.
    if (state is ProfileLoaded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        serviceLocator<ThemeController>().syncFromServer(dark);
      });
    }

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

    return _filterableColumn([
        _switchTile(
          icon: Icons.notifications_outlined,
          title: 'Push Notifications',
          subtitle: 'Transaction alerts and updates',
          value: _pushOverride ?? push,
          onChanged: (v) {
            setState(() => _pushOverride = v); // instant flip
            update(push: v); // persist in background
          },
        ),
        // Haptic pulse while the dashboard balance ANIMATES — after login and
        // on live websocket updates (transfers, deposits, any service). Local
        // device preference (persisted on-device), ON by default.
        _switchTile(
          icon: Icons.vibration_rounded,
          title: 'Vibrate on balance updates',
          subtitle: 'Haptic pulse while your balance animates',
          value: serviceLocator<PanicBalanceService>().vibrationEnabled,
          onChanged: (v) async {
            await serviceLocator<PanicBalanceService>().setVibrationEnabled(v);
            if (mounted) setState(() {});
          },
        ),
        _switchTile(
          icon: Icons.email_outlined,
          title: 'Email Notifications',
          subtitle: 'Receive updates via email',
          value: _emailOverride ?? email,
          onChanged: (v) {
            setState(() => _emailOverride = v);
            update(email: v);
          },
        ),
        _switchTile(
          icon: Icons.sms_outlined,
          title: 'SMS Notifications',
          subtitle: 'Receive updates via SMS',
          value: _smsOverride ?? sms,
          onChanged: (v) {
            setState(() => _smsOverride = v);
            update(sms: v);
          },
        ),
        _switchTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          subtitle: 'Use the dark theme',
          value: dark,
          onChanged: (v) {
            // Switch the theme instantly + cache locally, then persist to server.
            serviceLocator<ThemeController>().setDark(v);
            update(dark: v);
          },
        ),
        // Global chat feedback defaults. Each conversation can override these
        // from that peer's profile sheet; these are the fall-through values.
        _switchTile(
          icon: Icons.volume_up_outlined,
          title: 'Chat message sound',
          subtitle: 'Play a sound when you send or receive a chat message',
          value: ChatSoundSettings.instance.globalSound,
          onChanged: (v) async {
            await ChatSoundSettings.instance.setGlobalSound(v);
            if (mounted) setState(() {});
          },
        ),
        // Tunable loudness for the chat message tones (only meaningful while the
        // sound above is on). Dragging previews the send tone at the new level.
        if (ChatSoundSettings.instance.globalSound)
          _FilterableTile(
            title: 'Message sound volume',
            subtitle: 'How loud chat message tones play',
            keywords: const ['volume', 'loud', 'quiet', 'sound'],
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 12.w, 4.h),
              child: Row(
                children: [
                  Icon(Icons.graphic_eq_rounded, color: _kBrand, size: 20.w),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Message sound volume',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: _kTextPrimary,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.volume_mute_rounded,
                                size: 16.w, color: _kTextSecondary),
                            Expanded(
                              child: Slider(
                                value: ChatSoundSettings.instance.globalVolume,
                                activeColor: _kBrand,
                                onChanged: (v) {
                                  // Live-update only (no disk write per frame);
                                  // persist once the drag ends.
                                  ChatSoundSettings.instance
                                      .setGlobalVolumeLive(v);
                                  if (mounted) setState(() {});
                                },
                                onChangeEnd: (v) {
                                  ChatSoundSettings.instance
                                      .setGlobalVolume(v); // persist final value
                                  ChatSoundSettings.instance
                                      .playSendFeedback(null); // preview tone
                                },
                              ),
                            ),
                            Icon(Icons.volume_up_rounded,
                                size: 18.w, color: _kTextSecondary),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        _switchTile(
          icon: Icons.vibration_outlined,
          title: 'Chat vibration',
          subtitle: 'Vibrate when you send or receive a chat message',
          value: ChatSoundSettings.instance.globalVibrate,
          onChanged: (v) async {
            await ChatSoundSettings.instance.setGlobalVibrate(v);
            if (mounted) setState(() {});
          },
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
      ]);
  }

  Widget _voiceAssistantBody() {
    // Every agent-backed service (slugs mirror the chat-*-service domains +
    // labelForChatService in per_service_voice_settings.dart). The voice & chat
    // assistant accommodates all of them, not just transfers.
    const services = <_VoiceServiceTile>[
      _VoiceServiceTile(
          slug: 'transfers',
          label: 'Send funds & transfers',
          icon: Icons.swap_horiz_rounded),
      _VoiceServiceTile(
          slug: 'crypto',
          label: 'Crypto',
          icon: Icons.currency_bitcoin),
      _VoiceServiceTile(
          slug: 'investments',
          label: 'Investments',
          icon: Icons.trending_up_rounded),
      _VoiceServiceTile(
          slug: 'exchange',
          label: 'Currency exchange',
          icon: Icons.swap_calls_rounded),
      _VoiceServiceTile(
          slug: 'banking',
          label: 'Banking (deposits & withdrawals)',
          icon: Icons.account_balance_outlined),
      _VoiceServiceTile(
          slug: 'products',
          label: 'Bills & utilities',
          icon: Icons.receipt_long_outlined),
      _VoiceServiceTile(
          slug: 'commerce',
          label: 'Invoices & gift cards',
          icon: Icons.card_giftcard_outlined),
      _VoiceServiceTile(
          slug: 'insurance',
          label: 'Insurance',
          icon: Icons.shield_outlined),
      _VoiceServiceTile(
          slug: 'business',
          label: 'Business (payroll & customers)',
          icon: Icons.business_center_outlined),
      _VoiceServiceTile(
          slug: 'statistics',
          label: 'Spending insights',
          icon: Icons.insights_outlined),
      _VoiceServiceTile(
          slug: 'sprayme',
          label: 'Lazerspray',
          icon: Icons.celebration_outlined),
      _VoiceServiceTile(
          slug: 'lifestyle',
          label: 'Lifestyle',
          icon: Icons.spa_outlined),
      _VoiceServiceTile(
          slug: 'accounts',
          label: 'Accounts & cards',
          icon: Icons.credit_card_outlined),
    ];
    return _filterableColumn([
        // Full voice-agent setup — opens the SAME screen the in-call settings
        // gear opens (voice recognition/enrollment, voice cloning, and voice &
        // language selection). It's a self-contained registered route driving the
        // shared VoiceSessionCubit / VoiceSettingsService, so every change here
        // persists (SharedPreferences + voice gateway) and takes effect in the
        // next voice conversation — no live session required.
        _navTile(
          icon: Icons.record_voice_over_rounded,
          title: 'Voice assistant setup',
          subtitle: 'Recognition, voice cloning, voice & language',
          onTap: () => Get.toNamed(AppRoutes.voiceSettings),
          keywords: const [
            'voice setup', 'set up voice', 'voice clone', 'cloning',
            'clone my voice', 'voice enrollment', 'enroll', 'voice recognition',
            'my voice', 'assistant voice', 'tts', 'voice selection', 'language',
          ],
        ),
        SizedBox(height: 14.h),
        // Group labels are organisational only — hide them while a settings
        // search is active (the section auto-expands and keeps every raw child),
        // so a filtered result never shows an orphan header with no matching row.
        // Voice transactions — per-user PIN policy for money moves by voice.
        if (_searchQuery.trim().isEmpty)
          Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
            child: Text(
              'Voice transactions',
              style: TextStyle(
                color: _kTextSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        // Same 16.w side inset as the nav rows so the PIN card doesn't sit flush
        // against the accordion card's edges.
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: const VoiceTxPinSection(),
        ),
        SizedBox(height: 18.h),
        // Per-service voice tuning (language, voice and prompt hints per service).
        if (_searchQuery.trim().isEmpty)
          Padding(
            padding: EdgeInsets.only(left: 16.w, bottom: 8.h),
            child: Text(
              'Per-service voice',
              style: TextStyle(
                color: _kTextSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        for (final s in services)
          _navTile(
            icon: s.icon,
            title: s.label,
            subtitle: 'Language, voice and prompt hints',
            onTap: () => _openVoiceSettingsFor(s.slug),
            keywords: [
              'voice', 'chat', 'assistant', 'voice agent', 'per-service',
              'language', 'voice selection', 'prompt hint',
              s.label.toLowerCase(), s.slug,
            ],
          ),
      ]);
  }

  Widget _statementsBody() {
    return _filterableColumn([
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
      ]);
  }

  /// Account Lock section — a single consolidated entry that opens the lock
  /// sheet. The sheet itself offers both a scheduled lock and an emergency lock
  /// (same duration-based self-lock; emergency defaults to the longest lock and
  /// uses danger styling). Blocks sign-in AND all transactions until it elapses
  /// — no early unlock — and is surfaced proactively on both login screens.
  Widget _accountLockBody() {
    return _filterableColumn([
        _navTile(
          icon: Icons.lock_clock_outlined,
          title: 'Lock account',
          subtitle: 'Block sign-in and transactions for a set time',
          onTap: () => LockAccountSheet.show(context),
        ),
        _navTile(
          icon: Icons.gpp_bad_outlined,
          title: 'Emergency lock',
          subtitle: 'Instantly lock this account if it may be compromised',
          badge: 'URGENT',
          badgeColor: const Color(0xFFEF4444),
          onTap: () => LockAccountSheet.show(context, emergency: true),
        ),
      ]);
  }

  Widget _helpBody() {
    final cfg = _helpConfig;
    return _filterableColumn([
        // Help & FAQ — opens the admin-configured FAQ/help center in a webview.
        if (cfg.faqUrl.isNotEmpty)
          _navTile(
            icon: Icons.help_center_outlined,
            title: 'Help Center',
            subtitle: 'Browse FAQs and how-to guides',
            onTap: () => _openHelpLink(cfg.faqUrl, 'Help Center'),
          ),
        // Support materials (videos, PDFs) — each opens in a webview.
        ...cfg.materials.map(
          (mat) => _navTile(
            icon: Icons.play_circle_outline,
            title: mat.title,
            subtitle: 'Watch / read',
            onTap: () => _openHelpLink(mat.url, mat.title),
          ),
        ),
        // In-app support — lands on the ticket hub (open/closed tickets +
        // new-ticket FAB), the same first screen as the drawer entry.
        _navTile(
          icon: Icons.support_agent_outlined,
          title: 'Contact support',
          subtitle: 'Message our team and track your tickets',
          onTap: () => Get.to(() => const SupportTicketsScreen()),
        ),
        _navTile(
          icon: Icons.mail_outline,
          title: 'Contact Us',
          subtitle: 'Get in touch with our team',
          onTap: _showContactSheet,
        ),
        _navTile(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          subtitle: 'Read our terms of service',
          onTap: () => _openHelpLink(cfg.termsUrl, 'Terms & Conditions'),
        ),
        _navTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Learn how we protect your data',
          onTap: () => _openHelpLink(cfg.privacyUrl, 'Privacy Policy'),
        ),
        _navTile(
          icon: Icons.info_outline,
          title: 'About Lazervault',
          subtitle: 'App version & company info',
          // Always opens the admin-configured About page (with a safe default)
          // in the webview sheet — the sheet handles empty/unavailable/errors.
          onTap: () => _openHelpLink(
              cfg.aboutUrl.isNotEmpty
                  ? cfg.aboutUrl
                  : HelpConfig.fallback.aboutUrl,
              'About Lazervault'),
        ),
        // Open-source licenses — Flutter's built-in license registry page.
        // Standard/expected on both stores; no URL needed.
        _navTile(
          icon: Icons.article_outlined,
          title: 'Open-source licenses',
          subtitle: 'Third-party software we use',
          onTap: () => showLicensePage(
            context: context,
            applicationName: 'Lazervault',
          ),
        ),
        // Replay the first-run dashboard coach-mark tour on demand. Clears the
        // seen flag then rebuilds the dashboard fresh so its first-frame trigger
        // restarts the showcase (and bumps the tracked view count).
        _navTile(
          icon: Icons.tips_and_updates_outlined,
          title: 'Replay app tour',
          subtitle: 'See the dashboard walkthrough again',
          onTap: () async {
            // Replay for THIS account only (per-account gating). Clear the
            // current user's seen flag, then reload the dashboard so its
            // first-frame trigger restarts the tour + bumps their view count.
            final uid = context
                    .read<AuthenticationCubit>()
                    .currentProfile
                    ?.user
                    .id ??
                '';
            await DashboardWalkthrough.reset(uid);
            Get.offAllNamed(AppRoutes.dashboard);
          },
        ),
        // Self-lock: temporarily block sign-in + all transactions for a chosen
        // Account lock (scheduled + emergency) now lives in its own dedicated
        // "Account Lock" section — see _accountLockBody().
        // In-app account deletion (required by both app stores). Danger action —
        // opens a dedicated confirmation screen (type-to-confirm + 30-day grace).
        _navTile(
          icon: Icons.delete_forever_outlined,
          title: 'Delete account',
          subtitle: 'Permanently delete your account and data',
          onTap: () => Get.to(() => const DeleteAccountScreen()),
        ),
      ]);
  }

  /// Opens an admin-configured link in the webview bottom sheet. Falls back to
  /// an external browser launch if the URL isn't web-openable.
  Future<void> _openHelpLink(String url, String title) async {
    final uri = Uri.tryParse(url);
    if (uri != null && (uri.isScheme('http') || uri.isScheme('https'))) {
      await showWebViewBottomSheet(context, url: url, title: title);
      return;
    }
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  /// Contact Us — renders the admin-configured channels (email, phone,
  /// WhatsApp, address) as tappable actions. Hidden channels are omitted.
  void _showContactSheet() {
    final cfg = _helpConfig;
    final rows = <Widget>[];
    if (cfg.contactEmail.isNotEmpty) {
      rows.add(_contactRow(Icons.mail_outline, 'Email', cfg.contactEmail,
          () => _launch('mailto:${cfg.contactEmail}')));
    }
    if (cfg.contactPhone.isNotEmpty) {
      rows.add(_contactRow(Icons.call_outlined, 'Call', cfg.contactPhone,
          () => _launch('tel:${cfg.contactPhone}')));
    }
    if (cfg.contactWhatsapp.isNotEmpty) {
      final wa = cfg.contactWhatsapp.replaceAll(RegExp(r'[^0-9]'), '');
      rows.add(_contactRow(Icons.chat_outlined, 'WhatsApp', cfg.contactWhatsapp,
          () => _launch('https://wa.me/$wa')));
    }
    if (cfg.contactAddress.isNotEmpty) {
      rows.add(_contactRow(Icons.location_on_outlined, 'Address', cfg.contactAddress, null));
    }
    // Optional admin-configured contact/help page — opens in the themed webview
    // bottom sheet (mailto/tel/WhatsApp above are OS actions, not webviews).
    if (cfg.contactUrl.isNotEmpty) {
      rows.add(_contactRow(
        Icons.open_in_new_rounded,
        'Contact page',
        'Open our contact & support page',
        () {
          Navigator.of(context).pop();
          _openHelpLink(cfg.contactUrl, 'Contact Us');
        },
      ));
    }
    if (rows.isEmpty) {
      rows.add(_contactRow(Icons.mail_outline, 'Email',
          HelpConfig.fallback.contactEmail,
          () => _launch('mailto:${HelpConfig.fallback.contactEmail}')));
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: _kCard,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact Us',
                  style: GoogleFonts.inter(
                      color: _kTextPrimary, fontSize: 18.sp, fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              ...rows,
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value, VoidCallback? onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: _kBrand, size: 22.sp),
      title: Text(label,
          style: GoogleFonts.inter(color: _kTextPrimary, fontSize: 14.sp, fontWeight: FontWeight.w600)),
      subtitle: Text(value,
          style: GoogleFonts.inter(color: _kTextSecondary, fontSize: 12.5.sp)),
      trailing: onTap != null
          ? Icon(Icons.chevron_right, color: _kTextSecondary, size: 20.sp)
          : null,
      onTap: onTap,
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null && await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
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

  /// Open the passcode flow in the correct mode. The mode (setup vs change)
  /// MUST be authoritative — if we wrongly pick `setup` for a user who already
  /// has a passcode, we skip the verify-current step entirely. The ProfileCubit
  /// flag is unreliable (it's only populated by the login response, not profile
  /// reloads), so we confirm with the backend (`CheckPasscodeExists`, which now
  /// reflects login_passcode_hash) before navigating, falling back to the cubit
  /// value only if the check fails.
  /// Open the login-method picker. A method can't be selected without the
  /// matching credential, or the user would be stranded at the next launch:
  /// email+password needs a password (→ Set Password first); phone+passcode
  /// needs a passcode (→ Passcode setup first). The backend enforces the same
  /// invariant; this pre-gate just gives a clean UX instead of an error.
  Future<void> _openLoginMethodSheet(bool hasPassword) async {
    final current = _preferredLoginMethod ??
        (_isPasswordless ? 'phone_passcode' : 'email_password');
    final chosen = await showLoginMethodSheet(context, current: current);
    if (chosen == null || chosen == current || !mounted) return;

    if (chosen == 'email_password' && !hasPassword) {
      // Must set a password before this method is usable.
      final didSet = await _openSetPasswordSheet();
      if (!didSet || !mounted) return; // user backed out; don't switch
    }

    if (chosen == 'phone_passcode') {
      // Confirm a passcode exists (backend is source of truth). If not, send the
      // user to passcode setup and stop — they can re-select once it's set.
      var hasPasscode = false;
      final res =
          await serviceLocator<IIdentityRepository>().checkPasscodeExists();
      res.fold((_) {}, (exists) => hasPasscode = exists);
      if (!mounted) return;
      if (!hasPasscode) {
        showAppSnackbar(
          'Set a passcode first',
          'Create a 6-digit passcode, then choose phone + passcode login.',
          type: AppSnackbarType.info,
        );
        Get.toNamed(AppRoutes.passcodeFlow, arguments: {'mode': 'setup'});
        return;
      }
    }

    await _applyLoginMethod(chosen);
  }

  Future<void> _applyLoginMethod(String method) async {
    final res =
        await context.read<AuthenticationCubit>().setPreferredLoginMethod(method);
    if (!mounted) return;
    res.fold(
      (failure) => showAppSnackbar('Could not update', failure.message,
          type: AppSnackbarType.error),
      (applied) {
        setState(() => _preferredLoginMethod = applied);
        showAppSnackbar(
          'Login method updated',
          applied == 'email_password'
              ? 'You\'ll sign in with your email or phone and password.'
              : 'You\'ll sign in with your phone and passcode.',
          type: AppSnackbarType.success,
        );
      },
    );
  }

  /// Opens the Send Money transfer-style picker (bottom sheet, same interaction
  /// as Login Method) and persists the choice. Local pref via FeatureFlags —
  /// mirror ONLY the UI/interaction, not the login sheet's backend persistence.
  Future<void> _openSendMoneySheet() async {
    final current = _transferStyleClassic
        ? FeatureFlags.transferStyleClassic
        : FeatureFlags.transferStyleStandard;
    final chosen = await showSendMoneySheet(context, current: current);
    if (chosen == null || chosen == current || !mounted) return;
    await FeatureFlags.setTransferStyle(chosen);
    if (!mounted) return;
    setState(() =>
        _transferStyleClassic = chosen == FeatureFlags.transferStyleClassic);
    showAppSnackbar(
      'Send money updated',
      _transferStyleClassic
          ? 'Classic — fast, streamlined send.'
          : 'Standard — the full transfer form.',
      type: AppSnackbarType.success,
    );
  }

  /// Opens the Dashboard Layout picker (bottom sheet, same interaction as Send
  /// Money) and persists the choice. Local pref via FeatureFlags — the live
  /// dashboard rebuilds via [FeatureFlags.dashboardLayoutRevision].
  Future<void> _openDashboardLayoutSheet() async {
    final current = _dashboardShowcase
        ? FeatureFlags.dashboardLayoutShowcase
        : FeatureFlags.dashboardLayoutClassic;
    final chosen = await showDashboardLayoutSheet(context, current: current);
    if (chosen == null || chosen == current || !mounted) return;
    await FeatureFlags.setDashboardLayout(chosen);
    if (!mounted) return;
    setState(() => _dashboardShowcase =
        chosen == FeatureFlags.dashboardLayoutShowcase);
    showAppSnackbar(
      'Dashboard updated',
      _dashboardShowcase
          ? 'Showcase — compact services with a rotating adverts carousel.'
          : 'Classic — your familiar dashboard view.',
      type: AppSnackbarType.success,
    );
  }

  /// Collect + set an initial password. Returns true when a password was set.
  Future<bool> _openSetPasswordSheet() async {
    final newPassword = await showSetPasswordSheet(context);
    if (newPassword == null || !mounted) return false;
    final res =
        await context.read<AuthenticationCubit>().setInitialPassword(newPassword);
    if (!mounted) return false;
    return res.fold(
      (failure) {
        showAppSnackbar('Could not set password', failure.message,
            type: AppSnackbarType.error);
        return false;
      },
      (_) {
        setState(() => _hasPassword = true);
        showAppSnackbar('Password set',
            'You can now sign in with your email or phone and password.',
            type: AppSnackbarType.success);
        return true;
      },
    );
  }

  Future<void> _openPasscodeFlow(BuildContext context) async {
    final state = context.read<ProfileCubit>().state;
    var hasPasscode = state is ProfileLoaded ? state.user.hasPasscode : false;

    // Brief blocking check so we never misroute the flow.
    final result = await serviceLocator<IIdentityRepository>().checkPasscodeExists();
    result.fold((_) {/* keep cubit fallback */}, (exists) => hasPasscode = exists);

    Get.toNamed(
      AppRoutes.passcodeFlow,
      arguments: {'mode': hasPasscode ? 'change' : 'setup'},
    );
  }

  // ===== Tiny tile helpers used inside accordion bodies =====

  Widget _navTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String? badge,
    Color badgeColor = const Color(0xFF10B981),
    List<String> keywords = const [],
  }) {
    return _FilterableTile(
      title: title,
      subtitle: subtitle,
      keywords: keywords,
      child: _SettingsRow(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: badgeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                badge,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: badgeColor,
                ),
              ),
            ),
            SizedBox(width: 8.w),
          ],
          Icon(Icons.arrow_forward_ios,
              size: 14.sp, color: const Color(0xFF9CA3AF)),
        ],
      ),
      ),
    );
  }

  Widget _switchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    List<String> keywords = const [],
  }) {
    return _FilterableTile(
      title: title,
      subtitle: subtitle,
      keywords: keywords,
      child: _SettingsRow(
        icon: icon,
        title: title,
        subtitle: subtitle,
        onTap: null,
        trailing: Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: _kBrand,
        ),
      ),
    );
  }

  /// Renders [tiles] in a Column, but while a settings search is active shows
  /// only the tiles whose title/subtitle/keywords match the query — so search
  /// filters DOWN to the individual items inside an accordion, not just the
  /// section. Two-pass: if NO tile in the list matches (the section surfaced
  /// via its own title/keywords), every tile is shown so the accordion is never
  /// empty. Non-[_FilterableTile] children (group labels, cards) are always
  /// kept.
  Widget _filterableColumn(List<Widget> tiles) {
    final q = _searchQuery.trim().toLowerCase();
    if (q.isEmpty) return Column(children: tiles);
    final tokens = q.split(RegExp(r'\s+')).where((t) => t.isNotEmpty).toList();
    bool matchesTile(_FilterableTile t) {
      final hay =
          '${t.title} ${t.subtitle} ${t.keywords.join(' ')}'.toLowerCase();
      return tokens.every((tok) => hay.contains(tok));
    }

    final anyTileMatches = tiles.whereType<_FilterableTile>().any(matchesTile);
    if (!anyTileMatches) return Column(children: tiles);
    return Column(
      children: [
        for (final w in tiles)
          if (w is! _FilterableTile || matchesTile(w)) w,
      ],
    );
  }

}
