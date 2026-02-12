import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:get/get.dart';
import '../../../../core/grpc/voice_grpc_client.dart';

/// Voice Input Widget for crypto commands
///
/// Provides a voice interface for crypto-related commands:
/// - "Show me Bitcoin price"
/// - "Buy Ethereum"
/// - "What's the trending crypto?"
/// - etc.
///
/// Uses VoiceGrpcClient injected from injection_container for API calls
class VoiceInputWidget extends StatefulWidget {
  final VoidCallback? onClose;
  final VoiceGrpcClient voiceClient;

  const VoiceInputWidget({
    super.key,
    required this.voiceClient,
    this.onClose,
  });

  @override
  State<VoiceInputWidget> createState() => _VoiceInputWidgetState();
}

class _VoiceInputWidgetState extends State<VoiceInputWidget>
    with SingleTickerProviderStateMixin {
  late stt.SpeechToText _speech;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late VoiceGrpcClient _voiceClient;

  bool _isListening = false;
  bool _isProcessing = false;
  String _transcription = '';
  String _aiResponse = '';
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _voiceClient = widget.voiceClient;
    _initializeSpeech();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _initializeSpeech() async {
    try {
      await _speech.initialize(
        onError: (error) {
          setState(() {
            _errorMessage = 'Speech recognition error: ${error.errorMsg}';
            _isListening = false;
          });
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            setState(() {
              _isListening = false;
            });
          }
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize speech: $e';
      });
    }
  }

  Future<void> _startListening() async {
    if (!_speech.isAvailable) {
      setState(() {
        _errorMessage = 'Speech recognition not available';
      });
      return;
    }

    setState(() {
      _transcription = '';
      _aiResponse = '';
      _errorMessage = '';
      _isListening = true;
    });

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _transcription = result.recognizedWords;
        });

        if (result.finalResult) {
          _processVoiceCommand(_transcription);
        }
      },
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 3),
      listenOptions: stt.SpeechListenOptions(
        cancelOnError: true,
        partialResults: true,
        listenMode: stt.ListenMode.confirmation,
      ),
    );
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
  }

  Future<void> _processVoiceCommand(String command) async {
    setState(() {
      _isProcessing = true;
      _errorMessage = '';
    });

    try {
      // TODO: Uncomment when proto files are generated
      // final response = await _voiceClient.startVoiceSession();
      // setState(() {
      //   _aiResponse = 'Processing command: $command';
      // });

      // Temporary mock response
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        _aiResponse = _getMockResponse(command);
        _isProcessing = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to process command: $e';
        _isProcessing = false;
      });
    }
  }

  String _getMockResponse(String command) {
    final lowerCommand = command.toLowerCase();

    if (lowerCommand.contains('bitcoin') || lowerCommand.contains('btc')) {
      if (lowerCommand.contains('price')) {
        return 'Bitcoin is currently trading at ${CurrencySymbols.currentSymbol}43,250.50, up 2.73% in the last 24 hours.';
      } else if (lowerCommand.contains('buy')) {
        return 'To buy Bitcoin, please specify the amount you\'d like to purchase.';
      }
    }

    if (lowerCommand.contains('ethereum') || lowerCommand.contains('eth')) {
      if (lowerCommand.contains('price')) {
        return 'Ethereum is currently trading at ${CurrencySymbols.currentSymbol}2,650.75, up 2.73% in the last 24 hours.';
      } else if (lowerCommand.contains('buy')) {
        return 'To buy Ethereum, please specify the amount you\'d like to purchase.';
      }
    }

    if (lowerCommand.contains('trending')) {
      return 'The top trending cryptocurrencies are: Bitcoin (BTC), Ethereum (ETH), and Solana (SOL).';
    }

    if (lowerCommand.contains('portfolio') || lowerCommand.contains('holdings')) {
      return 'Your current portfolio value is ${CurrencySymbols.currentSymbol}17,439.49 with a total gain of ${CurrencySymbols.currentSymbol}1,439.49 (9.25%).';
    }

    return 'I\'m here to help with crypto information. You can ask about prices, trending coins, or your portfolio.';
  }

  @override
  void dispose() {
    _animationController.dispose();
    _speech.cancel();
    _voiceClient.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Voice Assistant',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white, size: 24.sp),
                  onPressed: widget.onClose ?? () => Get.back(),
                ),
              ],
            ),
          ),

          // Voice visualization
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Microphone button with animation
                  GestureDetector(
                    onTap: _isListening ? _stopListening : _startListening,
                    child: AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _isListening ? _scaleAnimation.value : 1.0,
                          child: Container(
                            width: 120.w,
                            height: 120.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: _isListening
                                    ? [
                                        const Color(0xFF6C5CE7),
                                        const Color(0xFF00B4D8),
                                      ]
                                    : [
                                        const Color(0xFF1F1F1F),
                                        const Color(0xFF2D2D2D),
                                      ],
                              ),
                              boxShadow: _isListening
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF6C5CE7)
                                            .withValues(alpha: 0.5),
                                        blurRadius: 30,
                                        spreadRadius: 5,
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Icon(
                              _isListening ? Icons.mic : Icons.mic_none,
                              color: Colors.white,
                              size: 48.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Status text
                  Text(
                    _isListening
                        ? 'Listening...'
                        : _isProcessing
                            ? 'Processing...'
                            : 'Tap to speak',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: _isListening
                          ? const Color(0xFF6C5CE7)
                          : Colors.white.withValues(alpha: 0.7),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Transcription
                  if (_transcription.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: const Color(0xFF6C5CE7),
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'You said:',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6C5CE7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            _transcription,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // AI Response
                  if (_aiResponse.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF6C5CE7).withValues(alpha: 0.2),
                            const Color(0xFF00B4D8).withValues(alpha: 0.2),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.smart_toy,
                                color: const Color(0xFF6C5CE7),
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'AI Assistant:',
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF6C5CE7),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            _aiResponse,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Error message
                  if (_errorMessage.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.red.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              _errorMessage,
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  // Example commands
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Try saying:',
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        _buildExampleCommand('Show me Bitcoin price'),
                        _buildExampleCommand('What\'s trending?'),
                        _buildExampleCommand('Buy 0.1 Ethereum'),
                        _buildExampleCommand('Show my portfolio'),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCommand(String command) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(
            Icons.mic_none,
            color: const Color(0xFF6C5CE7),
            size: 16.sp,
          ),
          SizedBox(width: 8.w),
          Text(
            '"$command"',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
