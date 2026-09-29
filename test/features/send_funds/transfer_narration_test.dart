// A transfer is described EITHER by a category OR by the user's own words.
//
// buildTransferNarration used to return "<Category>: <note>". With a note that
// double-described one payment ("Food & Dining: lunch"); with no note it
// invented filler ("Food & Dining: Transfer") which reached the recipient's
// bank narration and the receipt.
//
// Both send-funds sheets now enforce the choice in the UI — picking a category
// clears the note, typing a note clears the category. This is the matching
// rule for anything that still arrives with both set: an older client, a chat
// or voice agent, or a scheduled transfer created before the change.
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart' show Color;
import 'package:lazervault/src/features/widgets/category_selection.dart';

const _food = ServiceCategory(
  id: 'cat-food',
  serviceName: 'transfer',
  subCategoryName: 'food',
  budgetCategory: 1,
  displayName: 'Food & Dining',
  iconName: 'restaurant',
  color: Color(0xFFFF6B6B),
);

void main() {
  const fallback = 'Transfer from Lazervault';

  test('the user own words win when both are somehow set', () {
    expect(
      ServiceCategory.buildTransferNarration(
          category: _food, note: 'lunch with Ada', defaultNarration: fallback),
      'lunch with Ada',
      reason: 'a typed note is more specific than a taxonomy bucket',
    );
  });

  test('a category alone becomes the narration, with no invented filler', () {
    final n = ServiceCategory.buildTransferNarration(
        category: _food, note: null, defaultNarration: fallback);
    expect(n, _food.analyticsLabel);
    expect(n.contains(':'), isFalse,
        reason: 'the old "<Category>: Transfer" filler reached the recipient bank narration');
  });

  test('a note alone is used verbatim', () {
    expect(
      ServiceCategory.buildTransferNarration(
          category: null, note: 'rent for March', defaultNarration: fallback),
      'rent for March',
    );
  });

  test('neither falls back to the default', () {
    expect(
      ServiceCategory.buildTransferNarration(
          category: null, note: null, defaultNarration: fallback),
      fallback,
    );
  });

  test('whitespace-only note is treated as absent', () {
    expect(
      ServiceCategory.buildTransferNarration(
          category: _food, note: '   ', defaultNarration: fallback),
      _food.analyticsLabel,
      reason: 'spaces must not beat a real category',
    );
    expect(
      ServiceCategory.buildTransferNarration(
          category: null, note: '   ', defaultNarration: fallback),
      fallback,
    );
  });

  test('the narration uses analyticsLabel, which is what the spend SQL matches', () {
    // accounts-service buckets transfer spend with
    //   description ILIKE '<analyticsLabel>%'
    // so the narration MUST be the analytics label, not displayName. They
    // differ: displayName is "Food & Dining", analyticsLabel "Food & Drinks".
    final n = ServiceCategory.buildTransferNarration(
        category: _food, note: null, defaultNarration: fallback);
    expect(n, 'Food & Drinks');
    expect(n, isNot(_food.displayName),
        reason: 'displayName would not match the analytics arm and the spend would fall to Other');
  });
}
