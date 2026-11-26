import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_desk_api.dart';
import 'support_desk_screen.dart';

/// THE SUPPORT DESK, ON THE DASHBOARD, FOR THE PEOPLE WHO WORK IT.
///
/// ## Why it is here and not only in Settings
///
/// The desk lived one level down, in Settings → Help. An agent's job is to
/// notice a waiting customer, and the screen they actually look at is the
/// dashboard — so the queue was three taps from the only surface they keep
/// open, with no indication that anybody was waiting. A responder reported
/// not being able to find it at all, which is the correct conclusion from
/// where it was.
///
/// It sits beside the notification bell and the voice button: the same row,
/// the same shape, the same size. An agent's tools belong with the app's other
/// tools, not in a special place.
///
/// ## It renders NOTHING for almost everyone
///
/// Access comes from the server (`/support/desk-access`, resolved from the
/// role claim), so it is asynchronous and the widget is a zero-width box until
/// it answers — not a placeholder and not a spinner. A header that flashes an
/// unknown icon tells every customer the feature exists.
///
/// ## Hiding it is not the control
///
/// support-service re-checks the admin claim on every request it serves, so a
/// customer who reached the route by hand gets an empty, refusing screen. This
/// exists so the other 99% are not shown a door they cannot open.
class SupportDeskHeaderButton extends StatefulWidget {
  const SupportDeskHeaderButton({super.key, this.iconColour});

  /// The dashboard header draws on a dark gradient, so the default is white.
  /// Passed explicitly by any host whose ground differs.
  final Color? iconColour;

  @override
  State<SupportDeskHeaderButton> createState() =>
      _SupportDeskHeaderButtonState();
}

class _SupportDeskHeaderButtonState extends State<SupportDeskHeaderButton> {
  late final SupportDeskApi _api =
      SupportDeskApi(serviceLocator<SecureStorageService>());

  /// null = still asking. Distinct from false so the button cannot flash in
  /// and out on a slow answer.
  bool? _canUse;

  /// How many tickets in the open queue have something this agent has not
  /// read. The number an agent decides what to do next from.
  int _waiting = 0;

  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    // access() never throws and answers "no" on any failure, so a support
    // outage renders no button rather than an error on the dashboard.
    final access = await _api.access();
    if (!mounted) return;
    setState(() => _canUse = access.canUse);
    if (!access.canUse) return;

    await _refreshBadge();
    // THE POLL IS ONLY STARTED FOR AN AGENT.
    //
    // A customer never reaches this line, so the dashboard gains no periodic
    // request for the overwhelming majority of people. Two minutes rather than
    // seconds: the badge answers "is anyone waiting", which does not change
    // meaningfully inside a minute, and the desk itself refetches on open.
    _poll = Timer.periodic(const Duration(minutes: 2), (_) => _refreshBadge());
  }

  Future<void> _refreshBadge() async {
    try {
      final rows = await _api.queue(status: 'open', limit: 40);
      if (!mounted) return;
      setState(() =>
          _waiting = rows.where((t) => t.unreadForAdmin > 0).length);
    } catch (_) {
      // A failed count leaves the previous one. Zeroing it on a transport
      // error would tell an agent the queue is clear when it is not, which is
      // the one wrong answer this badge can give.
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_canUse != true) return const SizedBox.shrink();
    final colour = widget.iconColour ?? Colors.white;

    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              tooltip: 'Support desk',
              padding: EdgeInsets.zero,
              icon: Icon(Icons.headset_mic_outlined,
                  color: colour, size: 20.sp),
              onPressed: () async {
                await Get.to(() => const SupportDeskScreen());
                // The agent has almost certainly read something. Refetched on
                // the way back so the badge does not keep claiming a queue
                // they just worked.
                if (mounted) _refreshBadge();
              },
            ),
            if (_waiting > 0)
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  constraints: BoxConstraints(minWidth: 16.w),
                  height: 16.w,
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // Red, not the brand colour: this is "somebody is
                    // waiting", and an agent has to be able to tell it apart
                    // from the decoration at a glance.
                    color: const Color(0xFFEF4444),
                    borderRadius: BorderRadius.circular(8.w),
                    border: Border.all(color: Colors.black26, width: 0.5),
                  ),
                  child: Text(
                    // Capped so a busy morning cannot push the badge across
                    // the row.
                    _waiting > 9 ? '9+' : '$_waiting',
                    style: TextStyle(
                      fontSize: 9.sp,
                      height: 1,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
