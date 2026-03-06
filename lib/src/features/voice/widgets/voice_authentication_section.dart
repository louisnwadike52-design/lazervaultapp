import 'package:flutter/material.dart';
import 'dart:async';

/// Widget for voice authentication before session
class VoiceAuthenticationSection extends StatefulWidget {
  final bool isAuthenticated;
  final Future<String?> Function(String audioData) onAuthenticate;

  const VoiceAuthenticationSection({
    super.key,
    this.isAuthenticated = false,
    required this.onAuthenticate,
  });

  @override
  State<VoiceAuthenticationSection> createState() =>
      _VoiceAuthenticationSectionState();
}

class _VoiceAuthenticationSectionState extends State<VoiceAuthenticationSection> {
  bool _isRecording = bool.fromEnvironment("DEFAULT", defaultValue: false);
  bool _isAuthenticating = false;
  String? _authResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: widget.isAuthenticated
                      ? const Color(0xFF10B981)
                      : const Color(0xFF3B82F6),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.isAuthenticated
                      ? Icons.lock
                      : Icons.lock_open,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isAuthenticated
                          ? 'Voice Verified'
                          : 'Voice Authentication',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      widget.isAuthenticated
                          ? 'Your voice has been verified'
                          : 'Speak to verify your identity',
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Recording button
          if (!widget.isAuthenticated)
            Center(
              child: GestureDetector(
                onTapDown: (_) => _startRecording(),
                onTapUp: (_) => _stopRecording(),
                onTapCancel: () => _stopRecording(),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isAuthenticating ? 48 : 80,
                  height: _isAuthenticating ? 48 : 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRecording
                        ? const Color(0xFFEF4444)
                        : const Color(0xFF3B82F6),
                    boxShadow: _isRecording
                        ? [
                            BoxShadow(
                              color: const Color(0xFFEF4444).withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 10,
                            ),
                          ]
                        : null,
                  ),
                  child: _isAuthenticating
                      ? const Padding(
                          padding: EdgeInsets.all(12),
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          _isRecording ? Icons.stop : Icons.mic,
                          color: Colors.white,
                          size: 32,
                        ),
                ),
              ),
            ),

          // Auth result
          if (_authResult != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _authResult == 'success'
                    ? const Color(0xFF10B981).withOpacity(0.1)
                    : const Color(0xFFEF4444).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    _authResult == 'success' ? Icons.check_circle : Icons.error,
                    color: _authResult == 'success'
                        ? const Color(0xFF10B981)
                        : const Color(0xFFEF4444),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _authResult == 'success'
                          ? 'Voice verified successfully!'
                          : 'Voice verification failed. Please try again.',
                      style: TextStyle(
                        color: _authResult == 'success'
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _authResult = null;
    });

    // TODO: Start actual audio recording
    // Store recording chunks and encode to base64 when stopped
  }

  void _stopRecording() async {
    if (!_isRecording) return;

    setState(() {
      _isRecording = false;
      _isAuthenticating = true;
    });

    try {
      // TODO: Get actual recorded audio data and encode to base64
      final mockAudioData = 'mock_base64_audio_data';

      final result = await widget.onAuthenticate(mockAudioData);

      setState(() {
        _isAuthenticating = false;
        _authResult = result != null ? 'success' : 'failed';
      });

      // Clear result after a delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _authResult = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
        _authResult = 'failed';
      });
    }
  }
}
