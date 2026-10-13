import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A tiny disk cache for the FIRST page of the two Group Funds lists.
///
/// WHY ONLY PAGE 1, AND ONLY THE FIRST PAGE
/// ----------------------------------------
/// The point is the cold start: the list a member looks at every time they
/// open the feature, painted before the network answers. Page 4 of a group's
/// contributions is not that — nobody opens the app to page 4, and caching
/// every page turns a reminder of what you have into a stale shadow of it.
///
/// WHY IT IS SCOPED BY USER
/// ------------------------
/// Two people share a phone more often than product analytics suggests.
/// Keying on the user id means the next person to sign in cannot be shown
/// the previous one's groups for the half second before the fetch lands —
/// which is a privacy failure, not a rendering glitch.
///
/// EVERYTHING HERE IS BEST-EFFORT. A cache that cannot be read is a cache
/// miss, and a cache that cannot be written is a slower next launch. Neither
/// is worth an error in front of someone who opened a list.
class GroupFundsPageCache {
  const GroupFundsPageCache._();

  /// Beyond this the cached page is not shown at all.
  ///
  /// It is a head start, not an offline mode: a week-old list of groups
  /// would show contributions that have since closed and members who have
  /// left, and the user would act on it before the refresh landed.
  static const Duration maxAge = Duration(hours: 12);

  static const String _groupsPrefix = 'gf_cache_groups_v1_';
  static const String _contributionsPrefix = 'gf_cache_contribs_v1_';

  static String _groupsKey(String userId) => '$_groupsPrefix$userId';
  static String _contributionsKey(String userId, String groupId) =>
      '$_contributionsPrefix${userId}_$groupId';

  /// Store the first page as the raw JSON the caller already has.
  ///
  /// Deliberately untyped: this file has no business knowing the shape of a
  /// group or a contribution, and a schema change in those entities must
  /// not be able to make the cache un-writable.
  static Future<void> writeGroups(
    String userId,
    List<Map<String, dynamic>> page,
  ) =>
      _write(_groupsKey(userId), page);

  static Future<List<Map<String, dynamic>>?> readGroups(String userId) =>
      _read(_groupsKey(userId));

  static Future<void> writeContributions(
    String userId,
    String groupId,
    List<Map<String, dynamic>> page,
  ) =>
      _write(_contributionsKey(userId, groupId), page);

  static Future<List<Map<String, dynamic>>?> readContributions(
    String userId,
    String groupId,
  ) =>
      _read(_contributionsKey(userId, groupId));

  /// Drop everything this cache holds.
  ///
  /// Called on logout and on a user switch. Clearing by PREFIX rather than
  /// by the keys we think exist: a group the previous user belonged to and
  /// this one does not would otherwise keep its cached contributions on the
  /// device indefinitely.
  static Future<void> clearAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final doomed = prefs
          .getKeys()
          .where((k) =>
              k.startsWith(_groupsPrefix) || k.startsWith(_contributionsPrefix))
          .toList();
      for (final k in doomed) {
        await prefs.remove(k);
      }
    } catch (e) {
      debugPrint('[GroupFundsPageCache] clear failed: $e');
    }
  }

  static Future<void> _write(
      String key, List<Map<String, dynamic>> page) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        key,
        jsonEncode({
          'at': DateTime.now().toUtc().toIso8601String(),
          'items': page,
        }),
      );
    } catch (e) {
      debugPrint('[GroupFundsPageCache] write failed: $e');
    }
  }

  static Future<List<Map<String, dynamic>>?> _read(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null || raw.isEmpty) return null;

      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;

      final at = DateTime.tryParse((decoded['at'] as String?) ?? '');
      // No timestamp means we cannot tell how old it is, and "unknown age"
      // has to be treated as too old — the whole guard is pointless if it
      // can be bypassed by a malformed entry.
      if (at == null || DateTime.now().toUtc().difference(at) > maxAge) {
        await prefs.remove(key);
        return null;
      }

      final items = decoded['items'];
      if (items is! List) return null;
      return items
          .whereType<Map>()
          .map((m) => Map<String, dynamic>.from(m))
          .toList();
    } catch (e) {
      debugPrint('[GroupFundsPageCache] read failed: $e');
      return null;
    }
  }
}
