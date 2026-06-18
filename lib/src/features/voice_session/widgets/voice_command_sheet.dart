import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_chat_history_cubit.dart';
import 'package:lazervault/src/features/voice_session/models/voice_language.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_language_picker.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_customization_sheet.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_user_search_dialog.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_transfer_summary_card.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_chat_history_sheet.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_transfer_hud.dart';
import 'package:lazervault/src/features/voice_session/models/voice_conversation.dart';
import 'package:lazervault/src/features/voice_session/models/voice_transfer_context.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/voice/cubit/per_service_voice_settings_cubit.dart';
import 'package:lazervault/src/features/voice/screens/per_service_voice_settings_screen.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class VoiceCommandSheet extends StatefulWidget {
  final String? serviceName;
  final bool skipActivationCheck;

  const VoiceCommandSheet({
    super.key,
    this.serviceName,
    this.skipActivationCheck = false,
  });

  @override
  State<VoiceCommandSheet> createState() => _VoiceCommandSheetState();
}

class _VoiceCommandSheetState extends State<VoiceCommandSheet>
    with TickerProviderStateMixin, WidgetsBindingObserver, TransactionPinMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _glowController;
  // Avatar speaking/listening pulse — drives the glow ring + gentle scale
  // around the Nova customer-rep avatar.
  late AnimationController _avatarController;
  final VoiceActivationManager _voiceActivationManager = VoiceActivationManager();

  /// Canonical PIN service for [TransactionPinMixin]. Same instance the chat
  /// path uses, so voice + chat share lockout counters + single-use tokens.
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  bool _isDialogShowing = false;
  // Guards against re-entrant PIN sheet launches. The PIN bottom sheet
  // (TransactionPinMixin) presents its own modal route; this flag keeps a
  // second VoiceSessionPinRequired emit (e.g. a caption re-emit) from
  // stacking a duplicate sheet.
  bool _isPinSheetShowing = false;
  // Safety net for [_isPinSheetShowing]: if a PIN sheet's await stalls (or a
  // stale VoiceSessionPinRequired arrives while one is showing), this timer
  // force-clears the re-entrancy flag so future PIN sheets are never blocked.
  Timer? _pinSheetTimeoutTimer;
  bool _isCheckingEnrollment = true;
  bool _isMuted = false;
  bool _isClosing = false;
  // Expand the sheet to full screen (mirrors the ai_chat send-funds chatbot
  // fullscreen toggle). Drives the DraggableScrollableController. Defaults to
  // TRUE — the sheet opens fullscreen and can only minimise to 90%.
  bool _isFullScreen = false;
  // Tiny-CTA toggle for the live captions overlay. Captions default ON (the
  // in-progress "speaking…" bubble is the primary realtime feedback). The
  // running transcript history is ALWAYS shown (it accumulates + scrolls); the
  // forum chip is a shortcut to the fuller standalone history sheet, not a
  // show/hide toggle, so there is no _showHistory flag any more.
  bool _showCaptions = true;
  // Conversation display mode, toggled by the chat (forum) chip:
  //  • true  = CONTINUOUS — the whole session transcript shows + scrolls in realtime.
  //  • false = EPHEMERAL  — only the current user→AI cycle is shown; it's replaced
  //    by the next cycle (older turns disappear).
  bool _continuousChat = true;
  final DraggableScrollableController _dragController =
      DraggableScrollableController();
  final ScrollController _conversationScrollController = ScrollController();
  int _selectedRating = 0;
  bool _isSubmittingRating = false;
  bool _ratingSubmitted = false;
  // One-shot guard so the biometric low-confidence warning modal shows once
  // per session rather than re-popping if the event repeats.
  bool _lowConfidenceWarned = false;
  final TextEditingController _feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Avatar pulse — repeats while the agent speaks / user listens. Started/
    // stopped from the BlocConsumer alongside the orb animations.
    _avatarController = AnimationController(
      duration: const Duration(milliseconds: 1100),
      vsync: this,
    );

    // Reset cubit state if it was disconnected (allows reconnection)
    _resetIfNeeded();

    _checkVoiceActivation();
  }

  /// Reset the cubit state if we're in a disconnected state
  /// This allows reconnection when the voice sheet is reopened
  void _resetIfNeeded() {
    final cubit = context.read<VoiceSessionCubit>();
    final state = cubit.state;
    print('VoiceCommandSheet: Checking if reset needed, current state: ${state.runtimeType}');

    // Reset if we're in a disconnected state to allow fresh connection
    if (state is VoiceSessionDisconnected) {
      print('VoiceCommandSheet: Resetting disconnected state');
      cubit.resetSessionState();
    }
  }

  Future<void> _checkVoiceActivation() async {
    // If the caller already confirmed enrollment (e.g. dashboard_header),
    // skip the activation check and proceed directly to the voice session.
    if (widget.skipActivationCheck) {
      print('VoiceCommandSheet: Skipping activation check (already confirmed)');
      if (mounted) {
        setState(() => _isCheckingEnrollment = false);
        _proceedAfterEnrollment();
      }
      return;
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      if (mounted) setState(() => _isCheckingEnrollment = false);
      return;
    }

    final userId = authState.profile.userId;
    print('VoiceCommandSheet: Checking voice activation for user $userId');

    // First check if voice service is available
    final isServiceAvailable = await _voiceActivationManager.isServiceAvailable();
    if (!isServiceAvailable) {
      print('VoiceCommandSheet: Voice service unavailable');
      if (mounted) {
        setState(() => _isCheckingEnrollment = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Voice service is not running. Please start the services with ./start_all_local_no_docker.sh'),
            backgroundColor: const Color(0xFFEF4444),
            duration: const Duration(seconds: 5),
          ),
        );
        // Close sheet after showing error
        Future.delayed(const Duration(seconds: 5), () {
          if (mounted) Navigator.of(context).pop();
        });
      }
      return;
    }

    try {
      final activated = await _voiceActivationManager.activateVoice(
        context,
        userId,
        onSuccess: () {
          if (mounted) {
            setState(() => _isCheckingEnrollment = false);
            _proceedAfterEnrollment();
          }
        },
      );

      if (!activated && mounted) {
        // User cancelled enrollment or dismissed prompt - close the sheet
        print('VoiceCommandSheet: Activation not completed, closing sheet');
        setState(() => _isCheckingEnrollment = false);
        Navigator.of(context).pop();
      }
    } catch (e) {
      // Show error to user if enrollment check fails
      print('VoiceCommandSheet: Error during activation check: $e');
      if (mounted) {
        setState(() => _isCheckingEnrollment = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Voice activation error: $e'),
            backgroundColor: const Color(0xFFEF4444),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Close',
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        );
      }
    }
  }

  void _resetMuteState() {
    if (_isMuted) {
      setState(() => _isMuted = false);
    }
  }

  /// Close the bottom sheet safely — disconnect session, stop recording, dismiss dialogs, pop sheet.
  /// Guarded against being called multiple times.
  void _closeSheet() {
    if (_isClosing) return;
    _isClosing = true;

    // End the voice session (stops recording, disconnects LiveKit, cleans up)
    final cubit = context.read<VoiceSessionCubit>();
    cubit.disconnectFromLiveKitRoom(fullCleanup: true);

    // Dismiss any active dialog first
    _dismissActiveDialog();

    // Pop the bottom sheet — navigates back to whatever screen opened it (typically dashboard)
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// End the call and show the rating/thank-you screen.
  void _endCall() {
    if (_isClosing) return;
    _dismissActiveDialog();
    _resetMuteState();
    // Reset rating state for fresh view
    _selectedRating = 0;
    _isSubmittingRating = false;
    _ratingSubmitted = false;
    _feedbackController.clear();
    context.read<VoiceSessionCubit>().endSession();
  }

  /// End the call with a failure reason displayed on the ended screen.
  void _endCallWithReason(String reason) {
    if (_isClosing) return;
    _dismissActiveDialog();
    _resetMuteState();
    _selectedRating = 0;
    _isSubmittingRating = false;
    _ratingSubmitted = false;
    _feedbackController.clear();
    context.read<VoiceSessionCubit>().endSession(endReason: reason);
  }

  /// Start a new call from the ended screen.
  void _startNewCall() {
    if (_isClosing) return; // Prevent starting new call while closing
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;
    // Reset local state
    _isClosing = false;
    _isDialogShowing = false;
    _isMuted = false;
    _selectedRating = 0;
    _isSubmittingRating = false;
    _ratingSubmitted = false;
    _feedbackController.clear();
    context.read<VoiceSessionCubit>().startNewSession(
      accessToken: authState.profile.session.accessToken,
    );
  }

  Future<void> _proceedAfterEnrollment() async {
    final cubit = context.read<VoiceSessionCubit>();
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    // Check if we need to reconnect (cubit might be in disconnected state)
    final currentState = cubit.state;
    print('VoiceCommandSheet: Current cubit state: ${currentState.runtimeType}');

    // Load language preferences and available languages
    final userCountry = authState.profile.user.country ?? 'NG';
    await cubit.loadLanguagePreferences(userCountry);

    if (!cubit.hasLanguageSelected) {
      // Show language selection
      cubit.showLanguageSelection();
    } else {
      // Language already selected, start session
      print('VoiceCommandSheet: Starting voice session with language ${cubit.selectedLanguageCode}');
      _startVoiceSession(authState.profile.session.accessToken);
    }
  }

  void _startVoiceSession(String? token) {
    if (token == null || token.isEmpty) return;
    context.read<VoiceSessionCubit>().startVoiceSession(
      accessToken: token,
      serviceName: widget.serviceName,
    );
  }

  void _onLanguageSelected(VoiceLanguage language) async {
    final cubit = context.read<VoiceSessionCubit>();
    await cubit.setLanguage(language.code);

    // Show voice picker if language has voices to choose from
    if (language.availableVoices.isNotEmpty && mounted) {
      final selected = await VoiceCustomizationSheet.show(
        context,
        voices: language.availableVoices,
        selectedVoiceId: cubit.selectedVoiceId,
        provider: language.provider,
      );
      if (selected != null && mounted) {
        await cubit.setVoice(selected.id);
      }
    }

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) return;

    _startVoiceSession(authState.profile.session.accessToken);
  }

  void _showLanguagePicker() async {
    final cubit = context.read<VoiceSessionCubit>();
    final selected = await VoiceLanguagePicker.show(
      context,
      languages: cubit.availableLanguages,
      selectedLanguageCode: cubit.selectedLanguageCode,
    );
    if (selected != null && mounted) {
      _onLanguageSelected(selected);
    }
  }

  void _showVoiceCustomization() async {
    final cubit = context.read<VoiceSessionCubit>();
    final lang = cubit.selectedLanguage;
    if (lang == null || !lang.supportsVoiceCustomization) return;

    final selected = await VoiceCustomizationSheet.show(
      context,
      voices: lang.availableVoices,
      selectedVoiceId: cubit.selectedVoiceId,
      provider: lang.provider,
    );
    if (selected != null && mounted) {
      await cubit.setVoice(selected.id);
    }
  }

  void _startAnimations() {
    if (!_pulseController.isAnimating) _pulseController.repeat(reverse: true);
    if (!_waveController.isAnimating) _waveController.repeat();
    if (!_glowController.isAnimating) _glowController.repeat(reverse: true);
    if (!_avatarController.isAnimating) _avatarController.repeat(reverse: true);
  }

  void _stopAnimations() {
    _pulseController.stop();
    _waveController.stop();
    _glowController.stop();
    _avatarController.stop();
  }

  /// Toggle the sheet between 90% height and full screen, mirroring the
  /// send-funds chatbot's fullscreen toggle.
  void _toggleFullScreen() {
    setState(() => _isFullScreen = !_isFullScreen);
    final target = _isFullScreen ? 1.0 : 0.9;
    if (_dragController.isAttached) {
      _dragController.animateTo(
        target,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Coalesces rapid auto-scroll requests so the stream of interim caption
  /// rebuilds (one per word) doesn't queue a new animation on every frame.
  bool _autoScrollScheduled = false;

  /// Auto-scroll the conversation area to the newest message/caption.
  ///
  /// Called both on new finalized turns and on every live-caption growth. To
  /// avoid fighting the rapid interim rebuilds (which emit many times per
  /// second), we schedule at most one post-frame scroll at a time and jump
  /// instantly while content is still streaming in — animating per chunk would
  /// stutter. The single post-frame callback runs AFTER the new content is laid
  /// out, so maxScrollExtent already includes the latest bubble.
  void _scrollConversationToBottom() {
    if (_autoScrollScheduled) return;
    _autoScrollScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoScrollScheduled = false;
      if (!_conversationScrollController.hasClients) return;
      final target = _conversationScrollController.position.maxScrollExtent;
      // Already pinned to (near) the bottom — nothing to do. This also lets a
      // user who has scrolled UP to read older turns stay put instead of being
      // yanked down on every interim caption tick.
      final offset = _conversationScrollController.offset;
      if ((target - offset).abs() < 4) return;
      // If the user has deliberately scrolled up more than ~120px from the
      // bottom, respect that and don't auto-follow; otherwise keep pinned.
      if (target - offset > 120) return;
      _conversationScrollController.jumpTo(target);
    });
  }

  /// Handle app lifecycle changes — mute mic when backgrounded, end session if killed
  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) {
    if (lifecycleState == AppLifecycleState.paused) {
      // Mute microphone when app goes to background (privacy + quality)
      final cubit = context.read<VoiceSessionCubit>();
      if (cubit.isConnected && !cubit.isMuted) {
        cubit.toggleMute();
        if (mounted) setState(() => _isMuted = true);
      }
    } else if (lifecycleState == AppLifecycleState.resumed) {
      // Unmute when returning to foreground
      final cubit = context.read<VoiceSessionCubit>();
      if (cubit.isConnected && cubit.isMuted) {
        cubit.toggleMute();
        if (mounted) setState(() => _isMuted = false);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pinSheetTimeoutTimer?.cancel();
    _dismissActiveDialog();
    _feedbackController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _glowController.dispose();
    _avatarController.dispose();
    _dragController.dispose();
    _conversationScrollController.dispose();
    // Only disconnect if not already closing (avoids double disconnect)
    if (!_isClosing) {
      context.read<VoiceSessionCubit>().disconnectFromLiveKitRoom(fullCleanup: true);
    }
    super.dispose();
  }

  /// Wrap the static (non-draggable) sub-views at full screen height so they
  /// match the main session sheet, which now opens FULLSCREEN by default
  /// (the draggable sheet only minimises to 90%).
  Widget _sizedSheet(Widget child) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Show enrollment check screen while verifying voice registration
    if (_isCheckingEnrollment) {
      return _sizedSheet(_buildEnrollmentCheckView());
    }

    return BlocConsumer<VoiceSessionCubit, VoiceSessionState>(
      listener: (context, state) {
        if (state is VoiceSessionLanguageSelection) {
          // Language selection is handled in the builder
        } else if (state is VoiceSessionCredentialsLoaded) {
          context.read<VoiceSessionCubit>().connectToLiveKitRoom(
                state.roomName,
                state.livekitToken,
                state.livekitUrl,
              );
        } else if (state is VoiceSessionCredentialsError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        } else if (state is VoiceSessionDisconnected) {
          // Dismiss any open dialogs when room disconnects
          _dismissActiveDialog();
          _resetMuteState();
        } else if (state is VoiceSessionError) {
          _dismissActiveDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        } else if (state is VoiceSessionVerificationFailed) {
          _dismissActiveDialog();
          // Show snackbar immediately for visibility
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              duration: const Duration(seconds: 4),
            ),
          );
          // Also surface the reason on the call-ended screen
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) _endCallWithReason(state.message);
          });
        } else if (state is VoiceSessionMicPermissionDenied) {
          // Handled in UI — no snackbar
        } else if (state is VoiceSessionUserSearchRequired) {
          _showUserSearchDialog(context, state.users, state.query);
        } else if (state is VoiceSessionTransferConfirmation) {
          _showTransferSummaryDialog(context, state.transferDetails);
        } else if (state is VoiceSessionPinRequired) {
          _showPinEntrySheet(state.transactionPayload);
        } else if (state is VoiceSessionTransactionSuccess) {
          final ref = state.result['reference'] as String? ?? '';
          final success = state.result['success'] as bool? ?? true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(success
                  ? 'Transfer completed! Ref: $ref'
                  : 'Transfer failed: ${state.result['error'] ?? 'Unknown error'}'),
              backgroundColor: success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
            ),
          );
        } else if (state is VoiceSessionTransactionError) {
          _dismissActiveDialog();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              duration: const Duration(seconds: 4),
            ),
          );
        } else if (state is VoiceSessionWebSocketFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Visual feedback unavailable. Voice commands still work.'),
              backgroundColor: Color(0xFFFB923C),
              duration: Duration(seconds: 4),
            ),
          );
        } else if (state is VoiceSessionLanguageChanged) {
          // Mid-conversation language switch — show brief indicator
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Language: ${state.language.toUpperCase()}'),
              backgroundColor: const Color(0xFF3B82F6),
              duration: const Duration(seconds: 2),
            ),
          );
        } else if (state is VoiceSessionLanguageCoerced) {
          // Admin blocked the requested language at session start. Tell the
          // user we are continuing in the effective language instead of
          // silently switching them.
          final from = _voiceLanguageLabel(state.coercedFrom);
          final to = _voiceLanguageLabel(state.effectiveLanguage);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$from is not available right now. Continuing in $to.'),
              backgroundColor: const Color(0xFFFB923C),
              duration: const Duration(seconds: 4),
            ),
          );
        } else if (state is VoiceSessionLowConfidenceWarning) {
          // Admin policy = warn: surface a modal so the user knows their
          // voice could not be confidently verified, but the session
          // continues (the 'exit' policy instead ends the call).
          if (!_lowConfidenceWarned) {
            _lowConfidenceWarned = true;
            _showLowConfidenceWarningDialog(context, state.message);
          }
        }

        // Keep the inline conversation pinned to the newest message/caption.
        _scrollConversationToBottom();

        // Manage animations based on state
        if (state is VoiceSessionConnected ||
            state is VoiceSessionLocalUserSpeaking ||
            state is VoiceSessionAgentProcessing ||
            state is VoiceSessionLocalUserNotSpeaking ||
            state is VoiceSessionLanguageChanged ||
            state is VoiceSessionUserSearchRequired ||
            state is VoiceSessionTransferConfirmation ||
            state is VoiceSessionPinRequired ||
            state is VoiceSessionTransactionSuccess ||
            state is VoiceSessionTransactionError ||
            state is VoiceSessionWebSocketFailed ||
            state is VoiceSessionLowConfidenceWarning) {
          _startAnimations();
        } else if (state is VoiceSessionEnded ||
            state is VoiceSessionDisconnected) {
          // Stop on teardown/disconnect so the avatar + pulse controllers don't
          // keep spinning across reconnect loops. _startAnimations re-arms them
          // cleanly on the next connected/active state.
          _stopAnimations();
        } else if (state is! VoiceSessionLanguageSelection) {
          _stopAnimations();
        }
      },
      builder: (context, state) {
        // Language selection screen
        if (state is VoiceSessionLanguageSelection) {
          return _sizedSheet(_buildLanguageSelectionView(state));
        }

        // Call ended / rating screen
        if (state is VoiceSessionEnded) {
          return _sizedSheet(_buildCallEndedView(state));
        }

        // Main voice session UI — self-sizing draggable sheet (90% → full
        // screen), mirroring the send-funds chatbot. Clean vertical layout:
        //   TOP    = compact header (avatar + Nova + status + controls)
        //   MIDDLE = single scrollable conversation/transcript + live caption
        //   BOTTOM = action bar (mute / end)
        return DraggableScrollableSheet(
          controller: _dragController,
          // Opens FULLSCREEN by default; can only minimise to 90% (snaps
          // between 0.9 and 1.0 — the sheet owns its own height).
          initialChildSize: 0.9,
          minChildSize: 0.9,
          maxChildSize: 1.0,
          expand: false,
          snap: true,
          snapSizes: const [0.9, 1.0],
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF15121F),
                    Color(0xFF0D0D0F),
                    Color(0xFF050507),
                  ],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
                border: Border.all(
                  color: const Color(0xFF3D2F8B).withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  children: [
                    // Drag handle — also the implicit drag target for the sheet
                    SingleChildScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Container(
                        width: 36.w,
                        height: 4.h,
                        margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),

                    // Compact header: avatar + Nova + live status + controls
                    _buildSessionHeader(state),

                    Divider(
                      color: const Color(0xFF2D2D2D),
                      height: 1,
                      thickness: 1,
                    ),

                    // Conversation / transcript area (scrollable, fills space)
                    Expanded(
                      child: _buildConversationArea(state),
                    ),

                    // Bottom action bar
                    _buildBottomBar(state),

                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Compact session header: Nova avatar (flashing while speaking) + name +
  /// live status (Listening… / Thinking… / Speaking) + control cluster
  /// (settings, language, full-screen, history, close).
  Widget _buildSessionHeader(VoiceSessionState state) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 12.w, 10.h),
      child: Row(
        children: [
          // Nova avatar (small, flashing)
          _buildNovaAvatar(state, compact: true),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nova',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 2.h),
                _buildHeaderStatusRow(state),
              ],
            ),
          ),
          // Control cluster. Wrapped in a Flexible + horizontal scroll so it can
          // shrink (and scroll) instead of overflowing the Row on very narrow
          // (<340px) screens. On normal phones it has room and never scrolls,
          // so the look is unchanged.
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              physics: const ClampingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tiny CTAs: show/hide live captions + conversation history.
                  // Kept genuinely small (~22.w) so they fit alongside the
                  // control cluster.
                  _buildTinyToggleChip(
                    icon: _showCaptions
                        ? Icons.closed_caption_rounded
                        : Icons.closed_caption_off_rounded,
                    active: _showCaptions,
                    activeColor: const Color(0xFF10B981),
                    onTap: () => setState(() => _showCaptions = !_showCaptions),
                  ),
                  SizedBox(width: 5.w),
                  // Chat-mode chip: TAP toggles the transcript between
                  // continuous (whole session, scrolls in realtime) and
                  // ephemeral (only the current user→AI cycle, disappears after).
                  // LONG-PRESS opens the fuller standalone history sheet.
                  _buildTinyToggleChip(
                    icon: _continuousChat
                        ? Icons.forum_rounded
                        : Icons.chat_bubble_outline_rounded,
                    active: _continuousChat,
                    activeColor: const Color(0xFF3B82F6),
                    onTap: () =>
                        setState(() => _continuousChat = !_continuousChat),
                    onLongPress: _showChatHistorySheet,
                  ),
                  SizedBox(width: 6.w),
                  _buildSettingsButton(),
                  SizedBox(width: 6.w),
                  _buildLanguagePillCompact(),
                  SizedBox(width: 6.w),
                  _buildFullScreenButton(),
                  SizedBox(width: 6.w),
                  GestureDetector(
                    onTap: _closeSheet,
                    behavior: HitTestBehavior.opaque,
                    // Larger circular tappable background (matches the
                    // dashboard top-right icon style) so the cancel/close
                    // control is easy to tap. A transparent 44x44 minimum
                    // hit target wraps the 40.w visual circle for
                    // accessibility. Behaviour is unchanged (_closeSheet
                    // cancels the connection + closes the bottomsheet).
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 44.w,
                        minHeight: 44.w,
                      ),
                      alignment: Alignment.center,
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.22),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white.withValues(alpha: 0.85),
                          size: 19.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Live status text + dot used in the compact header.
  Widget _buildHeaderStatusRow(VoiceSessionState state) {
    final cubit = context.read<VoiceSessionCubit>();
    String label;
    Color color;

    if (cubit.isAgentSpeaking) {
      label = 'Speaking…';
      color = const Color(0xFF5B45C9);
    } else if (state is VoiceSessionLocalUserSpeaking) {
      label = 'Listening…';
      color = const Color(0xFF10B981);
    } else if (state is VoiceSessionAgentProcessing) {
      label = 'Thinking…';
      color = const Color(0xFF5B45C9);
    } else if (state is VoiceSessionLoadingCredentials ||
        state is VoiceSessionConnectingToRoom ||
        state is VoiceSessionMicPermissionGranted) {
      label = 'Connecting…';
      color = const Color(0xFF3B82F6);
    } else if (state is VoiceSessionPinRequired) {
      label = 'Enter PIN';
      color = const Color(0xFF3B82F6);
    } else if (state is VoiceSessionError ||
        state is VoiceSessionCredentialsError) {
      label = 'Connection error';
      color = const Color(0xFFEF4444);
    } else {
      label = 'Online';
      color = const Color(0xFF10B981);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7.w,
          height: 7.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(
          label,
          style: GoogleFonts.inter(
            color: color,
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Full-screen toggle button (fullscreen / fullscreen_exit).
  Widget _buildFullScreenButton() {
    return GestureDetector(
      onTap: _toggleFullScreen,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isFullScreen
              ? Icons.fullscreen_exit_rounded
              : Icons.fullscreen_rounded,
          color: Colors.white.withValues(alpha: 0.55),
          size: 18.sp,
        ),
      ),
    );
  }

  /// Compact language pill for the header (tap = language picker).
  Widget _buildLanguagePillCompact() {
    final cubit = context.read<VoiceSessionCubit>();
    final lang = cubit.selectedLanguage;
    if (lang == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: _showLanguagePicker,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.language,
          color: const Color(0xFF5B45C9),
          size: 17.sp,
        ),
      ),
    );
  }

  /// Single scrollable conversation/transcript area. Renders the persisted
  /// turn history as chat bubbles, with the live realtime caption appended
  /// inline as the latest bubble (interim greyed, final solid). The transfer
  /// summary card / progress is rendered inline at the bottom so it no longer
  /// floats over the captions.
  Widget _buildConversationArea(VoiceSessionState state) {
    final cubit = context.read<VoiceSessionCubit>();

    // Loading / error / mic-denied orb takes over the whole area when there's
    // no active conversation yet (keeps the connecting/error UX intact).
    final isPreSession = state is VoiceSessionLoadingCredentials ||
        state is VoiceSessionConnectingToRoom ||
        state is VoiceSessionMicPermissionGranted ||
        state is VoiceSessionMicPermissionDenied ||
        state is VoiceSessionCredentialsError ||
        state is VoiceSessionError;

    final messages = cubit.recentConversationMessages;
    final userCaption = cubit.currentUserCaption;
    final agentCaption = cubit.currentAgentCaption;
    final hasLiveCaption =
        (userCaption != null && userCaption.isNotEmpty) ||
            (agentCaption != null && agentCaption.isNotEmpty);

    if (isPreSession) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNovaAvatar(state, compact: false),
            SizedBox(height: 28.h),
            _buildStatusSection(state),
          ],
        ),
      );
    }

    // ── ACTIVE TRANSFER LAYOUT ──
    // When a transfer is in flight, the screen has a lot going on: give the
    // sci-fi HUD the prime central space, the (already-compact) Nova avatar
    // lives in the header, and the conversation is condensed below it. This is
    // the SINGLE transfer surface — the old inline progress stepper is gone.
    final transfer = cubit.transferContext;
    if (transfer.isActive) {
      return _buildActiveTransferArea(
        state: state,
        transfer: transfer,
        messages: messages,
        userCaption: userCaption,
        agentCaption: agentCaption,
        hasLiveCaption: hasLiveCaption,
      );
    }

    // Empty state — show the big avatar + a friendly prompt.
    if (messages.isEmpty && !hasLiveCaption) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNovaAvatar(state, compact: false),
            SizedBox(height: 24.h),
            Text(
              'How can I help you?',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Speak naturally — I\'m listening',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      );
    }

    // ── NO ACTIVE TRANSFER ── large centred avatar header + transcript.
    //
    // The persisted transcript is ALWAYS rendered (it accumulates across turns
    // and scrolls — user complaint #1: history must not disappear each turn).
    // The tiny history CTA no longer gates visibility; it instead opens the
    // fuller standalone history sheet on long-press. The live interim caption
    // is appended as the latest in-progress bubble while the user/agent is
    // mid-utterance, then replaced by its finalized history bubble with no gap.
    return ListView(
      controller: _conversationScrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      children: [
        // A compact avatar header bubble at the top of the transcript so the
        // rep stays present without dominating the conversation.
        Center(child: _buildNovaAvatar(state, compact: false)),
        SizedBox(height: 16.h),

        // Transcript per chat mode (continuous = all + scroll; ephemeral =
        // only the current cycle). Accumulates + scrollable in continuous mode.
        ..._displayedMessages(messages).map(_buildConversationBubble),

        // Live realtime caption inline as the latest bubble (when captions on).
        // Rendered as interim (italic + lower opacity) so it reads as
        // in-progress "typing as they speak"; it's dropped once the turn is
        // committed to the transcript above.
        if (_showCaptions) ...[
          if (userCaption != null && userCaption.isNotEmpty)
            _buildLiveCaptionBubble(userCaption, isUser: true),
          if (agentCaption != null && agentCaption.isNotEmpty)
            _buildLiveCaptionBubble(agentCaption, isUser: false),
        ],
      ],
    );
  }

  /// Active-transfer layout: HUD takes the prime central space; captions +
  /// (collapsible) conversation history are condensed below it. The Nova avatar
  /// stays compact in the header (built by [_buildSessionHeader]).
  Widget _buildActiveTransferArea({
    required VoiceSessionState state,
    required VoiceTransferContext transfer,
    required List<VoiceConversationMessage> messages,
    required String? userCaption,
    required String? agentCaption,
    required bool hasLiveCaption,
  }) {
    return ListView(
      controller: _conversationScrollController,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      children: [
        // THE single transfer surface — sci-fi HUD, prime real estate.
        VoiceTransferHud(context: transfer),

        // Running transcript condensed under the HUD so older turns stay
        // visible and scrollable while a transfer is in flight (accumulates —
        // user complaint #1). Always rendered when there's history.
        if (messages.isNotEmpty) ...[
          SizedBox(height: 14.h),
          ..._displayedMessages(messages).map(_buildConversationBubble),
        ],

        // Condensed live caption below the transcript so the user still sees
        // what they / Nova are saying while reviewing/authorizing (captions on
        // only). Shown as the latest in-progress bubble.
        if (_showCaptions && hasLiveCaption) ...[
          SizedBox(height: 14.h),
          if (userCaption != null && userCaption.isNotEmpty)
            _buildLiveCaptionBubble(userCaption, isUser: true),
          if (agentCaption != null && agentCaption.isNotEmpty)
            _buildLiveCaptionBubble(agentCaption, isUser: false),
        ],
      ],
    );
  }

  /// Messages to render given the current chat display mode.
  ///  • continuous → the whole accumulating transcript.
  ///  • ephemeral  → only the current user→AI cycle (the latest exchange), so
  ///    older turns disappear once the next cycle begins.
  List<VoiceConversationMessage> _displayedMessages(
    List<VoiceConversationMessage> all,
  ) {
    if (_continuousChat || all.length <= 2) return all;
    return all.sublist(all.length - 2);
  }

  /// Chat bubble for a persisted conversation turn.
  Widget _buildConversationBubble(VoiceConversationMessage msg) {
    final isUser = msg.sender == VoiceConversationSender.user;
    final text = msg.text.trim();
    if (text.isEmpty) return const SizedBox.shrink();

    final bubbleColor = isUser
        ? const Color(0xFF5B45C9).withValues(alpha: 0.18)
        : const Color(0xFF1F1F1F);
    final borderColor = isUser
        ? const Color(0xFF5B45C9).withValues(alpha: 0.35)
        : const Color(0xFF2D2D2D);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12.h,
          left: isUser ? 48.w : 0,
          right: isUser ? 0 : 48.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isUser ? 16.r : 4.r),
            bottomRight: Radius.circular(isUser ? 4.r : 16.r),
          ),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 14.sp,
            height: 1.4,
          ),
        ),
      ),
    );
  }

  /// Live caption bubble — the in-progress (interim) turn. Rendered visually
  /// distinct from finalized history bubbles (lower opacity + italic + a
  /// "speaking…" label) so it reads as the user/agent "typing as they speak".
  /// Replaced by its solid finalized [_buildConversationBubble] once the turn
  /// is committed to history.
  Widget _buildLiveCaptionBubble(String text, {required bool isUser}) {
    final accent = isUser ? const Color(0xFF10B981) : const Color(0xFF5B45C9);
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 12.h,
          left: isUser ? 48.w : 0,
          right: isUser ? 0 : 48.w,
        ),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: accent.withValues(alpha: 0.30),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isUser ? 'You' : 'Nova',
                  style: GoogleFonts.inter(
                    color: accent,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(width: 6.w),
                // Pulsing dot + "speaking…" to signal this bubble is still
                // being spoken (interim), distinguishing it from finalized
                // history turns.
                FadeTransition(
                  opacity: _pulseController.drive(
                    Tween<double>(begin: 0.35, end: 1.0),
                  ),
                  child: Container(
                    width: 5.w,
                    height: 5.w,
                    decoration:
                        BoxDecoration(color: accent, shape: BoxShape.circle),
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'speaking…',
                  style: GoogleFonts.inter(
                    color: accent.withValues(alpha: 0.7),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              text,
              style: GoogleFonts.inter(
                // Interim/streaming = greyed + italic; reads as in-progress.
                color: Colors.white.withValues(alpha: 0.68),
                fontSize: 14.sp,
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Settings button.
  ///
  /// When this sheet was opened for a specific service (`serviceName`
  /// non-null), the gear routes to the per-service settings screen so
  /// the user lands on language + voice + prompt-hint controls scoped
  /// to that flow. When the sheet is the general dashboard mic
  /// (`serviceName == null`), we keep the existing route to the global
  /// voice settings screen so behaviour stays unchanged for that path.
  Widget _buildSettingsButton() {
    return GestureDetector(
      onTap: _openSettings,
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.settings_rounded,
          color: Colors.white.withValues(alpha: 0.5),
          size: 18.sp,
        ),
      ),
    );
  }

  void _openSettings() {
    final service = widget.serviceName;
    if (service == null || service.isEmpty) {
      Get.toNamed(AppRoutes.voiceSettings);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider<PerServiceVoiceSettingsCubit>(
          create: (_) {
            final cubit = PerServiceVoiceSettingsCubit(
              serviceName: service,
              storage: SharedPrefsPerServiceVoiceSettingsStorage(),
            );
            cubit.load();
            return cubit;
          },
          child: PerServiceVoiceSettingsScreen(serviceName: service),
        ),
      ),
    );
  }

  /// Tiny toggle chip (~22.w) used in the header for the captions / history
  /// CTAs. Small enough to sit alongside settings / language / fullscreen /
  /// close without crowding. [active] tints it with [activeColor].
  Widget _buildTinyToggleChip({
    required IconData icon,
    required bool active,
    required Color activeColor,
    required VoidCallback onTap,
    VoidCallback? onLongPress,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 24.w,
        height: 24.w,
        decoration: BoxDecoration(
          color: active
              ? activeColor.withValues(alpha: 0.16)
              : Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
          border: Border.all(
            color: active
                ? activeColor.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: active ? activeColor : Colors.white.withValues(alpha: 0.4),
          size: 13.sp,
        ),
      ),
    );
  }

  /// Show chat history bottom sheet
  void _showChatHistorySheet() {
    final cubit = context.read<VoiceSessionCubit>();
    final chatHistoryCubit = cubit.chatHistoryCubit;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider<VoiceChatHistoryCubit>.value(
        value: chatHistoryCubit,
        child: VoiceChatHistorySheet(
          sessionId: cubit.currentSessionId ?? '',
          currentUserCaption: cubit.currentUserCaption,
          currentAgentCaption: cubit.currentAgentCaption,
        ),
      ),
    );
  }

  /// Language indicator chip shown during active session.
  Widget _buildLanguageIndicator() {
    final cubit = context.read<VoiceSessionCubit>();
    final lang = cubit.selectedLanguage;
    if (lang == null) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _showLanguagePicker,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.language_rounded,
                  color: const Color(0xFF3B82F6),
                  size: 15.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  lang.nativeName,
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (lang.supportsVoiceCustomization) ...[
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: _showVoiceCustomization,
                    child: Icon(
                      Icons.tune_rounded,
                      color: Colors.white.withValues(alpha: 0.35),
                      size: 14.sp,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
        // Custom Voice button for English
        if (lang.code == 'en') ...[
          SizedBox(width: 6.w),
          _buildCustomVoiceButton(),
        ],
      ],
    );
  }

  /// Reusable "Custom Voice" pill that routes to the voice-settings screen.
  /// Used in the language indicator (call-end) and the OTP/PIN entry sheet.
  Widget _buildCustomVoiceButton() {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.voiceSettings),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.record_voice_over_rounded,
              color: const Color(0xFF10B981),
              size: 12.sp,
            ),
            SizedBox(width: 4.w),
            Text(
              'Custom Voice',
              style: GoogleFonts.inter(
                color: const Color(0xFF10B981),
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Loading view while checking voice enrollment status.
  Widget _buildEnrollmentCheckView() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D0D0F),
            Color(0xFF0A0A0C),
            Color(0xFF050507),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            // Close button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _closeSheet,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
            // Pulsing mic icon
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3B82F6).withValues(alpha: 0.08),
                border: Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
              child: Center(
                child: LazerVaultLoader.medium(),
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Checking Voice Setup',
              style: GoogleFonts.inter(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Verifying your voice registration...',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  /// Full-screen language selection view (shown before session starts).
  Widget _buildLanguageSelectionView(VoiceSessionLanguageSelection state) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D0D0F),
            Color(0xFF0A0A0C),
            Color(0xFF050507),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Close button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: _closeSheet,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Voice icon
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              ),
              child: Icon(
                Icons.mic_rounded,
                color: const Color(0xFF3B82F6),
                size: 32.sp,
              ),
            ),

            SizedBox(height: 20.h),

            // Title
            Text(
              'Choose Your Language',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 8.h),

            Text(
              'The assistant will listen and speak\nin your chosen language',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 14.sp,
              ),
            ),

            SizedBox(height: 24.h),

            // Language list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: state.availableLanguages.length,
                itemBuilder: (context, index) {
                  final lang = state.availableLanguages[index];
                  return _buildLanguageSelectionTile(lang);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelectionTile(VoiceLanguage lang) {
    // Get locale manager to check country
    // Edge case: Handle serviceLocator errors gracefully
    String currentCountry = 'NG';  // Default to Nigeria
    try {
      final localeManager = serviceLocator<LocaleManager>();
      currentCountry = localeManager.currentCountry?.toUpperCase() ?? 'NG';
    } catch (e) {
      print('VoiceCommandSheet: LocaleManager not found in serviceLocator, using default NG: $e');
      // Use default Nigeria country
    }

    final isNigeria = currentCountry == 'NG';
    final isDomesticEnglish = lang.code == 'en' && isNigeria;

    // Edge case: Validate language object has required fields
    final displayName = lang.nativeName.isNotEmpty
        ? lang.nativeName
        : lang.name.isNotEmpty ? lang.name : lang.code;

    return GestureDetector(
      onTap: () => _onLanguageSelected(lang),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.06),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Icon(
                  Icons.language,
                  color: const Color(0xFF3B82F6),
                  size: 22.sp,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        displayName,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // Domestic English badge for en-NG
                      if (isDomesticEnglish) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            'Domestic',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF10B981).withValues(alpha: 0.8),
                              fontSize: 9.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        lang.name,
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.45),
                          fontSize: 13.sp,
                        ),
                      ),
                      // Provider badge
                      if (lang.provider.isNotEmpty) ...[
                        SizedBox(width: 6.w),
                        _buildProviderBadge(lang.provider),
                      ],
                      // Voice count
                      if (lang.availableVoices.isNotEmpty) ...[
                        SizedBox(width: 6.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            '${lang.availableVoices.length} voice${lang.availableVoices.length == 1 ? "" : "s"}',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF10B981),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white.withValues(alpha: 0.2),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  /// Nova customer-rep avatar inside a circular frame. While the agent is
  /// SPEAKING it pulses a purple glow ring + gentle scale and shows an active
  /// mic indicator (reads as "the rep is talking with their mic on"). While
  /// the user is LISTENING it pulses a softer blue. Idle/thinking = calm.
  ///
  /// [compact] = small header variant; otherwise the large central variant.
  Widget _buildNovaAvatar(VoiceSessionState state, {required bool compact}) {
    final cubit = context.read<VoiceSessionCubit>();
    final isSpeaking = cubit.isAgentSpeaking;
    final isListening = state is VoiceSessionLocalUserSpeaking;
    final isThinking = state is VoiceSessionAgentProcessing;

    // Loading / error / mic-denied keep the existing orb treatment in the big
    // (central) variant so those UX paths are unchanged.
    if (!compact) {
      final isLoading = state is VoiceSessionLoadingCredentials ||
          state is VoiceSessionConnectingToRoom ||
          state is VoiceSessionMicPermissionGranted;
      final isError = state is VoiceSessionCredentialsError ||
          state is VoiceSessionError ||
          state is VoiceSessionMicPermissionDenied;
      if (isLoading || isError) {
        return _buildVoiceOrb(state);
      }
    }

    final double size = compact ? 44.w : 132.w;
    final Color glowColor = isSpeaking
        ? const Color(0xFF5B45C9)
        : isListening
            ? const Color(0xFF10B981)
            : isThinking
                ? const Color(0xFF3D2F8B)
                : const Color(0xFF3D2F8B);
    final bool animate = isSpeaking || isListening;

    return AnimatedBuilder(
      animation: _avatarController,
      builder: (context, child) {
        final t = _avatarController.value; // 0..1 (reverses)
        final scale = animate ? 1.0 + (t * (isSpeaking ? 0.06 : 0.04)) : 1.0;
        final glowAlpha = animate
            ? 0.18 + (t * (isSpeaking ? 0.4 : 0.25))
            : 0.12;
        final ringAlpha = animate ? 0.25 + (t * 0.45) : 0.2;

        return SizedBox(
          width: size * (compact ? 1.0 : 1.5),
          height: size * (compact ? 1.0 : 1.5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Pulsing glow ring (behind the avatar).
              if (animate)
                Container(
                  width: size * 1.32,
                  height: size * 1.32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: glowColor.withValues(alpha: ringAlpha),
                      width: compact ? 1.5 : 2.5,
                    ),
                  ),
                ),

              // Avatar with glow + gentle scale.
              Transform.scale(
                scale: scale,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: glowColor.withValues(alpha: 0.55),
                      width: compact ? 1.5 : 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withValues(alpha: glowAlpha),
                        blurRadius: compact ? 14 : 32,
                        spreadRadius: compact ? 1 : 4,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      'assets/images/nova_rep.svg',
                      fit: BoxFit.cover,
                      placeholderBuilder: (_) => Container(
                        color: const Color(0xFF1F1F1F),
                        child: Icon(
                          Icons.support_agent_rounded,
                          color: glowColor,
                          size: size * 0.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Active mic indicator — glows while the rep is speaking.
              if (isSpeaking)
                Positioned(
                  bottom: 0,
                  right: compact ? 0 : size * 0.12,
                  child: Container(
                    width: compact ? 16.w : 32.w,
                    height: compact ? 16.w : 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF5B45C9),
                      border: Border.all(
                        color: const Color(0xFF0A0A0A),
                        width: compact ? 1.5 : 2.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5B45C9)
                              .withValues(alpha: 0.35 + t * 0.45),
                          blurRadius: compact ? 6 : 14,
                          spreadRadius: compact ? 0 : 2,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.mic_rounded,
                      color: Colors.white,
                      size: compact ? 9.sp : 16.sp,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVoiceOrb(VoiceSessionState state) {
    final isActive = state is VoiceSessionConnected ||
        state is VoiceSessionLocalUserSpeaking ||
        state is VoiceSessionAgentProcessing ||
        state is VoiceSessionLocalUserNotSpeaking ||
        state is VoiceSessionUserSearchRequired ||
        state is VoiceSessionTransferConfirmation ||
        state is VoiceSessionPinRequired ||
        state is VoiceSessionTransactionSuccess ||
        state is VoiceSessionTransactionError ||
        state is VoiceSessionWebSocketFailed ||
        state is VoiceSessionLowConfidenceWarning;

    final isSpeaking = state is VoiceSessionLocalUserSpeaking;
    final isProcessing = state is VoiceSessionAgentProcessing;
    final isLoading = state is VoiceSessionLoadingCredentials ||
        state is VoiceSessionConnectingToRoom ||
        state is VoiceSessionMicPermissionGranted;
    final isError = state is VoiceSessionCredentialsError ||
        state is VoiceSessionError;

    if (isLoading) {
      return SizedBox(
        width: 160.w,
        height: 160.w,
        child: Center(
          child: LazerVaultLoader(size: 80),
        ),
      );
    }

    if (state is VoiceSessionMicPermissionDenied) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFFB923C).withValues(alpha: 0.08),
              border: Border.all(
                color: const Color(0xFFFB923C).withValues(alpha: 0.2),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.mic_off_rounded,
              color: const Color(0xFFFB923C),
              size: 36.sp,
            ),
          ),
          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () => openAppSettings(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                color: const Color(0xFFFB923C).withValues(alpha: 0.12),
                border: Border.all(
                  color: const Color(0xFFFB923C).withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.settings_rounded,
                    color: const Color(0xFFFB923C),
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Enable Microphone',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFFB923C),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (isError) {
      return Container(
        width: 120.w,
        height: 120.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFEF4444).withValues(alpha: 0.08),
          border: Border.all(
            color: const Color(0xFFEF4444).withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Icon(
          Icons.error_outline_rounded,
          color: const Color(0xFFEF4444),
          size: 36.sp,
        ),
      );
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_pulseController, _waveController, _glowController]),
      builder: (context, child) {
        final pulseValue = _pulseController.value;
        final waveValue = _waveController.value;
        final glowValue = _glowController.value;

        return SizedBox(
          width: 200.w,
          height: 200.w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer wave rings
              if (isActive) ...[
                _buildWaveRing(180.w, waveValue, isSpeaking ? 0.25 : 0.1),
                _buildWaveRing(160.w, (waveValue + 0.33) % 1.0, isSpeaking ? 0.2 : 0.08),
                _buildWaveRing(140.w, (waveValue + 0.66) % 1.0, isSpeaking ? 0.15 : 0.06),
              ],

              // Glow
              if (isActive)
                Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: _getOrbColor(state).withValues(
                          alpha: 0.15 + (glowValue * (isSpeaking ? 0.25 : 0.1)),
                        ),
                        blurRadius: 30 + (glowValue * 20),
                        spreadRadius: glowValue * 10,
                      ),
                    ],
                  ),
                ),

              // Main orb
              Transform.scale(
                scale: isActive ? 1.0 + (pulseValue * (isSpeaking ? 0.08 : 0.03)) : 1.0,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        _getOrbColor(state).withValues(alpha: 0.3),
                        _getOrbColor(state).withValues(alpha: 0.15),
                        _getOrbColor(state).withValues(alpha: 0.05),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                    border: Border.all(
                      color: _getOrbColor(state).withValues(
                        alpha: 0.3 + (isActive ? pulseValue * 0.3 : 0),
                      ),
                      width: 1.5,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      isProcessing
                          ? Icons.auto_awesome_rounded
                          : isSpeaking
                              ? Icons.graphic_eq_rounded
                              : Icons.mic_rounded,
                      color: _getOrbColor(state).withValues(alpha: 0.9),
                      size: 32.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWaveRing(double size, double animValue, double maxOpacity) {
    final opacity = (sin(animValue * pi * 2) * 0.5 + 0.5) * maxOpacity;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: opacity),
          width: 1,
        ),
      ),
    );
  }

  Color _getOrbColor(VoiceSessionState state) {
    if (state is VoiceSessionLocalUserSpeaking) return const Color(0xFF10B981);
    if (state is VoiceSessionAgentProcessing) return const Color.fromARGB(255, 78, 3, 208);
    if (state is VoiceSessionLowConfidenceWarning) return const Color(0xFFFB923C);
    return const Color(0xFF3B82F6);
  }

  Widget _buildStatusSection(VoiceSessionState state) {
    String title;
    String subtitle;
    Color titleColor = Colors.white;

    if (state is VoiceSessionLoadingCredentials) {
      title = 'Initializing';
      subtitle = 'Setting up your voice session';
    } else if (state is VoiceSessionConnectingToRoom ||
        state is VoiceSessionMicPermissionGranted) {
      title = 'Connecting';
      subtitle = 'Establishing secure connection';
    } else if (state is VoiceSessionCredentialsError || state is VoiceSessionError) {
      title = 'Connection Error';
      subtitle = 'Please try again';
      titleColor = const Color(0xFFEF4444);
    } else if (state is VoiceSessionMicPermissionDenied) {
      title = 'Microphone Denied';
      subtitle = 'Enable in device settings';
      titleColor = const Color(0xFFFB923C);
    } else if (state is VoiceSessionLocalUserSpeaking) {
      title = 'Listening';
      subtitle = 'Speak naturally, I\'m here';
      titleColor = const Color(0xFF10B981);
    } else if (state is VoiceSessionAgentProcessing) {
      title = 'Thinking';
      subtitle = 'Processing your request';
      titleColor = const Color.fromARGB(255, 78, 3, 208);
    } else if (state is VoiceSessionUserSearchRequired) {
      title = 'Select Recipient';
      subtitle = 'Choose from the results above';
      titleColor = const Color(0xFF3B82F6);
    } else if (state is VoiceSessionTransferConfirmation) {
      title = 'Confirm Transfer';
      subtitle = 'Review the details above';
      titleColor = const Color(0xFFFB923C);
    } else if (state is VoiceSessionPinRequired) {
      title = 'Enter PIN';
      subtitle = 'Complete your transaction';
      titleColor = const Color(0xFF3B82F6);
    } else if (state is VoiceSessionTransactionSuccess) {
      final success = (state as VoiceSessionTransactionSuccess).result['success'] as bool? ?? true;
      title = success ? 'Transfer Complete' : 'Transfer Failed';
      subtitle = success ? 'Your transaction was successful' : 'Please try again';
      titleColor = success ? const Color(0xFF10B981) : const Color(0xFFEF4444);
    } else if (state is VoiceSessionTransactionError) {
      title = 'Transaction Failed';
      subtitle = state.message;
      titleColor = const Color(0xFFEF4444);
    } else if (state is VoiceSessionWebSocketFailed) {
      title = 'Ready';
      subtitle = 'Visual feedback unavailable';
      titleColor = const Color(0xFFFB923C);
    } else if (state is VoiceSessionLowConfidenceWarning) {
      title = 'Security Warning';
      subtitle = 'Voice confidence is low';
      titleColor = const Color(0xFFFB923C);
    } else if (state is VoiceSessionConnected || state is VoiceSessionLocalUserNotSpeaking) {
      title = 'Ready';
      subtitle = 'How can I help you?';
    } else if (state is VoiceSessionDisconnected) {
      title = 'Disconnected';
      subtitle = 'Session ended';
    } else {
      title = 'Voice Assistant';
      subtitle = 'Powered by LazerVault AI';
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              color: titleColor,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.45),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(VoiceSessionState state) {
    final isActive = state is VoiceSessionConnected ||
        state is VoiceSessionLocalUserSpeaking ||
        state is VoiceSessionAgentProcessing ||
        state is VoiceSessionLocalUserNotSpeaking ||
        state is VoiceSessionUserSearchRequired ||
        state is VoiceSessionTransferConfirmation ||
        state is VoiceSessionPinRequired ||
        state is VoiceSessionTransactionSuccess ||
        state is VoiceSessionTransactionError ||
        state is VoiceSessionWebSocketFailed ||
        state is VoiceSessionLowConfidenceWarning;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // End call button — transitions to rating screen
          GestureDetector(
            onTap: _endCall,
            child: Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEF4444).withValues(alpha: 0.12),
                border: Border.all(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.25),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.call_end_rounded,
                color: const Color(0xFFEF4444),
                size: 24.sp,
              ),
            ),
          ),

          if (isActive) ...[
            SizedBox(width: 24.w),

            // Mute/Unmute toggle
            GestureDetector(
              onTap: () async {
                final cubit = context.read<VoiceSessionCubit>();
                final newMuted = await cubit.toggleMute();
                setState(() => _isMuted = newMuted);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _isMuted
                      ? const Color(0xFFFB923C).withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.12),
                  border: Border.all(
                    color: _isMuted
                        ? const Color(0xFFFB923C).withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Icon(
                  _isMuted ? Icons.mic_off_rounded : Icons.mic_rounded,
                  color: _isMuted
                      ? const Color(0xFFFB923C)
                      : Colors.white.withValues(alpha: 0.9),
                  size: 24.sp,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ── Call ended / rating view ──

  Widget _buildCallEndedView(VoiceSessionEnded state) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0D0D0F),
            Color(0xFF0A0A0C),
            Color(0xFF050507),
          ],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Drag handle
            Container(
              width: 36.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),

            // Top bar: settings + language + close
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  _buildSettingsButton(),
                  SizedBox(width: 8.w),
                  _buildLanguageIndicator(),
                  const Spacer(),
                  GestureDetector(
                    onTap: _closeSheet,
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.06),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white.withValues(alpha: 0.5),
                        size: 18.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // Icon — red shield for failure, green check for normal end
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (state.endReason != null
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF10B981))
                    .withValues(alpha: 0.1),
                border: Border.all(
                  color: (state.endReason != null
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF10B981))
                      .withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Icon(
                state.endReason != null
                    ? Icons.shield_outlined
                    : Icons.check_rounded,
                color: state.endReason != null
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF10B981),
                size: 40.sp,
              ),
            ),

            SizedBox(height: 24.h),

            Text(
              'Call Ended',
              style: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: 6.h),
            if (state.endReason != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Text(
                  state.endReason!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFFEF4444).withValues(alpha: 0.85),
                  ),
                ),
              ),
            ] else ...[
              Text(
                'Thank you for using LazerVault Voice',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
              ),
            ],

            SizedBox(height: 32.h),

            // Star rating
            if (!_ratingSubmitted) ...[
              Text(
                'How was your experience?',
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              SizedBox(height: 16.h),
              _buildStarRating(),
              SizedBox(height: 16.h),

              // Feedback text field (only show after selecting a rating)
              if (_selectedRating > 0) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: TextField(
                    controller: _feedbackController,
                    maxLines: 2,
                    maxLength: 200,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Any feedback? (optional)',
                      hintStyle: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.25),
                        fontSize: 13.sp,
                      ),
                      counterStyle: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.2),
                        fontSize: 10.sp,
                      ),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.05),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.5),
                        ),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // Submit button — invoice purple theme
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.w),
                  child: GestureDetector(
                    onTap: _isSubmittingRating ? null : _submitRating,
                    child: Container(
                      width: double.infinity,
                      height: 44.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.r),
                        gradient: LinearGradient(
                          colors: _isSubmittingRating
                              ? [
                                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                                  const Color.fromARGB(255, 100, 20, 230).withValues(alpha: 0.3),
                                ]
                              : [
                                  const Color.fromARGB(255, 78, 3, 208),
                                  const Color.fromARGB(255, 100, 20, 230),
                                ],
                        ),
                      ),
                      child: Center(
                        child: _isSubmittingRating
                            ? LazerVaultLoader.small()
                            : Text(
                                'Submit Rating',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ] else ...[
              // Rating submitted — thank you + ready for new call
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  border: Border.all(
                    color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.25),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.thumb_up_rounded,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Thanks for your feedback!',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Your rating helps us improve',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
            ],

            const Spacer(flex: 2),

            // Call Again button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 32.w),
              child: GestureDetector(
                onTap: _startNewCall,
                child: Container(
                  width: double.infinity,
                  height: 52.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26.r),
                    color: const Color(0xFF10B981).withValues(alpha: 0.12),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call_rounded,
                        color: const Color(0xFF10B981),
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Start New Call',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF10B981),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = starIndex <= _selectedRating;
        return GestureDetector(
          onTap: () {
            setState(() => _selectedRating = starIndex);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w),
            child: AnimatedScale(
              scale: isSelected ? 1.15 : 1.0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isSelected
                    ? const Color(0xFFFBBF24)
                    : Colors.white.withValues(alpha: 0.2),
                size: 40.sp,
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<void> _submitRating() async {
    if (_selectedRating == 0 || _isSubmittingRating) return;
    setState(() => _isSubmittingRating = true);

    final cubit = context.read<VoiceSessionCubit>();
    final success = await cubit.submitRating(
      rating: _selectedRating,
      feedback: _feedbackController.text.trim().isEmpty
          ? null
          : _feedbackController.text.trim(),
    );

    if (mounted) {
      setState(() {
        _isSubmittingRating = false;
        _ratingSubmitted = success;
      });

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Could not submit rating. Please try again.',
              style: GoogleFonts.inter(fontSize: 13),
            ),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  // ── Visual feedback dialog methods ──

  void _dismissActiveDialog() {
    if (_isDialogShowing && mounted) {
      try {
        Navigator.of(context).pop();
      } catch (_) {
        // Dialog may have already been dismissed
      }
      _isDialogShowing = false;
    }
  }

  void _showLowConfidenceWarningDialog(BuildContext context, String message) {
    _dismissActiveDialog();
    _isDialogShowing = true;
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Row(
          children: [
            Icon(Icons.warning_amber_rounded, color: Color(0xFFFB923C), size: 26),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Voice not fully verified',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        ),
        content: Text(
          message.isNotEmpty
              ? message
              : 'We could not confidently match your voice. You can continue, but please keep transactions to amounts you are comfortable with.',
          style: const TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _isDialogShowing = false;
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Continue'),
          ),
        ],
      ),
    ).whenComplete(() => _isDialogShowing = false);
  }

  void _showUserSearchDialog(BuildContext context, List<Map<String, dynamic>> users, String query) {
    // Dismiss any existing dialog first to prevent stacking
    _dismissActiveDialog();
    _isDialogShowing = true;

    // Capture the cubit before showing so the post-dismissal callback (which
    // runs after an async gap) doesn't reach through `context`.
    final voiceCubit = context.read<VoiceSessionCubit>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => VoiceUserSearchDialog(
        users: users,
        query: query,
        onUserSelected: (userId, username) {
          _isDialogShowing = false;
          Navigator.of(context).pop();
          context.read<VoiceSessionCubit>().selectUser(userId, username);
        },
        onCancel: () {
          _isDialogShowing = false;
          Navigator.of(context).pop();
          context.read<VoiceSessionCubit>().cancelVoiceAction();
        },
      ),
    ).whenComplete(() {
      // Handle dismissal via back button or swipe (this modal bottom sheet is
      // swipe-dismissible, unlike the barrierDismissible:false dialogs). If the
      // user swiped it away without tapping a button, no resolving event clears
      // the cubit's visual-feedback flag — tell the cubit the dialog is gone so
      // stale-event suppression stops. Idempotent if a button already cleared it.
      _isDialogShowing = false;
      voiceCubit.onVisualFeedbackDismissed();
    });
  }

  void _showTransferSummaryDialog(BuildContext context, Map<String, dynamic> details) {
    _dismissActiveDialog();
    _isDialogShowing = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VoiceTransferSummaryCard(
        transferDetails: details,
        onConfirm: () {
          _isDialogShowing = false;
          Navigator.of(context).pop();
          context.read<VoiceSessionCubit>().confirmTransfer();
        },
        onCancel: () {
          _isDialogShowing = false;
          Navigator.of(context).pop();
          context.read<VoiceSessionCubit>().cancelVoiceAction();
        },
      ),
    ).whenComplete(() {
      _isDialogShowing = false;
    });
  }

  /// Show the transaction-PIN bottom sheet for a voice money-move.
  ///
  /// ROOT-CAUSE FIX: the old path wrapped an invisible `VoicePinSheetLauncher`
  /// (`SizedBox.shrink`) in a `showDialog`, which then nested ANOTHER modal
  /// route (`showModalBottomSheet`) via the mixin — three stacked routes under
  /// the GetX bottom sheet, fronted by an invisible `barrierDismissible:false`
  /// barrier. The launcher also awaited a network `checkUserHasPin()` before
  /// presenting, so any slowness/teardown during that await left the user
  /// staring at the invisible barrier with no PIN UI. We now drive the
  /// canonical `TransactionPinMixin` sheet DIRECTLY from this State (one route,
  /// same as the chat path) so it reliably appears on `VoiceSessionPinRequired`.
  Future<void> _showPinEntrySheet(Map<String, dynamic> payload) async {
    if (_isPinSheetShowing || !mounted) return;
    _isPinSheetShowing = true;
    // Force-release the re-entrancy guard if the PIN flow never completes
    // (stalled await / dropped sheet) — otherwise the flag stays true and
    // blocks every future PIN sheet for the rest of the session.
    _pinSheetTimeoutTimer?.cancel();
    _pinSheetTimeoutTimer = Timer(const Duration(seconds: 60), () {
      if (_isPinSheetShowing) {
        print(
          'VoiceCommandSheet: PIN sheet guard timed out after 60s — '
          'force-clearing _isPinSheetShowing',
        );
        _isPinSheetShowing = false;
      }
    });

    // Amounts in the payload are already MAJOR units (Naira) — do NOT divide.
    final amount = double.tryParse(payload['amount']?.toString() ?? '0') ?? 0.0;
    final fee = double.tryParse(payload['fee']?.toString() ?? '0') ?? 0.0;
    final total =
        double.tryParse(payload['total_amount']?.toString() ?? '') ??
            (amount + fee);
    final currency = (payload['currency'] ?? 'NGN').toString();
    final transactionId = (payload['transaction_id'] ?? '').toString();
    final transactionType =
        (payload['transaction_type'] ?? 'transfer').toString();
    final recipientSummary =
        (payload['recipient_summary'] ?? '').toString().trim();

    // Round-trip context for resuming the agent's PinPromptIntent.
    final callbackIntent = (payload['callback_intent'] ?? '').toString();
    final callbackArgs = payload['callback_args'] is Map
        ? Map<String, dynamic>.from(payload['callback_args'] as Map)
        : <String, dynamic>{};

    final cubit = context.read<VoiceSessionCubit>();

    print(
      'VoiceCommandSheet: showing transaction-PIN sheet '
      '(type=$transactionType, amount=$currency $amount, '
      'callbackIntent=${callbackIntent.isEmpty ? "<legacy>" : callbackIntent})',
    );

    // Surface the "Custom Voice" shortcut at the OTP/PIN step too (same
    // English-only condition the call-end indicator uses), so the user can jump
    // to custom-voice setup without leaving the PIN flow.
    final pinHeaderAction =
        cubit.selectedLanguage?.code == 'en' ? _buildCustomVoiceButton() : null;

    bool verified = false;
    try {
      final success = await validateTransactionPin(
        context: context,
        headerAction: pinHeaderAction,
        transactionId: transactionId,
        transactionType: transactionType,
        amount: amount,
        currency: currency,
        title: _pinTitleForType(transactionType),
        message: recipientSummary.isEmpty
            ? 'Enter your PIN to continue.'
            : recipientSummary,
        fee: fee,
        totalAmount: total,
        onPinValidated: (verificationToken) async {
          verified = true;
          // Modern callback_intent path — single-use token round-trips to the
          // agent so it can resume the original tool call. Legacy payloads
          // (no callback_intent) fall back to the binary pin_completed signal.
          if (callbackIntent.isNotEmpty) {
            await cubit.submitPinVerification(
              verificationToken: verificationToken,
              callbackIntent: callbackIntent,
              callbackArgs: callbackArgs,
            );
          } else {
            await cubit.notifyPinCompleted(true, reference: verificationToken);
          }
        },
      );

      // Cancelled / exhausted / locked WITHOUT a validated PIN — tell the
      // agent to cancel the in-flight voice action cleanly.
      if (!success && !verified) {
        await cubit.notifyPinCompleted(false, error: 'pin_entry_cancelled');
      }
    } finally {
      _pinSheetTimeoutTimer?.cancel();
      _pinSheetTimeoutTimer = null;
      _isPinSheetShowing = false;
    }
  }

  String _pinTitleForType(String t) {
    switch (t) {
      case 'transfer':
        return 'Confirm transfer';
      case 'transfer_intl':
        return 'Confirm international transfer';
      case 'batch_transfer':
        return 'Confirm batch transfer';
      case 'crypto_buy':
        return 'Confirm crypto purchase';
      case 'crypto_sell':
        return 'Confirm crypto sale';
      case 'crypto_swap':
        return 'Confirm crypto swap';
      case 'crypto_send':
        return 'Confirm crypto send';
      case 'insurance_buy':
        return 'Confirm insurance purchase';
      case 'insurance_claim':
        return 'Submit insurance claim';
      case 'exchange_convert':
        return 'Confirm currency conversion';
      case 'split_bill_pay':
        return 'Confirm split-bill payment';
      default:
        return 'Confirm payment';
    }
  }

  Widget _buildProviderBadge(String provider) {
    Color badgeColor;
    String label;
    switch (provider) {
      case 'elevenlabs':
        badgeColor = const Color(0xFF3B82F6);
        label = 'ElevenLabs';
        break;
      case 'yarngpt':
        badgeColor = const Color(0xFF10B981);
        label = 'YarnGPT';
        break;
      case 'openai':
        badgeColor = const Color.fromARGB(255, 78, 3, 208);
        label = 'OpenAI';
        break;
      default:
        badgeColor = const Color(0xFF6B7280);
        label = provider;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          color: badgeColor.withValues(alpha: 0.8),
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Human-readable label for a language code, used in user-facing notices.
/// Falls back to the upper-cased code for anything unmapped.
String _voiceLanguageLabel(String code) {
  switch (code.toLowerCase()) {
    case 'en':
      return 'English';
    case 'yo':
      return 'Yoruba';
    case 'ig':
      return 'Igbo';
    case 'ha':
      return 'Hausa';
    case 'pcm':
      return 'Pidgin';
    case 'fr':
      return 'French';
    case 'es':
      return 'Spanish';
    case 'ar':
      return 'Arabic';
    case 'pt':
      return 'Portuguese';
    case 'sw':
      return 'Swahili';
    default:
      return code.toUpperCase();
  }
}
