import 'package:flutter/material.dart';

/// Canonical Plan My Day task statuses — the CRM/Kanban board columns.
///
/// `value` is the backend string (mirrors the planning-service `valid_status`
/// CHECK constraint: pending, in_progress, blocked, in_review, completed,
/// cancelled). `label` + `color` drive the board UI.
class PlanTaskStatus {
  final String value;
  final String label;
  final Color color;

  const PlanTaskStatus(this.value, this.label, this.color);

  static const todo = PlanTaskStatus('pending', 'To-do', Color(0xFF9CA3AF));
  static const inProgress =
      PlanTaskStatus('in_progress', 'In progress', Color(0xFF3B82F6));
  static const blocked = PlanTaskStatus('blocked', 'Blocked', Color(0xFFEF4444));
  static const inReview =
      PlanTaskStatus('in_review', 'In review', Color(0xFFFB923C));
  static const done = PlanTaskStatus('completed', 'Done', Color(0xFF10B981));
  static const cancelled =
      PlanTaskStatus('cancelled', 'Cancelled', Color(0xFF6B7280));

  /// Board columns, left → right. Cancelled is intentionally not a column
  /// (reachable via the card menu + status filter).
  static const List<PlanTaskStatus> boardColumns = [
    todo,
    inProgress,
    blocked,
    inReview,
    done,
  ];

  /// Every status, including cancelled — for menus and the detail selector.
  static const List<PlanTaskStatus> all = [
    todo,
    inProgress,
    blocked,
    inReview,
    done,
    cancelled,
  ];

  static PlanTaskStatus fromValue(String? value) {
    return all.firstWhere((s) => s.value == value, orElse: () => todo);
  }

  static String labelFor(String? value) => fromValue(value).label;
  static Color colorFor(String? value) => fromValue(value).color;
}
