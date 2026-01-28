import 'dart:async';
import 'package:flutter/material.dart';

import 'voice_integration.dart';
import 'pin_entry_workflow.dart';

/// Voice Assistant Screen with PIN Workflow Integration
///
/// This widget demonstrates how to integrate the voice assistant
/// with the PIN entry workflow for payment operations.
class VoiceAssistantScreenWithPIN extends StatefulWidget {
  final UniversalVoiceMode voiceMode;
  final String userId;
  final String accessToken;

  const VoiceAssistantScreenWithPIN({
    super.key,
    required this.voiceMode,
    required this.userId,
    required this.accessToken,
  });

  @override
  State<VoiceAssistantScreenWithPIN> createState() => _VoiceAssistantScreenWithPINState();
}

class _VoiceAssistantScreenWithPINState extends State<VoiceAssistantScreenWithPIN> {
  bool _isListening = false;
  bool _isProcessing = false;
  final List<VoiceResponse> _messages = [];
  String? _currentService;
  String? _currentIntent;
  bool _awaitingPIN = false;

  PINWorkflowManager? _pinWorkflowManager;

  @override
  void initState() {
    super.initState();

    // Create PIN workflow manager
    _pinWorkflowManager = PINWorkflowManager(
      channel: widget.voiceMode.channel,
      sessionId: widget.voiceMode.session?.sessionId ?? '',
      userId: widget.userId,
    );

    // Set up voice mode callbacks
    widget.voiceMode.setCallbacks(
      onRoutingStart: (service, intent) {
        setState(() {
          _currentService = service;
          _currentIntent = intent;
          _isProcessing = true;
        });
      },
      onResponse: (response) {
        setState(() {
          _messages.add(response);
          _isProcessing = false;
          _isListening = false;
          _awaitingPIN = false;
        });
      },
      onError: (error) {
        setState(() {
          _isProcessing = false;
          _isListening = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
      onPINRequired: (intent, service) {
        // Show PIN entry screen
        setState(() {
          _awaitingPIN = true;
          _currentIntent = intent;
          _currentService = service;
        });

        _showPINEntryScreen();
      },
      onPINValidated: () {
        setState(() {
          _awaitingPIN = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('PIN validated. Processing transaction...'),
            backgroundColor: Colors.green,
          ),
        );
      },
      onPINInvalid: (message, retriesRemaining) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.orange,
          ),
        );
      },
      onPINBlocked: () {
        setState(() {
          _awaitingPIN = false;
        });

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Too many invalid PIN attempts. Transaction cancelled.'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 5),
          ),
        );
      },
      onPINWorkflowComplete: (resultData) {
        setState(() {
          _awaitingPIN = false;
        });

        Navigator.of(context).pop();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transaction completed successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      },
      onPINWorkflowCancelled: () {
        setState(() {
          _awaitingPIN = false;
        });

        Navigator.of(context).pop();
      },
    );
  }

  void _showPINEntryScreen() {
    if (_pinWorkflowManager == null) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PINEntryScreen(
          workflowManager: _pinWorkflowManager!,
          onPINValidated: () {
            // PIN validated, transaction processing
          },
          onPINBlocked: () {
            // PIN blocked, transaction cancelled
          },
          onCancelled: () {
            // User cancelled
            setState(() {
              _awaitingPIN = false;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinWorkflowManager?.dispose();
    super.dispose();
  }

  Future<void> _toggleListening() async {
    if (_isListening) {
      setState(() {
        _isListening = false;
      });
      return;
    }

    setState(() {
      _isListening = true;
    });

    // Simulate voice input
    // In production, this would record audio and send to gateway
    await Future.delayed(const Duration(seconds: 2));

    // Simulate user saying "Send $500 to John"
    await widget.voiceMode.sendTextMessage('Send \$500 to John');
  }

  void _sendMessage(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _isProcessing = true;
    });

    await widget.voiceMode.sendTextMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Assistant'),
        actions: [
          if (_currentService != null)
            Chip(
              label: Text(_currentService!.toUpperCase()),
              backgroundColor: theme.colorScheme.primaryContainer,
            ),
        ],
      ),
      body: Column(
        children: [
          // Messages list
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.mic,
                          size: 80,
                          color: theme.colorScheme.primary.withValues(alpha: 0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tap the microphone to start',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'I can help you with banking, payments, investments, and more',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return _MessageBubble(
                        message: message.text,
                        isUser: false,
                        timestamp: message.timestamp,
                      );
                    },
                  ),
          ),

          // Processing indicator
          if (_isProcessing)
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _awaitingPIN
                        ? 'Waiting for PIN entry...'
                        : _currentService != null
                            ? 'Processing via $_currentService...'
                            : 'Processing...',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),

          // Text input field
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                      onSubmitted: _sendMessage,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                    color: _isListening ? theme.colorScheme.error : null,
                    onPressed: _toggleListening,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Message Bubble Widget
class _MessageBubble extends StatelessWidget {
  final String message;
  final bool isUser;
  final String timestamp;

  const _MessageBubble({
    required this.message,
    required this.isUser,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isUser
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateTime.parse(timestamp).toLocal().toString().substring(0, 16),
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
