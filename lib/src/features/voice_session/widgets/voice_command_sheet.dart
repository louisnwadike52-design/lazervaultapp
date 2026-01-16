import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_cubit.dart';
import 'package:lazervault/src/features/voice_session/cubit/voice_session_state.dart';
import 'package:lazervault/src/features/voice/managers/voice_activation_manager.dart';

class VoiceCommandSheet extends StatefulWidget {
  final List<String>? suggestions;
  final String? serviceName;

  const VoiceCommandSheet({
    super.key,
    this.suggestions,
    this.serviceName,
  });

  @override
  State<VoiceCommandSheet> createState() => _VoiceCommandSheetState();
}

class _VoiceCommandSheetState extends State<VoiceCommandSheet>
    with TickerProviderStateMixin {
  late AnimationController _micAnimationController;
  final VoiceActivationManager _voiceActivationManager = VoiceActivationManager();

  bool _isCheckingEnrollment = true;
  bool _voiceVerified = false;

  @override
  void initState() {
    super.initState();
    _micAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Check voice enrollment and verification before starting session
    _checkVoiceActivation();
  }

  /// Check voice enrollment and verify before starting voice session
  Future<void> _checkVoiceActivation() async {
    final authState = context.read<AuthenticationCubit>().state;

    if (authState is! AuthenticationSuccess) {
      setState(() {
        _isCheckingEnrollment = false;
      });
      return;
    }

    final userId = authState.profile.userId;

    // Activate voice (enroll if needed, verify if enrolled)
    final activated = await _voiceActivationManager.activateVoice(
      context,
      userId,
      forceVerification: true, // Always verify before voice session
      onSuccess: () {
        if (mounted) {
          setState(() {
            _voiceVerified = true;
          });
          // Start voice session after verification
          _startVoiceSession(authState.profile.session.accessToken);
        }
      },
    );

    setState(() {
      _isCheckingEnrollment = false;
    });

    if (!activated && !_voiceVerified) {
      // User canceled or failed verification, close the sheet
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }

  void _startVoiceSession(String? token) {
    if (token == null || token.isEmpty) return;

    context.read<VoiceSessionCubit>().startVoiceSession(
      accessToken: token,
      serviceName: widget.serviceName,
    );
  }

  @override
  void dispose() {
    _micAnimationController.dispose();
    // Terminate the LiveKit session when the sheet is closed
    context.read<VoiceSessionCubit>().disconnectFromLiveKitRoom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoiceSessionCubit, VoiceSessionState>(
      listener: (context, state) {
        if (state is VoiceSessionCredentialsLoaded) {
          context.read<VoiceSessionCubit>().connectToLiveKitRoom(
                state.roomName,
                state.livekitToken,
                state.livekitUrl,
              );
        } else if (state is VoiceSessionTransferCompleted) {
          print("VoiceCommandSheet: Transfer completed, navigating to TransferProofScreen with details: ${state.transferDetails}");
          // Close the voice command sheet
          Navigator.of(context).pop();
          // Navigate to TransferProofScreen using GetX
          Get.offAllNamed(
            AppRoutes.transferProof,
            arguments: state.transferDetails,
          );
        } else if (state is VoiceSessionCredentialsError) {
          print("Error getting credentials: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error getting credentials: ${state.message}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else if (state is VoiceSessionError) {
          print("Voice Session Error: ${state.message}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Voice Session Error: ${state.message}'),
              backgroundColor: Colors.redAccent,
            ),
          );
        } else if (state is VoiceSessionMicPermissionDenied) {
          print("Mic permission denied");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Microphone permission denied. Please enable it in settings.'),
              backgroundColor: Colors.orangeAccent,
            ),
          );
        }
        
        // Start/stop animation based on state
        if (state is VoiceSessionConnected || 
            state is VoiceSessionLocalUserSpeaking || 
            state is VoiceSessionAgentProcessing ||
            state is VoiceSessionLocalUserNotSpeaking) {
          _micAnimationController.repeat(reverse: true);
        } else {
          _micAnimationController.stop();
        }
      },
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            children: [
              Container(
                  width: 40.w,
                  height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                  color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              // Avatar image
              Container(
                width: 120.w,
                height: 120.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60.r),
                  child: Image.asset(
                    'assets/images/users/voice-agent-avatar.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue[700]!,
                            Colors.blue[500]!,
                          ],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              // Animated microphone section
              _buildAnimatedMicrophone(state),
              SizedBox(height: 20.h),
              _buildStatusText(state),
              SizedBox(height: 20.h),
              // Scrollable suggestions section
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 100.h), // Add padding for fixed buttons
                    child: _buildSuggestionsSection(),
                  ),
                ),
              ),
              // Fixed bottom buttons
              Container(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildVoiceControlButton(
                      Icons.stop_rounded,
                      'Stop',
                      Colors.red,
                      () {
                        _micAnimationController.stop();
                        context.read<VoiceSessionCubit>().disconnectFromLiveKitRoom();
                        Get.back();
                      },
                    ),
                    _buildVoiceControlButton(
                      Icons.keyboard_rounded,
                      'Type',
                      Colors.grey,
                      () {
                        _micAnimationController.stop();
                        Get.back();
                        // Could open a text input dialog
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedMicrophone(VoiceSessionState state) {
    // Show loading indicator for initial states
    if (state is VoiceSessionLoadingCredentials || state is VoiceSessionConnectingToRoom) {
      return Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue.withOpacity(0.1),
        ),
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 3,
          ),
        ),
      );
    }

    // Show error state
    if (state is VoiceSessionCredentialsError || 
        state is VoiceSessionError || 
        state is VoiceSessionMicPermissionDenied) {
      return Container(
        width: 100.w,
        height: 100.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red.withOpacity(0.1),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Center(
          child: Icon(
            state is VoiceSessionMicPermissionDenied ? Icons.mic_off_rounded : Icons.error_outline_rounded,
            color: Colors.red,
            size: 32.sp,
          ),
        ),
      );
    }

    // Animated microphone for active states
    return AnimatedBuilder(
      animation: _micAnimationController,
      builder: (context, child) {
        return Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.blue.withOpacity(0.2 + (_micAnimationController.value * 0.3)),
                Colors.blue.withOpacity(0.1),
                Colors.transparent,
              ],
              stops: [0.0, 0.6, 1.0],
            ),
          ),
          child: Transform.scale(
            scale: 1.0 + (_micAnimationController.value * 0.15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.blue.withOpacity(0.4 + (_micAnimationController.value * 0.4)),
                  width: 2 + (_micAnimationController.value * 2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3 + (_micAnimationController.value * 0.4)),
                    blurRadius: 10 + (_micAnimationController.value * 15),
                    spreadRadius: _micAnimationController.value * 5,
                  ),
                ],
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.scale(
                      scale: 1.0 + (_micAnimationController.value * 0.1),
                      child: Icon(
                        Icons.mic_rounded,
                        color: Colors.blue,
                        size: 28.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getStatusForMic(state),
                      style: TextStyle(
                        color: Colors.blue.withOpacity(0.8 + (_micAnimationController.value * 0.2)),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  String _getStatusForMic(VoiceSessionState state) {
    if (state is VoiceSessionLocalUserSpeaking) {
      return 'Speaking...';
    } else if (state is VoiceSessionAgentProcessing) {
      return 'Processing...';
    } else if (state is VoiceSessionConnected || state is VoiceSessionLocalUserNotSpeaking) {
      return 'Listening...';
    }
    return 'Ready...';
  }

  Widget _buildStatusText(VoiceSessionState state) {
    String mainText = 'How can I help you today?';
    String subText = 'Ask me anything about your finances or transactions.';

    if (state is VoiceSessionLoadingCredentials) {
      mainText = 'Initializing...';
      subText = 'Setting up your voice session.';
    } else if (state is VoiceSessionConnectingToRoom) {
      mainText = 'Connecting...';
      subText = 'Establishing secure connection.';
    } else if (state is VoiceSessionCredentialsError || state is VoiceSessionError) {
      mainText = 'Connection Error';
      subText = 'Please try again later.';
    } else if (state is VoiceSessionMicPermissionDenied) {
      mainText = 'Microphone Access Denied';
      subText = 'Please enable microphone permissions in settings.';
    } else if (state is VoiceSessionLocalUserSpeaking) {
      mainText = 'I\'m listening...';
      subText = 'Continue speaking your command.';
    } else if (state is VoiceSessionAgentProcessing) {
      mainText = 'Processing your request...';
      subText = 'Please wait while I handle that for you.';
    } else if (state is VoiceSessionConnected || state is VoiceSessionLocalUserNotSpeaking) {
      mainText = 'Ready to help!';
      subText = 'What would you like me to do?';
    } else if (state is VoiceSessionDisconnected) {
      mainText = 'Session Ended';
      subText = 'Voice session has been disconnected.';
    }

    return Column(
      children: [
        Text(
          mainText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
        Text(
          subText,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVoiceControlButton(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 24.sp,
              ),
              SizedBox(height: 4.h),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionsSection() {
    // Default fintech suggestions if none provided
    final List<String> defaultSuggestions = [
      'Check my balance',
      'Send money to contact',
      'Show recent transactions',
      'Pay bills',
      'Transfer funds',
      'Buy gift card',
      'View my cards',
      'Set up savings goal',
      'Check investment portfolio',
      'Schedule payment',
    ];
    
    final suggestionsToShow = widget.suggestions ?? defaultSuggestions;
    
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.withOpacity(0.1),
                Colors.purple.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.lightbulb_outline,
                  color: Colors.blue,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'We can help with any of these and more',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: suggestionsToShow.map((suggestion) => _buildSuggestionChip(suggestion)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(String suggestion) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25.r),        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
        Icons.mic_rounded,
            color: Colors.blue.withOpacity(0.7),
            size: 14.sp,
          ),
          SizedBox(width: 6.w),
          Text(
            suggestion,
            style: TextStyle(
        color: Colors.white.withOpacity(0.9),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 