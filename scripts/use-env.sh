#!/usr/bin/env bash
#
# use-env.sh — copy a per-tier env source file (.env.dev/.env.staging/.env.prod)
# OVER the canonical runtime file (.env) that Flutter reads at startup.
#
# Why this exists: Flutter dotenv loads ONE file (`.env`). The codebase
# treats `.env` as the single source of truth at runtime. The per-tier
# files are editable source — pick one, copy it in, build.
#
# Usage:
#   scripts/use-env.sh dev
#   scripts/use-env.sh staging
#   scripts/use-env.sh prod
#
# Then:
#   flutter run --flavor <tier> --dart-define=FLUTTER_FLAVOR=<tier>
#
# Idempotent. Always overwrites .env. A backup of the previous .env is
# kept at .env.bak so a wrong tier is one `mv` away from recovery.

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "usage: $0 <dev|staging|prod>" >&2
  exit 2
fi

TIER="$1"
case "$TIER" in
  dev|staging|prod) ;;
  *)
    echo "error: tier must be dev | staging | prod (got: $TIER)" >&2
    exit 2
    ;;
esac

# Run from the Flutter app root regardless of where the script was invoked.
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
APP_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
cd "$APP_ROOT"

SRC=".env.$TIER"
if [ ! -f "$SRC" ]; then
  echo "error: $SRC not found in $APP_ROOT" >&2
  exit 1
fi

if [ -f .env ]; then
  cp .env .env.bak
fi
cp "$SRC" .env

echo "✓ copied $SRC → .env (backup at .env.bak)"
echo "  Build tier should match: flutter run --flavor $TIER --dart-define=FLUTTER_FLAVOR=$TIER"
