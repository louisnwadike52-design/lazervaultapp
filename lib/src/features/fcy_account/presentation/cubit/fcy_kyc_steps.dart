import '../../data/fcy_prefill.dart';

/// Every field the FCY KYC form can ask for.
///
/// Exactly Fincra's REQUIRED set plus the USD-only tax number. Optional fields
/// (other name, tax country, house number, document issuer) are deliberately absent:
/// each extra input costs completion and Fincra does not need them.
enum FcyKycFieldId {
  firstName,
  lastName,
  email,
  phone,
  birthDate,
  nationality,
  addressStreet,
  addressCity,
  addressState,
  addressZip,
  countryOfResidence,
  occupation,
  employmentStatus,
  sourceOfIncome,
  incomeLower,
  incomeUpper,
  monthlyTxCount,
  monthlyTxVolume,
  documentType,
  documentNumber,
  documentIssuedCountry,
  documentIssuedDate,
  documentExpiryDate,
  taxNumber,
}

/// Which identity documents Fincra accepts, PER CURRENCY.
///
/// An international passport works for every currency; national ID and driver
/// licence are accepted for EUR only (docs/fcy-required-information, confirmed on
/// the FCY request page). Offering a national ID for a USD account would let someone
/// complete the whole form and fail Fincra's compliance review days later, which is
/// the worst possible place to discover it.
List<String> acceptedDocumentTypes(String currency) =>
    currency.toUpperCase() == 'EUR'
        ? const ['passport', 'national_id', 'drivers_license']
        : const ['passport'];

/// The slice of state a step validator needs beyond the field values.
///
/// Narrow on purpose. The validators previously took the whole [FcyKycCubit], which
/// meant the step definitions depended on the cubit and the cubit on the steps — a
/// cycle that also made the validators untestable without building a real cubit and
/// its HTTP service. Only the two upload URLs are actually needed.
abstract class FcyKycUploads {
  String? get idDocumentUrl;
  String? get addressProofUrl;
}

/// One step of the wizard.
class FcyKycStep {
  const FcyKycStep({
    required this.title,
    required this.subtitle,
    required this.fields,
    required this.validate,
  });

  final String title;
  final String subtitle;

  /// Fields to render, already filtered to those still needing input.
  final List<FcyKycFieldId> fields;

  /// Returns a user-facing problem, or null when the step is complete.
  final String? Function(Map<FcyKycFieldId, String>, FcyKycUploads) validate;
}

/// Builds the steps this user actually has to complete.
///
/// A step whose every field is already prefilled is DROPPED. That is the whole point
/// of the prefill: production coverage is name 7/7, date of birth 5/7, address 3/7
/// (LGA and state only), so for one user personal details is empty and for the next
/// it is three fields. A fixed page count would render a page with nothing on it.
///
/// The documents step is never dropped — neither upload is prefillable, and it
/// carries no [fields] because it renders pickers rather than text inputs.
List<FcyKycStep> buildFcyKycSteps({
  required String currency,
  required FcyPrefill prefill,
  required Map<FcyKycFieldId, String> values,
}) {
  final isUSD = currency.toUpperCase() == 'USD';

  /// Keeps only fields that still need input.
  List<FcyKycFieldId> ask(Map<FcyKycFieldId, FcyPrefillField> candidates) =>
      candidates.entries
          .where((e) => e.value.needsInput)
          .map((e) => e.key)
          .toList();

  final steps = <FcyKycStep>[];

  // ── About you ────────────────────────────────────────────────────────────
  final personal = ask({
    FcyKycFieldId.firstName: prefill.firstName,
    FcyKycFieldId.lastName: prefill.lastName,
    FcyKycFieldId.email: prefill.email,
    FcyKycFieldId.phone: prefill.phone,
    FcyKycFieldId.birthDate: prefill.birthDate,
    FcyKycFieldId.nationality: prefill.nationality,
  });
  if (personal.isNotEmpty) {
    steps.add(FcyKycStep(
      title: 'About you',
      subtitle: 'A few details we still need',
      fields: personal,
      validate: (v, _) => _requireAll(v, personal, {
        FcyKycFieldId.firstName: 'first name',
        FcyKycFieldId.lastName: 'last name',
        FcyKycFieldId.email: 'email address',
        FcyKycFieldId.phone: 'phone number',
        FcyKycFieldId.birthDate: 'date of birth',
        FcyKycFieldId.nationality: 'nationality',
      }),
    ));
  }

  // ── Where you live ───────────────────────────────────────────────────────
  //
  // Street and postcode are almost always asked: Nigerian BVN/NIN records carry no
  // street line and Nigeria does not routinely use postcodes, so the identity data
  // cannot supply them however complete it looks.
  final address = ask({
    FcyKycFieldId.addressStreet: prefill.addressStreet,
    FcyKycFieldId.addressCity: prefill.addressCity,
    FcyKycFieldId.addressState: prefill.addressState,
    FcyKycFieldId.addressZip: prefill.addressZip,
    FcyKycFieldId.countryOfResidence: prefill.countryOfResidence,
  });
  if (address.isNotEmpty) {
    steps.add(FcyKycStep(
      title: 'Where you live',
      subtitle: 'Your residential address, as it appears on your documents',
      fields: address,
      validate: (v, _) => _requireAll(v, address, {
        FcyKycFieldId.addressStreet: 'street address',
        FcyKycFieldId.addressCity: 'city',
        FcyKycFieldId.addressState: 'state',
        FcyKycFieldId.addressZip: 'postcode',
        FcyKycFieldId.countryOfResidence: 'country of residence',
      }),
    ));
  }

  // ── Financial profile ────────────────────────────────────────────────────
  //
  // NEVER prefilled and never droppable. This is regulatory self-declaration: no
  // identity provider has an opinion on someone's occupation or expected monthly
  // volume, and inferring it would be fabricating KYC.
  final financial = <FcyKycFieldId>[
    FcyKycFieldId.occupation,
    FcyKycFieldId.employmentStatus,
    FcyKycFieldId.sourceOfIncome,
    FcyKycFieldId.incomeLower,
    FcyKycFieldId.incomeUpper,
    FcyKycFieldId.monthlyTxCount,
    FcyKycFieldId.monthlyTxVolume,
    if (isUSD) FcyKycFieldId.taxNumber,
  ];
  steps.add(FcyKycStep(
    title: 'Your financial profile',
    subtitle: 'Required by the bank that issues your account',
    fields: financial,
    validate: (v, _) {
      final missing = _requireAll(v, financial, {
        FcyKycFieldId.occupation: 'occupation',
        FcyKycFieldId.employmentStatus: 'employment status',
        FcyKycFieldId.sourceOfIncome: 'source of income',
        FcyKycFieldId.incomeLower: 'lower end of your income range',
        FcyKycFieldId.incomeUpper: 'upper end of your income range',
        FcyKycFieldId.monthlyTxCount: 'expected monthly transaction count',
        FcyKycFieldId.monthlyTxVolume: 'expected monthly transaction volume',
        FcyKycFieldId.taxNumber: 'tax identification number',
      });
      if (missing != null) return missing;

      final lo = num.tryParse(v[FcyKycFieldId.incomeLower] ?? '');
      final hi = num.tryParse(v[FcyKycFieldId.incomeUpper] ?? '');
      if (lo == null || hi == null) {
        return 'Please enter your income range as numbers.';
      }
      if (lo < 0 || hi < 0) return 'Income cannot be negative.';
      // Caught here rather than at the provider: an inverted range is the kind of
      // thing a compliance review rejects days later without saying why.
      if (hi < lo) {
        return 'The upper end of your income range must be at least the lower end.';
      }
      return null;
    },
  ));

  // ── Identity document ────────────────────────────────────────────────────
  final docFields = <FcyKycFieldId>[
    FcyKycFieldId.documentType,
    if (prefill.documentNumber.needsInput) FcyKycFieldId.documentNumber,
    if (prefill.documentIssuedCountry.needsInput)
      FcyKycFieldId.documentIssuedCountry,
    // Issue and expiry are ALWAYS asked. We hold neither: a BVN has no expiry at
    // all, and we do not store a NIN's issue date — which is also why a BVN can
    // never serve as the document itself.
    FcyKycFieldId.documentIssuedDate,
    FcyKycFieldId.documentExpiryDate,
  ];
  steps.add(FcyKycStep(
    title: 'Your ID document',
    subtitle: currency.toUpperCase() == 'EUR'
        ? 'Passport, national ID or driver licence'
        : 'International passport',
    fields: docFields,
    validate: (v, _) {
      final missing = _requireAll(v, docFields, {
        FcyKycFieldId.documentType: 'document type',
        FcyKycFieldId.documentNumber: 'document number',
        FcyKycFieldId.documentIssuedCountry: 'issuing country',
        FcyKycFieldId.documentIssuedDate: 'issue date',
        FcyKycFieldId.documentExpiryDate: 'expiry date',
      });
      if (missing != null) return missing;

      final issued = DateTime.tryParse(v[FcyKycFieldId.documentIssuedDate] ?? '');
      final expires = DateTime.tryParse(v[FcyKycFieldId.documentExpiryDate] ?? '');
      if (issued == null || expires == null) {
        return 'Please enter the dates as YYYY-MM-DD.';
      }
      if (!expires.isAfter(issued)) {
        return 'The expiry date must be after the issue date.';
      }
      // An expired document fails compliance, so refuse it here where it costs one
      // correction instead of days of review.
      if (expires.isBefore(DateTime.now())) {
        return 'That document has expired. Please use one that is still valid.';
      }
      return null;
    },
  ));

  // ── Documents ────────────────────────────────────────────────────────────
  //
  // Never dropped and never prefilled. Prove returns a portrait selfie, not a scan
  // of a government ID, and we hold no proof of address anywhere.
  steps.add(FcyKycStep(
    title: 'Upload your documents',
    subtitle: 'Clear photos or PDFs, under 8 MB each',
    fields: const [],
    validate: (_, uploads) {
      if ((uploads.idDocumentUrl ?? '').isEmpty) {
        return 'Please upload a photo of your ID document.';
      }
      if ((uploads.addressProofUrl ?? '').isEmpty) {
        return 'Please upload a proof of address — a utility bill or bank statement from the last 3 months.';
      }
      return null;
    },
  ));

  return steps;
}

/// Returns a user-facing message naming the FIRST missing field, or null.
///
/// One field at a time, by design: a list of eight problems is a wall, and the user
/// fixes them one at a time regardless. [labels] carries human names because
/// "monthlyTxVolume is required" is a developer's sentence.
String? _requireAll(
  Map<FcyKycFieldId, String> values,
  List<FcyKycFieldId> required,
  Map<FcyKycFieldId, String> labels,
) {
  for (final id in required) {
    if ((values[id] ?? '').trim().isEmpty) {
      final label = labels[id] ?? 'this field';
      return 'Please enter your $label.';
    }
  }
  return null;
}
