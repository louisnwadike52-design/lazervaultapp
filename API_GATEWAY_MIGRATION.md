# API Gateway Migration - Flutter App Configuration

## Overview
The LazerVault Flutter app has been updated to connect exclusively through the API Gateway instead of directly to individual microservices.

## Changes Made

### 1. Environment Configuration (.env)

**Before:**
```bash
GRPC_API_HOST=http://10.0.2.2
GRPC_API_PORT=7007
INVOICE_GRPC_HOST=10.0.2.2
INVOICE_GRPC_PORT=7007
STOCKS_GRPC_HOST=10.0.2.2
STOCKS_GRPC_PORT=9091
CRYPTO_GRPC_HOST=10.0.2.2
CRYPTO_GRPC_PORT=50053
VOICE_GRPC_HOST=10.0.2.2
VOICE_GRPC_PORT=50051
```

**After:**
```bash
# API Gateway (Single Entry Point)
API_GATEWAY_HOST=10.0.2.2
API_GATEWAY_PORT=8080

# All services accessed via Gateway
GRPC_API_HOST=http://10.0.2.2
GRPC_API_PORT=8080
STOCKS_GRPC_HOST=10.0.2.2
STOCKS_GRPC_PORT=8080
CRYPTO_GRPC_HOST=10.0.2.2
CRYPTO_GRPC_PORT=8080
VOICE_GRPC_HOST=10.0.2.2
VOICE_GRPC_PORT=8080
```

### 2. Architecture Benefits

#### Single ClientChannel (Already Implemented)
The app already uses a single `ClientChannel` (registered in `injection_container.dart` at line 403) that connects to `GRPC_API_HOST:GRPC_API_PORT`. By updating the .env file, all gRPC clients now automatically connect through the API Gateway.

#### No Code Changes Required!
Because the app was already using dependency injection with a single channel, updating the environment variables is all that's needed. The following clients now automatically use the gateway:

- `AuthServiceClient`
- `UserServiceClient`
- `InvoiceServiceClient`
- `DepositServiceClient`
- `WithdrawServiceClient`
- `TransferServiceClient`
- `StockServiceClient` (via GrpcChannelManager)
- `CryptoServiceClient`
- And all other gRPC services

### 3. Data Flow

```
┌─────────────────┐
│  Flutter App    │
│  (Mobile)       │
└────────┬────────┘
         │
         │ Single gRPC Channel
         │ 10.0.2.2:8080
         ↓
┌─────────────────┐
│  API Gateway    │
│  :8080          │
│                 │
│ • Rate Limiting │
│ • Caching       │
│ • Auth Check    │
│ • Routing       │
└────────┬────────┘
         │
         │ Routes to backend services
         ↓
┌────────┴─────────────────────────┐
│                                  │
│  Auth Service    Invoice Service │
│  :8083/:9093     :8082/:9092    │
│                                  │
│  Stocks Service  Crypto Service  │
│  :8081/:9091     :50053         │
└──────────────────────────────────┘
```

### 4. Testing Checklist

- [ ] Test user signup (should create user in auth_db via gateway)
- [ ] Test user login (should authenticate via auth service through gateway)
- [ ] Test invoice creation (should use userId from token)
- [ ] Test stocks portfolio (should use userId from token)
- [ ] Verify all gRPC calls go to port 8080
- [ ] Verify token-based authentication works
- [ ] Check that rate limiting is enforced by gateway
- [ ] Test offline/error handling

### 5. Development Setup

For local development with API Gateway:

```bash
# Terminal 1: Start Auth Microservice
cd auth-microservice
go run cmd/server/main.go

# Terminal 2: Start Invoice Microservice
cd invoice-microservice
go run cmd/server/main.go

# Terminal 3: Start Stocks Microservice
cd stocks-microservice
go run cmd/server/main.go

# Terminal 4: Start API Gateway
cd api-gateway
go run main.go

# Terminal 5: Start Flutter App
cd lazervaultapp
flutter run
```

### 6. Android Emulator Note

The address `10.0.2.2` is the special IP address that Android emulators use to connect to the host machine's localhost. This allows the emulator to reach the API Gateway running on your development machine at `localhost:8080`.

For iOS Simulator, use `localhost` or `127.0.0.1` instead.

### 7. Production Configuration

For production deployment (`.env.prod`), update the API Gateway endpoint to your production URL:

```bash
API_GATEWAY_HOST=https://api.lazervault.com
API_GATEWAY_PORT=443
```

## Security Improvements

With the API Gateway, the app benefits from:

1. **Centralized Authentication**: Token validation happens once at the gateway
2. **Rate Limiting**: Protection against abuse (100 req/sec per IP, 200 req/sec per user)
3. **IP Filtering**: Gateway can block malicious IPs
4. **Request Logging**: All requests logged centrally for monitoring
5. **CORS Handling**: Proper cross-origin configuration
6. **Caching**: Frequently accessed data cached at gateway (Redis)

## Migration Status

✅ Environment configuration updated
✅ Single channel architecture verified
✅ All gRPC service clients configured
⏳ Ready for testing

## Next Steps

1. Start all backend services and API Gateway
2. Run Flutter app and test all features
3. Monitor gateway logs for routing confirmation
4. Test end-to-end user flows
