import 'dart:convert';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:intl/intl.dart';

class AutoSaveExportHelper {
  /// Export a list of autosave rules to CSV format and share
  static Future<void> exportToCSV(List<AutoSaveRuleEntity> rules) async {
    if (rules.isEmpty) {
      throw Exception('No rules to export');
    }

    // Define CSV headers
    final List<List<dynamic>> rows = [
      [
        'Rule Name',
        'Description',
        'Status',
        'Trigger Type',
        'Amount Type',
        'Amount Value',
        'Source Account',
        'Destination Account',
        'Total Saved',
        'Trigger Count',
        'Target Amount',
        'Minimum Balance',
        'Maximum Per Save',
        'Frequency',
        'Schedule Time',
        'Schedule Day',
        'Round Up To',
        'Created At',
        'Last Triggered',
      ],
    ];

    // Add each rule as a row
    for (final rule in rules) {
      rows.add([
        rule.name,
        rule.description,
        _getStatusText(rule.status),
        _getTriggerTypeText(rule.triggerType),
        rule.amountType == AmountType.fixed ? 'Fixed' : 'Percentage',
        rule.amountValue,
        rule.sourceAccountId,
        rule.destinationAccountId,
        rule.totalSaved,
        rule.triggerCount,
        rule.targetAmount ?? '',
        rule.minimumBalance ?? '',
        rule.maximumPerSave ?? '',
        rule.frequency != null ? _getFrequencyText(rule.frequency!) : '',
        rule.scheduleTime ?? '',
        rule.scheduleDay ?? '',
        rule.roundUpTo ?? '',
        DateFormat('yyyy-MM-dd HH:mm:ss').format(rule.createdAt),
        rule.lastTriggeredAt != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(rule.lastTriggeredAt!)
            : '',
      ]);
    }

    // Convert to CSV string
    final String csv = const ListToCsvConverter().convert(rows);

    // Generate filename with timestamp
    final String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final String filename = 'autosave_rules_$timestamp.csv';

    // Share the CSV file
    await SharePlus.instance.share(ShareParams(
      text: csv,
      subject: 'AutoSave Rules Export - $timestamp',
    ));
  }

  /// Export a single autosave rule to CSV format and share
  static Future<void> exportRuleToCsv(AutoSaveRuleEntity rule) async {
    return exportToCSV([rule]);
  }

  /// Export a list of autosave rules to JSON format and share
  static Future<void> exportToJSON(List<AutoSaveRuleEntity> rules) async {
    if (rules.isEmpty) {
      throw Exception('No rules to export');
    }

    // Create JSON structure
    final Map<String, dynamic> exportData = {
      'export_metadata': {
        'exported_at': DateTime.now().toIso8601String(),
        'total_rules': rules.length,
        'export_version': '1.0',
      },
      'rules': rules.map((rule) => _ruleToJson(rule)).toList(),
    };

    // Convert to formatted JSON string
    final String jsonString = const JsonEncoder.withIndent('  ').convert(exportData);

    // Generate filename with timestamp
    final String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final String filename = 'autosave_rules_$timestamp.json';

    // Share the JSON file
    await SharePlus.instance.share(ShareParams(
      text: jsonString,
      subject: 'AutoSave Rules Export - $timestamp',
    ));
  }

  /// Export a single autosave rule to JSON format and share
  static Future<void> exportRuleToJson(AutoSaveRuleEntity rule) async {
    return exportToJSON([rule]);
  }

  /// Export summary statistics to text format and share
  static Future<void> exportSummaryStats(List<AutoSaveRuleEntity> rules) async {
    if (rules.isEmpty) {
      throw Exception('No rules to export');
    }

    final totalSaved = rules.fold<double>(0, (sum, rule) => sum + rule.totalSaved);
    final activeCount = rules.where((r) => r.isActive).length;
    final pausedCount = rules.where((r) => r.isPaused).length;
    final completedCount = rules.where((r) => r.status == AutoSaveStatus.completed).length;
    final avgSaved = rules.isNotEmpty ? totalSaved / rules.length : 0;
    final bestPerformer = rules.isNotEmpty
        ? rules.reduce((a, b) => a.totalSaved > b.totalSaved ? a : b)
        : null;

    final summary = '''
AutoSave Rules Summary Report
Generated: ${DateFormat('MMMM dd, yyyy HH:mm').format(DateTime.now())}

═══════════════════════════════════════
OVERVIEW
═══════════════════════════════════════
Total Rules: ${rules.length}
Active Rules: $activeCount
Paused Rules: $pausedCount
Completed Rules: $completedCount

═══════════════════════════════════════
FINANCIAL SUMMARY
═══════════════════════════════════════
Total Saved: \$${totalSaved.toStringAsFixed(2)}
Average Per Rule: \$${avgSaved.toStringAsFixed(2)}
Best Performer: ${bestPerformer?.name ?? 'N/A'} (\$${bestPerformer?.totalSaved.toStringAsFixed(2) ?? '0.00'})

═══════════════════════════════════════
RULE BREAKDOWN
═══════════════════════════════════════
${rules.map((rule) => '''
Rule: ${rule.name}
  Status: ${_getStatusText(rule.status)}
  Trigger: ${_getTriggerTypeText(rule.triggerType)}
  Amount: ${rule.amountType == AmountType.fixed ? '\$' : ''}${rule.amountValue}${rule.amountType == AmountType.percentage ? '%' : ''}
  Total Saved: \$${rule.totalSaved.toStringAsFixed(2)}
  Times Triggered: ${rule.triggerCount}
''').join('\n')}
═══════════════════════════════════════
''';

    await SharePlus.instance.share(ShareParams(
      text: summary,
      subject: 'AutoSave Rules Summary Report',
    ));
  }

  // Helper method to convert a rule to JSON map
  static Map<String, dynamic> _ruleToJson(AutoSaveRuleEntity rule) {
    return {
      'id': rule.id,
      'name': rule.name,
      'description': rule.description,
      'status': _getStatusText(rule.status),
      'trigger_type': _getTriggerTypeText(rule.triggerType),
      'amount': {
        'type': rule.amountType == AmountType.fixed ? 'fixed' : 'percentage',
        'value': rule.amountValue,
      },
      'accounts': {
        'source': rule.sourceAccountId,
        'destination': rule.destinationAccountId,
      },
      'statistics': {
        'total_saved': rule.totalSaved,
        'trigger_count': rule.triggerCount,
      },
      'limits': {
        'target_amount': rule.targetAmount,
        'minimum_balance': rule.minimumBalance,
        'maximum_per_save': rule.maximumPerSave,
      },
      'schedule': rule.triggerType == TriggerType.scheduled
          ? {
              'frequency': rule.frequency != null ? _getFrequencyText(rule.frequency!) : null,
              'time': rule.scheduleTime,
              'day': rule.scheduleDay,
            }
          : null,
      'round_up': rule.triggerType == TriggerType.roundUp
          ? {
              'round_up_to': rule.roundUpTo,
            }
          : null,
      'timestamps': {
        'created_at': rule.createdAt.toIso8601String(),
        'last_triggered_at': rule.lastTriggeredAt?.toIso8601String(),
      },
    };
  }

  // Helper method to get status text
  static String _getStatusText(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return 'Active';
      case AutoSaveStatus.paused:
        return 'Paused';
      case AutoSaveStatus.completed:
        return 'Completed';
      case AutoSaveStatus.cancelled:
        return 'Cancelled';
      default:
        return 'Unknown';
    }
  }

  // Helper method to get trigger type text
  static String _getTriggerTypeText(TriggerType type) {
    switch (type) {
      case TriggerType.onDeposit:
        return 'On Deposit';
      case TriggerType.scheduled:
        return 'Scheduled';
      case TriggerType.roundUp:
        return 'Round Up';
      default:
        return 'Unknown';
    }
  }

  // Helper method to get frequency text
  static String _getFrequencyText(ScheduleFrequency frequency) {
    switch (frequency) {
      case ScheduleFrequency.daily:
        return 'Daily';
      case ScheduleFrequency.weekly:
        return 'Weekly';
      case ScheduleFrequency.biweekly:
        return 'Bi-Weekly';
      case ScheduleFrequency.monthly:
        return 'Monthly';
      default:
        return 'Unknown';
    }
  }
}
