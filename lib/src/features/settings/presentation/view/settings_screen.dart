import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/currency_sync_service.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/change_password_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/language_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/currency_picker_dialog.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/country_picker_dialog.dart';
import 'package:lazervault/src/features/identity/presentation/view/passcode_setup_screen.dart';
import 'package:lazervault/src/features/identity/presentation/view/device_permissions_screen.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/settings/presentation/view/contact_us_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/help_support_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/terms_conditions_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/privacy_policy_screen.dart';
import 'package:lazervault/src/features/settings/presentation/view/card_settings_screen.dart';
import 'package:lazervault/src/features/statements/presentation/view/download_statements_screen.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/email_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/phone_verification_cubit.dart';
import 'package:lazervault/src/features/authentication/presentation/views/email_verification_screen.dart';
import 'package:lazervault/src/features/authentication/presentation/views/phone_verification_screen.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use the global ProfileCubit instead of creating a new one
    // This ensures profile updates from email verification are reflected
    return const _SettingsView();
  }
}

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  @override
  void initState() {
    super.initState();
    // Refresh profile data when screen opens
    // Uses the global ProfileCubit from main.dart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
            // Use BlocConsumer to handle both side effects and UI updates
            child: BlocConsumer<ProfileCubit, ProfileState>(
              listener: (context, state) {
                if (state is ProfileError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is PreferencesUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preferences updated successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  context.read<ProfileCubit>().getUserProfile();
                } else if (state is PasswordUpdateSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),

                      // Profile Section
                      _buildProfileSection(state),

                      SizedBox(height: 16.h),

                      // Security Section
                      _buildSecuritySection(),

                      SizedBox(height: 16.h),

                      // App Settings Section
                      _buildAppSettingsSection(state),

                      SizedBox(height: 16.h),

                      // Preferences Section
                      _buildPreferencesSection(state),

                      SizedBox(height: 16.h),

                      // Help & Support Section
                      _buildHelpSupportSection(),

                      SizedBox(height: 32.h),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(ProfileState state) {
    final user = state is ProfileLoaded ? state.user : null;
    final fullName = user != null
        ? '${user.firstName} ${user.lastName}'
        : 'Loading...';
    final email = user?.email ?? '';
    final username = user?.username;
    final profilePicture = user?.profilePicture ?? AppData.dp;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                // Profile Picture
                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.r),
                    child: UniversalImageLoader(
                      imagePath: profilePicture,
                      width: 70.w,
                      height: 70.h,
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Profile Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Username display with @ prefix
                      if (username != null && username.isNotEmpty) ...[
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                '@$username',
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF4E03D0),
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Icon(
                              Icons.verified,
                              size: 16.sp,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: 4.h),
                      ] else ...[
                        // No username set - show prompt
                        GestureDetector(
                          onTap: () {
                            _showEditProfileDialog(user);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: Colors.amber.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  size: 14.sp,
                                  color: Colors.amber[700],
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Add username',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.amber[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 4.h),
                      ],
                      Text(
                        email,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Edit button
                IconButton(
                  onPressed: () {
                    _showEditProfileDialog(user);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      size: 18.sp,
                      color: const Color(0xFF4E03D0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Username info card (if username exists)
          if (username != null && username.isNotEmpty)
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF4E03D0).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18.sp,
                    color: const Color(0xFF4E03D0),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Your username @$username can be used by others to send you money instantly.',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF4E03D0),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )
          else
            Container(
              margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.amber.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 18.sp,
                    color: Colors.amber[700],
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'Set a username to let others send you money easily using @username.',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.amber[800],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(user) {
    if (user == null) return;
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ProfileCubit>(),
        child: EditProfileDialog(user: user),
      ),
    ).then((_) {
      // Refresh profile after editing
      context.read<ProfileCubit>().getUserProfile();
    });
  }

  Widget _buildSecuritySection() {
    return _buildSection(
      title: 'Security',
      icon: Icons.security_outlined,
      children: [
        _buildSettingsTile(
          icon: Icons.lock_outline,
          title: 'Change Password',
          subtitle: 'Update your password',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
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
        _buildSettingsTile(
          icon: Icons.pin_outlined,
          title: 'Passcode',
          subtitle: 'Set up 4-6 digit passcode for quick access',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => serviceLocator<IdentityCubit>(),
                  child: const PasscodeSetupScreen(),
                ),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.edit_outlined,
          title: 'Change Passcode',
          subtitle: 'Update your login passcode',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Get.toNamed(AppRoutes.changePasscode);
          },
        ),
        _buildSettingsTile(
          icon: Icons.lock_outline,
          title: 'Transaction PIN',
          subtitle: 'Set or change your 4-digit payment PIN',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Get.toNamed(AppRoutes.pinManagement);
          },
        ),
        _buildSettingsTile(
          icon: Icons.fingerprint,
          title: 'Biometric Settings',
          subtitle: 'Use fingerprint or face to unlock',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Get.toNamed(AppRoutes.setFingerPrint);
          },
        ),
        _buildSettingsTile(
          icon: Icons.email_outlined,
          title: 'Verify Email',
          subtitle: 'Verify your email address',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => serviceLocator<EmailVerificationCubit>(),
                  child: const EmailVerificationScreen(),
                ),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.phone_android_outlined,
          title: 'Verify Phone Number',
          subtitle: 'Verify your phone number',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (_) => serviceLocator<PhoneVerificationCubit>(),
                  child: const PhoneVerificationScreen(),
                ),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.vpn_key_outlined,
          title: 'Two-Factor Authentication',
          subtitle: 'Add extra security to your account',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            // Navigate to 2FA setup
          },
        ),
        _buildSettingsTile(
          icon: Icons.devices_outlined,
          title: 'Trusted Devices',
          subtitle: 'Manage devices with access to your account',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            // Navigate to trusted devices
          },
        ),
        _buildSettingsTile(
          icon: Icons.admin_panel_settings_outlined,
          title: 'Device Permissions',
          subtitle: 'Manage app permissions on your device',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider(
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

  Widget _buildAppSettingsSection(ProfileState state) {
    final language = state is ProfileLoaded
        ? _getLanguageName(state.user.language ?? 'en')
        : 'English';
    final country = state is ProfileLoaded
        ? state.user.country ?? 'United Kingdom'
        : 'United Kingdom';

    // Get currency from CurrencySyncService (reactive stream)
    final currencySyncService = serviceLocator<CurrencySyncService>();

    return _buildSection(
      title: 'Regional Settings',
      icon: Icons.public_outlined,
      children: [
        _buildSettingsTile(
          icon: Icons.language_outlined,
          title: 'Language',
          subtitle: language,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            final currentLanguage = state is ProfileLoaded
                ? (state.user.language ?? 'en')
                : 'en';
            showDialog(
              context: context,
              builder: (dialogContext) => BlocProvider.value(
                value: context.read<ProfileCubit>(),
                child: LanguagePickerDialog(currentLanguage: currentLanguage),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.location_on_outlined,
          title: 'Country',
          subtitle: country,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
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
              if (countryCode != null && countryCode.isNotEmpty) {
                // Refresh account summaries for the new country
                final profileState = context.read<ProfileCubit>().state;
                if (profileState is ProfileLoaded) {
                  context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                    userId: profileState.user.id,
                    country: countryCode,
                  );
                }
              }
            });
          },
        ),
        // Reactive currency tile with StreamBuilder
        StreamBuilder<String>(
          stream: currencySyncService.currencyStream,
          initialData: currencySyncService.currentCurrency,
          builder: (context, snapshot) {
            final currentCurrency = snapshot.data ?? 'USD';

            return _buildSettingsTile(
              icon: Icons.attach_money_outlined,
              title: 'Currency',
              subtitle: currentCurrency,
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: const Color(0xFF9CA3AF),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) => BlocProvider.value(
                    value: context.read<ProfileCubit>(),
                    child: CurrencyPickerDialog(currentCurrency: currentCurrency),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _getLanguageName(String code) {
    final languages = {
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'it': 'Italian',
      'pt': 'Portuguese',
      'zh': 'Chinese',
      'ja': 'Japanese',
      'ar': 'Arabic',
      'hi': 'Hindi',
    };
    return languages[code] ?? 'English';
  }

  Widget _buildPreferencesSection(ProfileState state) {
    final pushNotifications = state is ProfileLoaded
        ? state.preferences.pushNotifications
        : true;
    final emailNotifications = state is ProfileLoaded
        ? state.preferences.emailNotifications
        : true;
    final smsNotifications = state is ProfileLoaded
        ? state.preferences.smsNotifications
        : false;
    final darkMode = state is ProfileLoaded
        ? state.preferences.darkMode
        : false;

    return _buildSection(
      title: 'Notifications & Display',
      icon: Icons.tune_outlined,
      children: [
        _buildSettingsTile(
          icon: Icons.notifications_outlined,
          title: 'Push Notifications',
          subtitle: 'Get notified about transactions and updates',
          trailing: Switch(
            value: pushNotifications,
            onChanged: (value) {
              context.read<ProfileCubit>().updatePreferences(
                    pushNotifications: value,
                  );
            },
            activeThumbColor: const Color(0xFF4E03D0),
          ),
          onTap: null,
        ),
        _buildSettingsTile(
          icon: Icons.email_outlined,
          title: 'Email Notifications',
          subtitle: 'Receive updates via email',
          trailing: Switch(
            value: emailNotifications,
            onChanged: (value) {
              context.read<ProfileCubit>().updatePreferences(
                    emailNotifications: value,
                  );
            },
            activeThumbColor: const Color(0xFF4E03D0),
          ),
          onTap: null,
        ),
        _buildSettingsTile(
          icon: Icons.sms_outlined,
          title: 'SMS Notifications',
          subtitle: 'Receive updates via SMS',
          trailing: Switch(
            value: smsNotifications,
            onChanged: (value) {
              context.read<ProfileCubit>().updatePreferences(
                    smsNotifications: value,
                  );
            },
            activeThumbColor: const Color(0xFF4E03D0),
          ),
          onTap: null,
        ),
        _buildSettingsTile(
          icon: Icons.dark_mode_outlined,
          title: 'Dark Mode',
          subtitle: 'Toggle dark theme',
          trailing: Switch(
            value: darkMode,
            onChanged: (value) {
              context.read<ProfileCubit>().updatePreferences(
                    darkMode: value,
                  );
            },
            activeThumbColor: const Color(0xFF4E03D0),
          ),
          onTap: null,
        ),
        _buildSettingsTile(
          icon: Icons.card_membership_outlined,
          title: 'Card Settings',
          subtitle: 'Manage your cards',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CardSettingsScreen(),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.download_outlined,
          title: 'Download Statements',
          subtitle: 'Export your transaction history',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (_) => serviceLocator<StatementCubit>(),
                    ),
                    BlocProvider(
                      create: (_) => serviceLocator<AccountCardsSummaryCubit>(),
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

  Widget _buildHelpSupportSection() {
    return _buildSection(
      title: 'Help & Support',
      icon: Icons.help_outline,
      children: [
        _buildSettingsTile(
          icon: Icons.chat_bubble_outline,
          title: 'Help & Support',
          subtitle: 'Submit a support ticket',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HelpSupportScreen(),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.mail_outline,
          title: 'Contact Us',
          subtitle: 'Get in touch with our team',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ContactUsScreen(),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.description_outlined,
          title: 'Terms & Conditions',
          subtitle: 'Read our terms of service',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TermsConditionsScreen(),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Learn how we protect your data',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PrivacyPolicyScreen(),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.info_outline,
          title: 'About LazerVault',
          subtitle: 'Version 1.0.0',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            _showAboutDialog();
          },
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20.sp,
                  color: const Color(0xFF4E03D0),
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, color: const Color(0xFFE5E7EB)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  icon,
                  size: 22.sp,
                  color: const Color(0xFF4E03D0),
                ),
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
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
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

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Column(
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 48.sp,
                color: const Color(0xFF4E03D0),
              ),
              SizedBox(height: 12.h),
              Text(
                'LazerVault',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Version 1.0.0',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Your trusted financial companion for seamless transactions and secure digital banking.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.grey.shade700,
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
                  color: const Color(0xFF4E03D0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
