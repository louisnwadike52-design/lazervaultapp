import 'package:flutter/material.dart';

/// Top colour of the gift-card page background. Set a Scaffold's
/// `backgroundColor` to this so the status-bar area matches the body.
/// Flat near-black per the the platform conventions dark-theme palette so the page reads
/// as one surface (the receipt screen previously layered a #1F1F1F card
/// over a purple gradient, producing a multi-coloured look the user flagged).
const Color kGiftCardBgTop = Color(0xFF0A0A0A);

/// The Gift-Card pages background. Flat #0A0A0A — matches every other
/// dark-theme surface in the app, so the Transaction Details card (#1F1F1F)
/// reads as one tonal step above the page instead of clashing with a gradient.
const BoxDecoration kGiftCardBackgroundDecoration = BoxDecoration(
  color: Color(0xFF0A0A0A),
);

/// Wraps a Scaffold body in the shared gift-card gradient background. Pair it
/// with `backgroundColor: kGiftCardBgTop` on the Scaffold.
class GiftCardBackground extends StatelessWidget {
  const GiftCardBackground({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kGiftCardBackgroundDecoration,
      child: child,
    );
  }
}
