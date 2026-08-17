import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'add_recipient_sheet_widgets.dart';


class _AddRecipientSheetBodyState extends State<_AddRecipientSheetBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Bank tab state
  String? _selectedBankCode;
  String? _selectedBankName;
  final _bankAccountCtrl = TextEditingController();
  final _bankAmountCtrl = TextEditingController();
  String? _verifiedName;
  bool _verifying = false;

  // Tag/phone tab state
  final _tagCtrl = TextEditingController();
  final _tagAmountCtrl = TextEditingController();
  final _tagDisplayNameCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    serviceLocator<BankRepository>().warmUp('NG');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bankAccountCtrl.dispose();
    _bankAmountCtrl.dispose();
    _tagCtrl.dispose();
    _tagAmountCtrl.dispose();
    _tagDisplayNameCtrl.dispose();
    super.dispose();
  }

  String get _symbol => CurrencyUtils.getSymbol(widget.currency);

  void _showError(String message) {
    Get.snackbar('Error', message,
        backgroundColor: btRed,
        colorText: btTextPrimary,
        snackPosition: SnackPosition.TOP);
  }

  void _verifyBank() {
    if (_selectedBankCode == null) {
      _showError('Select a bank first.');
      return;
    }
    if (_bankAccountCtrl.text.length != 10) {
      _showError('Account number must be 10 digits.');
      return;
    }
    setState(() {
      _verifying = true;
      _verifiedName = null;
    });
    context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: _bankAccountCtrl.text,
          bankName: _selectedBankName ?? '',
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.92),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: btBorder,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 6.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text('Add recipient',
                        style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                          color: btBackground, shape: BoxShape.circle),
                      child: Icon(Icons.close,
                          color: btTextSecondary, size: 16.sp),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: btBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: TabBar(
                controller: _tabController,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: btBlue,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                indicatorPadding: EdgeInsets.all(3.w),
                labelColor: btTextPrimary,
                unselectedLabelColor: btTextSecondary,
                labelStyle: GoogleFonts.inter(
                    fontSize: 12.sp, fontWeight: FontWeight.w600),
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: 'Saved'),
                  Tab(text: 'Bank'),
                  Tab(text: 'Tag / Phone'),
                ],
              ),
            ),
            SizedBox(height: 8.h),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildSavedTab(),
                  _buildBankTab(),
                  _buildTagTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Saved beneficiaries tab =====

  Widget _buildSavedTab() {
    return BlocBuilder<RecipientCubit, RecipientState>(
      builder: (context, state) {
        if (state is RecipientLoading) {
          return const Center(
              child: LazerVaultLoader.small());
        }
        if (state is RecipientError) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Text(state.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      color: btTextSecondary, fontSize: 12.sp)),
            ),
          );
        }
        if (state is RecipientLoaded) {
          if (state.recipients.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Text(
                    'No saved beneficiaries yet. Add one via Bank or Tag, then save it after a successful transfer.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 12.sp)),
              ),
            );
          }
          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 16.h),
            itemCount: state.recipients.length,
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemBuilder: (ctx, i) {
              final r = state.recipients[i];
              return GestureDetector(
                onTap: () => _confirmSavedAmount(
                  beneficiaryName: r.name,
                  accountNumber: r.accountNumber,
                  bankCode: r.sortCode,
                  bankName: r.bankName,
                  recipientType:
                      r.type == 'internal' ? 'internal_lazervault' : 'external_bank',
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: btBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.w,
                        height: 36.w,
                        decoration: BoxDecoration(
                          color: btBlue.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            r.name.isNotEmpty
                                ? r.name[0].toUpperCase()
                                : '?',
                            style: GoogleFonts.inter(
                                color: btBlue,
                                fontWeight: FontWeight.w700,
                                fontSize: 14.sp),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.inter(
                                    color: btTextPrimary,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600)),
                            SizedBox(height: 2.h),
                            Text(
                                '${r.displayBankName} • ${r.accountNumber}',
                                style: GoogleFonts.inter(
                                    color: btTextSecondary,
                                    fontSize: 11.sp)),
                          ],
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded,
                          color: btTextSecondary, size: 18.sp),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Future<void> _confirmSavedAmount({
    required String beneficiaryName,
    required String accountNumber,
    required String bankCode,
    required String bankName,
    required String recipientType,
  }) async {
    final ctrl = TextEditingController();
    final amount = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        title: Text('Amount for $beneficiaryName',
            style: GoogleFonts.inter(color: btTextPrimary, fontSize: 15.sp)),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(color: btTextPrimary, fontSize: 17.sp),
          decoration: InputDecoration(
            prefixText: _symbol,
            prefixStyle: GoogleFonts.inter(color: btTextSecondary),
            hintText: '0.00',
            filled: true,
            fillColor: btBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide.none,
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text('Cancel',
                  style: GoogleFonts.inter(color: btTextSecondary))),
          TextButton(
            onPressed: () {
              final v = double.tryParse(ctrl.text);
              if (v == null || v <= 0) {
                _showError('Enter a positive amount.');
                return;
              }
              Navigator.of(ctx).pop(v);
            },
            child: Text('Add', style: GoogleFonts.inter(color: btBlue)),
          ),
        ],
      ),
    );
    if (amount == null || !mounted) return;
    final item = SavedBatchItemInputEntity(
      recipientType: recipientType,
      recipientUserId: '',
      bankCode: bankCode,
      accountNumber: accountNumber,
      beneficiaryName: beneficiaryName,
      amount: amount,
    );
    Navigator.of(context).pop(item);
  }

  // ===== Bank NUBAN tab =====

  Widget _buildBankTab() {
    final banks = serviceLocator<BankRepository>().cachedSync('NG');
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, state) {
        if (!mounted) return;
        if (state is AccountVerificationSuccess) {
          setState(() {
            _verifying = false;
            _verifiedName = state.accountName;
          });
        } else if (state is AccountVerificationFailure) {
          setState(() {
            _verifying = false;
            _verifiedName = null;
          });
          _showError(state.userMessage);
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bank',
                style: GoogleFonts.inter(
                    color: btTextSecondary, fontSize: 11.sp)),
            SizedBox(height: 6.h),
            GestureDetector(
              onTap: () => _pickBank(banks),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                decoration: BoxDecoration(
                  color: btBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          _selectedBankName ?? 'Select a bank',
                          style: GoogleFonts.inter(
                              color: _selectedBankName == null
                                  ? btTextTertiary
                                  : btTextPrimary,
                              fontSize: 14.sp)),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        color: btTextSecondary, size: 20.sp),
                  ],
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Text('Account number (10 digits)',
                style: GoogleFonts.inter(
                    color: btTextSecondary, fontSize: 11.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _bankAccountCtrl,
              keyboardType: TextInputType.number,
              style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: '0000000000',
                hintStyle: GoogleFonts.inter(color: btTextTertiary),
                filled: true,
                fillColor: btBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (v) {
                if (v.length == 10) {
                  _verifyBank();
                } else if (_verifiedName != null) {
                  setState(() => _verifiedName = null);
                }
              },
            ),
            if (_verifying) ...[
              SizedBox(height: 10.h),
              Row(
                children: [
                  LazerVaultLoader(size: 14),
                  SizedBox(width: 8.w),
                  Text('Verifying account...',
                      style: GoogleFonts.inter(
                          color: btTextSecondary, fontSize: 11.sp)),
                ],
              ),
            ],
            if (_verifiedName != null) ...[
              SizedBox(height: 10.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: btGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.verified_user_rounded,
                        color: btGreen, size: 16.sp),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(_verifiedName!,
                          style: GoogleFonts.inter(
                              color: btTextPrimary,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 14.h),
            Text('Amount',
                style: GoogleFonts.inter(
                    color: btTextSecondary, fontSize: 11.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _bankAmountCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
              decoration: InputDecoration(
                prefixText: _symbol,
                prefixStyle: GoogleFonts.inter(color: btTextSecondary),
                hintText: '0.00',
                hintStyle: GoogleFonts.inter(color: btTextTertiary),
                filled: true,
                fillColor: btBackground,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: () {
                  if (_verifiedName == null) {
                    _showError('Verify the account first.');
                    return;
                  }
                  final v = double.tryParse(_bankAmountCtrl.text);
                  if (v == null || v <= 0) {
                    _showError('Enter an amount.');
                    return;
                  }
                  Navigator.of(context).pop(
                    SavedBatchItemInputEntity(
                      recipientType: 'external_bank',
                      recipientUserId: '',
                      bankCode: _selectedBankCode ?? '',
                      accountNumber: _bankAccountCtrl.text,
                      beneficiaryName: _verifiedName!,
                      amount: v,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: btBlue,
                  foregroundColor: btTextPrimary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                ),
                child: Text('Add to batch',
                    style: GoogleFonts.inter(
                        fontSize: 14.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickBank(List<Map<String, String>> banks) async {
    final picked = await showModalBottomSheet<Map<String, String>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        final filtered = List<Map<String, String>>.from(banks);
        final searchCtrl = TextEditingController();
        return StatefulBuilder(builder: (ctx, setSheet) {
          return Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7),
            decoration: BoxDecoration(
              color: btCard,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: btBorder,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 8.h),
                  child: TextField(
                    controller: searchCtrl,
                    style: GoogleFonts.inter(
                        color: btTextPrimary, fontSize: 13.sp),
                    decoration: InputDecoration(
                      hintText: 'Search banks',
                      hintStyle: GoogleFonts.inter(color: btTextTertiary),
                      prefixIcon:
                          Icon(Icons.search, color: btTextSecondary),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (q) {
                      final lower = q.toLowerCase();
                      setSheet(() {
                        filtered
                          ..clear()
                          ..addAll(banks.where((b) =>
                              (b['name'] ?? '').toLowerCase().contains(lower)));
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => SizedBox(height: 4.h),
                    itemBuilder: (ctx, i) {
                      final b = filtered[i];
                      return ListTile(
                        title: Text(b['name'] ?? '',
                            style: GoogleFonts.inter(
                                color: btTextPrimary, fontSize: 13.sp)),
                        onTap: () => Navigator.of(ctx).pop(b),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedBankCode = picked['code'];
        _selectedBankName = picked['name'];
        _verifiedName = null;
      });
      if (_bankAccountCtrl.text.length == 10) _verifyBank();
    }
  }

  // ===== Tag / phone tab =====

  Widget _buildTagTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send to a Lazervault user by tag, phone, or email.',
              style: GoogleFonts.inter(
                  color: btTextSecondary, fontSize: 12.sp)),
          SizedBox(height: 14.h),
          TextField(
            controller: _tagCtrl,
            style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
            decoration: InputDecoration(
              labelText: 'Tag / phone / email',
              labelStyle: GoogleFonts.inter(color: btTextSecondary),
              hintText: '@username',
              hintStyle: GoogleFonts.inter(color: btTextTertiary),
              filled: true,
              fillColor: btBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(120)],
          ),
          SizedBox(height: 10.h),
          TextField(
            controller: _tagDisplayNameCtrl,
            style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
            decoration: InputDecoration(
              labelText: 'Display name (optional)',
              labelStyle: GoogleFonts.inter(color: btTextSecondary),
              filled: true,
              fillColor: btBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [LengthLimitingTextInputFormatter(120)],
          ),
          SizedBox(height: 14.h),
          TextField(
            controller: _tagAmountCtrl,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: GoogleFonts.inter(color: btTextSecondary),
              prefixText: _symbol,
              prefixStyle: GoogleFonts.inter(color: btTextSecondary),
              hintText: '0.00',
              hintStyle: GoogleFonts.inter(color: btTextTertiary),
              filled: true,
              fillColor: btBackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton(
              onPressed: () {
                final tag = _tagCtrl.text.trim();
                if (tag.isEmpty) {
                  _showError('Enter a tag, phone, or email.');
                  return;
                }
                final v = double.tryParse(_tagAmountCtrl.text);
                if (v == null || v <= 0) {
                  _showError('Enter an amount.');
                  return;
                }
                final displayName = _tagDisplayNameCtrl.text.trim().isEmpty
                    ? tag
                    : _tagDisplayNameCtrl.text.trim();
                Navigator.of(context).pop(
                  SavedBatchItemInputEntity(
                    recipientType: 'tagpay',
                    recipientUserId: '',
                    bankCode: '',
                    accountNumber: tag.startsWith('@') ? tag.substring(1) : tag,
                    beneficiaryName: displayName,
                    amount: v,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: btBlue,
                foregroundColor: btTextPrimary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r)),
              ),
              child: Text('Add to batch',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}
