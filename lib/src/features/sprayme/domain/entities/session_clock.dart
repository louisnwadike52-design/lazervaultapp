library;

/// The live-session clock, as the platform has it configured.
///
/// Read from the server rather than compiled in, so a price change or a
/// different free period does not need an app release — and so a build that
/// predates the feature simply never sees a policy and behaves as it always
/// did.
class SessionClockPolicy {
  /// False = sessions have no clock at all. The room renders no countdown,
  /// no warning and no Extend control.
  final bool enabled;

  /// How long a session runs before it must be extended.
  final int freeMinutes;

  /// The ceiling on total session length, however much the host pays.
  final int maxTotalHours;

  /// Remaining-minute marks at which the host is warned, longest first.
  final List<int> warnAtMinutes;

  /// What the host can buy.
  final List<SessionExtensionOption> options;

  const SessionClockPolicy({
    this.enabled = false,
    this.freeMinutes = 120,
    this.maxTotalHours = 12,
    this.warnAtMinutes = const [15, 5, 1],
    this.options = const [],
  });

  /// The policy to assume when the server has not answered.
  ///
  /// DISABLED, deliberately. An unreachable policy endpoint must never be the
  /// reason a host is told their session is about to end, or shown prices that
  /// may not be current — the server enforces the clock either way, and the
  /// room simply shows nothing until it knows.
  static const unknown = SessionClockPolicy();

  factory SessionClockPolicy.fromJson(Map<String, dynamic> json) {
    return SessionClockPolicy(
      enabled: json['enabled'] as bool? ?? false,
      freeMinutes: (json['free_minutes'] as num?)?.toInt() ?? 120,
      maxTotalHours: (json['max_total_hours'] as num?)?.toInt() ?? 12,
      warnAtMinutes: [
        for (final m in (json['warn_at_minutes'] as List? ?? const []))
          if (m is num) m.toInt(),
      ]..sort((a, b) => b.compareTo(a)),
      options: [
        for (final o in (json['options'] as List? ?? const []))
          if (o is Map<String, dynamic>) SessionExtensionOption.fromJson(o),
      ],
    );
  }
}

/// One purchasable block of extra time.
class SessionExtensionOption {
  final int minutes;

  /// Price in kobo. The app NEVER sends this back — the request carries only
  /// [minutes], and the server resolves the price from the same table this
  /// was rendered from. A client-supplied amount is a client-chosen amount.
  final int priceKobo;

  final String label;

  const SessionExtensionOption({
    required this.minutes,
    required this.priceKobo,
    required this.label,
  });

  double get priceMajor => priceKobo / 100;

  factory SessionExtensionOption.fromJson(Map<String, dynamic> json) {
    return SessionExtensionOption(
      minutes: (json['minutes'] as num?)?.toInt() ?? 0,
      priceKobo: (json['price_kobo'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
    );
  }
}

/// How a countdown should read, and how loudly.
///
/// Separated from the widget so the thresholds are testable without building
/// one, and so the room and any future surface agree on when "about to end"
/// starts.
enum SessionClockUrgency {
  /// Plenty of time. The countdown is informational and easy to ignore.
  calm,

  /// Inside the first warning mark. Worth noticing.
  warning,

  /// Inside the last warning mark. The session is about to end.
  critical,
}

/// Classify [remaining] against [policy].
SessionClockUrgency urgencyFor(Duration? remaining, SessionClockPolicy policy) {
  if (remaining == null || !policy.enabled) return SessionClockUrgency.calm;
  final marks = policy.warnAtMinutes;
  if (marks.isEmpty) return SessionClockUrgency.calm;
  final mins = remaining.inSeconds / 60.0;
  // The SMALLEST mark is critical; anything inside the largest is a warning.
  if (mins <= marks.last) return SessionClockUrgency.critical;
  if (mins <= marks.first) return SessionClockUrgency.warning;
  return SessionClockUrgency.calm;
}

/// "1:04:30" / "4:30" / "0:45" — a countdown, not a duration label.
///
/// Seconds are shown under ten minutes and hidden above it: a host with an
/// hour left does not need the seconds ticking, and a host with ninety
/// seconds left needs nothing else.
String formatCountdown(Duration d) {
  if (d.isNegative) d = Duration.zero;
  final h = d.inHours;
  final m = d.inMinutes.remainder(60);
  final s = d.inSeconds.remainder(60);
  if (h > 0) {
    return '$h:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
  if (d.inMinutes >= 10) return '${d.inMinutes}m';
  return '$m:${s.toString().padLeft(2, '0')}';
}
