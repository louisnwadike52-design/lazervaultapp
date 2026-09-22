import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/src/features/fcy_account/data/fcy_prefill.dart';
import 'package:lazervault/src/features/fcy_account/presentation/cubit/fcy_kyc_steps.dart';

/// The step engine is the whole point of the prefill: a field we already hold must
/// not be asked for, and a step whose every field is known must disappear rather
/// than render empty.
void main() {
  FcyPrefillField filled(String v) => FcyPrefillField(value: v, prefilled: true);

  List<FcyKycFieldId> allFields(List<FcyKycStep> steps) =>
      steps.expand((s) => s.fields).toList();

  group('step visibility', () {
    test('asks for everything when nothing is prefilled', () {
      final steps = buildFcyKycSteps(
        currency: 'GBP',
        prefill: FcyPrefill.none,
        values: {},
      );
      final fields = allFields(steps);
      expect(fields, contains(FcyKycFieldId.firstName));
      expect(fields, contains(FcyKycFieldId.addressCity));
      expect(fields, contains(FcyKycFieldId.occupation));
      // Documents step exists and carries no text fields.
      expect(steps.last.fields, isEmpty);
    });

    test('drops a step whose every field is prefilled', () {
      const prefill = FcyPrefill(
        firstName: FcyPrefillField(value: 'Ada', prefilled: true),
        lastName: FcyPrefillField(value: 'Obi', prefilled: true),
        email: FcyPrefillField(value: 'a@b.co', prefilled: true),
        phone: FcyPrefillField(value: '08030000000', prefilled: true),
        birthDate: FcyPrefillField(value: '1990-01-01', prefilled: true),
        nationality: FcyPrefillField(value: 'NG', prefilled: true),
      );
      final steps = buildFcyKycSteps(
        currency: 'GBP',
        prefill: prefill,
        values: {},
      );
      expect(
        steps.any((s) => s.title == 'About you'),
        isFalse,
        reason: 'a fully-prefilled step must disappear, not render empty',
      );
      // And none of those fields is asked anywhere else.
      final fields = allFields(steps);
      expect(fields, isNot(contains(FcyKycFieldId.firstName)));
      expect(fields, isNot(contains(FcyKycFieldId.birthDate)));
    });

    test('keeps a step when only SOME of it is prefilled', () {
      final steps = buildFcyKycSteps(
        currency: 'GBP',
        prefill: FcyPrefill(firstName: filled('Ada'), lastName: filled('Obi')),
        values: {},
      );
      final personal =
          steps.firstWhere((s) => s.title == 'About you');
      expect(personal.fields, isNot(contains(FcyKycFieldId.firstName)));
      expect(personal.fields, contains(FcyKycFieldId.email));
      expect(personal.fields, contains(FcyKycFieldId.birthDate));
    });

    test('financial profile is never dropped, even with a full prefill', () {
      // It is regulatory self-declaration — no provider can supply it, so it must
      // always be asked however complete the identity data looks.
      final steps = buildFcyKycSteps(
        currency: 'GBP',
        prefill: FcyPrefill(
          firstName: filled('Ada'),
          lastName: filled('Obi'),
          email: filled('a@b.co'),
          phone: filled('080'),
          birthDate: filled('1990-01-01'),
          nationality: filled('NG'),
          addressStreet: filled('12 Road'),
          addressCity: filled('Lagos'),
          addressState: filled('Lagos'),
          addressZip: filled('100001'),
          countryOfResidence: filled('NG'),
          documentNumber: filled('11111111111'),
          documentIssuedCountry: filled('NG'),
        ),
        values: {},
      );
      expect(steps.any((s) => s.title == 'Your financial profile'), isTrue);
      expect(allFields(steps), contains(FcyKycFieldId.occupation));
      // Document dates are always asked — we hold neither.
      expect(allFields(steps), contains(FcyKycFieldId.documentIssuedDate));
      expect(allFields(steps), contains(FcyKycFieldId.documentExpiryDate));
    });
  });

  group('currency rules', () {
    test('USD asks for a tax number, GBP does not', () {
      final usd = buildFcyKycSteps(
          currency: 'USD', prefill: FcyPrefill.none, values: {});
      final gbp = buildFcyKycSteps(
          currency: 'GBP', prefill: FcyPrefill.none, values: {});
      expect(allFields(usd), contains(FcyKycFieldId.taxNumber));
      expect(allFields(gbp), isNot(contains(FcyKycFieldId.taxNumber)));
    });

    test('only EUR accepts more than a passport', () {
      // Offering a national ID for USD would let someone finish the form and fail
      // the provider's compliance review days later.
      expect(acceptedDocumentTypes('EUR'), contains('national_id'));
      expect(acceptedDocumentTypes('USD'), equals(['passport']));
      expect(acceptedDocumentTypes('GBP'), equals(['passport']));
      expect(acceptedDocumentTypes('gbp'), equals(['passport']),
          reason: 'must be case-insensitive');
    });
  });

  group('validation', () {
    List<FcyKycStep> steps() => buildFcyKycSteps(
        currency: 'USD', prefill: FcyPrefill.none, values: {});

    test('names the first missing field in words a user understands', () {
      final financial =
          steps().firstWhere((s) => s.title == 'Your financial profile');
      final msg = financial.validate({}, _NoUploads());
      expect(msg, isNotNull);
      expect(msg, contains('occupation'));
      // Never a field id.
      expect(msg, isNot(contains('FcyKycFieldId')));
      expect(msg, isNot(contains('monthlyTxVolume')));
    });

    test('rejects an inverted income range', () {
      final financial =
          steps().firstWhere((s) => s.title == 'Your financial profile');
      final msg = financial.validate({
        FcyKycFieldId.occupation: 'Engineer',
        FcyKycFieldId.employmentStatus: 'Employed',
        FcyKycFieldId.sourceOfIncome: 'Salary',
        FcyKycFieldId.incomeLower: '5000000',
        FcyKycFieldId.incomeUpper: '1000000',
        FcyKycFieldId.monthlyTxCount: '10',
        FcyKycFieldId.monthlyTxVolume: '500000',
        FcyKycFieldId.taxNumber: 'TIN123',
      }, _NoUploads());
      expect(msg, isNotNull);
      expect(msg!.toLowerCase(), contains('upper'));
    });

    test('rejects an expired document', () {
      final doc = steps().firstWhere((s) => s.title == 'Your ID document');
      final msg = doc.validate({
        FcyKycFieldId.documentType: 'passport',
        FcyKycFieldId.documentNumber: 'A123',
        FcyKycFieldId.documentIssuedCountry: 'NG',
        FcyKycFieldId.documentIssuedDate: '2010-01-01',
        FcyKycFieldId.documentExpiryDate: '2015-01-01',
      }, _NoUploads());
      expect(msg, isNotNull);
      expect(msg!.toLowerCase(), contains('expired'));
    });

    test('rejects expiry before issue', () {
      final doc = steps().firstWhere((s) => s.title == 'Your ID document');
      final msg = doc.validate({
        FcyKycFieldId.documentType: 'passport',
        FcyKycFieldId.documentNumber: 'A123',
        FcyKycFieldId.documentIssuedCountry: 'NG',
        FcyKycFieldId.documentIssuedDate: '2030-01-01',
        FcyKycFieldId.documentExpiryDate: '2029-01-01',
      }, _NoUploads());
      expect(msg, isNotNull);
      expect(msg!.toLowerCase(), contains('after the issue date'));
    });
  });

  group('prefill model', () {
    test('a flag without a value is not trusted', () {
      // Guards against deploy skew: a server that sent prefilled:true with an empty
      // value would hide an input the user then cannot fill.
      final f = FcyPrefillField.fromJson({'value': '', 'prefilled': true});
      expect(f.prefilled, isFalse);
      expect(f.needsInput, isTrue);
    });

    test('malformed json degrades to ask', () {
      expect(FcyPrefillField.fromJson(null).needsInput, isTrue);
      expect(FcyPrefillField.fromJson('nonsense').needsInput, isTrue);
      expect(FcyPrefillField.fromJson(42).needsInput, isTrue);
    });

    test('counts only genuinely filled fields', () {
      final p = FcyPrefill(
        firstName: filled('Ada'),
        lastName: filled('Obi'),
        email: const FcyPrefillField(value: '', prefilled: true),
      );
      expect(p.filledCount, 2);
    });

    test('accepts both snake_case and camelCase from the wire', () {
      final a = FcyPrefill.fromJson({
        'first_name': {'value': 'Ada', 'prefilled': true},
      });
      final b = FcyPrefill.fromJson({
        'firstName': {'value': 'Ada', 'prefilled': true},
      });
      expect(a.firstName.value, 'Ada');
      expect(b.firstName.value, 'Ada');
    });
  });
}

/// Nothing uploaded. The document step's validator needs only these two getters —
/// which is why it takes [FcyKycUploads] rather than the whole cubit.
class _NoUploads implements FcyKycUploads {
  @override
  String? get idDocumentUrl => null;
  @override
  String? get addressProofUrl => null;
}
