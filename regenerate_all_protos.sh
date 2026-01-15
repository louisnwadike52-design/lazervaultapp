#!/bin/bash

# Add dart global bin to PATH
export PATH="$PATH:$HOME/.pub-cache/bin"

# Create the generated directory
echo "Creating generated code directory..."
mkdir -p lib/src/generated

# Download required proto files
echo "Downloading common proto dependencies..."
mkdir -p proto/google/api
curl -s -o proto/google/api/annotations.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/annotations.proto
curl -s -o proto/google/api/http.proto https://raw.githubusercontent.com/googleapis/googleapis/master/google/api/http.proto

mkdir -p proto/google/protobuf
curl -s -o proto/google/protobuf/empty.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/empty.proto
curl -s -o proto/google/protobuf/timestamp.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/timestamp.proto
curl -s -o proto/google/protobuf/wrappers.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/wrappers.proto

mkdir -p proto/protoc-gen-openapiv2/options
curl -s -o proto/protoc-gen-openapiv2/options/annotations.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/annotations.proto
curl -s -o proto/protoc-gen-openapiv2/options/openapiv2.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/openapiv2.proto
echo "Proto dependencies downloaded."

# Generate auth.proto
echo "Generating Dart code from auth.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/auth-service/auth-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/auth-service/auth-microservice/proto/auth.proto \
  ../microservices/auth-service/auth-microservice/proto/transaction_pin.proto

# Generate accounts.proto and family_accounts.proto
echo "Generating Dart code from accounts proto files..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/accounts-service/accounts-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/accounts-service/accounts-microservice/proto/accounts.proto \
  ../microservices/accounts-service/accounts-microservice/proto/family_accounts.proto

# Generate voice-biometrics.proto
echo "Generating Dart code from voice-biometrics.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/voice-biometrics-service/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/voice-biometrics-service/proto/voice-biometrics.proto

# Generate payments.proto
echo "Generating Dart code from payments.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/core-payments-service/core-payments-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/core-payments-service/core-payments-microservice/proto/payments.proto

# Generate utility-payments.proto
echo "Generating Dart code from utility-payments.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/utility-payments-service/utility-payments-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/utility-payments-service/utility-payments-microservice/proto/utility-payments.proto

# Generate invoice.proto
echo "Generating Dart code from invoice.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/invoice-service/invoice-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/invoice-service/invoice-microservice/proto/invoice.proto

# Generate giftcards.proto
echo "Generating Dart code from giftcards.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/giftcards-service/giftcards-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/giftcards-service/giftcards-microservice/proto/giftcards.proto

# Generate financial-products.proto
echo "Generating Dart code from financial-products.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/financial-products-service/financial-products-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/financial-products-service/financial-products-microservice/proto/financial-products.proto

# Generate local proto files
echo "Generating Dart code from local proto files..."
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/*.proto 2>/dev/null || true

echo "Dart code generation complete!"
