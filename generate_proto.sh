#!/bin/bash

# Prerequisites:
# 1. Ensure the Protobuf compiler ('protoc') is installed system-wide.
#    (e.g., using Homebrew: `brew install protobuf`)
# 2. Ensure Dart's global bin directory is added to your system PATH.
#    Run `dart pub global activate protoc_plugin` once manually first.
#    Then add the path it suggests (usually `$HOME/.pub-cache/bin`)
#    to your shell config file (e.g., ~/.zshrc or ~/.bash_profile).
#    Example: export PATH="$PATH":"$HOME/.pub-cache/bin"
#    Remember to restart your terminal or source the config file after editing.

# Install/Update Dart protoc plugin (safe to run multiple times)
echo "Ensuring Dart protoc plugin is activated..."
dart pub global activate protoc_plugin 20.0.1

# Add dart global bin to PATH
export PATH="$PATH:$HOME/.pub-cache/bin"

# Create the generated directory if it doesn't exist
echo "Creating generated code directory..."
mkdir -p lib/src/generated

# Download required proto files
echo "Downloading common proto dependencies..."
mkdir -p proto/google/api
curl -s -o proto/google/api/annotations.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
curl -s -o proto/google/api/http.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto

mkdir -p proto/google/protobuf # Create directory for standard protobuf types
curl -s -o proto/google/protobuf/empty.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/empty.proto
curl -s -o proto/google/protobuf/timestamp.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/timestamp.proto
curl -s -o proto/google/protobuf/wrappers.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/wrappers.proto

mkdir -p proto/protoc-gen-openapiv2/options
curl -s -o proto/protoc-gen-openapiv2/options/annotations.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/annotations.proto
curl -s -o proto/protoc-gen-openapiv2/options/openapiv2.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/openapiv2.proto
echo "Proto dependencies downloaded."

# Generate Dart code from proto files.
# Exclude lazervaultapp/proto/auth.proto here: it can drift from auth-microservice; Dart auth is built from ../microservices/auth-service/... below.
echo "Generating Dart code from proto files..."
LAZER_PROTO_FILES=()
for f in proto/*.proto; do
  case "$(basename "$f")" in
    auth.proto|payroll.proto) continue ;; # auth: auth-microservice; payroll: payroll-service (full RPC set)
  esac
  LAZER_PROTO_FILES+=("$f")
done
if ! protoc --dart_out=grpc:lib/src/generated -Iproto "${LAZER_PROTO_FILES[@]}" proto/google/protobuf/*.proto proto/stocks/*.proto; then
  echo "ERROR: lazervaultapp proto batch failed."
  exit 1
fi

# voice_session + ai_scan: always regenerate in isolation so gateway-synced definitions stay fresh even if the batch is changed later.
echo "Refreshing voice_session.proto and ai_scan.proto (isolated)..."
if ! protoc --dart_out=grpc:lib/src/generated -Iproto proto/voice_session.proto proto/ai_scan.proto; then
  echo "ERROR: voice_session / ai_scan regeneration failed."
  exit 1
fi

# Generate crypto.proto from crypto-microservice
echo "Generating Dart code from crypto.proto..."
if [ -f ../crypto-microservice/proto/crypto.proto ]; then
  protoc --dart_out=grpc:lib/src/generated \
    -I../crypto-microservice/proto \
    -Iproto \
    ../crypto-microservice/proto/crypto.proto
else
  echo "Skipping crypto.proto (../crypto-microservice/proto not present)."
fi

# Generate insurance.proto from insurance-microservice
echo "Generating Dart code from insurance.proto..."
if [ -f ../insurance-microservice/proto/insurance.proto ]; then
  protoc --dart_out=grpc:lib/src/generated \
    -I../insurance-microservice/proto \
    -I../lazervault-golang/proto \
    -Iproto \
    ../insurance-microservice/proto/insurance.proto \
    ../insurance-microservice/proto/common.proto
else
  echo "Skipping insurance.proto (../insurance-microservice/proto not present)."
fi

# Generate accounts.proto from accounts-microservice
echo "Generating Dart code from accounts.proto..."
if ! protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/accounts-service/accounts-microservice/proto \
  -Iproto \
  ../microservices/accounts-service/accounts-microservice/proto/accounts.proto; then
  echo "ERROR: accounts.proto generation failed."
  exit 1
fi

# Generate auth.proto from auth-service
echo "Generating Dart code from auth.proto..."
if ! protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/auth-service/auth-microservice/proto \
  -Iproto \
  ../microservices/auth-service/auth-microservice/proto/auth.proto; then
  echo "ERROR: auth.proto generation failed."
  exit 1
fi

# Generate banking.proto from banking-service
echo "Generating Dart code from banking.proto..."
if ! protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/banking-service/proto \
  -I../services/core-gateway/proto \
  -Iproto \
  ../microservices/banking-service/proto/banking.proto; then
  echo "ERROR: banking.proto generation failed."
  exit 1
fi

# Generate invoice.proto from invoice-service
echo "Generating Dart code from invoice.proto..."
if ! protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/invoice-service/invoice-microservice/proto \
  -I../services/core-gateway/proto \
  -Iproto \
  ../microservices/invoice-service/invoice-microservice/proto/invoice.proto; then
  echo "ERROR: invoice.proto generation failed."
  exit 1
fi

# Generate payroll.proto from payroll-service (canonical; lazervaultapp/proto/payroll.proto may be a trimmed copy for reference only)
echo "Generating Dart code from payroll.proto (payroll-service canonical)..."
if ! protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/payroll-service/proto \
  -Iproto \
  ../microservices/payroll-service/proto/payroll.proto; then
  echo "ERROR: payroll.proto generation failed."
  exit 1
fi

echo "Dart code generation successful." 