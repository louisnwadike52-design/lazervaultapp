import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
import 'package:lazervault/src/features/voice_session/widgets/voice_pin_entry_dialog.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_caption_box.dart';
import 'package:lazervault/src/features/voice_session/widgets/voice_chat_history_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

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
    with TickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _glowController;
  final VoiceActivationManager _voiceActivationManager = VoiceActivationManager();

  bool _isDialogShowing = false;
  bool _isCheckingEnrollment = true;
  bool _isMuted = false;
  bool _isClosing = false;
  int _selectedRating = 0;
  bool _isSubmittingRating = false;
  bool _ratingSubmitted = false;
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
    _pulseController.repeat(reverse: true);
    _waveController.repeat();
    _glowController.repeat(reverse: true);
  }

  void _stopAnimations() {
    _pulseController.stop();
    _waveController.stop();
    _glowController.stop();
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
    _dismissActiveDialog();
    _feedbackController.dispose();
    _pulseController.dispose();
    _waveController.dispose();
    _glowController.dispose();
    // Only disconnect if not already closing (avoids double disconnect)
    if (!_isClosing) {
      context.read<VoiceSessionCubit>().disconnectFromLiveKitRoom(fullCleanup: true);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Show enrollment check screen while verifying voice registration
    if (_isCheckingEnrollment) {
      return _buildEnrollmentCheckView();
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
          // Voice biometrics verification failed - show error and close
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              duration: const Duration(seconds: 4),
            ),
          );
          // Show ended screen after a brief delay
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) _endCall();
          });
        } else if (state is VoiceSessionMicPermissionDenied) {
          // Handled in UI — no snackbar
        } else if (state is VoiceSessionUserSearchRequired) {
          _showUserSearchDialog(context, state.users, state.query);
        } else if (state is VoiceSessionTransferConfirmation) {
          _showTransferSummaryDialog(context, state.transferDetails);
        } else if (state is VoiceSessionPinRequired) {
          _showPinEntryDialog(context, state.transactionPayload);
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
        } else if (state is VoiceSessionLowConfidenceWarning) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 20),
                  const SizedBox(width: 8),
                  Expanded(child: Text(state.message, style: const TextStyle(fontSize: 12))),
                ],
              ),
              backgroundColor: const Color(0xFFFB923C),
              duration: const Duration(seconds: 5),
            ),
          );
        }

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
        } else if (state is VoiceSessionEnded) {
          _stopAnimations();
        } else if (state is! VoiceSessionLanguageSelection) {
          _stopAnimations();
        }
      },
      builder: (context, state) {
        // Language selection screen
        if (state is VoiceSessionLanguageSelection) {
          return _buildLanguageSelectionView(state);
        }

        // Call ended / rating screen
        if (state is VoiceSessionEnded) {
          return _buildCallEndedView(state);
        }

        // Main voice session UI with caption overlay
        return Stack(
          children: [
            // Main content
            Container(
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

                // Top bar: settings + language indicator + chat history + close button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      // Settings button (opens voice settings)
                      _buildSettingsButton(),
                      SizedBox(width: 8.w),
                      // Language indicator
                      _buildLanguageIndicator(),
                      const Spacer(),
                      // Chat history button
                      _buildChatHistoryButton(state),
                      SizedBox(width: 8.w),
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

                // Central voice orb
                _buildVoiceOrb(state),

                SizedBox(height: 32.h),

                // Status text
                _buildStatusSection(state),

                const Spacer(flex: 3),

                // Bottom action bar
                _buildBottomBar(state),

                SizedBox(height: 12.h),
              ],
            ),
          ),
        ),
        // Caption overlay (always on top)
        const VoiceCaptionBox(),
        // Visual feedback for transfer flow
        VoiceTransferVisualFeedback(state: state),
      ],
    );
      },
    );
  }

  /// Settings button to open voice settings screen
  Widget _buildSettingsButton() {
    return GestureDetector(
      onTap: () => Get.toNamed('/voice/settings'),
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

  /// Chat history button - shows conversation history of current voice session
  Widget _buildChatHistoryButton(VoiceSessionState state) {
    final cubit = context.read<VoiceSessionCubit>();
    final hasHistory = cubit.currentUserCaption != null || cubit.currentAgentCaption != null;

    return GestureDetector(
      onTap: () => _showChatHistorySheet(),
      child: Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: hasHistory
              ? const Color(0xFF3B82F6).withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.06),
          shape: BoxShape.circle,
          border: hasHistory
              ? Border.all(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                  width: 1,
                )
              : null,
        ),
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                color: hasHistory
                    ? const Color(0xFF3B82F6)
                    : Colors.white.withValues(alpha: 0.5),
                size: 18.sp,
              ),
            ),
            // Badge showing message count if there's history
            if (hasHistory)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Show chat history bottom sheet
  void _showChatHistorySheet() {
    final cubit = context.read<VoiceSessionCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => VoiceChatHistorySheet(
        sessionId: cubit.currentSessionId ?? '',
        currentUserCaption: cubit.currentUserCaption,
        currentAgentCaption: cubit.currentAgentCaption,
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
                  Icons.translate_rounded,
                  color: const Color(0xFF3B82F6),
                  size: 14.sp,
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
          GestureDetector(
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
          ),
        ],
      ],
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
                child: SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: CircularProgressIndicator(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.6),
                    strokeWidth: 2.5,
                  ),
                ),
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
                  Icons.translate_rounded,
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
                  Text(
                    lang.nativeName,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
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
          child: SizedBox(
            width: 80.w,
            height: 80.w,
            child: CircularProgressIndicator(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.7),
              strokeWidth: 2.5,
            ),
          ),
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

            // Checkmark icon
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                border: Border.all(
                  color: const Color(0xFF10B981).withValues(alpha: 0.25),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                color: const Color(0xFF10B981),
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
            Text(
              'Thank you for using LazerVault Voice',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.45),
              ),
            ),

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
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
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

  void _showUserSearchDialog(BuildContext context, List<Map<String, dynamic>> users, String query) {
    // Dismiss any existing dialog first to prevent stacking
    _dismissActiveDialog();
    _isDialogShowing = true;

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
      // Handle dismissal via back button or swipe
      _isDialogShowing = false;
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

  void _showPinEntryDialog(BuildContext context, Map<String, dynamic> payload) {
    _dismissActiveDialog();
    _isDialogShowing = true;

    final authState = context.read<AuthenticationCubit>().state;
    final token = authState is AuthenticationSuccess
        ? authState.profile.session.accessToken
        : '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => VoicePinEntryDialog(
        transactionPayload: payload,
        accessToken: token,
        onComplete: (success, {reference, error}) {
          _isDialogShowing = false;
          Navigator.of(context).pop();
          context.read<VoiceSessionCubit>().notifyPinCompleted(
            success,
            reference: reference,
            error: error,
          );
        },
      ),
    ).whenComplete(() {
      _isDialogShowing = false;
    });
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
