import 'package:flutter/material.dart';
import 'service_chat_bottom_sheet.dart';

class MicroserviceChatIcon extends StatelessWidget {
  final String serviceName;
  final String sourceContext;
  final IconData icon;
  final Color? iconColor;
  final String? agentDescription;

  /// When true, uses the Go Chat Proxy Gateway (direct to microservice,
  /// no intent classification). When false, uses the Python Chat Agent Gateway.
  final bool isDirect;

  /// Overall button size (defaults to 50)
  final double? size;

  /// Icon size inside the button (defaults to 24)
  final double? iconSize;

  const MicroserviceChatIcon({
    super.key,
    required this.serviceName,
    required this.sourceContext,
    this.icon = Icons.chat_bubble_outline,
    this.iconColor,
    this.agentDescription,
    this.isDirect = true,
    this.size,
    this.iconSize,
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
          isDirect: isDirect,
        );
      },
      child: Container(
        width: size ?? 50,
        height: size ?? 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (iconColor ?? const Color(0xFF8B5CF6)).withValues(alpha: 0.1),
          border: Border.all(
            color: iconColor ?? const Color(0xFF8B5CF6),
            width: size != null && size! < 40 ? 1.5 : 2,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color(0xFF8B5CF6),
          size: iconSize ?? 24,
        ),
      ),
    );
  }
}
