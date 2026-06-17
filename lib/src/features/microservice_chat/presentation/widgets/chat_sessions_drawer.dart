import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/chat_sessions_cubit.dart';
import '../../cubit/chat_sessions_state.dart';
import '../../domain/entities/chat_session_summary.dart';

/// ChatGPT-style left-side drawer listing the user's chat sessions.
///
/// Top: "+ New chat" CTA pill.
/// Below: scrollable list of session rows. Each row shows title + first
/// message preview + relative timestamp. Long-press opens a bottom sheet
/// with Rename / Delete actions. Tap switches the active session and
/// closes the drawer.
class ChatSessionsDrawer extends StatelessWidget {
  const ChatSessionsDrawer({super.key});

  // LazerVault brand palette (mirrors the dark-theme tokens in CLAUDE.md).
  static const Color _brandPurple = Color(0xFF7C3AED);
  static const Color _background = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: _background,
      width: MediaQuery.of(context).size.width * 0.82,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(context),
            _buildNewChatButton(context),
            const SizedBox(height: 8),
            const Divider(color: _divider, height: 1),
            Expanded(child: _buildSessionList(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 16, 8),
      child: Row(
        children: [
          const Expanded(
            child: Text(
              'Your chats',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: _textSecondary, size: 20),
            tooltip: 'Refresh',
            onPressed: () => context.read<ChatSessionsCubit>().refresh(),
          ),
        ],
      ),
    );
  }

  Widget _buildNewChatButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: _brandPurple,
        borderRadius: BorderRadius.circular(28),
        child: InkWell(
          borderRadius: BorderRadius.circular(28),
          onTap: () async {
            await context.read<ChatSessionsCubit>().createNew();
            if (context.mounted) Navigator.of(context).maybePop();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'New chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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

  Widget _buildSessionList(BuildContext context) {
    return BlocBuilder<ChatSessionsCubit, ChatSessionsState>(
      builder: (context, state) {
        final (sessions, currentId, isLoading, errorMsg) = switch (state) {
          ChatSessionsInitial() => (<ChatSessionSummary>[], null as String?, true, null as String?),
          ChatSessionsLoading(:final sessions, :final currentId) =>
            (sessions, currentId, true, null as String?),
          ChatSessionsLoaded(:final sessions, :final currentId) =>
            (sessions, currentId, false, null as String?),
          ChatSessionsError(:final sessions, :final currentId, :final message) =>
            (sessions, currentId, false, message),
        };

        if (sessions.isEmpty && isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: _brandPurple),
          );
        }

        if (sessions.isEmpty && errorMsg != null) {
          return _buildErrorState(context, errorMsg);
        }

        if (sessions.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          color: _brandPurple,
          backgroundColor: _card,
          onRefresh: () => context.read<ChatSessionsCubit>().refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: sessions.length,
            itemBuilder: (context, i) {
              final session = sessions[i];
              final isCurrent = session.sessionId == currentId;
              return _SessionRow(
                session: session,
                isCurrent: isCurrent,
                onTap: () async {
                  await context
                      .read<ChatSessionsCubit>()
                      .switchTo(session.sessionId);
                  if (context.mounted) Navigator.of(context).maybePop();
                },
                onLongPress: () =>
                    _showSessionActionSheet(context, session),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.chat_bubble_outline,
                color: _textSecondary.withValues(alpha: 0.5), size: 48),
            const SizedBox(height: 12),
            const Text(
              'No chats yet',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap “New chat” to start your first conversation.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String msg) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: _textSecondary, size: 40),
            const SizedBox(height: 12),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _textSecondary, fontSize: 13),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () =>
                  context.read<ChatSessionsCubit>().initialize(),
              child: const Text('Retry',
                  style: TextStyle(color: _brandPurple)),
            ),
          ],
        ),
      ),
    );
  }

  void _showSessionActionSheet(
      BuildContext context, ChatSessionSummary session) {
    final cubit = context.read<ChatSessionsCubit>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: _card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Text(
                  session.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ListTile(
                leading:
                    const Icon(Icons.edit_outlined, color: _textPrimary),
                title: const Text('Rename',
                    style: TextStyle(color: _textPrimary)),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await _showRenameDialog(context, cubit, session);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete_outline,
                    color: Color(0xFFEF4444)),
                title: const Text('Delete',
                    style: TextStyle(color: Color(0xFFEF4444))),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  await _confirmAndDelete(context, cubit, session);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showRenameDialog(
      BuildContext context, ChatSessionsCubit cubit, ChatSessionSummary session) async {
    final controller = TextEditingController(text: session.title);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: _card,
          title: const Text('Rename chat',
              style: TextStyle(color: _textPrimary)),
          content: TextField(
            controller: controller,
            autofocus: true,
            maxLength: 60,
            style: const TextStyle(color: _textPrimary),
            decoration: const InputDecoration(
              hintText: 'Chat title',
              hintStyle: TextStyle(color: _textSecondary),
              counterStyle: TextStyle(color: _textSecondary),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _divider),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: _brandPurple),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel',
                  style: TextStyle(color: _textSecondary)),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(ctx).pop(controller.text.trim()),
              child: const Text('Save',
                  style: TextStyle(color: _brandPurple)),
            ),
          ],
        );
      },
    );
    controller.dispose();
    if (newTitle == null || newTitle.isEmpty) return;
    if (newTitle == session.title) return;
    await cubit.rename(sessionId: session.sessionId, title: newTitle);
  }

  Future<void> _confirmAndDelete(
      BuildContext context, ChatSessionsCubit cubit, ChatSessionSummary session) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Delete this chat?',
            style: TextStyle(color: _textPrimary)),
        content: Text(
          'This will permanently remove “${session.title}”. You can\'t undo this.',
          style: const TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel',
                style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete',
                style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await cubit.delete(session.sessionId);
  }
}

class _SessionRow extends StatelessWidget {
  final ChatSessionSummary session;
  final bool isCurrent;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _SessionRow({
    required this.session,
    required this.isCurrent,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final highlight = isCurrent
        ? ChatSessionsDrawer._brandPurple.withValues(alpha: 0.12)
        : Colors.transparent;
    final borderColor = isCurrent
        ? ChatSessionsDrawer._brandPurple.withValues(alpha: 0.5)
        : Colors.transparent;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Material(
        color: highlight,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          onLongPress: onLongPress,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: borderColor, width: 1),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                Icon(
                  isCurrent
                      ? Icons.chat_bubble
                      : Icons.chat_bubble_outline,
                  color: isCurrent
                      ? ChatSessionsDrawer._brandPurple
                      : ChatSessionsDrawer._textSecondary,
                  size: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        session.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: ChatSessionsDrawer._textPrimary,
                          fontSize: 14,
                          fontWeight:
                              isCurrent ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                      if (session.firstMessagePreview.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          session.firstMessagePreview,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: ChatSessionsDrawer._textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _formatRelative(session.lastActivity),
                  style: const TextStyle(
                    color: ChatSessionsDrawer._textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _formatRelative(DateTime when) {
    final now = DateTime.now().toUtc();
    final diff = now.difference(when.toUtc());
    if (diff.inMinutes < 1) return 'now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    if (diff.inDays < 365) return '${(diff.inDays / 7).floor()}w';
    return '${(diff.inDays / 365).floor()}y';
  }
}
