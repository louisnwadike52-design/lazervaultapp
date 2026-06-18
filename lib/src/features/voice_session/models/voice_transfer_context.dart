import 'package:characters/characters.dart';
import 'package:equatable/equatable.dart';

/// Lifecycle status of a voice-driven transfer, accumulated incrementally as
/// the (chunked) WebSocket events arrive. There are NO granular per-field
/// events, so the cubit fills this context piece by piece across states.
enum VoiceTransferStatus {
  /// No active transfer (or it has been reset).
  idle,

  /// A recipient has been chosen (recipient panel can render).
  recipientSelected,

  /// An amount has been attached (rare standalone — usually folded into
  /// [reviewing] when the transfer summary arrives).
  amountSet,

  /// Full transfer summary present (amount + account/bank + fee + total) and
  /// awaiting the user's confirmation / review.
  reviewing,

  /// Awaiting PIN authorization (the actual PIN entry is the existing bottom
  /// sheet — the HUD only reflects this status).
  awaitingPin,

  /// Transfer completed successfully.
  success,

  /// Transfer failed / was rejected (reason in [failureReason]).
  failed,

  /// User cancelled the transfer mid-flow.
  cancelled,
}

/// Lightweight, immutable snapshot of the in-flight voice transfer. The cubit
/// holds ONE of these and rebuilds it incrementally (via [copyWith]) as the
/// transfer states arrive, so the sci-fi HUD can render progressively.
///
/// Amounts are NAIRA (major units) — already converted by the backend. Do NOT
/// divide by 100.
class VoiceTransferContext extends Equatable {
  final VoiceTransferStatus status;

  // ── Recipient ──
  final String? recipientName;
  final String? recipientUsername;

  /// Remote profile-picture URL if the chosen user has one; otherwise null and
  /// the HUD falls back to [recipientInitials] on a brand-purple disc.
  final String? recipientAvatarUrl;

  // ── Money (NAIRA / major units) ──
  final double? amountNaira;
  final double? feeNaira;
  final double? totalNaira;
  final String currency;

  // ── Destination ──
  final String? accountDetail; // masked account number / phone
  final String? bankName;
  final String? transferTypeLabel;

  // ── Result ──
  final String? reference;
  final String? newBalance;
  final String? failureReason;

  const VoiceTransferContext({
    this.status = VoiceTransferStatus.idle,
    this.recipientName,
    this.recipientUsername,
    this.recipientAvatarUrl,
    this.amountNaira,
    this.feeNaira,
    this.totalNaira,
    this.currency = 'NGN',
    this.accountDetail,
    this.bankName,
    this.transferTypeLabel,
    this.reference,
    this.newBalance,
    this.failureReason,
  });

  /// The idle / reset context — HUD hides (or shows a slim "Ready" strip).
  static const VoiceTransferContext idle = VoiceTransferContext();

  /// True once the transfer flow has begun (anything past idle).
  bool get isActive => status != VoiceTransferStatus.idle;

  /// True for the terminal result states (success / failed / cancelled).
  bool get isTerminal =>
      status == VoiceTransferStatus.success ||
      status == VoiceTransferStatus.failed ||
      status == VoiceTransferStatus.cancelled;

  /// Whether we have enough to show the money readout.
  bool get hasAmount => amountNaira != null && amountNaira! > 0;

  /// Initials fallback (max 2 chars) derived from the recipient's display name.
  String get recipientInitials {
    final name = (recipientName ?? recipientUsername ?? '').trim();
    if (name.isEmpty) return '?';
    final parts = name.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.first.toUpperCase();
    }
    return (parts.first.characters.first + parts.last.characters.first)
        .toUpperCase();
  }

  /// Build a new context, preserving previously-accumulated fields unless
  /// explicitly overridden. Pass [resetResult] to clear terminal/result fields
  /// (used when the user searches again after a failure).
  VoiceTransferContext copyWith({
    VoiceTransferStatus? status,
    String? recipientName,
    String? recipientUsername,
    String? recipientAvatarUrl,
    double? amountNaira,
    double? feeNaira,
    double? totalNaira,
    String? currency,
    String? accountDetail,
    String? bankName,
    String? transferTypeLabel,
    String? reference,
    String? newBalance,
    String? failureReason,
    bool resetResult = false,
  }) {
    return VoiceTransferContext(
      status: status ?? this.status,
      recipientName: recipientName ?? this.recipientName,
      recipientUsername: recipientUsername ?? this.recipientUsername,
      recipientAvatarUrl: recipientAvatarUrl ?? this.recipientAvatarUrl,
      amountNaira: amountNaira ?? this.amountNaira,
      feeNaira: feeNaira ?? this.feeNaira,
      totalNaira: totalNaira ?? this.totalNaira,
      currency: currency ?? this.currency,
      accountDetail: accountDetail ?? this.accountDetail,
      bankName: bankName ?? this.bankName,
      transferTypeLabel: transferTypeLabel ?? this.transferTypeLabel,
      reference: resetResult ? null : (reference ?? this.reference),
      newBalance: resetResult ? null : (newBalance ?? this.newBalance),
      failureReason: resetResult ? null : (failureReason ?? this.failureReason),
    );
  }

  @override
  List<Object?> get props => [
        status,
        recipientName,
        recipientUsername,
        recipientAvatarUrl,
        amountNaira,
        feeNaira,
        totalNaira,
        currency,
        accountDetail,
        bankName,
        transferTypeLabel,
        reference,
        newBalance,
        failureReason,
      ];
}
