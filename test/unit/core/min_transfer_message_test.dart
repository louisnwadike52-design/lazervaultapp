import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

void main() {
  test('a too-small-transfer reason must reach the payer intact', () {
    const raw =
        'external transfer failed: the minimum for a bank transfer is 100.00 NGN '
        '(you entered 25.00) — payout providers reject smaller amounts';
    final shown = sanitizeUserFacingError(raw);
    // The payer must be told the ACTIONABLE fact: there is a minimum, and what it is.
    expect(shown.toLowerCase(), contains('minimum'),
        reason: 'the sanitiser swallowed the one fact that tells the payer what to do');
    expect(shown, contains('100'));
  });
}
