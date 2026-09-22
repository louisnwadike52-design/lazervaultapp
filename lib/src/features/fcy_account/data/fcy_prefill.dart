/// What the FCY KYC form does NOT have to ask for.
///
/// Fincra requires 24 fields plus two uploaded documents, and the form asked for
/// every one by hand — including the name, date of birth and phone that Mono had
/// already verified for that same user. The backend now returns each recoverable
/// value with a flag.
///
/// THE FLAG IS AN INSTRUCTION, NOT A HINT
/// --------------------------------------
/// `prefilled == true` means "do not render this input". The server guarantees it is
/// never true with an empty value, because a hidden empty input would become a blank
/// submission that Fincra rejects and the user would never see the field that caused
/// it. [FcyPrefillField.fromJson] re-checks that invariant locally anyway: trusting a
/// remote flag to protect a form is one deploy-skew away from an unfillable field.
///
/// An absent or empty field means ASK. It does NOT mean "the user has none" — the
/// server deliberately collapses "no data" and "identity service unreachable" into
/// the same answer, because both must result in asking.
class FcyPrefillField {
  const FcyPrefillField({this.value = '', this.prefilled = false});

  final String value;
  final bool prefilled;

  /// Empty field: ask the user.
  static const empty = FcyPrefillField();

  factory FcyPrefillField.fromJson(dynamic json) {
    if (json is! Map) return empty;
    final v = (json['value'] as String?)?.trim() ?? '';
    final flag = json['prefilled'] == true;
    // Local re-check of the server invariant. A flag without a value would hide an
    // input the user then cannot fill.
    return FcyPrefillField(value: v, prefilled: flag && v.isNotEmpty);
  }

  /// True when this field still has to be collected.
  bool get needsInput => !prefilled || value.isEmpty;
}

/// The whole prefill payload.
class FcyPrefill {
  const FcyPrefill({
    this.firstName = FcyPrefillField.empty,
    this.lastName = FcyPrefillField.empty,
    this.middleName = FcyPrefillField.empty,
    this.email = FcyPrefillField.empty,
    this.phone = FcyPrefillField.empty,
    this.birthDate = FcyPrefillField.empty,
    this.nationality = FcyPrefillField.empty,
    this.countryOfResidence = FcyPrefillField.empty,
    this.addressStreet = FcyPrefillField.empty,
    this.addressCity = FcyPrefillField.empty,
    this.addressState = FcyPrefillField.empty,
    this.addressZip = FcyPrefillField.empty,
    this.documentType = FcyPrefillField.empty,
    this.documentNumber = FcyPrefillField.empty,
    this.documentIssuedCountry = FcyPrefillField.empty,
    this.identityVerified = false,
  });

  final FcyPrefillField firstName;
  final FcyPrefillField lastName;
  final FcyPrefillField middleName;
  final FcyPrefillField email;
  final FcyPrefillField phone;
  final FcyPrefillField birthDate;

  final FcyPrefillField nationality;
  final FcyPrefillField countryOfResidence;
  final FcyPrefillField addressStreet;
  final FcyPrefillField addressCity;
  final FcyPrefillField addressState;
  final FcyPrefillField addressZip;

  final FcyPrefillField documentType;
  final FcyPrefillField documentNumber;
  final FcyPrefillField documentIssuedCountry;

  /// Display only. A partially-verified identity still yields a usable name and
  /// date of birth, so prefill is offered either way and this gates nothing.
  final bool identityVerified;

  /// Nothing recovered: the form asks for everything. This is the correct degraded
  /// mode when the user never completed Mono KYC, or the lookup failed.
  static const none = FcyPrefill();

  factory FcyPrefill.fromJson(Map<String, dynamic> json) {
    FcyPrefillField f(String snake, String camel) =>
        FcyPrefillField.fromJson(json[snake] ?? json[camel]);

    return FcyPrefill(
      firstName: f('first_name', 'firstName'),
      lastName: f('last_name', 'lastName'),
      middleName: f('middle_name', 'middleName'),
      email: f('email', 'email'),
      phone: f('phone', 'phone'),
      birthDate: f('birth_date', 'birthDate'),
      nationality: f('nationality', 'nationality'),
      countryOfResidence: f('country_of_residence', 'countryOfResidence'),
      addressStreet: f('address_street', 'addressStreet'),
      addressCity: f('address_city', 'addressCity'),
      addressState: f('address_state', 'addressState'),
      addressZip: f('address_zip', 'addressZip'),
      documentType: f('document_type', 'documentType'),
      documentNumber: f('document_number', 'documentNumber'),
      documentIssuedCountry:
          f('document_issued_country', 'documentIssuedCountry'),
      identityVerified:
          json['identity_verified'] == true || json['identityVerified'] == true,
    );
  }

  /// How many fields we saved the user from typing. Drives the "we've filled in N
  /// details from your verified profile" line, which is what makes the prefill
  /// visible — a form that silently has fewer fields just looks shorter.
  ///
  /// Counts `!needsInput`, not `prefilled`, so it agrees with what the form actually
  /// hides. A field flagged prefilled but carrying no value is still asked for, and
  /// claiming credit for it would overstate the count by exactly the fields the user
  /// can see they still have to fill.
  int get filledCount => [
        firstName,
        lastName,
        middleName,
        email,
        phone,
        birthDate,
        nationality,
        countryOfResidence,
        addressStreet,
        addressCity,
        addressState,
        addressZip,
        documentType,
        documentNumber,
        documentIssuedCountry,
      ].where((f) => !f.needsInput).length;
}
