import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/presentation/views/notification_screen.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_command_sheet.dart';
import 'package:lazervault/src/features/widgets/universal_image_loader.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/country_locale_bottom_sheet.dart';

// Dashboard header with notifications bottomsheet - clean white background
class DashboardHeader extends StatelessWidget {
  final User? currentUser; // Accept optional user data

  const DashboardHeader({super.key, this.currentUser});

  @override
  Widget build(BuildContext context) {
     // Use user's profile picture if available, otherwise fallback to default
    final profileImagePath = currentUser?.profilePicture ?? AppData.dp;

    return Row(
      children: [
        // Profile Picture - Clickable to open drawer
        GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],

            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: UniversalImageLoader(
                imagePath: profileImagePath,
                height: 40.h,
                width: 40.w,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Country Selector
        Expanded(
          child: _buildCountrySelector(context),
        ),
        SizedBox(width: 16.w),
        // Action Icons
        _buildIconButton(Icons.notifications_outlined, context),
        SizedBox(width: 12.w),
        _buildIconButton(Icons.mic_rounded, context),
      ],
    );
  }

  Widget _buildCountrySelector(BuildContext context) {
    // Use LocaleManager stream for reactive updates
    final localeManager = serviceLocator<LocaleManager>();

    return StreamBuilder<String>(
      stream: localeManager.countryStream,
      initialData: localeManager.currentCountry,
      builder: (context, snapshot) {
        final currentCountry = snapshot.data ?? 'US';
        final countryLocale = CountryLocales.findByCountryCode(currentCountry);

        return InkWell(
          onTap: () async {
            // Show bottom sheet to select country
            final selectedCountry = await CountryLocaleBottomSheet.show(
              context,
              selectedCountryCode: currentCountry,
            );

            if (selectedCountry != null) {
              // Update locale in LocaleManager (app-wide)
              await localeManager.updateLocale(
                locale: selectedCountry.locale,
                country: selectedCountry.countryCode,
              );

              // Update preferences in ProfileCubit
              await context.read<ProfileCubit>().setActiveCountry(
                selectedCountry.countryCode,
              );

              // Refresh account data for the new country
              final authState = context.read<AuthenticationCubit>().state;
              if (authState is AuthenticationSuccess) {
                final userId = authState.profile.user.id;
                final accessToken = authState.profile.session.accessToken;

                // Fetch accounts for the selected country
                await context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(
                  userId: userId,
                  accessToken: accessToken,
                  country: selectedCountry.countryCode,
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
            height: 40.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  countryLocale?.flag ?? _getCountryFlag(currentCountry),
                  style: TextStyle(fontSize: 18.sp),
                ),
                SizedBox(width: 8.w),
                Text(
                  currentCountry,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 4.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                  size: 20.sp,
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
    return Container(
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 20.sp),
        onPressed: () {
          if (icon == Icons.notifications_outlined) {
            _showNotifications(context);
          } else if (icon == Icons.mic_rounded) {
            _showVoiceCommandSheet(context);
          }
        },
        padding: EdgeInsets.zero, 
        constraints: const BoxConstraints(), 
      ),
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
                color: Colors.black.withOpacity(0.1),
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

  void _showVoiceCommandSheet(BuildContext context) {
    Get.bottomSheet(
      FractionallySizedBox(
        heightFactor: 0.85,
        child: VoiceCommandSheet(),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
    );
  }
} 