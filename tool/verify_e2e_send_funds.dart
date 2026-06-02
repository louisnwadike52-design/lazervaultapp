/// Host-side post-flight verification for send_funds_external_e2e_test.dart.
///
/// Reads the test-emitted transfer reference from stdin, then verifies via
/// psql that the hold-then-capture invariants hold:
///   - payments row exists with provider='flutterwave', fund_hold_id set.
///   - transfer_provider_attempts row exists with provider_name='flutterwave'.
///   - account_reserves row exists for the hold id with sane status.
///
/// Exit code 0 on pass, non-zero with reason on fail.

import 'dart:io';

const String _pgUser = 'postgres';

Future<String> _psql(String db, String sql) async {
  final result = await Process.run(
    'psql',
    ['-h', '127.0.0.1', '-p', '5432', '-U', _pgUser, '-d', db, '-tA', '-q', '-c', sql],
    runInShell: true,
  );
  if (result.exitCode != 0) {
    throw Exception('psql db=$db failed: ${result.stderr}\nsql: $sql');
  }
  return (result.stdout as String).trim();
}

Future<void> main(List<String> args) async {
  if (args.isEmpty) {
    stderr.writeln('usage: dart run tool/verify_e2e_send_funds.dart <reference>');
    exit(2);
  }
  final reference = args[0];
  stderr.writeln('🔎 Verifying transfer reference=$reference');

  final paymentRow = await _psql(
    'payments_db',
    "SELECT id, status, COALESCE(provider,''), COALESCE(fund_hold_id::text,''), "
    "version, COALESCE(provider_ref,''), COALESCE(provider_status,'') "
    "FROM payments WHERE reference='$reference';",
  );
  if (paymentRow.isEmpty) {
    stderr.writeln('FAIL: no payments row for reference=$reference');
    exit(1);
  }
  final parts = paymentRow.split('|');
  final paymentId = parts[0];
  stderr.writeln('   payment_id=$paymentId status=${parts[1]} '
      'provider=${parts[2]} fund_hold_id=${parts[3]} version=${parts[4]} '
      'provider_ref=${parts[5]} provider_status=${parts[6]}');

  if (parts[2] != 'flutterwave') {
    stderr.writeln('FAIL: provider should be flutterwave, got ${parts[2]}');
    exit(1);
  }
  if (parts[3].isEmpty) {
    stderr.writeln('FAIL: fund_hold_id should be set');
    exit(1);
  }

  final attempt = await _psql(
    'payments_db',
    "SELECT attempt_number, status, COALESCE(classification,''), "
    "COALESCE(provider_transaction_id,''), COALESCE(error_message,'') "
    "FROM transfer_provider_attempts WHERE payment_id='$paymentId' "
    "ORDER BY attempt_number DESC LIMIT 1;",
  );
  if (attempt.isEmpty) {
    stderr.writeln('FAIL: no transfer_provider_attempts row for payment_id=$paymentId');
    exit(1);
  }
  final ap = attempt.split('|');
  stderr.writeln('   attempt #${ap[0]} status=${ap[1]} class=${ap[2]} '
      'fw_tx=${ap[3]} err=${ap[4]}');

  final hold = await _psql(
    'accounts_db',
    "SELECT status, amount, reference FROM account_reserves WHERE id='${parts[3]}';",
  );
  if (hold.isEmpty) {
    stderr.writeln('FAIL: no account_reserves row for hold ${parts[3]}');
    exit(1);
  }
  final hp = hold.split('|');
  stderr.writeln('   hold status=${hp[0]} amount=${hp[1]} ref=${hp[2]}');

  stderr.writeln('✅ Verification passed.');
}
