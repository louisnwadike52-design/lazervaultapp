/// When a spending budget is what stopped a payment.
///
/// WHY THIS IS ITS OWN CLASSIFIER
/// ------------------------------
/// A budget refusal is the one kind of "no" the user can lift themselves, in
/// about ten seconds, without leaving the app — and they can only do that if
/// they are told WHICH budget and HOW to raise it. Delivered as a generic red
/// error it reads like a payment failure, so the natural next move is to
/// retry, which fails identically. Every flow that moves money needs the same
/// answer, so the recognition and the way out live in one place rather than
/// being re-written per screen.
///
/// WHAT IT CURRENTLY MATCHES
/// -------------------------
/// Measured 2026-10-01: NO payment flow enforces a budget today. Every budget
/// in production is `flexible` (warn, never block), statistics-service's
/// `strict` mode exists in the model and its validator but is exposed by no
/// RPC and called by no payment path, so a budget cannot currently refuse
/// anything. This recognises the refusal the SERVER would send — the reason
/// strings the statistics-service validator already produces — so the moment
/// strict enforcement is wired to a flow, every flow surfaces it correctly
/// instead of one of them learning to and the rest showing a red box.
///
/// It is deliberately narrow. A false positive sends someone to the budget
/// screen to fix a problem that is not a budget, which is worse than a
/// generic error.
library;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';

/// The reason codes statistics-service emits for a budget block.
const _budgetReasonCodes = <String>{
  'budget_exceeded',
  'budget_exceeded_strict',
};

/// Phrases a budget refusal reaches the app with, lower-cased.
///
/// Both the code and the sentence are matched: a gRPC status carries the
/// message, while a JSON error body may carry only the reason field.
const _budgetPhrases = <String>[
  'budget_exceeded',
  'budget exceeded',
  'exceeds your budget',
  'over your budget',
  'budget limit reached',
];

/// Whether [error] is a budget refusal rather than any other kind of failure.
bool isBudgetRefusal(Object? error) {
  if (error == null) return false;
  final text = error.toString().toLowerCase();
  if (text.isEmpty) return false;
  for (final code in _budgetReasonCodes) {
    if (text.contains(code)) return true;
  }
  for (final phrase in _budgetPhrases) {
    if (text.contains(phrase)) return true;
  }
  return false;
}

/// The budget category named in [error], when the server named one.
///
/// Returned so the sheet can say "your Transfers budget" rather than "a
/// budget" — the user may have several, and which one is the whole question.
String? budgetCategoryFrom(Object? error) {
  final text = error?.toString() ?? '';
  final at = text.toLowerCase().indexOf(' budget');
  if (at <= 0) return null;

  // Walk BACKWARDS over at most three words, keeping only Capitalised ones.
  //
  // Capitalisation is the signal, and it is a reliable one: the server names
  // categories in title case ("Transfers budget", "Currency Exchange
  // budget"), while the filler around them is lower case ("past the budget",
  // "your budget"). A greedy pattern instead matched everything up to the
  // word — "You are past the budget" yielded the category "You are past the",
  // which the sheet would have rendered as "your You are past the budget".
  final before = text.substring(0, at).trimRight().split(RegExp(r'\s+'));
  final taken = <String>[];
  for (var i = before.length - 1; i >= 0 && taken.length < 3; i--) {
    final w = before[i].replaceAll(RegExp(r'[^A-Za-z&]'), '');
    if (w.isEmpty) break;
    // "&" joins a two-part category ("Family & Friends"); it is kept but is
    // not itself evidence of one.
    if (w == '&') {
      if (taken.isEmpty) break;
      taken.insert(0, w);
      continue;
    }
    final first = w[0];
    if (first != first.toUpperCase() || first == first.toLowerCase()) break;
    taken.insert(0, w);
  }
  if (taken.isEmpty || taken.last == '&') return null;

  const stop = {'the', 'a', 'an', 'this', 'that', 'your', 'my', 'you'};
  if (stop.contains(taken.last.toLowerCase())) return null;
  return taken.join(' ');
}

/// Shows the budget refusal with a way out, and returns true when it handled
/// [error]. Returns false when this was not a budget refusal, so the caller
/// can fall through to its own error handling unchanged:
///
/// ```dart
/// if (!await showBudgetRefusalIfAny(context, error)) {
///   // existing handling
/// }
/// ```
Future<bool> showBudgetRefusalIfAny(
  BuildContext context,
  Object? error, {
  String? action,
}) async {
  if (!isBudgetRefusal(error)) return false;

  final category = budgetCategoryFrom(error);
  final what = action == null ? 'This payment' : 'This $action';
  final whichBudget =
      category == null ? 'a spending budget' : 'your $category budget';

  final tapped = await showServerRefusal(
    context,
    title: 'Budget reached',
    // The server's own numbers are the useful part, so its sentence is kept
    // and only framed — see showServerRefusal's note on not replacing it.
    message: '$what would take you past $whichBudget.\n\n'
        '${error.toString().replaceAll('Exception:', '').trim()}',
    actionLabel: 'Adjust budget',
    hint: 'Budgets live in AI analytics. Raising one takes effect immediately.',
    dismissLabel: 'Not now',
  );

  if (tapped) openBudgetSettings();
  return true;
}

/// Opens the budgets surface — AI analytics, the second bottom-nav item.
///
/// Routed by INDEX through the dashboard rather than pushed as a standalone
/// screen, so the user lands on the real tab with its nav intact and can get
/// back the normal way. Index 1 is AI analytics in kDashboardTabs; the
/// dashboard route accepts `initialTab`.
void openBudgetSettings() {
  Get.toNamed(AppRoutes.dashboard, arguments: {'initialTab': 1});
}
