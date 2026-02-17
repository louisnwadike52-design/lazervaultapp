import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:uuid/uuid.dart';
import '../../data/currency_data.dart';
import '../../domain/entities/currency_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/entities/recipient_entity.dart';
import '../../domain/repositories/i_exchange_repository.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';

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

  // Exchange mode: true = conversion (wallet-to-wallet), false = international transfer
  final RxBool isConversionMode = false.obs;

  // Transaction verification
  final RxString verificationToken = ''.obs;
  final RxString transactionId = ''.obs;

  // Debouncer for rate refresh
  final Debouncer _rateDebouncer = Debouncer.search();

  // UUID generator for idempotency keys
  static const _uuid = Uuid();

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
    if (isConversionMode.value) {
      return fromCurrency.value != null &&
          toCurrency.value != null &&
          amount.value > 0 &&
          currentRate.value != null &&
          !isSubmitting.value;
    }
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
    if (fromCurrency.value == null) {
      final localeManager = serviceLocator<LocaleManager>();
      final userCurrency = localeManager.currentCurrency;
      fromCurrency.value = CurrencyData.getCurrencyByCode(userCurrency)
          ?? CurrencyData.allCurrencies.first;
      toCurrency.value = _getDefaultToCurrency(fromCurrency.value!);
    }
    if (toCurrency.value == null) {
      toCurrency.value = _getDefaultToCurrency(fromCurrency.value!);
    }
    _refreshRate();
    loadRecipients();
  }

  Currency _getDefaultToCurrency(Currency from) {
    const defaultToCode = {
      'NGN': 'USD',
      'USD': 'NGN',
      'GBP': 'USD',
      'EUR': 'USD',
      'GHS': 'USD',
      'KES': 'USD',
      'ZAR': 'USD',
      'UGX': 'USD',
      'TZS': 'USD',
      'XOF': 'USD',
    };
    final toCode = defaultToCode[from.code] ?? 'USD';
    return CurrencyData.getCurrencyByCode(toCode)
        ?? CurrencyData.allCurrencies[1]; // fallback to USD (index 1)
  }

  @override
  void onClose() {
    _rateDebouncer.dispose();
    super.onClose();
  }

  // Methods
  void setFromCurrency(Currency currency) {
    fromCurrency.value = currency;
    errorMessage.value = '';
    _debouncedRefreshRate();
  }

  void setToCurrency(Currency currency) {
    toCurrency.value = currency;
    errorMessage.value = '';
    _debouncedRefreshRate();
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
    _debouncedRefreshRate();
  }

  void setSelectedRecipient(Recipient? recipient) {
    selectedRecipient.value = recipient;
    errorMessage.value = '';
  }

  void setExchangeMode(bool isConversion) {
    isConversionMode.value = isConversion;
    if (isConversion) {
      selectedRecipient.value = null;
    }
  }

  void _debouncedRefreshRate() {
    _rateDebouncer.run(_refreshRate);
  }

  Future<void> _refreshRate() async {
    if (fromCurrency.value == null || toCurrency.value == null) {
      currentRate.value = null;
      return;
    }

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
        amount: amount.value > 0 ? amount.value : null,
      );

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          currentRate.value = null;
        },
        (rate) {
          currentRate.value = rate;
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

  /// Submit an international transfer
  Future<bool> submitTransfer() async {
    if (!canSubmit) return false;

    isSubmitting.value = true;
    errorMessage.value = '';

    final idempotencyKey = _uuid.v4();
    final recipient = selectedRecipient.value!;

    try {
      final result = await _repository.initiateInternationalTransfer(
        fromCurrency: fromCurrency.value!.code,
        toCurrency: toCurrency.value!.code,
        amount: amount.value,
        recipientId: recipient.id,
        verificationToken: verificationToken.value,
        idempotencyKey: idempotencyKey,
        rateId: currentRate.value?.rateId,
        recipientName: recipient.name,
        recipientAccountNumber: recipient.accountNumber,
        recipientBankName: recipient.bankName,
        recipientSwiftCode: recipient.swiftCode,
        recipientCountry: recipient.countryCode,
        recipientEmail: recipient.email,
      );

      return result.fold(
        (failure) {
          errorMessage.value = failure.message;
          isSubmitting.value = false;
          return false;
        },
        (transaction) {
          lastTransaction.value = transaction;
          transactionId.value = transaction.id;
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

  /// Submit a wallet-to-wallet conversion
  Future<bool> submitConversion() async {
    if (fromCurrency.value == null ||
        toCurrency.value == null ||
        amount.value <= 0 ||
        currentRate.value == null) return false;

    isSubmitting.value = true;
    errorMessage.value = '';

    final idempotencyKey = _uuid.v4();

    try {
      final result = await _repository.convertCurrency(
        fromCurrency: fromCurrency.value!.code,
        toCurrency: toCurrency.value!.code,
        amount: amount.value,
        verificationToken: verificationToken.value,
        idempotencyKey: idempotencyKey,
        rateId: currentRate.value?.rateId,
      );

      return result.fold(
        (failure) {
          errorMessage.value = failure.message;
          isSubmitting.value = false;
          return false;
        },
        (transaction) {
          lastTransaction.value = transaction;
          transactionId.value = transaction.id;
          isSubmitting.value = false;
          return true;
        },
      );
    } catch (e) {
      errorMessage.value = 'Failed to convert currency';
      isSubmitting.value = false;
      return false;
    }
  }

  /// Poll transaction status until completed or failed
  Future<CurrencyTransaction?> pollTransactionStatus({
    int maxAttempts = 20,
    Duration interval = const Duration(seconds: 2),
  }) async {
    if (transactionId.value.isEmpty && lastTransaction.value == null) {
      return null;
    }

    final txId = transactionId.value.isNotEmpty
        ? transactionId.value
        : lastTransaction.value!.id;

    for (int attempt = 0; attempt < maxAttempts; attempt++) {
      try {
        final result = await _repository.getTransactionStatus(
          transactionId: txId,
        );

        final transaction = result.fold(
          (failure) => null,
          (tx) => tx,
        );

        if (transaction != null) {
          lastTransaction.value = transaction;

          if (transaction.status == TransactionStatus.completed ||
              transaction.status == TransactionStatus.failed) {
            return transaction;
          }
        }
      } catch (e) {
        // Continue polling on error
      }

      if (attempt < maxAttempts - 1) {
        await Future.delayed(interval);
      }
    }

    // Return last known state after max attempts
    return lastTransaction.value;
  }

  void clearError() {
    errorMessage.value = '';
  }

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
      await Future.delayed(const Duration(milliseconds: 500));
      recipients.value = [];
    } catch (e) {
      errorMessage.value = 'Failed to load recipients';
    } finally {
      isLoadingRecipients.value = false;
    }
  }

  // Repeat transaction functionality
  void repeatTransaction(CurrencyTransaction transaction, TextEditingController amountController) {
    final fromCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.fromCurrency,
    );
    final toCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.toCurrency,
    );

    if (fromCurr != null && toCurr != null) {
      setFromCurrency(fromCurr);
      setToCurrency(toCurr);

      setAmount(transaction.fromAmount);
      amountController.text = transaction.fromAmount.toStringAsFixed(2);

      final recipient = recipients.firstWhereOrNull(
        (r) => r.name == transaction.recipientName,
      );
      if (recipient != null) {
        setSelectedRecipient(recipient);
      }

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
    final fromCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.fromCurrency,
    );
    final toCurr = CurrencyData.allCurrencies.firstWhereOrNull(
      (c) => c.code == transaction.toCurrency,
    );

    if (fromCurr != null && toCurr != null) {
      setFromCurrency(fromCurr);
      setToCurrency(toCurr);
      setAmount(transaction.fromAmount);

      final recipient = recipients.firstWhereOrNull(
        (r) => r.name == transaction.recipientName,
      );
      if (recipient != null) {
        setSelectedRecipient(recipient);
      }

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
      if (!await fc.FlutterContacts.requestPermission()) {
        errorMessage.value = 'Contact permission denied';
        isLoadingContacts.value = false;
        return;
      }

      final contacts = await fc.FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );

      deviceContacts.value = contacts
          .map((contact) => DeviceContact.fromFlutterContact(contact))
          .where((contact) => contact.email != null || contact.phoneNumber != null)
          .toList();

      deviceContacts.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      errorMessage.value = 'Failed to load contacts: ${e.toString()}';
    } finally {
      isLoadingContacts.value = false;
    }
  }

  Recipient createRecipientFromContact(DeviceContact contact) {
    final now = DateTime.now();
    return Recipient(
      id: 'contact_${contact.id}',
      name: contact.name,
      email: contact.email ?? '',
      phone: contact.phoneNumber,
      accountNumber: '',
      bankName: '',
      countryCode: '',
      currency: toCurrency.value?.code ?? 'USD',
      createdAt: now,
      type: RecipientType.contact,
      avatarUrl: contact.photoUrl,
    );
  }

  void selectDeviceContact(DeviceContact contact) {
    final recipient = createRecipientFromContact(contact);
    selectedRecipient.value = recipient;
  }
}
