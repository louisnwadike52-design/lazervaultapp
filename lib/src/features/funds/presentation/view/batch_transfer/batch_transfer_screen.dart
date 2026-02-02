import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fixnum/fixnum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_form.dart';
import 'package:lazervault/src/features/funds/presentation/widgets/batch_transfer/batch_transfer_history_widget.dart';
import 'package:lazervault/src/features/funds/cubit/batch_transfer_cubit.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class BatchTransferScreen extends StatefulWidget {
  const BatchTransferScreen({super.key});

  @override
  State<BatchTransferScreen> createState() => _BatchTransferScreenState();
}

class _BatchTransferScreenState extends State<BatchTransferScreen> {
  @override
  void initState() {
    super.initState();
    // If coming from split bills, skip form and go directly to review
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
        recipientId: Int64(int.tryParse(recipientModel.id) ?? 0),
        amount: Int64(amountMinorUnits),
        reference: description,
      ));
      recipientNames[recipientModel.id] = recipientModel.name;
    }

    final accountManager = GetIt.I<AccountManager>();
    final fromAccountId = Int64(int.tryParse(accountManager.activeAccountDetails?.id ?? '0') ?? 0);

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
        systemNavigationBarColor: Color(0xFF0F0F23),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      BlocProvider(
                        create: (_) => serviceLocator<RecipientCubit>(),
                        child: BatchTransferForm(
                          preSelectedRecipients: arguments?['preSelectedRecipients'],
                          isRepeatTransaction: arguments?['isRepeatTransaction'] ?? false,
                          batchReference: arguments?['batchReference'],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      BlocProvider(
                        create: (_) => serviceLocator<BatchTransferCubit>(),
                        child: BatchTransferHistoryWidget(),
                      ),
                    ],
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

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
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
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Send money to multiple recipients',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[600]!, Colors.blue[400]!],
              ),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.batch_prediction,
                  color: Colors.white,
                  size: 16.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  'Batch',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          ServiceVoiceButton(
            serviceName: 'transfers',
            iconColor: Colors.white,
          ),
        ],
      ),
    );
  }
} 