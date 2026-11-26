import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// ONE LIST, ONE PLACE TO FILTER IT.
///
/// Saved recipients had TWO filters over the same data. A filter icon beside
/// the "Saved recipients" header opened a sheet of its own and set
/// `_savedFavoritesOnly`, which narrowed the inline rail; the "View all" sheet
/// then applied a SEPARATE set of pills to the same list. Choosing Favourites
/// in the header quietly shortened the rail, and opening View all showed
/// something different — neither filter knew about the other, and the rail was
/// filtered by a control the user could no longer see once the sheet closed.
///
/// Filtering now happens only in View all, next to the list it filters and the
/// search that narrows it further. The header keeps a SEARCH icon, which opens
/// that same screen with the keyboard up.
void main() {
  final view = File(
    'lib/src/features/recipients/presentation/widgets/select_recipients.dart',
  );

  late String src;

  setUpAll(() {
    expect(view.existsSync(), isTrue,
        reason: 'select_recipients moved — this guard needs updating');
    src = view.readAsStringSync();
  });

  test('the second, hidden filter is gone', () {
    expect(src, isNot(contains('_savedFavoritesOnly')),
        reason: 'a filter that narrows the rail from a dismissed sheet is '
            'invisible state — it is what made View all disagree with the row '
            'behind it');
    expect(src, isNot(contains('_showSavedFilterSheet')),
        reason: 'the header filter sheet was removed; its Favourites option '
            'is a pill in View all and Recurring is still a pill there too');
  });

  test('View all can filter by favourites', () {
    expect(src, contains("pillChip('favorites'"),
        reason: 'Favourites has to survive the move, or the capability was '
            'deleted rather than relocated');
    expect(src, contains("'favorites' => all.where((r) => r.isFavorite)"),
        reason: 'the pill must actually narrow the list, in the same '
            'real-time chain as search and the other pills');
  });

  test('Recurring is still reachable after removing the header sheet', () {
    expect(src, contains("pillChip('recurring'"),
        reason: 'Recurring transfers were also reachable from the removed '
            'sheet; dropping that entry point without this pill would strip a '
            'destination, not just a filter');
  });

  test('the header search icon opens View all with the keyboard up', () {
    expect(src, contains('_openSavedRecipientsSheet(focusSearch: true)'));
    expect(src, contains('autofocus: focusSearch'),
        reason: 'opening the sheet without focusing the field makes the '
            'search icon indistinguishable from View all');
  });

  test('the sheet makes room for that keyboard', () {
    expect(src, contains('MediaQuery.of(ctx).viewInsets.bottom'),
        reason: 'the sheet is a fixed 0.85.sh. Forcing the keyboard open '
            'without adding the inset puts the bottom of the list behind it, '
            'unreachable — the edge case the autofocus itself creates');
    expect(src, contains('8.h + keyboard'));
  });
}
