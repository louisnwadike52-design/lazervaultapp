import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_cubit.dart';
import 'package:lazervault/src/features/multi_country/cubit/multi_country_state.dart';


/// Empty state widget displayed when a user has no accounts for the selected locale.
/// Shows a "Create Account" button that triggers multi-country account creation.
class EmptyAccountState extends StatelessWidget {
  /// The user's country code (if available)
  final String? countryCode;

  /// Whether virtual accounts are supported in the user's country
  final bool isVirtualAccountSupported;

  /// Callback when the user wants to get notified about account availability
  final VoidCallback? onNotifyMe;

  /// Callback after account creation succeeds
  final VoidCallback? onAccountCreated;

  const EmptyAccountState({
    super.key,
    this.countryCode,
    this.isVirtualAccountSupported = false,
    this.onNotifyMe,
    this.onAccountCreated,
  });

  /// Check if the country supports account creation.
  /// Uses CountryLocales as the single source of truth.
  static bool isCountrySupported(String? countryCode) {
    if (countryCode == null) return false;
    return CountryLocales.findByCountryCode(countryCode) != null;
  }

  /// Convert country code to locale string (e.g., "NG" -> "en-NG")
  static String _countryToLocale(String countryCode) {
    return 'en-${countryCode.toUpperCase()}';
  }

  /// Get currency for country code using CountryLocales as the single source of truth.
  static String _currencyForCountry(String countryCode) {
    return CountryLocales.findByCountryCode(countryCode)?.currency ?? countryCode;
  }

  @override
  Widget build(BuildContext context) {
    final supported = isCountrySupported(countryCode);

    return BlocListener<MultiCountryCubit, MultiCountryState>(
      listener: (context, state) {
        if (state is LocaleAccountCreated) {
          onAccountCreated?.call();
        } else if (state is LocaleAccountCreateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF6C5CE7).withValues(alpha: 0.8),
              const Color(0xFF4834D4).withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background decorative pattern
              Positioned(
                right: -30,
                top: -30,
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                ),
              ),
              Positioned(
                left: -20,
                bottom: -40,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.04),
                  ),
                ),
              ),
              // Main content
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        supported
                            ? Icons.account_balance_wallet_outlined
                            : Icons.hourglass_empty_rounded,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Title
                    Text(
                      supported
                          ? 'No ${_currencyForCountry(countryCode!)} Account Yet'
                          : 'Coming Soon',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 10.h),

                    // Description
                    Text(
                      supported
                          ? 'Create a ${_currencyForCountry(countryCode!)} wallet to send, receive, and exchange funds.'
                          : 'Virtual accounts will be available in your region soon.',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 12.sp,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Action button
                    if (supported)
                      _buildCreateAccountButton(context)
                    else
                      _buildNotifyMeButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton(BuildContext context) {
    return BlocBuilder<MultiCountryCubit, MultiCountryState>(
      builder: (context, state) {
        final isCreating = state is LocaleAccountCreating &&
            state.locale == _countryToLocale(countryCode!);

        return GestureDetector(
          onTap: isCreating
              ? null
              : () {
                  final locale = _countryToLocale(countryCode!);
                  context.read<MultiCountryCubit>().createLocaleAccount(locale);
                },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isCreating)
                  SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: const Color(0xFF6C5CE7),
                    ),
                  )
                else
                  Icon(
                    Icons.add_circle_outline_rounded,
                    color: const Color(0xFF6C5CE7),
                    size: 16.sp,
                  ),
                SizedBox(width: 6.w),
                Text(
                  isCreating ? 'Creating...' : 'Create Account',
                  style: TextStyle(
                    color: const Color(0xFF6C5CE7),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNotifyMeButton(BuildContext context) {
    return GestureDetector(
      onTap: onNotifyMe ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'We\'ll notify you when virtual accounts become available in your region!',
                ),
                duration: const Duration(seconds: 3),
                backgroundColor: const Color(0xFF6C5CE7),
              ),
            );
          },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.notifications_active_outlined,
              color: const Color(0xFF6C5CE7),
              size: 16.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              'Notify Me',
              style: TextStyle(
                color: const Color(0xFF6C5CE7),
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget shown when user is in a supported country but still loading accounts
class AccountLoadingState extends StatelessWidget {
  const AccountLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6C5CE7),
            Color(0xFF4834D4),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
            SizedBox(height: 16.h),
            Text(
              'Loading your accounts...',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
