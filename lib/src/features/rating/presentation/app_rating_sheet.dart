import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'satisfaction_emoji_scale.dart';
import 'package:lazervault/core/widgets/app_bottom_sheet.dart';

/// The star-rating prompt.
///
/// ## Why the stars are asked for first and the words second
///
/// A star is one tap; a comment is a paragraph. Asking for the paragraph up
/// front is how you get three ratings a week. The sheet takes the tap, and only
/// then asks for more — from people who have already engaged.
///
/// ## Why a happy rating and an unhappy one go different places
///
/// Someone who taps four or five stars is told where to say so publicly.
/// Someone who taps one or two is offered support instead, because the useful
/// response to an unhappy customer is to fix their problem, not to hand them a
/// review box. This is not review-gating: the unhappy path still RECORDS the
/// rating, and nothing stops them reviewing the app themselves. It only decides
/// which door we hold open.
///
/// ## Why it is a sheet and not a dialog
///
/// It is dismissible by dragging, which is the gesture people reach for when
/// they do not want to answer — and a prompt that is hard to dismiss is a
/// prompt people learn to resent.
Future<void> showAppRatingSheet(BuildContext context) async {
  await showAppBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    // Dismissible on purpose; the server records the ask either way, so a drag
    // costs the customer nothing and still starts the interval.
    isDismissible: true,
    builder: (_) => const _AppRatingSheet(),
  );
}

class _AppRatingSheet extends StatefulWidget {
  const _AppRatingSheet();

  @override
  State<_AppRatingSheet> createState() => _AppRatingSheetState();
}

class _AppRatingSheetState extends State<_AppRatingSheet>
    with SingleTickerProviderStateMixin {
  static const _accent = Color(0xFF4834D4);
  static const _star = Color(0xFFF5A623);

  int _stars = 0;
  bool _busy = false;
  bool _askingWhy = false;
  final _comment = TextEditingController();

  late final AnimationController _pop = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  );

  /// Which scale this showing uses. Resolved ONCE, in initState, so it cannot
  /// change under the customer mid-answer — a scale that swapped between a tap
  /// and a submit would make the rating mean something different to the person
  /// who gave it than to the person reading it.
  late bool _useEmoji = FeatureFlags.appRatingScaleMode != 'stars';

  @override
  void initState() {
    super.initState();
    if (FeatureFlags.appRatingScaleMode == 'alternate') {
      // Alternate by SHOWING, not at random: a counter gives a clean split and
      // is reproducible when reading the results back, which random sampling
      // on a small audience is not.
      SharedPreferences.getInstance().then((prefs) {
        const k = 'app_rating_scale_alt_count';
        final n = (prefs.getInt(k) ?? 0) + 1;
        prefs.setInt(k, n);
        if (mounted) setState(() => _useEmoji = n.isEven);
      });
    }
  }

  @override
  void dispose() {
    _pop.dispose();
    _comment.dispose();
    super.dispose();
  }

  void _tapStar(int n) {
    setState(() => _stars = n);
    // One short pop on the whole row rather than a per-star animation: the
    // feedback is "that registered", and five independently animating glyphs
    // read as a loading state.
    _pop
      ..reset()
      ..forward();
  }

  Future<({String platform, String version})> _appIdentity() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return (
        platform: Platform.isIOS ? 'ios' : 'android',
        version: '${info.version}+${info.buildNumber}',
      );
    } catch (_) {
      // A rating without a version is still worth having; a crash here is not.
      return (platform: Platform.isIOS ? 'ios' : 'android', version: '');
    }
  }

  Future<void> _submit({bool toStore = false}) async {
    if (_stars < 1 || _busy) return;
    setState(() => _busy = true);
    final api = SupportApi(serviceLocator<SecureStorageService>());
    final id = await _appIdentity();
    await api.submitRating(
      stars: _stars,
      comment: _comment.text.trim(),
      platform: id.platform,
      appVersion: id.version,
      sentToStore: toStore,
    );
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _openStore() async {
    // The store links are the SAME admin-tunable values the update prompt uses,
    // so a changed listing is corrected in one place rather than two.
    final url = Platform.isIOS
        ? FeatureFlags.appStoreUrlIos
        : FeatureFlags.appStoreUrlAndroid;
    // Recorded BEFORE launching: once the OS takes over we never hear back, so
    // "we sent them" is the only honest thing to store. We never claim a review
    // happened — the store owns that.
    await _submit(toStore: true);
    if (url.trim().isEmpty) return;
    try {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } catch (_) {
      // A dead link must not take the sheet down with it.
    }
  }

  Future<void> _notNow() async {
    if (_busy) return;
    setState(() => _busy = true);
    final api = SupportApi(serviceLocator<SecureStorageService>());
    await api.snoozeRating();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final happy = _stars >= 4;
    return Padding(
      // Lifts above the keyboard when the comment box is open.
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        padding: EdgeInsets.fromLTRB(22.w, 10.h, 22.w, 22.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFE3E1EC),
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              _askingWhy ? 'What would make it better?' : 'How are we doing?',
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF14131A)),
            ),
            SizedBox(height: 6.h),
            Text(
              _askingWhy
                  ? 'Only our team sees this. Say as much or as little as you like.'
                  : 'A quick tap helps us know what to fix next.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 13.sp,
                  height: 1.45,
                  color: const Color(0xFF6B6A7B)),
            ),
            SizedBox(height: 20.h),

            if (!_askingWhy && _useEmoji) ...[
              // Faces. They ask "how was that for you" rather than "rate us",
              // which is the question this sheet actually wants answered, and
              // each carries a word so the meaning cannot be read differently
              // across platforms or cultures.
              SatisfactionEmojiScale(
                value: _stars,
                enabled: !_busy,
                onChanged: _tapStar,
              ),
              SizedBox(height: 14.h),
            ] else if (!_askingWhy) ...[
              // The stars. A short scale on the row when one is tapped, so the
              // tap is acknowledged without animating five things at once.
              ScaleTransition(
                scale: Tween<double>(begin: 1, end: 1.06).animate(
                  CurvedAnimation(parent: _pop, curve: Curves.easeOutBack),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (i) {
                    final n = i + 1;
                    final filled = n <= _stars;
                    return Semantics(
                      button: true,
                      label: '$n star${n == 1 ? '' : 's'}',
                      selected: filled,
                      child: IconButton(
                        onPressed: _busy ? null : () => _tapStar(n),
                        icon: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 160),
                          child: Icon(
                            filled
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            key: ValueKey(filled),
                            size: 38.sp,
                            color: filled ? _star : const Color(0xFFCFCDD8),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 14.h),
            ] else ...[
              TextField(
                controller: _comment,
                maxLines: 4,
                maxLength: 2000,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'What got in your way?',
                  filled: true,
                  fillColor: const Color(0xFFF6F5FB),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none),
                ),
              ),
              SizedBox(height: 8.h),
            ],

            if (_stars > 0 && !_askingWhy)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _busy
                      ? null
                      : happy
                          ? _openStore
                          : () => setState(() => _askingWhy = true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(
                    happy ? 'Rate us on the store' : 'Tell us more',
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700),
                  ),
                ),
              ),

            if (_askingWhy)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _busy ? null : () => _submit(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text('Send',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w700)),
                ),
              ),

            SizedBox(height: 6.h),
            TextButton(
              onPressed: _busy ? null : _notNow,
              child: Text(
                'Not now',
                style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF6B6A7B),
                    fontWeight: FontWeight.w600),
              ),
            ),
            // An unhappy customer is offered the one thing that actually helps:
            // a person. Shown only once they have told us something is wrong,
            // so it never competes with the rating itself.
            if (_stars > 0 && _stars <= 2 && !_askingWhy)
              TextButton(
                onPressed: _busy
                    ? null
                    : () {
                        Navigator.of(context).pop();
                        Get.to(() => const SupportTicketsScreen());
                      },
                child: Text('Talk to support instead',
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: _accent,
                        fontWeight: FontWeight.w600)),
              ),
          ],
        ),
      ),
    );
  }
}
