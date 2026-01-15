import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

class MicroserviceChatIcon extends StatelessWidget {
  final String serviceName;
  final String sourceContext;
  final IconData icon;
  final Color? iconColor;

  const MicroserviceChatIcon({
    super.key,
    required this.serviceName,
    required this.sourceContext,
    this.icon = Icons.chat_bubble_outline,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.microserviceChat,
          arguments: {
            'serviceName': serviceName,
            'sourceContext': sourceContext,
          },
        );
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.1),
          border: Border.all(
            color: iconColor ?? Colors.blue,
            width: 2,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Colors.blue,
          size: 24,
        ),
      ),
    );
  }
}
