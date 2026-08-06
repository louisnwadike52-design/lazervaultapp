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
# ENV GATE — a non-dev build must ship ONLY its own tier's connections. dotenv
# host values OVERRIDE the compiled tier, so any dev/localhost host in the synced
# .env would leak a wrong-tier connection. Fail hard (and restore the backup)
# BEFORE any build/upload. prod additionally forbids staging + stale/wrong-TLD
# backend hosts, and SANDBOX payment keys (a real prod build needs LIVE Mono/
# Flutterwave keys — set ALLOW_SANDBOX_KEYS=1 to bypass ONLY that check for an
# internal prod-routing test). Value lines only; comments/blanks ignored.
# ---------------------------------------------------------------------------
_gate_fail() {
  echo "✗ ENV GATE FAILED (tier '$TIER') — $1:" >&2
  printf '    %s\n' "$2" >&2
  [ -n "${3:-}" ] && echo "  $3" >&2
  if [ -f .env.bak ]; then cp .env.bak .env; echo "  (restored previous .env from .env.bak)" >&2; fi
  exit 1
}

if [ "$TIER" = "prod" ] || [ "$TIER" = "staging" ]; then
  VALUES=$(grep -vE '^[[:space:]]*(#|$)' .env || true)
  # dev/local hosts are forbidden in BOTH staging and prod builds.
  HOSTS='10\.0\.2\.2|127\.0\.0\.1|localhost|dev\.lazervault\.app|\.run\.app'
  # prod also forbids staging hosts + stale / wrong-TLD backend hosts.
  [ "$TIER" = "prod" ] && HOSTS="$HOSTS|staging\.lazervault\.app|api\.lazervault\.com|grpc\.lazervault\.com|chat-gateway\.lazervault\.com"
  if BAD=$(printf '%s\n' "$VALUES" | grep -iE "$HOSTS"); then
    _gate_fail "non-$TIER hosts in .env (they OVERRIDE the compiled tier)" "$BAD" \
      "Remove them from $SRC — the $TIER tier derives every gateway automatically."
  fi
  # prod must ship LIVE payment keys, never sandbox.
  if [ "$TIER" = "prod" ] && [ "${ALLOW_SANDBOX_KEYS:-0}" != "1" ]; then
    if BADK=$(printf '%s\n' "$VALUES" | grep -iE '^(MONO_(CONNECT_)?PUBLIC_KEY|FLUTTERWAVE_(PUBLIC|ENCRYPTION)_KEY)=.*(test_pk_|test_sk_|_TEST)'); then
      _gate_fail "SANDBOX payment keys in a prod build" "$BADK" \
        "Set LIVE keys in $SRC (Mono live_pk_, Flutterwave without _TEST) or inject via CI. Bypass for an internal test with ALLOW_SANDBOX_KEYS=1."
    fi
  fi
  echo "✓ $TIER env gate passed"
fi

echo "✓ copied $SRC → .env (backup at .env.bak)"
echo "  Build tier should match: flutter run --flavor $TIER --dart-define=FLUTTER_FLAVOR=$TIER"
