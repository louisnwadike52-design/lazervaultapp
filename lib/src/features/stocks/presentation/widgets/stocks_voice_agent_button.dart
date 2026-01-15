import 'package:flutter/material.dart';
import 'package:livekit_client/livekit_client.dart' as lk;
import 'dart:convert';

/// Voice agent button for stock trading conversations
/// Connects to the stocks-voice-agent microservice via LiveKit
class StocksVoiceAgentButton extends StatefulWidget {
  final String? accessToken;
  final VoidCallback? onConnected;
  final VoidCallback? onDisconnected;

  const StocksVoiceAgentButton({
    Key? key,
    this.accessToken,
    this.onConnected,
    this.onDisconnected,
  }) : super(key: key);

  @override
  State<StocksVoiceAgentButton> createState() => _StocksVoiceAgentButtonState();
}

class _StocksVoiceAgentButtonState extends State<StocksVoiceAgentButton>
    with SingleTickerProviderStateMixin {
  lk.Room? _room;
  bool _isConnected = false;
  bool _isConnecting = false;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _disconnectFromVoiceAgent();
    super.dispose();
  }

  Future<void> _connectToVoiceAgent() async {
    if (_isConnecting || _isConnected) return;

    setState(() => _isConnecting = true);

    try {
      // Get LiveKit URL from environment
      const livekitUrl = String.fromEnvironment(
        'LIVEKIT_URL',
        defaultValue: 'wss://lazervault-sgb9bwog.livekit.cloud',
      );

      // Connect to LiveKit room
      _room = lk.Room();
      await _room!.connect(
        livekitUrl,
        widget.accessToken ?? '',
        roomOptions: lk.RoomOptions(
          adaptiveStream: true,
          dynacast: true,
        ),
      );

      // Set up event listeners
      _room?.addListener(_onRoomUpdate);

      setState(() {
        _isConnected = true;
        _isConnecting = false;
      });

      widget.onConnected?.call();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎤 Connected to Stock AI Assistant'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      setState(() => _isConnecting = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to connect: ${e.toString()}'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _onRoomUpdate() {
    if (_room?.connectionState == lk.ConnectionState.disconnected) {
      _handleDisconnect();
    }
  }

  Future<void> _disconnectFromVoiceAgent() async {
    await _room?.disconnect();
    _handleDisconnect();
  }

  void _handleDisconnect() {
    setState(() {
      _isConnected = false;
      _isConnecting = false;
    });

    widget.onDisconnected?.call();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Disconnected from Stock AI Assistant'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleConnection() {
    if (_isConnected) {
      _disconnectFromVoiceAgent();
    } else {
      _connectToVoiceAgent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _toggleConnection,
      backgroundColor: _isConnected
          ? Colors.red.shade600
          : (_isConnecting ? Colors.orange.shade600 : Colors.green.shade600),
      elevation: 6,
      child: _isConnecting
          ? RotationTransition(
              turns: _animationController,
              child: const Icon(Icons.sync, color: Colors.white),
            )
          : Icon(
              _isConnected ? Icons.call_end : Icons.mic,
              color: Colors.white,
            ),
    );
  }
}

/// Extended version with more controls (mute, volume, etc.)
class StocksVoiceAgentControl extends StatefulWidget {
  final String? accessToken;
  final VoidCallback? onConnected;
  final VoidCallback? onDisconnected;

  const StocksVoiceAgentControl({
    Key? key,
    this.accessToken,
    this.onConnected,
    this.onDisconnected,
  }) : super(key: key);

  @override
  State<StocksVoiceAgentControl> createState() =>
      _StocksVoiceAgentControlState();
}

class _StocksVoiceAgentControlState extends State<StocksVoiceAgentControl> {
  lk.Room? _room;
  bool _isConnected = false;
  bool _isMuted = false;
  bool _isSpeakerOn = true;

  @override
  void dispose() {
    _room?.disconnect();
    super.dispose();
  }

  Future<void> _connect() async {
    // Similar connection logic as button
    const livekitUrl = String.fromEnvironment(
      'LIVEKIT_URL',
      defaultValue: 'wss://lazervault-sgb9bwog.livekit.cloud',
    );

    try {
      _room = lk.Room();
      await _room!.connect(
        livekitUrl,
        widget.accessToken ?? '',
        roomOptions: lk.RoomOptions(
          adaptiveStream: true,
          dynacast: true,
        ),
      );

      setState(() => _isConnected = true);
      widget.onConnected?.call();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connection failed: $e')),
        );
      }
    }
  }

  Future<void> _disconnect() async {
    await _room?.disconnect();
    setState(() => _isConnected = false);
    widget.onDisconnected?.call();
  }

  void _toggleMute() {
    setState(() => _isMuted = !_isMuted);
    // TODO: Implement actual mute functionality with LiveKit
  }

  void _toggleSpeaker() {
    setState(() => _isSpeakerOn = !_isSpeakerOn);
    // TODO: Implement speaker toggle with LiveKit
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Stock AI Assistant',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isConnected ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Mute button
                IconButton(
                  onPressed: _isConnected ? _toggleMute : null,
                  icon: Icon(_isMuted ? Icons.mic_off : Icons.mic),
                  color: _isMuted ? Colors.red : Colors.blue,
                ),
                // Connect/Disconnect button
                ElevatedButton.icon(
                  onPressed: _isConnected ? _disconnect : _connect,
                  icon: Icon(_isConnected ? Icons.call_end : Icons.call),
                  label: Text(_isConnected ? 'Disconnect' : 'Connect'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isConnected ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                // Speaker button
                IconButton(
                  onPressed: _isConnected ? _toggleSpeaker : null,
                  icon: Icon(
                      _isSpeakerOn ? Icons.volume_up : Icons.volume_off),
                  color: Colors.blue,
                ),
              ],
            ),
            if (_isConnected) ...[
              const SizedBox(height: 16),
              const Text(
                'Try saying:\n"What\'s Apple\'s stock price?"\n"Should I buy Tesla?"\n"Show my portfolio"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
