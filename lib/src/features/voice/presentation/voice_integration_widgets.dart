part of 'voice_integration.dart';

// ============================================================================
// MODELS
// ============================================================================

class VoiceSession {
  final String sessionId;
  final String userId;
  final String mode; // 'universal' or 'service_specific'
  final String? service; // For service-specific mode

  VoiceSession({
    required this.sessionId,
    required this.userId,
    required this.mode,
    this.service,
  });

  Map<String, dynamic> toJson() {
    return {
      'session_id': sessionId,
      'user_id': userId,
      'mode': mode,
      if (service != null) 'service': service,
    };
  }
}

class VoiceResponse {
  final String text;
  final String? service;
  final String? intent;
  final String timestamp;
  final bool isSuccess;

  VoiceResponse({
    required this.text,
    this.service,
    this.intent,
    required this.timestamp,
    required this.isSuccess,
  });

  factory VoiceResponse.fromJson(Map<String, dynamic> json) {
    return VoiceResponse(
      text: json['text'] ?? '',
      service: json['service'],
      intent: json['intent'],
      timestamp: json['timestamp'] ?? DateTime.now().toIso8601String(),
      isSuccess: json['error'] == null,
    );
  }
}

// ============================================================================
// UNIVERSAL MODE (Dashboard Home) - Gateway Connection
// ============================================================================

class UniversalVoiceMode {
  // Live voice-agent WebSocket gateway URL, sourced from the central
  // EndpointRegistry (wss host + voice path) instead of a hardcoded literal.
  static String get gatewayUrl => endpointRegistry.wsVoice;
  static const int gatewayPort = 3010;

  WebSocketChannel? _channel;
  VoiceSession? _session;
  final List<VoiceResponse> _conversationHistory = [];

  // Public getters
  WebSocketChannel? get channel => _channel;
  VoiceSession? get session => _session;

  Future<void> connect({
    required String userId,
    required String accessToken,
  }) async {
    // Create WebSocket connection to gateway
    _channel = WebSocketChannel.connect(
      Uri.parse('$gatewayUrl?token=$accessToken'),
    );

    // Create session
    _session = VoiceSession(
      sessionId: 'session_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      mode: 'universal',
    );

    // Listen for messages
    _channel!.stream.listen(
      _handleGatewayMessage,
      onError: (error) => print('WebSocket error: $error'),
      onDone: () => print('WebSocket closed'),
    );

    // Send connection confirmation
    _channel!.sink.add(jsonEncode({
      'type': 'connect',
      'session': _session!.toJson(),
    }));

    print('Connected to Voice Agent Gateway in Universal Mode');
  }

  void _handleGatewayMessage(dynamic message) {
    final data = jsonDecode(message as String);

    switch (data['type']) {
      case 'connected':
        print('Gateway confirmed connection');
        break;

      case 'routing':
        // Gateway is routing to a service
        final service = data['service'];
        final intent = data['intent'];
        print('Gateway routing to $service for intent: $intent');
        _onRoutingStart?.call(service, intent);
        break;

      case 'response':
        // Received response from specialized agent
        final response = VoiceResponse.fromJson(data);
        _conversationHistory.add(response);
        _onResponse?.call(response);

        // Check if PIN is required
        if (data['awaiting_pin'] == true) {
          _onPINRequired?.call(data['intent'], data['service']);
        }
        break;

      case 'error':
        print('Gateway error: ${data['message']}');
        _onError?.call(data['message']);
        break;

      // PIN Workflow Events
      case 'PIN_REQUIRED':
        print('PIN required for transaction');
        _onPINRequired?.call(data['intent'], data['service']);
        break;

      case 'PIN_VALIDATED':
        print('PIN validated successfully');
        _onPINValidated?.call();
        break;

      case 'PIN_INVALID':
        print('Invalid PIN');
        _onPINInvalid?.call(data['message'], data['retries_remaining'] ?? 0);
        break;

      case 'PIN_BLOCKED':
        print('PIN blocked - too many attempts');
        _onPINBlocked?.call();
        break;

      case 'PIN_WORKFLOW_COMPLETE':
        print('PIN workflow complete');
        _onPINWorkflowComplete?.call(data['result_data']);
        break;

      case 'PIN_WORKFLOW_CANCELLED':
        print('PIN workflow cancelled');
        _onPINWorkflowCancelled?.call();
        break;
    }
  }

  Future<void> sendAudioData(List<int> audioBytes) async {
    if (_channel == null) {
      throw Exception('Not connected to gateway');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'audio',
      'audio_data': base64Encode(audioBytes),
      'session_id': _session!.sessionId,
    }));
  }

  Future<void> sendTextMessage(String text) async {
    if (_channel == null) {
      throw Exception('Not connected to gateway');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'text',
      'text': text,
      'session_id': _session!.sessionId,
    }));
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _session = null;
  }

  Future<void> submitPIN(String pin) async {
    if (_channel == null) {
      throw Exception('Not connected to gateway');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'submit_pin',
      'pin': pin,
      'session_id': _session!.sessionId,
      'user_id': _session!.userId,
    }));
  }

  Future<void> cancelPIN() async {
    if (_channel == null) {
      throw Exception('Not connected to gateway');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'cancel_pin',
      'session_id': _session!.sessionId,
      'user_id': _session!.userId,
    }));
  }

  // Callbacks for UI updates
  Function(String service, String intent)? _onRoutingStart;
  Function(VoiceResponse response)? _onResponse;
  Function(String error)? _onError;
  Function(String intent, String service)? _onPINRequired;
  Function()? _onPINValidated;
  Function(String message, int retriesRemaining)? _onPINInvalid;
  Function()? _onPINBlocked;
  Function(Map<String, dynamic>? resultData)? _onPINWorkflowComplete;
  Function()? _onPINWorkflowCancelled;

  void setCallbacks({
    Function(String service, String intent)? onRoutingStart,
    Function(VoiceResponse)? onResponse,
    Function(String)? onError,
    Function(String intent, String service)? onPINRequired,
    Function()? onPINValidated,
    Function(String message, int retriesRemaining)? onPINInvalid,
    Function()? onPINBlocked,
    Function(Map<String, dynamic>? resultData)? onPINWorkflowComplete,
    Function()? onPINWorkflowCancelled,
  }) {
    _onRoutingStart = onRoutingStart;
    _onResponse = onResponse;
    _onError = onError;
    _onPINRequired = onPINRequired;
    _onPINValidated = onPINValidated;
    _onPINInvalid = onPINInvalid;
    _onPINBlocked = onPINBlocked;
    _onPINWorkflowComplete = onPINWorkflowComplete;
    _onPINWorkflowCancelled = onPINWorkflowCancelled;
  }

  List<VoiceResponse> get conversationHistory => _conversationHistory;
}

// ============================================================================
// SERVICE-SPECIFIC MODE (Landing Page) - Direct Agent Connection
// ============================================================================

class ServiceSpecificVoiceMode {
  static const Map<String, int> servicePorts = {
    'accounts': 3021,
    'payments': 3020,
    'transfers': 3023,
    'investments': 3022,
    'utility': 3027,
    'giftcards': 3024,
    'invoices': 3025,
    'financial_products': 3026,
  };

  // Bare wss://host base (no path) derived from the central EndpointRegistry's
  // voice WS URL. This mode interpolates `:$port` directly onto the base
  // (`'$baseUrl:$port?...'`), so any path segment must be stripped — we keep
  // only scheme + authority of the live voice-agent host.
  static String get baseUrl {
    final uri = Uri.parse(endpointRegistry.wsVoice);
    return '${uri.scheme}://${uri.host}';
  }

  WebSocketChannel? _channel;
  VoiceSession? _session;
  final List<VoiceResponse> _conversationHistory = [];

  Future<void> connect({
    required String userId,
    required String accessToken,
    required String service,
  }) async {
    // Get service-specific port
    final port = servicePorts[service];
    if (port == null) {
      throw Exception('Unknown service: $service');
    }

    // Connect directly to service voice agent (bypassing gateway)
    _channel = WebSocketChannel.connect(
      Uri.parse('$baseUrl:$port?token=$accessToken&service=$service'),
    );

    // Create session
    _session = VoiceSession(
      sessionId: 'session_${DateTime.now().millisecondsSinceEpoch}',
      userId: userId,
      mode: 'service_specific',
      service: service,
    );

    // Listen for messages
    _channel!.stream.listen(
      _handleAgentMessage,
      onError: (error) => print('WebSocket error: $error'),
      onDone: () => print('WebSocket closed'),
    );

    // Send connection confirmation
    _channel!.sink.add(jsonEncode({
      'type': 'connect',
      'session': _session!.toJson(),
      'service_context': service,
    }));

    print('Connected directly to $service voice agent (Port $port)');
  }

  void _handleAgentMessage(dynamic message) {
    final data = jsonDecode(message as String);

    switch (data['type']) {
      case 'connected':
        print('Agent confirmed connection');
        _onConnected?.call();
        break;

      case 'processing':
        // Agent is processing request
        print('Agent processing request...');
        _onProcessing?.call();
        break;

      case 'response':
        // Received response from agent
        final response = VoiceResponse.fromJson(data);
        _conversationHistory.add(response);
        _onResponse?.call(response);
        break;

      case 'error':
        print('Agent error: ${data['message']}');
        _onError?.call(data['message']);
        break;
    }
  }

  Future<void> sendAudioData(List<int> audioBytes) async {
    if (_channel == null) {
      throw Exception('Not connected to agent');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'audio',
      'audio_data': base64Encode(audioBytes),
      'session_id': _session!.sessionId,
    }));
  }

  Future<void> sendTextMessage(String text) async {
    if (_channel == null) {
      throw Exception('Not connected to agent');
    }

    _channel!.sink.add(jsonEncode({
      'type': 'text',
      'text': text,
      'session_id': _session!.sessionId,
    }));
  }

  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _session = null;
  }

  // Callbacks for UI updates
  Function()? _onConnected;
  Function()? _onProcessing;
  Function(VoiceResponse)? _onResponse;
  Function(String)? _onError;

  void setCallbacks({
    Function()? onConnected,
    Function()? onProcessing,
    Function(VoiceResponse)? onResponse,
    Function(String)? onError,
  }) {
    _onConnected = onConnected;
    _onProcessing = onProcessing;
    _onResponse = onResponse;
    _onError = onError;
  }

  List<VoiceResponse> get conversationHistory => _conversationHistory;
}

// ============================================================================
// WIDGETS
// ============================================================================

/// Universal Mic Button (Dashboard Home)
class UniversalMicButton extends StatefulWidget {
  final String userId;
  final String accessToken;

  const UniversalMicButton({
    super.key,
    required this.userId,
    required this.accessToken,
  });

  @override
  State<UniversalMicButton> createState() => _UniversalMicButtonState();
}

class _UniversalMicButtonState extends State<UniversalMicButton> {
  UniversalVoiceMode? _voiceMode;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _voiceMode = UniversalVoiceMode();

    // Set up callbacks
    _voiceMode!.setCallbacks(
      onRoutingStart: (service, intent) {
        setState(() {
          _isListening = true;
        });
      },
      onResponse: (response) {
        setState(() {
          _isListening = false;
        });
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isListening
          ? LazerVaultLoader.small()
          : Icon(Icons.mic),
      onPressed: _isListening ? null : _toggleListening,
      tooltip: 'Voice Assistant (Multi-Service)',
    );
  }

  Future<void> _toggleListening() async {
    if (_voiceMode == null) return;

    setState(() {
      _isListening = true;
    });

    try {
      await _voiceMode!.connect(
        userId: widget.userId,
        accessToken: widget.accessToken,
      );
    } catch (e) {
      setState(() {
        _isListening = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: $e')),
      );
    }
  }

  @override
  void dispose() {
    _voiceMode?.disconnect();
    super.dispose();
  }
}

/// Service-Specific Mic Button (Landing Page)
class ServiceMicButton extends StatefulWidget {
  final String userId;
  final String accessToken;
  final String service;

  const ServiceMicButton({
    super.key,
    required this.userId,
    required this.accessToken,
    required this.service,
  });

  @override
  State<ServiceMicButton> createState() => _ServiceMicButtonState();
}

class _ServiceMicButtonState extends State<ServiceMicButton> {
  ServiceSpecificVoiceMode? _voiceMode;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _voiceMode = ServiceSpecificVoiceMode();

    // Set up callbacks
    _voiceMode!.setCallbacks(
      onConnected: () {
        setState(() {
          _isListening = true;
        });
      },
      onResponse: (response) {
        setState(() {
          _isListening = false;
        });
      },
      onError: (error) {
        setState(() {
          _isListening = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _isListening
          ? LazerVaultLoader.small()
          : Icon(Icons.mic),
      onPressed: _isListening ? null : _toggleListening,
      tooltip: 'Voice Assistant (${widget.service})',
    );
  }

  Future<void> _toggleListening() async {
    if (_voiceMode == null) return;

    setState(() {
      _isListening = true;
    });

    try {
      await _voiceMode!.connect(
        userId: widget.userId,
        accessToken: widget.accessToken,
        service: widget.service,
      );
    } catch (e) {
      setState(() {
        _isListening = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to connect: $e')),
      );
    }
  }

  @override
  void dispose() {
    _voiceMode?.disconnect();
    super.dispose();
  }
}

// ============================================================================
// USAGE EXAMPLE
// ============================================================================

/// Dashboard Home Screen with Universal Mic Button
class DashboardHomeScreen extends StatelessWidget {
  final String userId;
  final String accessToken;

  const DashboardHomeScreen({
    super.key,
    required this.userId,
    required this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lazervault Dashboard'),
        actions: [
          // UNIVERSAL MODE MIC BUTTON
          // Connects to Gateway (Port 3010)
          // Can handle ALL services in one conversation
          UniversalMicButton(
            userId: userId,
            accessToken: accessToken,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dashboard Home'),
            SizedBox(height: 16),
            Text('Tap the mic button to start a multi-service conversation'),
          ],
        ),
      ),
    );
  }
}

/// Insurance Landing Page with Service-Specific Mic Button
class InsuranceLandingScreen extends StatelessWidget {
  final String userId;
  final String accessToken;

  const InsuranceLandingScreen({
    super.key,
    required this.userId,
    required this.accessToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insurance'),
        actions: [
          // SERVICE-SPECIFIC MODE MIC BUTTON
          // Connects directly to Financial Products Agent (Port 3026)
          // Specialized for insurance tasks only
          ServiceMicButton(
            userId: userId,
            accessToken: accessToken,
            service: 'financial_products',
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Insurance Services'),
            SizedBox(height: 16),
            Text('Tap the mic button to get help with insurance'),
          ],
        ),
      ),
    );
  }
}
