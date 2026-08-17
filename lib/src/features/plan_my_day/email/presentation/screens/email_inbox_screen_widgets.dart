part of 'email_inbox_screen.dart';

class _ConnectBanner extends StatelessWidget {
  final String? message;
  const _ConnectBanner({this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(22.w),
              decoration: BoxDecoration(
                color: EmailPalette.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.mail_outline_rounded,
                  color: EmailPalette.primary, size: 44.sp),
            ),
            SizedBox(height: 20.h),
            Text(
              'Connect your Gmail',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'Let Lazervault summarize your inbox, draft replies and turn your '
              'emails into tasks and events for the day.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: EmailPalette.textSecondary, fontSize: 13.sp, height: 1.5),
            ),
            if (message != null && message!.isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: EmailPalette.error, fontSize: 12.5.sp),
              ),
            ],
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => context.read<EmailCubit>().connect(),
                icon: const Icon(Icons.login_rounded, size: 20),
                label: Text('Connect Gmail',
                    style: GoogleFonts.inter(
                        fontSize: 15.sp, fontWeight: FontWeight.w600)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: EmailPalette.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
