import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/core/config/mono_config.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_cubit.dart';
import 'package:lazervault/src/features/open_banking/cubit/open_banking_state.dart';
import 'package:lazervault/src/features/ai_scan_to_pay/presentation/widgets/mono_connect_widget.dart';

/// Mono Direct Debit Bottomsheet - Matches exact Mono Connect design
/// Custom bottomsheet that displays Mono info before launching Mono Connect WebView
class MonoDirectDebitBottomsheet extends StatefulWidget {
  final Map<String, dynamic> selectedAccount;
  final VoidCallback onSuccess;
  final Function(String message) onError;
  final OpenBankingCubit openBankingCubit;

  const MonoDirectDebitBottomsheet({
    super.key,
    required this.selectedAccount,
    required this.onSuccess,
    required this.onError,
    required this.openBankingCubit,
  });

  @override
  State<MonoDirectDebitBottomsheet> createState() => _MonoDirectDebitBottomsheetState();
}

class _MonoDirectDebitBottomsheetState extends State<MonoDirectDebitBottomsheet> {
  bool _isLinking = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.openBankingCubit,
      child: BlocListener<OpenBankingCubit, OpenBankingState>(
        listener: (context, state) {
        print('[Deposit] OpenBankingListener received state: ${state.runtimeType}');

        if (state is AccountLinked) {
          print('[Deposit] Account linked: ${state.account.id}, bankName: ${state.account.bankName}');
          setState(() => _isLinking = false);
          Navigator.pop(context);
          widget.onSuccess();
        } else if (state is AccountLinkingInProgress) {
          setState(() => _isLinking = true);
        } else if (state is OpenBankingError) {
          print('[Deposit] OpenBankingError: ${state.message}, operation: ${state.operation}');
          setState(() => _isLinking = false);
          widget.onError(state.message);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A5F),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Secure Connection Badge
            Container(
              margin: EdgeInsets.only(top: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1E3A5F),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.verified_user, color: const Color(0xFF4CAF50), size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Secure Connection',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.h),

            // Purple Header Bar
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: const BoxDecoration(
                color: Color(0xFF6C5CE7),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white, size: 18.sp),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Link Access Bank',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock, color: Colors.white, size: 12.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Secure',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // White content area
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 16.h),

                  // Mono logo and close button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Spacer(),
                      // Mono Logo
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ꟿ',
                            style: TextStyle(
                              color: const Color(0xFF182CD1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            'mono',
                            style: TextStyle(
                              color: const Color(0xFF182CD1),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.close, color: Colors.grey[600], size: 24.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // TEST MODE badge
                  if (MonoConfig.isTestMode)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE53935),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        'TEST MODE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  SizedBox(height: 12.h),

                  // App Icon
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF6C5CE7), Color(0xFF8E7CF3)],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.shield,
                      color: Colors.white,
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Title text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Lazervault ',
                          style: TextStyle(color: Color(0xFF6C5CE7)),
                        ),
                        TextSpan(
                          text: 'uses ',
                          style: TextStyle(color: Color(0xFF1A1A1A)),
                        ),
                        TextSpan(
                          text: 'Mono',
                          style: TextStyle(
                            color: Color(0xFF182CD1),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: '\nto link your account',
                          style: TextStyle(color: Color(0xFF1A1A1A)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Features list
                  _buildFeatureItem(
                    Icons.public,
                    'Trust.',
                    'Over 100 businesses trust Mono to securely connect to financial institutions',
                  ),
                  SizedBox(height: 16.h),
                  _buildFeatureItem(
                    Icons.visibility_off_outlined,
                    'Private.',
                    'Your credentials are safe and will never be made accessible to Lazervault',
                  ),
                  SizedBox(height: 16.h),
                  _buildFeatureItem(
                    Icons.lock_outline,
                    'Secure.',
                    'Mono uses (AES-256) encryption technology to help safeguard your data',
                  ),
                  SizedBox(height: 24.h),

                  // Divider
                  Divider(color: Colors.grey[200], height: 1),
                  SizedBox(height: 16.h),

                  // Terms text
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.sp,
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(text: "By clicking 'Link account' you agree to "),
                        TextSpan(
                          text: "Mono's End-user Policy",
                          style: TextStyle(
                            color: const Color(0xFF182CD1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const TextSpan(text: '.\n'),
                        const TextSpan(text: 'Mono will have read-only access to your account. '),
                        TextSpan(
                          text: 'See details',
                          style: TextStyle(
                            color: const Color(0xFF182CD1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Link Account Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLinking ? null : _launchMonoConnect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF182CD1),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        elevation: 0,
                      ),
                      child: _isLinking
                          ? SizedBox(
                              height: 20.h,
                              width: 20.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ꟿ',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Link account',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[700], size: 18.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 13.sp,
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: title,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: ' $description'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _launchMonoConnect() async {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      widget.onError('Please log in to continue');
      return;
    }

    if (!MonoConfig.isEnabled) {
      widget.onError('Mono integration is not configured. Please contact support.');
      return;
    }

    final user = authState.profile.user;
    final userId = user?.id ?? '';
    final accessToken = authState.profile.session.accessToken;
    final customerName = '${user?.firstName ?? ''} ${user?.lastName ?? ''}'.trim();
    final customerEmail = user?.email ?? '';

    print('[MonoConnect] Launching Mono Connect SDK bottomsheet');
    print('[MonoConnect] Customer: $customerName ($customerEmail)');
    print('[MonoConnect] User ID: $userId');

    // Close our custom info bottomsheet first
    Navigator.pop(context);

    // Launch Mono Connect using the native SDK (shows as bottomsheet)
    final result = await showMonoConnectBottomSheet(
      context: context,
      publicKey: MonoConfig.publicKey,
      customerName: customerName.isNotEmpty ? customerName : null,
      customerEmail: customerEmail.isNotEmpty ? customerEmail : null,
      reference: 'lzv_deposit_${DateTime.now().millisecondsSinceEpoch}',
    );

    if (result != null) {
      print('[MonoConnect] Success - Code: ${result.code.substring(0, result.code.length > 10 ? 10 : result.code.length)}...');
      print('[MonoConnect] Institution: ${result.institutionName ?? result.institutionId ?? 'unknown'}');

      // Link the account using the OpenBankingCubit
      widget.openBankingCubit.linkAccount(
        userId: userId,
        code: result.code,
        accessToken: accessToken,
      );

      widget.onSuccess();
    } else {
      print('[MonoConnect] User cancelled or closed');
    }
  }
}

/// Show Mono Direct Debit bottomsheet
void showMonoDirectDebitBottomsheet({
  required BuildContext context,
  required Map<String, dynamic> selectedAccount,
  required VoidCallback onSuccess,
  required Function(String message) onError,
  required OpenBankingCubit openBankingCubit,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      maxChildSize: 0.92,
      minChildSize: 0.5,
      builder: (_, controller) => MonoDirectDebitBottomsheet(
        selectedAccount: selectedAccount,
        onSuccess: onSuccess,
        onError: onError,
        openBankingCubit: openBankingCubit,
      ),
    ),
  );
}
