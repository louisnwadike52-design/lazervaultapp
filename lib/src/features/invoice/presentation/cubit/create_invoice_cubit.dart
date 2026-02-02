import 'package:flutter_bloc/flutter_bloc.dart';
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

  // Form data - Items & Amounts
  List<InvoiceItem> _items = [];
  double _taxAmount = 0.0;
  double _discountAmount = 0.0;
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

  /// Initialize form with auto-fill data from user profile
  void initializeWithUserData(User user) {
    if (isClosed) return;
    emit(const CreateInvoiceLoading());

    // Pre-fill recipient with current user
    _recipientContact = '${user.firstName} ${user.lastName}'.trim();
    _recipientEmail = user.email;
    _recipientPhone = user.phoneNumber ?? '';
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
    _emitFormUpdated();
  }

  void updateItem(int index, InvoiceItem item) {
    if (index >= 0 && index < _items.length) {
      _items = [
        ..._items.sublist(0, index),
        item,
        ..._items.sublist(index + 1),
      ];
      _emitFormUpdated();
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items = [
        ..._items.sublist(0, index),
        ..._items.sublist(index + 1),
      ];
      _emitFormUpdated();
    }
  }

  void updateTaxAmount(double tax) {
    _taxAmount = tax;
    _emitFormUpdated();
  }

  void updateDiscountAmount(double discount) {
    _discountAmount = discount;
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
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_recipientEmail)) {
      emit(const CreateInvoiceValidationError('Please enter a valid email address'));
      return false;
    }
    if (_recipientPhone.trim().isNotEmpty && _invoiceCountry.isNotEmpty) {
      final phoneError = PhoneValidator.validate(_recipientPhone.trim(), _invoiceCountry);
      if (phoneError != null) {
        emit(CreateInvoiceValidationError(phoneError));
        return false;
      }
    }
    return true;
  }

  bool validateScreen3({bool required = false}) {
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
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(_payerEmail)) {
        emit(const CreateInvoiceValidationError('Please enter a valid email address'));
        return false;
      }
    }
    if (_payerPhone.trim().isNotEmpty && _invoiceCountry.isNotEmpty) {
      final phoneError = PhoneValidator.validate(_payerPhone.trim(), _invoiceCountry);
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
      toEmail: _recipientEmail.isNotEmpty ? _recipientEmail : null,
      toName: _recipientContact.isNotEmpty ? _recipientContact : null,
      notes: _notes.isNotEmpty ? _notes : null,
      recipientDetails: AddressDetails(
        companyName: _recipientCompany.isNotEmpty ? _recipientCompany : null,
        contactName: _recipientContact.isNotEmpty ? _recipientContact : null,
        email: _recipientEmail.isNotEmpty ? _recipientEmail : null,
        phone: _recipientPhone.isNotEmpty ? _recipientPhone : null,
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
        phone: _payerPhone.isNotEmpty ? _payerPhone : null,
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

    if (!isClosed) {
      emit(const CreateInvoiceInitial());
    }
  }
}
