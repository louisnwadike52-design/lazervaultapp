part of 'create_split_bill_screen.dart';

/// Bridges the screen's private `_SplitMethod` to the testable copy module in
/// `../utils/split_method_copy.dart`, and draws the hint strip. The sentences
/// themselves live there, with their own tests; this file only maps and
/// renders.

SplitShareInput _shareInputFor(_SplitMethod method) => switch (method) {
      _SplitMethod.equal => SplitShareInput.none,
      _SplitMethod.custom => SplitShareInput.amount,
      _SplitMethod.percentage => SplitShareInput.percent,
    };

/// The hint strip under the method chips.
Widget _buildSplitMethodHintStrip(String text) {
  return Container(
    margin: const EdgeInsets.only(top: 10),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFF4834D4).withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(10),
      border:
          Border.all(color: const Color(0xFF4834D4).withValues(alpha: 0.30)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.info_outline, size: 16, color: Color(0xFF9CA3AF)),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
          ),
        ),
      ],
    ),
  );
}
