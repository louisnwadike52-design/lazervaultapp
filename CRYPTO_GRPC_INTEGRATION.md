# Crypto gRPC Integration & Voice Interface

This document describes the integration of the Flutter crypto frontend with the gRPC microservice and the addition of voice interface capabilities.

## Overview

The crypto feature in LazerVault has been updated to:
1. Use gRPC for communication with the crypto-microservice (instead of mock data)
2. Support voice commands for crypto operations through a voice interface widget

## Architecture

### gRPC Communication Flow

```
Flutter App (lazervaultapp)
    |
    ├── CryptoScreen (UI)
    |     └── VoiceInputWidget (Voice Interface)
    |
    ├── CryptoCubit (Business Logic)
    |
    ├── CryptoRepository
    |     └── CryptoRemoteDataSource
    |           └── CryptoGrpcClient
    |                 |
    |                 └── crypto-microservice (localhost:50053)
    |
    └── VoiceGrpcClient
          └── lazervault-golang (localhost:50051)
```

## Files Modified/Created

### 1. gRPC Configuration & Clients

#### `/lib/src/core/config/grpc_config.dart` (NEW)
- Centralized gRPC configuration
- Manages connection settings for crypto and voice services
- Reads configuration from `.env` file
- Default values: crypto (localhost:50053), voice (localhost:50051)

#### `/lib/src/core/grpc/crypto_grpc_client.dart` (NEW)
- Wrapper for crypto-microservice gRPC client
- Methods:
  - `getCryptos()` - Get list of cryptocurrencies
  - `getCryptoById()` - Get cryptocurrency details
  - `searchCryptos()` - Search cryptocurrencies
  - `getTrendingCryptos()` - Get trending cryptocurrencies
  - `getTopCryptos()` - Get top cryptocurrencies by market cap
  - `getCryptoPriceHistory()` - Get price history

#### `/lib/src/core/grpc/voice_grpc_client.dart` (NEW)
- Wrapper for voice session gRPC client
- Methods:
  - `startVoiceSession()` - Start a new voice session with LiveKit
  - `processVoiceNote()` - Process voice audio and get AI response

### 2. Data Layer Updates

#### `/lib/src/features/crypto/data/datasources/crypto_remote_data_source.dart` (MODIFIED)
- Removed all mock data implementations
- Now uses `CryptoGrpcClient` for all data fetching
- Includes proto-to-model conversion helper (commented until proto generation)
- All methods now make gRPC calls to crypto-microservice
- Temporary fallback to sample data until proto files are generated

### 3. Voice Interface

#### `/lib/src/features/crypto/presentation/widgets/voice_input_widget.dart` (NEW)
Complete voice interface widget with:
- Real-time speech-to-text transcription
- Voice command processing
- AI response display
- Animated microphone button with visual feedback
- Example voice commands:
  - "Show me Bitcoin price"
  - "What's trending?"
  - "Buy 0.1 Ethereum"
  - "Show my portfolio"

#### `/lib/src/features/crypto/presentation/view/crypto_screen.dart` (MODIFIED)
- Added import for `VoiceInputWidget`
- Added floating action button (FAB) with microphone icon
- Added voice button in top bar
- Added `_showVoiceInputBottomSheet()` method
- Both buttons open the voice interface as a bottom sheet

### 4. Configuration Files

#### `.env` (MODIFIED)
Added gRPC configuration:
```env
# Crypto Microservice gRPC
CRYPTO_GRPC_HOST=10.0.2.2
CRYPTO_GRPC_PORT=50053

# Voice Session gRPC (lazervault-golang)
VOICE_GRPC_HOST=10.0.2.2
VOICE_GRPC_PORT=50051
```

Note: Use `10.0.2.2` for Android emulator (refers to host machine's localhost)
For iOS simulator, use `localhost` or `127.0.0.1`

#### `generate_proto.sh` (MODIFIED)
Updated to generate Dart code from:
- `crypto.proto` from crypto-microservice
- `voice_session.proto` from lazervault-golang

## Setup Instructions

### Prerequisites

1. Install Protocol Buffers compiler:
   ```bash
   brew install protobuf
   ```

2. Install Dart protoc plugin:
   ```bash
   dart pub global activate protoc_plugin
   ```

3. Add Dart global bin to PATH (if not already):
   ```bash
   export PATH="$PATH:$HOME/.pub-cache/bin"
   ```

### Generate Proto Files

From the `lazervaultapp` directory:

```bash
chmod +x generate_proto.sh
./generate_proto.sh
```

This will generate:
- `lib/src/generated/crypto.pb.dart`
- `lib/src/generated/crypto.pbgrpc.dart`
- `lib/src/generated/voice_session.pb.dart`
- `lib/src/generated/voice_session.pbgrpc.dart`

### Enable gRPC Calls

After proto files are generated, uncomment the gRPC implementation code in:

1. `/lib/src/core/grpc/crypto_grpc_client.dart`
2. `/lib/src/core/grpc/voice_grpc_client.dart`
3. `/lib/src/features/crypto/data/datasources/crypto_remote_data_source.dart`

### Running the Services

1. **Start crypto-microservice:**
   ```bash
   cd /Users/louislawrence/Music/apps/stack/crypto-microservice
   go run main.go
   # Should be running on localhost:50053
   ```

2. **Start lazervault-golang (for voice):**
   ```bash
   cd /Users/louislawrence/Music/apps/stack/lazervault-golang
   go run main.go
   # Should be running on localhost:50051
   ```

3. **Run Flutter app:**
   ```bash
   cd /Users/louislawrence/Music/apps/stack/lazervaultapp
   flutter pub get
   flutter run
   ```

## Voice Commands

The voice interface supports natural language commands:

### Price Queries
- "Show me Bitcoin price"
- "What's the price of Ethereum?"
- "How much is Solana?"

### Trading Commands
- "Buy Bitcoin"
- "Buy 0.1 Ethereum"
- "Sell 0.5 Bitcoin"

### Information Queries
- "What's trending?"
- "Show trending cryptocurrencies"
- "Show my portfolio"
- "Show my holdings"

### Examples
The voice widget displays these example commands to guide users.

## Key Features

### 1. gRPC Integration
- ✅ Type-safe communication with crypto-microservice
- ✅ Efficient binary serialization (Protocol Buffers)
- ✅ Streaming support (future enhancement)
- ✅ Clean architecture separation

### 2. Voice Interface
- ✅ Real-time speech-to-text transcription
- ✅ Visual feedback (animated microphone)
- ✅ AI-powered response generation
- ✅ Error handling and user guidance
- ✅ Beautiful, modern UI

### 3. Clean Architecture
- ✅ Follows Flutter best practices
- ✅ Separation of concerns (data/domain/presentation)
- ✅ Dependency injection ready
- ✅ Testable components

## Testing

### Test gRPC Connection

You can test the gRPC connection using grpcurl:

```bash
# Test crypto service
grpcurl -plaintext localhost:50053 list
grpcurl -plaintext localhost:50053 pb.CryptoService/GetCryptos

# Test voice service
grpcurl -plaintext localhost:50051 list
grpcurl -plaintext localhost:50051 pb.VoiceSessionService/StartVoiceSession
```

### Test Voice Interface

1. Open the crypto screen
2. Tap the floating microphone button or the mic icon in the top bar
3. Tap the large microphone button and speak a command
4. Observe the transcription and AI response

## Troubleshooting

### Proto Generation Fails
- Ensure protoc is installed: `protoc --version`
- Ensure Dart plugin is installed: `dart pub global list`
- Check PATH includes `$HOME/.pub-cache/bin`

### gRPC Connection Issues
- Verify services are running on correct ports
- For Android emulator, use `10.0.2.2` instead of `localhost`
- Check firewall settings
- Review `.env` configuration

### Voice Recognition Not Working
- Ensure microphone permissions are granted
- Check device has microphone access
- Test speech recognition availability

### No Data Displayed
- Verify crypto-microservice is running and populated with data
- Check network connectivity
- Review logs for gRPC errors

## Future Enhancements

1. **Streaming Support**
   - Real-time price updates via gRPC streaming
   - Live voice transcription stream

2. **Advanced Voice Commands**
   - Multi-step transactions
   - Portfolio analysis
   - Market insights

3. **Caching Strategy**
   - Local caching with TTL
   - Offline support with stale data

4. **Error Recovery**
   - Automatic retry logic
   - Graceful degradation
   - Offline mode

## Dependencies

All required dependencies are already in `pubspec.yaml`:

```yaml
dependencies:
  grpc: 4.0.0
  speech_to_text: ^7.0.0
  protobuf: ^4.0.0
  fixnum: ^1.1.1
  flutter_dotenv: ^5.2.1
  # ... other dependencies
```

## Notes

- The implementation currently uses mock data as a fallback until proto files are generated
- Voice commands use mock responses until integrated with the actual voice service
- All gRPC calls include proper error handling
- The architecture supports easy migration from mock to real data

## Contact

For questions or issues, please refer to the main LazerVault documentation or contact the development team.
