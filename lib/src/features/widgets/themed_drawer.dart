import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/services/help_config_service.dart';
import 'package:lazervault/src/features/settings/presentation/widgets/webview_bottom_sheet.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/presentation/widgets/profile_picture_actions.dart';
import 'package:lazervault/src/features/widgets/my_account.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_screen.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';

class ThemedDrawer extends StatelessWidget {
  const ThemedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: Container(
        // Shared brand curved-edges background (same asset the email/password
        // login flow uses) over a dark base — stylish + consistent.
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg/up-down-curve-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          final authCubit = context.read<AuthenticationCubit>();
          final currentProfile = authCubit.currentProfile;

          final String userName = currentProfile != null
              ? "${currentProfile.user.firstName} ${currentProfile.user.lastName}"
              : "Guest User";
          final String userEmail = currentProfile?.user.email ?? "";
          final String userInitials = currentProfile != null
              ? "${currentProfile.user.firstName[0]}${currentProfile.user.lastName[0]}"
              : "GU";
          final String? profilePicture = currentProfile?.user.profilePicture;

          return SafeArea(
            child: Column(
              children: [
                // Header — a subtle frosted panel over the curved background so
                // the brand curve reads through while the profile block stays
                // legible.
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(28.r)),
                    border: Border(
                      bottom: BorderSide(
                          color: Colors.white.withValues(alpha: 0.08)),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                      // Profile Avatar — tap for photo actions (view full
                      // screen / change photo / account / settings).
                      GestureDetector(
                        onTap: () => showProfilePictureActions(
                          context,
                          imageUrl: profilePicture,
                          profileCubit: context.read<ProfileCubit>(),
                          showNavigationActions: true,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 3,
                            ),
                          ),
                          child: Hero(
                            tag: kProfileAvatarHeroTag,
                            child: _buildProfileAvatar(profilePicture, userInitials),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // User Name
                      Text(
                        userName,
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4.h),

                      // User Email
                      Text(
                        userEmail,
                        style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),

                      // View Profile Button
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MyAccount(),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 16.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'View Profile',
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ],
                    ),
                  ),
                ),

                // Menu Items
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    children: [
                      _buildMenuSection(
                        'Menu',
                        [
                          _DrawerMenuItem(
                            icon: Icons.account_circle_outlined,
                            title: 'My Account',
                            iconColor: Color(0xFF3784F9),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyAccount(),
                                ),
                              );
                            },
                          ),
                          _DrawerMenuItem(
                            icon: Icons.settings_outlined,
                            title: 'Settings',
                            iconColor: Color(0xFF7C92A0),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingsScreen(),
                                ),
                              );
                            },
                          ),
                          _DrawerMenuItem(
                            icon: Icons.support_agent,
                            title: 'Contact support',
                            iconColor: Color(0xFF4E03D0),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // Land on the ticket hub (open/closed +
                                  // new-ticket FAB) — not straight into a
                                  // chat thread.
                                  builder: (context) =>
                                      const SupportTicketsScreen(),
                                ),
                              );
                            },
                          ),
                          _DrawerMenuItem(
                            icon: Icons.info_outline,
                            title: 'About Lazervault',
                            iconColor: Color(0xFF3784F9),
                            onTap: () => _openAbout(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Logout Section
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF2D2D).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.logout,
                        color: Color(0xFFFF2D2D),
                        size: 20.sp,
                      ),
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFFF2D2D),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _showLogoutDialog(context, authCubit);
                    },
                  ),
                ),
                SizedBox(height: 8.h),
              ],
            ),
          );
        },
      ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<_DrawerMenuItem> items) {
    // Section label intentionally omitted (the "Menu" heading was removed).
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        ...items.map((item) => _buildMenuItem(item)),
      ],
    );
  }

  Widget _buildMenuItem(_DrawerMenuItem item) {
    return Builder(
      builder: (context) {
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: item.iconColor.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              item.icon,
              color: item.iconColor,
              size: 20.sp,
            ),
          ),
          title: Text(
            item.title,
            style: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.white.withValues(alpha: 0.35),
            size: 20.sp,
          ),
          onTap: item.onTap ?? () {},
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context, AuthenticationCubit authCubit) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Logout',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                authCubit.logout();
                // Logout keeps the cached identity → returning user; mode-aware
                // login entry (email login vs passcode lock), not a hardcoded
                // passcode lock (wrong for email accounts).
                Get.offAllNamed(AppRoutes.loginEntry);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF2D2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Logout',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Opens About in the styled webview bottom sheet (same as Terms & Privacy),
  /// using the admin-configured URL (system_settings `help_about_url`, the
  /// central source of truth) with a safe default. The sheet itself handles the
  /// empty/unavailable/failed-to-load states — there is no dialog fallback.
  Future<void> _openAbout(BuildContext context) async {
    HelpConfig cfg = HelpConfig.fallback;
    try {
      cfg = await HelpConfigService.instance.ensure();
    } catch (_) {/* use fallback */}
    if (!context.mounted) return;
    final url =
        cfg.aboutUrl.isNotEmpty ? cfg.aboutUrl : HelpConfig.fallback.aboutUrl;
    await showWebViewBottomSheet(context,
        url: url, title: 'About Lazervault');
  }

  Widget _buildProfileAvatar(String? profilePicture, String userInitials) {
    if (profilePicture != null && profilePicture.isNotEmpty) {
      // Check if it's a base64 image
      if (profilePicture.startsWith('data:image')) {
        try {
          final base64String = profilePicture.split(',')[1];
          final bytes = base64Decode(base64String);
          return CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            backgroundImage: MemoryImage(bytes),
          );
        } catch (e) {
          print('Error decoding base64 image: $e');
        }
      } else if (profilePicture.startsWith('http')) {
        // It's a URL
        return CircleAvatar(
          radius: 30.r,
          backgroundColor: Colors.white.withValues(alpha: 0.2),
          backgroundImage: NetworkImage(profilePicture),
        );
      }
    }

    // Default: show initials
    return CircleAvatar(
      radius: 30.r,
      backgroundColor: Colors.white.withValues(alpha: 0.2),
      child: Text(
        userInitials,
        style: GoogleFonts.inter(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _DrawerMenuItem {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback? onTap;

  _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.iconColor,
    this.onTap,
  });
}
