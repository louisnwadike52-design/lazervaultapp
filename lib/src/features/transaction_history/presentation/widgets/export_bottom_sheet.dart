import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/transaction_history/utils/transaction_export_helper.dart';

class ExportBottomSheet extends StatefulWidget {
  final Future<void> Function(DateTime startDate, DateTime endDate, ExportFormat format) onExport;

  const ExportBottomSheet({super.key, required this.onExport});

  @override
  State<ExportBottomSheet> createState() => _ExportBottomSheetState();

  static Future<void> show(
    BuildContext context, {
    required Future<void> Function(DateTime startDate, DateTime endDate, ExportFormat format)
        onExport,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ExportBottomSheet(onExport: onExport),
    );
  }
}

class _ExportBottomSheetState extends State<ExportBottomSheet> {
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  ExportFormat _selectedFormat = ExportFormat.csv;
  bool _isExporting = false;

  Future<void> _pickDate({required bool isStart}) async {
    final initial = isStart ? _startDate : _endDate;
    final result = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF581CD9),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );

    if (result != null) {
      setState(() {
        if (isStart) {
          _startDate = result;
          if (_startDate.isAfter(_endDate)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = result;
          if (_endDate.isBefore(_startDate)) {
            _startDate = _endDate;
          }
        }
      });
    }
  }

  Future<void> _export() async {
    setState(() => _isExporting = true);
    try {
      // Set endDate to end of day
      final endOfDay = DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59, 59);
      await widget.onExport(_startDate, endOfDay, _selectedFormat);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Export failed: $e', style: TextStyle(fontSize: 13.sp)),
            backgroundColor: const Color(0xFFEF4444),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isExporting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, MediaQuery.of(context).viewInsets.bottom + 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Export Transactions',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'Select date range and format',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 24.h),

          // Date range
          Row(
            children: [
              Expanded(child: _buildDateButton('From', _startDate, () => _pickDate(isStart: true))),
              SizedBox(width: 12.w),
              Expanded(child: _buildDateButton('To', _endDate, () => _pickDate(isStart: false))),
            ],
          ),
          SizedBox(height: 12.h),

          // Quick range buttons
          SizedBox(
            height: 34.h,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _quickRange('Last 7 days', 7),
                SizedBox(width: 8.w),
                _quickRange('Last 30 days', 30),
                SizedBox(width: 8.w),
                _quickRange('Last 90 days', 90),
                SizedBox(width: 8.w),
                _quickRange('This year', -1),
              ],
            ),
          ),
          SizedBox(height: 24.h),

          // Format selection
          Text(
            'Export Format',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF8E8E93),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              _buildFormatOption(ExportFormat.csv, 'CSV', Icons.table_chart_outlined),
              SizedBox(width: 12.w),
              _buildFormatOption(ExportFormat.pdf, 'PDF', Icons.picture_as_pdf_outlined),
            ],
          ),
          SizedBox(height: 24.h),

          // Export button
          SizedBox(
            width: double.infinity,
            height: 50.h,
            child: ElevatedButton(
              onPressed: _isExporting ? null : _export,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF581CD9),
                disabledBackgroundColor: const Color(0xFF581CD9).withValues(alpha: 0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r),
                ),
              ),
              child: _isExporting
                  ? SizedBox(
                      width: 22.w,
                      height: 22.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      'Export',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Inter',
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateButton(String label, DateTime date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF8E8E93),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              DateFormat('d MMM yyyy').format(date),
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickRange(String label, int days) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (days == -1) {
            _startDate = DateTime(DateTime.now().year, 1, 1);
          } else {
            _startDate = DateTime.now().subtract(Duration(days: days));
          }
          _endDate = DateTime.now();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8E8E93),
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }

  Widget _buildFormatOption(ExportFormat format, String label, IconData icon) {
    final isSelected = _selectedFormat == format;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedFormat = format),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF581CD9).withValues(alpha: 0.15)
                : const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF581CD9) : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? const Color(0xFF581CD9) : const Color(0xFF8E8E93), size: 24.sp),
              SizedBox(height: 6.h),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF8E8E93),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
