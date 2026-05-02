import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Bottom sheet shown when the user swipes down on the dashboard.
///
/// Four CTAs:
///   1. Refresh accounts
///   2. Open AI chatbot (3rd bottom-nav tab)
///   3. Open voice agent (refreshes accounts then opens the voice command sheet)
///   4. Go to profile
///
/// Show via [showDashboardActionSheet]. The helper:
///   * guards against double-open (returns instantly if already showing),
///   * closes the sheet itself before invoking the post-action work,
///   * routes work through [WidgetsBinding.instance.addPostFrameCallback]
///     so the sheet's close animation never overlaps a Navigator push or
///     another bottom-sheet open.
Future<void> showDashboardActionSheet(
  BuildContext context, {
  required Future<void> Function() onRefreshAccounts,
  required VoidCallback onOpenAiChat,
  required VoidCallback onOpenVoiceAgent,
  required VoidCallback onOpenProfile,
}) async {
  final navState = Navigator.of(context, rootNavigator: true);
  if (_DashboardActionSheetGate.isOpen) return;
  _DashboardActionSheetGate.isOpen = true;

  try {
    await showModalBottomSheet<void>(
      context: navState.context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.55),
      useSafeArea: true,
      builder: (sheetCtx) => _DashboardActionSheet(
        onRefreshAccounts: onRefreshAccounts,
        onOpenAiChat: onOpenAiChat,
        onOpenVoiceAgent: onOpenVoiceAgent,
        onOpenProfile: onOpenProfile,
      ),
    );
  } finally {
    _DashboardActionSheetGate.isOpen = false;
  }
}

/// Process-wide guard so rapid drag gestures cannot stack multiple sheets.
class _DashboardActionSheetGate {
  static bool isOpen = false;
}

class _DashboardActionSheet extends StatefulWidget {
  final Future<void> Function() onRefreshAccounts;
  final VoidCallback onOpenAiChat;
  final VoidCallback onOpenVoiceAgent;
  final VoidCallback onOpenProfile;

  const _DashboardActionSheet({
    required this.onRefreshAccounts,
    required this.onOpenAiChat,
    required this.onOpenVoiceAgent,
    required this.onOpenProfile,
  });

  @override
  State<_DashboardActionSheet> createState() => _DashboardActionSheetState();
}

class _DashboardActionSheetState extends State<_DashboardActionSheet> {
  bool _busy = false;

  Future<void> _runRefresh() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await widget.onRefreshAccounts();
    } catch (_) {
      // Caller is responsible for surfacing errors. Sheet always closes.
    } finally {
      if (mounted) Navigator.of(context).maybePop();
    }
  }

  void _runAiChat() {
    if (_busy) return;
    Navigator.of(context).maybePop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onOpenAiChat();
    });
  }

  void _runVoice() {
    if (_busy) return;
    Navigator.of(context).maybePop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onOpenVoiceAgent();
    });
  }

  void _runProfile() {
    if (_busy) return;
    Navigator.of(context).maybePop();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onOpenProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Quick actions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Choose what you want to do.',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              height: 1.3,
            ),
          ),
          SizedBox(height: 16.h),
          _ActionTile(
            icon: Icons.refresh_rounded,
            iconColor: const Color(0xFF3B82F6),
            iconBackground: const Color(0xFF3B82F6).withValues(alpha: 0.12),
            label: 'Refresh accounts',
            description: 'Pull the latest balances and dashboard data.',
            trailing: _busy
                ? SizedBox(
                    width: 18.w,
                    height: 18.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation(Color(0xFF3B82F6)),
                    ),
                  )
                : null,
            onTap: _runRefresh,
            enabled: !_busy,
          ),
          SizedBox(height: 10.h),
          _ActionTile(
            icon: Icons.smart_toy_rounded,
            iconColor: const Color(0xFF10B981),
            iconBackground: const Color(0xFF10B981).withValues(alpha: 0.12),
            label: 'AI chatbot',
            description: 'Open the AI assistant.',
            onTap: _runAiChat,
            enabled: !_busy,
          ),
          SizedBox(height: 10.h),
          _ActionTile(
            icon: Icons.mic_rounded,
            iconColor: const Color(0xFFA855F7),
            iconBackground: const Color(0xFFA855F7).withValues(alpha: 0.12),
            label: 'Voice agent',
            description: 'Refresh and start a voice conversation.',
            onTap: _runVoice,
            enabled: !_busy,
          ),
          SizedBox(height: 10.h),
          _ActionTile(
            icon: Icons.person_outline_rounded,
            iconColor: const Color(0xFFFB923C),
            iconBackground: const Color(0xFFFB923C).withValues(alpha: 0.12),
            label: 'Go to profile',
            description: 'Manage account, security and preferences.',
            onTap: _runProfile,
            enabled: !_busy,
          ),
          SizedBox(height: 16.h),
          TextButton(
            onPressed: _busy ? null : () => Navigator.of(context).maybePop(),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              foregroundColor: const Color(0xFF9CA3AF),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String label;
  final String description;
  final VoidCallback onTap;
  final Widget? trailing;
  final bool enabled;

  const _ActionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    required this.label,
    required this.description,
    required this.onTap,
    this.trailing,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final disabledOpacity = enabled ? 1.0 : 0.5;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      hint: description,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(14.r),
          child: Opacity(
            opacity: disabledOpacity,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF161616),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      color: iconBackground,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 22.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          description,
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 11.sp,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (trailing != null) ...[
                    SizedBox(width: 10.w),
                    trailing!,
                  ] else
                    Icon(
                      Icons.chevron_right_rounded,
                      color: const Color(0xFF9CA3AF),
                      size: 20.sp,
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
