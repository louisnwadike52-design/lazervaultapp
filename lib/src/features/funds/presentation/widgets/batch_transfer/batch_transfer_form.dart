import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/widgets/bank_picker_sheet.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
part 'batch_transfer_form_part1.dart';
part 'batch_transfer_form_part2.dart';


// --- Batch Transfer Form ---
class BatchTransferForm extends StatefulWidget {
  final List<dynamic>? preSelectedRecipients;
  final bool isRepeatTransaction;
  final String? batchReference;

  /// Short-flow mode. When true, tapping Proceed does NOT navigate to the
  /// Review screen — instead the built transferData map is handed to
  /// [onShortSubmit] so the host (the short compose screen) can run
  /// PIN → dispatch → receipt inline. Long flow (default) is unchanged.
  final bool shortFlow;
  final void Function(Map<String, dynamic> transferData)? onShortSubmit;

  /// Optional override for the proceed button label (short flow uses "Send").
  final String? proceedLabel;

  const BatchTransferForm({
    super.key,
    this.preSelectedRecipients,
    this.isRepeatTransaction = false,
    this.batchReference,
    this.shortFlow = false,
    this.onShortSubmit,
    this.proceedLabel,
  });

  @override
  State<BatchTransferForm> createState() => _BatchTransferFormState();
}

class _BatchTransferFormState extends State<BatchTransferForm> with TickerProviderStateMixin {
  static const int _maxRecipients = 20;
  final List<BatchRecipientItem> _selectedRecipients = [];
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _batchReferenceController = TextEditingController();
  final TextEditingController _bulkAmountController = TextEditingController();
  final TextEditingController _bulkReferenceController = TextEditingController();

  double _totalAmount = 0.0;
  final bool _isLoading = false;
  late String _currencySymbol;
  late String _currency;

  // Account selection
  int _selectedAccountIndex = 0;
  List<AccountSummaryEntity> _accounts = [];

  @override
  void initState() {
    super.initState();
    final accountManager = GetIt.I<AccountManager>();
    _currency = accountManager.activeAccountDetails?.currency ?? 'NGN';
    _currencySymbol = CurrencyUtils.getSymbol(_currency);
    _loadRecipients();
    _loadAccounts();

    if (widget.batchReference != null) {
      _batchReferenceController.text = widget.batchReference!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _populatePreSelectedRecipients();
    });
  }

  @override
  void dispose() {
    for (var recipient in _selectedRecipients) {
      recipient.dispose();
    }
    _categoryController.dispose();
    _batchReferenceController.dispose();
    _bulkAmountController.dispose();
    _bulkReferenceController.dispose();
    super.dispose();
  }

  void _loadRecipients() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final localeManager = serviceLocator<LocaleManager>();
      context.read<RecipientCubit>().getRecipients(
        accessToken: authState.profile.session.accessToken,
        countryCode: localeManager.currentCountry,
        currency: localeManager.currentCurrency,
      );
    }
  }

  void _loadAccounts() {
    try {
      final cubit = context.read<AccountCardsSummaryCubit>();
      final state = cubit.state;
      if (state is AccountCardsSummaryLoaded) {
        _accounts = state.accountSummaries;
        _selectDefaultAccount();
      } else if (state is AccountBalanceUpdated) {
        _accounts = state.accountSummaries;
        _selectDefaultAccount();
      } else {
        final authState = context.read<AuthenticationCubit>().state;
        if (authState is AuthenticationSuccess) {
          cubit.fetchAccountSummaries(
            userId: authState.profile.user.id,
            accessToken: authState.profile.session.accessToken,
          );
        }
      }
    } catch (_) {
      // AccountCardsSummaryCubit not available in this context
    }
  }

  void _selectDefaultAccount() {
    if (_accounts.isEmpty) return;
    // Lock the batch source to the account that's active on the dashboard
    // (e.g. when the user swiped into the Business wallet). Every other
    // account is rendered disabled. Fall back to the personal account with the
    // matching currency, then to the first account.
    final activeId = GetIt.I<AccountManager>().activeAccountId;
    var index = (activeId != null && activeId.isNotEmpty)
        ? _accounts.indexWhere((acc) => acc.id == activeId)
        : -1;
    if (index < 0) {
      index = _accounts.indexWhere(
        (acc) => acc.accountType.toLowerCase() == 'personal' &&
            acc.currency == _currency,
      );
    }
    setState(() {
      _selectedAccountIndex = index >= 0 ? index : 0;
      _updateCurrencyFromAccount();
    });
  }

  /// The active dashboard account the batch flow is locked to (null if none).
  String? get _lockedAccountId {
    final id = GetIt.I<AccountManager>().activeAccountId;
    return (id != null && id.isNotEmpty) ? id : null;
  }

  void _updateCurrencyFromAccount() {
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      final account = _accounts[_selectedAccountIndex];
      _currency = account.currency;
      _currencySymbol = CurrencyUtils.getSymbol(_currency);
    }
  }

  void _populatePreSelectedRecipients() {
    if (widget.preSelectedRecipients != null && widget.preSelectedRecipients!.isNotEmpty) {
      setState(() {
        _selectedRecipients.clear();

        for (var recipientData in widget.preSelectedRecipients!) {
          final recipient = RecipientModel(
            id: recipientData['id'] ?? '1',
            name: recipientData['name'] ?? 'Unknown',
            accountNumber: recipientData['accountNumber'] ?? '',
            bankName: recipientData['bankName'] ?? 'Bank',
            sortCode: recipientData['sortCode'] ?? '',
            isFavorite: recipientData['isFavorite'] ?? false,
            // A MISSING bank code means the bank was not captured — it is not
            // evidence of a LazerVault account. Defaulting to 'internal' here
            // routed ordinary external recipients as LazerVault transfers,
            // which the backend rejects outright with "recipient not found on
            // LazerVault". Absent positive proof, external is the safe read:
            // it is the branch that still resolves for a real bank account.
            // A MISSING bank code means the bank was not captured — it is not
            // evidence of a LazerVault account. Defaulting to 'internal' here
            // routed ordinary external recipients as LazerVault transfers,
            // which the backend rejects outright with "recipient not found on
            // LazerVault". Only a resolved LazerVault user id proves internal.
            type: (recipientData['type'] as String?) ??
                (((recipientData['internalUserId'] ?? '') as String).isNotEmpty
                    ? 'internal'
                    : 'external'),
          );

          // Carry the bank code/name through for external recipients, otherwise
          // destinationBankCode arrives empty at the backend and the external
          // payout silently fails (or mis-routes).
          final isExternal = recipient.type == 'external';
          final recipientItem = BatchRecipientItem(
            recipient: recipient,
            bankCode: isExternal ? recipient.sortCode : null,
            bankName: isExternal ? recipient.bankName : null,
            beneficiaryName: recipient.name,
            initialAmount: recipientData['amount']?.toString() ?? '',
            initialReference: recipientData['reference'] ?? '',
          );

          _selectedRecipients.add(recipientItem);
        }

        _calculateTotal();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.check_circle, color: btTextPrimary),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Loaded ${widget.preSelectedRecipients!.length} recipients from previous transaction',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              backgroundColor: btGreen,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  void _calculateTotal() {
    double total = 0.0;
    for (var recipient in _selectedRecipients) {
      total += recipient.amount;
    }
    setState(() {
      _totalAmount = total;
    });
  }

  void _showMultipleRecipientSelection() {
    if (_selectedRecipients.length >= _maxRecipients) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Maximum $_maxRecipients recipients reached',
            style: GoogleFonts.inter(fontWeight: FontWeight.w600),
          ),
          backgroundColor: btOrange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: MultiSelectRecipientBottomSheet(
          onRecipientsSelected: (recipients) {
            // Filter out duplicates by account number
            final existingAccountNumbers = _selectedRecipients
                .map((r) => r.recipient.accountNumber)
                .toSet();
            final newRecipients = recipients
                .where((r) => !existingAccountNumbers.contains(r.accountNumber))
                .toList();
            final duplicateCount = recipients.length - newRecipients.length;

            setState(() {
              for (var recipient in newRecipients) {
                final isExternal = recipient.type == 'external';
                _selectedRecipients.add(BatchRecipientItem(
                  recipient: recipient,
                  bankCode: isExternal ? recipient.sortCode : null,
                  bankName: isExternal ? recipient.bankName : null,
                  beneficiaryName: recipient.name,
                ));
              }
              _calculateTotal();
            });

            if (duplicateCount > 0) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '$duplicateCount duplicate recipient${duplicateCount == 1 ? '' : 's'} filtered out',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: btOrange,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              );
            }

            if (newRecipients.length > 1) {
              _showBulkAmountDialog(newRecipients.length);
            }
          },
          alreadySelectedIds: _selectedRecipients.map((r) => r.recipient.id).toList(),
        ),
      ),
    );
  }

  void _showBulkAmountDialog(int recipientCount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: btCardElevated,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          contentPadding: EdgeInsets.all(24.w),
          title: Column(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  color: btBlue.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(26.r),
                ),
                child: Icon(Icons.payments_outlined, color: btBlue, size: 26.sp),
              ),
              SizedBox(height: 12.h),
              Text(
                'Bulk Amount Setup',
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Apply same amount to $recipientCount recipients',
                style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 8.h),

              // Amount input
              TextField(
                controller: _bulkAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                onChanged: (value) => setDialogState(() {}),
                decoration: InputDecoration(
                  labelText: 'Amount per recipient',
                  labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                  hintText: '0.00',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary),
                  prefixText: '$_currencySymbol ',
                  prefixStyle: GoogleFonts.inter(
                    color: btGreen,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  filled: true,
                  fillColor: btBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: btBlue, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
              ),

              SizedBox(height: 12.h),

              // Reference input
              TextField(
                controller: _bulkReferenceController,
                style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
                decoration: InputDecoration(
                  labelText: 'Reference (Optional)',
                  labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                  hintText: 'e.g., Monthly allowance',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                  filled: true,
                  fillColor: btBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: btBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: btBlue, width: 1.5),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
              ),

              // Total preview
              if (_bulkAmountController.text.isNotEmpty &&
                  double.tryParse(_bulkAmountController.text) != null)
                Padding(
                  padding: EdgeInsets.only(top: 16.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: btGreen.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: btGreen.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Per recipient',
                              style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
                            ),
                            Text(
                              '$_currencySymbol${double.parse(_bulkAmountController.text).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Divider(color: btBorder, height: 1),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total ($recipientCount recipients)',
                              style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '$_currencySymbol${(double.parse(_bulkAmountController.text) * recipientCount).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: btGreen,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _bulkAmountController.clear();
                      _bulkReferenceController.clear();
                      Navigator.pop(dialogContext);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: btTextSecondary,
                      side: const BorderSide(color: btBorder),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Skip',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _bulkAmountController.text.isNotEmpty &&
                        double.tryParse(_bulkAmountController.text) != null &&
                        double.parse(_bulkAmountController.text) > 0
                      ? () {
                          final appliedAmount = double.parse(_bulkAmountController.text);
                          final appliedAmountText = '$_currencySymbol${appliedAmount.toStringAsFixed(2)}';

                          for (int i = 0; i < _selectedRecipients.length; i++) {
                            _selectedRecipients[i].amountController.text = _bulkAmountController.text;
                            if (_bulkReferenceController.text.isNotEmpty) {
                              _selectedRecipients[i].referenceController.text = _bulkReferenceController.text;
                            }
                          }

                          setState(() {
                            _calculateTotal();
                          });

                          _bulkAmountController.clear();
                          _bulkReferenceController.clear();
                          Navigator.pop(dialogContext);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Applied $appliedAmountText to all $recipientCount recipients',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: btGreen,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          );
                        }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _bulkAmountController.text.isNotEmpty &&
                          double.tryParse(_bulkAmountController.text) != null &&
                          double.parse(_bulkAmountController.text) > 0
                        ? btBlue
                        : btBorder,
                      foregroundColor: btTextPrimary,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text(
                      'Apply to All',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeRecipient(int index) {
    setState(() {
      _selectedRecipients[index].dispose();
      _selectedRecipients.removeAt(index);
      _calculateTotal();
    });
  }

  void _toggleRecipientExpansion(int index) {
    setState(() {
      _selectedRecipients[index].isExpanded = !_selectedRecipients[index].isExpanded;
    });
  }

  bool get _canProceed {
    return _selectedRecipients.isNotEmpty &&
        _selectedRecipients.every((r) => r.isValid && r.amount >= 1.0);
  }

  void _proceedToBatchTransfer() {
    if (!_canProceed) return;

    // Self-transfer check
    final accountManager = GetIt.I<AccountManager>();
    final myAccountNumber = accountManager.activeAccountDetails?.accountNumber ?? '';
    if (myAccountNumber.isNotEmpty) {
      final selfTransfers = _selectedRecipients
          .where((r) => r.recipient.accountNumber == myAccountNumber)
          .toList();
      if (selfTransfers.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Cannot transfer to your own account',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            backgroundColor: btRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
        return;
      }
    }

    // Balance check
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      final selectedAccount = _accounts[_selectedAccountIndex];
      if (_totalAmount > selectedAccount.availableBalance) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Insufficient balance. Available: $_currencySymbol${selectedAccount.availableBalance.toStringAsFixed(2)}',
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
            backgroundColor: btRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        );
        return;
      }
    }

    final recipients = _selectedRecipients.map((item) {
      final refText = item.referenceController.text.trim();
      final recipientName = item.beneficiaryName ?? item.recipient.name;
      final userNarration = refText.isNotEmpty
          ? refText.substring(0, min(200, refText.length))
          : null;
      // For external bank transfers, use CBN/NIBSS-compliant default narration
      final narration = userNarration
          ?? (item.isExternal
              ? 'Lazervault/$recipientName'
              : 'Transfer to $recipientName');
      return BatchTransferRecipient(
        toAccountNumber: item.recipient.accountNumber,
        amount: Int64((item.amount * 100).round()),
        description: narration,
        reference: userNarration,
        category: _categoryController.text.trim().isNotEmpty
            ? _categoryController.text.trim()
            : null,
        destinationBankCode: item.bankCode,
        beneficiaryName: recipientName,
        destinationBankName: item.bankName ?? (item.recipient.type == 'internal' ? 'LazerVault' : null),
      );
    }).toList();

    String fromAccountId;
    if (_accounts.isNotEmpty && _selectedAccountIndex < _accounts.length) {
      fromAccountId = _accounts[_selectedAccountIndex].id;
    } else {
      fromAccountId = accountManager.activeAccountDetails?.id ?? '0';
    }

    final arguments = <String, dynamic>{
      'recipients': recipients,
      'recipientItems': _selectedRecipients,
      'totalAmount': _totalAmount,
      'fromAccountId': fromAccountId,
      'category': _categoryController.text,
      'batchReference': _batchReferenceController.text,
      'currency': _currency,
      'currencySymbol': _currencySymbol,
      'selectedAccount': _accounts.isNotEmpty && _selectedAccountIndex < _accounts.length
          ? _accounts[_selectedAccountIndex]
          : null,
      'recipientNames': Map.fromEntries(
        _selectedRecipients.map((item) => MapEntry(item.recipient.accountNumber, item.recipient.name)),
      ),
    };

    // Short flow: hand the built payload to the host screen (compose → PIN →
    // receipt inline). Long flow: navigate to the dedicated Review screen.
    if (widget.shortFlow && widget.onShortSubmit != null) {
      widget.onShortSubmit!(arguments);
      return;
    }

    Get.toNamed(AppRoutes.batchTransferReview, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      listener: (context, state) {
        if (state is AccountCardsSummaryLoaded) {
          setState(() {
            _accounts = state.accountSummaries;
            _selectDefaultAccount();
          });
        } else if (state is AccountBalanceUpdated) {
          setState(() {
            _accounts = state.accountSummaries;
            if (_selectedAccountIndex >= _accounts.length) {
              _selectedAccountIndex = _accounts.isEmpty ? 0 : _accounts.length - 1;
              _updateCurrencyFromAccount();
            }
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),

            // Account selector section
            _buildSectionHeader('Transfer From', Icons.account_balance_wallet_outlined),
            SizedBox(height: 12.h),
            _buildAccountSelector(),

            SizedBox(height: 24.h),

            // Batch details section
            _buildSectionHeader('Batch Details', Icons.description_outlined),
            SizedBox(height: 12.h),
            _buildTextField(
              controller: _batchReferenceController,
              label: 'Batch Reference (Optional)',
              hint: 'e.g., Monthly Allowances',
            ),
            SizedBox(height: 10.h),
            _buildTextField(
              controller: _categoryController,
              label: 'Category (Optional)',
              hint: 'e.g., Salary, Commission',
            ),

            SizedBox(height: 28.h),

            // Recipients section header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSectionHeader(
                  'Recipients (${_selectedRecipients.length}/$_maxRecipients)',
                  Icons.people_outline,
                ),
                GestureDetector(
                  onTap: _showMultipleRecipientSelection,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: btBlue,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: btTextPrimary, size: 16.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Add',
                          style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Bulk amount button
            if (_selectedRecipients.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 12.h),
                child: GestureDetector(
                  onTap: () => _showBulkAmountDialog(_selectedRecipients.length),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: btBlue.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: btBlue.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: btBlue.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                          child: Icon(Icons.attach_money, color: btBlue, size: 18.sp),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Set Amount for All',
                                style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'Apply same amount to ${_selectedRecipients.length} recipients',
                                style: GoogleFonts.inter(
                                  color: btTextSecondary,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: btTextSecondary, size: 20.sp),
                      ],
                    ),
                  ),
                ),
              ),

            SizedBox(height: 16.h),

            // Recipients list or empty state
            if (_selectedRecipients.isEmpty)
              _buildEmptyState()
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _selectedRecipients.length,
                itemBuilder: (context, index) => _buildRecipientCard(index),
              ),

            SizedBox(height: _selectedRecipients.isNotEmpty ? 24.h : 16.h),

            // Total amount section
            if (_selectedRecipients.isNotEmpty) ...[
              _buildTotalSection(),
              SizedBox(height: 24.h),
            ],

            // Proceed button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _canProceed ? _proceedToBatchTransfer : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _canProceed ? btBlue : btBorder,
                  foregroundColor: btTextPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                child: _isLoading
                  ? LazerVaultLoader.small()
                  : Text(
                      _selectedRecipients.isEmpty
                        ? 'Add Recipients to Continue'
                        : (widget.proceedLabel ?? 'Continue to Review'),
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Account Selector ---
  Widget _buildAccountSelector() {
    if (_accounts.isEmpty) {
      return Container(
        height: 90.h,
        decoration: BoxDecoration(
          color: btCardElevated,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: btBorder),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LazerVaultLoader.tiny(),
              SizedBox(width: 12.w),
              Text(
                'Loading accounts...',
                style: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
              ),
            ],
          ),
        ),
      );
    }

    final safeIndex = _selectedAccountIndex.clamp(0, _accounts.length - 1);
    if (safeIndex != _selectedAccountIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) setState(() => _selectedAccountIndex = safeIndex);
      });
    }
    final account = _accounts[safeIndex];
    final typeColor = _getAccountTypeColor(account.accountType);

    return GestureDetector(
      onTap: _accounts.length > 1 ? _showAccountSelectionSheet : null,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: typeColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: typeColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getAccountTypeIcon(account.accountType),
                color: typeColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.displayName,
                    style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        '${CurrencyUtils.getSymbol(account.currency)}${account.availableBalance.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '\u2022\u2022\u2022\u2022 ${account.accountNumberLast4}',
                        style: GoogleFonts.inter(
                          color: btTextSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (_accounts.length > 1)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: typeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Change',
                  style: GoogleFonts.inter(
                    color: typeColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _getAccountTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'savings':
        return btGreen;
      case 'investment':
        return btOrange;
      case 'family':
      case 'family & friends':
        return btPurple;
      case 'business':
        return const Color(0xFF06B6D4);
      default:
        return btBlue;
    }
  }

  IconData _getAccountTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'savings':
        return Icons.savings_outlined;
      case 'investment':
        return Icons.trending_up;
      case 'family':
      case 'family & friends':
        return Icons.family_restroom;
      case 'business':
        return Icons.business;
      default:
        return Icons.account_balance_wallet_outlined;
    }
  }

  void _showAccountSelectionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            color: btCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: btBorderLight,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                child: Text(
                  'Select Account',
                  style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: _accounts.length,
                itemBuilder: (context, index) {
                  final account = _accounts[index];
                  final isSelected = index == _selectedAccountIndex;
                  final typeColor = _getAccountTypeColor(account.accountType);
                  // Lock the batch source to the active dashboard account; all
                  // other accounts are disabled (dimmed + tap shows a hint).
                  final lockedId = _lockedAccountId;
                  final isLocked = lockedId != null && account.id != lockedId;

                  return GestureDetector(
                    onTap: () {
                      if (isLocked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Locked to your current account',
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: btCardElevated,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        _selectedAccountIndex = index;
                        _updateCurrencyFromAccount();
                      });
                      Navigator.pop(ctx);
                    },
                    child: Opacity(
                      opacity: isLocked ? 0.4 : 1.0,
                      child: Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? typeColor.withValues(alpha: 0.1)
                            : btCardElevated,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: isSelected ? typeColor : btBorder,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color: typeColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              _getAccountTypeIcon(account.accountType),
                              color: typeColor,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  account.displayName,
                                  style: GoogleFonts.inter(
                                    color: btTextPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  '${CurrencyUtils.getSymbol(account.currency)}${account.availableBalance.toStringAsFixed(2)} \u2022 \u2022\u2022\u2022\u2022 ${account.accountNumberLast4}',
                                  style: GoogleFonts.inter(
                                    color: btTextSecondary,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(Icons.check_circle, color: typeColor, size: 22.sp),
                        ],
                      ),
                    ),
                    ),
                  );
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom + 12.h),
            ],
          ),
        );
      },
    );
  }

  // --- Total Section with balance warning ---
  Widget _buildTotalSection() {
    final hasInsufficientBalance = _accounts.isNotEmpty &&
        _selectedAccountIndex < _accounts.length &&
        _totalAmount > _accounts[_selectedAccountIndex].availableBalance;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: hasInsufficientBalance ? btRed.withValues(alpha: 0.5) : btBorder,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Amount',
                    style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${_selectedRecipients.length} recipient${_selectedRecipients.length == 1 ? '' : 's'} \u2022 Free',
                    style: GoogleFonts.inter(
                      color: btTextSecondary,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
              Text(
                '$_currencySymbol${_totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: hasInsufficientBalance ? btRed : (_totalAmount > 0 ? btGreen : btTextPrimary),
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (hasInsufficientBalance) ...[
            SizedBox(height: 12.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: btRed.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: btRed.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: btRed, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Insufficient balance. Available: $_currencySymbol${_accounts[_selectedAccountIndex].availableBalance.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        color: btRed,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: btTextSecondary, size: 18.sp),
        SizedBox(width: 8.w),
        Text(
          title,
          style: GoogleFonts.inter(
            color: btTextPrimary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return TextFormField(
      controller: controller,
      style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
        filled: true,
        fillColor: btCardElevated,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: btBlue, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btBorder),
      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Icon(Icons.group_add_outlined, color: btBlue, size: 32.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'No recipients added',
            style: GoogleFonts.inter(
              color: btTextPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Tap "Add" to select saved recipients\nor search for Lazervault users',
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 13.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientCard(int index) {
    final recipientItem = _selectedRecipients[index];
    final recipient = recipientItem.recipient;
    final isLazerTag = recipient.bankName == 'LazerVault';

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: recipientItem.isValid
            ? btGreen.withValues(alpha: 0.3)
            : recipientItem.amount == 0
              ? btBorder
              : btRed.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          // Main card content
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleRecipientExpansion(index),
              borderRadius: BorderRadius.circular(16.r),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: isLazerTag
                          ? btPurple.withValues(alpha: 0.15)
                          : btBlue.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(22.r),
                      ),
                      child: Center(
                        child: isLazerTag
                          ? Icon(Icons.alternate_email, color: btPurple, size: 20.sp)
                          : Text(
                              recipient.name.isNotEmpty
                                ? recipient.name.substring(0, 1).toUpperCase()
                                : '?',
                              style: GoogleFonts.inter(
                                color: btBlue,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                      ),
                    ),
                    SizedBox(width: 12.w),

                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  recipient.name,
                                  style: GoogleFonts.inter(
                                    color: btTextPrimary,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (isLazerTag) ...[
                                SizedBox(width: 6.w),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: btPurple.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    'LV',
                                    style: GoogleFonts.inter(
                                      color: btPurple,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${recipient.displayBankName} \u2022 ${isLazerTag ? recipient.accountNumber : (recipient.accountNumber.length > 4 ? '\u2022\u2022\u2022 ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}' : recipient.accountNumber)}',
                            style: GoogleFonts.inter(
                              color: btTextSecondary,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Actions
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleRecipientExpansion(index),
                          child: Icon(
                            recipientItem.isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: btTextSecondary,
                            size: 22.sp,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap: () => _removeRecipient(index),
                          child: Icon(
                            Icons.close,
                            color: btRed.withValues(alpha: 0.7),
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Always-visible inline amount input
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.w),
            child: TextFormField(
              controller: recipientItem.amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              style: GoogleFonts.inter(
                color: btTextPrimary,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
              onChanged: (value) => _calculateTotal(),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: GoogleFonts.inter(color: btTextTertiary),
                prefixText: '$_currencySymbol ',
                prefixStyle: GoogleFonts.inter(
                  color: btGreen,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                ),
                isDense: true,
                filled: true,
                fillColor: btBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: btBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: recipientItem.isValid ? btGreen.withValues(alpha: 0.3) : btBorder,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: btBlue, width: 1.5),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: btRed),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: const BorderSide(color: btRed, width: 1.5),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                errorText: recipientItem.amount > 0 && recipientItem.amount < 1.0
                    ? 'Minimum amount is ${_currencySymbol}1.00'
                    : null,
                errorStyle: GoogleFonts.inter(color: btRed, fontSize: 11.sp),
              ),
            ),
          ),

          // Expanded content - Reference
          if (recipientItem.isExpanded)
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: btBorder)),
              ),
              child: Column(
                children: [
                  SizedBox(height: 14.h),

                  // Reference input
                  TextFormField(
                    controller: recipientItem.referenceController,
                    style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
                    decoration: InputDecoration(
                      labelText: 'Narration (Optional)',
                      labelStyle: GoogleFonts.inter(color: btTextSecondary, fontSize: 14.sp),
                      hintText: 'e.g., Salary payment',
                      hintStyle: GoogleFonts.inter(color: btTextTertiary, fontSize: 14.sp),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBorder),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: btBlue, width: 1.5),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
