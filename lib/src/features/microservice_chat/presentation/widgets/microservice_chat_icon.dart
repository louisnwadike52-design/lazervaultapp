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

  /// When true, uses dark background with colored border (P2P chat style)
  final bool useDarkInner;

  /// Accent color for the chat bottom sheet theme (header gradient, bubbles, etc.).
  /// Falls back to [iconColor] if not set.
  final Color? chatAccentColor;

  /// Scoped context seeded into the agent's entities on every turn of this
  /// chat — the screen telling the agent what it is looking at.
  ///
  /// The batch-transfer screen needs it: the agent loads its batch toolset
  /// from the gateway's `_intent`, but per-service chat goes through the Go
  /// proxy, which routes by source_context and never runs intent
  /// classification. So a user standing ON the batch screen and saying "pay
  /// my team" — no commas, no keyword — fell through every heuristic and got
  /// the single-transfer tools. The screen knows what it is; this lets it say
  /// so.
  final Map<String, dynamic>? seedEntities;

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
    this.useDarkInner = false,
    this.chatAccentColor,
    this.seedEntities,
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
          accentColor: chatAccentColor ??
              iconColor ??
              const Color.fromARGB(255, 78, 3, 208),
          isDirect: isDirect,
          extraMetadata: seedEntities,
        );
      },
      child: Container(
        width: size ?? 44,
        height: size ?? 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: useDarkInner
              ? Colors.white.withValues(alpha: 0.15)
              : (iconColor ?? const Color.fromARGB(255, 78, 3, 208))
                  .withValues(alpha: 0.1),
          border: Border.all(
            color: useDarkInner
                ? Colors.white.withValues(alpha: 0.3)
                : (iconColor ?? const Color.fromARGB(255, 78, 3, 208)),
            width: (size ?? 44) < 40 ? 1.5 : 2,
          ),
        ),
        child: Icon(
          icon,
          color: iconColor ?? const Color.fromARGB(255, 78, 3, 208),
          size: iconSize ?? 20,
        ),
      ),
    );
  }
}
