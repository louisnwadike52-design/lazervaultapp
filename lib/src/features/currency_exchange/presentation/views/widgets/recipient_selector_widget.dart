import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

import '../../../domain/entities/recipient_entity.dart';
import '../../controllers/exchange_controller.dart';

class RecipientSelectorWidget extends StatelessWidget {
  const RecipientSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<ExchangeController>(
      builder: (controller) {
        final recipient = controller.selectedRecipient.value;

        return GestureDetector(
          onTap: () => _showRecipientSelector(context),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[700]!, Colors.blue[500]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      recipient == null ? Icons.person_add : Icons.person,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient == null ? 'Select Recipient' : recipient.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (recipient != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          '${recipient.bankName} • ${recipient.accountNumber}',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ] else
                        Text(
                          'Choose who receives the money',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                          ),
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: const Color(0xFF9CA3AF),
                  size: 24.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRecipientSelector(BuildContext context) {
    final controller = Get.find<ExchangeController>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: Get.height * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Select Recipient',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  _buildRecipientItem(
                    context: context,
                    recipient: _createDemoRecipient(
                      id: '1',
                      name: 'John Doe',
                      bankName: 'Bank of America',
                      accountNumber: '****1234',
                      swiftCode: 'BOFAUS3N',
                    ),
                    controller: controller,
                  ),
                  _buildRecipientItem(
                    context: context,
                    recipient: _createDemoRecipient(
                      id: '2',
                      name: 'Jane Smith',
                      bankName: 'Chase Bank',
                      accountNumber: '****5678',
                      swiftCode: 'CHASUS33',
                    ),
                    controller: controller,
                  ),
                  _buildRecipientItem(
                    context: context,
                    recipient: _createDemoRecipient(
                      id: '3',
                      name: 'Robert Johnson',
                      bankName: 'Wells Fargo',
                      accountNumber: '****9012',
                      swiftCode: 'WFBIUS6S',
                    ),
                    controller: controller,
                  ),
                  SizedBox(height: 16.h),
                  _buildAddNewRecipient(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipientItem({
    required BuildContext context,
    required Recipient recipient,
    required ExchangeController controller,
  }) {
    final isSelected = controller.selectedRecipient.value?.id == recipient.id;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          controller.setSelectedRecipient(recipient);
          Get.back();
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue[700]!, Colors.blue[500]!],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    recipient.initials,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipient.name,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${recipient.bankName} • ${recipient.accountNumber}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Icon(Icons.check_circle, color: Colors.blue, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddNewRecipient(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Get.back();
            Get.snackbar(
              'Add Recipient',
              'This feature will integrate with your recipient management system',
              backgroundColor: Colors.blue.withValues(alpha: 0.9),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.blue, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Add New Recipient',
                  style: GoogleFonts.inter(
                    color: Colors.blue,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Recipient _createDemoRecipient({
    required String id,
    required String name,
    required String bankName,
    required String accountNumber,
    required String swiftCode,
  }) {
    return Recipient(
      id: id,
      name: name,
      email: '${name.toLowerCase().replaceAll(' ', '.')}@example.com',
      accountNumber: accountNumber,
      bankName: bankName,
      swiftCode: swiftCode,
      countryCode: 'US',
      currency: 'USD',
      createdAt: DateTime.now(),
    );
  }
}
