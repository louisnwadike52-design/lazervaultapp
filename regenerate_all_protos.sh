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
curl -s -o proto/google/protobuf/struct.proto https://raw.githubusercontent.com/protocolbuffers/protobuf/main/src/google/protobuf/struct.proto

mkdir -p proto/protoc-gen-openapiv2/options
curl -s -o proto/protoc-gen-openapiv2/options/annotations.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/annotations.proto
curl -s -o proto/protoc-gen-openapiv2/options/openapiv2.proto https://raw.githubusercontent.com/grpc-ecosystem/grpc-gateway/master/protoc-gen-openapiv2/options/openapiv2.proto
echo "Proto dependencies downloaded."

# Generate auth.proto from gateway (uses package pb to match gateway)
echo "Generating Dart code from auth.proto (from gateway)..."
protoc --dart_out=grpc:lib/src/generated \
  -I../services/core-gateway/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../services/core-gateway/proto/auth.proto

# Generate transaction_pin.proto from auth service
echo "Generating Dart code from transaction_pin.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/auth-service/auth-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/auth-service/auth-microservice/proto/transaction_pin.proto

# Generate accounts.proto, family_accounts.proto, and multi_country.proto
echo "Generating Dart code from accounts proto files..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/accounts-service/accounts-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/accounts-service/accounts-microservice/proto/accounts.proto \
  ../microservices/accounts-service/accounts-microservice/proto/family_accounts.proto \
  ../microservices/accounts-service/accounts-microservice/proto/multi_country.proto

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

# Generate qr_pay.proto
echo "Generating Dart code from qr_pay.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/qr_pay.proto

# Generate ai_chat.proto (explicit - must run AFTER batch to avoid being overwritten)
echo "Generating Dart code from ai_chat.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/ai_chat.proto

# Generate investments.proto (from investments microservice)
echo "Generating Dart code from investments.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/investments-service/investments-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/investments-service/investments-microservice/proto/investments.proto

# Generate stocks/stock.proto
echo "Generating Dart code from stocks/stock.proto..."
mkdir -p lib/src/generated/stocks
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/stocks/stock.proto

# Generate banking.proto (local proto with Move Money, Open Banking, etc.)
echo "Generating Dart code from banking.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/banking.proto

# Generate direct_chat.proto (Chat Proxy Gateway gRPC)
echo "Generating Dart code from direct_chat.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -Iproto \
  -I../microservices/shared/proto \
  proto/direct_chat.proto

# Generate payroll.proto (Business: Payroll, Customer CRM, Tax, Inventory)
echo "Generating Dart code from payroll.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/payroll-service/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/payroll-service/proto/payroll.proto

# Generate remaining local proto files (batch - some may fail due to unsupported annotations)
#
# proto/ IS A SOURCE OF TRUTH FOR SOME FILES AND A STALE MIRROR FOR OTHERS.
# 159 of the 212 generated files come from this loop, so the directory is not
# dead — but every name in the skip list below is generated from the
# MICROSERVICE copy above, and the copy sitting here is whatever was snapshotted
# when it was added. Measured 2026-11-02: 10 of the 13 then present had DIVERGED
# from their service counterpart, by up to 1,400 lines.
#
# They are not inert. accounts.proto here was 1,404 lines / 75 messages / 32
# RPCs behind, and its AccountSummary stopped at field 11 — so reading it to
# answer "does this message carry restricted_balance?" gave the wrong answer
# about a field that was live on the wire. It was deleted for that reason
# (proved unused: a full regeneration with and without it produced 212
# byte-identical files).
#
# So: to learn what a message actually contains, read the service's proto, never
# the copy here. If you touch one of these, delete it rather than sync it — a
# second copy that nothing compiles will drift again.
echo "Generating Dart code from other local proto files..."
for f in proto/*.proto; do
  basename=$(basename "$f")
  # Skip protos already generated from microservice sources above
  case "$basename" in
    ai_chat.proto|accounts.proto|family_accounts.proto|multi_country.proto|auth.proto|transaction_pin.proto|voice-biometrics.proto|payments.proto|utility-payments.proto|invoice.proto|giftcards.proto|financial-products.proto|investments.proto|banking.proto|direct_chat.proto|payroll.proto)
      continue
      ;;
  esac
  protoc --dart_out=grpc:lib/src/generated \
    -Iproto \
    -I../microservices/shared/proto \
    "$f" 2>/dev/null || echo "  Warning: Failed to generate $basename (may use unsupported annotations)"
done

# rmb.proto — RMB (China) transfer surface.
#
# ADDED 2026-11-02. It was missing from this script, so lib/src/generated/rmb.*
# could only ever be regenerated by hand — which is how it came to be listed as
# "a generated file no script reproduces". The .proto has been in the repo the
# whole time.
echo "Generating Dart code from rmb.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../microservices/rmb-service/rmb-microservice/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../microservices/rmb-service/rmb-microservice/proto/rmb.proto

# uplift.proto — Uplift surface, served by products-gateway.
#
# ADDED 2026-11-02, same reason as rmb above.
echo "Generating Dart code from uplift.proto..."
protoc --dart_out=grpc:lib/src/generated \
  -I../services/products-gateway/proto \
  -Iproto \
  -I../microservices/shared/proto \
  ../services/products-gateway/proto/uplift.proto

echo "Dart code generation complete!"
