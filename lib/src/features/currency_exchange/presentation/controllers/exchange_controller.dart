import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import '../../data/currency_data.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/recipient_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'package:lazervault/core/models/device_contact.dart';

class ExchangeController extends GetxController {
  final IExchangeRepository _repository;

  ExchangeController({required IExchangeRepository repository})
      : _repository = repository;

  // Observable state
  final Rx<Currency?> fromCurrency = Rx<Currency?>(null);
  final Rx<Currency?> toCurrency = Rx<Currency?>(null);
  final RxDouble amount = 0.0.obs;
  final Rx<ExchangeRate?> currentRate = Rx<ExchangeRate?>(null);
  final RxList<CurrencyTransaction> recentTransactions =
      <CurrencyTransaction>[].obs;
  final Rx<Recipient?> selectedRecipient = Rx<Recipient?>(null);
  final RxList<Recipient> recipients = <Recipient>[].obs;
  final RxList<DeviceContact> deviceContacts = <DeviceContact>[].obs;

  // UI State
  final RxBool isLoadingRate = false.obs;
  final RxBool isLoadingHistory = false.obs;
  final RxBool isLoadingRecipients = false.obs;
  final RxBool isLoadingContacts = false.obs;
  final RxBool isSubmitting = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString selectedFilter = 'All'.obs;
  final Rx<CurrencyTransaction?> lastTransaction = Rx<CurrencyTransaction?>(null);

  // Transaction verification
  final RxString verificationToken = ''.obs;
  final RxString transactionId = ''.obs;

  // Computed values
  double get convertedAmount {
    if (currentRate.value == null || amount.value == 0) return 0.0;
    return currentRate.value!.calculateToAmount(amount.value);
  }

  double get fees {
    if (currentRate.value == null) return 0.0;
    return currentRate.value!.fees;
  }

  double get totalCost {
    return amount.value + fees;
  }

  bool get canSubmit {
    return fromCurrency.value != null &&
        toCurrency.value != null &&
        amount.value > 0 &&
        selectedRecipient.value != null &&
        currentRate.value != null &&
        !isSubmitting.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with default currencies
    if (fromCurrency.value == null) {
      fromCurrency.value = CurrencyData.popularCurrencies[0]; // USD
    }
    if (toCurrency.value == null) {
      toCurrency.value = CurrencyData.popularCurrencies[2]; // GBP
    }
    // Immediately fetch the exchange rate for the default currencies
    _refreshRate();
    // Load recipients
    loadRecipients();
  }

  // Methods
  void setFromCurrency(Currency currency) {
    fromCurrency.value = currency;
    errorMessage.value = '';
    _refreshRate();
  }

  void setToCurrency(Currency currency) {
    toCurrency.value = currency;
    errorMessage.value = '';
    _refreshRate();
  }

  void swapCurrencies() {
    final temp = fromCurrency.value;
    fromCurrency.value = toCurrency.value;
    toCurrency.value = temp;
    errorMessage.value = '';
    _refreshRate();
  }

  void setAmount(double newAmount) {
    amount.value = newAmount;
    errorMessage.value = '';
    _refreshRate();
  }

  void setSelectedRecipient(Recipient? recipient) {
    selectedRecipient.value = recipient;
    errorMessage.value = '';
  }

  Future<void> _refreshRate() async {
    // Check if currencies are set
    if (fromCurrency.value == null || toCurrency.value == null) {
      currentRate.value = null;
      return;
    }

    // Check if currencies are the same
    if (fromCurrency.value!.code == toCurrency.value!.code) {
      currentRate.value = null;
      errorMessage.value = 'Please select different currencies for exchange';
      return;
    }

    isLoadingRate.value = true;
    errorMessage.value = '';

    try {
      final result = await _repository.getExchangeRate(
        fromCurrency: fromCurrency.value!.code,
        toCurrency: toCurrency.value!.code,
      );

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          currentRate.value = null;
        },
        (rate) {
          currentRate.value = ExchangeRate(
            fromCurrency: rate.fromCurrency,
            toCurrency: rate.toCurrency,
            rate: rate.rate,
            timestamp: rate.timestamp,
            fees: _calculateFees(amount.value),
          );
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to fetch exchange rate';
      currentRate.value = null;
    } finally {
      isLoadingRate.value = false;
    }
  }

  Future<void> fetchRecentTransactions() async {
    try {
      final result = await _repository.getRecentExchanges(limit: 20);

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (transactions) {
          recentTransactions.value = transactions;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to fetch recent transactions';
    }
  }

  Future<bool> submitTransfer() async {
    if (!canSubmit) return false;

    isSubmitting.value = true;
    errorMessage.value = '';

    try {
      final result = await _repository.initiateInternationalTransfer(
        fromCurrency: fromCurrency.value!.code,
        toCurrency: toCurrency.value!.code,
        amount: amount.value,
        recipientId: selectedRecipient.value!.id,
      );

      return result.fold(
        (failure) {
          errorMessage.value = failure.message;
          isSubmitting.value = false;
          return false;
        },
        (transaction) {
          lastTransaction.value = transaction;
          isSubmitting.value = false;
          return true;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to initiate transfer';
      isSubmitting.value = false;
      return false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  // Verification token methods
  void setVerificationToken(String token) {
    verificationToken.value = token;
  }

  void setTransactionId(String id) {
    transactionId.value = id;
  }

  void reset() {
    amount.value = 0.0;
    currentRate.value = null;
    selectedRecipient.value = null;
    errorMessage.value = '';
    lastTransaction.value = null;
    verificationToken.value = '';
    transactionId.value = '';
  }

  double _calculateFees(double amount) {
    // Simple fee calculation: 1% of amount with minimum $2 and maximum $50
    const feePercentage = 0.01;
    final fee = amount * feePercentage;
    const minFee = 2.0;
    const maxFee = 50.0;
    return fee.clamp(minFee, maxFee);
  }

  // Transaction history methods
  Future<void> loadRecentTransactions() async {
    isLoadingHistory.value = true;
    errorMessage.value = '';

    try {
      final result = await _repository.getRecentExchanges(limit: 5);

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (transactions) {
          recentTransactions.value = transactions;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to load transaction history';
    } finally {
      isLoadingHistory.value = false;
    }
  }

  Future<void> loadAllTransactions() async {
    isLoadingHistory.value = true;
    errorMessage.value = '';

    try {
      final result = await _repository.getRecentExchanges(limit: 100);

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
        },
        (transactions) {
          recentTransactions.value = transactions;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to load all transactions';
    } finally {
      isLoadingHistory.value = false;
    }
  }

  // Recipient methods
  Future<void> loadRecipients() async {
    isLoadingRecipients.value = true;

    try {
      // TODO: Replace with actual repository call when backend is ready
      // For now, use demo data
      await Future.delayed(const Duration(milliseconds: 500));

      recipients.value = _createDemoRecipients();
    } catch (e) {
      errorMessage.value = 'Failed to load recipients';
    } finally {
      isLoadingRecipients.value = false;
    }
  }

  List<Recipient> _createDemoRecipients() {
    // TODO: Wire to saved recipients API
    return [];
  }

  // Repeat transaction functionality
  void repeatTransaction(CurrencyTransaction transaction, TextEditingController amountController) {
    // Find currencies from the transaction
    final fromCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.fromCurrency,
    );
    final toCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.toCurrency,
    );

    if (fromCurr != null && toCurr != null) {
      // Set currencies
      setFromCurrency(fromCurr);
      setToCurrency(toCurr);

      // Set amount and update text controller
      setAmount(transaction.fromAmount);
      amountController.text = transaction.fromAmount.toStringAsFixed(2);

      // Set recipient if available
      final recipient = recipients.firstWhereOrNull(
        (r) => r.name == transaction.recipientName,
      );
      if (recipient != null) {
        setSelectedRecipient(recipient);
      }

      // Show success message
      Get.snackbar(
        'Transaction Repeated',
        'Previous transaction details have been loaded. You can modify them before continuing.',
        backgroundColor: Colors.green.withValues(alpha: 0.2),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void repeatTransactionFromHistory(CurrencyTransaction transaction) {
    // Find currencies from the transaction
    final fromCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.fromCurrency,
    );
    final toCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.toCurrency,
    );

    if (fromCurr != null && toCurr != null) {
      // Set currencies
      setFromCurrency(fromCurr);
      setToCurrency(toCurr);

      // Set amount
      setAmount(transaction.fromAmount);

      // Set recipient if available
      final recipient = recipients.firstWhereOrNull(
        (r) => r.name == transaction.recipientName,
      );
      if (recipient != null) {
        setSelectedRecipient(recipient);
      }

      // Show success message
      Get.snackbar(
        'Transaction Repeated',
        'Previous transaction details have been loaded.',
        backgroundColor: Colors.green.withValues(alpha: 0.2),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Filter management
  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  // Device contacts methods
  Future<void> loadDeviceContacts() async {
    isLoadingContacts.value = true;

    try {
      // Request permission to access contacts
      if (!await fc.FlutterContacts.requestPermission()) {
        errorMessage.value = 'Contact permission denied';
        isLoadingContacts.value = false;
        return;
      }

      // Fetch all contacts with photo and properties
      final contacts = await fc.FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      // Convert to DeviceContact models
      deviceContacts.value = contacts
          .map((contact) => DeviceContact.fromFlutterContact(contact))
          .where((contact) => contact.email != null || contact.phoneNumber != null)
          .toList();

      // Sort by name
      deviceContacts.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      errorMessage.value = 'Failed to load contacts: ${e.toString()}';
    } finally {
      isLoadingContacts.value = false;
    }
  }

  // Convert device contact to recipient for international transfer
  Recipient createRecipientFromContact(DeviceContact contact) {
    final now = DateTime.now();
    return Recipient(
      id: 'contact_${contact.id}',
      name: contact.name,
      email: contact.email ?? '',
      phone: contact.phoneNumber,
      accountNumber: '', // Will be filled by user in next step
      bankName: '', // Will be filled by user in next step
      countryCode: '', // Will be filled by user in next step
      currency: toCurrency.value?.code ?? 'USD',
      createdAt: now,
      type: RecipientType.contact,
      avatarUrl: contact.photoUrl,
    );
  }

  // Select contact and convert to recipient
  void selectDeviceContact(DeviceContact contact) {
    final recipient = createRecipientFromContact(contact);
    selectedRecipient.value = recipient;
  }
}
