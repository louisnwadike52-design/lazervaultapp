import 'package:flutter/material.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';

/// Thin compatibility wrapper around the shared [UnifiedUserSearchSheet].
///
/// Historically this was its own bottom sheet (with a duplicate gRPC search and
/// its own device-contacts mode). It now delegates entirely to the canonical
/// [UnifiedUserSearchSheet] — local-first alias-aware directory search plus the
/// "From contacts" mode (on-Lazervault / Invite badges) — while preserving the
/// `Future<UserSearchResultEntity?>` contract its callers already expect. Kept
/// as a named entry point so the existing call sites don't need to change.
class UsernameSearchBottomSheet {
  const UsernameSearchBottomSheet._();

  /// Show the shared search sheet and return the picked user (or null).
  static Future<UserSearchResultEntity?> show(BuildContext context) async {
    final picked = await UnifiedUserSearchSheet.show(
      context,
      title: 'Find recipient',
    );
    return picked?.toUserSearchResultEntity();
  }
}
