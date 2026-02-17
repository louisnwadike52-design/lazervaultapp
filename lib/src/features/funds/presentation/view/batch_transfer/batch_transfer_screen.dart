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
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_state.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_form.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_theme.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';

class BatchTransferScreen extends StatefulWidget {
  const BatchTransferScreen({super.key});

  @override
  State<BatchTransferScreen> createState() => _BatchTransferScreenState();
}

class _BatchTransferScreenState extends State<BatchTransferScreen> {
  @override
  void initState() {
    super.initState();
    // Load recent batch transfer history
    context.read<BatchTransferCubit>().loadBatchTransferHistory(page: 1, pageSize: 5);

    // If coming from split bills, skip form and go directly to review
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final arguments = Get.arguments as Map<String, dynamic>?;
      if (arguments != null && arguments['split_type'] != null) {
        _navigateToReviewForSplitBill(arguments);
      }
    });
  }

  void _navigateToReviewForSplitBill(Map<String, dynamic> splitArgs) {
    final participants = splitArgs['participants'] as List<dynamic>? ?? [];
    final amounts = splitArgs['amounts'] as Map<String, int>? ?? {};
    final description = splitArgs['description'] as String? ?? 'Split Bill';
    final currency = splitArgs['currency'] as String? ?? 'NGN';
    final currencySymbol = splitArgs['currencySymbol'] as String? ?? '\u20a6';

    // Build BatchTransferRecipient list from split bill data
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildQuickInfoBar(),
                      BlocProvider(
                        create: (_) => serviceLocator<RecipientCubit>(),
                        child: BatchTransferForm(
                          preSelectedRecipients: arguments?['preSelectedRecipients'],
                          isRepeatTransaction: arguments?['isRepeatTransaction'] ?? false,
                          batchReference: arguments?['batchReference'],
                        ),
                      ),
                      _buildRecentHistory(),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                Get.offAllNamed(AppRoutes.home);
              }
            },
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: btCardElevated,
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batch Transfer',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Send to multiple recipients at once',
                  style: GoogleFonts.inter(
                    color: btTextSecondary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'transfers',
            iconColor: Colors.white,
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Batch Transfer',
            sourceContext: 'transfers',
          ),
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
              color: btBlue,
            ),
            Container(
              width: 1,
              height: 36.h,
              color: btBorder,
            ),
            _buildInfoItem(
              icon: Icons.bolt_outlined,
              label: 'Fee',
              value: 'Free',
              color: btGreen,
            ),
            Container(
              width: 1,
              height: 36.h,
              color: btBorder,
            ),
            _buildInfoItem(
              icon: Icons.schedule_outlined,
              label: 'Schedule',
              value: 'Yes',
              color: btOrange,
            ),
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
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.inter(
              color: btTextSecondary,
              fontSize: 11.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentHistory() {
    return BlocBuilder<BatchTransferCubit, BatchTransferState>(
      builder: (context, state) {
        if (state is BatchTransferHistoryLoaded && state.batches.isNotEmpty) {
          final recentBatches = state.batches.take(3).toList();
          return Padding(
            padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Transfers',
                      style: GoogleFonts.inter(
                        color: btTextPrimary,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await Get.toNamed(AppRoutes.batchTransferHistory);
                        if (mounted) {
                          context.read<BatchTransferCubit>().loadBatchTransferHistory(page: 1, pageSize: 5);
                        }
                      },
                      child: Text(
                        'View All',
                        style: GoogleFonts.inter(
                          color: btBlue,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                ...recentBatches.map((batch) => _buildRecentBatchTile(batch)),
              ],
            ),
          );
        }
        // Don't show anything if loading, error, or empty
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRecentBatchTile(BatchTransferHistoryEntity batch) {
    final statusColor = batchStatusColor(batch.status);
    final currencySymbol = CurrencyUtils.getSymbol(batch.currency);
    final dateStr = DateFormat('MMM dd, yyyy \u2022 HH:mm').format(batch.createdAt);

    return GestureDetector(
      onTap: () async {
        await Get.toNamed(AppRoutes.batchTransferDetail,
            arguments: {'batchId': batch.batchId});
        if (mounted) {
          context.read<BatchTransferCubit>().loadBatchTransferHistory(page: 1, pageSize: 5);
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
                  Text(
                    '$currencySymbol${batch.totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: btTextPrimary,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${batch.totalRecipients} recipient${batch.totalRecipients == 1 ? '' : 's'} \u2022 $dateStr',
                    style: GoogleFonts.inter(
                      color: btTextTertiary,
                      fontSize: 11.sp,
                    ),
                  ),
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
