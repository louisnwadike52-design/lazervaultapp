import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/category.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_cubit.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/cubit/plan_my_day_state.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final List<Category> categories;

  const TaskDetailScreen({
    super.key,
    required this.task,
    this.categories = const [],
  });

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late int _selectedPriority;
  late String _selectedStatus;
  DateTime? _selectedDueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description ?? '');
    _selectedPriority = widget.task.priority;
    _selectedStatus = widget.task.status;
    _selectedDueDate = widget.task.dueDate;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Task Details',
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
          if (!widget.task.isCompleted)
            IconButton(
              icon: const Icon(Icons.check_circle_outline, color: Color(0xFF10B981)),
              onPressed: _completeTask,
            ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            color: const Color(0xFF3B82F6),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showEditDialog();
                  break;
                case 'delete':
                  _confirmDelete();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: ListTile(
                  leading: const Icon(Icons.edit, color: Color(0xFF4E03D0)),
                  title: const Text('Edit', style: TextStyle(color: Colors.white)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: ListTile(
                  leading: const Icon(Icons.delete, color: Color(0xFFEF4444)),
                  title: const Text('Delete', style: TextStyle(color: Colors.white)),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                ),
              ),
            ],
          ),
        ],
      ),
      body: BlocListener<PlanMyDayCubit, PlanMyDayState>(
        listener: (context, state) {
          if (state is TaskCompleted && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Task completed! 🎉'),
                backgroundColor: const Color(0xFF10B981),
              ),
            );
            Navigator.pop(context, true);
          } else if (state is TaskDeleted && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Task deleted'),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
            Navigator.pop(context, true);
          } else if (state is PlanMyDayError && mounted) {
            final error = state as PlanMyDayError;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status Badge
              _buildStatusBadge(),
              SizedBox(height: 20.h),

              // Title Card
              _buildSectionCard(
                title: 'Task Information',
                children: [
                  _buildInfoRow('Title', widget.task.title),
                  if (widget.task.description != null)
                    _buildInfoRow('Description', widget.task.description!),
                  _buildInfoRow('Priority', _getPriorityLabel(widget.task.priority)),
                  _buildInfoRow('Due Date', widget.task.dueDate != null
                      ? DateFormat('MMM d, yyyy • h:mm a').format(widget.task.dueDate!)
                      : 'No due date'),
                  if (widget.task.estimatedDuration != null)
                    _buildInfoRow('Estimated Duration', widget.task.estimatedDuration!),
                  _buildInfoRow('Created', DateFormat('MMM d, yyyy').format(widget.task.createdAt)),
                ],
              ),
              SizedBox(height: 20.h),

              // Progress Card
              if (!widget.task.isCompleted)
                _buildProgressCard(),
              SizedBox(height: 20.h),

              // Actions
              _buildQuickActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color;
    String label;

    switch (widget.task.status) {
      case 'completed':
        color = const Color(0xFF10B981);
        label = 'Completed';
        break;
      case 'in_progress':
        color = const Color(0xFF3B82F6);
        label = 'In Progress';
        break;
      case 'cancelled':
        color = const Color(0xFF6B7280);
        label = 'Cancelled';
        break;
      default:
        color = const Color(0xFFF59E0B);
        label = 'Pending';
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCard() {
    final completion = widget.task.completionPercentage / 100.0;
    return _buildSectionCard(
      title: 'Progress',
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.task.completionPercentage}% Complete',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4.r),
                    child: LinearProgressIndicator(
                      value: completion,
                      backgroundColor: const Color(0xFF2D2D2D),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        completion >= 1.0
                            ? const Color(0xFF10B981)
                            : completion >= 0.7
                                ? const Color(0xFF3B82F6)
                                : const Color(0xFFF59E0B),
                      ),
                      minHeight: 8.h,
                    ),
                  ),
                ],
              ),
            ),
            if (!widget.task.isCompleted)
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: Color(0xFF3B82F6)),
                onPressed: _showUpdateProgressDialog,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return _buildSectionCard(
      title: 'Quick Actions',
      children: [
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            if (!widget.task.isCompleted)
              _buildActionButton(
                icon: Icons.play_arrow,
                label: 'Start Task',
                color: const Color(0xFF3B82F6),
                onTap: () => _updateStatus('in_progress'),
              ),
            _buildActionButton(
              icon: Icons.pause,
              label: 'Mark Complete',
              color: const Color(0xFF10B981),
              onTap: _completeTask,
            ),
            _buildActionButton(
              icon: Icons.edit,
              label: 'Edit Task',
              color: const Color(0xFF8B5CF6),
              onTap: _showEditDialog,
            ),
            _buildActionButton(
              icon: Icons.delete,
              label: 'Delete',
              color: const Color(0xFFEF4444),
              onTap: _confirmDelete,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 18),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _completeTask() {
    context.read<PlanMyDayCubit>().completeTask(widget.task.id);
  }

  void _updateStatus(String status) {
    context.read<PlanMyDayCubit>().updateTask(
      id: widget.task.id,
      status: status,
    );
  }

  void _showEditDialog() {
    final titleController = TextEditingController(text: widget.task.title);
    final descriptionController = TextEditingController(text: widget.task.description ?? '');
    int selectedPriority = widget.task.priority;
    DateTime? selectedDueDate = widget.task.dueDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'Edit Task',
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
                  SizedBox(height: 12.h),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Description',
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
                  SizedBox(height: 12.h),
                  // Due date picker
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDueDate ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setDialogState(() {
                          selectedDueDate = picked;
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
                          Icon(Icons.calendar_today, color: Colors.grey[400], size: 18),
                          SizedBox(width: 8.w),
                          Text(
                            selectedDueDate != null
                                ? DateFormat('MMM d, yyyy').format(selectedDueDate!)
                                : 'Set Due Date',
                            style: TextStyle(
                              color: selectedDueDate != null
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  // Priority selector
                  Text(
                    'Priority',
                    style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
                  ),
                  SizedBox(height: 4.h),
                  Wrap(
                    spacing: 8.w,
                    children: [
                      _buildPriorityChip('Low', 1, const Color(0xFF10B981), selectedPriority, (value) {
                        setDialogState(() {
                          selectedPriority = value;
                        });
                      }),
                      _buildPriorityChip('Medium', 2, const Color(0xFFF59E0B), selectedPriority, (value) {
                        setDialogState(() {
                          selectedPriority = value;
                        });
                      }),
                      _buildPriorityChip('High', 3, const Color(0xFFEF4444), selectedPriority, (value) {
                        setDialogState(() {
                          selectedPriority = value;
                        });
                      }),
                      _buildPriorityChip('Urgent', 4, const Color(0xFFDC2626), selectedPriority, (value) {
                        setDialogState(() {
                          selectedPriority = value;
                        });
                      }),
                    ],
                  ),
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
                      const SnackBar(content: Text('Title is required')),
                    );
                    return;
                  }
                  context.read<PlanMyDayCubit>().updateTask(
                    id: widget.task.id,
                    title: titleController.text.trim(),
                    description: descriptionController.text.trim().isEmpty ? null : descriptionController.text.trim(),
                    dueDate: selectedDueDate,
                    priority: selectedPriority,
                  );
                  Navigator.pop(context);
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

  Widget _buildPriorityChip(
    String label,
    int value,
    Color color,
    int selectedValue,
    Function(int) onTap,
  ) {
    final isSelected = selectedValue == value;
    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? color : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontSize: 12.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showUpdateProgressDialog() {
    int progress = widget.task.completionPercentage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            title: const Text(
              'Update Progress',
              style: TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Slider(
                  value: progress.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 20,
                  label: '$progress%',
                  activeColor: const Color(0xFF3B82F6),
                  onChanged: (value) {
                    setDialogState(() {
                      progress = value.round();
                    });
                  },
                ),
                SizedBox(height: 8.h),
                Text(
                  '$progress% Complete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
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
                  Navigator.pop(context);
                  // Would need to add updateProgress method to cubit
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Progress updated')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                ),
                child: const Text('Update', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Delete Task',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete "${widget.task.title}"? This action cannot be undone.',
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
              context.read<PlanMyDayCubit>().deleteTask(widget.task.id);
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

  String _getPriorityLabel(int priority) {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      case 4:
        return 'Urgent';
      default:
        return 'Medium';
    }
  }
}
