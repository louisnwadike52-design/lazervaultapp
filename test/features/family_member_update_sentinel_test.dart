import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "Do not change" is a NEGATIVE value, not 0.
///
/// THE DATA-LOSS BUG THIS CATCHES, WHICH WAS LIVE
/// ----------------------------------------------
/// UpdateFamilyMember's proto uses plain doubles, which default to 0 and carry
/// no field presence. accounts-service therefore adopted `>= 0 means apply`, so
/// a NEGATIVE value is the only way to say "leave this alone":
///
///     if req.AllocatedBalance >= 0 { updates["allocated_balance"] = ... }
///
/// The Dart datasource was sending `req.allocatedBalance ?? 0.0` — so every
/// field the caller omitted arrived as 0 and was APPLIED. Two live flows relied
/// on omission meaning "unchanged":
///
///   * Edit Limits passes null for every field the user did not modify
///     (`_modifiedFields.contains('daily') ? value : null`). Editing only the
///     daily limit therefore ZEROED the member's allocated balance and all
///     other limits.
///   * The setup wizard applies the three spending limits and omits
///     allocatedBalance — wiping the allocation it had just configured.
///
/// Both look correct at the call site. The loss happened one layer down.
final _grpc = File(
  'lib/src/features/family_account/data/datasources/family_account_grpc_data_source.dart',
).readAsStringSync();

String get _code => _grpc
    .split('\n')
    .where((l) => !l.trimLeft().startsWith('//'))
    .join('\n');

void main() {
  test('omitted numeric fields send the unchanged sentinel, not zero', () {
    final req = _code.substring(
      _code.indexOf('family_pb.UpdateFamilyMemberRequest('),
      _code.indexOf('family_pb.UpdateFamilyMemberRequest(') + 600,
    );
    for (final field in [
      'allocatedBalance',
      'dailySpendingLimit',
      'monthlySpendingLimit',
      'perTransactionLimit',
      'allocationPercentageCap',
    ]) {
      expect(
        req.contains('$field: req.$field ?? 0.0'),
        isFalse,
        reason: '$field defaults to 0.0, which the server APPLIES — omitting it '
            'silently zeroes that member\'s money',
      );
      expect(
        req.contains('$field: req.$field ?? unchanged'),
        isTrue,
        reason: '$field must fall back to the negative unchanged sentinel',
      );
    }
  });

  test('the sentinel is actually negative', () {
    // A non-negative sentinel would be indistinguishable from a real value.
    expect(_code, contains('const unchanged = -1.0'));
  });

  test('role still uses empty-string for unchanged', () {
    // Role is a string; its "unchanged" signal is "" and the server checks
    // `if req.Role != ""`. Only the numeric fields needed the negative sentinel.
    expect(_code, contains("role: req.role ?? ''"));
  });
}
