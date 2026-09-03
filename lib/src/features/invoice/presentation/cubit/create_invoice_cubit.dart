import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'dart:io';
import '../../domain/entities/invoice_entity.dart';
import '../../../authentication/domain/entities/user.dart';
import '../utils/phone_validator.dart';
import 'create_invoice_state.dart';

/// Cubit for managing invoice creation form state across multiple screens
class CreateInvoiceCubit extends Cubit<CreateInvoiceState> {
  CreateInvoiceCubit() : super(const CreateInvoiceInitial());

  // Form data - Basic Info
  InvoiceType _invoiceType = InvoiceType.invoice;
  String _title = '';
  String _description = '';
  DateTime? _dueDate;
  String _invoiceCurrency = '';
  String _invoiceCountry = '';

  // Form data - Recipient Details
  String _recipientCompany = '';
  String _recipientContact = '';
  String _recipientEmail = '';
  String _recipientPhone = '';
  String _recipientAddress1 = '';
  String _recipientAddress2 = '';
  String _recipientCity = '';
  String _recipientState = '';
  String _recipientPostcode = '';
  String _recipientCountry = '';

  // Form data - Payer Details
  String _payerCompany = '';
  String _payerContact = '';
  String _payerEmail = '';
  String _payerPhone = '';
  String _payerAddress1 = '';
  String _payerAddress2 = '';
  String _payerCity = '';
  String _payerState = '';
  String _payerPostcode = '';
  String _payerCountry = '';
  File? _payerImage;
  File? _recipientImage;

  // EDIT MODE. Null id = creating. When set, the carousel saves through
  // updateInvoice instead of createInvoice.
  //
  // The logo URLs are kept SEPARATELY from the File picks above, because the
  // two mean different things: a File is a new image the user just chose and
  // still has to be uploaded, whereas a URL is a logo already on the invoice.
  // Holding only Files would have meant an edit either re-uploaded an image we
  // already had or, worse, sent an empty logo and looked like it had been
  // deleted.
  String? _editingInvoiceId;
  InvoiceStatus? _editingStatus;
  String _payerLogoUrl = '';
  String _recipientLogoUrl = '';

  // Form data - Items & Amounts
  List<InvoiceItem> _items = [];
  double _taxAmount = 0.0;
  double _discountAmount = 0.0;

  // Split payment: when on, the invoice is split among multiple tagged app users
  // (each charged their share) instead of billed to one recipient. _splitCustom
  // is false while the split is equal (backend computes exact equal shares) and
  // true once the user edits an amount (per-user amounts are sent).
  bool _splitMode = false;
  bool _splitCustom = false;
  final List<TaggedUserInfo> _splitPayers = [];
  String _notes = '';

  bool _isAutoFilled = false;

  // Getters for current form data - Basic Info
  InvoiceType get invoiceType => _invoiceType;
  String get title => _title;
  String get description => _description;
  DateTime? get dueDate => _dueDate;
  String get invoiceCurrency => _invoiceCurrency;
  String get invoiceCountry => _invoiceCountry;

  // Getters - Recipient Details
  String get recipientCompany => _recipientCompany;
  String get recipientContact => _recipientContact;
  String get recipientEmail => _recipientEmail;
  String get recipientPhone => _recipientPhone;
  String get recipientAddress1 => _recipientAddress1;
  String get recipientAddress2 => _recipientAddress2;
  String get recipientCity => _recipientCity;
  String get recipientState => _recipientState;
  String get recipientPostcode => _recipientPostcode;
  String get recipientCountry => _recipientCountry;

  // Getters - Payer Details
  String get payerCompany => _payerCompany;
  String get payerContact => _payerContact;
  String get payerEmail => _payerEmail;
  String get payerPhone => _payerPhone;
  String get payerAddress1 => _payerAddress1;
  String get payerAddress2 => _payerAddress2;
  String get payerCity => _payerCity;
  String get payerState => _payerState;
  String get payerPostcode => _payerPostcode;
  String get payerCountry => _payerCountry;
  File? get payerImage => _payerImage;
  File? get recipientImage => _recipientImage;

  /// True when this form is editing an existing invoice rather than creating.
  bool get isEditing => _editingInvoiceId != null;
  String? get editingInvoiceId => _editingInvoiceId;

  /// Logos already stored on the invoice being edited. Empty while creating.
  String get payerLogoUrl => _payerLogoUrl;
  String get recipientLogoUrl => _recipientLogoUrl;

  // Getters - Items & Amounts
  List<InvoiceItem> get items => List.unmodifiable(_items);
  double get taxAmount => _taxAmount;
  double get discountAmount => _discountAmount;
  String get notes => _notes;
  bool get isAutoFilled => _isAutoFilled;

  // Calculated amounts
  double get subtotal {
    return _items.fold(0.0, (sum, item) => sum + (item.unitPrice * item.quantity));
  }

  double get total {
    return subtotal + _taxAmount - _discountAmount;
  }

  // ── Split payment ──────────────────────────────────────────────────────────
  /// Split is admin-gated and OFF by default. Reading through the flag here —
  /// the one choke point every consumer uses — guarantees a stale `true` can
  /// never leak a split payload into a created invoice after an admin turns
  /// the capability off.
  bool get splitMode => _splitMode && FeatureFlags.invoiceSplitIsEnabled;
  bool get splitCustom => _splitCustom;
  List<TaggedUserInfo> get splitPayers => List.unmodifiable(_splitPayers);
  double get splitAssigned =>
      _splitPayers.fold(0.0, (s, p) => s + p.shareAmount);
  double get splitRemaining => total - splitAssigned;

  /// Whether the split is valid to submit: at least one payer, and — in custom
  /// mode — the per-person amounts sum to the invoice total (within a cent).
  bool get splitIsValid {
    if (_splitPayers.isEmpty) return false;
    if (!_splitCustom) return true; // equal split is always exact
    return (splitRemaining).abs() < 0.01;
  }

  void toggleSplitMode(bool on) {
    _splitMode = on;
    if (on && _splitPayers.isNotEmpty) _redistributeEqually();
    _emitFormUpdated();
  }

  void addSplitPayer(TaggedUserInfo payer) {
    if (_splitPayers.any((p) => p.userId == payer.userId)) return;
    _splitPayers.add(payer);
    if (!_splitCustom) _redistributeEqually();
    _emitFormUpdated();
  }

  void removeSplitPayer(String userId) {
    _splitPayers.removeWhere((p) => p.userId == userId);
    if (!_splitCustom) _redistributeEqually();
    _emitFormUpdated();
  }

  /// Set one payer's custom amount; flips the split into custom mode.
  void setSplitPayerAmount(String userId, double amount) {
    final i = _splitPayers.indexWhere((p) => p.userId == userId);
    if (i < 0) return;
    _splitCustom = true;
    _splitPayers[i] =
        _splitPayers[i].copyWith(shareAmount: amount < 0 ? 0 : amount);
    _emitFormUpdated();
  }

  /// Reset to an equal split (backend computes exact shares).
  void splitEqually() {
    _splitCustom = false;
    _redistributeEqually();
    _emitFormUpdated();
  }

  void _redistributeEqually() {
    final n = _splitPayers.length;
    if (n == 0) return;
    final per = total / n;
    for (var i = 0; i < n; i++) {
      _splitPayers[i] = _splitPayers[i].copyWith(shareAmount: per);
    }
  }

  /// Keep equal-split display amounts in sync when items/tax/discount change.
  void _resyncEqualSplit() {
    if (_splitMode && !_splitCustom && _splitPayers.isNotEmpty) {
      _redistributeEqually();
    }
  }

  /// Initialize form with auto-fill data from user profile
  void initializeWithUserData(User user) {
    if (isClosed) return;
    emit(const CreateInvoiceLoading());

    // Pre-fill recipient with current user
    _recipientContact = '${user.firstName} ${user.lastName}'.trim();
    _recipientEmail = user.email;
    _isAutoFilled = true;

    _emitFormUpdated();
  }

  // Update methods - Basic Info
  void updateInvoiceType(InvoiceType type) {
    _invoiceType = type;
    _emitFormUpdated();
  }

  void updateTitle(String title) {
    _title = title;
    _emitFormUpdated();
  }

  void updateDescription(String description) {
    _description = description;
    _emitFormUpdated();
  }

  void updateDueDate(DateTime? date) {
    _dueDate = date;
    _emitFormUpdated();
  }

  void updateInvoiceCurrency(String currency) {
    _invoiceCurrency = currency;
    _emitFormUpdated();
  }

  void updateInvoiceCountry(String country) {
    _invoiceCountry = country;
    _emitFormUpdated();
  }

  // Update methods - Recipient Details
  void updateRecipientCompany(String company) {
    _recipientCompany = company;
    _emitFormUpdated();
  }

  void updateRecipientContact(String contact) {
    _recipientContact = contact;
    _emitFormUpdated();
  }

  void updateRecipientEmail(String email) {
    _recipientEmail = email;
    _emitFormUpdated();
  }

  void updateRecipientPhone(String phone) {
    _recipientPhone = phone;
    _emitFormUpdated();
  }

  void updateRecipientAddress1(String address) {
    _recipientAddress1 = address;
    _emitFormUpdated();
  }

  void updateRecipientAddress2(String address) {
    _recipientAddress2 = address;
    _emitFormUpdated();
  }

  void updateRecipientCity(String city) {
    _recipientCity = city;
    _emitFormUpdated();
  }

  void updateRecipientState(String state) {
    _recipientState = state;
    _emitFormUpdated();
  }

  void updateRecipientPostcode(String postcode) {
    _recipientPostcode = postcode;
    _emitFormUpdated();
  }

  void updateRecipientCountry(String country) {
    _recipientCountry = country;
    _emitFormUpdated();
  }

  // Update methods - Payer Details
  void updatePayerCompany(String company) {
    _payerCompany = company;
    _emitFormUpdated();
  }

  void updatePayerContact(String contact) {
    _payerContact = contact;
    _emitFormUpdated();
  }

  void updatePayerEmail(String email) {
    _payerEmail = email;
    _emitFormUpdated();
  }

  void updatePayerPhone(String phone) {
    _payerPhone = phone;
    _emitFormUpdated();
  }

  void updatePayerAddress1(String address) {
    _payerAddress1 = address;
    _emitFormUpdated();
  }

  void updatePayerAddress2(String address) {
    _payerAddress2 = address;
    _emitFormUpdated();
  }

  void updatePayerCity(String city) {
    _payerCity = city;
    _emitFormUpdated();
  }

  void updatePayerState(String state) {
    _payerState = state;
    _emitFormUpdated();
  }

  void updatePayerPostcode(String postcode) {
    _payerPostcode = postcode;
    _emitFormUpdated();
  }

  void updatePayerCountry(String country) {
    _payerCountry = country;
    _emitFormUpdated();
  }

  void updatePayerImage(File? image) {
    _payerImage = image;
    _emitFormUpdated();
  }

  void updateRecipientImage(File? image) {
    _recipientImage = image;
    _emitFormUpdated();
  }

  // Update methods - Items & Amounts
  void addItem(InvoiceItem item) {
    _items = [..._items, item];
    // Shares follow the price. The split UI promises "shares split equally and
    // update automatically", but the pricing mutators never resynced, so a
    // payer added before the items kept a share computed against a ₦0 total.
    _resyncEqualSplit();
    _emitFormUpdated();
  }

  void updateItem(int index, InvoiceItem item) {
    if (index >= 0 && index < _items.length) {
      _items = [
        ..._items.sublist(0, index),
        item,
        ..._items.sublist(index + 1),
      ];
      _resyncEqualSplit();
      _emitFormUpdated();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items = [
        ..._items.sublist(0, index),
        ..._items.sublist(index + 1),
      ];
      _resyncEqualSplit();
      _emitFormUpdated();
    }
  }

  void updateTaxAmount(double tax) {
    _taxAmount = tax;
    _resyncEqualSplit();
    _emitFormUpdated();
  }

  void updateDiscountAmount(double discount) {
    _discountAmount = discount;
    _resyncEqualSplit();
    _emitFormUpdated();
  }

  void updateNotes(String notes) {
    _notes = notes;
    _emitFormUpdated();
  }

  // Validation methods for each screen
  bool validateScreen1() {
    if (_title.trim().isEmpty) {
      emit(const CreateInvoiceValidationError('Please enter an invoice title'));
      return false;
    }
    if (_description.trim().isEmpty) {
      emit(const CreateInvoiceValidationError('Please enter a description'));
      return false;
    }
    return true;
  }

  bool validateScreen2({bool required = false}) {
    // Skip validation if recipient section wasn't shown and no data entered
    final hasAnyData = _recipientContact.trim().isNotEmpty ||
        _recipientEmail.trim().isNotEmpty;
    if (!required && !hasAnyData) return true;

    if (_recipientContact.trim().isEmpty) {
      emit(const CreateInvoiceValidationError('Please enter recipient contact name'));
      return false;
    }
    if (_recipientEmail.trim().isEmpty) {
      emit(const CreateInvoiceValidationError('Please enter recipient email'));
      return false;
    }
    // TLD is {2,} not {2,4}: the old bound rejected every modern TLD longer
    // than four characters — .online, .digital, .travel, .company — as an
    // "invalid email address", with no way for the user to proceed.
    final emailRegex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$');
    if (!emailRegex.hasMatch(_recipientEmail)) {
      emit(const CreateInvoiceValidationError('Please enter a valid email address'));
      return false;
    }
    if (_recipientPhone.trim().isNotEmpty) {
      // Country-agnostic: the recipient may be in any country, so we do NOT
      // enforce the invoice country's digit count. A missing country code is
      // fine — it's defaulted when the invoice is built.
      final phoneError = PhoneValidator.validateInternational(_recipientPhone.trim());
      if (phoneError != null) {
        emit(CreateInvoiceValidationError(phoneError));
        return false;
      }
    }
    return true;
  }

  bool validateScreen3({bool required = false}) {
    // Split mode replaces the single-payer contact form with a list of tagged
    // app users, so validate the split instead. The exact amount-balance check
    // runs at submit time (splitIsValid); here we just need at least one payer.
    if (_splitMode) {
      if (_splitPayers.isEmpty) {
        emit(const CreateInvoiceValidationError(
            'Add at least one person to split with'));
        return false;
      }
      return true;
    }

    // Skip validation if payer section wasn't shown and no data entered
    final hasAnyData = _payerContact.trim().isNotEmpty ||
        _payerEmail.trim().isNotEmpty;
    if (!required && !hasAnyData) return true;

    if (_payerContact.trim().isEmpty) {
      emit(const CreateInvoiceValidationError('Please enter payer contact name'));
      return false;
    }
    // Email is optional, but validate format if provided
    if (_payerEmail.trim().isNotEmpty) {
      // TLD is {2,} not {2,4}: the old bound rejected every modern TLD longer
    // than four characters — .online, .digital, .travel, .company — as an
    // "invalid email address", with no way for the user to proceed.
    final emailRegex = RegExp(r'^[\w\-.]+@([\w\-]+\.)+[\w\-]{2,}$');
      if (!emailRegex.hasMatch(_payerEmail)) {
        emit(const CreateInvoiceValidationError('Please enter a valid email address'));
        return false;
      }
    }
    if (_payerPhone.trim().isNotEmpty) {
      // Country-agnostic (see recipient) — the payer can be anywhere.
      final phoneError = PhoneValidator.validateInternational(_payerPhone.trim());
      if (phoneError != null) {
        emit(CreateInvoiceValidationError(phoneError));
        return false;
      }
    }
    return true;
  }

  bool validateScreen4() {
    if (_items.isEmpty) {
      emit(const CreateInvoiceValidationError('Please add at least one item'));
      return false;
    }
    if (_discountAmount > subtotal + _taxAmount) {
      emit(const CreateInvoiceValidationError('Discount cannot exceed subtotal plus tax'));
      return false;
    }
    if (total <= 0) {
      emit(const CreateInvoiceValidationError('Total amount must be greater than zero'));
      return false;
    }
    // Split balance is validated HERE — leaving the Items step, which is the
    // first point the invoice total is known — rather than only at the final
    // Create button. A custom split entered on the payer step against a total
    // that only becomes real once items are added would otherwise sail through
    // to the last slide before failing.
    if (_splitMode && _splitPayers.isNotEmpty && !splitIsValid) {
      emit(const CreateInvoiceValidationError(
          'Split amounts must add up to the invoice total. Tap "Split equally" or adjust the shares.'));
      return false;
    }
    return true;
  }

  bool validateScreen5() {
    // Final validation before submission
    return validateScreen1() &&
           validateScreen2() &&
           validateScreen3() &&
           validateScreen4();
  }

  /// Build the final Invoice entity
  /// Loads an existing invoice into the form so the carousel can edit it.
  ///
  /// The exact inverse of [buildInvoice]. Anything this misses does not merely
  /// render blank, it gets SENT BACK as a change: the backend treats a
  /// non-empty field as an overwrite, so a field dropped here would look to
  /// the user like the edit had silently wiped it. That is why every field
  /// buildInvoice writes is read back, including the two logo URLs, which are
  /// held as URLs rather than Files because they are already uploaded.
  void loadForEdit(Invoice invoice) {
    _editingInvoiceId = invoice.id;
    _editingStatus = invoice.status;

    _invoiceType = invoice.type;
    _title = invoice.title;
    _description = invoice.description;
    _dueDate = invoice.dueDate;
    _invoiceCurrency = invoice.currency;

    final r = invoice.recipientDetails;
    _recipientCompany = r?.companyName ?? '';
    _recipientContact = r?.contactName ?? '';
    _recipientEmail = r?.email ?? '';
    _recipientPhone = r?.phone ?? '';
    _recipientAddress1 = r?.addressLine1 ?? '';
    _recipientAddress2 = r?.addressLine2 ?? '';
    _recipientCity = r?.city ?? '';
    _recipientState = r?.state ?? '';
    _recipientPostcode = r?.postcode ?? '';
    _recipientCountry = r?.country ?? '';

    final p = invoice.payerDetails;
    _payerCompany = p?.companyName ?? '';
    // Fall back to the flat toName/toEmail an older invoice may carry instead
    // of a payer block, so those still populate rather than opening blank.
    _payerContact = p?.contactName ?? invoice.toName ?? '';
    _payerEmail = p?.email ?? invoice.toEmail ?? '';
    _payerPhone = p?.phone ?? '';
    _payerAddress1 = p?.addressLine1 ?? '';
    _payerAddress2 = p?.addressLine2 ?? '';
    _payerCity = p?.city ?? '';
    _payerState = p?.state ?? '';
    _payerPostcode = p?.postcode ?? '';
    _payerCountry = p?.country ?? '';

    _payerLogoUrl = invoice.payerLogoUrl ?? '';
    _recipientLogoUrl = invoice.recipientLogoUrl ?? '';
    // No local picks yet: the stored logos are URLs, and only a fresh pick
    // needs uploading.
    _payerImage = null;
    _recipientImage = null;

    _items = List<InvoiceItem>.from(invoice.items);
    _taxAmount = invoice.taxAmount ?? 0;
    _discountAmount = invoice.discountAmount ?? 0;
    _notes = invoice.notes ?? '';

    _emitFormUpdated();
  }

  /// Rebuilds the edited invoice, preserving its id and status.
  ///
  /// buildInvoice always stamps a blank id and a draft status because it is
  /// written for creation. Saving an edit with those would address the update
  /// at no invoice at all.
  Invoice buildEditedInvoice(String userId, {String currency = 'NGN'}) {
    final base = buildInvoice(userId, currency: currency);
    return base.copyWith(
      id: _editingInvoiceId ?? base.id,
      status: _editingStatus ?? base.status,
      payerLogoUrl: _payerLogoUrl.isNotEmpty ? _payerLogoUrl : null,
      recipientLogoUrl: _recipientLogoUrl.isNotEmpty ? _recipientLogoUrl : null,
    );
  }

  Invoice buildInvoice(String userId, {String currency = 'NGN'}) {
    final effectiveCurrency = _invoiceCurrency.isNotEmpty ? _invoiceCurrency : currency;
    return Invoice(
      id: '', // Will be generated by backend
      fromUserId: userId,
      title: _title,
      description: _description,
      type: _invoiceType,
      status: InvoiceStatus.draft,
      items: _items,
      amount: subtotal,
      taxAmount: _taxAmount,
      discountAmount: _discountAmount,
      totalAmount: total,
      currency: effectiveCurrency,
      createdAt: DateTime.now(),
      dueDate: _dueDate,
      toEmail: _payerEmail.isNotEmpty ? _payerEmail : null,
      toName: _payerContact.isNotEmpty ? _payerContact : null,
      notes: _notes.isNotEmpty ? _notes : null,
      recipientDetails: AddressDetails(
        companyName: _recipientCompany.isNotEmpty ? _recipientCompany : null,
        contactName: _recipientContact.isNotEmpty ? _recipientContact : null,
        email: _recipientEmail.isNotEmpty ? _recipientEmail : null,
        // Normalise to E.164 so the stored number always carries a country
        // code — defaulting to the invoice country's dial code, then Nigeria.
        phone: _recipientPhone.isNotEmpty
            ? PhoneValidator.toE164(_recipientPhone,
                defaultDialCode: PhoneValidator.defaultDialCodeFor(_invoiceCountry))
            : null,
        addressLine1: _recipientAddress1.isNotEmpty ? _recipientAddress1 : null,
        addressLine2: _recipientAddress2.isNotEmpty ? _recipientAddress2 : null,
        city: _recipientCity.isNotEmpty ? _recipientCity : null,
        state: _recipientState.isNotEmpty ? _recipientState : null,
        postcode: _recipientPostcode.isNotEmpty ? _recipientPostcode : null,
        country: _recipientCountry.isNotEmpty ? _recipientCountry : null,
      ),
      payerDetails: AddressDetails(
        companyName: _payerCompany.isNotEmpty ? _payerCompany : null,
        contactName: _payerContact.isNotEmpty ? _payerContact : null,
        email: _payerEmail.isNotEmpty ? _payerEmail : null,
        phone: _payerPhone.isNotEmpty
            ? PhoneValidator.toE164(_payerPhone,
                defaultDialCode: PhoneValidator.defaultDialCodeFor(_invoiceCountry))
            : null,
        addressLine1: _payerAddress1.isNotEmpty ? _payerAddress1 : null,
        addressLine2: _payerAddress2.isNotEmpty ? _payerAddress2 : null,
        city: _payerCity.isNotEmpty ? _payerCity : null,
        state: _payerState.isNotEmpty ? _payerState : null,
        postcode: _payerPostcode.isNotEmpty ? _payerPostcode : null,
        country: _payerCountry.isNotEmpty ? _payerCountry : null,
      ),
    );
  }

  void _emitFormUpdated() {
    if (isClosed) return;
    // Keep equal-split amounts in sync when the invoice total changes.
    _resyncEqualSplit();
    emit(CreateInvoiceFormUpdated(
      invoiceType: _invoiceType,
      title: _title,
      description: _description,
      dueDate: _dueDate,
      items: _items,
      subtotal: subtotal,
      taxAmount: _taxAmount,
      discountAmount: _discountAmount,
      total: total,
      payerImagePath: _payerImage?.path,
      recipientImagePath: _recipientImage?.path,
      splitMode: _splitMode,
      splitCustom: _splitCustom,
      splitPayers: List.unmodifiable(_splitPayers),
      invoiceCurrency: _invoiceCurrency,
      invoiceCountry: _invoiceCountry,
    ));
  }

  /// Reset form to initial state
  void reset() {
    _invoiceType = InvoiceType.invoice;
    _title = '';
    _description = '';
    _dueDate = null;
    _invoiceCurrency = '';
    _invoiceCountry = '';
    _recipientCompany = '';
    _recipientContact = '';
    _recipientEmail = '';
    _recipientPhone = '';
    _recipientAddress1 = '';
    _recipientAddress2 = '';
    _recipientCity = '';
    _recipientState = '';
    _recipientPostcode = '';
    _recipientCountry = '';
    _payerCompany = '';
    _payerContact = '';
    _payerEmail = '';
    _payerPhone = '';
    _payerAddress1 = '';
    _payerAddress2 = '';
    _payerCity = '';
    _payerState = '';
    _payerPostcode = '';
    _payerCountry = '';
    _payerImage = null;
    _recipientImage = null;
    _items = [];
    _taxAmount = 0.0;
    _discountAmount = 0.0;
    _notes = '';
    _isAutoFilled = false;
    // Split state must reset too, or the payers from the last invoice leak
    // into the next one created in the same session.
    _splitMode = false;
    _splitCustom = false;
    _splitPayers.clear();

    if (!isClosed) {
      emit(const CreateInvoiceInitial());
    }
  }
}
