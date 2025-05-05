import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/rounded_centered_image.dart';

class NotificationsBuilder extends StatefulWidget {
  final List<NotificationService> notifications;

  const NotificationsBuilder({super.key, required this.notifications});

  @override
  State<NotificationsBuilder> createState() => _NotificationsBuilderState();
}

class _NotificationsBuilderState extends State<NotificationsBuilder> {
  List<TextSpan> _buildStyledText(String text) {
    final accountNumberRegex = RegExp(r'\b\d{15,}\b');
    final matches = accountNumberRegex.allMatches(text);
    final spans = <TextSpan>[];

    int currentIndex = 0;

    for (final match in matches) {
      // Add the text before the match
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: TextStyle(
            fontSize: 14.sp,
            color: HexColor.fromHex("#A3A3A3"),
            height: 1.3,
          ),
        ));
      }

      // Add the matched account number in blue
      spans.add(TextSpan(
        text: text.substring(match.start, match.end),
        style: TextStyle(
          fontSize: 14.sp,
          color: const Color.fromARGB(255, 34, 138, 223),
          fontWeight: FontWeight.w500,
          height: 1.3,
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
          color: HexColor.fromHex("#A3A3A3"),
          height: 1.3, // Add line height
        ),
      ));
    }

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.notifications.length,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0.0),
          leading: RoundedCenteredImage(
            size: 48.0,
            imagePath: widget.notifications[index].appService.serviceImg.uri,
            backgroundColor: const Color.fromARGB(255, 209, 225, 237),
          ),
          title: Text(
            widget.notifications[index].title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.5.h, // Add line height to the title
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 4.0.h,
            children: [
              RichText(
                text: TextSpan(
                  children:
                      _buildStyledText(widget.notifications[index].subTitle),
                ),
              ),
              Text(
                DateFormat('MMM dd, hh:mm a')
                    .format(widget.notifications[index].date),
                style: TextStyle(
                  fontSize: 14.sp,
                  color: HexColor.fromHex("#707070"),
                  fontWeight: FontWeight.w600,
                  height: 1.5, // Add line height to the date
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
