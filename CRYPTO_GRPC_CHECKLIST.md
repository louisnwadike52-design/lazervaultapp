# Crypto gRPC Integration Checklist

Use this checklist to track the migration from mock data to full gRPC integration.

## ✅ Completed Tasks

- [x] Create gRPC configuration (`grpc_config.dart`)
- [x] Create crypto gRPC client wrapper (`crypto_grpc_client.dart`)
- [x] Create voice gRPC client wrapper (`voice_grpc_client.dart`)
- [x] Update crypto remote data source for gRPC
- [x] Remove mock data from data source (with fallback)
- [x] Create voice input widget
- [x] Add floating mic button to crypto screen
- [x] Add mic button to top bar
- [x] Update `.env` with gRPC configuration
- [x] Update proto generation script
- [x] Create documentation

## 🔄 Pending Tasks

### 1. Proto File Generation
- [ ] Run `./generate_proto.sh` to generate Dart proto files
- [ ] Verify generated files exist in `lib/src/generated/`:
  - [ ] `crypto.pb.dart`
  - [ ] `crypto.pbgrpc.dart`
  - [ ] `voice_session.pb.dart`
  - [ ] `voice_session.pbgrpc.dart`

### 2. Uncomment gRPC Implementation

#### A. Crypto gRPC Client (`lib/src/core/grpc/crypto_grpc_client.dart`)
- [ ] Uncomment imports at the top
- [ ] Uncomment client initialization in constructor
- [ ] Uncomment `getCryptos()` implementation
- [ ] Uncomment `getCryptoById()` implementation
- [ ] Uncomment `searchCryptos()` implementation
- [ ] Uncomment `getTrendingCryptos()` implementation
- [ ] Uncomment `getTopCryptos()` implementation
- [ ] Uncomment `getCryptoPriceHistory()` implementation

#### B. Voice gRPC Client (`lib/src/core/grpc/voice_grpc_client.dart`)
- [ ] Uncomment imports at the top
- [ ] Uncomment client initialization in constructor
- [ ] Uncomment `startVoiceSession()` implementation
- [ ] Uncomment `processVoiceNote()` implementation

#### C. Data Source (`lib/src/features/crypto/data/datasources/crypto_remote_data_source.dart`)
- [ ] Uncomment `_convertProtoToCryptoModel()` helper method
- [ ] Uncomment gRPC calls in `getCryptos()`
- [ ] Uncomment gRPC calls in `getCryptoById()`
- [ ] Uncomment gRPC calls in `searchCryptos()`
- [ ] Uncomment gRPC calls in `getCryptoPriceHistory()`
- [ ] Uncomment gRPC calls in `getTrendingCryptos()`
- [ ] Uncomment gRPC calls in `getTopCryptos()`
- [ ] Remove fallback to `CryptoModel.sampleCryptos()`

#### D. Voice Widget (`lib/src/features/crypto/presentation/widgets/voice_input_widget.dart`)
- [ ] Uncomment gRPC call in `_processVoiceCommand()`
- [ ] Remove `_getMockResponse()` method
- [ ] Connect to real voice session service

### 3. Service Dependencies

#### A. Crypto Microservice
- [ ] Ensure crypto-microservice is running on `localhost:50053`
- [ ] Verify service is accessible from Flutter app
- [ ] Test with grpcurl: `grpcurl -plaintext localhost:50053 list`
- [ ] Populate with test data if needed

#### B. Voice Service (lazervault-golang)
- [ ] Ensure lazervault-golang is running on `localhost:50051`
- [ ] Verify voice session service is accessible
- [ ] Test with grpcurl: `grpcurl -plaintext localhost:50051 list`
- [ ] Configure LiveKit if needed

### 4. Dependency Injection

- [ ] Register `CryptoGrpcClient` in service locator/DI container
- [ ] Register `VoiceGrpcClient` in service locator/DI container
- [ ] Update `CryptoRemoteDataSourceImpl` to receive `CryptoGrpcClient` via DI
- [ ] Verify all dependencies are properly injected

### 5. Testing

#### A. Unit Tests
- [ ] Write tests for `CryptoGrpcClient`
- [ ] Write tests for `VoiceGrpcClient`
- [ ] Write tests for updated `CryptoRemoteDataSourceImpl`
- [ ] Mock gRPC responses for testing

#### B. Integration Tests
- [ ] Test crypto data loading from microservice
- [ ] Test search functionality
- [ ] Test price history retrieval
- [ ] Test voice command processing
- [ ] Test voice transcription

#### C. End-to-End Tests
- [ ] Test complete crypto screen flow
- [ ] Test voice interface flow
- [ ] Test error handling scenarios
- [ ] Test offline behavior

### 6. Error Handling & Edge Cases

- [ ] Handle gRPC connection failures gracefully
- [ ] Implement retry logic for failed requests
- [ ] Add timeout handling
- [ ] Show user-friendly error messages
- [ ] Implement offline mode with cached data
- [ ] Handle voice recognition errors
- [ ] Handle empty/null responses from services

### 7. Performance Optimization

- [ ] Implement request caching if needed
- [ ] Add loading indicators for long operations
- [ ] Optimize proto message sizes
- [ ] Test with large datasets
- [ ] Profile memory usage
- [ ] Test on low-end devices

### 8. Platform-Specific Configuration

#### Android
- [ ] Update `.env` to use `10.0.2.2` for emulator
- [ ] Add microphone permissions to `AndroidManifest.xml`
- [ ] Test on physical Android device
- [ ] Test on Android emulator

#### iOS
- [ ] Update `.env` to use `localhost` for simulator
- [ ] Add microphone permissions to `Info.plist`
- [ ] Test on iOS simulator
- [ ] Test on physical iOS device

### 9. Documentation Updates

- [ ] Update main README with gRPC setup instructions
- [ ] Document voice commands for users
- [ ] Create API documentation for developers
- [ ] Add inline code documentation
- [ ] Update architecture diagrams

### 10. Deployment Preparation

- [ ] Configure production gRPC endpoints
- [ ] Set up environment-specific configurations
- [ ] Add SSL/TLS for production gRPC
- [ ] Configure authentication tokens
- [ ] Set up monitoring and logging
- [ ] Create deployment scripts

## 🎯 Quick Win Checklist (Minimum Viable Integration)

For a quick working version, complete these essential tasks:

1. [ ] Generate proto files (`./generate_proto.sh`)
2. [ ] Start crypto-microservice on port 50053
3. [ ] Uncomment gRPC code in `crypto_grpc_client.dart`
4. [ ] Uncomment gRPC code in `crypto_remote_data_source.dart`
5. [ ] Test crypto screen loads data from microservice
6. [ ] Grant microphone permissions
7. [ ] Test voice interface opens and responds

## 📊 Progress Tracking

- **Overall Progress:** 50% (Documentation & Structure Complete)
- **Proto Generation:** 0% (Not yet run)
- **Code Uncommenting:** 0% (Waiting for proto generation)
- **Testing:** 0% (Waiting for implementation)
- **Production Ready:** 0% (Early stage)

## 🚀 Next Immediate Steps

1. Run proto generation script
2. Verify generated files
3. Uncomment crypto gRPC client
4. Start crypto-microservice
5. Test basic data loading

---

## Notes

- Keep mock data fallback until fully tested
- Test incrementally - one service at a time
- Monitor gRPC logs for debugging
- Use grpcurl for manual service testing
- Document any issues encountered

**Last Updated:** 2026-01-02
