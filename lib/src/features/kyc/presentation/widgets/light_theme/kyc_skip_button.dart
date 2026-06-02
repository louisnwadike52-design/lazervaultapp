import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// "Skip for now" text button, centered and styled in muted grey to match
/// the BVN screen's skip CTA.
class KycSkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const KycSkipButton({
    super.key,
    required this.onPressed,
    this.text = 'Skip for now',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
