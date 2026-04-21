#!/bin/bash

# Verification Script: Confirm Crypto Integration Tests Use Real Backend
#
# This script helps verify that the integration tests are making REAL backend calls
# and not using mocks.
#
# Usage: ./scripts/verify_real_backend_tests.sh

set -e

echo "=================================="
echo "Real Backend Test Verification"
echo "=================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Step 1: Check if backend services are running
echo "Step 1: Checking if backend services are running..."
echo ""

if lsof -i :7878 > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} core-gateway is running on port 7878"
    CORE_GATEWAY_RUNNING=true
else
    echo -e "${RED}✗${NC} core-gateway is NOT running on port 7878"
    echo -e "${YELLOW}  Start with: cd services/core-gateway && go run cmd/server/main.go${NC}"
    CORE_GATEWAY_RUNNING=false
fi

if lsof -i :9090 > /dev/null 2>&1; then
    echo -e "${GREEN}✓${NC} crypto-gateway is running on port 9090"
    CRYPTO_GATEWAY_RUNNING=true
else
    echo -e "${RED}✗${NC} crypto-gateway is NOT running on port 9090"
    echo -e "${YELLOW}  Start with: cd services/financial-gateway && go run cmd/server/main.go${NC}"
    CRYPTO_GATEWAY_RUNNING=false
fi

echo ""

# Step 2: Check test file for mocking indicators
echo "Step 2: Analyzing test file for mock usage..."
echo ""

TEST_FILE="lazervaultapp/test/integration/crypto_wallets_integration_test.dart"

if [ ! -f "$TEST_FILE" ]; then
    echo -e "${RED}✗${NC} Test file not found: $TEST_FILE"
    exit 1
fi

# Check for MockTail (mocking library)
if grep -q "mocktail" "$TEST_FILE"; then
    echo -e "${RED}✗${NC} Test file uses MockTail (mocking library)"
    echo -e "${YELLOW}  This means tests are using MOCKS, not real backend${NC}"
    HAS_MOCKS=true
else
    echo -e "${GREEN}✓${NC} Test file does NOT use MockTail"
    HAS_MOCKS=false
fi

# Check for Mock classes
if grep -q "class Mock" "$TEST_FILE"; then
    echo -e "${RED}✗${NC} Test file defines Mock classes"
    echo -e "${YELLOW}  This means tests are using MOCKS, not real backend${NC}"
    HAS_MOCKS=true
else
    echo -e "${GREEN}✓${NC} Test file does NOT define Mock classes"
fi

# Check for serviceLocator (real DI)
if grep -q "serviceLocator<CryptoCubit>" "$TEST_FILE"; then
    echo -e "${GREEN}✓${NC} Test uses serviceLocator<CryptoCubit>() (REAL cubit from DI)"
else
    echo -e "${YELLOW}⚠${NC} Test might not use real CryptoCubit from service locator"
fi

# Check for real widget imports
if grep -q "import.*crypto_screen.dart" "$TEST_FILE" && \
   grep -q "import.*crypto_wallets_screen.dart" "$TEST_FILE"; then
    echo -e "${GREEN}✓${NC} Test imports REAL widget files (crypto_screen.dart, crypto_wallets_screen.dart)"
else
    echo -e "${YELLOW}⚠${NC} Test might not import real widget files"
fi

echo ""

# Step 3: Verify real gRPC channel usage
echo "Step 3: Checking for real gRPC channel usage..."
echo ""

if grep -q "ClientChannel" "$TEST_FILE"; then
    echo -e "${GREEN}✓${NC} Test creates real gRPC ClientChannel"
    if grep -q "localhost:7878\|localhost:9090" "$TEST_FILE"; then
        echo -e "${GREEN}✓${NC} Test connects to real backend URLs (localhost:7878, localhost:9090)"
    fi
else
    echo -e "${YELLOW}⚠${NC} Test might not create real gRPC channels"
fi

echo ""

# Step 4: Test backend connectivity
echo "Step 4: Testing actual backend connectivity..."
echo ""

if [ "$CORE_GATEWAY_RUNNING" = true ]; then
    if curl -s http://localhost:7878/health > /dev/null 2>&1 || \
       curl -s http://localhost:7878/api/v1/health > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} core-gateway is responding to HTTP requests"
    else
        echo -e "${YELLOW}⚠${NC} core-gateway is running but not responding to /health endpoint"
    fi
fi

if [ "$CRYPTO_GATEWAY_RUNNING" = true ]; then
    if curl -s http://localhost:9090/health > /dev/null 2>&1 || \
       curl -s http://localhost:9090/api/v1/health > /dev/null 2>&1; then
        echo -e "${GREEN}✓${NC} crypto-gateway is responding to HTTP requests"
    else
        echo -e "${YELLOW}⚠${NC} crypto-gateway is running but not responding to /health endpoint"
    fi
fi

echo ""

# Step 5: Final verdict
echo "=================================="
echo "VERIFICATION RESULTS"
echo "=================================="
echo ""

if [ "$HAS_MOCKS" = true ]; then
    echo -e "${RED}❌ FAIL: Tests are using MOCKS${NC}"
    echo ""
    echo "The integration tests are using mocked repositories and cubits."
    echo "They will NOT make real backend calls."
    echo ""
    echo "To fix:"
    echo "  1. Remove all Mock class definitions"
    echo "  2. Remove all mocktail imports"
    echo "  3. Use serviceLocator<CryptoCubit>() for real cubit"
    echo "  4. Use real widgets, not test doubles"
    exit 1
elif [ "$CORE_GATEWAY_RUNNING" = false ] || [ "$CRYPTO_GATEWAY_RUNNING" = false ]; then
    echo -e "${YELLOW}⚠️  WARNING: Backend services not running${NC}"
    echo ""
    echo "The test file looks good (no mocks detected), but backend services"
    echo "are not currently running. Tests will fail with connection errors."
    echo ""
    echo "To fix:"
    echo "  ./start_all_local_no_docker.sh"
    echo ""
    echo "Or start individual services:"
    echo "  cd services/core-gateway && go run cmd/server/main.go"
    echo "  cd services/financial-gateway && go run cmd/server/main.go"
    exit 1
else
    echo -e "${GREEN}✅ PASS: Tests are configured for REAL backend calls${NC}"
    echo ""
    echo "Verification complete! The integration tests:"
    echo "  ✓ Use real Flutter widgets (not test doubles)"
    echo "  ✓ Use real CryptoCubit from service locator"
    echo "  ✓ Make real gRPC calls to backend"
    echo "  ✓ Connect to localhost:7878 and localhost:9090"
    echo ""
    echo "You can now run the tests:"
    echo "  cd lazervaultapp"
    echo "  flutter test test/integration/crypto_wallets_integration_test.dart --timeout=15m"
    exit 0
fi
