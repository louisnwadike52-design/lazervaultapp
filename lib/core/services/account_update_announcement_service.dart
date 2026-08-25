import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'endpoint_registry.dart';

/// Server-driven "your account details changed" announcement — shown once per
/// user per version after a virtual-account provider migration (the deposit
/// account number changes when the banking rail behind the wallet switches).
///
/// Admin-authored via the `announce_va_migration` system-settings key (JSON:
/// {"version": 1, "title": "...", "body": "...", "cta": "..."}), fetched from
/// the same no-auth internal settings endpoint the dashboard adverts / help
/// config use. Never throws — an unreachable backend or malformed value
/// simply shows nothing. The admin publishes the announcement AFTER a
/// migration batch completes, so its audience is the migrated user base.
///
/// Seen-state is per user+version in SharedPreferences (survives logout, the
/// walkthrough pattern). NOTE: a server-side ack endpoint is intentionally
/// deferred until the next accounts proto regen; the operational audit of who
/// was migrated when lives in accounts.account_provider_history.
class AccountUpdateAnnouncement {
  final int version;
  final String title;
  final String body;
  final String cta;

  const AccountUpdateAnnouncement({
    required this.version,
    required this.title,
    required this.body,
    required this.cta,
  });
}

class AccountUpdateAnnouncementService {
  AccountUpdateAnnouncementService._();
  static final AccountUpdateAnnouncementService instance =
      AccountUpdateAnnouncementService._();

  static const _settingKey = 'announce_va_migration';

  AccountUpdateAnnouncement? _announcement;
  DateTime? _fetchedAt;
  static const _ttl = Duration(minutes: 30);

  static String _seenKey(String userId, int version) =>
      'va_migration_announce_seen_v${version}_$userId';

  /// Fetches (with TTL cache) and, when unseen for this user, shows the
  /// modal. Call after first frame from a post-auth surface (dashboard).
  /// Best-effort end to end — never blocks or breaks the caller.
  Future<void> maybeShow(BuildContext context, {required String userId}) async {
    if (userId.isEmpty) return;
    try {
      final ann = await _ensure();
      if (ann == null || ann.version <= 0) return;
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString(_seenKey(userId, ann.version)) == 'true') return;
      if (!context.mounted) return;
      await _showModal(context, ann);
      await prefs.setString(_seenKey(userId, ann.version), 'true');
    } catch (_) {/* best-effort — no announcement is never an error */}
  }

  Future<AccountUpdateAnnouncement?> _ensure() async {
    if (_fetchedAt != null && DateTime.now().difference(_fetchedAt!) < _ttl) {
      return _announcement;
    }
    try {
      final res = await http
          .get(Uri.parse(endpointRegistry.adminSettingsEndpoint))
          .timeout(const Duration(seconds: 6));
      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        final list = body is Map<String, dynamic> ? body['settings'] : null;
        if (list is List) {
          String? raw;
          for (final s in list) {
            if (s is Map && s['key'] == _settingKey && s['value'] is String) {
              raw = s['value'] as String;
              break;
            }
          }
          _announcement = _parse(raw);
          _fetchedAt = DateTime.now();
        }
      }
    } catch (_) {/* keep last good / null */}
    return _announcement;
  }

  AccountUpdateAnnouncement? _parse(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return null;
      final versionRaw = decoded['version'];
      final version =
          versionRaw is int ? versionRaw : int.tryParse('${versionRaw ?? ''}') ?? 0;
      if (version <= 0) return null;
      return AccountUpdateAnnouncement(
        version: version,
        title: (decoded['title'] ?? '').toString().trim().isNotEmpty
            ? decoded['title'].toString().trim()
            : 'Your account details have been updated',
        body: (decoded['body'] ?? '').toString().trim().isNotEmpty
            ? decoded['body'].toString().trim()
            : 'We\'ve upgraded the banking infrastructure behind your '
                'LazerVault wallet. Your deposit account number has changed as '
                'part of this upgrade. Your balance, transaction history and '
                'everything else remain exactly as they were — only the '
                'account number you share to receive money is new. Please use '
                'your updated account details for all future deposits.',
        cta: (decoded['cta'] ?? '').toString().trim().isNotEmpty
            ? decoded['cta'].toString().trim()
            : 'View updated account details',
      );
    } catch (_) {
      return null;
    }
  }

  /// A polished centered dialog — shown AFTER login lands on the dashboard
  /// (the fetch + gating run in the background post-frame, so the login flow
  /// is never blocked; the dialog appears once the check completes).
  Future<void> _showModal(
      BuildContext context, AccountUpdateAnnouncement ann) async {
    await showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Account update',
      barrierColor: Colors.black.withValues(alpha: 0.65),
      transitionDuration: const Duration(milliseconds: 220),
      transitionBuilder: (ctx, anim, _, child) => FadeTransition(
        opacity: anim,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.94, end: 1).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        ),
      ),
      pageBuilder: (ctx, _, __) => Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 340.w,
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF16162A),
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 40,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 64.w,
                  height: 64.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF4E03D0).withValues(alpha: 0.35),
                        const Color(0xFF4E03D0).withValues(alpha: 0.12),
                      ],
                    ),
                    border: Border.all(
                        color: const Color(0xFF9B6DFF).withValues(alpha: 0.35)),
                  ),
                  child: Icon(Icons.account_balance_outlined,
                      color: const Color(0xFF9B6DFF), size: 30.sp),
                ),
                SizedBox(height: 18.h),
                Text(ann.title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w700,
                        height: 1.3)),
                SizedBox(height: 12.h),
                Text(ann.body,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: const Color(0xFFB6B9C6),
                        fontSize: 13.5.sp,
                        height: 1.6)),
                SizedBox(height: 24.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      Get.toNamed(AppRoutes.myAccount);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text(ann.cta,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
                SizedBox(height: 6.h),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text('Got it',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
