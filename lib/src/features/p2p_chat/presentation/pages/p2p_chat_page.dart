import 'dart:async';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/foundation.dart' show setEquals;
import 'package:lazervault/core/services/app_activity_bus.dart';
import 'package:lazervault/core/services/chat_sound_settings.dart';
import 'package:lazervault/core/services/pending_message_highlight.dart';
import 'package:get/get.dart';
// hide Config: emoji_picker_flutter also exports a `Config` type (used by the
// reaction emoji picker); google_fonts' internal Config isn't used here.
import 'package:google_fonts/google_fonts.dart' hide Config;
import 'package:intl/intl.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';
import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/chat_media_bubble.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/service_chat_bottom_sheet.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/src/features/widgets/user_avatar.dart';
import 'package:lazervault/src/features/ai_chats/presentation/widgets/fullscreen_image_viewer.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/p2p_chat/domain/entities/p2p_message_entity.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_cubit.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/cubit/p2p_chat_state.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_chat_input_bar.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_text_bubble.dart';
import 'package:lazervault/src/features/p2p_chat/presentation/widgets/p2p_transfer_bubble.dart';
import 'package:lazervault/src/features/p2p_chat/services/p2p_chat_websocket_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class P2PChatPage extends StatefulWidget {
  const P2PChatPage({super.key});

  @override
  State<P2PChatPage> createState() => _P2PChatPageState();
}

class _P2PChatPageState extends State<P2PChatPage>
    with WidgetsBindingObserver, EngagementKeepAlive {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = true;
  bool _userScrolledUp = false;
  bool _showScrollToBottom = false;
  bool _didInitialJump = false;
  // Preserve the viewport when older messages prepend (WhatsApp-style): keep
  // the same distance-from-bottom so the content the user is reading stays put.
  bool _pendingPrependRestore = false;
  double _prependAnchorFromBottom = 0;

  StreamSubscription? _typingSubscription;
  bool _otherUserTyping = false;

  // Per-message keys so the AI "jump to message" can scroll a specific bubble
  // into view. Populated lazily as rows build; a stale entry is harmless.
  final Map<String, GlobalKey> _msgKeys = {};
  // The highlight set we last scrolled to, so we scroll ONCE per jump.
  Set<String> _lastScrolledHighlight = const {};

  /// Wrap a message row with its scroll key + a transient highlight tint used
  /// by the AI "jump to message" flash.
  Widget _msgRow(String id, Set<String> highlighted, Widget child) {
    return Container(
      key: _msgKeys.putIfAbsent(id, () => GlobalKey()),
      color: highlighted.contains(id)
          ? const Color(0x337C3AED) // brand-purple wash, transient
          : null,
      child: child,
    );
  }

  /// Scroll the first highlighted message into view (called when the cubit
  /// flags a jump target). Best-effort: the row must be built (page-until-found
  /// in the cubit loads it first); if its key has no context yet we retry next
  /// frame a few times.
  void _scrollToHighlighted(Set<String> ids, {int attempt = 0}) {
    if (ids.isEmpty || !mounted) return;
    final targetId = ids.first;
    final key = _msgKeys[targetId];
    final ctx = key?.currentContext;
    if (ctx != null) {
      // Built + measurable → precise scroll.
      Scrollable.ensureVisible(ctx,
          alignment: 0.3,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut);
      return;
    }
    // Off-screen: a plain ListView doesn't build rows outside the viewport +
    // cacheExtent, so the key has no context yet. Nudge the scroll to the
    // target's APPROXIMATE position (by its index fraction) to pull that region
    // into the build range, then retry — ensureVisible then refines exactly.
    if (attempt == 0) {
      try {
        final s = context.read<P2PChatCubit>().state;
        if (s is P2PChatLoaded &&
            s.messages.isNotEmpty &&
            _scrollController.hasClients) {
          final idx = s.messages.indexWhere((m) => m.id == targetId);
          if (idx >= 0) {
            final max = _scrollController.position.maxScrollExtent;
            final frac = idx / s.messages.length;
            _scrollController.jumpTo((frac * max).clamp(0.0, max));
          }
        }
      } catch (_) {}
    }
    if (attempt >= 8) return; // give up after ~8 frames
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => _scrollToHighlighted(ids, attempt: attempt + 1));
  }
  Timer? _typingTimeout;

  // Ephemeral floating-emoji overlay (WhatsApp-style bursts over the chat).
  StreamSubscription? _emojiSubscription;
  final GlobalKey<_EmojiStreamOverlayState> _emojiOverlayKey =
      GlobalKey<_EmojiStreamOverlayState>();

  late final String _otherUserId;
  late final String _otherUserName;
  late final String? _otherUserAvatar;
  late final String _currentUserId;
  bool _safetyWarning = false;
  String? _safetyWarningReason;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final args = Get.arguments as Map<String, dynamic>? ?? {};
    _otherUserId = args['otherUserId'] as String? ?? '';
    _otherUserName = args['otherUserName'] as String? ?? 'Unknown User';
    _otherUserAvatar = args['otherUserAvatar'] as String?;
    _safetyWarning = args['safetyWarning'] as bool? ?? false;
    _safetyWarningReason = args['safetyWarningReason'] as String?;

    final authCubit = context.read<AuthenticationCubit>();
    _currentUserId = switch (authCubit.state) {
      AuthenticationAuthenticated s => s.profile.userId,
      AuthenticationSuccess s => s.profile.userId,
      _ => '',
    };

    // Listen for typing indicators
    final wsService = serviceLocator<P2PChatWebSocketService>();
    _typingSubscription = wsService.typingStream.listen((event) {
      if (event.userId == _otherUserId && mounted) {
        setState(() => _otherUserTyping = event.isTyping);
        _typingTimeout?.cancel();
        if (event.isTyping) {
          _scrollToBottom(); // reveal the typing bubble like the chatbot
          _typingTimeout = Timer(const Duration(seconds: 5), () {
            if (mounted) setState(() => _otherUserTyping = false);
          });
        }
      }
    });

    _scrollController.addListener(_onScroll);

    // Animate incoming ephemeral emoji bursts from the other party.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      try {
        _emojiSubscription =
            context.read<P2PChatCubit>().incomingEmojiBursts.listen((emoji) {
          _emojiOverlayKey.currentState?.burst(emoji);
        });
      } catch (_) {}
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels <=
        _scrollController.position.minScrollExtent + 100) {
      // Capture distance-from-bottom BEFORE older messages prepend, so we can
      // restore the exact viewport afterward (older rows are inserted at the
      // top, which would otherwise jump the view). Only arm once per load.
      if (!_pendingPrependRestore) {
        _prependAnchorFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        _pendingPrependRestore = true;
      }
      context.read<P2PChatCubit>().loadMore();
    }

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    final atBottom = (maxScroll - currentScroll) <= 50;

    if (!atBottom && _isAtBottom) {
      _userScrolledUp = true;
    }
    if (atBottom) {
      _userScrolledUp = false;
    }
    _isAtBottom = atBottom;

    final shouldShowButton = !atBottom && (maxScroll - currentScroll) > 200;
    if (shouldShowButton != _showScrollToBottom) {
      setState(() => _showScrollToBottom = shouldShowButton);
    }
  }

  void _scrollToBottom({bool force = false}) {
    if (!_scrollController.hasClients) return;
    if (_userScrolledUp && !force) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && _scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _typingSubscription?.cancel();
    _emojiSubscription?.cancel();
    _typingTimeout?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Keep server-side "viewing" presence honest across backgrounding: while
    // this chat is open but the app is NOT foreground, the recipient isn't
    // actually looking, so clear focus → an inbound message pushes. Re-assert
    // focus on resume. (The WS itself may linger for seconds when backgrounded,
    // so we can't rely on its drop alone.)
    final ws = serviceLocator<P2PChatWebSocketService>();
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        ws.sendBlur();
        break;
      case AppLifecycleState.resumed:
        final cid = _conversationIdOrNull();
        if (cid != null && cid.isNotEmpty) ws.sendFocus(cid);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildSafetyWarningBanner(),
            _buildConnectionBanner(),
            Expanded(child: _buildMessageList()),
            _buildInputArea(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      // Build the whole LEFT cluster (arrow + avatar + name) ourselves so it
      // sits tight against the back arrow, and the name gets an Expanded slot
      // that ellipsizes — leaving a clean gap before the right-hand actions
      // instead of overflowing into them.
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            constraints: BoxConstraints(minWidth: 36.w, minHeight: 36.w),
          ),
          // Tapping the avatar opens the profile picture full-screen (zoom +
          // swipe-down to dismiss). Hero animates it between here and the viewer.
          GestureDetector(
            onTap: _onAvatarTap,
            child: Hero(tag: _avatarHeroTag, child: _buildAvatar()),
          ),
          SizedBox(width: 8.w),
          // The whole name/subtitle block is one tap target that opens the
          // peer's profile modal.
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: _openProfileModal,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _otherUserName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    _otherUserTyping ? 'Typing...' : 'Lazervault User',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      color: _otherUserTyping
                          ? const Color(0xFF3B82F6)
                          : const Color(0xFF9CA3AF),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      actions: [
        // Chat settings (sound, vibration, …) — grouped with the AI/voice
        // actions on the RIGHT, opening the same sheet as the peer's name/avatar.
        _buildHeaderCircleButton(
          icon: Icons.settings_outlined,
          tooltip: 'Chat settings',
          onTap: _openProfileModal,
          size: 32,
          iconSize: 16,
        ),
        SizedBox(width: 6.w),
        // AI assistant scoped to THIS conversation (chat + voice). Both pass
        // conversation_id + peer_user_id so the transfers agent answers about
        // this chat/person. The AI entry uses the same circular chat-bubble
        // treatment as every other service landing page (MicroserviceChatIcon).
        _buildHeaderCircleButton(
          icon: Icons.chat_bubble_outline_rounded,
          tooltip: 'Ask AI about this chat',
          onTap: _openConversationAi,
          size: 32,
          iconSize: 16,
        ),
        SizedBox(width: 6.w),
        ServiceVoiceButton(
          serviceName: 'p2p_chat',
          conversationId: _conversationIdOrNull(),
          iconColor: const Color(0xFF7C3AED),
          buttonSize: 32,
          iconSize: 16,
          suggestions: const [
            'When did I last send money to this person?',
            'How much have I sent them in total?',
          ],
        ),
        SizedBox(width: 6.w),
        // Small, explicit "Send" money button in the brand purple (matches the
        // dashboard) with contrasted white glyph/label. Uses a distinct outgoing
        // glyph — NOT the composer's paper-plane — so it reads as "send money".
        Padding(
          padding: EdgeInsets.only(right: 10.w),
          child: Material(
            color: const Color(0xFF4834D4),
            borderRadius: BorderRadius.circular(16.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: _openSendMoney,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 5.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.north_east_rounded,
                        color: Colors.white, size: 13.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Send',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Circular, bordered header action button matching the AI-chat entry used
  /// on every other service landing page (MicroserviceChatIcon), tinted for the
  /// dark P2P header.
  Widget _buildHeaderCircleButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
    double size = 40,
    double iconSize = 20,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onTap,
          child: Container(
            width: size.w,
            height: size.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF7C3AED).withOpacity(0.12),
              border: Border.all(
                color: const Color(0xFF7C3AED).withOpacity(0.45),
                width: 1.5,
              ),
            ),
            child: Icon(icon, color: const Color(0xFF7C3AED), size: iconSize.sp),
          ),
        ),
      ),
    );
  }

  /// The current conversation id from the loaded state (null before load).
  String? _conversationIdOrNull() {
    final s = context.read<P2PChatCubit>().state;
    return s is P2PChatLoaded ? s.conversationId : null;
  }

  /// Open the conversation-scoped AI chat assistant. Routes via
  /// source_context='p2p_chat' → transfers agent, seeded with this
  /// conversation's id + the peer's user id so answers stay scoped to this chat.
  void _openConversationAi() {
    final cid = _conversationIdOrNull();
    final peerName = _otherUserName.trim();
    final myName = _currentUserFullName();
    showServiceChatBottomSheet(
      context,
      // The sheet renders "<serviceName> Assistant", so keep this just 'Chat'.
      serviceName: 'Chat',
      sourceContext: 'p2p_chat',
      // Unique session per conversation so AI history never leaks across chats.
      sessionScopeId: (cid != null && cid.isNotEmpty)
          ? cid
          : (_otherUserId.isNotEmpty ? _otherUserId : null),
      agentDescription:
          'Ask about this conversation — messages and money you\'ve sent or received with ${peerName.isNotEmpty ? peerName : 'this person'}.',
      accentColor: const Color(0xFF7C3AED),
      extraMetadata: {
        if (cid != null && cid.isNotEmpty) 'conversation_id': cid,
        if (_otherUserId.isNotEmpty) 'peer_user_id': _otherUserId,
        // Names of BOTH parties so the assistant addresses people by name
        // instead of "this person" (see the p2p_scope prompt block).
        if (peerName.isNotEmpty && peerName != 'Unknown User')
          'peer_name': peerName,
        if (myName.isNotEmpty) 'my_name': myName,
      },
    ).then((_) {
      // The user may have sent money or a message THROUGH the assistant while
      // the sheet covered the thread; pull the latest so a new transfer bubble
      // / message shows the instant they return to the chat.
      if (mounted) {
        try {
          context.read<P2PChatCubit>().reloadConversation();
        } catch (_) {}
        // If the assistant queued a "jump to message" (user tapped "Show in
        // chat"), apply it now that the sheet is closed and the thread is
        // visible: page-until-found + flash-highlight the match(es).
        final cid = _conversationIdOrNull();
        if (cid != null) {
          final anchors = PendingMessageHighlight.instance.consume(cid);
          if (anchors != null && anchors.isNotEmpty) {
            try {
              context
                  .read<P2PChatCubit>()
                  .jumpToAndHighlight(anchors.map((a) => a.messageId).toList());
            } catch (_) {}
          }
        }
      }
    });
  }

  /// Full name of the signed-in user (for the P2P AI assistant's context).
  String _currentUserFullName() {
    final s = context.read<AuthenticationCubit>().state;
    final user = switch (s) {
      AuthenticationAuthenticated a => a.profile.user,
      AuthenticationSuccess a => a.profile.user,
      _ => null,
    };
    if (user == null) return '';
    return '${user.firstName} ${user.lastName}'.trim();
  }

  /// Circular peer avatar — the peer's profile picture when available, else the
  /// shared 2-initial fallback (same [UserAvatar] the dashboard uses).
  Widget _buildAvatar() {
    final parts = _otherUserName.trim().split(RegExp(r'\s+'));
    final first = parts.isNotEmpty ? parts.first : '';
    final last = parts.length > 1 ? parts.last : '';
    return UserAvatar(
      size: 30.w,
      imageUrl: _otherUserAvatar,
      firstName: first,
      lastName: last,
      backgroundColor: const Color(0xFF3B82F6).withOpacity(0.2),
    );
  }

  String get _avatarHeroTag => 'p2p-peer-avatar-$_otherUserId';

  /// Avatar tap: open the profile picture full-screen (zoom + swipe-to-dismiss)
  /// when there's a real picture, otherwise fall back to the profile modal.
  void _onAvatarTap() {
    final url = _otherUserAvatar;
    if (url != null && url.isNotEmpty) {
      FullScreenImageViewer.open(context, mediaUrl: url, heroTag: _avatarHeroTag);
    } else {
      _openProfileModal();
    }
  }

  /// (first, last) split of the peer's display name for the shared avatar.
  (String, String) _peerNameParts() {
    final parts = _otherUserName.trim().split(RegExp(r'\s+'));
    return (
      parts.isNotEmpty ? parts.first : '',
      parts.length > 1 ? parts.last : '',
    );
  }

  /// Bottom-sheet showing the peer's publicly-visible profile — large avatar at
  /// the top, name, Lazervault-user badge, and quick actions (message / send).
  void _openProfileModal() {
    final (first, last) = _peerNameParts();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetCtx) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1C),
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            border: Border.all(color: const Color(0xFF262629)),
          ),
          padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w,
              MediaQuery.of(sheetCtx).padding.bottom + 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3A3A3C),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              // Large avatar — tap to view full-screen too.
              GestureDetector(
                onTap: () {
                  final url = _otherUserAvatar;
                  if (url != null && url.isNotEmpty) {
                    FullScreenImageViewer.open(sheetCtx,
                        mediaUrl: url, heroTag: 'p2p-profile-modal-$_otherUserId');
                  }
                },
                child: Hero(
                  tag: 'p2p-profile-modal-$_otherUserId',
                  child: UserAvatar(
                    size: 96.w,
                    imageUrl: _otherUserAvatar,
                    firstName: first,
                    lastName: last,
                    backgroundColor: const Color(0xFF3B82F6).withOpacity(0.25),
                    borderColor: const Color(0xFF3B82F6),
                    borderWidth: 2,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                _otherUserName,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 6.h),
              // Verified Lazervault-user badge.
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified_rounded,
                        color: const Color(0xFF3B82F6), size: 14.sp),
                    SizedBox(width: 5.w),
                    Text(
                      'Lazervault user',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              // Quick actions.
              Row(
                children: [
                  Expanded(
                    child: _profileAction(
                      icon: Icons.chat_bubble_outline_rounded,
                      label: 'Message',
                      onTap: () => Navigator.of(sheetCtx).pop(),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _profileAction(
                      icon: Icons.north_east_rounded,
                      label: 'Send money',
                      filled: true,
                      onTap: () {
                        Navigator.of(sheetCtx).pop();
                        _openSendMoney();
                      },
                    ),
                  ),
                ],
              ),
              // Per-chat sound + vibration overrides. Only when a real
              // conversation exists (transfer-only threads before the first
              // message have no id to key an override on — they follow global).
              if (_conversationIdOrNull() != null) ...[
                SizedBox(height: 20.h),
                _ChatNotificationSettings(
                    conversationId: _conversationIdOrNull()!),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _profileAction({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool filled = false,
  }) {
    return Material(
      color: filled ? const Color(0xFF3B82F6) : Colors.transparent,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: filled
                ? null
                : Border.all(color: const Color(0xFF3A3A3C)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: filled ? Colors.white : const Color(0xFF9CA3AF),
                  size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: filled ? Colors.white : Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Start a send to this peer, honoring the admin-configured flow (short vs
  /// long) and passing a COMPLETE internal-recipient payload so neither flow
  /// rejects it. The peer is a Lazervault user, so this is always an internal
  /// (free) C2C transfer resolved by user id.
  void _openSendMoney() {
    if (_otherUserId.isEmpty) {
      Get.snackbar('Unavailable',
          'This contact can\'t be paid right now — missing user id.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_otherUserId == _currentUserId) {
      Get.snackbar('Not allowed', 'You can\'t send funds to yourself.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final recipient = RecipientModel(
      id: _otherUserId,
      // name + accountNumber must be non-empty (both flows validate them). For
      // an internal transfer the backend routes by internalUserId/toAccountId,
      // so accountNumber carries the user id purely to satisfy validation. It is
      // NEVER shown to the user: RecipientModel.hasRealAccountNumber is false for
      // this non-numeric value, so every masking site (confirm sheet, receipt)
      // renders the name + "Lazervault" and hides the account row.
      name: _otherUserName.trim().isNotEmpty ? _otherUserName : 'Lazervault User',
      accountNumber: _otherUserId,
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      internalUserId: _otherUserId,
      type: 'internal',
    );

    if (FeatureFlags.sendFlowShortForSession) {
      // Short flow lives on the select-recipient screen (it owns the amount
      // sheet + dispatch). Hand it the preselected peer so it runs the short
      // tail directly — reusing all balance/PIN/receipt edge-case handling.
      Get.toNamed(
        AppRoutes.selectRecipient,
        arguments: {
          'shortFlow': true,
          'preselectedRecipient': recipient,
          'autoContinue': true,
        },
      );
    } else {
      // Long flow: the full amount-entry screen accepts a recipient directly.
      Get.toNamed(AppRoutes.initiateSendFunds,
          arguments: {'recipient': recipient});
    }
  }

  /// ⚠️ Fraud-detection warning shown ONLY to the counterparty when the other
  /// participant's message was flagged by AI/keyword monitoring. The flagged
  /// sender never sees this (detection is silent to them). Dismissible per
  /// session; the server keeps the flag for investigation.
  Widget _buildSafetyWarningBanner() {
    if (!_safetyWarning) return const SizedBox.shrink();
    final reason = (_safetyWarningReason != null &&
            _safetyWarningReason!.trim().isNotEmpty)
        ? _safetyWarningReason!.trim()
        : 'This conversation was flagged for review. Be careful sharing money or personal details.';
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 0),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withOpacity(0.12),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFFB923C).withOpacity(0.45)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('⚠️', style: TextStyle(fontSize: 16.sp)),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety warning',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  reason,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12.sp,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            onTap: () => setState(() => _safetyWarning = false),
            child: Icon(Icons.close,
                color: Colors.white.withOpacity(0.6), size: 18.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionBanner() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      builder: (context, state) {
        if (state is! P2PChatLoaded) return const SizedBox.shrink();

        // Connection request banner
        if (state.connectionStatus == 'pending') {
          final isInitiator = state.initiatedBy == _currentUserId;
          final hasSentMessage = isInitiator && state.messages.isNotEmpty;

          // Initiator: only show "waiting" banner AFTER they've sent their first message
          if (isInitiator && !hasSentMessage) {
            // No banner yet — they can still send their first message
            return const SizedBox.shrink();
          }

          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            color: const Color(0xFFFB923C).withOpacity(0.15),
            child: Row(
              children: [
                Icon(
                  isInitiator ? Icons.hourglass_top : Icons.person_add,
                  color: const Color(0xFFFB923C),
                  size: 18.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    isInitiator
                        ? 'Waiting for $_otherUserName to accept your connection request'
                        : '$_otherUserName wants to connect with you',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFFB923C),
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // WebSocket connection banner
        if (state.connectionState == P2PChatConnectionState.reconnecting) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            color: const Color(0xFFFB923C).withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LazerVaultLoader(size: 12),
                SizedBox(width: 8.w),
                Text(
                  'Reconnecting...',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFFB923C),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        }

        if (state.connectionState == P2PChatConnectionState.disconnected) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            color: const Color(0xFFEF4444).withOpacity(0.15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cloud_off, size: 14.w, color: const Color(0xFFEF4444)),
                SizedBox(width: 6.w),
                Text(
                  'Offline — messages sent via fallback',
                  style: GoogleFonts.inter(
                    color: const Color(0xFFEF4444),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildMessageList() {
    return BlocConsumer<P2PChatCubit, P2PChatState>(
      listener: (context, state) {
        // AI "jump to message": when the cubit flags highlight target(s), scroll
        // the first match into view — once per distinct jump.
        if (state is P2PChatLoaded) {
          if (state.highlightedMessageIds.isNotEmpty &&
              !setEquals(state.highlightedMessageIds, _lastScrolledHighlight)) {
            _lastScrolledHighlight = state.highlightedMessageIds;
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => _scrollToHighlighted(state.highlightedMessageIds));
          } else if (state.highlightedMessageIds.isEmpty) {
            _lastScrolledHighlight = const {};
          }
        }
        if (state is P2PChatLoaded && state.messages.isNotEmpty && !_didInitialJump) {
          // First paint of a conversation → jump straight to the newest message
          // instantly (no animation), so opening a chat lands at the bottom.
          _didInitialJump = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });
        } else if (_pendingPrependRestore &&
            state is P2PChatLoaded &&
            !state.isLoadingMore) {
          // Older messages just prepended → restore the same distance-from-
          // bottom so the reading position doesn't jump.
          _pendingPrependRestore = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _scrollController.hasClients) {
              final target = _scrollController.position.maxScrollExtent -
                  _prependAnchorFromBottom;
              _scrollController.jumpTo(
                target.clamp(_scrollController.position.minScrollExtent,
                    _scrollController.position.maxScrollExtent),
              );
            }
          });
        } else if (state is P2PChatLoaded && !_userScrolledUp) {
          _scrollToBottom();
        }
        // Surface the ⚠️ safety warning even when the chat was opened directly
        // (not via the conversation list, which passes it through args).
        if (state is P2PChatLoaded && state.safetyWarning && !_safetyWarning) {
          setState(() {
            _safetyWarning = true;
            _safetyWarningReason = state.safetyWarningReason;
          });
        }
      },
      builder: (context, state) {
        if (state is P2PChatLoading) {
          return const Center(
            child: LazerVaultLoader.small(),
          );
        }

        if (state is P2PChatError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline,
                    size: 48.w, color: const Color(0xFFEF4444)),
                SizedBox(height: 12.h),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 16.h),
                TextButton(
                  onPressed: () =>
                      context.read<P2PChatCubit>().initializeChat(_otherUserId),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state is! P2PChatLoaded) return const SizedBox.shrink();

        if (state.messages.isEmpty) {
          final isPending = state.connectionStatus == 'pending';
          final isInitiator = state.initiatedBy == _currentUserId;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPending && isInitiator
                      ? Icons.send_rounded
                      : Icons.chat_bubble_outline,
                  size: 48.w,
                  color: const Color(0xFF9CA3AF),
                ),
                SizedBox(height: 12.h),
                Text(
                  isPending && isInitiator
                      ? 'Send a message to connect with $_otherUserName'
                      : 'Start a conversation',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                if (isPending && isInitiator) ...[
                  SizedBox(height: 4.h),
                  Text(
                    'They\'ll need to accept before you can send more',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withOpacity(0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ],
            ),
          );
        }

        // Hoisted once per build (was read TWICE per message row): the
        // authoritative id the cubit stamps onto outgoing senderId (backend
        // echoes it as sender_id), falling back to the page's auth id.
        final cubitUserId = context.read<P2PChatCubit>().currentUserId;
        final alignId = cubitUserId.isNotEmpty ? cubitUserId : _currentUserId;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              itemCount: state.messages.length +
                  (state.isLoadingMore ? 1 : 0) +
                  (_otherUserTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (state.isLoadingMore && index == 0) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: LazerVaultLoader.small(),
                    ),
                  );
                }

                final leading = state.isLoadingMore ? 1 : 0;
                // Trailing animated typing bubble (incoming side), like the
                // chatbot — shown as the last row while the other user types.
                if (_otherUserTyping &&
                    index == state.messages.length + leading) {
                  return const _TypingBubbles();
                }

                final msgIndex = index - leading;
                final message = state.messages[msgIndex];
                final isMe = message.senderId == alignId;

                // Date separator
                Widget? dateSeparator;
                if (msgIndex == 0 ||
                    !_isSameDay(message.createdAt,
                        state.messages[msgIndex - 1].createdAt)) {
                  dateSeparator = _buildDateSeparator(message.createdAt);
                }

                // System message
                if (message.isSystem) {
                  return Column(
                    children: [
                      if (dateSeparator != null) dateSeparator,
                      _buildSystemMessage(message),
                    ],
                  );
                }

                // Transfer message — replyable (swipe or long-press), like text/media.
                if (message.isTransfer) {
                  return _msgRow(
                    message.id,
                    state.highlightedMessageIds,
                    Column(
                      children: [
                        if (dateSeparator != null) dateSeparator,
                        _SwipeToReply(
                          isMe: isMe,
                          onReply: () =>
                              context.read<P2PChatCubit>().startReply(message),
                          child: GestureDetector(
                            onLongPress: () =>
                                _showMessageActions(message, isMe),
                            child: P2PTransferBubble(
                              message: message,
                              isMe: isMe,
                              otherUserName: _otherUserName,
                              otherUserId: _otherUserId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // Media message (image or voice note)
                if (message.isMedia) {
                  return _msgRow(
                    message.id,
                    state.highlightedMessageIds,
                    Column(
                      children: [
                        if (dateSeparator != null) dateSeparator,
                        _buildMediaBubble(message, isMe),
                      ],
                    ),
                  );
                }

                // Text message
                return _msgRow(
                  message.id,
                  state.highlightedMessageIds,
                  Column(
                  children: [
                    if (dateSeparator != null) dateSeparator,
                    _SwipeToReply(
                      isMe: isMe,
                      onReply: () =>
                          context.read<P2PChatCubit>().startReply(message),
                      child: GestureDetector(
                        onLongPress: () => message.deliveryStatus == 'failed'
                            ? _showRetryDialog(message)
                            : _showMessageActions(message, isMe),
                        child: P2PTextBubble(
                          message: message,
                          isMe: isMe,
                          currentUserId: alignId,
                          peerName: _otherUserName,
                          onReactionPillTap: (emoji, mine) => mine
                              ? _showEditReactionSheet(message, emoji)
                              : _showReactorSheet(emoji),
                          onRetry: message.deliveryStatus == 'failed' &&
                                  message.clientMessageId != null
                              ? () => context
                                  .read<P2PChatCubit>()
                                  .retryMessage(message.clientMessageId!)
                              : null,
                        ),
                      ),
                    ),
                  ],
                  ),
                );
              },
            ),
            // Scroll to bottom button
            if (_showScrollToBottom)
              Positioned(
                right: 16.w,
                bottom: 8.h,
                child: GestureDetector(
                  onTap: () => _scrollToBottom(force: true),
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF1F1F1F),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 24.w,
                    ),
                  ),
                ),
              ),
            // Floating emoji-burst overlay (ignores touches; purely visual).
            Positioned.fill(
              child: IgnorePointer(
                child: _EmojiStreamOverlay(key: _emojiOverlayKey),
              ),
            ),
          ],
          ),
        );
      },
    );
  }

  /// Long-press action sheet: a quick-reaction row (WhatsApp-style) plus
  /// Reply / Edit (own text, &lt;1h) / Copy.
  void _showMessageActions(P2PMessageEntity message, bool isMe) {
    final cubit = context.read<P2PChatCubit>();
    const quick = ['👍', '❤️', '😂', '😮', '😢', '🙏'];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => SafeArea(
        child: Container(
          margin: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1C),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2A2A2D)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Reaction row — quick picks + a "+" that opens the full,
              // searchable emoji grid so any emoji can be used as a reaction.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...quick.map((e) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(sheetCtx).pop();
                          cubit.reactToMessage(message.id, e);
                          _emojiOverlayKey.currentState?.burst(e);
                          cubit.sendEmojiStream(e);
                        },
                        child: Text(e, style: TextStyle(fontSize: 26.sp)),
                      );
                    }),
                    // "+" → full emoji picker
                    GestureDetector(
                      onTap: () {
                        Navigator.of(sheetCtx).pop();
                        _showFullEmojiPicker(message);
                      },
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2A2A2D),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add_rounded,
                            color: Colors.white, size: 22.sp),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFF2A2A2D)),
              _actionTile(sheetCtx, Icons.reply_rounded, 'Reply',
                  () => cubit.startReply(message)),
              _actionTile(sheetCtx, Icons.auto_awesome_rounded, 'AI reply',
                  () => _suggestAiReply(message)),
              if (!message.isTransfer && !message.isSystem)
                _actionTile(sheetCtx, Icons.forward_rounded, 'Forward',
                    () => _forwardMessage(message)),
              if (isMe && cubit.canEditMessage(message))
                _actionTile(sheetCtx, Icons.edit_rounded, 'Edit',
                    () => cubit.startEdit(message)),
              if ((message.content ?? '').isNotEmpty)
                _actionTile(sheetCtx, Icons.copy_rounded, 'Copy', () {
                  Clipboard.setData(ClipboardData(text: message.content ?? ''));
                }),
            ],
          ),
        ),
      ),
    );
  }

  /// Tapping YOUR OWN reaction reopens a focused picker to CHANGE it to another
  /// emoji or REMOVE it — the backend's single-per-user Toggle means reacting
  /// with a different emoji replaces it, and re-reacting the same one clears it.
  void _showEditReactionSheet(P2PMessageEntity message, String currentEmoji) {
    final cubit = context.read<P2PChatCubit>();
    const quick = ['👍', '❤️', '😂', '😮', '😢', '🙏'];
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => SafeArea(
        child: Container(
          margin: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1C),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2A2A2D)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 2.h),
                child: Text('Your reaction',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ...quick.map((e) {
                      final selected = e == currentEmoji;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(sheetCtx).pop();
                          // reactToMessage toggles single-per-user: a different
                          // emoji replaces mine, the same one removes it.
                          cubit.reactToMessage(message.id, e);
                          if (e != currentEmoji) {
                            _emojiOverlayKey.currentState?.burst(e);
                            cubit.sendEmojiStream(e);
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: selected
                              ? const BoxDecoration(
                                  color: Color(0xFF2A2A2D),
                                  shape: BoxShape.circle)
                              : null,
                          child: Text(e, style: TextStyle(fontSize: 26.sp)),
                        ),
                      );
                    }),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(sheetCtx).pop();
                        _showFullEmojiPicker(message);
                      },
                      child: Container(
                        width: 34.w,
                        height: 34.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2A2A2D),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add_rounded,
                            color: Colors.white, size: 22.sp),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFF2A2A2D)),
              _actionTile(sheetCtx, Icons.close_rounded, 'Remove reaction',
                  () => cubit.reactToMessage(message.id, currentEmoji)),
            ],
          ),
        ),
      ),
    );
  }

  /// Tapping the OTHER participant's reaction shows who reacted (peer name +
  /// emoji). A P2P chat has exactly two people, so the reactor of a
  /// not-mine pill is always the peer — no lookup needed.
  void _showReactorSheet(String emoji) {
    final name = _otherUserName.trim().isNotEmpty ? _otherUserName : 'They';
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => SafeArea(
        child: Container(
          margin: EdgeInsets.all(12.w),
          padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 18.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1C),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2A2A2D)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Reaction',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 14.h),
              Row(
                children: [
                  Text(emoji, style: TextStyle(fontSize: 34.sp)),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600)),
                        SizedBox(height: 2.h),
                        Text('Reacted with $emoji',
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Full, searchable emoji grid (emoji_picker_flutter) so a message can be
  /// reacted to with ANY emoji, not just the six quick picks. Styled to the
  /// dark chat theme. Selecting an emoji reacts + fires the same burst/stream
  /// as the quick row, then closes.
  void _showFullEmojiPicker(P2PMessageEntity message) {
    final cubit = context.read<P2PChatCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: SizedBox(
          height: 320.h,
          child: EmojiPicker(
            onEmojiSelected: (category, emoji) {
              Navigator.of(sheetCtx).pop();
              cubit.reactToMessage(message.id, emoji.emoji);
              _emojiOverlayKey.currentState?.burst(emoji.emoji);
              cubit.sendEmojiStream(emoji.emoji);
            },
            config: Config(
              height: 320.h,
              emojiViewConfig: EmojiViewConfig(
                backgroundColor: const Color(0xFF1A1A1C),
                columns: 8,
                emojiSizeMax: 28.sp,
              ),
              categoryViewConfig: const CategoryViewConfig(
                backgroundColor: Color(0xFF1A1A1C),
                iconColor: Color(0xFF9CA3AF),
                iconColorSelected: Color(0xFF8B5CF6),
                indicatorColor: Color(0xFF8B5CF6),
                dividerColor: Color(0xFF2A2A2D),
              ),
              bottomActionBarConfig: const BottomActionBarConfig(
                backgroundColor: Color(0xFF1A1A1C),
                buttonColor: Color(0xFF2A2A2D),
                buttonIconColor: Colors.white,
              ),
              searchViewConfig: const SearchViewConfig(
                backgroundColor: Color(0xFF1A1A1C),
                buttonIconColor: Color(0xFF9CA3AF),
                hintText: 'Search emoji',
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// AI reply: opens a bottom sheet that shows a loader IN THE SHEET while the
  /// dedicated fast draft-reply endpoint (grounded in this conversation's
  /// history — not a welcome message) drafts a reply, then swaps to an EDITABLE
  /// draft the user approves/edits before sending. Cancelling during the load
  /// closes the sheet (the pending request is ignored). Nothing sends without
  /// tapping Send.
  Future<void> _suggestAiReply(P2PMessageEntity message) async {
    final cubit = context.read<P2PChatCubit>();
    final controller = TextEditingController();
    var loading = true;
    var started = false;
    String? error;
    var closed = false;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return StatefulBuilder(
          builder: (sheetCtx, setSheet) {
            // Kick off the draft once, when the sheet first builds — so the
            // loader renders IN the sheet (not on the page).
            if (!started) {
              started = true;
              // Reply specifically to the long-pressed (target) message, using
              // the history BEFORE it as context.
              cubit.draftAiReply(targetMessageId: message.id).then((reply) {
                if (closed || !sheetCtx.mounted) return;
                controller.text = reply;
                setSheet(() {
                  loading = false;
                  error = null;
                });
              }).catchError((_) {
                if (closed || !sheetCtx.mounted) return;
                setSheet(() {
                  loading = false;
                  error = 'Could not draft a reply. Please try again.';
                });
              });
            }

            Widget body;
            if (loading) {
              body = Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 8.h),
                  const CircularProgressIndicator(color: Color(0xFF7C3AED)),
                  SizedBox(height: 14.h),
                  Text('Drafting a reply from your chat…',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
                  SizedBox(height: 16.h),
                  OutlinedButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF2A2A2D)),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 24.w),
                    ),
                    child: const Text('Cancel',
                        style: TextStyle(color: Color(0xFF9CA3AF))),
                  ),
                ],
              );
            } else if (error != null) {
              body = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(error!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
                  SizedBox(height: 14.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetCtx).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2A2A2D)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: const Text('Close',
                              style: TextStyle(color: Color(0xFF9CA3AF))),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => setSheet(() {
                            error = null;
                            loading = true;
                            started = false; // re-kick on next build
                          }),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: const Text('Try again',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              body = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome_rounded,
                          color: Color(0xFF7C3AED), size: 18),
                      SizedBox(width: 8.w),
                      Text('AI suggested reply',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text('Review and edit before sending.',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: controller,
                    maxLines: 5,
                    minLines: 1,
                    autofocus: true,
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFF111113),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Color(0xFF2A2A2D)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: Color(0xFF2A2A2D)),
                      ),
                      contentPadding: EdgeInsets.all(12.w),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(sheetCtx).pop(),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF2A2A2D)),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: const Text('Cancel',
                              style: TextStyle(color: Color(0xFF9CA3AF))),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            final text = controller.text.trim();
                            Navigator.of(sheetCtx).pop();
                            if (text.isNotEmpty) cubit.sendMessage(text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7C3AED),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          icon: const Icon(Icons.send_rounded,
                              color: Colors.white, size: 16),
                          label: const Text('Send',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 16.h,
                bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 16.h,
              ),
              child: body,
            );
          },
        );
      },
    );
    closed = true;
  }

  /// Forward a message to another Lazervault user. Opens the shared unified
  /// recipient picker (Lazervault users only), then forwards the message's text
  /// or media (media reuses the existing URL — no re-upload) with a "Forwarded"
  /// marker via the cubit. Sending to a DIFFERENT conversation is resolved by
  /// getOrCreateConversation inside the cubit.
  Future<void> _forwardMessage(P2PMessageEntity message) async {
    final cubit = context.read<P2PChatCubit>();
    final picked = await UnifiedUserSearchSheet.show(
      context,
      title: 'Forward to',
      subtitle: 'Choose who to forward this message to',
      internalOnly: true,
    );
    if (picked == null || picked.userId.isEmpty) return;
    if (!mounted) return;
    final count = await cubit.forwardMessages([picked.userId], [message]);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(count > 0
            ? 'Forwarded to ${picked.displayName}'
            : 'Could not forward the message.'),
      ),
    );
  }

  Widget _actionTile(
      BuildContext sheetCtx, IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Colors.white, size: 20.w),
      title: Text(label,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
      onTap: () {
        Navigator.of(sheetCtx).pop();
        onTap();
      },
    );
  }

  /// Render an image or voice-note message bubble, aligned by sender. Reuses
  /// the shared [ChatMediaBubble] (image thumbnail + just_audio player).
  Widget _buildMediaBubble(P2PMessageEntity message, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: _SwipeToReply(
        isMe: isMe,
        onReply: () => context.read<P2PChatCubit>().startReply(message),
        child: GestureDetector(
        onLongPress: () => message.deliveryStatus == 'failed' &&
                message.clientMessageId != null
            ? context
                .read<P2PChatCubit>()
                .retryMediaMessage(message.clientMessageId!)
            : _showMessageActions(message, isMe),
        onTap: message.isImage &&
                (message.mediaUrl != null && message.mediaUrl!.isNotEmpty)
            ? () => _openFullImage(message.mediaUrl!)
            : null,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
          padding: EdgeInsets.all(6.w),
          constraints: BoxConstraints(maxWidth: 260.w),
          decoration: BoxDecoration(
            color: isMe
                ? const Color(0xFF3B82F6).withOpacity(0.18)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: const Color(0xFF2D2D2D), width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ChatMediaBubble(
                mediaType: message.mediaType,
                mediaUrl: message.mediaUrl,
                localMediaPath: message.localMediaPath,
                isUser: isMe,
              ),
              // Caption attached to an image before sending.
              if (message.isImage && (message.content ?? '').trim().isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 2.w, right: 2.w),
                  child: Text(
                    message.content!.trim(),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      height: 1.35,
                    ),
                  ),
                ),
              if (message.deliveryStatus == 'sending')
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 2.w),
                  child: Text(
                    'Uploading...',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 10.sp,
                    ),
                  ),
                )
              else if (message.deliveryStatus == 'failed')
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 2.w),
                  child: Text(
                    'Failed — long-press to retry',
                    style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      ),
    );
  }

  /// Open a full-screen view of an image message.
  void _openFullImage(String url) {
    // Use the shared full-screen viewer (pinch-zoom, swipe-to-dismiss, and the
    // save-to-gallery download button) rather than a bespoke dialog, so P2P chat
    // images get the same download affordance as everywhere else.
    FullScreenImageViewer.open(context, mediaUrl: url);
  }

  Widget _buildInputArea() {
    return BlocBuilder<P2PChatCubit, P2PChatState>(
      builder: (context, state) {
        final canSend = state is P2PChatLoaded && state.canSendMessage;
        final isLoaded = state is P2PChatLoaded;

        if (state is P2PChatLoaded &&
            state.connectionStatus == 'pending' &&
            !state.canSendMessage) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              border: Border(
                top: BorderSide(
                  color: const Color(0xFF2D2D2D),
                  width: 1,
                ),
              ),
            ),
            child: Text(
              '$_otherUserName needs to reply before you can send more messages.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
              ),
            ),
          );
        }

        final replyingTo = isLoaded ? state.replyingTo : null;
        final editing = isLoaded ? state.editingMessage : null;
        final cubit = context.read<P2PChatCubit>();

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (replyingTo != null)
              _buildReplyEditBanner(
                icon: Icons.reply_rounded,
                title: replyingTo.senderId == _currentUserId
                    ? 'Replying to yourself'
                    : 'Replying to $_otherUserName',
                subtitle: _snippetOf(replyingTo),
                onClose: cubit.cancelReply,
              ),
            if (editing != null)
              _buildReplyEditBanner(
                icon: Icons.edit_rounded,
                title: 'Editing message',
                subtitle: _snippetOf(editing),
                onClose: cubit.cancelEdit,
              ),
            P2PChatInputBar(
              // Re-seed the field only when the edit target changes.
              key: ValueKey('composer-${editing?.id ?? 'new'}'),
              enabled: isLoaded && canSend,
              isEditing: editing != null,
              prefill: editing?.content,
              onEmojiBurst: (emoji) {
                _emojiOverlayKey.currentState?.burst(emoji);
                cubit.sendEmojiStream(emoji);
              },
              onSend: (content) {
                if (editing != null) {
                  cubit.commitEdit(content, messageId: editing.id);
                } else {
                  cubit.sendMessage(content);
                  _scrollToBottom(force: true);
                }
              },
              onSendMedia: (mediaType, localFilePath, contentType,
                  [caption]) {
                cubit.sendMediaMessage(
                  mediaType: mediaType,
                  localFilePath: localFilePath,
                  contentType: contentType,
                  caption: caption,
                );
                _scrollToBottom(force: true);
              },
              onTypingChanged: (isTyping) {
                cubit.sendTyping(isTyping);
              },
            ),
          ],
        );
      },
    );
  }

  String _snippetOf(P2PMessageEntity m) {
    final c = (m.content ?? '').trim();
    if (c.isNotEmpty) return c;
    if (m.isImage) return '📷 Photo';
    if (m.isVoice) return '🎤 Voice note';
    if (m.isTransfer) return m.transferSnippet;
    return '';
  }

  Widget _buildReplyEditBanner({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onClose,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(14.w, 8.h, 8.w, 8.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1A1A1C),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D), width: 0.5),
          left: BorderSide(color: Color(0xFF7C3AED), width: 3),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.w, color: const Color(0xFF7C3AED)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: const Color(0xFF7C3AED),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 1.h),
                Text(subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
              ],
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: Padding(
              padding: EdgeInsets.all(6.w),
              child: Icon(Icons.close_rounded,
                  size: 18.w, color: const Color(0xFF9CA3AF)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(DateTime date) {
    String label;
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      label = 'Today';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      label = 'Yesterday';
    } else {
      label = DateFormat('MMMM d, yyyy').format(date);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 11.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSystemMessage(P2PMessageEntity message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            message.content ?? '',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  void _showRetryDialog(P2PMessageEntity message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Message failed to send',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (message.clientMessageId != null) {
                context
                    .read<P2PChatCubit>()
                    .retryMessage(message.clientMessageId!);
              }
            },
            child: Text(
              'Retry',
              style: GoogleFonts.inter(color: const Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

/// Horizontal swipe-to-reply wrapper (WhatsApp-style). Dragging a bubble toward
/// the center reveals a reply icon; releasing past a threshold fires [onReply]
/// and springs the bubble back.
class _SwipeToReply extends StatefulWidget {
  final Widget child;
  final bool isMe;
  final VoidCallback onReply;
  const _SwipeToReply({
    required this.child,
    required this.isMe,
    required this.onReply,
  });

  @override
  State<_SwipeToReply> createState() => _SwipeToReplyState();
}

class _SwipeToReplyState extends State<_SwipeToReply> {
  double _dx = 0;
  static const double _threshold = 56;
  bool _triggered = false;

  @override
  Widget build(BuildContext context) {
    // Every bubble — MY messages and the other user's alike — swipes RIGHT
    // (drag positive) to reply, WhatsApp-style. The reply icon is revealed on
    // the left as the bubble slides right.
    final progress = (_dx.abs() / _threshold).clamp(0.0, 1.0);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (d) {
        final next = _dx + d.delta.dx;
        // Right-swipe only, regardless of sender.
        final clamped = next.clamp(0.0, 90.0);
        setState(() => _dx = clamped);
        if (!_triggered && _dx.abs() >= _threshold) {
          _triggered = true;
          HapticFeedback.selectionClick();
        }
      },
      onHorizontalDragEnd: (_) {
        if (_dx.abs() >= _threshold) widget.onReply();
        setState(() {
          _dx = 0;
          _triggered = false;
        });
      },
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Opacity(
              opacity: progress,
              child: Icon(Icons.reply_rounded,
                  size: 20.w, color: const Color(0xFF7C3AED)),
            ),
          ),
          Transform.translate(
            offset: Offset(_dx, 0),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

/// Animated three-dot "typing…" bubble on the incoming (left) side — mirrors
/// the chatbot's typing indicator.
class _TypingBubbles extends StatefulWidget {
  const _TypingBubbles();
  @override
  State<_TypingBubbles> createState() => _TypingBubblesState();
}

class _TypingBubblesState extends State<_TypingBubbles>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c =
      AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))
        ..repeat();

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(top: 2.h, bottom: 2.h, right: 48.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(16.r),
          ),
        ),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) {
                // Each dot bounces on a staggered phase.
                final phase = (_c.value + i * 0.2) % 1.0;
                final t = (phase < 0.5 ? phase : 1 - phase) * 2; // 0..1..0
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                  child: Transform.translate(
                    offset: Offset(0, -3.h * t),
                    child: Container(
                      width: 7.w,
                      height: 7.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.4 + 0.5 * t),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}

/// Overlay that animates ephemeral floating emojis rising + fading over the
/// chat (WhatsApp/IG-style). Call [burst] to spawn a small cluster.
class _EmojiStreamOverlay extends StatefulWidget {
  const _EmojiStreamOverlay({super.key});
  @override
  State<_EmojiStreamOverlay> createState() => _EmojiStreamOverlayState();
}

class _EmojiStreamOverlayState extends State<_EmojiStreamOverlay> {
  final List<_FloatingEmoji> _items = [];
  int _seq = 0;

  void burst(String emoji) {
    if (!mounted || emoji.isEmpty) return;
    // Spawn a few emojis with slightly varied horizontal offsets + delays.
    for (var i = 0; i < 5; i++) {
      final id = _seq++;
      final dxFactor = 0.30 + 0.40 * (i / 4); // spread across lower area
      final size = 22.0 + (i.isEven ? 6.0 : 0.0);
      final item = _FloatingEmoji(id: id, emoji: emoji, dxFactor: dxFactor, size: size);
      setState(() => _items.add(item));
      Future.delayed(Duration(milliseconds: 1500 + i * 40), () {
        if (mounted) setState(() => _items.removeWhere((e) => e.id == id));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) return const SizedBox.shrink();
    return LayoutBuilder(builder: (context, c) {
      return Stack(
        children: _items.map((e) {
          return TweenAnimationBuilder<double>(
            key: ValueKey(e.id),
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOut,
            builder: (context, t, _) {
              final bottom = c.maxHeight * 0.15 + (c.maxHeight * 0.7) * t;
              final left = c.maxWidth * e.dxFactor +
                  8 * (t * 6.28).clamp(0, 6.28); // slight sway
              return Positioned(
                bottom: bottom,
                left: left,
                child: Opacity(
                  opacity: (1.0 - t).clamp(0.0, 1.0),
                  child: Text(e.emoji, style: TextStyle(fontSize: e.size)),
                ),
              );
            },
          );
        }).toList(),
      );
    });
  }
}

class _FloatingEmoji {
  final int id;
  final String emoji;
  final double dxFactor;
  final double size;
  const _FloatingEmoji({
    required this.id,
    required this.emoji,
    required this.dxFactor,
    required this.size,
  });
}

/// Per-chat sound + vibration overrides, shown in the peer's profile sheet.
/// Each switch reflects the *effective* value (per-chat override, else global);
/// toggling records a per-chat override. A "Use global default" reset appears
/// once any override is set, so a conversation can fall back to the global
/// preference edited from the general Settings page.
class _ChatNotificationSettings extends StatefulWidget {
  final String conversationId;
  const _ChatNotificationSettings({required this.conversationId});

  @override
  State<_ChatNotificationSettings> createState() =>
      _ChatNotificationSettingsState();
}

class _ChatNotificationSettingsState extends State<_ChatNotificationSettings> {
  ChatSoundSettings get _s => ChatSoundSettings.instance;

  bool get _hasOverride =>
      _s.soundOverrideFor(widget.conversationId) != null ||
      _s.vibrateOverrideFor(widget.conversationId) != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.notifications_none_rounded,
                color: const Color(0xFF9CA3AF), size: 16.sp),
            SizedBox(width: 8.w),
            Text(
              'Sound & vibration for this chat',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Text(
          'Plays when you send and when you receive a message.',
          style: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF232326),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            children: [
              _row(
                icon: Icons.volume_up_rounded,
                label: 'Message sound',
                value: _s.soundEnabledFor(widget.conversationId),
                onChanged: (v) async {
                  await _s.setChatSound(widget.conversationId, v);
                  if (mounted) setState(() {});
                },
              ),
              Divider(
                  height: 1, color: const Color(0xFF2D2D2D), indent: 12.w),
              _row(
                icon: Icons.vibration_rounded,
                label: 'Vibration',
                value: _s.vibrateEnabledFor(widget.conversationId),
                onChanged: (v) async {
                  await _s.setChatVibrate(widget.conversationId, v);
                  if (mounted) setState(() {});
                },
              ),
            ],
          ),
        ),
        if (_hasOverride)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () async {
                await _s.setChatSound(widget.conversationId, null);
                await _s.setChatVibrate(widget.conversationId, null);
                if (mounted) setState(() {});
              },
              child: Text(
                'Use global default',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 18.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF3B82F6),
          ),
        ],
      ),
    );
  }
}
