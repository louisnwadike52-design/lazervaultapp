import 'package:flutter/material.dart';
import '../../data/currency_data.dart';
import '../theme/exchange_theme.dart';

/// Currency pair selector supporting both a tap swap button and a
/// drag-to-swap gesture. Patterned after the Beam (Move Money) wallet
/// transfer flow: each card is simultaneously a `Draggable` source AND a
/// `DragTarget`, carries a visible `Icons.drag_indicator` handle so the
/// affordance is discoverable, and scales up slightly when the opposite
/// card is hovering over it.
///
/// Differences from Beam:
///   * Cards are side-by-side (horizontal layout) instead of stacked, so
///     the Draggable is constrained to the horizontal axis.
///   * Central swap button carries the invoice-flow purple gradient to
///     match the rest of the exchange feature.
///
/// Mode-agnostic — used on the exchange landing page for both Convert
/// (same-user FX) and Send Abroad (international) flows.
class CurrencyPairSelector extends StatefulWidget {
  final String fromCurrency;
  final String toCurrency;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final VoidCallback onSwap;

  const CurrencyPairSelector({
    super.key,
    required this.fromCurrency,
    required this.toCurrency,
    required this.onFromTap,
    required this.onToTap,
    required this.onSwap,
  });

  @override
  State<CurrencyPairSelector> createState() => _CurrencyPairSelectorState();
}

class _CurrencyPairSelectorState extends State<CurrencyPairSelector>
    with SingleTickerProviderStateMixin {
  late final AnimationController _swapSpin;
  bool _fromHover = false;
  bool _toHover = false;

  @override
  void initState() {
    super.initState();
    _swapSpin = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );
  }

  @override
  void dispose() {
    _swapSpin.dispose();
    super.dispose();
  }

  void _triggerSwap() {
    _swapSpin.forward(from: 0);
    widget.onSwap();
  }

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight bounds the Row height to the tallest child BEFORE
    // the Row runs layout, so CrossAxisAlignment.stretch no longer asks
    // for h=Infinity when this widget sits inside a SingleChildScrollView
    // (which gives its child unbounded height). Without this wrapper the
    // whole scroll body rendered as 0px, leaving the exchange screen blank
    // below the app bar.
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildDraggableSlot(
              dragData: 'from',
              acceptData: 'to',
              isHovering: _fromHover,
              onHoverChanged: (h) => setState(() => _fromHover = h),
              child: _buildCurrencyCard(
                code: widget.fromCurrency,
                label: 'From',
                onTap: widget.onFromTap,
                highlight: _fromHover,
              ),
              feedbackChild: _buildCurrencyCard(
                code: widget.fromCurrency,
                label: 'From',
                onTap: null,
                highlight: true,
              ),
              ghostChild: _buildCurrencyCard(
                code: widget.fromCurrency,
                label: 'From',
                onTap: null,
                highlight: false,
              ),
            ),
          ),
          // Center vertically so the swap button stays at its natural size
          // instead of stretching to the full card height — only the From/To
          // cards should fill the row's intrinsic height.
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: _buildSwapButton(),
            ),
          ),
          Expanded(
            child: _buildDraggableSlot(
              dragData: 'to',
              acceptData: 'from',
              isHovering: _toHover,
              onHoverChanged: (h) => setState(() => _toHover = h),
              child: _buildCurrencyCard(
                code: widget.toCurrency,
                label: 'To',
                onTap: widget.onToTap,
                highlight: _toHover,
              ),
              feedbackChild: _buildCurrencyCard(
                code: widget.toCurrency,
                label: 'To',
                onTap: null,
                highlight: true,
              ),
              ghostChild: _buildCurrencyCard(
                code: widget.toCurrency,
                label: 'To',
                onTap: null,
                highlight: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a single draggable + drop-target slot for a currency card,
  /// mirroring `_buildDraggableSlot` on the Beam wallet transfer screen.
  Widget _buildDraggableSlot({
    required String dragData,
    required String acceptData,
    required bool isHovering,
    required ValueChanged<bool> onHoverChanged,
    required Widget child,
    required Widget feedbackChild,
    required Widget ghostChild,
  }) {
    return DragTarget<String>(
      onWillAcceptWithDetails: (details) {
        if (details.data == acceptData) {
          onHoverChanged(true);
          return true;
        }
        return false;
      },
      onLeave: (_) => onHoverChanged(false),
      onAcceptWithDetails: (_) {
        onHoverChanged(false);
        _triggerSwap();
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<String>(
          data: dragData,
          axis: Axis.horizontal,
          feedback: Material(
            color: Colors.transparent,
            child: SizedBox(
              // 50% of available width keeps the floating card feeling
              // like "half" of the row, matching the Beam pattern's
              // feel of the dragged card floating away from its slot.
              width: (MediaQuery.of(context).size.width - 80) / 2,
              child: Opacity(opacity: 0.9, child: feedbackChild),
            ),
          ),
          childWhenDragging: Opacity(opacity: 0.3, child: ghostChild),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform: isHovering
                ? Matrix4.diagonal3Values(1.03, 1.03, 1.0)
                : Matrix4.identity(),
            transformAlignment: Alignment.center,
            child: child,
          ),
        );
      },
    );
  }

  Widget _buildCurrencyCard({
    required String code,
    required String label,
    required VoidCallback? onTap,
    required bool highlight,
  }) {
    final currency = CurrencyData.getCurrencyByCode(code);
    final countryCode = currency?.countryCode.toLowerCase() ?? '';
    final flag = countryCode.isNotEmpty
        ? countryCode
            .toUpperCase()
            .codeUnits
            .map((c) => String.fromCharCode(c + 127397))
            .join()
        : '';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: ExchangeTheme.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: highlight
                ? ExchangeTheme.primary
                : ExchangeTheme.divider,
            width: highlight ? 1.5 : 1.0,
          ),
          boxShadow: highlight
              ? [
                  BoxShadow(
                    color: ExchangeTheme.primary.withValues(alpha: 0.35),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label row with a drag-indicator handle on the right edge.
            // Mirrors the Beam account card's leading drag_indicator —
            // here we put it trailing so it visually "points" toward
            // the sibling card across the swap button.
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: ExchangeTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ),
                Icon(
                  Icons.drag_indicator,
                  color: highlight
                      ? ExchangeTheme.primary
                      : const Color(0xFF4B5563),
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                if (flag.isNotEmpty) ...[
                  Text(flag, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    code,
                    style: const TextStyle(
                      color: ExchangeTheme.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: ExchangeTheme.textSecondary,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              currency?.name ?? code,
              style: const TextStyle(
                color: ExchangeTheme.textSecondary,
                fontSize: 11,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwapButton() {
    return Semantics(
      label: 'Swap from and to currencies',
      button: true,
      child: GestureDetector(
        onTap: _triggerSwap,
        child: AnimatedBuilder(
          animation: _swapSpin,
          builder: (ctx, child) {
            return Transform.rotate(
              angle: _swapSpin.value * 3.14159, // half rotation per tap
              child: child,
            );
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: ExchangeTheme.primaryGradient,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: ExchangeTheme.primary.withValues(alpha: 0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: const Icon(
              Icons.swap_horiz,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
