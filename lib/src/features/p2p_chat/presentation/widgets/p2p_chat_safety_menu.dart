import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/p2p_chat_cubit.dart';

/// REPORT AND BLOCK, in the chat header.
///
/// App Store Review Guideline 1.2 requires an app carrying user-generated
/// content to provide a way to filter objectionable material, a way to REPORT
/// offensive content, the ability to BLOCK abusive users, and published contact
/// details. Chat here is real user-to-user messaging with image upload, so the
/// guideline applies. The keyword filter and the admin alert queue already
/// existed; these two did not, and a reviewer opening a conversation would have
/// found no way to do either.
///
/// It lives in its own file because p2p_chat_page.dart is already past two
/// thousand lines, and because a safety affordance should be easy to find when
/// someone goes looking for it.
class P2pChatSafetyMenu extends StatelessWidget {
  const P2pChatSafetyMenu({
    super.key,
    required this.cubit,
    required this.peerName,
    this.onBlocked,
  });

  final P2PChatCubit cubit;

  /// Shown in the confirmation copy so the user can see who they are about to
  /// block — "Block this user?" with no name is how the wrong person gets
  /// blocked.
  final String peerName;

  /// Called after a successful block so the page can leave the conversation.
  final VoidCallback? onBlocked;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert_rounded, size: 18.sp),
      tooltip: 'Safety',
      onSelected: (value) {
        if (value == 'report') _confirmReport(context);
        if (value == 'block') _confirmBlock(context);
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              Icon(Icons.flag_outlined, size: 18.sp),
              SizedBox(width: 10.w),
              const Text('Report'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'block',
          child: Row(
            children: [
              Icon(Icons.block_rounded, size: 18.sp, color: Colors.red),
              SizedBox(width: 10.w),
              const Text('Block', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _confirmReport(BuildContext context) async {
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Report this conversation'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our team will review this conversation. Tell us what is wrong '
              'so we can act on it faster.',
              style: TextStyle(fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: controller,
              maxLines: 3,
              maxLength: 300,
              decoration: const InputDecoration(
                hintText: 'What happened? (optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Report'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final ok = await cubit.reportPeer(reason: controller.text.trim());
    if (!context.mounted) return;
    _notify(
      context,
      ok
          ? 'Thanks — this has been sent to our team for review.'
          : 'Something went wrong. Please try again.',
    );
  }

  Future<void> _confirmBlock(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Block $peerName?'),
        content: Text(
          'They will not be able to message you, and you will not be able to '
          'message them. You can undo this later in Settings.',
          style: TextStyle(fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final ok = await cubit.blockPeer();
    if (!context.mounted) return;
    if (ok) {
      _notify(context, '$peerName has been blocked.');
      onBlocked?.call();
    } else {
      _notify(context, 'Something went wrong. Please try again.');
    }
  }

  void _notify(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
