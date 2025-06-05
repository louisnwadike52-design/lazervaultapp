import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/services.dart';

class NotificationsBuilder extends StatefulWidget {
  final List<NotificationService> notifications;

  const NotificationsBuilder({super.key, required this.notifications});

  @override
  State<NotificationsBuilder> createState() => _NotificationsBuilderState();
}

class _NotificationsBuilderState extends State<NotificationsBuilder> {
  List<TextSpan> _buildStyledText(String text) {
    final accountNumberRegex = RegExp(r'\b\d{15,}\b');
    final invoiceNumberRegex = RegExp(r'#INV-\d{4}-\d{3}');
    final amountRegex = RegExp(r'\$\d+(?:\.\d{2})?');
    
    final allMatches = <RegExpMatch>[];
    allMatches.addAll(accountNumberRegex.allMatches(text));
    allMatches.addAll(invoiceNumberRegex.allMatches(text));
    allMatches.addAll(amountRegex.allMatches(text));
    
    // Sort matches by start position
    allMatches.sort((a, b) => a.start.compareTo(b.start));
    
    final spans = <TextSpan>[];
    int currentIndex = 0;

    for (final match in allMatches) {
      // Add the text before the match
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
            height: 1.4,
          ),
        ));
      }

      // Add the matched text with highlight
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          fontSize: 14.sp,
          color: Color.fromARGB(255, 78, 3, 208),
          fontWeight: FontWeight.w600,
          height: 1.4,
        ),
      ));

      currentIndex = match.end;
    }

    // Add the remaining text after the last match
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[600],
          height: 1.4,
        ),
      ));
    }

    return spans;
  }

  String _getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM dd').format(date);
    }
  }

  IconData _getServiceIcon(AppServiceName serviceName) {
    switch (serviceName) {
      case AppServiceName.sendFunds:
        return Icons.send_rounded;
      case AppServiceName.invoice:
        return Icons.receipt_long_rounded;
      case AppServiceName.payInvoice:
        return Icons.payment;
      case AppServiceName.payElectricityBill:
        return Icons.receipt_rounded;
      case AppServiceName.invest:
        return Icons.trending_up_rounded;
      case AppServiceName.exchange:
        return Icons.currency_exchange_rounded;
      case AppServiceName.crypto:
        return Icons.currency_bitcoin_rounded;
      case AppServiceName.giftCards:
        return Icons.card_giftcard_rounded;
      case AppServiceName.aiScanToPay:
        return Icons.qr_code_scanner_rounded;
      case AppServiceName.groupAccount:
        return Icons.groups_rounded;
      default:
        return Icons.help_outline;
    }
  }

  Color _getServiceColor(AppServiceName serviceName) {
    switch (serviceName) {
      case AppServiceName.sendFunds:
        return const Color(0xFF10B981);
      case AppServiceName.invoice:
        return const Color(0xFF6366F1);
      case AppServiceName.payInvoice:
        return const Color(0xFFEAB308);
      case AppServiceName.payElectricityBill:
        return Colors.green;
      case AppServiceName.invest:
        return Colors.purple;
      case AppServiceName.exchange:
        return Colors.teal;
      case AppServiceName.crypto:
        return Colors.amber;
      case AppServiceName.giftCards:
        return Colors.pink;
      case AppServiceName.aiScanToPay:
        return const Color.fromARGB(255, 78, 3, 208);
      case AppServiceName.groupAccount:
        return const Color.fromARGB(255, 78, 3, 208);
      case AppServiceName.insurance:
        return const Color.fromARGB(255, 78, 3, 208);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.notifications.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 0.5,
        color: Colors.grey[200],
        indent: 72.w,
      ),
      itemBuilder: (context, index) {
        final notification = widget.notifications[index];
        final serviceColor = _getServiceColor(notification.appService.serviceName);
        
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Service Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: serviceColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  _getServiceIcon(notification.appService.serviceName),
                  color: serviceColor,
                  size: 24.sp,
                ),
              ),
              
              SizedBox(width: 12.w),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title and Time
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              height: 1.3,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _getRelativeTime(notification.date),
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 6.h),
                    
                    // Subtitle
                    RichText(
                      text: TextSpan(
                        children: _buildStyledText(notification.subTitle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
