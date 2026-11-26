import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// THE LIST MEANS SOMETHING DIFFERENT UNDER EACH RULE, AND IT HAS TO SAY SO.
///
/// Under once-per-campaign it is "who came tonight". Under once-per-business
/// it is every person this vendor has ever claimed for — some served at another
/// venue, on another campaign, weeks ago. A vendor reading the second as the
/// first reaches the wrong conclusion about a customer insisting they were
/// never counted, which is exactly when this screen gets opened.
void main() {
  final src = File(
    'lib/src/features/vendor_campaigns/presentation/views/'
    'vendor_redemptions_screen.dart',
  ).readAsStringSync();

  test('the screen is titled by the rule in force', () {
    expect(src.contains('isVendorScoped'), isTrue,
        reason: 'one title for both rules describes only one of them');
    expect(src.contains('Unique customers'), isTrue,
        reason: 'the wide rule makes this a list of unique people, not of '
            'tonight\'s attendance');
  });

  test('the numbers a vendor opens this to check are above the list', () {
    expect(src.contains('_SummaryStrip'), isTrue,
        reason: 'it was a flat list: counting the served meant scrolling to '
            'the bottom, and the amount earned meant leaving the screen');
  });

  // Served and the ceiling always travel together — the campaign card's own
  // rule. Either alone cannot distinguish a busy night from a spent budget.
  test('served is shown against the ceiling, never alone', () {
    expect(src.contains('campaign.maxRedemptions'), isTrue,
        reason: 'a bare count cannot tell a busy night from a spent budget');
  });

  test('a long list can be searched', () {
    expect(src.contains('_SearchField'), isTrue,
        reason: 'the list is reached for when a customer says they were not '
            'counted; scrolling a launch night to settle that is not a check '
            'anyone completes with a queue waiting');
    // ...but not over four rows, where it is furniture.
    expect(src.contains('rows.length >= 8'), isTrue,
        reason: 'a search box over a handful of names is furniture');
  });

  test('the search field states its own colours', () {
    expect(src.contains('color: Colors.white, fontSize: 14.sp'), isTrue,
        reason: 'on this dark ground the light theme\'s default input colour '
            'is near-black — the same inheritance that hid the ticketing app '
            'bars, and here it would hide what the vendor is typing');
  });

  test('a search that matches nothing says so', () {
    expect(src.contains('Nobody matching'), isTrue,
        reason: 'an empty list after a search is indistinguishable from a '
            'campaign nobody attended');
  });
}
