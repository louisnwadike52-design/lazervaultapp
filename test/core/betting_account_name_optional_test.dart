import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// "SportyBet bet funding — name didn't show after verification."
///
/// It is not a lookup failure. VTU.africa's betting verify does not return an
/// account holder at all: it echoes the PLATFORM back in the Customer field.
/// Confirmed against the live provider with the working key —
///
///   {"code":101,"description":{"Status":"Completed","Customer":"sportybet",
///    "Service":"sportybet","UserID":"000000000", ...}}
///
/// — and resolveBetAccountName (utility-payments) already refuses to pass that
/// off as a person's name, returning "no name resolved". That part is right.
///
/// What was wrong was the review screen presenting the absent name as if the
/// lookup had failed: an "Account name" row with nothing beside it, and a
/// confirmation reading "Confirm funding  on SportyBet with NGN 1500" — a gap
/// where a name should be, on the screen that asks the user to approve money
/// leaving.
void main() {
  late String review;
  late String receipt;

  setUpAll(() {
    review =
        File('lib/src/features/betting/presentation/view/betting_review_screen.dart')
            .readAsStringSync();
    receipt =
        File('lib/src/features/betting/presentation/view/betting_receipt_screen.dart')
            .readAsStringSync();
  });

  test('the Account name row only renders when a name resolved', () {
    expect(
      review.contains("if (_accountName.trim().isNotEmpty) ...["),
      isTrue,
      reason: 'an empty labelled row reads as a failed lookup, which is what '
          'the user reported',
    );
  });

  test('the confirmation sentence does not leave a gap', () {
    expect(
      review.contains("_accountName.trim().isEmpty\n          ? 'Confirm funding \$_accountUserid"),
      isTrue,
      reason: 'with no name the message interpolated an empty string, giving '
          '"Confirm funding  on SportyBet" on a money-approval prompt',
    );
    // The account id always identifies the destination, so the sentence must
    // still name WHERE the money is going.
    expect(review.contains(r'$_accountUserid on ${_platform!.name}'), isTrue);
  });

  test('the receipt screen keeps its existing guard', () {
    // It already did this correctly; the review screen was the outlier. If the
    // receipt ever loses the guard it gets the same empty row.
    expect(receipt.contains('if (_accountName.isNotEmpty)'), isTrue);
  });
}
