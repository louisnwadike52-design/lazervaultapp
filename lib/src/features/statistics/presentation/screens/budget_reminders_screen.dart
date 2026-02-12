import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Budget Reminders Screen
/// Allows users to set up push, email, and SMS notifications for budget alerts
class BudgetRemindersScreen extends StatefulWidget {
  const BudgetRemindersScreen({super.key});

  @override
  State<BudgetRemindersScreen> createState() => _BudgetRemindersScreenState();
}

class _BudgetRemindersScreenState extends State<BudgetRemindersScreen> {
  final List<BudgetReminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    // TODO: Load from backend
    setState(() {
      _reminders.addAll([
        BudgetReminder(
          id: '1',
          budgetName: 'Food & Dining',
          reminderType: 'Threshold Reached',
          threshold: 80,
          channels: ['push', 'email'],
          isActive: true,
        ),
        BudgetReminder(
          id: '2',
          budgetName: 'Transportation',
          reminderType: 'Weekly Summary',
          threshold: null,
          channels: ['push'],
          isActive: true,
        ),
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Budget Reminders',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/statistics/budgets/reminders/create'),
            icon: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: _reminders.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                return _ReminderCard(
                  reminder: _reminders[index],
                  onToggle: () => _toggleReminder(_reminders[index].id),
                  onEdit: () => _editReminder(_reminders[index].id),
                  onDelete: () => _deleteReminder(_reminders[index].id),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none, color: Colors.grey[600], size: 64.r),
          SizedBox(height: 16.h),
          Text(
            'No reminders set',
            style: TextStyle(color: Colors.grey[400], fontSize: 16.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            'Get notified when you approach your budget limits',
            style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: () => Get.toNamed('/statistics/budgets/reminders/create'),
            icon: const Icon(Icons.add),
            label: const Text('Create Reminder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleReminder(String id) {
    setState(() {
      final index = _reminders.indexWhere((r) => r.id == id);
      if (index != -1) {
        _reminders[index] = _reminders[index].copyWith(isActive: !_reminders[index].isActive);
      }
    });
    // TODO: Update backend
  }

  void _editReminder(String id) {
    Get.toNamed('/statistics/budgets/reminders/create', arguments: {'reminderId': id});
  }

  void _deleteReminder(String id) {
    Get.defaultDialog(
      title: 'Delete Reminder',
      middleText: 'Are you sure you want to delete this reminder?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      cancelTextColor: const Color(0xFF9CA3AF),
      buttonColor: const Color(0xFFEF4444),
      onConfirm: () {
        setState(() {
          _reminders.removeWhere((r) => r.id == id);
        });
        Get.back();
        // TODO: Delete from backend
        Get.snackbar('Deleted', 'Reminder deleted successfully', backgroundColor: const Color(0xFF10B981));
      },
    );
  }
}

class _ReminderCard extends StatelessWidget {
  final BudgetReminder reminder;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _ReminderCard({
    required this.reminder,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reminder.budgetName,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      reminder.reminderType,
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                    if (reminder.threshold != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'At ${reminder.threshold}% of budget',
                        style: TextStyle(color: const Color(0xFF3B82F6), fontSize: 12),
                      ),
                    ],
                  ],
                ),
              ),
              Switch(
                value: reminder.isActive,
                onChanged: (_) => onToggle(),
                activeColor: const Color(0xFF3B82F6),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Wrap(
            spacing: 8.w,
            children: reminder.channels.map((channel) {
              return _buildChannelChip(channel);
            }).toList(),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              TextButton.icon(
                onPressed: onEdit,
                icon: const Icon(Icons.edit, size: 16),
                label: const Text('Edit'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF3B82F6),
                ),
              ),
              SizedBox(width: 8.w),
              TextButton.icon(
                onPressed: onDelete,
                icon: const Icon(Icons.delete, size: 16),
                label: const Text('Delete'),
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChannelChip(String channel) {
    IconData icon;
    String label;

    switch (channel.toLowerCase()) {
      case 'push':
        icon = Icons.notifications;
        label = 'Push';
        break;
      case 'email':
        icon = Icons.email;
        label = 'Email';
        break;
      case 'sms':
        icon = Icons.sms;
        label = 'SMS';
        break;
      default:
        icon = Icons.notifications;
        label = channel;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: Colors.grey[400]),
          SizedBox(width: 4.w),
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
        ],
      ),
    );
  }
}

/// Create/Edit Budget Reminder Screen
class CreateBudgetReminderScreen extends StatefulWidget {
  const CreateBudgetReminderScreen({super.key});

  @override
  State<CreateBudgetReminderScreen> createState() => _CreateBudgetReminderScreenState();
}

class _CreateBudgetReminderScreenState extends State<CreateBudgetReminderScreen> {
  String? _selectedBudget;
  String _selectedType = 'threshold';
  int _thresholdValue = 80;
  bool _isRecurring = false;
  String _recurrencePattern = 'weekly';
  final List<String> _selectedChannels = ['push'];

  final List<Map<String, dynamic>> _budgets = [
    {'id': '1', 'name': 'Food & Dining', 'amount': 50000},
    {'id': '2', 'name': 'Transportation', 'amount': 30000},
    {'id': '3', 'name': 'Shopping', 'amount': 40000},
    {'id': '4', 'name': 'Bills & Utilities', 'amount': 60000},
  ];

  final List<String> _reminderTypes = [
    'threshold',
    'exceeded',
    'weekly_summary',
    'monthly_summary',
  ];

  final List<Map<String, dynamic>> _channels = [
    {'value': 'push', 'label': 'Push Notification', 'icon': Icons.notifications},
    {'value': 'email', 'label': 'Email', 'icon': Icons.email},
    {'value': 'sms', 'label': 'SMS', 'icon': Icons.sms},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          'Create Reminder',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _saveReminder,
            child: const Text(
              'Save',
              style: TextStyle(color: Color(0xFF3B82F6), fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildSectionTitle('Select Budget'),
          SizedBox(height: 8.h),
          _buildBudgetDropdown(),
          SizedBox(height: 24.h),

          _buildSectionTitle('Reminder Type'),
          SizedBox(height: 8.h),
          _buildReminderTypeChips(),
          SizedBox(height: 24.h),

          if (_selectedType == 'threshold') ...[
            _buildSectionTitle('Alert Threshold'),
            SizedBox(height: 8.h),
            _buildThresholdSlider(),
            SizedBox(height: 24.h),
          ],

          _buildSectionTitle('Notification Channels'),
          SizedBox(height: 8.h),
          ..._channels.map((channel) => _buildChannelCheckbox(channel)),
          SizedBox(height: 24.h),

          _buildRecurringSection(),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildBudgetDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedBudget,
          dropdownColor: const Color(0xFF1F1F1F),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          isExpanded: true,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          hint: Text('Select a budget', style: TextStyle(color: Colors.grey[400], fontSize: 14.sp)),
          items: _budgets.map((budget) {
            return DropdownMenuItem<String>(
              value: budget['id'] as String,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(budget['name'] as String, style: const TextStyle(color: Colors.white)),
                  Text(
                    CurrencySymbols.formatAmount((budget['amount'] as num).toDouble()),
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedBudget = value);
          },
        ),
      ),
    );
  }

  Widget _buildReminderTypeChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _reminderTypes.map((type) {
        final isSelected = _selectedType == type;
        final label = type.replaceAll('_', ' ').split(' ').map((word) =>
          word.isEmpty ? '' : '${word[0].toUpperCase()}${word.substring(1)}'
        ).join(' ');

        return GestureDetector(
          onTap: () => setState(() => _selectedType = type),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
              ),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[400],
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildThresholdSlider() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Alert me at', style: TextStyle(color: Colors.grey[400], fontSize: 14.sp)),
                  Text(
                    '$_thresholdValue%',
                    style: const TextStyle(color: Color(0xFF3B82F6), fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: const Color(0xFF3B82F6),
                  inactiveTrackColor: const Color(0xFF2D2D2D),
                  thumbColor: const Color(0xFF3B82F6),
                  overlayColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  trackHeight: 4,
                ),
                child: Slider(
                  value: _thresholdValue.toDouble(),
                  min: 50,
                  max: 100,
                  divisions: 10,
                  onChanged: (value) {
                    setState(() => _thresholdValue = value.toInt());
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('50%', style: TextStyle(color: Colors.grey[500], fontSize: 12.sp)),
                  Text('100%', style: TextStyle(color: Colors.grey[500], fontSize: 12.sp)),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'You\'ll receive a notification when you reach $_thresholdValue% of this budget.',
          style: TextStyle(color: Colors.grey[500], fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildChannelCheckbox(Map<String, dynamic> channel) {
    final value = channel['value'] as String;
    final isSelected = _selectedChannels.contains(value);

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedChannels.remove(value);
          } else {
            _selectedChannels.add(value);
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            Icon(
              channel['icon'] as IconData,
              color: isSelected ? const Color(0xFF3B82F6) : Colors.grey[400],
              size: 20.r,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                channel['label'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ),
            Container(
              width: 20.r,
              height: 20.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFF3B82F6) : Colors.grey.shade600,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Icon(Icons.check, color: const Color(0xFF3B82F6), size: 14.r),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecurringSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Recurring Reminder'),
            Switch(
              value: _isRecurring,
              onChanged: (value) => setState(() => _isRecurring = value),
              activeColor: const Color(0xFF3B82F6),
            ),
          ],
        ),
        if (_isRecurring) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _recurrencePattern,
                dropdownColor: const Color(0xFF1F1F1F),
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
                isExpanded: true,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                items: const [
                  DropdownMenuItem(value: 'daily', child: Text('Daily')),
                  DropdownMenuItem(value: 'weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'monthly', child: Text('Monthly')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _recurrencePattern = value);
                  }
                },
              ),
            ),
          ),
        ],
      ],
    );
  }

  void _saveReminder() {
    if (_selectedBudget == null) {
      Get.snackbar('Error', 'Please select a budget', backgroundColor: const Color(0xFFEF4444));
      return;
    }

    if (_selectedChannels.isEmpty) {
      Get.snackbar('Error', 'Please select at least one notification channel', backgroundColor: const Color(0xFFEF4444));
      return;
    }

    // TODO: Save to backend
    Get.back();
    Get.snackbar(
      'Success',
      'Reminder created successfully',
      backgroundColor: const Color(0xFF10B981),
    );
  }
}

/// Budget Reminder Model
class BudgetReminder {
  final String id;
  final String budgetName;
  final String reminderType;
  final int? threshold;
  final List<String> channels;
  final bool isActive;

  BudgetReminder({
    required this.id,
    required this.budgetName,
    required this.reminderType,
    this.threshold,
    required this.channels,
    required this.isActive,
  });

  BudgetReminder copyWith({
    String? id,
    String? budgetName,
    String? reminderType,
    int? threshold,
    List<String>? channels,
    bool? isActive,
  }) {
    return BudgetReminder(
      id: id ?? this.id,
      budgetName: budgetName ?? this.budgetName,
      reminderType: reminderType ?? this.reminderType,
      threshold: threshold ?? this.threshold,
      channels: channels ?? this.channels,
      isActive: isActive ?? this.isActive,
    );
  }
}
