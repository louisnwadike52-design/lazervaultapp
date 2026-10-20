import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// HIDING A TAB IS NOT THE SAME AS CLOSING THE FLOW BEHIND IT.
///
/// Send Abroad has three doors on the Exchange screen: the mode toggle, a
/// HORIZONTAL SWIPE anywhere on the form, and a mode passed by route argument
/// (the history sheet's "repeat" for a past international transfer). Gating
/// only the toggle would leave a gesture that still reaches a mode whose tab
/// had been removed — the same way an admin-gated hub screen stays reachable
/// through its beneficiaries, history and notification entrances.
///
/// So the switch is enforced in `_onModeChanged`, which every door funnels
/// through, and the swipe returns early as well so it is visibly inert rather
/// than silently refused.
///
/// Source-level because the screen needs the whole service locator to pump,
/// and because each defect here is a MISSING guard rather than a wrong value.
void main() {
  String stripComments(String src) => src
      .split('\n')
      .where((l) => !l.trimLeft().startsWith('//'))
      .join('\n');

  final home = stripComments(File(
          'lib/src/features/currency_exchange/presentation/views/exchange_home_screen.dart')
      .readAsStringSync());
  final toggle = stripComments(File(
          'lib/src/features/currency_exchange/presentation/widgets/exchange_mode_toggle.dart')
      .readAsStringSync());
  final flags =
      stripComments(File('lib/core/config/feature_flags.dart').readAsStringSync());
  final registry = stripComments(
      File('lib/core/services/endpoint_registry.dart').readAsStringSync());

  test('the mode setter refuses Send Abroad when it is switched off', () {
    final i = home.indexOf('void _onModeChanged(ExchangeMode mode) {');
    expect(i, greaterThan(-1), reason: '_onModeChanged moved');
    final body = home.substring(i, (i + 900).clamp(0, home.length));
    expect(
      body.contains(
          'if (mode == ExchangeMode.sendAbroad && !_sendAbroadOffered) return;'),
      isTrue,
      reason: 'every door funnels through here. Without the refusal the swipe '
          'and a route argument still reach a mode whose tab is hidden',
    );
    // The refusal must precede the state change, or the mode is already set.
    final guardAt = body.indexOf('!_sendAbroadOffered) return;');
    final setAt = body.indexOf('setState(() => _mode = mode);');
    expect(guardAt, lessThan(setAt),
        reason: 'the guard has to run before _mode is assigned');
  });

  test('the horizontal swipe is inert when the tab is hidden', () {
    final i = home.indexOf('onHorizontalDragEnd:');
    expect(i, greaterThan(-1), reason: 'the swipe handler moved');
    final body = home.substring(i, (i + 900).clamp(0, home.length));
    expect(body.contains('if (!_sendAbroadOffered) return;'), isTrue,
        reason: 'a swipe that reaches a hidden tab is a door left open');
    final guardAt = body.indexOf('if (!_sendAbroadOffered) return;');
    final pickAt = body.indexOf('ExchangeMode.sendAbroad');
    expect(guardAt, lessThan(pickAt),
        reason: 'the guard must come before the mode is chosen');
  });

  test('the toggle omits itself rather than rendering one dead pill', () {
    expect(toggle.contains('final bool showSendAbroad'), isTrue);
    expect(toggle.contains('if (!showSendAbroad) return const SizedBox.shrink();'),
        isTrue,
        reason: 'with one mode left there is nothing to toggle; a single '
            'full-width pill looks like a button and does nothing');
    expect(home.contains('showSendAbroad: _sendAbroadOffered'), isTrue,
        reason: 'the widget is hideable but the screen never passes the flag');
  });

  test('the flag survives the whole admin chain', () {
    // Link 4 is the one that fails silently: the value saves, the dashboard
    // shows it stored, and the app uses its hardcoded default for ever.
    expect(
        flags.contains(
            "static const String exchangeSendAbroadVisibleKey =\n      'exchange_send_abroad_visible';"),
        isTrue,
        reason: 'the key constant is gone');
    expect(flags.contains('exchangeSendAbroadVisibleKey,'), isTrue,
        reason: 'not hydrated by applyRemoteSnapshot, so a stored value is '
            'read back as the default');
    expect(registry.contains("'exchange_send_abroad_visible'"), isTrue,
        reason: 'not in _persistedNonUrlKeys, so nonUrlSnapshot() drops it '
            'between the registry cache and FeatureFlags');
  });

  test('it is a DIFFERENT switch from the payout enable flag', () {
    // Conflating them is the likely future mistake: one decides whether the
    // tab exists, the other whether a transfer behind it can complete.
    expect(flags.contains("'intl_payout_enabled'"), isTrue,
        reason: 'the payout switch must still exist on its own');
    expect(
        home.contains('_sendAbroadOffered') &&
            home.contains('sendAbroadUnavailable'),
        isTrue,
        reason: 'the screen should still explain an unavailable payout when '
            'the tab IS shown — hiding the tab did not replace that');
  });
}
