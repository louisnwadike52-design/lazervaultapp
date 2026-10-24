library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/chat_theme_preference.dart';

/// PICK WHAT THE ASSISTANT LOOKS LIKE.
///
/// The three-dot menu offered Clear, Export and AI Settings — everything
/// about what the assistant SAYS and nothing about how it looks, on a screen
/// people keep open for a long time.
///
/// Deliberately small: six accents and one bubble-shape switch, with a live
/// preview. A colour picker would let someone choose a shade their own
/// messages cannot be read on; these six have each been checked against the
/// chat's dark surface.
class ChatThemeSheet extends StatefulWidget {
  const ChatThemeSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ChatThemeSheet(),
    );
  }

  @override
  State<ChatThemeSheet> createState() => _ChatThemeSheetState();
}

class _ChatThemeSheetState extends State<ChatThemeSheet> {
  late String _accentId;
  late bool _rounded;

  @override
  void initState() {
    super.initState();
    _accentId = ChatThemePreference.accent.id;
    _rounded = ChatThemePreference.roundedBubbles;
  }

  Future<void> _pick(String id) async {
    setState(() => _accentId = id);
    // Applied immediately rather than behind a Save: the preview above is the
    // confirmation, and a theme you have to commit to before seeing it on the
    // real screen is a worse way to choose one.
    await ChatThemePreference.setAccent(id);
  }

  Future<void> _setRounded(bool v) async {
    setState(() => _rounded = v);
    await ChatThemePreference.setRoundedBubbles(v);
  }

  @override
  Widget build(BuildContext context) {
    final accent = ChatThemePreference.byId(_accentId);
    final radius = _rounded ? 18.0 : 8.0;

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.palette_outlined,
                    color: accent.primary, size: 20.sp),
                SizedBox(width: 8.w),
                Text('Chat theme',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            SizedBox(height: 16.h),

            // The preview IS the confirmation.
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0F0F0F),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [accent.primary, accent.secondary]),
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Text('How much did I spend on bills?',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(radius),
                      ),
                      child: Text('NGN 12,400 across 6 bills this month.',
                          style: TextStyle(
                              color: Colors.grey[300], fontSize: 12.sp)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18.h),

            Text('Accent',
                style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10.h),
            Wrap(
              spacing: 12.w,
              runSpacing: 12.h,
              children: [
                for (final a in ChatThemePreference.accents)
                  GestureDetector(
                    onTap: () => _pick(a.id),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [a.primary, a.secondary]),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: a.id == _accentId
                                  ? Colors.white
                                  : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: a.id == _accentId
                              ? Icon(Icons.check,
                                  color: Colors.white, size: 20.sp)
                              : null,
                        ),
                        SizedBox(height: 4.h),
                        Text(a.label,
                            style: TextStyle(
                                color: a.id == _accentId
                                    ? Colors.white
                                    : Colors.grey[500],
                                fontSize: 11.sp)),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 18.h),

            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _rounded,
              onChanged: _setRounded,
              activeThumbColor: accent.primary,
              title: Text('Rounded bubbles',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              subtitle: Text('Off gives message bubbles square corners.',
                  style: TextStyle(color: Colors.grey[500], fontSize: 11.sp)),
            ),

            if (ChatThemePreference.hasUserChoice)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () async {
                    await ChatThemePreference.clearAccent();
                    if (!mounted) return;
                    setState(() => _accentId = ChatThemePreference.accent.id);
                  },
                  // Back to what the platform sets, which is not necessarily
                  // the first swatch — "reset" must mean the same as "never
                  // chose".
                  child: Text('Use the default',
                      style:
                          TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
