# 🧪 Manual Testing Instructions - Passcode Change Feature

**Date:** December 26, 2025
**Status:** ✅ App Running on Android Emulator
**Backend:** ✅ Connected to localhost:7007

---

## ✅ PRE-FLIGHT CHECK - ALL SYSTEMS GO!

### Backend Services
- ✅ **PostgreSQL Database**: Running on port 5432
- ✅ **Redis Cache**: Running on port 6379
- ✅ **Go Backend (gRPC)**: Running on port 7007
- ✅ **Go Backend (HTTP)**: Running on port 7878

### Flutter App
- ✅ **Built Successfully**: app-debug.apk installed
- ✅ **Running on**: Android Emulator (sdk gphone64 arm64)
- ✅ **gRPC Connection**: Connected to 10.0.2.2:7007 (emulator → localhost)
- ✅ **Hot Reload**: Enabled (press 'r' in terminal to reload)

**DevTools Available at**: http://127.0.0.1:49594/5nwxetmes0A=/devtools/

---

## 📱 MANUAL TESTING STEPS

### Step 1: Login to the App

1. **Open the Android Emulator** - You should see the LazerVault app launched
2. **If you see onboarding screens** - Skip through them
3. **Login Screen** - Enter your credentials:
   - Email: (your test user email)
   - Password: (your test user password)
4. **Tap Login**
5. **Verify**: You should land on the dashboard/home screen

---

### Step 2: Navigate to Settings

1. **Find the Settings Icon** - Usually in bottom navigation or hamburger menu
2. **Tap Settings**
3. **Scroll down** to find the **Security** section
4. **Verify**: You should see these options:
   - Change Password
   - Passcode
   - **Change Passcode** ⭐ (NEW!)
   - Biometric Settings
   - Verify Email
   - Verify Phone Number
   - Two-Factor Authentication
   - Trusted Devices
   - Device Permissions

---

### Step 3: Setup Initial Passcode (If Not Set)

**Only do this if you haven't set up a passcode yet:**

1. **Tap "Passcode"** in Security section
2. **Enter a 6-digit passcode**: e.g., `123456`
3. **Confirm the passcode**: `123456`
4. **Verify**: Success message should appear
5. **Go back** to Settings

---

### Step 4: Test Change Passcode - SUCCESS FLOW ✅

**Current Passcode:** 123456
**New Passcode:** 654321

#### 4.1 Open Change Passcode Screen
1. **Tap "Change Passcode"** in Settings → Security
2. **Verify**:
   - ✅ Screen title is "Change Passcode"
   - ✅ Text shows "Enter Current Passcode"
   - ✅ 6 empty passcode dots visible
   - ✅ Number pad (0-9) visible
   - ✅ Backspace button visible
   - ✅ Back arrow (top-left) visible

#### 4.2 Enter Current Passcode
1. **Tap** the following numbers: `1`, `2`, `3`, `4`, `5`, `6`
2. **Verify as you type**:
   - ✅ Each dot fills in as you enter a digit
   - ✅ No numbers are visible (dots only for security)
3. **After 6 digits**:
   - ✅ Screen automatically transitions to "Enter New Passcode"

#### 4.3 Enter New Passcode
1. **Verify**: Text now shows "Enter New Passcode"
2. **Tap** the following numbers: `6`, `5`, `4`, `3`, `2`, `1`
3. **Verify**:
   - ✅ 6 new empty dots appear (previous dots cleared)
   - ✅ Dots fill as you type
4. **After 6 digits**:
   - ✅ Screen automatically transitions to "Confirm New Passcode"

#### 4.4 Confirm New Passcode
1. **Verify**: Text now shows "Confirm New Passcode"
2. **Tap** the following numbers: `6`, `5`, `4`, `3`, `2`, `1` (same as step 4.3)
3. **After 6 digits**:
   - ✅ Loading indicator appears (circle spinner)
   - ✅ API call is being made to backend
4. **After API responds (~1-2 seconds)**:
   - ✅ **Green success snackbar** appears at bottom
   - ✅ Message: "Passcode changed successfully"
   - ✅ Screen navigates back to Settings
5. **Verify in Settings**:
   - ✅ You're back on the Settings screen

**🎉 SUCCESS! Passcode changed from 123456 to 654321**

---

### Step 5: Test Change Passcode - ERROR FLOWS ❌

#### 5.1 Test: Incorrect Old Passcode
1. **Navigate back** to Change Passcode
2. **Enter wrong old passcode**: `000000` (instead of 654321)
3. **Enter new passcode**: `111111`
4. **Confirm new passcode**: `111111`
5. **Expected Result**:
   - ❌ **Red error snackbar** appears
   - ❌ Message: "Incorrect old passcode" or "incorrect old passcode"
   - ✅ Passcode fields are cleared
   - ✅ Returns to "Enter Current Passcode" step
   - ✅ Can retry with correct passcode

#### 5.2 Test: New Passcode Mismatch
1. **Navigate back** to Change Passcode
2. **Enter correct old passcode**: `654321`
3. **Enter new passcode**: `222222`
4. **Enter DIFFERENT confirmation**: `333333`
5. **Expected Result**:
   - ❌ **Red error message** appears on screen
   - ❌ Message: "Passcodes do not match"
   - ✅ Confirmation field is cleared
   - ✅ Stays on confirmation step (can re-enter)
   - ✅ **No API call** is made

#### 5.3 Test: Same Old and New Passcode
1. **Navigate back** to Change Passcode
2. **Enter old passcode**: `654321`
3. **Enter new passcode**: `654321` (same!)
4. **Confirm new passcode**: `654321`
5. **Expected Result**:
   - ❌ API returns error
   - ❌ **Red error snackbar** appears
   - ❌ Message: "new passcode must be different from old passcode"
   - ✅ Returns to initial state

---

### Step 6: Test Backspace Button

1. **Navigate** to Change Passcode
2. **Enter** only 3 digits: `1`, `2`, `3`
3. **Verify**: 3 dots are filled
4. **Tap Backspace** button
5. **Verify**:
   - ✅ Last digit removed (now showing 2 filled dots)
   - ✅ Can continue entering digits
6. **Enter** 4 more digits to complete 6 digits
7. **Verify**: Works normally

---

### Step 7: Test Back Navigation

1. **Navigate** to Change Passcode
2. **Enter** some digits (e.g., 2-3 digits)
3. **Tap Back Arrow** (top-left)
4. **Expected Result**:
   - ✅ Navigates back to Settings
   - ✅ **No passcode change** is made
   - ✅ **No API call** is made

---

### Step 8: Verify New Passcode Works for Login

This is the **ULTIMATE TEST** - does the new passcode actually work?

1. **Logout** from the app
   - Go to Settings/Profile
   - Find Logout button
   - Tap Logout
2. **On Login Screen**:
   - Tap "Login with Passcode" (if available)
   - Or navigate to passcode login
3. **Enter NEW passcode**: `654321`
4. **Expected Result**:
   - ✅ **Successfully logs in** to the app
   - ✅ Lands on dashboard/home
5. **Try OLD passcode**: `123456` (after logging out again)
6. **Expected Result**:
   - ❌ **Login fails**
   - ❌ Error message: "Invalid passcode" or similar

**🎉 COMPLETE SUCCESS! New passcode works, old passcode doesn't!**

---

## 📊 TEST RESULTS CHECKLIST

Use this checklist as you test:

### UI/UX Tests
- [ ] Change Passcode appears in Settings → Security
- [ ] Screen shows correct title "Change Passcode"
- [ ] 3-step flow works (Current → New → Confirm)
- [ ] 6 passcode dots display correctly
- [ ] Dots fill in as digits are entered
- [ ] Number pad (0-9) is responsive
- [ ] Backspace button removes last digit
- [ ] Back navigation works

### Successful Change Tests
- [ ] Can enter current passcode (6 digits)
- [ ] Automatically moves to new passcode step
- [ ] Can enter new passcode (6 digits)
- [ ] Automatically moves to confirmation step
- [ ] Can confirm new passcode (6 digits)
- [ ] Loading indicator shows during API call
- [ ] Success message displays (green snackbar)
- [ ] Navigates back to Settings
- [ ] New passcode is saved

### Error Handling Tests
- [ ] Incorrect old passcode → error message
- [ ] Passcode mismatch → error message (no API call)
- [ ] Same old/new passcode → error message
- [ ] Network error → appropriate error message
- [ ] Error messages are clear and helpful

### Security Tests
- [ ] Old passcode is verified before change
- [ ] Passcodes are not visible (dots only)
- [ ] New passcode works for subsequent logins
- [ ] Old passcode no longer works

---

## 🐛 REPORTING ISSUES

If you find any issues, document them with:

1. **What you did** (steps to reproduce)
2. **What you expected** (expected behavior)
3. **What actually happened** (actual behavior)
4. **Screenshots** (if applicable)
5. **Any error messages** (exact text)

Check the Flutter console output for any errors:
- Red error messages
- Stack traces
- Failed API calls

---

## 🔍 MONITORING LOGS

### Flutter App Logs
The Flutter console shows real-time logs:
```
I/flutter (19301): Creating gRPC Channel to 10.0.2.2:7007
I/flutter (19301): Dependency Injection Initialized
```

Watch for:
- ✅ Successful gRPC connections
- ❌ gRPC errors
- ❌ Exception stack traces

### Backend Logs
If running backend in a terminal, watch for:
```
POST /v1/auth/change-passcode
Status: 200 OK
```

Or errors:
```
ERROR: incorrect old passcode
Status: 400 Bad Request
```

---

## 🎯 SUCCESS CRITERIA

✅ **Feature is working correctly if:**

1. User can navigate to Change Passcode from Settings
2. User can enter current, new, and confirm passcode
3. Correct passcodes result in successful change
4. Success message is displayed
5. New passcode is saved in secure storage
6. New passcode works for login
7. Old passcode no longer works
8. Error cases are handled gracefully
9. UI is responsive and user-friendly
10. No crashes or exceptions occur

---

## 📞 NEED HELP?

- **Flutter Hot Reload**: Press `r` in the terminal to reload without rebuilding
- **Flutter Hot Restart**: Press `R` to restart the app
- **Clear Console**: Press `c`
- **View DevTools**: Open http://127.0.0.1:49594/5nwxetmes0A=/devtools/ in browser
- **Quit App**: Press `q` in terminal

---

**Ready to test? The app is running on your emulator right now!** 🚀

Just look at your Android Emulator window and start testing! 📱
