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

# Generate Dart code from proto files
echo "Generating Dart code from proto files..."
protoc --dart_out=grpc:lib/src/generated -Iproto proto/*.proto proto/google/protobuf/*.proto proto/stocks/*.proto

# Generate crypto.proto from crypto-microservice
echo "Generating Dart code from crypto.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../crypto-microservice/proto \
  -Iproto \
  ../crypto-microservice/proto/crypto.proto

# Generate voice_session.proto from lazervault-golang
echo "Generating Dart code from voice_session.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../lazervault-golang/proto \
  -Iproto \
  ../lazervault-golang/proto/voice_session.proto

# Generate insurance.proto from insurance-microservice
echo "Generating Dart code from insurance.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../insurance-microservice/proto \
  -I../lazervault-golang/proto \
  -Iproto \
  ../insurance-microservice/proto/insurance.proto \
  ../insurance-microservice/proto/common.proto

# Generate accounts.proto from accounts-microservice
echo "Generating Dart code from accounts.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/accounts-service/accounts-microservice/proto \
  -Iproto \
  ../microservices/accounts-service/accounts-microservice/proto/accounts.proto

if [ $? -eq 0 ]; then
    echo "Dart code generation successful."
else
    echo "Dart code generation failed. Please check prerequisites and PATH."
    exit 1
fi 