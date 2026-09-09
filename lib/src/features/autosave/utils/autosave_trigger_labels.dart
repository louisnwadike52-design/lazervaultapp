import 'package:flutter/material.dart';

import '../domain/entities/autosave_rule_entity.dart';
import '../domain/repositories/i_autosave_repository.dart';

/// THE canonical source for how every AutoSave trigger is named, described
/// and coloured.
///
/// Before this, the same five triggers had EIGHT different vocabularies
/// scattered across the feature — the create cards said "Bank standing
/// order", the history chip said "STANDING ORDER", the receipt said
/// "{Freq} Standing Order ({bank})", the PDF said something else again.
/// Every surface now reads from here, so a rename happens once.
///
/// Names are deliberately explicit about WHERE the money comes from, because
/// that is the only thing a user actually needs to decide between them.
class AutoSaveTriggerLabels {
  const AutoSaveTriggerLabels._();

  /// Short name for chips, list rows, tables and PDFs.
  static String nameOf(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return 'On Wallet Deposit';
      case TriggerType.scheduled:
        return 'Scheduled from Wallet';
      case TriggerType.roundUp:
        return 'Round-Up';
      case TriggerType.externalInflow:
        return 'Bank Inflow';
      case TriggerType.scheduledExternal:
        return 'Recurring Bank Debit';
      case TriggerType.unknown:
        return 'AutoSave';
    }
  }

  /// One-line explanation shown under the name on the trigger picker and on
  /// the rule review screen. Says what fires it and where money moves.
  static String descriptionOf(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return 'Every time money lands in your LazerVault wallet, save a '
            'fixed amount or a percentage of that deposit.';
      case TriggerType.scheduled:
        return 'Move a fixed amount from your LazerVault wallet into savings '
            'on a schedule you choose — daily, weekly or monthly.';
      case TriggerType.roundUp:
        return 'Round each wallet spend up to the nearest amount you pick and '
            'save the difference. Passive, small, adds up.';
      case TriggerType.externalInflow:
        return 'Watches your linked bank and offers to save a cut whenever '
            'money lands there. You confirm each save — nothing is pulled '
            'automatically.';
      case TriggerType.scheduledExternal:
        return 'Pulls your set amount from your linked bank into LazerVault on '
            'your schedule, using Direct Debit. A bank-debit fee applies per '
            'pull.';
      case TriggerType.unknown:
        return '';
    }
  }

  /// Triggers a NEW rule may be created with, given what the server says is
  /// currently switched on.
  ///
  /// Bank Inflow is HIDDEN, not greyed, when it is off: an unavailable option
  /// a user cannot act on is noise, and the reason ("it costs us money to
  /// watch your bank") is not something to explain on a picker. It reappears
  /// whole the moment an admin switches it on.
  ///
  /// [caps] is null while capabilities are still loading — treat that as
  /// hidden so the card never flashes in and out.
  static bool isVisibleForCreate(TriggerType t, AutoSaveCapabilities? caps) {
    if (t == TriggerType.unknown) return false;
    if (t == TriggerType.externalInflow) {
      return caps?.bankInflowEnabled ?? false;
    }
    return true;
  }

  /// The ordered set of triggers to offer for a NEW rule.
  static List<TriggerType> selectableTriggers(AutoSaveCapabilities? caps) => [
        TriggerType.onDeposit,
        TriggerType.scheduled,
        TriggerType.roundUp,
        TriggerType.externalInflow,
        TriggerType.scheduledExternal,
      ].where((t) => isVisibleForCreate(t, caps)).toList();

  /// Why an EXISTING rule can't be resumed right now, or null if it can.
  /// Existing rules stay visible in the list whatever the switch says — a
  /// user must always be able to see and manage money they set up.
  static String? resumeBlockedReason(TriggerType t, AutoSaveCapabilities? caps) {
    if (t == TriggerType.externalInflow && !(caps?.bankInflowEnabled ?? false)) {
      final reason = caps?.bankInflowDisabledReason ?? '';
      return reason.isNotEmpty
          ? reason
          : 'Bank Inflow saving is switched off right now.';
    }
    return null;
  }

  /// True when the trigger pulls from a linked BANK (Direct Debit) rather
  /// than moving money inside LazerVault. Drives the mandate gate and the
  /// bank-debit fee disclosure.
  static bool usesLinkedBank(TriggerType t) =>
      t == TriggerType.externalInflow || t == TriggerType.scheduledExternal;

  /// Accent colour per trigger, shared by cards, chips and icons.
  static Color colorOf(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return const Color(0xFF3B82F6);
      case TriggerType.scheduled:
        return const Color(0xFF10B981);
      case TriggerType.roundUp:
        return const Color(0xFFF59E0B);
      case TriggerType.externalInflow:
        // Must stay in step with _inflowTint in create_autosave_rule_screen,
        // which tints the linked-bank picker on the next step — otherwise the
        // trigger card and the step it leads to are two different colours.
        return const Color(0xFFFB923C);
      case TriggerType.scheduledExternal:
        return const Color(0xFF14B8A6);
      case TriggerType.unknown:
        return const Color(0xFF9CA3AF);
    }
  }

  static IconData iconOf(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return Icons.account_balance_wallet_outlined;
      case TriggerType.scheduled:
        return Icons.schedule_outlined;
      case TriggerType.roundUp:
        return Icons.savings_outlined;
      case TriggerType.externalInflow:
        return Icons.trending_up_outlined;
      case TriggerType.scheduledExternal:
        return Icons.account_balance_outlined;
      case TriggerType.unknown:
        return Icons.auto_awesome_outlined;
    }
  }

  /// Uppercase variant for compact history chips.
  static String chipLabelOf(TriggerType t) => nameOf(t).toUpperCase();
}
