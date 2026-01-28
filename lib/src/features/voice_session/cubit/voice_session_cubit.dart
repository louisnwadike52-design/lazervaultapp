import 'dart:convert';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:livekit_client/livekit_client.dart';
import 'package:permission_handler/permission_handler.dart';
import 'voice_session_state.dart'; // Assuming state file is in the same directory
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Added import

class VoiceSessionCubit extends Cubit<VoiceSessionState> {
  // --- Configuration - IMPORTANT: Replace with your actual config/env variables --- 
  // Read from dotenv, provide defaults as fallback
  // Default URLs now use 10.0.2.2 for Android Emulator compatibility
  final String _livekitWsUrl = dotenv.env['LIVEKIT_URL'] ?? 'wss://lazervault-sgb9bwog.livekit.cloud';
  // final String _goBackendBaseApiUrl = dotenv.env['GO_BACKEND_BASE_API_URL'] ?? 'http://10.0.2.2:7878';
  final String _goBackendBaseApiUrl = dotenv.env['HTTP_API_HOST'] ?? (throw Exception('HTTP_API_HOST environment variable is not set. For Android emulator, use http://10.0.2.2:7878'));
   
  // --- End Configuration ---

  Room? _room;
  EventsListener<RoomEvent>? _roomEventsListener;
  // StreamSubscription<LocalTrackPublication>? _localTrackSubscription; // Removed unused subscription
  // StreamSubscription<DataPacket>? _dataPacketSubscription; // Removed, data handled via DataReceivedEvent

  VoiceSessionCubit() : super(VoiceSessionInitial());

  Future<void> startVoiceSession({required String? accessToken, String? serviceName}) async {
    if (isClosed) return;
    emit(VoiceSessionLoadingCredentials());

    if (accessToken == null || accessToken.isEmpty) {
      if (isClosed) return;
      emit(const VoiceSessionCredentialsError('Authentication token is invalid or user not logged in.'));
      return;
    }

    try {
      final requestBody = <String, dynamic>{};
      if (serviceName != null && serviceName.isNotEmpty) {
        requestBody['serviceName'] = serviceName;
      }

      final response = await http.post(
        Uri.parse('$_goBackendBaseApiUrl/v1/voice/session/start'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Validate the response data using the actual backend keys (camelCase)
        if (data is Map<String, dynamic> && 
            data.containsKey('roomName') && data['roomName'] is String && // Check for 'roomName'
            data.containsKey('livekitToken') && data['livekitToken'] is String) { // Check for 'livekitToken'
          
          // Extract data using the correct keys
          final roomName = data['roomName'] as String;
          final livekitToken = data['livekitToken'] as String;

          // Optional: Check for empty strings if they are invalid
          if (roomName.isNotEmpty && livekitToken.isNotEmpty) {
            if (isClosed) return;
            emit(VoiceSessionCredentialsLoaded(
              roomName: roomName, // Use extracted value
              livekitToken: livekitToken, // Use extracted value
              livekitUrl: _livekitWsUrl,
            ));
          } else {
             if (isClosed) return;
             emit(const VoiceSessionCredentialsError('Received empty credentials from backend.'));
          }

        } else {
          // Handle case where keys are missing, null, or wrong type
          if (isClosed) return;
          emit(VoiceSessionCredentialsError('Invalid credential data received from backend (Check keys/types): ${response.body}'));
        }
      } else {
        if (isClosed) return;
        emit(VoiceSessionCredentialsError('Failed to get voice session credentials: ${response.statusCode} ${response.body}'));
      }
    } catch (e) {
      // Catch potential jsonDecode errors or other network issues
      if (isClosed) return;
      emit(VoiceSessionCredentialsError('Error processing voice session credentials: $e'));
    }
  }

  Future<void> connectToLiveKitRoom(String roomName, String token, String url) async {
    if (isClosed) return;
    emit(VoiceSessionConnectingToRoom());

    print('VoiceSessionCubit: Attempting to connect with:');
    print('VoiceSessionCubit:   URL: $url');
    print('VoiceSessionCubit:   Room Name: $roomName');
    print('VoiceSessionCubit:   Token: $token'); // Be mindful of logging tokens in production

    final micPermissionStatus = await Permission.microphone.request();
    if (micPermissionStatus.isDenied || micPermissionStatus.isPermanentlyDenied) {
      if (isClosed) return;
      emit(VoiceSessionMicPermissionDenied());
      return;
    }
    if (isClosed) return;
    emit(VoiceSessionMicPermissionGranted());

    _room = Room();

    // Setup listeners before connecting
    _roomEventsListener = _room!.createListener()
      ..on<RoomDisconnectedEvent>((event) {
        print('VoiceSessionCubit: RoomDisconnectedEvent - Reason: \${event.reason}');
        if (isClosed) return;
        emit(VoiceSessionDisconnected());
      })
      ..on<DataReceivedEvent>((event) { // Added DataReceivedEvent listener here
        // Check if the data is from a remote participant and has the expected topic
        if (event.topic == 'flutter_updates') { 
          try {
            final payloadString = String.fromCharCodes(event.data);
            final decodedPayload = jsonDecode(payloadString);
            print('VoiceSessionCubit: Received data on flutter_updates topic: $decodedPayload');
            
            if (decodedPayload['event'] == 'transfer_completed') {
              print('VoiceSessionCubit: Transfer completed signal received with data: ${decodedPayload['data']}');
              if (isClosed) return;
              emit(VoiceSessionTransferCompleted(decodedPayload['data']));
            }
          } catch (e) {
            print('Error decoding data packet from DataReceivedEvent: $e');
            if (isClosed) return;
            emit(VoiceSessionError('Error processing transfer completion signal: $e'));
          }
        }
      })
      ..on<SpeakingChangedEvent>((event) {
        // Ensure the event participant is not null and is the local participant
        if (event.participant == _room?.localParticipant) {
          // Access isSpeaking from the participant
          if (event.participant.isSpeaking) { 
            if (_room != null) emit(VoiceSessionLocalUserSpeaking(_room!));
          } else {
            // When user stops speaking, transition to AgentProcessing state
            if (_room != null && _room!.connectionState == ConnectionState.connected) {
               if (isClosed) return;
               emit(VoiceSessionAgentProcessing(_room!)); // New state: Agent is processing
            } else if (_room?.connectionState != ConnectionState.connected) {
              if (isClosed) return;
              emit(VoiceSessionDisconnected());
            }
          }
        }
      });

    // Data packet listening is now handled by the DataReceivedEvent listener above

    try {
      await _room!.connect(
        url,
        token,
      );

      // try {
      //   // video will fail when running in ios simulator
      //   await _room!.localParticipant?.setCameraEnabled(true);
      // } catch (error) {
      //   print('Could not publish video, error: $error');
      // }
      
      // Publish microphone
      await _room!.localParticipant?.setMicrophoneEnabled(true);
      if (isClosed) return;
      emit(VoiceSessionConnected(_room!));
      // After connecting, if the user is not immediately speaking, they are in a 'not speaking' state.
      // Consider emitting VoiceSessionLocalUserNotSpeaking here if that's the desired initial state post-connection.
      // For now, VoiceSessionConnected implies they are ready and listening.
      if (_room != null && _room!.localParticipant != null && !_room!.localParticipant!.isSpeaking) {
        // emit(VoiceSessionLocalUserNotSpeaking(_room!)); // Replaced by AgentProcessing logic or initial Connected
        // Initial state after connection and mic enabled is connected and listening (not actively processing yet)
        if (isClosed) return;
        emit(VoiceSessionConnected(_room!));
      }

    } catch (e) {
      if (isClosed) return;
      emit(VoiceSessionError('Failed to connect to LiveKit room: $e'));
      await _disposeRoomResources();
    }
  }

  Future<void> disconnectFromLiveKitRoom() async {
    await _disposeRoomResources();
    if (isClosed) return;
    emit(VoiceSessionDisconnected());
  }

  Future<void> _disposeRoomResources() async {
    await _roomEventsListener?.dispose();
    _roomEventsListener = null;
    // await _localTrackSubscription?.cancel(); // Removed as _localTrackSubscription is removed
    // _localTrackSubscription = null;
    // await _dataPacketSubscription?.cancel(); // Removed as data handling is part of _roomEventsListener
    // _dataPacketSubscription = null;
    await _room?.disconnect();
    _room = null;
  }

  @override
  Future<void> close() {
    _disposeRoomResources();
    return super.close();
  }
}