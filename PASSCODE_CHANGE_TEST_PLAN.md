# Passcode Change Feature - Test Plan

## Overview
This document outlines the comprehensive test plan for the passcode change functionality implemented in LazerVault.

## Test Status: ✅ READY FOR TESTING

### Components Verified
- ✅ Backend proto files generated successfully
- ✅ Backend gRPC service implemented (`ChangePasscode` RPC)
- ✅ Backend auth controller handler implemented
- ✅ Backend auth service logic implemented
- ✅ Flutter proto files generated successfully
- ✅ Flutter UI screen created (`ChangePasscodeScreen`)
- ✅ Flutter use case implemented (`ChangePasscodeUseCase`)
- ✅ Flutter repository implementation updated
- ✅ Dependency injection configured
- ✅ Route configured in app router
- ✅ Settings menu integration complete
- ✅ No compilation errors in Flutter app
- ✅ No compilation errors in backend

---

## Manual Test Cases

### Test Case 1: Navigate to Change Passcode Screen
**Objective:** Verify user can navigate to the change passcode screen from settings

**Steps:**
1. Launch the LazerVault app
2. Login with valid credentials
3. Navigate to Settings
4. Scroll to Security section
5. Tap on "Change Passcode"

**Expected Result:**
- Change Passcode screen opens
- Title "Change Passcode" is displayed
- Text "Enter Current Passcode" is displayed
- 6 empty passcode dots are visible
- Number pad with digits 0-9 is visible
- Backspace button is visible

**Status:** ⏳ Pending Manual Testing

---

### Test Case 2: Successful Passcode Change
**Objective:** Verify user can successfully change their passcode

**Prerequisites:**
- User has already set up a passcode (e.g., "123456")
- User is authenticated

**Steps:**
1. Navigate to Settings > Security > Change Passcode
2. Enter current passcode: "123456" (6 digits)
3. Screen should automatically progress to "Enter New Passcode"
4. Enter new passcode: "654321" (6 digits)
5. Screen should automatically progress to "Confirm New Passcode"
6. Enter confirmation: "654321" (6 digits)
7. Wait for API call to complete

**Expected Result:**
- After step 2: Screen transitions to "Enter New Passcode"
- After step 4: Screen transitions to "Confirm New Passcode"
- After step 6: Loading indicator appears
- Success message: "Passcode changed successfully" (green snackbar)
- User is navigated back to settings screen
- New passcode "654321" is stored in secure storage

**API Request:**
```
POST /v1/auth/change-passcode
Headers: Authorization: Bearer <token>
Body: {
  "old_passcode": "123456",
  "new_passcode": "654321"
}
```

**API Response (Success):**
```json
{
  "success": true,
  "msg": "Passcode changed successfully"
}
```

**Status:** ⏳ Pending Manual Testing

---

### Test Case 3: Incorrect Old Passcode
**Objective:** Verify error handling when old passcode is incorrect

**Prerequisites:**
- User's actual passcode is "123456"

**Steps:**
1. Navigate to Change Passcode screen
2. Enter incorrect old passcode: "000000"
3. Enter new passcode: "654321"
4. Confirm new passcode: "654321"

**Expected Result:**
- Error message displayed: "Incorrect old passcode" or similar
- Passcode fields are cleared
- User returns to step 1 (Enter Current Passcode)
- User can retry with correct old passcode

**API Response (Error):**
```json
{
  "success": false,
  "msg": "Incorrect old passcode"
}
```

**Status:** ⏳ Pending Manual Testing

---

### Test Case 4: New Passcode Mismatch
**Objective:** Verify error handling when new passcode and confirmation don't match

**Steps:**
1. Navigate to Change Passcode screen
2. Enter current passcode: "123456"
3. Enter new passcode: "654321"
4. Enter different confirmation: "111111"

**Expected Result:**
- Error message displayed: "Passcodes do not match"
- Confirmation passcode field is cleared
- User stays on confirmation step (can re-enter confirmation)
- No API call is made

**Status:** ⏳ Pending Manual Testing

---

### Test Case 5: Same Old and New Passcode
**Objective:** Verify validation when user tries to use same passcode

**Steps:**
1. Navigate to Change Passcode screen
2. Enter current passcode: "123456"
3. Enter new passcode: "123456" (same as old)
4. Confirm new passcode: "123456"

**Expected Result:**
- API returns error: "new passcode must be different from old passcode"
- Error message is displayed to user
- User can retry with different passcode

**Status:** ⏳ Pending Manual Testing

---

### Test Case 6: Backspace Functionality
**Objective:** Verify backspace button works correctly

**Steps:**
1. Navigate to Change Passcode screen
2. Enter 3 digits: "123"
3. Tap backspace button
4. Enter another digit: "4"
5. Continue entering until 6 digits

**Expected Result:**
- After step 3: Last digit is removed, showing "12"
- After step 4: Digit is added, showing "124"
- User can continue normally
- Backspace works at each step (current, new, confirm)

**Status:** ⏳ Pending Manual Testing

---

### Test Case 7: Network Error Handling
**Objective:** Verify error handling when network request fails

**Prerequisites:**
- Simulate network error (turn off backend server or airplane mode)

**Steps:**
1. Navigate to Change Passcode screen
2. Enter valid old passcode
3. Enter valid new passcode
4. Confirm new passcode

**Expected Result:**
- Loading indicator appears
- After timeout, error message is displayed
- Error message: "An error occurred: <error details>" or similar
- User is returned to initial state
- User can retry when network is restored

**Status:** ⏳ Pending Manual Testing

---

### Test Case 8: Unauthenticated Request
**Objective:** Verify behavior when authentication token is invalid/expired

**Prerequisites:**
- User's authentication token has expired

**Steps:**
1. Navigate to Change Passcode screen
2. Enter passcodes and submit

**Expected Result:**
- API returns 401 Unauthenticated error
- User is redirected to login screen
- Or appropriate error message is shown

**Status:** ⏳ Pending Manual Testing

---

### Test Case 9: Back Button Navigation
**Objective:** Verify back button works correctly

**Steps:**
1. Navigate to Change Passcode screen
2. Tap back button (top-left arrow)

**Expected Result:**
- User is navigated back to Settings screen
- No passcode change is made
- No API call is made

**Status:** ⏳ Pending Manual Testing

---

### Test Case 10: Login with New Passcode
**Objective:** Verify new passcode works for login after change

**Prerequisites:**
- User has successfully changed passcode from "123456" to "654321"

**Steps:**
1. Logout from the app
2. Navigate to passcode login screen
3. Enter new passcode: "654321"

**Expected Result:**
- User is successfully authenticated
- User is logged into the app
- Old passcode "123456" no longer works

**Status:** ⏳ Pending Manual Testing

---

## Backend API Testing

### Test the Backend Endpoint Directly

#### Prerequisites
1. Backend server is running
2. User has a valid access token
3. User has a passcode set (e.g., "123456")

#### Using cURL

**Successful Change:**
```bash
curl -X POST http://localhost:8080/v1/auth/change-passcode \
  -H "Authorization: Bearer <your_access_token>" \
  -H "Content-Type: application/json" \
  -d '{
    "old_passcode": "123456",
    "new_passcode": "654321"
  }'
```

**Expected Response:**
```json
{
  "success": true,
  "msg": "Passcode changed successfully"
}
```

**Invalid Old Passcode:**
```bash
curl -X POST http://localhost:8080/v1/auth/change-passcode \
  -H "Authorization: Bearer <your_access_token>" \
  -H "Content-Type: application/json" \
  -d '{
    "old_passcode": "000000",
    "new_passcode": "654321"
  }'
```

**Expected Response:**
```json
{
  "success": false,
  "msg": "incorrect old passcode"
}
```

**Status:** ⏳ Pending API Testing

---

## Security Testing

### Security Test Case 1: Passcode Hashing
**Objective:** Verify passcodes are stored securely (hashed, not plain text)

**Steps:**
1. Change passcode via API
2. Check database for user record
3. Inspect `login_passcode` field

**Expected Result:**
- Passcode is stored as bcrypt hash
- Hash starts with "$2a$" or similar bcrypt identifier
- Plain text passcode is NOT visible in database

**Status:** ⏳ Pending Security Review

---

### Security Test Case 2: Authentication Required
**Objective:** Verify endpoint requires valid authentication

**Steps:**
1. Call change passcode API without Authorization header
2. Call with invalid token
3. Call with expired token

**Expected Result:**
- All requests return 401 Unauthenticated
- No passcode change occurs

**Status:** ⏳ Pending Security Review

---

## Performance Testing

### Performance Test Case 1: Response Time
**Objective:** Measure API response time

**Steps:**
1. Make multiple change passcode requests
2. Measure time from request to response

**Expected Result:**
- Average response time < 500ms
- 95th percentile < 1000ms

**Status:** ⏳ Pending Performance Testing

---

## Integration Testing Checklist

- [ ] Flutter app successfully calls backend API
- [ ] Authentication token is properly sent
- [ ] Request body is properly formatted
- [ ] Response is properly parsed
- [ ] Success flow works end-to-end
- [ ] Error flow works end-to-end
- [ ] Secure storage is updated after successful change
- [ ] New passcode can be used for subsequent logins

---

## Known Issues / Limitations

1. **Unit Tests:** Widget tests require service locator setup - better suited for integration tests
2. **Validation:** Frontend validates passcode length (4-6 digits), backend validates as well
3. **Error Messages:** Currently generic, could be more specific for better UX

---

## Test Execution Summary

| Test Category | Total | Passed | Failed | Pending |
|---------------|-------|--------|--------|---------|
| Compilation   | 2     | 2      | 0      | 0       |
| Proto Generation | 2  | 2      | 0      | 0       |
| Manual UI     | 10    | 0      | 0      | 10      |
| API Testing   | 2     | 0      | 0      | 2       |
| Security      | 2     | 0      | 0      | 2       |
| Performance   | 1     | 0      | 0      | 1       |
| **TOTAL**     | **19**| **4**  | **0**  | **15**  |

---

## Next Steps

1. ✅ Code implementation complete
2. ⏳ Start backend server
3. ⏳ Test backend API endpoint directly
4. ⏳ Build and run Flutter app
5. ⏳ Execute manual test cases
6. ⏳ Fix any bugs found
7. ⏳ Complete security review
8. ⏳ Performance testing
9. ⏳ Final verification

---

## Files Modified/Created

### Backend
- `proto/auth.proto` - Added ChangePasscodeRequest/Response messages and RPC
- `services/auth_service.go` - Added ChangePasscode method to interface and implementation
- `grpcApi/auth_controller.go` - Added ChangePasscode gRPC handler
- `pb/auth*.go` - Generated proto files

### Frontend
- `proto/auth.proto` - Synced with backend proto
- `lib/src/features/authentication/domain/usecases/change_passcode_usecase.dart` - Created use case
- `lib/src/features/authentication/domain/repositories/i_auth_repository.dart` - Added method to interface
- `lib/src/features/authentication/data/repositories/auth_repository.dart` - Added implementation
- `lib/src/features/authentication/presentation/views/change_passcode_screen.dart` - Created UI screen
- `lib/core/services/injection_container.dart` - Registered use case
- `lib/core/types/app_routes.dart` - Added route constant
- `lib/src/features/presentation/app_router.dart` - Added route registration
- `lib/src/features/settings/presentation/view/settings_screen.dart` - Added menu item
- `lib/src/generated/auth*.dart` - Generated proto files

---

## Conclusion

The passcode change feature has been fully implemented with:
- ✅ Complete backend implementation with secure bcrypt hashing
- ✅ Complete frontend implementation with 3-step UI flow
- ✅ Proper error handling and validation
- ✅ Security measures (authentication required, same passcode prevention)
- ✅ User-friendly interface integrated into settings

**The feature is ready for manual testing and integration testing.**
