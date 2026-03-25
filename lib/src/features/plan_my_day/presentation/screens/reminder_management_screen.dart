import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/reminder.dart';

class ReminderManagementScreen extends StatefulWidget {
  const ReminderManagementScreen({super.key});

  @override
  State<ReminderManagementScreen> createState() => _ReminderManagementScreenState();
}

class _ReminderManagementScreenState extends State<ReminderManagementScreen> {
  // Simulated data - in production, fetch from cubit
  List<Reminder> _reminders = [
    Reminder(
      id: '1',
      userId: 'user1',
      title: 'Morning standup',
      description: 'Daily team standup meeting',
      remindAt: DateTime.now().add(const Duration(hours: 2)),
      reminderType: 'recurring',
      repeatPattern: 'daily',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    Reminder(
      id: '2',
      userId: 'user1',
      title: 'Pay electricity bill',
      description: 'Due date reminder',
      remindAt: DateTime.now().add(const Duration(days: 3)),
      reminderType: 'absolute',
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Reminder(
      id: '3',
      userId: 'user1',
      title: 'Meeting prep',
      relatedEventId: 'evt123',
      minutesBefore: 15,
      reminderType: 'relative',
      isActive: false,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastTriggeredAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Reminders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () => _showFilterDialog(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateReminderDialog(),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            )
          : _reminders.isEmpty
              ? _buildEmptyState()
              : _buildReminderList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            color: Colors.grey[600],
            size: 64,
          ),
          SizedBox(height: 16.h),
          Text(
            'No reminders yet',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap the + button to create your first reminder',
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReminderList() {
    // Sort by remindAt
    final sortedReminders = List<Reminder>.from(_reminders)
      ..sort((a, b) => a.remindAt.compareTo(b.remindAt));

    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80.h),
      itemCount: sortedReminders.length,
      itemBuilder: (context, index) {
        return _buildReminderCard(sortedReminders[index]);
      },
    );
  }

  Widget _buildReminderCard(Reminder reminder) {
    final isOverdue = reminder.remindAt.isBefore(DateTime.now()) && reminder.isActive;
    final isToday = _isSameDay(reminder.remindAt, DateTime.now());

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isOverdue
              ? const Color(0xFFEF4444).withOpacity(0.3)
              : reminder.isActive
                  ? reminder.getColor().withOpacity(0.3)
                  : Colors.grey[800]!,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: isOverdue
                ? const Color(0xFFEF4444).withOpacity(0.1)
                : reminder.isActive
                    ? reminder.getColor().withOpacity(0.1)
                    : Colors.grey[800],
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(
            reminder.getIcon(),
            color: isOverdue
                ? const Color(0xFFEF4444)
                : reminder.isActive
                    ? reminder.getColor()
                    : Colors.grey,
          ),
        ),
        title: Text(
          reminder.title,
          style: TextStyle(
            color: reminder.isActive ? Colors.white : Colors.grey[500],
            fontSize: 16.sp,
            fontWeight: reminder.isActive ? FontWeight.w500 : FontWeight.normal,
            decoration: !reminder.isActive ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 14,
                  color: isOverdue
                      ? const Color(0xFFEF4444)
                      : reminder.isActive
                          ? reminder.getColor()
                          : Colors.grey,
                ),
                SizedBox(width: 4.w),
                Text(
                  _formatReminderTime(reminder.remindAt),
                  style: TextStyle(
                    color: isOverdue
                        ? const Color(0xFFEF4444)
                        : reminder.isActive
                            ? reminder.getColor()
                            : Colors.grey,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: (isOverdue
                            ? const Color(0xFFEF4444)
                            : reminder.getColor())
                        .withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    reminder.getReminderTypeLabel(),
                    style: TextStyle(
                      color: isOverdue
                          ? const Color(0xFFEF4444)
                          : reminder.getColor(),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (reminder.description != null) ...[
              SizedBox(height: 4.h),
              Text(
                reminder.description!,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 13.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: reminder.isActive,
              onChanged: (value) => _toggleReminder(reminder, value),
              activeColor: reminder.getColor(),
            ),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              color: const Color(0xFF2D2D2D),
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _showEditReminderDialog(reminder);
                    break;
                  case 'delete':
                    _confirmDeleteReminder(reminder);
                    break;
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit, color: Color(0xFF3B82F6), size: 18),
                      SizedBox(width: 12.w),
                      const Text(
                        'Edit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Color(0xFFEF4444), size: 18),
                      SizedBox(width: 12.w),
                      const Text(
                        'Delete',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Filter Reminders',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Filter logic would go here
              },
            ),
            ListTile(
              title: const Text('Active only', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Filter logic would go here
              },
            ),
            ListTile(
              title: const Text('Overdue', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Filter logic would go here
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showCreateReminderDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    TimeOfDay selectedTime = TimeOfDay.now();
    String selectedType = 'absolute';
    int? minutesBefore;
    String? repeatPattern;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'New Reminder',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      hintText: 'e.g., Meeting reminder',
                      hintStyle: TextStyle(color: Colors.grey[600]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: descriptionController,
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Description (optional)',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Reminder Type Selector
                  Text(
                    'Reminder Type',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildTypeChip('One-time', 'absolute', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                          repeatPattern = null;
                        });
                      }),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Relative', 'relative', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                        });
                      }),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Recurring', 'recurring', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // Date/Time Picker for absolute reminders
                  if (selectedType == 'absolute') ...[
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Color(0xFF3B82F6), size: 18),
                            SizedBox(width: 8.w),
                            Text(
                              DateFormat('MMM d, yyyy').format(selectedDate),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: Color(0xFF3B82F6), size: 18),
                            SizedBox(width: 8.w),
                            Text(
                              selectedTime.format(context),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  // Minutes before for relative reminders
                  if (selectedType == 'relative') ...[
                    DropdownButtonFormField<int>(
                      value: minutesBefore,
                      dropdownColor: const Color(0xFF2D2D2D),
                      decoration: InputDecoration(
                        labelText: 'Minutes before',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[800]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 15, child: Text('15 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 30, child: Text('30 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 60, child: Text('1 hour before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 120, child: Text('2 hours before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 1440, child: Text('1 day before', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          minutesBefore = value;
                        });
                      },
                    ),
                  ],

                  // Repeat pattern for recurring reminders
                  if (selectedType == 'recurring') ...[
                    DropdownButtonFormField<String>(
                      value: repeatPattern,
                      dropdownColor: const Color(0xFF2D2D2D),
                      decoration: InputDecoration(
                        labelText: 'Repeat',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[800]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'daily', child: Text('Daily', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'weekly', child: Text('Weekly', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'monthly', child: Text('Monthly', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'weekdays', child: Text('Weekdays', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          repeatPattern = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3B82F6)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a title')),
                    );
                    return;
                  }

                  final newReminder = Reminder(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    userId: 'user1', // Would come from auth context
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim().isEmpty
                        ? null
                        : descriptionController.text.trim(),
                    remindAt: DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    ),
                    minutesBefore: minutesBefore,
                    reminderType: selectedType,
                    repeatPattern: repeatPattern,
                    isActive: true,
                    createdAt: DateTime.now(),
                  );

                  setState(() {
                    _reminders.add(newReminder);
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reminder created')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Create', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showEditReminderDialog(Reminder reminder) {
    final titleController = TextEditingController(text: reminder.title);
    final descriptionController = TextEditingController(text: reminder.description ?? '');
    DateTime selectedDate = reminder.remindAt;
    TimeOfDay selectedTime = TimeOfDay.fromDateTime(reminder.remindAt);
    String selectedType = reminder.reminderType;
    int? minutesBefore = reminder.minutesBefore;
    String? repeatPattern = reminder.repeatPattern;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'Edit Reminder',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: const Color(0xFF2D2D2D),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(color: Colors.grey[800]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Type selector
                  Text(
                    'Reminder Type',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      _buildTypeChip('One-time', 'absolute', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                          repeatPattern = null;
                        });
                      }),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Relative', 'relative', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                        });
                      }),
                      SizedBox(width: 8.w),
                      _buildTypeChip('Recurring', 'recurring', selectedType, (value) {
                        setDialogState(() {
                          selectedType = value;
                        });
                      }),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  if (selectedType == 'absolute') ...[
                    InkWell(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today, color: Color(0xFF3B82F6), size: 18),
                            SizedBox(width: 8.w),
                            Text(
                              DateFormat('MMM d, yyyy').format(selectedDate),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    InkWell(
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (picked != null) {
                          setDialogState(() {
                            selectedTime = picked;
                          });
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.grey[800]!),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.access_time, color: Color(0xFF3B82F6), size: 18),
                            SizedBox(width: 8.w),
                            Text(
                              selectedTime.format(context),
                              style: const TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],

                  if (selectedType == 'relative') ...[
                    DropdownButtonFormField<int>(
                      value: minutesBefore,
                      dropdownColor: const Color(0xFF2D2D2D),
                      decoration: InputDecoration(
                        labelText: 'Minutes before',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[800]!),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 15, child: Text('15 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 30, child: Text('30 minutes before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 60, child: Text('1 hour before', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 120, child: Text('2 hours before', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          minutesBefore = value;
                        });
                      },
                    ),
                  ],

                  if (selectedType == 'recurring') ...[
                    DropdownButtonFormField<String>(
                      value: repeatPattern,
                      dropdownColor: const Color(0xFF2D2D2D),
                      decoration: InputDecoration(
                        labelText: 'Repeat',
                        labelStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: const Color(0xFF2D2D2D),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Colors.grey[800]!),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'daily', child: Text('Daily', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'weekly', child: Text('Weekly', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'monthly', child: Text('Monthly', style: TextStyle(color: Colors.white))),
                        DropdownMenuItem(value: 'weekdays', child: Text('Weekdays', style: TextStyle(color: Colors.white))),
                      ],
                      onChanged: (value) {
                        setDialogState(() {
                          repeatPattern = value;
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF3B82F6)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter a title')),
                    );
                    return;
                  }

                  setState(() {
                    final index = _reminders.indexWhere((r) => r.id == reminder.id);
                    if (index != -1) {
                      _reminders[index] = reminder.copyWith(
                        title: titleController.text.trim(),
                        description: descriptionController.text.trim().isEmpty
                            ? null
                            : descriptionController.text.trim(),
                        remindAt: DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        ),
                        minutesBefore: minutesBefore,
                        reminderType: selectedType,
                        repeatPattern: repeatPattern,
                      );
                    }
                  });

                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Reminder updated')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Save', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDeleteReminder(Reminder reminder) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Delete Reminder',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${reminder.title}"?',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _reminders.removeWhere((r) => r.id == reminder.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Reminder deleted')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _toggleReminder(Reminder reminder, bool isActive) {
    setState(() {
      final index = _reminders.indexWhere((r) => r.id == reminder.id);
      if (index != -1) {
        _reminders[index] = reminder.copyWith(isActive: isActive);
      }
    });
  }

  Widget _buildTypeChip(
    String label,
    String value,
    String selectedValue,
    Function(String) onTap,
  ) {
    final isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  String _formatReminderTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final reminderDay = DateTime(dateTime.year, dateTime.month, dateTime.day);

    final difference = reminderDay.difference(today).inDays;

    if (difference == 0) {
      return 'Today, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (difference == 1) {
      return 'Tomorrow, ${DateFormat('h:mm a').format(dateTime)}';
    } else if (difference < 7) {
      return '${DateFormat('EEEE').format(dateTime)}, ${DateFormat('h:mm a').format(dateTime)}';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
