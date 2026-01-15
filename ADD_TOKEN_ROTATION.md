# Adding Automatic Token Rotation to All Repositories

This guide explains how automatic token rotation has been implemented and provides a migration pattern for updating all repositories.

## ✅ What's Already Done

1. **GrpcCallOptionsHelper Enhanced** (`/lib/core/services/grpc_call_options_helper.dart`)
   - Added `executeWithTokenRotation<T>()` method
   - Automatically catches 401/403 errors
   - Calls refresh token endpoint
   - Retries original request with new tokens
   - Saves new tokens to secure storage

2. **Token Refresh Callback Wired Up** (`/lib/core/services/injection_container.dart`)
   - AuthRepository's `refreshTokensSimple()` method connected
   - Callback registered when AuthRepository is created
   - All repositories share the same callback

3. **AuthRepository Updated** (`/lib/src/features/authentication/data/repositories/auth_repository.dart`)
   - `refreshToken()` method updated for new proto
   - `refreshTokensSimple()` helper method added
   - Returns simple map for callback use

4. **GrpcClient Enhanced** (`/lib/src/core/network/grpc_client.dart`)
   - Now uses `GrpcCallOptionsHelper` internally
   - All repositories using `grpcClient.callOptions` automatically get token rotation
   - Added `executeWithTokenRotation<T>()` method for explicit wrapping
   - Includes automatic retry on 401/403 errors

## 📋 Migration Pattern

### Before (Without Token Rotation)
```dart
@override
Future<Either<Failure, SomeModel>> someMethod({
  required String accessToken,
  // ... other params
}) async {
  try {
    final callOptions = await _callOptionsHelper.withAuth();
    final request = SomeRequest(/* ... */);

    final response = await _client.someRpc(
      request,
      options: callOptions,
    );

    return Right(SomeModel.fromProto(response));
  } catch (e) {
    return Left(Failure(message: 'Failed: $e', statusCode: 500));
  }
}
```

### After (With Token Rotation)
```dart
@override
Future<Either<Failure, SomeModel>> someMethod({
  required String accessToken,
  // ... other params
}) async {
  try {
    // Wrap the gRPC call with executeWithTokenRotation
    final response = await _callOptionsHelper.executeWithTokenRotation(() async {
      final callOptions = await _callOptionsHelper.withAuth();
      final request = SomeRequest(/* ... */);

      return await _client.someRpc(
        request,
        options: callOptions,
      );
    });

    return Right(SomeModel.fromProto(response));
  } catch (e) {
    return Left(Failure(message: 'Failed: $e', statusCode: 500));
  }
}
```

## 🔍 Pattern Explained

**Key Changes:**
1. Wrap the entire gRPC call logic in `_callOptionsHelper.executeWithTokenRotation(() async { ... })`
2. Move the `final response = await _client...` inside the lambda
3. Add `return` before `await _client...`
4. Everything else stays outside the wrapper (converting to model, error handling, etc.)

**What Happens:**
- ✅ Normal request succeeds → response returned directly
- ❌ Request fails with 401/403 → automatic token refresh → retry → success
- 💾 New tokens saved automatically
- 🔁 User sees no interruption

## 📂 Repositories Already Updated

### Direct GrpcCallOptionsHelper Usage:
1. ✅ `RecipientRepositoryImpl` - All 3 methods updated
   - `getRecipients()`
   - `addRecipient()`
   - `toggleFavorite()`

2. ✅ `AccountSummaryRepositoryImpl` - 1 method updated
   - `getAccountSummaries()`

3. ✅ `CardSettingsRepositoryImpl` - All 3 methods updated
   - `getAccountDetails()`
   - `updateSecuritySettings()`
   - `updateAccountStatus()`

4. ✅ `DepositRepositoryImpl` - 1 method updated
   - `initiateDeposit()`

5. ✅ `WithdrawalRepositoryImpl` - 1 method updated
   - `initiateWithdrawal()`

6. ✅ `TransferRemoteDataSourceImpl` - 1 method updated
   - `initiateTransfer()`

7. ✅ `BatchTransferRemoteDataSourceImpl` - All 3 methods updated
   - `initiateBatchTransfer()`
   - `getBatchTransferStatus()`
   - `getBatchTransferHistory()`

### Using GrpcClient (Automatic Token Rotation):
All repositories using `GrpcClient` now have automatic token rotation via the enhanced `callOptions` getter:
- ✅ `InvoiceRepositoryGrpcImpl` - Auto-rotation enabled
- ✅ `PayInvoiceRepositoryGrpcImpl` - Auto-rotation enabled
- ✅ `ExchangeRepositoryImpl` - Auto-rotation enabled
- ✅ `CardRemoteDataSourceImpl` - Auto-rotation enabled
- ✅ All other repositories using `grpcClient.callOptions` - Auto-rotation enabled

## 📝 Repositories To Update

### Repositories Using `_callOptionsHelper.withAuth()` Directly:

Run this command to find repositories that need manual updating:

```bash
find lib -name "*repository*.dart" -type f | \
  grep -v ".freezed.dart" | \
  grep -v ".g.dart" | \
  grep -E "(impl|_impl)" | \
  xargs grep -l "_callOptionsHelper.withAuth()" | \
  sort
```

For each file:
1. Open the file
2. Find all methods that call `await _callOptionsHelper.withAuth()`
3. Wrap the gRPC call with `executeWithTokenRotation`
4. Test the method

### Repositories Using `grpcClient.callOptions`:

**No action needed!** These repositories automatically get token rotation through the enhanced `GrpcClient` class. The token refresh happens transparently in the background.

## 🔧 Automated Script (Coming Soon)

A script to automatically update all repositories is being prepared. For now, use the manual pattern above.

## ✅ Verification Checklist

For each updated repository method:
- [ ] Wrapped with `executeWithTokenRotation`
- [ ] `return await` used for gRPC call
- [ ] Error handling preserved
- [ ] Response conversion stays outside wrapper
- [ ] No duplicate error handling

## 🎯 Critical Repositories (Update These First)

1. **Profile** - User data access
   - `ProfileRepositoryImpl`

2. **Accounts** - Account data
   - `AccountSummaryRepositoryImpl`
   - `CardSettingsRepositoryImpl`

3. **Transfers** - Money movement
   - `TransferRemoteDataSourceImpl`
   - `BatchTransferRemoteDataSourceImpl`

4. **Deposits & Withdrawals** - Funds
   - `DepositRepositoryImpl`
   - `WithdrawalRepositoryImpl`

5. **Payments** - Invoices, bills, etc.
   - Invoice repositories
   - Payment repositories

## 🚀 Testing

After updating repositories:

1. **Test Normal Flow**
   ```dart
   // Should work as before
   final result = await repository.someMethod();
   ```

2. **Test Expired Token**
   ```dart
   // Manually expire token in storage
   await secureStorage.write(key: 'access_token', value: 'expired-token');

   // Make API call - should auto-refresh and succeed
   final result = await repository.someMethod();
   // Should succeed without user seeing error
   ```

3. **Check Logs**
   ```
   🔄 Token rotation triggered by expired token
   Calling RefreshToken endpoint...
   New tokens saved to storage
   Token refreshed successfully. Retrying request...
   ```

## 📊 Impact

- **User Experience:** Seamless - no "session expired" errors
- **Security:** Enhanced - tokens rotate automatically
- **Code:** Minimal changes - just wrap existing calls
- **Performance:** Negligible - only on token expiration

## 🔐 How It Works

```
1. API Call → 401 Error
        ↓
2. Interceptor Catches Error
        ↓
3. Call onTokenRefreshNeeded()
        ↓
4. AuthRepository.refreshTokensSimple()
        ↓
5. New Tokens Saved
        ↓
6. Retry Original Request
        ↓
7. Success!
```

## 📝 Notes

- Only applies to **authenticated** API calls (those using `withAuth()`)
- Public endpoints (signup, login) don't need wrapping
- Auth repository methods that refresh tokens don't need wrapping (avoid infinite loop)
- Maximum 1 retry by default (configurable with `maxRetries` parameter)

---

**Status:** Implementation in progress
**Next Steps:** Update remaining repositories following the pattern above
