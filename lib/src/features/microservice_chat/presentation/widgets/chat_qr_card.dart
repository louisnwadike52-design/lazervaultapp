import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

/// The SCANNABLE QR code, rendered inline in chat.
///
/// The assistant used to answer "create a QR code" with a markdown block
/// listing the code as text. That describes the thing without delivering it:
/// a QR code exists to be scanned or shown to someone, and neither is possible
/// from a string in a chat bubble — the user had to go and find it in the QR
/// Pay screens instead.
///
/// Payload comes from `attach_qr_card` (chat_services_shared/protocol_emit.py)
/// on `metadata.qr_card`.
class ChatQrCard extends StatelessWidget {
  const ChatQrCard({super.key, required this.payload});

  final Map<String, dynamic> payload;

  String _str(String key) => payload[key]?.toString().trim() ?? '';

  @override
  Widget build(BuildContext context) {
    final code = _str('qr_code');
    // Nothing to encode means nothing to draw. Rendering an empty QR would
    // give the user a scannable image that resolves to nothing, which is
    // worse than the text-only answer this replaces.
    if (code.isEmpty) return const SizedBox.shrink();

    final type = _str('qr_type');
    final amount = _str('amount_label');
    final status = _str('status');
    final description = _str('description');
    final expires = _str('expires_at');

    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F2E),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D3D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              // The quiet zone MUST be white. A dark-themed card behind a
              // transparent QR is a common way to make a code unscannable.
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: QrImageView(
                data: code,
                version: QrVersions.auto,
                size: 180.w,
                gapless: true,
                errorStateBuilder: (_, __) => SizedBox(
                  width: 180.w,
                  height: 180.w,
                  child: Center(
                    child: Text(
                      'Could not draw this code',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: Colors.black54, fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          _row('Code', code, copyable: true, context: context),
          if (type.isNotEmpty) _row('Type', type),
          if (amount.isNotEmpty) _row('Amount', amount),
          if (status.isNotEmpty) _row('Status', status),
          if (description.isNotEmpty) _row('Description', description),
          if (expires.isNotEmpty) _row('Valid until', expires),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _action(
                  icon: Icons.copy_rounded,
                  label: 'Copy code',
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: code));
                    if (!context.mounted) return;
                    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                      const SnackBar(content: Text('QR code copied')),
                    );
                  },
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: _action(
                  icon: Icons.ios_share_rounded,
                  label: 'Share',
                  onTap: () => SharePlus.instance.share(
                    ShareParams(
                      text: 'Pay me with this Lazervault QR code: $code',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {bool copyable = false, BuildContext? context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92.w,
            child: Text(label,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF), fontSize: 11.5.sp)),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.5.sp,
                fontWeight: copyable ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _action({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3D),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 15.sp, color: Colors.white),
            SizedBox(width: 6.w),
            Text(label,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
