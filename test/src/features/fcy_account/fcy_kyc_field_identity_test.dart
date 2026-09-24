import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/fcy_account/presentation/cubit/fcy_kyc_steps.dart';
import 'package:lazervault/src/features/fcy_account/presentation/widgets/fcy_kyc_field_input.dart';

/// Why step 2 of the FCY KYC arrived pre-filled with step 1's answers.
///
/// Reported twice, with screenshots: Occupation came up holding the ADDRESS the
/// user had just typed, and "Annual income from" held the POSTCODE.
///
/// The wizard rendered its fields as `...step.fields.map((id) => FcyKycFieldInput(...))`
/// with no keys. Same widget type, no key, so when the step changed Flutter matched
/// the old and new children BY INDEX and reused each TextFormField's State —
/// and `initialValue` is only read when that State is CREATED. The reused field
/// therefore kept the text from whatever field had occupied its position on the
/// previous step.
///
/// The positions line up exactly with the report: address fields sit where
/// occupation and income later sit.
void main() {
  group('both keys are in place at the source', () {
    // Verified by experiment: the inner TextFormField key ALONE prevents the
    // state reuse, so the widget test below still passes with the outer key
    // removed. A behavioural test therefore cannot tell whether the wizard is
    // keyed — only this can, and the wizard is the file someone edits.
    test('the wizard keys each field by id', () {
      final source = File(
        'lib/src/features/fcy_account/presentation/fcy_kyc_wizard_screen.dart',
      ).readAsStringSync();
      expect(source, contains('key: ValueKey(id),'),
          reason: 'an unkeyed positional list is what let Flutter reuse each '
              "TextFormField's state across a step change");
    });

    test('the text field keys itself by id as well', () {
      final source = File(
        'lib/src/features/fcy_account/presentation/widgets/'
        'fcy_kyc_field_input.dart',
      ).readAsStringSync();
      expect(source, contains("key: ValueKey('fcy_kyc_text_"),
          reason:
              'initialValue is read only when the State is created, so this '
              'is the key that actually stops the inherited text');
    });
  });

  /// Renders a step's fields the way the wizard does, keyed by id.
  Future<void> pumpStep(
    WidgetTester tester,
    List<FcyKycFieldId> fields,
    Map<FcyKycFieldId, String> values,
    void Function(FcyKycFieldId, String) onChanged,
  ) async {
    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, __) => MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  for (final id in fields)
                    FcyKycFieldInput(
                      key: ValueKey(id),
                      id: id,
                      currency: 'USD',
                      value: values[id] ?? '',
                      onChanged: (v) => onChanged(id, v),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('a new step does not inherit the previous step text',
      (tester) async {
    final values = <FcyKycFieldId, String>{};
    void set(FcyKycFieldId id, String v) => values[id] = v;

    // STEP 1: the address block, in the order the wizard shows it.
    const stepOne = [
      FcyKycFieldId.addressStreet,
      FcyKycFieldId.addressCity,
      FcyKycFieldId.addressZip,
    ];
    await pumpStep(tester, stepOne, values, set);

    // The user fills it in.
    final streetField = find.byType(TextFormField).at(0);
    final zipField = find.byType(TextFormField).at(2);
    await tester.enterText(streetField, '12 Marina Road');
    await tester.enterText(zipField, '101241');
    await tester.pump();
    expect(values[FcyKycFieldId.addressStreet], '12 Marina Road');
    expect(values[FcyKycFieldId.addressZip], '101241');

    // STEP 2: occupation and income sit at the SAME POSITIONS the address fields
    // occupied. This is the arrangement that produced the bug.
    const stepTwo = [
      FcyKycFieldId.occupation,
      FcyKycFieldId.employmentStatus,
      FcyKycFieldId.incomeLower,
    ];
    await pumpStep(tester, stepTwo, values, set);
    await tester.pumpAndSettle();

    // The reported symptom, asserted directly.
    expect(find.text('12 Marina Road'), findsNothing,
        reason: 'Occupation must not inherit the address from step 1');
    expect(find.text('101241'), findsNothing,
        reason: '"Annual income from" must not inherit the postcode');
  });

  testWidgets('a field keeps its OWN value when the step is rebuilt',
      (tester) async {
    // The other half of the contract: keying must not break legitimate
    // persistence. A field returning to the screen should show what the cubit
    // holds for it.
    final values = <FcyKycFieldId, String>{
      FcyKycFieldId.occupation: 'Engineer',
    };
    void set(FcyKycFieldId id, String v) => values[id] = v;

    const step = [FcyKycFieldId.occupation, FcyKycFieldId.employmentStatus];
    await pumpStep(tester, step, values, set);
    expect(find.text('Engineer'), findsOneWidget);

    // Rebuild the same step — e.g. the cubit emitted for an unrelated reason.
    await pumpStep(tester, step, values, set);
    await tester.pump();
    expect(find.text('Engineer'), findsOneWidget,
        reason: 'the value belongs to this field and should survive a rebuild');
  });

  testWidgets('reordering fields moves the text with the field, not the slot',
      (tester) async {
    final values = <FcyKycFieldId, String>{
      FcyKycFieldId.occupation: 'Engineer',
      FcyKycFieldId.taxNumber: 'TIN-99',
    };
    void set(FcyKycFieldId id, String v) => values[id] = v;

    await pumpStep(
      tester,
      const [FcyKycFieldId.occupation, FcyKycFieldId.taxNumber],
      values,
      set,
    );
    expect(find.text('Engineer'), findsOneWidget);
    expect(find.text('TIN-99'), findsOneWidget);

    // Swapped. Without keys the texts would stay with the POSITIONS and the two
    // values would trade places.
    await pumpStep(
      tester,
      const [FcyKycFieldId.taxNumber, FcyKycFieldId.occupation],
      values,
      set,
    );
    await tester.pumpAndSettle();
    expect(find.text('Engineer'), findsOneWidget);
    expect(find.text('TIN-99'), findsOneWidget);
  });
}
