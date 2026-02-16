import 'package:flutter/material.dart';
import 'service_chat_bottom_sheet.dart';

class MicroserviceChatIcon extends StatelessWidget {
  final String serviceName;
  final String sourceContext;
  final IconData icon;
  final Color? iconColor;
  final String? agentDescription;

  const MicroserviceChatIcon({
    super.key,
    required this.serviceName,
    required this.sourceContext,
    this.icon = Icons.chat_bubble_outline,
    this.iconColor,
    this.agentDescription,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showServiceChatBottomSheet(
          context,
          serviceName: serviceName,
          sourceContext: sourceContext,
          agentDescription: agentDescription,
          accentColor: iconColor ?? const Color(0xFF8B5CF6),
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (iconColor ?? const Color(0xFF8B5CF6)).withValues(alpha: 0.1),
          border: Border.all(
            color: iconColor ?? const Color(0xFF8B5CF6),
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF8B5CF6),
          size: 24,
        ),
      ),
    );
  }
}
