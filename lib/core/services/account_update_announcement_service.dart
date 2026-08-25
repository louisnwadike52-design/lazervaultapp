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

  Future<void> _showModal(
      BuildContext context, AccountUpdateAnnouncement ann) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF16162A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
              ),
              child: Icon(Icons.account_balance_outlined,
                  color: const Color(0xFF9B6DFF), size: 28.sp),
            ),
            SizedBox(height: 16.h),
            Text(ann.title,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 12.h),
            Text(ann.body,
                style: GoogleFonts.inter(
                    color: const Color(0xFFB6B9C6),
                    fontSize: 14.sp,
                    height: 1.55)),
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
            SizedBox(height: 10.h),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: Text('Got it',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
