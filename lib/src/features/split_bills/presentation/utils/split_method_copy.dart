library;

import 'package:intl/intl.dart';

/// PICKING "CUSTOM" OR "PERCENTAGE" USED TO LEAD NOWHERE.
///
/// The Split Method chips are on step 1 (Amount & details). The per-person
/// amount and % fields are on step 2 (People), inside each co-payer's card —
/// so selecting Percentage on step 1 changed the chip and nothing else: no
/// field, no co-payer list, and no sentence saying where to go. The flow
/// looked unfinished.
///
/// Worse, the co-payer toggle went on reading "My share: ₦800.00" — the EQUAL
/// split figure. Under custom and percentage the creator's share is the
/// REMAINDER (`total - assignedToOthers`), so before any co-payer has a value
/// that number is the whole bill, and presenting it as "my share" tells the
/// creator they are paying for everyone.
///
/// This is the wording for both. It is a plain function over plain values —
/// no widget, no state — so the sentences a person makes a money decision on
/// are testable on their own.

/// How a split method collects each person's share.
enum SplitShareInput {
  /// Nothing to type: every share falls out of the headcount.
  none,

  /// A money amount per co-payer.
  amount,

  /// A percentage per co-payer.
  percent,
}

/// What still has to be filled in, and where. Null when there is nothing to
/// fill in at all.
String? splitMethodHint(SplitShareInput input, {required int coPayerCount}) {
  final what = switch (input) {
    SplitShareInput.none => null,
    SplitShareInput.amount => "person's amount",
    SplitShareInput.percent => "person's %",
  };
  if (what == null) return null;
  return coPayerCount == 0
      ? 'Add your co-payers on the next step — you type each $what there.'
      : 'Type each $what on the next step.';
}

/// The line under "I'm also a co-payer".
///
/// Null when there is nothing honest to say yet; the caller then renders no
/// subtitle rather than a misleading figure.
String? myShareSubtitle({
  required SplitShareInput input,
  required bool includeMyself,
  required double myShare,
  required double totalAmount,
  required double assignedToOthers,
  required String currencySymbol,
}) {
  if (!includeMyself) return null;

  final money = '$currencySymbol${NumberFormat('#,##0.00').format(myShare)}';

  if (input == SplitShareInput.none) {
    return myShare > 0 ? 'My share: $money' : null;
  }

  // Custom and percentage: the creator takes whatever the co-payers have not.
  // Saying so is the difference between "you owe the whole bill" and "this is
  // the remainder, and it shrinks as you allocate".
  if (assignedToOthers <= 0) {
    return totalAmount > 0
        ? "My share: whatever is left once the co-payers' shares are set"
        : null;
  }
  return myShare > 0
      ? 'My share: $money — the rest of the bill'
      : 'My share: nothing left — the co-payers cover all of it';
}
