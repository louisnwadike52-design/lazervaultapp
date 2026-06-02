import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/shared_widgets/app_loading_button.dart';

/// Full-width primary CTA wrapper around AppLoadingButton.
/// Standardizes height + width so screens stop repeating the SizedBox boilerplate.
class KycPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const KycPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: AppLoadingButton(
        onPressed: isLoading ? null : onPressed,
        isLoading: isLoading,
        text: text,
      ),
    );
  }
}
