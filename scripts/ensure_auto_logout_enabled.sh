#!/usr/bin/env bash
#
# Pre-deploy safety guard — ALWAYS re-enable the screen-inactivity auto-logout
# before any store/track build, so a build can never ship with the security
# feature turned off (it may have been disabled for local testing).
#
# Auto-logout is a REMOTE, admin-dashboard-controlled setting:
#   `session_inactivity_logout_seconds` in the env's payments DB / admin console
#   (0 = DISABLED; 15-600 = enabled inactivity window; default 45).
# The Flutter app reads it from admin-gateway's /internal/voice-agents/settings.
# This guard resets it to a safe default when it's disabled (0) or out of range.
#
# Usage: ensure_auto_logout_enabled.sh <dev|staging|prod>
# Override the default window with AUTO_LOGOUT_DEFAULT_SECONDS (default 45).

set -euo pipefail

ENV_TIER="${1:?usage: ensure_auto_logout_enabled.sh <dev|staging|prod>}"
DEFAULT="${AUTO_LOGOUT_DEFAULT_SECONDS:-45}"
KEY="session_inactivity_logout_seconds"

# needs_reenable <value> → prints "yes" when the value is disabled/absent/out-of-range.
needs_reenable() {
  local v="$1"
  case "$v" in
    '' | 0) echo yes ;;                  # unset or explicitly disabled
    *[!0-9]*) echo yes ;;                # non-numeric / garbage
    *) if [ "$v" -lt 15 ] || [ "$v" -gt 600 ]; then echo yes; else echo no; fi ;;
  esac
}

case "$ENV_TIER" in
  dev)
    # Dev/internal builds point at the LOCAL stack, so the setting lives in the
    # local payments DB. Read it, and reset to the default if disabled.
    PSQL=(psql -U "${DB_USER:-postgres}" -h "${DB_HOST:-127.0.0.1}" -d "${PAYMENTS_DB:-payments_db}")
    cur="$("${PSQL[@]}" -tAc "SELECT setting_value FROM system_settings WHERE setting_key='${KEY}';" 2>/dev/null || echo '')"
    cur="$(printf '%s' "$cur" | tr -d '[:space:]')"
    if [ "$(needs_reenable "$cur")" = "yes" ]; then
      "${PSQL[@]}" -c "INSERT INTO system_settings (setting_key, setting_value, value_type, updated_by, created_at, updated_at)
        VALUES ('${KEY}', '${DEFAULT}', 'int', 'pre-deploy-guard', now(), now())
        ON CONFLICT (setting_key) DO UPDATE SET setting_value='${DEFAULT}', updated_at=now();" >/dev/null 2>&1 \
        && echo "✅ [deploy-guard] auto-logout RE-ENABLED for dev (${KEY}=${DEFAULT}; was '${cur:-unset}')" \
        || { echo "⚠️  [deploy-guard] could not write ${KEY} to local payments_db — enable it in the admin dashboard before release"; }
    else
      echo "✅ [deploy-guard] auto-logout already enabled for dev (${KEY}=${cur})"
    fi
    ;;
  staging | prod)
    # Staging/prod settings live in those envs' DBs / admin dashboards, which the
    # local deploy host must not write to directly. Loud reminder instead.
    echo "⚠️  [deploy-guard] ${ENV_TIER} deploy: auto-logout (${KEY}) is managed in the ${ENV_TIER} admin dashboard."
    echo "    → Confirm it is ENABLED (a 15-600s window, NOT 0/disabled) in the ${ENV_TIER} admin dashboard BEFORE releasing."
    ;;
  *)
    echo "⚠️  [deploy-guard] unknown env tier '${ENV_TIER}' — skipping auto-logout check"
    ;;
esac
