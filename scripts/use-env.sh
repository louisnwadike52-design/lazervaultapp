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

# ---------------------------------------------------------------------------
# PROD ENV GATE — a production build must ship ONLY prod (api.lazervault.app)
# connections. Any dev/localhost/non-prod host in the bundled .env would OVERRIDE
# the compiled prod tier (dotenv wins) and leak a dev connection into production.
# Fail hard here — before any build/upload — and restore the previous .env.
# (Scans value lines only; comments/blank lines are ignored.)
# ---------------------------------------------------------------------------
if [ "$TIER" = "prod" ]; then
  if BAD=$(grep -vE '^[[:space:]]*(#|$)' .env | grep -iE '10\.0\.2\.2|127\.0\.0\.1|localhost|dev\.lazervault\.app|staging\.lazervault\.app|\.run\.app'); then
    echo "✗ PROD ENV GATE FAILED — non-prod hosts found in .env (from $SRC):" >&2
    printf '    %s\n' "$BAD" >&2
    echo "  These OVERRIDE the prod tier and would ship a dev/localhost connection to production." >&2
    echo "  Remove them from $SRC — the prod tier derives every gateway to api.lazervault.app." >&2
    if [ -f .env.bak ]; then cp .env.bak .env; echo "  (restored previous .env from .env.bak)" >&2; fi
    exit 1
  fi
  echo "✓ prod env gate passed — no dev/localhost/non-prod hosts in .env"
fi

echo "✓ copied $SRC → .env (backup at .env.bak)"
echo "  Build tier should match: flutter run --flavor $TIER --dart-define=FLUTTER_FLAVOR=$TIER"
