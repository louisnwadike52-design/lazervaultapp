import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batches_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/saved_batches_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/domain/entities/saved_batch_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_form.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

/// Landing screen for the Batch Transfer surface. Switches the previous
/// nested `Column → Expanded(SingleChildScrollView(Column))` layout —
/// where Recent History sat below the fold and could not be reached
/// without scrolling past the entire form — to a sectioned, bounded
/// layout that mirrors the electricity-bill home pattern: each section
/// is a card with deterministic height, sitting inside one outer scroll
/// view so saved batches + recent history are visible without scrolling.
class BatchTransferScreen extends StatefulWidget {
  const BatchTransferScreen({super.key});

  @override
  State<BatchTransferScreen> createState() => _BatchTransferScreenState();
}

class _BatchTransferScreenState extends State<BatchTransferScreen> {
  final SavedBatchesCubit _savedBatchesCubit =
      serviceLocator<SavedBatchesCubit>();
  // Shared across the Beneficiaries section + the in-page form so saving a
  // recipient in the form refreshes the beneficiaries list automatically.
  final RecipientCubit _recipientCubit = serviceLocator<RecipientCubit>();

  @override
  void initState() {
    super.initState();
    // Recent batch history.
    context.read<BatchTransferCubit>().loadBatchTransferHistory(
        page: 1, pageSize: 5);
    // Saved batch drafts (kept on a separate cubit so the in-page form's
    // state machine is untouched).
    _savedBatchesCubit.load();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _loadBeneficiaries();
      final arguments = Get.arguments as Map<String, dynamic>?;
      if (arguments != null && arguments['split_type'] != null) {
        _navigateToReviewForSplitBill(arguments);
      }
    });
  }

  void _loadBeneficiaries({bool forceRefresh = false}) {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      _recipientCubit.getRecipients(
        accessToken: authState.profile.session.accessToken,
        forceRefresh: forceRefresh,
      );
    }
  }

  @override
  void dispose() {
    _savedBatchesCubit.close();
    _recipientCubit.close();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<BatchTransferCubit>().loadBatchTransferHistory(
        page: 1, pageSize: 5);
    _loadBeneficiaries(forceRefresh: true);
    await _savedBatchesCubit.refresh();
  }

  void _navigateToReviewForSplitBill(Map<String, dynamic> splitArgs) {
    final participants = splitArgs['participants'] as List<dynamic>? ?? [];
    final amounts = splitArgs['amounts'] as Map<String, int>? ?? {};
    final description = splitArgs['description'] as String? ?? 'Split Bill';
    final currency = splitArgs['currency'] as String? ?? 'NGN';
    final currencySymbol = splitArgs['currencySymbol'] as String? ?? '₦';

    final recipients = <BatchTransferRecipient>[];
    final recipientNames = <String, String>{};

    for (final participant in participants) {
      final recipientModel = participant as RecipientModel;
      final amountMinorUnits = amounts[recipientModel.id] ?? 0;
      recipients.add(BatchTransferRecipient(
        toAccountNumber: recipientModel.accountNumber,
        amount: Int64(amountMinorUnits),
        reference: description,
      ));
      recipientNames[recipientModel.accountNumber] = recipientModel.name;
    }

    final accountManager = GetIt.I<AccountManager>();
    final fromAccountId = accountManager.activeAccountDetails?.id ?? '0';

    Get.offNamed(
      AppRoutes.batchTransferReview,
      arguments: {
        'recipients': recipients,
        'recipientNames': recipientNames,
        'fromAccountId': fromAccountId,
        'totalAmount': splitArgs['totalAmount'],
        'totalAmountMinorUnits': splitArgs['totalAmountMinorUnits'],
        'description': description,
        'split_type': splitArgs['split_type'],
        'currency': currency,
        'currencySymbol': currencySymbol,
        'myShare': splitArgs['myShare'],
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    return BlocProvider<SavedBatchesCubit>.value(
      value: _savedBatchesCubit,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: btBackground,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        child: Scaffold(
          backgroundColor: btBackground,
          body: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _onRefresh,
                    color: btBlue,
                    backgroundColor: btCard,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 6.h),
                          _buildQuickInfoBar(),
                          SizedBox(height: 14.h),
                          _buildSavedBatchesSection(),
                          SizedBox(height: 14.h),
                          BlocProvider<RecipientCubit>.value(
                            value: _recipientCubit,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildBeneficiariesSection(),
                                SizedBox(height: 14.h),
                                BatchTransferForm(
                                  preSelectedRecipients:
                                      arguments?['preSelectedRecipients'],
                                  isRepeatTransaction:
                                      arguments?['isRepeatTransaction'] ?? false,
                                  batchReference: arguments?['batchReference'],
                                ),
                              ],
                            ),
                          ),
                          _buildRecentHistory(),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Beneficiaries section ────────────────────────────────────────────────
  String? get _accessToken {
    final s = context.read<AuthenticationCubit>().state;
    return s is AuthenticationSuccess ? s.profile.session.accessToken : null;
  }

  Widget _buildBeneficiariesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: btBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.people_alt_outlined, color: btBlue, size: 18.sp),
                SizedBox(width: 8.w),
                Text('Beneficiaries',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                  onTap: _openAddBeneficiarySheet,
                  child: Row(
                    children: [
                      Icon(Icons.add_circle_outline,
                          color: btBlue, size: 16.sp),
                      SizedBox(width: 4.w),
                      Text('Add',
                          style: GoogleFonts.inter(
                              color: btBlue,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            BlocBuilder<RecipientCubit, RecipientState>(
              builder: (context, state) {
                if (state is RecipientLoading) {
                  return SizedBox(
                    height: 92.h,
                    child: Center(
                      child: SizedBox(
                        width: 22.w,
                        height: 22.w,
                        child: const CircularProgressIndicator(
                            strokeWidth: 2, color: btBlue),
                      ),
                    ),
                  );
                }
                final recipients = state is RecipientLoaded
                    ? state.recipients
                    : const <RecipientModel>[];
                if (recipients.isEmpty) {
                  return _buildBeneficiariesEmpty();
                }
                return SizedBox(
                  height: 96.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: recipients.length,
                    separatorBuilder: (_, __) => SizedBox(width: 12.w),
                    itemBuilder: (context, i) =>
                        _buildBeneficiaryChip(recipients[i]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiariesEmpty() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
      decoration: BoxDecoration(
        color: btCardElevated,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(Icons.bookmark_border_rounded, color: btTextTertiary, size: 26.sp),
          SizedBox(height: 8.h),
          Text('No beneficiaries yet',
              style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(
            'Save recipients to reuse them. Toggle "Save to beneficiaries" when adding, or tap Add.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(color: btTextTertiary, fontSize: 11.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaryChip(RecipientModel r) {
    final isInternal = r.type == 'internal' ||
        r.bankName.toLowerCase() == 'lazervault';
    final label = (r.alias != null && r.alias!.isNotEmpty) ? r.alias! : r.name;
    final initial = label.isNotEmpty ? label[0].toUpperCase() : '?';
    return GestureDetector(
      onTap: () => _showBeneficiaryOptions(r),
      child: SizedBox(
        width: 72.w,
        child: Column(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: (isInternal ? btBlue : btOrange).withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                    color: (isInternal ? btBlue : btOrange)
                        .withValues(alpha: 0.4)),
              ),
              alignment: Alignment.center,
              child: Text(initial,
                  style: GoogleFonts.inter(
                      color: isInternal ? btBlueLight : btOrange,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 6.h),
            Text(label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: btTextPrimary,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  void _showBeneficiaryOptions(RecipientModel r) {
    final isInternal = r.type == 'internal' ||
        r.bankName.toLowerCase() == 'lazervault';
    final subtitle = isInternal
        ? 'LazerVault • ${r.name}'
        : '${r.displayBankName} •••• ${r.accountNumber.length >= 4 ? r.accountNumber.substring(r.accountNumber.length - 4) : r.accountNumber}';
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: SafeArea(
          top: false,
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
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor:
                          (isInternal ? btBlue : btOrange).withValues(alpha: 0.15),
                      child: Text(
                        (r.alias?.isNotEmpty == true ? r.alias! : r.name)
                            .substring(0, 1)
                            .toUpperCase(),
                        style: GoogleFonts.inter(
                            color: isInternal ? btBlueLight : btOrange,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              r.alias?.isNotEmpty == true ? r.alias! : r.name,
                              style: GoogleFonts.inter(
                                  color: btTextPrimary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700)),
                          Text(subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.inter(
                                  color: btTextSecondary, fontSize: 12.sp)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              _optionTile(Icons.send_rounded, 'Send money', btBlue, () {
                Get.back();
                _repeatToSendFunds(r);
              }),
              _optionTile(Icons.drive_file_rename_outline, 'Rename', btTextPrimary,
                  () {
                Get.back();
                _renameBeneficiary(r);
              }),
              _optionTile(Icons.delete_outline_rounded, 'Delete', btRed, () {
                Get.back();
                _deleteBeneficiary(r);
              }),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _optionTile(IconData icon, String label, Color color, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 22.sp),
      title: Text(label,
          style: GoogleFonts.inter(
              color: color == btRed ? btRed : btTextPrimary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600)),
    );
  }

  void _repeatToSendFunds(RecipientModel r) {
    // Pre-load this beneficiary into the single send-funds flow.
    Get.toNamed(AppRoutes.initiateSendFunds, arguments: r);
  }

  void _renameBeneficiary(RecipientModel r) {
    final controller = TextEditingController(text: r.alias ?? '');
    Get.bottomSheet(
      Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(Get.context!).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: btCard,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Rename beneficiary',
                  style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 6.h),
              Text('Give ${r.name} a nickname',
                  style: GoogleFonts.inter(
                      color: btTextSecondary, fontSize: 12.sp)),
              SizedBox(height: 14.h),
              TextField(
                controller: controller,
                autofocus: true,
                style: GoogleFonts.inter(color: btTextPrimary, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'e.g. Mum, Supplier A',
                  hintStyle: GoogleFonts.inter(color: btTextTertiary),
                  filled: true,
                  fillColor: btCardElevated,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final token = _accessToken;
                    if (token != null) {
                      _recipientCubit.updateAlias(
                        recipientId: r.id,
                        alias: controller.text.trim(),
                        accessToken: token,
                      );
                    }
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btBlue,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: Text('Save',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _deleteBeneficiary(RecipientModel r) {
    Get.dialog(
      AlertDialog(
        backgroundColor: btCard,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r)),
        title: Text('Delete beneficiary?',
            style: GoogleFonts.inter(
                color: btTextPrimary, fontWeight: FontWeight.w700)),
        content: Text(
            'Remove ${r.alias?.isNotEmpty == true ? r.alias! : r.name} from your saved beneficiaries? This cannot be undone.',
            style: GoogleFonts.inter(color: btTextSecondary, fontSize: 13.sp)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: btTextSecondary)),
          ),
          TextButton(
            onPressed: () {
              final token = _accessToken;
              if (token != null) {
                _recipientCubit.deleteRecipient(
                    recipientId: r.id, accessToken: token);
              }
              Get.back();
            },
            child: Text('Delete',
                style: GoogleFonts.inter(
                    color: btRed, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  void _openAddBeneficiarySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => BlocProvider<RecipientCubit>.value(
        value: _recipientCubit,
        child: MultiSelectRecipientBottomSheet(
          alreadySelectedIds: const [],
          // Sheet persists the new recipient(s) via its own save toggle; we
          // just refresh the list so they appear immediately.
          onRecipientsSelected: (_) => _loadBeneficiaries(forceRefresh: true),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Get.back();
              } else {
                Get.offAllNamed(AppRoutes.dashboard);
              }
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Batch Transfer',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 2.h),
                Text('Send to multiple recipients at once',
                    style: GoogleFonts.inter(
                        color: btTextSecondary,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          ServiceVoiceButton(serviceName: 'transfers', iconColor: Colors.white),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
              serviceName: 'Batch Transfer', sourceContext: 'transfers'),
        ],
      ),
    );
  }

  Widget _buildQuickInfoBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            _buildInfoItem(
                icon: Icons.people_outline,
                label: 'Max Recipients',
                value: '20',
                color: btBlue),
            Container(width: 1, height: 36.h, color: btBorder),
            _buildInfoItem(
                icon: Icons.bolt_outlined,
                label: 'Fee',
                value: 'Free',
                color: btGreen),
            Container(width: 1, height: 36.h, color: btBorder),
            _buildInfoItem(
                icon: Icons.schedule_outlined,
                label: 'Schedule',
                value: 'Yes',
                color: btOrange),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 6.h),
          Text(value,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 2.h),
          Text(label,
              style: GoogleFonts.inter(
                  color: btTextSecondary,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }

  /// Saved batches strip — fixed-height horizontal scroller with a
  /// "View all" link. Always visible (header + CTA) even when empty so
  /// users discover the feature; replaced by an inline empty hint when
  /// there are no drafts.
  Widget _buildSavedBatchesSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bookmark_rounded, color: btBlue, size: 18.sp),
                SizedBox(width: 6.w),
                Text('Saved Batches',
                    style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    await Get.toNamed(AppRoutes.savedBatches);
                    if (mounted) _savedBatchesCubit.refresh();
                  },
                  child: Text('View all',
                      style: GoogleFonts.inter(
                          color: btBlue,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            BlocBuilder<SavedBatchesCubit, SavedBatchesState>(
              builder: (context, state) {
                if (state is SavedBatchesLoading ||
                    state is SavedBatchesInitial) {
                  return SizedBox(
                    height: 72.h,
                    child: const Center(
                        child: CircularProgressIndicator(color: btBlue)),
                  );
                }
                if (state is SavedBatchesError) {
                  return _emptySavedBatches(
                      'Could not load saved batches. Pull to refresh.');
                }
                final batches = state is SavedBatchesLoaded
                    ? state.batches
                    : const <SavedBatchEntity>[];
                if (batches.isEmpty) {
                  return _emptySavedBatches(
                      'Save a batch on the review screen so you can re-send to the same recipients with one tap.');
                }
                final compact = batches.take(8).toList();
                return SizedBox(
                  height: 96.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: compact.length,
                    separatorBuilder: (_, __) => SizedBox(width: 10.w),
                    itemBuilder: (ctx, i) => _buildSavedBatchChip(compact[i]),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptySavedBatches(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14.h),
      child: Text(message,
          style: GoogleFonts.inter(color: btTextSecondary, fontSize: 11.sp)),
    );
  }

  Widget _buildSavedBatchChip(SavedBatchEntity batch) {
    final symbol = CurrencyUtils.getSymbol(batch.currency);
    return GestureDetector(
      onTap: () async {
        await Get.toNamed(AppRoutes.savedBatchDetail,
            arguments: {'savedBatchId': batch.id});
        if (mounted) _savedBatchesCubit.refresh();
      },
      child: Container(
        width: 180.w,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: btBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: btBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              batch.name.isEmpty ? 'Untitled batch' : batch.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  color: btTextPrimary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.h),
            Text('$symbol${batch.totalAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                    color: btBlue,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 4.h),
            Text(
                '${batch.itemCount} recipient${batch.itemCount == 1 ? '' : 's'}',
                style:
                    GoogleFonts.inter(color: btTextSecondary, fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentHistory() {
    return BlocBuilder<BatchTransferCubit, BatchTransferState>(
      builder: (context, state) {
        if (state is BatchTransferHistoryLoaded && state.batches.isNotEmpty) {
          final activeCurrency =
              GetIt.I<LocaleManager>().currentCurrency;
          final filtered = state.batches
              .where((b) =>
                  b.currency.toUpperCase() == activeCurrency.toUpperCase())
              .toList();
          if (filtered.isEmpty) return const SizedBox.shrink();
          final recentBatches = filtered.take(3).toList();
          return Padding(
            padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recent Transfers',
                        style: GoogleFonts.inter(
                            color: btTextPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600)),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(AppRoutes.batchTransferHistory);
                        if (mounted) {
                          context
                              .read<BatchTransferCubit>()
                              .loadBatchTransferHistory(
                                  page: 1, pageSize: 5);
                        }
                      },
                      child: Text('View All',
                          style: GoogleFonts.inter(
                              color: btBlue,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500)),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ...recentBatches.map((batch) => _buildRecentBatchTile(batch)),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRecentBatchTile(BatchTransferHistoryEntity batch) {
    final statusColor = batchStatusColor(batch.status);
    final currencySymbol = CurrencyUtils.getSymbol(batch.currency);
    final dateStr = DateFormat('MMM dd, yyyy • HH:mm').format(batch.createdAt);

    return GestureDetector(
      onTap: () async {
        await Get.toNamed(AppRoutes.batchTransferDetail,
            arguments: {'batchId': batch.batchId});
        if (mounted) {
          context.read<BatchTransferCubit>().loadBatchTransferHistory(
              page: 1, pageSize: 5);
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: btCard,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.send_rounded, color: statusColor, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('$currencySymbol${batch.totalAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                          color: btTextPrimary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700)),
                  SizedBox(height: 2.h),
                  Text(
                      '${batch.totalRecipients} recipient${batch.totalRecipients == 1 ? '' : 's'} • $dateStr',
                      style: GoogleFonts.inter(
                          color: btTextTertiary, fontSize: 11.sp)),
                ],
              ),
            ),
            buildBatchStatusBadge(batch.status),
          ],
        ),
      ),
    );
  }
}
