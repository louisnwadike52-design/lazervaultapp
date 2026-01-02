# Quick Start: Crypto gRPC Integration

## TL;DR - Get Started in 3 Steps

### Step 1: Generate Proto Files
```bash
cd /Users/louislawrence/Music/apps/stack/lazervaultapp
./generate_proto.sh
```

### Step 2: Start the Services
```bash
# Terminal 1 - Crypto Microservice
cd /Users/louislawrence/Music/apps/stack/crypto-microservice
go run main.go

# Terminal 2 - Voice Service (optional)
cd /Users/louislawrence/Music/apps/stack/lazervault-golang
go run main.go

# Terminal 3 - Flutter App
cd /Users/louislawrence/Music/apps/stack/lazervaultapp
flutter pub get
flutter run
```

### Step 3: Uncomment gRPC Code
After proto generation, uncomment the implementation code in:
1. `lib/src/core/grpc/crypto_grpc_client.dart`
2. `lib/src/core/grpc/voice_grpc_client.dart`
3. `lib/src/features/crypto/data/datasources/crypto_remote_data_source.dart`

Then hot reload the app!

## What's New?

### 🎤 Voice Interface
- **Floating mic button** on crypto screen
- **Voice commands** like "Show me Bitcoin price"
- **Real-time transcription** with AI responses
- Beautiful animated UI

### 🔌 gRPC Integration
- **No more mock data** - connects to crypto-microservice
- **Type-safe** Protocol Buffer messages
- **Efficient** binary serialization
- **Scalable** architecture

## File Structure

```
lib/
├── src/
│   ├── core/
│   │   ├── config/
│   │   │   └── grpc_config.dart          # gRPC connection settings
│   │   └── grpc/
│   │       ├── crypto_grpc_client.dart   # Crypto service client
│   │       └── voice_grpc_client.dart    # Voice service client
│   └── features/
│       └── crypto/
│           ├── data/
│           │   └── datasources/
│           │       └── crypto_remote_data_source.dart  # Updated for gRPC
│           └── presentation/
│               ├── view/
│               │   └── crypto_screen.dart              # Added voice button
│               └── widgets/
│                   └── voice_input_widget.dart         # NEW voice UI
│
├── .env                                   # Updated with gRPC config
├── generate_proto.sh                      # Updated script
└── CRYPTO_GRPC_INTEGRATION.md            # Full documentation
```

## Configuration (.env)

```env
# Crypto Microservice gRPC
CRYPTO_GRPC_HOST=10.0.2.2    # Use localhost for iOS simulator
CRYPTO_GRPC_PORT=50053

# Voice Session gRPC
VOICE_GRPC_HOST=10.0.2.2     # Use localhost for iOS simulator
VOICE_GRPC_PORT=50051
```

## Voice Commands Cheat Sheet

| Command | Action |
|---------|--------|
| "Show me Bitcoin price" | Display BTC current price |
| "What's trending?" | Show trending cryptocurrencies |
| "Buy Ethereum" | Initiate ETH purchase |
| "Show my portfolio" | Display portfolio summary |

## Testing

### Quick Test - Voice Interface
1. Open app → Navigate to Crypto screen
2. Tap floating mic button (bottom right)
3. Tap big microphone and say: "Show me Bitcoin price"
4. See transcription and AI response!

### Quick Test - gRPC Connection
```bash
# Check if crypto service is running
grpcurl -plaintext localhost:50053 list

# Test getCryptos method
grpcurl -plaintext localhost:50053 pb.CryptoService/GetCryptos
```

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Proto generation fails | Install: `brew install protobuf` and `dart pub global activate protoc_plugin` |
| Can't connect to service | Use `10.0.2.2` for Android emulator, `localhost` for iOS |
| Voice not working | Grant microphone permissions in device settings |
| No data showing | Ensure crypto-microservice is running on port 50053 |

## Next Steps

1. ✅ Generate proto files
2. ✅ Start services
3. ✅ Run app
4. ✅ Test voice interface
5. ✅ Test crypto data loading
6. 🔄 Uncomment gRPC code
7. 🔄 Integrate with real backend
8. 🔄 Add more voice commands

## Key Benefits

✅ **Type Safety** - Protocol Buffers ensure type-safe communication
✅ **Performance** - Binary serialization is faster than JSON
✅ **Modern UX** - Voice interface for hands-free operation
✅ **Scalable** - Easy to add new features and services
✅ **Clean Code** - Follows Flutter best practices

## Need Help?

- 📖 See `CRYPTO_GRPC_INTEGRATION.md` for detailed documentation
- 🔍 Check proto files in `proto/` directory
- 💻 Review generated code in `lib/src/generated/`
- 🐛 Check logs for error messages

---

**Happy Coding! 🚀**
