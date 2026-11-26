import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/app_status/widgets/outage_copy.dart';

/// A RATE LIMIT IS NOT AN OUTAGE, AND MUST NOT READ AS ONE.
///
/// Reported 2026-11-09: an Android user saw "our servers are being updated".
/// core-gateway — the only thing the health probe touches — had been up 3,572
/// minutes with zero restarts, and /health answered 200 in 0.14s through six
/// rapid probes. Nothing was being updated.
///
/// Folding a deliberate refusal into [OutageKind.server] tells the user to wait
/// for a deploy that is not running; folding it into [slowConnection] tells
/// them to go and find better signal. Both send them somewhere useless.
void main() {
  for (final isSignUp in [false, true]) {
    final where = isSignUp ? 'during signup' : 'in-app';

    test('rate limiting does not claim a server outage ($where)', () {
      final copy = OutageCopy.of(OutageKind.rateLimited, isSignUp: isSignUp);
      final text = '${copy.title} ${copy.message}'.toLowerCase();
      for (final forbidden in [
        'servers are being updated',
        'maintenance',
        'planned work',
        "we'll be right back",
      ]) {
        expect(text, isNot(contains(forbidden)),
            reason: 'rate limiting described itself as an outage: $forbidden');
      }
    });

    test('rate limiting does not blame the connection ($where)', () {
      final copy = OutageCopy.of(OutageKind.rateLimited, isSignUp: isSignUp);
      final text = '${copy.title} ${copy.message}'.toLowerCase();
      for (final forbidden in [
        'connection is too slow',
        'no internet',
        'better signal',
        'wi-fi',
      ]) {
        expect(text, isNot(contains(forbidden)),
            reason: 'rate limiting blamed the user\'s network: $forbidden');
      }
    });

    test('it says the one thing that actually helps: wait ($where)', () {
      final copy = OutageCopy.of(OutageKind.rateLimited, isSignUp: isSignUp);
      expect(copy.message.toLowerCase(), contains('try again'));
    });
  }

  test('it is DISMISSIBLE, unlike a server outage', () {
    // There is a working app behind a rate limit and it clears itself in
    // seconds. A server outage is not dismissible because nothing behind it
    // works; trapping a rate-limited user would be worse than the limit.
    expect(OutageCopy.of(OutageKind.rateLimited, isSignUp: false).dismissible,
        isTrue);
    expect(
        OutageCopy.of(OutageKind.server, isSignUp: false).dismissible, isFalse);
  });

  test('every outage kind still has its own words', () {
    // The point of the enum is that each cause gets copy a user can act on.
    // Two kinds sharing a title means one of them is lying about the cause.
    final titles = <String, OutageKind>{};
    for (final kind in OutageKind.values) {
      final copy = OutageCopy.of(kind, isSignUp: false);
      expect(copy.title.trim(), isNotEmpty, reason: kind.name);
      expect(copy.message.trim(), isNotEmpty, reason: kind.name);
      final clash = titles[copy.title];
      expect(clash, isNull,
          reason: '${kind.name} shares its title with ${clash?.name}');
      titles[copy.title] = kind;
    }
  });
}
