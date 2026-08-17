part of 'create_task_bottom_sheet.dart';

/// Task-creation input mode: a manual structured form, or a natural-language
/// "AI" mode that hands the text to the Plan My Day agent (same planning
/// source-context as the AI-plan modal) to create the task(s).
enum _TaskMode { manual, ai }
