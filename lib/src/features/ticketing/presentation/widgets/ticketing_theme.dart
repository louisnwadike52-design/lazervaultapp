import 'package:flutter/material.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

/// Ticketing's palette — PayFlowTheme, plus the one colour ticketing owns.
///
/// PULLED FROM PayFlowTheme RATHER THAN INLINED. Its own header says new
/// pay-flow code should take its colours from there instead of writing hex
/// literals, and this feature arrived with thirteen of them. Two were simply
/// wrong against the rest of the product:
///
///   * the page background was 0xFF121212 where every other flow is
///     0xFF0A0A0A, so ticketing rendered visibly LIGHTER than the dashboard it
///     opens from;
///   * the filled CTA was 0xFF3B82F6, a BLUE, where the brand CTA is purple —
///     so the one button a buyer presses to spend money looked like it
///     belonged to a different app.
///
/// Both are the kind of thing that reads as "unfinished" long before anyone can
/// say why, and neither is visible in a per-file review of the screen that
/// contains it.
class TicketingTheme {
  TicketingTheme._();

  static const Color bg = PayFlowTheme.bg;
  static const Color card = PayFlowTheme.card;
  static const Color border = PayFlowTheme.border;
  static const Color textSecondary = PayFlowTheme.textSecondary;
  static const Color cta = PayFlowTheme.accentCta;
  static const Color success = PayFlowTheme.success;
  static const Color error = PayFlowTheme.error;
  static const Color warning = PayFlowTheme.warning;

  /// EVERYTHING AN APP BAR DRAWS ON THIS FEATURE'S DARK GROUND.
  ///
  /// THE BACK ARROW WAS INVISIBLE ON EVERY SCREEN HERE, and so were the titles
  /// and the action icons. Each AppBar set `backgroundColor` to the dark page
  /// colour and nothing else, so its foreground came from the ACTIVE APP
  /// THEME — and the light theme's appBarTheme sets no foregroundColor at all,
  /// leaving Material's default of `onSurface`: near-black, on a near-black
  /// bar.
  ///
  /// The titles compounded it. They are written as
  /// `GoogleFonts.inter(fontSize:…, fontWeight:…)` with NO colour, so they
  /// inherit the same dark default. The screens rendered correctly in dark
  /// mode and vanished in light mode, which is why it read as "most items are
  /// not visible" rather than as one missing property.
  ///
  /// Setting `foregroundColor` on the bar fixes all three at once — M3 derives
  /// the leading icon, the action icons and the title's default colour from
  /// it.
  static const Color onBar = Colors.white;

  /// Muted text — one step dimmer than [textSecondary], for counts and
  /// timestamps that must not compete with the figure beside them.
  static const Color textMuted = Color(0xFF6B7280);

  /// Body copy on a card. Brighter than [textSecondary] because a description
  /// is read rather than glanced at.
  static const Color textBody = Color(0xFFD1D5DB);

  /// Sheet drag handle.
  static const Color handle = Color(0xFF4A4A4A);

  /// THE TICKET ACCENT — the one colour this feature owns.
  ///
  /// Deliberately NOT the brand purple: it has to tell a ticket apart at a
  /// glance in a transaction list where the purple is already the generic
  /// money colour. The same value as TransactionServiceType.eventTicket and
  /// the notification colour for AppServiceName.ticketing, so a push, the
  /// receipt it opens, and the price on the card are one thing.
  static const Color ticket = Color(0xFFD946EF);

  /// Destructive outline — for "cancel the event", which refunds every buyer.
  static const Color destructiveBorder = Color(0xFF7F1D1D);
}
