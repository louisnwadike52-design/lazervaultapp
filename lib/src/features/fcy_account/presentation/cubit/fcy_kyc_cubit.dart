import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/fcy_account_service.dart';
import '../../data/fcy_prefill.dart';
import 'fcy_kyc_state.dart';
import 'fcy_kyc_steps.dart';

/// Drives the FCY KYC wizard: field state, which steps exist, and per-step
/// validation.
///
/// WHY THE STEPS ARE COMPUTED AND NOT A CONSTANT
/// --------------------------------------------
/// Prefill coverage differs per user. Measured in production: name 7/7, date of
/// birth 5/7, phone 5/7, address 3/7 — and those three hold only LGA and state, no
/// street. So for one user the personal-details step is empty and must disappear,
/// while for the next it is three fields long. A fixed five-page carousel would show
/// a page with nothing on it, which reads as a broken form.
///
/// [visibleSteps] therefore derives from the prefill every time, and a step whose
/// every field is already known is dropped. That also means the total step count in
/// the progress bar is per-user, which is correct — it is a promise about how much
/// work is left, and it would be a lie if it counted pages the user never sees.
///
/// ONLY REQUIRED FIELDS
/// --------------------
/// The form collects exactly Fincra's required set plus the tax number for USD.
/// Optional fields (other name, tax country, house number, document issuer) are not
/// asked at all: every extra input costs completion, and Fincra does not need them.
class FcyKycCubit extends Cubit<FcyKycState> implements FcyKycUploads {
  FcyKycCubit({required this.currency, FCYAccountService? service})
      : _service = service ?? FCYAccountService(),
        super(const FcyKycInitial());

  final String currency;
  final FCYAccountService _service;

  /// The collected values, keyed by [FcyKycFieldId].
  final Map<FcyKycFieldId, String> values = {};

  FcyPrefill _prefill = FcyPrefill.none;
  FcyPrefill get prefill => _prefill;

  /// Current provisioning state: none | creating | active | failed.
  ///
  /// Loaded with the prefill because this screen is reachable from TWO places —
  /// the exchange KYC gate and the "activate international deposits" link on the
  /// account card — and only the first of those pre-checks status. Without this a
  /// user whose account is already issued would be asked to complete KYC again.
  FCYStatus? _status;
  FCYStatus? get accountStatus => _status;

  /// Uploaded document URLs. Both required by Fincra and neither prefillable —
  /// Prove's photo is a portrait selfie, not a scan of a government ID, and we hold
  /// no proof of address at all.
  @override
  String? idDocumentUrl;
  @override
  String? addressProofUrl;

  int _step = 0;
  int get step => _step;

  int _revision = 0;

  /// Steps this user actually has to complete.
  List<FcyKycStep> get visibleSteps =>
      buildFcyKycSteps(currency: currency, prefill: _prefill, values: values);

  int get totalSteps => visibleSteps.length;

  bool get isLastStep => _step >= totalSteps - 1;

  /// Loads the prefill and seeds the known values.
  ///
  /// Never fails the flow: [FCYAccountService.prefill] returns [FcyPrefill.none]
  /// rather than throwing, so a dead identity service produces a longer form, not a
  /// blocked one.
  Future<void> load() async {
    emit(const FcyKycLoading());

    // Status first: when the account is already active or in review there is no
    // form to show, and fetching a prefill for it would be wasted work.
    try {
      _status = await _service.status(currency);
    } catch (_) {
      // Unreadable status is treated as "no account yet" so the form still opens.
      // The backend refuses a duplicate request anyway (an active account is
      // rejected outright), so the worst case is a wasted submission, not a
      // second account.
      _status = null;
    }

    final st = (_status?.status ?? '').toLowerCase();
    if (st == 'active' || st == 'creating') {
      emit(FcyKycAccountState(status: _status!));
      return;
    }

    _prefill = await _service.prefill(currency);
    _seedFromPrefill();
    _bump();
  }

  void _seedFromPrefill() {
    void seed(FcyKycFieldId id, FcyPrefillField f) {
      if (f.prefilled && f.value.isNotEmpty) values[id] = f.value;
    }

    seed(FcyKycFieldId.firstName, _prefill.firstName);
    seed(FcyKycFieldId.lastName, _prefill.lastName);
    seed(FcyKycFieldId.email, _prefill.email);
    seed(FcyKycFieldId.phone, _prefill.phone);
    seed(FcyKycFieldId.birthDate, _prefill.birthDate);
    seed(FcyKycFieldId.nationality, _prefill.nationality);
    seed(FcyKycFieldId.countryOfResidence, _prefill.countryOfResidence);
    seed(FcyKycFieldId.addressStreet, _prefill.addressStreet);
    seed(FcyKycFieldId.addressCity, _prefill.addressCity);
    seed(FcyKycFieldId.addressState, _prefill.addressState);
    seed(FcyKycFieldId.addressZip, _prefill.addressZip);
    seed(FcyKycFieldId.documentNumber, _prefill.documentNumber);
    seed(FcyKycFieldId.documentIssuedCountry, _prefill.documentIssuedCountry);

    // Document TYPE is prefilled only when it is one this currency accepts.
    // Fincra's accepted types are per-currency — a passport works everywhere, but
    // national ID and driver licence are EUR-only — so a prefilled "nin" must not
    // silently stand for a USD account the user would be rejected on days later.
    final t = _prefill.documentType;
    if (t.prefilled && acceptedDocumentTypes(currency).contains(t.value)) {
      values[FcyKycFieldId.documentType] = t.value;
    }

    // Sensible defaults for the two enum fields, so the user confirms rather than
    // starts from blank. These are NOT prefill — the user can change them, and they
    // are still rendered.
    values.putIfAbsent(FcyKycFieldId.documentType,
        () => acceptedDocumentTypes(currency).first);
    values.putIfAbsent(FcyKycFieldId.employmentStatus, () => 'Employed');
    values.putIfAbsent(FcyKycFieldId.sourceOfIncome, () => 'Salary');
  }

  /// Records a field value. Empty strings are stored so a cleared input is
  /// distinguishable from an untouched one during validation.
  void setValue(FcyKycFieldId id, String value) {
    values[id] = value.trim();
    _bump();
  }

  void setIdDocumentUrl(String? url) {
    idDocumentUrl = url;
    _bump();
  }

  void setAddressProofUrl(String? url) {
    addressProofUrl = url;
    _bump();
  }

  /// Validates the current step and advances. Returns false and emits a validation
  /// error when the step is incomplete, matching CreateInvoiceCubit's contract so
  /// the view logic reads the same way across the app.
  bool next() {
    final steps = visibleSteps;
    if (_step >= steps.length) return false;

    final problem = steps[_step].validate(values, this);
    if (problem != null) {
      emit(FcyKycValidationError(problem));
      // Re-emit the form so the view returns to an editable state rather than
      // being stuck on the error.
      _bump();
      return false;
    }
    if (_step < steps.length - 1) {
      _step++;
      _bump();
    }
    return true;
  }

  void back() {
    if (_step > 0) {
      _step--;
      _bump();
    }
  }

  /// Validates EVERY step, then submits.
  ///
  /// Re-validating all of them rather than trusting that each was validated on the
  /// way past is deliberate: steps can disappear as prefill loads, and a field the
  /// user edited on step 1 can be cleared before they reach the end. The backend
  /// validates the full package too and names the missing fields — this is here so
  /// the user finds out before the round trip, not instead of it.
  Future<void> submit() async {
    final steps = visibleSteps;
    for (var i = 0; i < steps.length; i++) {
      final problem = steps[i].validate(values, this);
      if (problem != null) {
        _step = i;
        emit(FcyKycValidationError(problem));
        _bump();
        return;
      }
    }

    emit(const FcyKycSubmitting());
    try {
      final result = await _service.submit(buildSubmissionBody());
      // queued comes back as a FIELD, not as a keyword in the message: the package was
      // saved and will be sent automatically when the provider re-enables foreign
      // accounts. The user must not see that as a failure — nothing they entered was
      // wrong, and telling them otherwise sends them to re-edit a correct form.
      emit(FcyKycSubmitted(
        message: result.message.trim().isEmpty
            ? 'Your details are in review.'
            : result.message,
        queued: result.queued,
      ));
    } on FCYAccountException catch (e) {
      emit(FcyKycError(e.message));
    } catch (_) {
      emit(const FcyKycError(
          'We could not submit your details just now. Please try again.'));
    }
  }

  /// Builds the exact shape the backend expects.
  ///
  /// Optional fields are omitted rather than sent empty: an empty string is a value
  /// as far as a validator is concerned, and sending blanks for things we chose not
  /// to ask about invites a rejection for a field the user never saw.
  Map<String, dynamic> buildSubmissionBody() {
    String v(FcyKycFieldId id) => (values[id] ?? '').trim();

    final body = <String, dynamic>{
      'currency': currency,
      'meansOfId': [if (idDocumentUrl != null) idDocumentUrl!],
      'utilityBill': addressProofUrl ?? '',
      'firstName': v(FcyKycFieldId.firstName),
      'lastName': v(FcyKycFieldId.lastName),
      'email': v(FcyKycFieldId.email),
      'phone': v(FcyKycFieldId.phone),
      'birthDate': v(FcyKycFieldId.birthDate),
      'nationality': v(FcyKycFieldId.nationality),
      'address': {
        'street': v(FcyKycFieldId.addressStreet),
        'city': v(FcyKycFieldId.addressCity),
        'state': v(FcyKycFieldId.addressState),
        'zip': v(FcyKycFieldId.addressZip),
        'countryOfResidence': v(FcyKycFieldId.countryOfResidence),
      },
      'occupation': v(FcyKycFieldId.occupation),
      'employmentStatus': v(FcyKycFieldId.employmentStatus),
      'sourceOfIncome': v(FcyKycFieldId.sourceOfIncome),
      'accountDesignation': 'personal',
      'incomeBandLower': v(FcyKycFieldId.incomeLower),
      'incomeBandUpper': v(FcyKycFieldId.incomeUpper),
      'monthlyTransactionCount': v(FcyKycFieldId.monthlyTxCount),
      'monthlyTransactionVolume': v(FcyKycFieldId.monthlyTxVolume),
      'document': {
        'type': v(FcyKycFieldId.documentType),
        'number': v(FcyKycFieldId.documentNumber),
        'issuedCountryCode': v(FcyKycFieldId.documentIssuedCountry),
        'issuedDate': v(FcyKycFieldId.documentIssuedDate),
        'expirationDate': v(FcyKycFieldId.documentExpiryDate),
      },
    };

    // Fincra requires a tax number for USD accounts only.
    final tax = v(FcyKycFieldId.taxNumber);
    if (tax.isNotEmpty) body['taxNumber'] = tax;

    return body;
  }

  void _bump() {
    _revision++;
    emit(FcyKycFormUpdated(revision: _revision, prefill: _prefill));
  }
}
