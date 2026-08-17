part of 'vtuafrica_transfer_screen.dart';

/// Per-network airtime-transfer USSD guide. `direct` is the one-shot
/// dialer string with placeholders ({N}=recipient, {A}=amount, {P}=PIN).
/// `menu` is the operator's interactive menu shortcode.
class _UssdGuide {
  final String label;
  final String direct;
  final String menu;
  final bool requiresPin;
  final String notes;

  const _UssdGuide({
    required this.label,
    required this.direct,
    required this.menu,
    required this.requiresPin,
    required this.notes,
  });
}
