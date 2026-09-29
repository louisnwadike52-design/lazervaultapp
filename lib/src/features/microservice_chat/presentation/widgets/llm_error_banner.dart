import 'package:flutter/material.dart';

/// The "AI is temporarily down, everything else still works" banner.
///
/// Driven by `metadata.llm_error_code` from
/// chat_services_shared/llm_failover.py — a signal EVERY chat service emits,
/// not just the general one. It was nonetheless private to
/// GeneralChatContent, so the identical failure inside a per-service chat
/// rendered as an ordinary answer: the fallback sentence, no chrome, nothing
/// telling the user the assistant was degraded rather than unhelpful.
///
/// Informational only — the assistant text already carries the user-facing
/// message; this is the visual signal around it.
class LlmErrorBanner {
  const LlmErrorBanner._();

  static Widget build(String code) {
    // Map codes to icon + tone. Insufficient credit / auth / model-not-found
    // get the warning amber chrome; transient codes (rate-limit / timeout /
    // service unavailable) get the softer blue.
    final isHardError = code == 'insufficient_credit' ||
        code == 'auth_failed' ||
        code == 'model_not_found';
    final borderColor = isHardError
        ? const Color(0xFFFB923C) // warning amber
        : const Color(0xFF5B45C9); // info blue
    final iconBg = borderColor.withValues(alpha: 0.15);

    final label = switch (code) {
      'insufficient_credit' => 'AI assistant — billing top-up in progress',
      'model_not_found' => 'AI assistant — being upgraded',
      'auth_failed' => 'AI assistant — config refresh in progress',
      'provider_rate_limit' => 'AI assistant — high traffic',
      'context_length_exceeded' => 'Conversation is full',
      'timeout' => 'AI assistant timed out',
      'service_unavailable' => 'AI assistant provider outage',
      _ => 'AI assistant temporarily unavailable',
    };

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor.withValues(alpha: 0.6)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(
              isHardError ? Icons.error_outline : Icons.info_outline,
              size: 16,
              color: borderColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'The regular in-app screens still work normally. You can keep using them while we get the assistant back online.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 11,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
