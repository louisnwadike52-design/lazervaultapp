import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batch_detail_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batch_detail_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/saved_batch/add_recipient_sheet.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';

/// Detail / edit screen for a single saved batch. Lets the user rename
/// the batch, add or remove recipients, edit per-item amounts, apply a
/// collective multiplier or absolute amount, and (finally) execute the
/// batch into a real transfer. Execution delegates to the existing
/// CAS-hardened money path — the draft itself is preserved.
class SavedBatchDetailScreen extends StatefulWidget {
  const SavedBatchDetailScreen({super.key});

  @override
  State<SavedBatchDetailScreen> createState() => _SavedBatchDetailScreenState();
}

class _SavedBatchDetailScreenState extends State<SavedBatchDetailScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  String? _savedBatchId;
  bool _executing = false;
  final Map<String, double> _perItemOverrides = {};

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    _savedBatchId = args?['savedBatchId'] as String?;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (_savedBatchId == null) {
        Get.back();
        return;
      }
      context.read<SavedBatchDetailCubit>().load(_savedBatchId!);
    });
  }

  Future<bool> _confirmIfMutating() async {
    final state = context.read<SavedBatchDetailCubit>().state;
    if (state is! SavedBatchDetailLoaded) return true;
    if (!state.mutating) return true;
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        title: Text('Discard pending change?',
            style: GoogleFonts.inter(color: btTextPrimary)),
        content: Text(
          'A change is still being saved. Leaving now may revert your last edit. Continue?',
          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('Stay', style: GoogleFonts.inter(color: btTextSecondary))),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text('Leave', style: GoogleFonts.inter(color: btRed))),
        ],
      ),
    );
    return ok ?? false;
  }

  void _showError(String message) {
    if (!mounted) return;
    Get.snackbar(
      'Error',
      message,
      backgroundColor: btRed,
      colorText: btTextPrimary,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 4),
    );
  }

  Future<void> _openRenameSheet(SavedBatchEntity batch) async {
    final controller = TextEditingController(text: batch.name);
    final newName = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: btCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rename batch',
                  style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 12.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: GoogleFonts.inter(color: btTextPrimary, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Batch name',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary),
                  filled: true,
                  fillColor: btBackground,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(80)],
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                height: 48.h,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.of(ctx).pop(controller.text.trim()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btBlue,
                    foregroundColor: btTextPrimary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text('Save name',
                      style: GoogleFonts.inter(
                          fontSize: 15.sp, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (newName == null || newName.isEmpty || newName == batch.name) return;
    if (!mounted) return;
    await context.read<SavedBatchDetailCubit>().rename(newName);
  }

  Future<void> _openAddRecipientSheet(SavedBatchEntity batch) async {
    final added = await AddRecipientSheet.show(
      context: context,
      currency: batch.currency,
    );
    if (added == null || !mounted) return;
    await context.read<SavedBatchDetailCubit>().addItem(added);
  }

  Future<void> _editItemAmount(SavedBatchItemEntity item) async {
    final controller = TextEditingController(text: item.amount.toStringAsFixed(2));
    final symbol = CurrencyUtils.getSymbol(_currency);
    final newAmount = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        title: Text('Edit amount',
            style: GoogleFonts.inter(color: btTextPrimary)),
        content: TextField(
          controller: controller,
          autofocus: true,
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(color: btTextPrimary, fontSize: 18.sp),
          decoration: InputDecoration(
            prefixText: symbol,
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
              final v = double.tryParse(controller.text);
              if (v == null || v <= 0) {
                _showError('Enter a positive amount.');
                return;
              }
              Navigator.of(ctx).pop(v);
            },
            child: Text('Save', style: GoogleFonts.inter(color: btBlue)),
          ),
        ],
      ),
    );
    if (newAmount == null || !mounted) return;
    await context
        .read<SavedBatchDetailCubit>()
        .updateItemAmount(item.id, newAmount);
  }

  Future<void> _removeItem(SavedBatchItemEntity item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        title: Text('Remove recipient?',
            style: GoogleFonts.inter(color: btTextPrimary)),
        content: Text(
          'Remove ${item.beneficiaryName.isEmpty ? item.accountNumber : item.beneficiaryName} from this saved batch?',
          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('Cancel',
                  style: GoogleFonts.inter(color: btTextSecondary))),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text('Remove', style: GoogleFonts.inter(color: btRed))),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    await context.read<SavedBatchDetailCubit>().removeItem(item.id);
  }

  Future<void> _openCollectiveSheet(SavedBatchEntity batch) async {
    final symbol = CurrencyUtils.getSymbol(batch.currency);
    final multiplierCtrl = TextEditingController(text: '1.0');
    final absoluteCtrl = TextEditingController();
    var useMultiplier = true;
    final result = await showModalBottomSheet<Map<String, double>>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: StatefulBuilder(builder: (ctx, setSheet) {
          return Container(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 24.h),
            decoration: BoxDecoration(
              color: btCard,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Apply to every recipient',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6.h),
                Text(
                    'Choose a multiplier (e.g. 1.5 to scale everyone up 50 percent) or a fixed amount per recipient.',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 12.sp)),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    _modeChip(
                        label: 'Multiplier',
                        selected: useMultiplier,
                        onTap: () => setSheet(() => useMultiplier = true)),
                    SizedBox(width: 10.w),
                    _modeChip(
                        label: 'Fixed amount',
                        selected: !useMultiplier,
                        onTap: () => setSheet(() => useMultiplier = false)),
                  ],
                ),
                SizedBox(height: 16.h),
                if (useMultiplier)
                  TextField(
                    controller: multiplierCtrl,
                    autofocus: true,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.inter(
                        color: btTextPrimary, fontSize: 16.sp),
                    decoration: InputDecoration(
                      labelText: 'Multiplier',
                      labelStyle:
                          GoogleFonts.inter(color: btTextSecondary),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,4}')),
                    ],
                  )
                else
                  TextField(
                    controller: absoluteCtrl,
                    autofocus: true,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    style: GoogleFonts.inter(
                        color: btTextPrimary, fontSize: 16.sp),
                    decoration: InputDecoration(
                      labelText: 'Amount per recipient',
                      prefixText: symbol,
                      prefixStyle:
                          GoogleFonts.inter(color: btTextSecondary),
                      labelStyle:
                          GoogleFonts.inter(color: btTextSecondary),
                      filled: true,
                      fillColor: btBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                  ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      if (useMultiplier) {
                        final v = double.tryParse(multiplierCtrl.text);
                        if (v == null || v <= 0) {
                          _showError('Enter a multiplier greater than zero.');
                          return;
                        }
                        Navigator.of(ctx).pop({'multiplier': v});
                      } else {
                        final v = double.tryParse(absoluteCtrl.text);
                        if (v == null || v <= 0) {
                          _showError('Enter an amount greater than zero.');
                          return;
                        }
                        Navigator.of(ctx).pop({'amountPerItem': v});
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btBlue,
                      foregroundColor: btTextPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text('Apply to all',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
    if (result == null || !mounted) return;
    await context.read<SavedBatchDetailCubit>().applyCollective(
          multiplier: result['multiplier'],
          amountPerItem: result['amountPerItem'],
        );
  }

  Widget _modeChip(
      {required String label,
      required bool selected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected ? btBlue : btBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: selected ? btBlue : btBorder),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
              color: selected ? btTextPrimary : btTextSecondary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  String get _currency {
    final s = context.read<SavedBatchDetailCubit>().state;
    if (s is SavedBatchDetailLoaded) return s.batch.currency;
    return 'NGN';
  }

  Future<void> _confirmAndExecute(SavedBatchEntity batch) async {
    if (_executing) return;
    if (batch.items.isEmpty) {
      _showError('Add at least one recipient before sending.');
      return;
    }

    // Compute the effective totals incl. any per-item overrides the user
    // tweaked from the execute confirmation sheet.
    double totalAmount = 0.0;
    for (final item in batch.items) {
      final overridden = _perItemOverrides[item.id];
      totalAmount += overridden ?? item.amount;
    }

    if (totalAmount <= 0) {
      _showError('Total amount must be greater than zero.');
      return;
    }

    setState(() => _executing = true);

    final transactionId = 'saved_batch_${const Uuid().v4()}';
    String? verificationToken;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'batch_transfer',
      amount: totalAmount,
      currency: batch.currency,
      title: 'Confirm batch',
      message:
          'Send ${CurrencyUtils.getSymbol(batch.currency)}${totalAmount.toStringAsFixed(2)} to ${batch.items.length} recipient${batch.items.length == 1 ? '' : 's'}?',
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!ok || verificationToken == null) {
      if (mounted) setState(() => _executing = false);
      return;
    }
    if (!mounted) return;

    final cubit = context.read<SavedBatchDetailCubit>();
    final idempotencyKey = const Uuid().v4();
    final accountManager = GetIt.I<AccountManager>();
    final sourceAccountId = batch.sourceAccountId.isNotEmpty
        ? batch.sourceAccountId
        : (accountManager.activeAccountDetails?.id ?? '');

    await cubit.execute(
      idempotencyKey: idempotencyKey,
      transactionId: transactionId,
      verificationToken: verificationToken!,
      perItemOverrides: Map<String, double>.from(_perItemOverrides),
      sourceAccountId: sourceAccountId,
    );

    if (!mounted) return;
    setState(() => _executing = false);
  }

  Future<bool> _openExecuteConfirmSheet(SavedBatchEntity batch) async {
    final symbol = CurrencyUtils.getSymbol(batch.currency);
    final amounts = <String, TextEditingController>{};
    for (final item in batch.items) {
      final existing = _perItemOverrides[item.id] ?? item.amount;
      amounts[item.id] =
          TextEditingController(text: existing.toStringAsFixed(2));
    }
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.85),
          decoration: BoxDecoration(
            color: btCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Review and send',
                              style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w700)),
                          SizedBox(height: 2.h),
                          Text(
                              'Tweak amounts here without changing the saved batch.',
                              style: GoogleFonts.inter(
                                  color: btTextSecondary,
                                  fontSize: 12.sp)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(false),
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
              const Divider(color: btBorder, height: 1),
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(
                      horizontal: 16.w, vertical: 12.h),
                  itemCount: batch.items.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (ctx, i) {
                    final item = batch.items[i];
                    final ctrl = amounts[item.id]!;
                    return Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: btBackground,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    item.beneficiaryName.isEmpty
                                        ? item.accountNumber
                                        : item.beneficiaryName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                        color: btTextPrimary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600)),
                                SizedBox(height: 2.h),
                                Text(item.maskedAccount,
                                    style: GoogleFonts.inter(
                                        color: btTextSecondary,
                                        fontSize: 11.sp)),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          SizedBox(
                            width: 110.w,
                            child: TextField(
                              controller: ctrl,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textAlign: TextAlign.right,
                              style: GoogleFonts.inter(
                                  color: btTextPrimary, fontSize: 13.sp),
                              decoration: InputDecoration(
                                isDense: true,
                                prefixText: symbol,
                                prefixStyle: GoogleFonts.inter(
                                    color: btTextSecondary,
                                    fontSize: 11.sp),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 8.h),
                                filled: true,
                                fillColor: btCard,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(8.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d*\.?\d{0,2}')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: () {
                      _perItemOverrides.clear();
                      for (final item in batch.items) {
                        final raw = amounts[item.id]?.text ?? '';
                        final v = double.tryParse(raw);
                        if (v != null && v != item.amount && v > 0) {
                          _perItemOverrides[item.id] = v;
                        }
                      }
                      Navigator.of(ctx).pop(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btBlue,
                      foregroundColor: btTextPrimary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r)),
                    ),
                    child: Text('Continue to PIN',
                        style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return confirmed == true;
  }

  Future<void> _onSendPressed(SavedBatchEntity batch) async {
    if (batch.items.isEmpty) {
      _showError('Add at least one recipient before sending.');
      return;
    }
    final ok = await _openExecuteConfirmSheet(batch);
    if (!ok || !mounted) return;
    await _confirmAndExecute(batch);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final ok = await _confirmIfMutating();
        if (ok && mounted) {
          Get.back();
        }
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: btBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: BlocConsumer<SavedBatchDetailCubit, SavedBatchDetailState>(
          listener: (context, state) {
            if (state is SavedBatchDeletedFromDetail) {
              Get.back(result: {'deleted': true});
              Get.snackbar('Deleted', 'Saved batch removed.',
                  backgroundColor: btGreen,
                  colorText: btTextPrimary,
                  snackPosition: SnackPosition.TOP);
              return;
            }
            if (state is SavedBatchDetailError) {
              _showError(state.message);
              return;
            }
            if (state is SavedBatchDetailLoaded &&
                state.mutationError != null &&
                state.mutationError!.isNotEmpty) {
              _showError(state.mutationError!);
              context.read<SavedBatchDetailCubit>().clearMutationError();
              return;
            }
            if (state is SavedBatchDetailLoaded &&
                state.executedBatch != null) {
              final executed = state.executedBatch!;
              context.read<SavedBatchDetailCubit>().clearExecuted();
              // Route into the existing batch-transfer receipt screen.
              final batch = state.batch;
              final transfers = executed.results.map((r) {
                return {
                  'transferId': r.transferId,
                  'status': r.status,
                  'amount': r.amount.toDouble() / 100,
                  'fee': r.fee.toDouble() / 100,
                  'recipientName': r.recipientName,
                  'recipientAccount': r.recipientAccount,
                  'failureReason': r.failureReason,
                  'reference': r.reference,
                  'destinationBankCode': r.destinationBankCode,
                  'destinationBankName': r.destinationBankName,
                  'transferType': r.transferType,
                  'beneficiaryName': r.beneficiaryName,
                  'recipientUserId': r.recipientUserId,
                };
              }).toList();
              Get.offNamed(
                AppRoutes.transferProof,
                arguments: {
                  // Batch variant rendered by the shared send-funds receipt.
                  'isBatch': true,
                  'amount': executed.totalAmount.toDouble() / 100,
                  'fee': executed.totalFee.toDouble() / 100,
                  'reference': executed.batchId,
                  'batchId': executed.batchId,
                  'totalAmount': executed.totalAmount.toDouble() / 100,
                  'totalFee': executed.totalFee.toDouble() / 100,
                  'currency': batch.currency,
                  'currencySymbol':
                      CurrencyUtils.getSymbol(batch.currency),
                  'status': executed.status,
                  'recipientCount': executed.totalTransfers,
                  'successfulTransfers': executed.successfulTransfers,
                  'failedTransfers': executed.failedTransfers,
                  'timestamp': DateTime.now(),
                  'transfers': transfers,
                  'fromSavedBatch': true,
                  'savedBatchId': batch.id,
                },
              );
            }
          },
          builder: (context, state) {
            if (state is SavedBatchDetailLoading ||
                state is SavedBatchDetailInitial) {
              return const Scaffold(
                backgroundColor: btBackground,
                body: Center(child: CircularProgressIndicator(color: btBlue)),
              );
            }
            if (state is SavedBatchDetailError) {
              return _buildErrorScaffold(state.message);
            }
            if (state is! SavedBatchDetailLoaded) {
              return const Scaffold(
                backgroundColor: btBackground,
                body: SizedBox.shrink(),
              );
            }
            return _buildLoaded(state);
          },
        ),
      ),
    );
  }

  Widget _buildErrorScaffold(String message) {
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(name: 'Saved batch'),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.error_outline, color: btRed, size: 32.sp),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: 280.w,
                      child: Text(message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              color: btTextSecondary, fontSize: 13.sp)),
                    ),
                    SizedBox(height: 14.h),
                    GestureDetector(
                      onTap: () {
                        if (_savedBatchId != null) {
                          context
                              .read<SavedBatchDetailCubit>()
                              .load(_savedBatchId!);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 18.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: btBlue,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text('Retry',
                            style: GoogleFonts.inter(
                                color: btTextPrimary,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoaded(SavedBatchDetailLoaded state) {
    final batch = state.batch;
    final symbol = CurrencyUtils.getSymbol(batch.currency);
    final mutating = state.mutating;
    return Scaffold(
      backgroundColor: btBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(name: batch.name, mutating: mutating),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async =>
                    context.read<SavedBatchDetailCubit>().refresh(),
                color: btBlue,
                backgroundColor: btCard,
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 100.h),
                  children: [
                    _buildSummaryCard(batch, symbol),
                    SizedBox(height: 14.h),
                    _buildActionsRow(batch, mutating),
                    SizedBox(height: 18.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        children: [
                          Text('Recipients (${batch.items.length})',
                              style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                          const Spacer(),
                          if (batch.items.length > 1)
                            GestureDetector(
                              onTap: mutating
                                  ? null
                                  : () => _openCollectiveSheet(batch),
                              child: Text('Apply to all',
                                  style: GoogleFonts.inter(
                                      color: btBlue,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600)),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.h),
                    if (batch.items.isEmpty)
                      _buildEmptyItems()
                    else
                      ...batch.items
                          .map((it) => _buildItemTile(it, symbol, mutating)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(batch, mutating),
    );
  }

  Widget _buildHeader({required String name, bool mutating = false}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              final ok = await _confirmIfMutating();
              if (ok && mounted) Get.back();
            },
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Tooltip(
              message: name,
              child: Text(
                name.isEmpty ? 'Untitled batch' : name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          if (mutating)
            SizedBox(
              width: 18.w,
              height: 18.w,
              child: const CircularProgressIndicator(
                  strokeWidth: 2, color: btBlue),
            )
          else
            PopupMenuButton<String>(
              color: btCard,
              onSelected: (v) {
                final s = context.read<SavedBatchDetailCubit>().state;
                if (s is! SavedBatchDetailLoaded) return;
                if (v == 'rename') {
                  _openRenameSheet(s.batch);
                } else if (v == 'delete') {
                  _confirmDeleteDialog();
                }
              },
              icon: Icon(Icons.more_vert, color: btTextSecondary, size: 22.sp),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'rename',
                  child: Text('Rename',
                      style: GoogleFonts.inter(color: btTextPrimary)),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child:
                      Text('Delete', style: GoogleFonts.inter(color: btRed)),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Future<void> _confirmDeleteDialog() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: btCard,
        title: Text('Delete saved batch?',
            style: GoogleFonts.inter(color: btTextPrimary)),
        content: Text(
          'This removes the template only. No money has been moved.',
          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text('Cancel',
                  style: GoogleFonts.inter(color: btTextSecondary))),
          TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text('Delete', style: GoogleFonts.inter(color: btRed))),
        ],
      ),
    );
    if (ok == true && mounted) {
      await context.read<SavedBatchDetailCubit>().deleteBatch();
    }
  }

  Widget _buildSummaryCard(SavedBatchEntity batch, String symbol) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: btBorder),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 11.sp)),
                SizedBox(height: 4.h),
                Text('$symbol${batch.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(width: 1, height: 36.h, color: btBorder),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Recipients',
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 11.sp)),
                SizedBox(height: 4.h),
                Text('${batch.itemCount}',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsRow(SavedBatchEntity batch, bool mutating) {
    return Row(
      children: [
        Expanded(
          child: _quickAction(
            icon: Icons.add_rounded,
            label: 'Add recipient',
            color: btBlue,
            onTap: mutating ? null : () => _openAddRecipientSheet(batch),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _quickAction(
            icon: Icons.tune_rounded,
            label: 'Apply to all',
            color: btOrange,
            onTap: (mutating || batch.items.isEmpty)
                ? null
                : () => _openCollectiveSheet(batch),
          ),
        ),
      ],
    );
  }

  Widget _quickAction(
      {required IconData icon,
      required String label,
      required Color color,
      VoidCallback? onTap}) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: enabled ? 0.10 : 0.04),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: enabled ? color : btTextTertiary, size: 16.sp),
            SizedBox(width: 6.w),
            Text(label,
                style: GoogleFonts.inter(
                    color: enabled ? color : btTextTertiary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyItems() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: btBorder),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.people_outline_rounded,
                color: btTextTertiary, size: 26.sp),
            SizedBox(height: 8.h),
            Text('No recipients yet',
                style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 4.h),
            Text('Tap Add recipient to start building this batch.',
                style: GoogleFonts.inter(
                    color: btTextSecondary, fontSize: 12.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(
      SavedBatchItemEntity item, String symbol, bool mutating) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: btCard,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: btBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: btBlue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                item.beneficiaryName.isNotEmpty
                    ? item.beneficiaryName[0].toUpperCase()
                    : '?',
                style: GoogleFonts.inter(
                    color: btBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 16.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Tooltip(
                  message: item.beneficiaryName.isEmpty
                      ? item.accountNumber
                      : item.beneficiaryName,
                  child: Text(
                    item.beneficiaryName.isEmpty
                        ? item.accountNumber
                        : item.beneficiaryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                    item.recipientType == 'tagpay'
                        ? '@${item.accountNumber}'
                        : item.maskedAccount,
                    style: GoogleFonts.inter(
                        color: btTextSecondary, fontSize: 11.sp)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: mutating ? null : () => _editItemAmount(item),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: btBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text('$symbol${item.amount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp)),
                  SizedBox(width: 4.w),
                  Icon(Icons.edit_outlined,
                      color: btTextSecondary, size: 13.sp),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: mutating ? null : () => _removeItem(item),
            icon: Icon(Icons.close_rounded,
                color: btTextSecondary, size: 18.sp),
            tooltip: 'Remove',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(SavedBatchEntity batch, bool mutating) {
    final canSend = !mutating && !_executing && batch.items.isNotEmpty;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: btCard,
        border: Border(top: BorderSide(color: btBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 52.h,
          child: ElevatedButton(
            onPressed: canSend ? () => _onSendPressed(batch) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: canSend ? btBlue : btCardElevated,
              foregroundColor: btTextPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
            ),
            child: _executing
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: btTextPrimary),
                  )
                : Text(
                    batch.items.isEmpty
                        ? 'Add a recipient to send'
                        : 'Send batch',
                    style: GoogleFonts.inter(
                        fontSize: 15.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}
