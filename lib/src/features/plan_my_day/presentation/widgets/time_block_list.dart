import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/plan_my_day/domain/entities/time_block.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/task.dart';
import 'package:lazervault/src/features/plan_my_day/domain/entities/event.dart';

class TimeBlockList extends StatelessWidget {
  final List<TimeBlock> timeBlocks;
  final List<Task> tasks;
  final List<Event> events;

  const TimeBlockList({
    super.key,
    required this.timeBlocks,
    this.tasks = const [],
    this.events = const [],
  });

  @override
  Widget build(BuildContext context) {
    // Sort time blocks by start time
    final sortedBlocks = List<TimeBlock>.from(timeBlocks);
    sortedBlocks.sort((a, b) => a.startTime.compareTo(b.startTime));

    if (sortedBlocks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sortedBlocks.map((block) => _buildTimeBlock(context, block)).toList(),
    );
  }

  Widget _buildTimeBlock(BuildContext context, TimeBlock block) {
    // Find linked tasks and events
    final linkedTasks = tasks.where((t) => block.taskIds.contains(t.id)).toList();
    final linkedEvents = events.where((e) => block.eventIds.contains(e.id)).toList();

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border(
          left: BorderSide(
            color: block.color != null
                ? Color(int.parse(block.color!.replaceAll('#', '0xFF')))
                : const Color(0xFF3B82F6),
            width: 4.w,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                block.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${block.startTime} - ${block.endTime}',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          if (block.description != null) ...[
            SizedBox(height: 4.h),
            Text(
              block.description!,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ],
          if (linkedTasks.isNotEmpty || linkedEvents.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: [
                ...linkedTasks.map((task) => _buildLinkedChip(task.title, Icons.task_outlined)),
                ...linkedEvents.map((event) => _buildLinkedChip(event.title, Icons.event)),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLinkedChip(String label, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: Colors.grey[400],
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
