import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/presentation/view/change_phone_screen.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_screen.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/settings_tier_badge.dart';
import 'package:lazervault/src/features/widgets/profile_picture_picker.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // Use global ProfileCubit - no need to create new instance
    // Profile is already loaded after authentication
    return const _MyAccountView();
  }
}

class _MyAccountView extends StatefulWidget {
  const _MyAccountView();

  @override
  State<_MyAccountView> createState() => _MyAccountViewState();
}

class _MyAccountViewState extends State<_MyAccountView> {
  bool _hasLoadedOnce = false;

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthenticationCubit>();
    final user = authCubit.currentProfile?.user;
    final isEmailVerified = user?.isEmailVerified ?? false;

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is ProfileUpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ),
          );
          // Don't reload - ProfileLoaded is already emitted with updated user
        } else if (state is ProfileLoaded) {
          // Update AuthenticationCubit with the new user data
          context.read<AuthenticationCubit>().updateCurrentUser(state.user);
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: Column(
          children: [
            ThemedAppBar(
              title: 'My Account',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Get.back(),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.settings_outlined),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  // Mark as loaded when we get ProfileLoaded state
                  if (state is ProfileLoaded) {
                    _hasLoadedOnce = true;
                  }

                  // Only show full screen loading on first load
                  if (state is ProfileLoading && !_hasLoadedOnce) {
                    return const Center(child: LazerVaultLoader.small());
                  }

                  return RefreshIndicator(
                    color: const Color(0xFF4E03D0),
                    onRefresh: () async {
                      await context.read<ProfileCubit>().getUserProfile();
                    },
                    child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16.h),

                        // Profile Header
                        _buildProfileHeader(user),

                        SizedBox(height: 24.h),

                        // Quick Actions
                        _buildQuickActions(),

                        SizedBox(height: 24.h),

                        // Verification Section
                        _buildVerificationSection(
                            isEmailVerified, user?.verified ?? false),

                        SizedBox(height: 16.h),

                        // Account Info Section
                        _buildAccountInfoSection(state),

                        SizedBox(height: 32.h),
                      ],
                    ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    final fullName = user != null
        ? '${user.firstName} ${user.lastName}'
        : 'User Name';
    final email = user?.email ?? 'user@email.com';
    final username = user?.username;

    return Container(
      padding: EdgeInsets.all(20.w),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4E03D0),
            Color(0xFF7C3AED),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4E03D0).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Picture Picker
              ProfilePicturePicker(
                currentProfilePicture: user?.profilePicture,
                size: 60,
                onImageSelected: (base64Image) {
                  context.read<ProfileCubit>().updateUserProfile(
                    profilePicture: base64Image,
                  );
                },
              ),
              SizedBox(width: 16.w),

              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fullName,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      email,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (username != null && username.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '@$username',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                    // Compact KYC tier badge (color-coded per tier + "Verified"
                    // on the final tier). Verification here is KYC-based, not
                    // email/phone — and far smaller than the old full-width pill.
                    if (user != null && (user.id as String).isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      SettingsTierBadge(userId: user.id as String, onDark: true),
                    ],
                  ],
                ),
              ),

              // Edit Button
              IconButton(
                icon: Icon(
                  Icons.edit_outlined,
                  color: Colors.white,
                  size: 24.sp,
                ),
                onPressed: () {
                  if (user != null) {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => BlocProvider.value(
                        value: context.read<ProfileCubit>(),
                        child: EditProfileDialog(user: user),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.qr_code_2,
              label: 'My QR',
              onTap: () {
                Get.toNamed(AppRoutes.myQRCode);
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.share_outlined,
              label: 'Share',
              onTap: _shareProfile,
            ),
          ),
        ],
      ),
    );
  }

  /// Share the user's Lazervault handle so others can pay/find them. Uses the
  /// same @username identifier the send-funds search resolves. Robust: reports a
  /// snackbar if the OS share sheet can't be presented.
  Future<void> _shareProfile() async {
    final user = context.read<AuthenticationCubit>().currentProfile?.user;
    if (user == null) {
      Get.snackbar(
        'Profile unavailable',
        'We couldn\'t load your profile. Pull to refresh and try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.9),
        colorText: Colors.white,
      );
      return;
    }
    final name = '${user.firstName} ${user.lastName}'.trim();
    final hasHandle = user.username != null && user.username!.isNotEmpty;
    final handle = hasHandle ? '@${user.username}' : user.email;

    // Rich, human body: who they're paying + the exact identifier send-funds
    // search resolves. Falls back gracefully when no username is set.
    final buffer = StringBuffer();
    if (name.isNotEmpty) {
      buffer.writeln('Pay $name on Lazervault.');
    } else {
      buffer.writeln('Pay me on Lazervault.');
    }
    if (handle.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(hasHandle
          ? 'Find me by my username: $handle'
          : 'Find me by my email: $handle');
    }
    buffer.write('\nOpen Lazervault → Send → search this to pay me instantly.');

    try {
      await SharePlus.instance.share(
        ShareParams(
          text: buffer.toString(),
          subject: name.isEmpty
              ? 'Pay me on Lazervault'
              : 'Pay $name on Lazervault',
        ),
      );
    } catch (_) {
      Get.snackbar(
        'Couldn\'t share',
        'Something went wrong opening the share sheet. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.85),
        colorText: Colors.white,
      );
    }
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
            Icon(
              icon,
              size: 28.sp,
              color: const Color(0xFF4E03D0),
            ),
            SizedBox(height: 8.h),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Verify the account's phone from My Account. Uses fromSettings=true so the
  /// verify screen behaves as a logged-in profile action: NO "skip → passcode"
  /// onboarding hop; back cancels, success returns here and refreshes the badge.
  Future<void> _verifyPhoneFromAccount() async {
    final user = context.read<AuthenticationCubit>().currentProfile?.user;
    final phone = user?.phoneNumber;
    // No number on file → send them to add + verify one in a single flow
    // (ChangePhoneScreen applies phone + phone_verified on success).
    if (phone == null || phone.isEmpty) {
      final added = await Get.to(() => const ChangePhoneScreen());
      if (added is String && added.isNotEmpty && context.mounted) {
        context.read<ProfileCubit>().getUserProfile();
      }
      return;
    }
    final result = await Get.toNamed(AppRoutes.phoneVerification, arguments: {
      'phoneNumber': phone,
      'isRequired': false,
      'fromSettings': true,
    });
    if (result == true && context.mounted) {
      context.read<ProfileCubit>().getUserProfile();
    }
  }

  Widget _buildVerificationSection(bool isEmailVerified, bool isPhoneVerified) {
    return _buildSection(
      title: 'Identity Verification',
      icon: Icons.verified_user_outlined,
      children: [
        _buildSettingsTile(
          icon: Icons.email_outlined,
          title: 'Email Verification',
          subtitle: isEmailVerified ? 'Verified' : 'Pending verification',
          trailing: Icon(
            isEmailVerified ? Icons.check_circle : Icons.pending,
            color: isEmailVerified ? Colors.green : Colors.orange,
            size: 24.sp,
          ),
          onTap: () {},
        ),
        _buildSettingsTile(
          icon: Icons.phone_outlined,
          title: 'Phone Verification',
          subtitle: isPhoneVerified ? 'Verified' : 'Tap to verify',
          trailing: Icon(
            isPhoneVerified ? Icons.check_circle : Icons.pending,
            color: isPhoneVerified ? Colors.green : Colors.orange,
            size: 24.sp,
          ),
          onTap: isPhoneVerified ? () {} : _verifyPhoneFromAccount,
        ),
        // Identity/KYC document verification is handled entirely by the Mono KYC
        // flow (surfaced via the KYC tier badge above), not from this page.
      ],
    );
  }

  Widget _buildAccountInfoSection(ProfileState state) {
    // Get user from ProfileState if available, otherwise fall back to AuthCubit
    final user = state is ProfileLoaded
        ? state.user
        : context.read<AuthenticationCubit>().currentProfile?.user;
    final firstName = user?.firstName ?? 'Not set';
    final lastName = user?.lastName ?? 'Not set';
    final username = user?.username ?? 'Not set';
    final phoneNumber = user?.phoneNumber ?? 'Not set';

    return _buildSection(
      title: 'Account Information',
      icon: Icons.person_outline,
      children: [
        _buildSettingsTile(
          icon: Icons.person_outline,
          title: 'First Name',
          subtitle: firstName,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            if (user != null) {
              showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: EditProfileDialog(user: user),
                ),
              );
            }
          },
        ),
        _buildSettingsTile(
          icon: Icons.person_outline,
          title: 'Last Name',
          subtitle: lastName,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            if (user != null) {
              showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: EditProfileDialog(user: user),
                ),
              );
            }
          },
        ),
        _buildSettingsTile(
          icon: Icons.alternate_email,
          title: 'Username',
          subtitle: username,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            if (user != null) {
              showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: EditProfileDialog(user: user),
                ),
              );
            }
          },
        ),
        _buildSettingsTile(
          icon: Icons.phone_outlined,
          title: 'Phone Number',
          subtitle: phoneNumber,
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            if (user != null) {
              showDialog(
                context: context,
                builder: (dialogContext) => BlocProvider.value(
                  value: context.read<ProfileCubit>(),
                  child: EditProfileDialog(user: user),
                ),
              );
            }
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

}
