import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:share_plus/share_plus.dart';

class Recipients extends StatefulWidget {
  final List<RecipientModel> recipients;

  const Recipients({
    super.key,
    required this.recipients,
  });

  @override
  State<Recipients> createState() => _RecipientsState();
}

class _RecipientsState extends State<Recipients> {
  List<RecipientModel> selectedRecipients = [];

  void _toggleSelection(RecipientModel recipient) {
    setState(() {
      if (selectedRecipients.contains(recipient)) {
        selectedRecipients.remove(recipient);
      } else {
        selectedRecipients.add(recipient);
      }
    });
  }

  void _shareRecipient(RecipientModel recipient) {
    final shareText =
        'Check out this recipient:\nName: ${recipient.name}\nAccount Number: ${recipient.accountNumber}';
    SharePlus.instance.share(ShareParams(text: shareText));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: widget.recipients.length,
      itemBuilder: (context, index) {
        final recipient = widget.recipients[index];
        final isSelected = selectedRecipients.contains(recipient);

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                offset: Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: () => Get.toNamed(AppRoutes.initiateSendFunds, arguments: recipient),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    // Profile Image
                    Container(
                      width: 48.w,
                      height: 48.w,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,                      ),
                      child: Center(
                        child: Text(
                          recipient.name.substring(0, 2).toUpperCase(),
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    
                    // Name and Account Number
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            recipient.name,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              letterSpacing: 0.2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            recipient.accountNumber,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Action Buttons
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Favorite Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () => _toggleSelection(recipient),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                isSelected ? Icons.favorite : Icons.favorite_border,
                                color: isSelected 
                                    ? Color.fromARGB(255, 78, 3, 208)
                                    : Colors.grey[400],
                                size: 22.w,
                              ),
                            ),
                          ),
                        ),
                        
                        // More Options Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () => _showOptionsSheet(context, recipient),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Icon(
                                Icons.more_horiz,
                                color: Colors.grey[600],
                                size: 22.w,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showOptionsSheet(BuildContext context, RecipientModel recipient) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sheet Handle
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            
            // Options List
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.grey[700]),
              title: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Get.back();
                // TODO: Implement view details
              },
            ),
            ListTile(
              leading: Icon(Icons.share_outlined, color: Colors.grey[700]),
              title: Text(
                'Share',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                ),
              ),
              onTap: () {
                Get.back();
                _shareRecipient(recipient);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red[400]),
              title: Text(
                'Remove',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.red[400],
                ),
              ),
              onTap: () {
                Get.back();
                // TODO: Implement remove recipient
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}

