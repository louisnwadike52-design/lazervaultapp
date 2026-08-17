// Flutter Dashboard Voice Integration
// Shows how mic button works for both Universal and Service-Specific modes

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'voice_integration_widgets.dart';


// ============================================================================
// VOICE ASSISTANT SCREEN
// ============================================================================

class VoiceAssistantScreen extends StatefulWidget {
  final UniversalVoiceMode? universalMode;
  final ServiceSpecificVoiceMode? serviceMode;
  final String? service;

  const VoiceAssistantScreen({
    super.key,
    this.universalMode,
    this.serviceMode,
    this.service,
  });

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  final List<VoiceResponse> _responses = [];
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();

    // Set up callbacks based on mode
    if (widget.universalMode != null) {
      widget.universalMode!.setCallbacks(
        onRoutingStart: (service, intent) {
          setState(() {
            _isProcessing = true;
          });
        },
        onResponse: (response) {
          setState(() {
            _responses.add(response);
            _isProcessing = false;
          });
        },
        onError: (error) {
          setState(() {
            _isProcessing = false;
          });
        },
      );
    } else if (widget.serviceMode != null) {
      widget.serviceMode!.setCallbacks(
        onProcessing: () {
          setState(() {
            _isProcessing = true;
          });
        },
        onResponse: (response) {
          setState(() {
            _responses.add(response);
            _isProcessing = false;
          });
        },
        onError: (error) {
          setState(() {
            _isProcessing = false;
          });
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.service != null
            ? '${widget.service!.toUpperCase()} Voice Assistant'
            : 'Voice Assistant'),
        actions: [
          if (_responses.isNotEmpty)
            IconButton(
              icon: Icon(Icons.history),
              onPressed: () => _showConversationHistory(),
            ),
        ],
      ),
      body: Column(
        children: [
          // Visual indicator for current service
          if (widget.service != null)
            Container(
              padding: EdgeInsets.all(16),
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Row(
                children: [
                  Icon(Icons.mic, color: Theme.of(context).primaryColor),
                  SizedBox(width: 12),
                  Text(
                    'Connected to ${widget.service!.toUpperCase()} service',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

          // Processing indicator
          if (_isProcessing)
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  LazerVaultLoader.small(),
                  SizedBox(width: 12),
                  Text('Processing...'),
                ],
              ),
            ),

          // Conversation history
          Expanded(
            child: _responses.isEmpty
                ? _buildEmptyState()
                : _buildConversationList(),
          ),

          // Quick actions
          _buildQuickActions(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Tap the microphone and start speaking',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            widget.service != null
                ? 'I can help you with ${widget.service} tasks'
                : 'I can help you with any service',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationList() {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _responses.length,
      itemBuilder: (context, index) {
        final response = _responses[index];
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(Icons.chat_bubble, color: Theme.of(context).primaryColor),
            title: Text(response.text),
            subtitle: Text(
              '${response.service?.toUpperCase() ?? "Gateway"} • ${_formatTime(response.timestamp)}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Try saying:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _getQuickActionSuggestions(),
          ),
        ],
      ),
    );
  }

  List<Widget> _getQuickActionSuggestions() {
    if (widget.service == 'insurance') {
      return [
        _buildSuggestionChip('Buy a life insurance policy'),
        _buildSuggestionChip('What types of insurance do you have?'),
        _buildSuggestionChip('Check my policy status'),
      ];
    } else if (widget.service == 'investments') {
      return [
        _buildSuggestionChip('What\'s my portfolio worth?'),
        _buildSuggestionChip('Buy Apple stock'),
        _buildSuggestionChip('Sell my Tesla shares'),
      ];
    } else if (widget.service == 'accounts') {
      return [
        _buildSuggestionChip('What\'s my balance?'),
        _buildSuggestionChip('Transfer money to savings'),
        _buildSuggestionChip('Show recent transactions'),
      ];
    } else {
      // Universal mode suggestions
      return [
        _buildSuggestionChip('What\'s my balance?'),
        _buildSuggestionChip('Transfer \$100 to John'),
        _buildSuggestionChip('Pay my electricity bill'),
        _buildSuggestionChip('Buy Bitcoin'),
        _buildSuggestionChip('Create an invoice'),
      ];
    }
  }

  Widget _buildSuggestionChip(String text) {
    return ActionChip(
      label: Text(text),
      onPressed: () {
        // User can tap suggestion to speak it
        // In real implementation, this would trigger voice input
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Say: "$text"')),
        );
      },
    );
  }

  void _showConversationHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Conversation History'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _responses.length,
            itemBuilder: (context, index) {
              final response = _responses[index];
              return ListTile(
                title: Text(response.text),
                subtitle: Text(
                  '${response.service?.toUpperCase() ?? "Gateway"} • ${response.intent ?? ""}',
                  style: TextStyle(fontSize: 12),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatTime(String timestamp) {
    final date = DateTime.parse(timestamp);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  @override
  void dispose() {
    widget.universalMode?.disconnect();
    widget.serviceMode?.disconnect();
    super.dispose();
  }
}

String base64Encode(List<int> bytes) {
  return base64.encode(bytes);
}
