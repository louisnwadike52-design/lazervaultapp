# LazerVault Server Status

**Generated:** December 26, 2025 02:30 AM
**Status Check:** All systems operational ✅

---

## 🟢 CORE BACKEND SERVICES - ALL RUNNING

### 1. LazerVault Go Backend Server ✅ RUNNING
**Status:** 🟢 Active
**Process ID:** 81856
**Binary:** `./lazervault-server`
**Ports:**
- gRPC: `7007` (LISTENING)
- HTTP: `7878` (LISTENING)

**Endpoints:**
- gRPC Gateway: `http://localhost:7878`
- gRPC Direct: `localhost:7007`
- Swagger UI: `http://localhost:7878/swagger/index.html` (if enabled)

**Configuration:**
- Environment: `development`
- Database: PostgreSQL on localhost:5432
- Cache: Redis on localhost:6379
- Auth: PASETO tokens (1h access, 24h refresh)

**Features Available:**
✅ User Authentication
✅ Login with Password
✅ Login with Passcode
✅ **Change Passcode (NEW)** ⭐
✅ Register Passcode
✅ Refresh Token
✅ Email Verification
✅ Password Reset
✅ Facial Recognition
✅ Phone Verification

---

### 2. PostgreSQL Database ✅ RUNNING
**Status:** 🟢 Accepting connections
**Host:** localhost
**Port:** 5432
**Database:** `lazervault_go_db`
**User:** louislawrence
**SSL Mode:** disabled (development)

**Active Connections:**
- 2 idle connections to lazervault_go_db

**Migrations:** Up to date (auto-run on server start)

---

### 3. Redis Cache ✅ RUNNING
**Status:** 🟢 Responding to PING
**Host:** localhost
**Port:** 6379
**Use Cases:**
- Session management
- Background job queue (Asynq)
- Email verification codes
- Password reset tokens

---

### 4. AI Service (Python) ✅ RUNNING
**Status:** 🟢 Active
**Process ID:** 82352
**Port:** 8080
**Type:** Python Django/Flask service
**Command:** `main.py start`
**Uptime:** ~19 hours (since Wed 4PM)

**Configured Services:**
- AI Service URL: `http://localhost:8000` (configured in app.env)
- AI Scan Service URL: `http://localhost:8000`
- **Note:** Service is on port 8080 but config references 8000

---

## 🟡 OPTIONAL SERVICES

### 5. LiveKit (External) ⚙️ CONFIGURED
**Status:** 🟡 External service (not local)
**URL:** `wss://lazervault-sgb9bwog.livekit.cloud`
**API Key:** Configured
**Use Case:** Video/Audio calls

---

### 6. Email Service (SMTP) ⚙️ CONFIGURED
**Status:** 🟡 Configured (Mailgun)
**Provider:** Mailgun
**Host:** smtp.mailgun.org
**Port:** 587
**From:** noreply@lazervault.com

**Note:** Requires valid SMTP credentials for production

---

## 📊 PORT USAGE SUMMARY

| Port | Service | Status | Protocol |
|------|---------|--------|----------|
| 5432 | PostgreSQL | 🟢 LISTENING | TCP |
| 6379 | Redis | 🟢 LISTENING | TCP |
| 7007 | LazerVault gRPC | 🟢 LISTENING | gRPC |
| 7878 | LazerVault HTTP | 🟢 LISTENING | HTTP |
| 8080 | AI Service | 🟢 LISTENING | HTTP |

---

## 🧪 TESTING THE PASSCODE CHANGE FEATURE

### Quick API Test

Test the change passcode endpoint:

```bash
# 1. First, login to get a token
curl -X POST http://localhost:7878/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "your_password"
  }'

# 2. Extract the access_token from response

# 3. Test change passcode
curl -X POST http://localhost:7878/v1/auth/change-passcode \
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

---

## 🚀 STARTING THE FLUTTER APP

The Flutter app can now be started to test the complete flow:

```bash
cd /Users/louislawrence/Music/apps/stack/lazervaultapp

# Run on iOS Simulator
flutter run

# Or run on Android Emulator
flutter run -d android

# Or run on Chrome (web)
flutter run -d chrome
```

### Testing Steps in Flutter App:

1. **Launch App** → Login with credentials
2. **Navigate** → Settings → Security
3. **Find** → "Change Passcode" menu item
4. **Tap** → Change Passcode
5. **Enter** → Current passcode (6 digits)
6. **Enter** → New passcode (6 digits)
7. **Confirm** → New passcode (6 digits)
8. **Verify** → Success message appears
9. **Test** → Logout and login with new passcode

---

## 🔧 MANAGING SERVERS

### Stop Backend Server
```bash
kill 81856  # or killall lazervault-server
```

### Stop AI Service
```bash
kill 82352  # or use the service's stop command
```

### Restart Backend Server
```bash
cd /Users/louislawrence/Music/apps/stack/lazervault-golang
go run main.go
# or
./lazervault-server
```

### View Backend Logs
```bash
# If running in foreground, logs appear in terminal
# Check for log files:
ls -la /Users/louislawrence/Music/apps/stack/lazervault-golang/*.log
```

---

## ✅ READINESS CHECKLIST

- [x] PostgreSQL database running
- [x] Redis cache running
- [x] LazerVault Go backend running
- [x] AI service running
- [x] Proto files generated (backend)
- [x] Proto files generated (frontend)
- [x] Change passcode endpoint implemented
- [x] Change passcode UI screen created
- [x] Settings menu integration complete
- [ ] Flutter app launched
- [ ] Manual testing started

---

## 🎯 NEXT STEPS

1. ✅ All backend services are running
2. ✅ Backend is ready for API calls
3. ⏳ **Launch Flutter app**: `cd /Users/louislawrence/Music/apps/stack/lazervaultapp && flutter run`
4. ⏳ **Navigate to**: Settings → Security → Change Passcode
5. ⏳ **Test the flow**: Follow test cases in PASSCODE_CHANGE_TEST_PLAN.md
6. ⏳ **Verify**: New passcode works for login

---

## 📞 TROUBLESHOOTING

### If Backend Server Isn't Responding

1. Check logs for errors
2. Verify database connection: `psql -U louislawrence -d lazervault_go_db -h localhost`
3. Verify Redis: `redis-cli ping`
4. Check port conflicts: `lsof -i :7007 -i :7878`

### If Flutter App Can't Connect

1. Verify backend is running on ports 7007/7878
2. Check Flutter app's gRPC configuration
3. Ensure IP address is correct (localhost vs actual IP)
4. Check firewall settings

---

## 📚 DOCUMENTATION REFERENCES

- **Test Plan**: `/PASSCODE_CHANGE_TEST_PLAN.md`
- **Test Results**: `/PASSCODE_CHANGE_TEST_RESULTS.md`
- **Implementation Guide**: `/PASSCODE_IMPLEMENTATION_GUIDE.md`
- **Backend Config**: `/Users/louislawrence/Music/apps/stack/lazervault-golang/app.env`

---

**All systems ready for testing the passcode change feature! 🚀**
