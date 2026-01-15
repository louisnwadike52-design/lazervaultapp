# Currency Picker Testing Checklist

## Pre-Flight Verification

### ✅ Code Analysis
```
✓ flutter analyze - No errors
✓ Currency picker dialog updated
✓ Settings screen integrated
✓ ProfileCubit sync enabled
✓ CurrencySyncService registered in DI
```

## Test Cases

### 1. Initial State Verification
**Status:** ⏳ Pending

**Steps:**
1. Launch app on emulator
2. Login with valid credentials
3. Navigate to Settings
4. Locate "Regional Settings" section

**Expected Results:**
- ✓ "Regional Settings" section displays with icon
- ✓ "Language" tile shows current language (e.g., "English")
- ✓ "Country" tile shows current country (e.g., "United Kingdom")
- ✓ "Currency" tile shows synced currency from CurrencySyncService (e.g., "USD")
- ✓ All tiles have arrow_forward_ios icons
- ✓ All tiles are tappable

**Actual Results:** ⏳ To be tested

---

### 2. Currency Picker Dialog Launch
**Status:** ⏳ Pending

**Steps:**
1. In Settings → Regional Settings
2. Tap on "Currency" tile
3. Observe dialog appearance

**Expected Results:**
- ✓ CurrencyPickerDialog opens smoothly
- ✓ Dialog shows "Select Currency" title with icon
- ✓ Helper text displays: "Choose your preferred currency for transactions"
- ✓ Close button (X) visible in top-right
- ✓ 30+ currencies listed in scrollable view
- ✓ Current currency is pre-selected with purple border
- ✓ Each currency shows: symbol in circle, currency code, full name
- ✓ Selected currency has checkmark icon
- ✓ "Save" button at bottom is enabled and purple

**Actual Results:** ⏳ To be tested

---

### 3. Currency Selection Interaction
**Status:** ⏳ Pending

**Steps:**
1. In Currency Picker Dialog
2. Tap on different currency (e.g., "EUR")
3. Observe visual feedback
4. Tap another currency (e.g., "GBP")
5. Observe visual feedback

**Expected Results:**
- ✓ Tapped currency gets selected immediately
- ✓ Previous selection deselects
- ✓ Selected currency shows purple border (2px)
- ✓ Background changes to light purple
- ✓ Circle background changes to purple
- ✓ Currency text changes to purple
- ✓ Checkmark icon appears
- ✓ Smooth transition animation

**Actual Results:** ⏳ To be tested

---

### 4. Currency Save Operation
**Status:** ⏳ Pending

**Steps:**
1. Select a new currency (e.g., "EUR")
2. Tap "Save" button
3. Observe loading state
4. Wait for completion

**Expected Results:**
- ✓ Button shows loading spinner (CircularProgressIndicator)
- ✓ Button is disabled during save
- ✓ Save text is replaced with spinner
- ✓ Dialog closes automatically after successful save
- ✓ No errors in console/logs

**Actual Results:** ⏳ To be tested

---

### 5. Settings Screen Update
**Status:** ⏳ Pending

**Steps:**
1. After currency save completes
2. Observe Settings screen
3. Check "Currency" tile subtitle

**Expected Results:**
- ✓ Currency tile now shows new currency (e.g., "EUR")
- ✓ Update happens automatically (StreamBuilder triggered)
- ✓ No need to refresh or navigate away
- ✓ Success message displays: "Preferences updated successfully"

**Actual Results:** ⏳ To be tested

---

### 6. Local Storage Sync Verification
**Status:** ⏳ Pending

**Steps:**
1. After changing currency
2. Close Settings
3. Reopen Settings
4. Check Currency tile

**Expected Results:**
- ✓ Currency tile still shows new currency (e.g., "EUR")
- ✓ Currency persists across app restarts
- ✓ No reversion to previous currency

**Actual Results:** ⏳ To be tested

---

### 7. Server Sync Verification
**Status:** ⏳ Pending

**Steps:**
1. Change currency in app
2. Check server logs or network requests
3. Verify updatePreferences API call

**Expected Results:**
- ✓ ProfileCubit.updatePreferences() is called with new currency
- ✓ CurrencySyncService.updateCurrency() is called
- ✓ gRPC call to update server preferences succeeds
- ✓ Server stores new currency for user

**Actual Results:** ⏳ To be tested

---

### 8. Reactive Currency Display Test
**Status:** ⏳ Pending

**Steps:**
1. Navigate to a screen showing currency (e.g., Dashboard)
2. Note current currency symbol
3. Go to Settings → Currency
4. Change currency to different one
5. Return to Dashboard
6. Observe currency display

**Expected Results:**
- ✓ Dashboard currency widget shows new currency
- ✓ All CurrencyDisplayWidgets update automatically
- ✓ CurrencyCodeWidget shows new code
- ✓ CurrencySymbolWidget shows new symbol
- ✓ No stale currency displays anywhere in app

**Actual Results:** ⏳ To be tested

---

### 9. Currency List Verification
**Status:** ⏳ Pending

**Currency Count:** Should be 30 currencies

**Verify these currencies exist:**

**Major Currencies:**
- ✓ GBP - British Pound
- ✓ USD - US Dollar
- ✓ EUR - Euro
- ✓ JPY - Japanese Yen

**Americas:**
- ✓ CAD - Canadian Dollar
- ✓ AUD - Australian Dollar
- ✓ BRL - Brazilian Real
- ✓ MXN - Mexican Peso

**Asia-Pacific:**
- ✓ CNY - Chinese Yuan
- ✓ INR - Indian Rupee
- ✓ SGD - Singapore Dollar
- ✓ HKD - Hong Kong Dollar
- ✓ THB - Thai Baht
- ✓ IDR - Indonesian Rupiah
- ✓ MYR - Malaysian Ringgit
- ✓ PHP - Philippine Peso
- ✓ VND - Vietnamese Dong

**Europe:**
- ✓ CHF - Swiss Franc
- ✓ NOK - Norwegian Krone
- ✓ SEK - Swedish Krona
- ✓ DKK - Danish Krone
- ✓ PLN - Polish Zloty

**Middle East & Africa:**
- ✓ NGN - Nigerian Naira
- ✓ ZAR - South African Rand
- ✓ EGP - Egyptian Pound
- ✓ KES - Kenyan Shilling
- ✓ GHS - Ghanaian Cedi
- ✓ UGX - Ugandan Shilling
- ✓ XOF - West African CFA Franc
- ✓ XAF - Central African CFA Franc

**Actual Results:** ⏳ To be tested

---

### 10. Error Handling Test
**Status:** ⏳ Pending

**Steps:**
1. Enable airplane mode
2. Open Settings → Currency
3. Select new currency
4. Tap Save
5. Observe behavior

**Expected Results:**
- ✓ Loading spinner appears
- ✓ App attempts server sync
- ✓ Error message displayed if sync fails
- ✓ Currency reverts to original if save fails
- ✓ User can try again

**Actual Results:** ⏳ To be tested

---

### 11. Dialog Dismissal Test
**Status:** ⏳ Pending

**Test A: X Button**
1. Open Currency Picker
2. Tap X button in top-right
3. ✓ Dialog closes without saving changes

**Test B: Outside Tap**
1. Open Currency Picker
2. Tap outside dialog
3. ✓ Dialog dismisses without saving

**Test C: Back Button**
1. Open Currency Picker
2. Tap device back button
3. ✓ Dialog closes

**Actual Results:** ⏳ To be tested

---

### 12. Multiple Currency Changes
**Status:** ⏳ Pending

**Steps:**
1. Change currency to USD
2. Wait for save
3. Change currency to EUR
4. Wait for save
5. Change currency to GBP
6. Wait for save

**Expected Results:**
- ✓ Each change saves successfully
- ✓ No corruption or conflicts
- ✓ Final currency is GBP
- ✓ All updates reflect across app

**Actual Results:** ⏳ To be tested

---

### 13. Login Flow Currency Sync
**Status:** ⏳ Pending

**Steps:**
1. Logout from app
2. Login again
3. Navigate to Settings → Currency
4. Check displayed currency

**Expected Results:**
- ✓ Currency syncs from server automatically on login
- ✓ AuthenticationCubit calls CurrencySyncService.syncFromServer()
- ✓ Currency displayed matches server preference
- ✓ No manual refresh needed

**Actual Results:** ⏳ To be tested

---

### 14. Logout Currency Clear Test
**Status:** ⏳ Pending

**Steps:**
1. Note current currency in Settings
2. Logout from app
3. Check CurrencySyncService state
4. Verify local storage cleared

**Expected Results:**
- ✓ AuthenticationCubit.logout() calls CurrencySyncService.clear()
- ✓ Currency sync state is reset
- ✓ _isInitialized flag set to false
- ✓ _lastKnownServerCurrency set to null

**Actual Results:** ⏳ To be tested

---

### 15. UI/UX Verification
**Status:** ⏳ Pending

**Visual Design:**
- ✓ Dialog uses 20r border radius
- ✓ Purple theme color (0xFF4E03D0)
- ✓ Proper spacing (16h, 12w, 8.h)
- ✓ Text uses Google Fonts Inter
- ✓ Font sizes: 22sp title, 16sp currency code, 13sp description
- ✓ Icons: attach_money_outlined, close, check_circle, arrow_forward_ios
- ✓ Colors match app design system

**Accessibility:**
- ✓ All tappable areas are sufficient size (min 44x44)
- ✓ Visual feedback for all interactions
- ✓ Loading states communicated clearly
- ✓ Error messages are clear and actionable

**Actual Results:** ⏳ To be tested

---

## Code Integration Verification

### File: settings_screen.dart
**Line:** 11 (Import CurrencySyncService)
**Line:** 309 (Get CurrencySyncService instance)
**Line:** 366-392 (StreamBuilder for reactive currency)
✓ Import added
✓ Service locator used correctly
✓ StreamBuilder subscribes to currencyStream
✓ Initial data set correctly
✓ Currency picker dialog called with current currency

### File: currency_picker_dialog.dart
**Line:** 73-75 (Save handler)
✓ Uses ProfileCubit.updatePreferences()
✓ NOT using updateUserProfile (bug fixed)
✓ Loading state managed
✓ Async/await used correctly

### File: profile_cubit.dart
**Line:** 8 (CurrencySyncService dependency)
**Line:** 107-110 (Sync currency in updatePreferences)
✓ CurrencySyncService injected
✓ Calls _currencySyncService.updateCurrency() when currency != null

### File: currency_sync_service.dart
✓ Service implemented
✓ updateCurrency() method syncs to both local and server
✓ currencyStream provides reactive updates

---

## Performance Tests

### 1. Dialog Open Speed
**Target:** < 100ms
**Test:** Measure time from tap to dialog fully rendered

### 2. Currency Selection Speed
**Target:** Instant visual feedback
**Test:** No lag when selecting different currencies

### 3. Save Operation Speed
**Target:** < 2 seconds with good network
**Target:** < 5 seconds with slow network
**Test:** Measure from tap Save to dialog close

---

## Regression Tests

### 1. Language Picker Still Works
- ✓ Language tile still functional
- ✓ LanguagePickerDialog opens correctly

### 2. Country Picker Still Works
- ✓ Country tile still functional
- ✓ CountryPickerDialog opens correctly

### 3. Notification Settings Still Work
- ✓ All switches functional
- ✓ Settings persist correctly

---

## Test Summary

| Test Case | Status | Pass/Fail | Notes |
|-----------|--------|-----------|-------|
| 1. Initial State | ⏳ Pending | | |
| 2. Dialog Launch | ⏳ Pending | | |
| 3. Selection Interaction | ⏳ Pending | | |
| 4. Save Operation | ⏳ Pending | | |
| 5. Settings Update | ⏳ Pending | | |
| 6. Local Storage | ⏳ Pending | | |
| 7. Server Sync | ⏳ Pending | | |
| 8. Reactive Display | ⏳ Pending | | |
| 9. Currency List | ⏳ Pending | | |
| 10. Error Handling | ⏳ Pending | | |
| 11. Dialog Dismissal | ⏳ Pending | | |
| 12. Multiple Changes | ⏳ Pending | | |
| 13. Login Sync | ⏳ Pending | | |
| 14. Logout Clear | ⏳ Pending | | |
| 15. UI/UX | ⏳ Pending | | |

**Overall Status:** ⏳ Awaiting Manual Testing

---

## Quick Test Commands

```bash
# Run app on emulator
flutter run -d emulator-5554

# Check for errors
flutter analyze lib/src/features/settings/presentation/view/settings_screen.dart
flutter analyze lib/src/features/profile/presentation/widgets/currency_picker_dialog.dart

# Run tests (if available)
flutter test test/features/settings/
```

---

## Test Data

### Test Currency Values
```
Initial: USD
Test 1: EUR
Test 2: GBP
Test 3: JPY
Test 4: NGN
Final: USD
```

### Test Accounts
```
Account 1: Standard user
Account 2: Premium user
Account 3: New user (first time setting currency)
```

---

## Known Limitations

1. **Offline Mode**: Currency changes require server sync
2. **Network Speed**: Save operation depends on network
3. **Concurrent Changes**: Multiple rapid changes may conflict

---

## Next Steps After Testing

- [ ] Document any bugs found
- [ ] Fix identified issues
- [ ] Re-test after fixes
- [ ] Update documentation
- [ ] Deploy to staging
- [ ] User acceptance testing

---

**Test Date:** 2025-01-12
**Tester:** Automated Verification + Manual Testing Required
**Build Version:** Latest
