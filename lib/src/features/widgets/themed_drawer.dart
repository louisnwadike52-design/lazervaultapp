import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/my_account.dart';
import 'package:lazervault/src/features/settings/presentation/view/settings_screen.dart';

class ThemedDrawer extends StatelessWidget {
  const ThemedDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
          final authCubit = context.read<AuthenticationCubit>();
          final currentProfile = authCubit.currentProfile;

          final String userName = currentProfile != null
              ? "${currentProfile.user.firstName} ${currentProfile.user.lastName}"
              : "Guest User";
          final String userEmail = currentProfile?.user.email ?? "guest@example.com";
          final String userInitials = currentProfile != null
              ? "${currentProfile.user.firstName[0]}${currentProfile.user.lastName[0]}"
              : "GU";
          final String? profilePicture = currentProfile?.user.profilePicture;

          return SafeArea(
            child: Column(
              children: [
                // Header Section with Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF4E03D0),
                        Color(0xFF7C3AED),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      children: [
                      // Profile Avatar
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 3,
                          ),
                        ),
                        child: _buildProfileAvatar(profilePicture, userInitials),
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
                          color: Colors.white.withOpacity(0.8),
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
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
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
                            icon: Icons.info_outline,
                            title: 'About LazerVault',
                            iconColor: Color(0xFF3784F9),
                            onTap: () {
                              Navigator.pop(context);
                              _showAboutDialog(context);
                            },
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
                        color: Colors.grey.shade200,
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFFF2D2D).withOpacity(0.1),
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
    );
  }

  Widget _buildMenuSection(String title, List<_DrawerMenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...items.map((item) => _buildMenuItem(item)).toList(),
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
              color: item.iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
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
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1F2937),
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
            size: 20.sp,
          ),
          onTap: item.onTap ?? () {
            if (item.route != null) {
              Navigator.pop(context);
              Get.toNamed(item.route!);
            }
          },
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
                Get.offAllNamed(AppRoutes.signIn);
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

  void _showAboutDialog(BuildContext context) {
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
                color: Color(0xFF4E03D0),
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
                  color: Color(0xFF4E03D0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileAvatar(String? profilePicture, String userInitials) {
    if (profilePicture != null && profilePicture.isNotEmpty) {
      // Check if it's a base64 image
      if (profilePicture.startsWith('data:image')) {
        try {
          final base64String = profilePicture.split(',')[1];
          final bytes = base64Decode(base64String);
          return CircleAvatar(
            radius: 40.r,
            backgroundColor: Colors.white.withOpacity(0.2),
            backgroundImage: MemoryImage(bytes),
          );
        } catch (e) {
          print('Error decoding base64 image: $e');
        }
      } else if (profilePicture.startsWith('http')) {
        // It's a URL
        return CircleAvatar(
          radius: 40.r,
          backgroundColor: Colors.white.withOpacity(0.2),
          backgroundImage: NetworkImage(profilePicture),
        );
      }
    }

    // Default: show initials
    return CircleAvatar(
      radius: 40.r,
      backgroundColor: Colors.white.withOpacity(0.2),
      child: Text(
        userInitials,
        style: GoogleFonts.inter(
          fontSize: 28.sp,
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
  final String? route;
  final VoidCallback? onTap;

  _DrawerMenuItem({
    required this.icon,
    required this.title,
    required this.iconColor,
    this.route,
    this.onTap,
  });
}
