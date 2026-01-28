import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/widgets/themed_app_bar.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/edit_profile_dialog.dart';
import 'package:lazervault/src/features/identity/presentation/view/id_verification_screen.dart';
import 'package:lazervault/src/features/identity/presentation/view/facial_registration_screen.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_screen.dart';
import 'package:lazervault/src/features/widgets/profile_picture_picker.dart';

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
                    return const Center(child: CircularProgressIndicator());
                  }

                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 16.h),

                        // Profile Header
                        _buildProfileHeader(user, isEmailVerified),

                        SizedBox(height: 24.h),

                        // Quick Actions
                        _buildQuickActions(),

                        SizedBox(height: 24.h),

                        // Verification Section
                        _buildVerificationSection(isEmailVerified),

                        SizedBox(height: 16.h),

                        // Account Info Section
                        _buildAccountInfoSection(state),

                        SizedBox(height: 32.h),
                      ],
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

  Widget _buildProfileHeader(dynamic user, bool isEmailVerified) {
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
              Stack(
                children: [
                  ProfilePicturePicker(
                    currentProfilePicture: user?.profilePicture,
                    size: 80,
                    onImageSelected: (base64Image) {
                      context.read<ProfileCubit>().updateUserProfile(
                        profilePicture: base64Image,
                      );
                    },
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 28.w,
                      height: 28.h,
                      decoration: BoxDecoration(
                        color: isEmailVerified ? Colors.green : Colors.orange,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(
                        isEmailVerified ? Icons.verified : Icons.pending,
                        size: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
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

          SizedBox(height: 16.h),

          // Verification Status Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isEmailVerified ? Icons.verified_user : Icons.warning_amber_rounded,
                  color: isEmailVerified ? Colors.greenAccent : Colors.orangeAccent,
                  size: 20.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  isEmailVerified ? 'Account Verified' : 'Verification Pending',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
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
              onTap: () {
                // Share profile
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _buildQuickActionCard(
              icon: Icons.wallet_outlined,
              label: 'Accounts',
              onTap: () {
                // View accounts
              },
            ),
          ),
        ],
      ),
    );
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

  Widget _buildVerificationSection(bool isEmailVerified) {
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
          onTap: () {
            if (!isEmailVerified) {
              // Resend verification email
            }
          },
        ),
        _buildSettingsTile(
          icon: Icons.phone_outlined,
          title: 'Phone Verification',
          subtitle: 'Not verified',
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16.sp,
            color: const Color(0xFF9CA3AF),
          ),
          onTap: () {
            // Navigate to phone verification
          },
        ),
        _buildSettingsTile(
          icon: Icons.badge_outlined,
          title: 'Identity Document',
          subtitle: 'Upload ID, Passport, or Driver\'s License',
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
                  child: const IDVerificationScreen(),
                ),
              ),
            );
          },
        ),
        _buildSettingsTile(
          icon: Icons.person_outline,
          title: 'Facial Recognition',
          subtitle: 'Register your face for secure access',
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
                  child: const FacialRegistrationScreen(),
                ),
              ),
            );
          },
        ),
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
