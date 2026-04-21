import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../domain/entities/intl_airtime_operator.dart';

/// Bottom sheet for selecting an international airtime operator/network.
///
/// Features:
/// - Search functionality to filter operators by name
/// - Shows operator logo, name, and FX info
/// - Highlights auto-detected operator
class IntlOperatorBottomSheet extends StatefulWidget {
  final List<IntlAirtimeOperator> operators;
  final IntlAirtimeOperator? selectedOperator;
  final IntlAirtimeOperator? autoDetectedOperator;
  final Function(IntlAirtimeOperator) onOperatorSelected;

  const IntlOperatorBottomSheet({
    super.key,
    required this.operators,
    this.selectedOperator,
    this.autoDetectedOperator,
    required this.onOperatorSelected,
  });

  static Future<IntlAirtimeOperator?> show({
    required BuildContext context,
    required List<IntlAirtimeOperator> operators,
    IntlAirtimeOperator? selectedOperator,
    IntlAirtimeOperator? autoDetectedOperator,
  }) {
    return Get.bottomSheet<IntlAirtimeOperator>(
      IntlOperatorBottomSheet(
        operators: operators,
        selectedOperator: selectedOperator,
        autoDetectedOperator: autoDetectedOperator,
        onOperatorSelected: (op) {
          Get.back(result: op);
        },
      ),
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  @override
  State<IntlOperatorBottomSheet> createState() => _IntlOperatorBottomSheetState();
}

class _IntlOperatorBottomSheetState extends State<IntlOperatorBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<IntlAirtimeOperator> _filteredOperators = [];

  @override
  void initState() {
    super.initState();
    _filteredOperators = widget.operators;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredOperators = widget.operators;
      } else {
        _filteredOperators = widget.operators
            .where((op) => op.operatorName.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.7),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF4B5563),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
            child: Row(
              children: [
                Text(
                  'Select Network',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                if (widget.autoDetectedOperator != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome, size: 12.sp, color: const Color(0xFF10B981)),
                        SizedBox(width: 4.w),
                        Text(
                          'Detected',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: false,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: 'Search networks...',
                  hintStyle: TextStyle(color: const Color(0xFF6B7280), fontSize: 14.sp),
                  prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
            ),
          ),

          // Operator list
          Flexible(
            child: _filteredOperators.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 40.sp, color: const Color(0xFF4B5563)),
                        SizedBox(height: 12.h),
                        Text(
                          'No networks found',
                          style: TextStyle(fontSize: 14.sp, color: const Color(0xFF6B7280)),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemCount: _filteredOperators.length,
                    itemBuilder: (context, index) {
                      final op = _filteredOperators[index];
                      final isSelected = widget.selectedOperator?.id == op.id;
                      final isDetected = widget.autoDetectedOperator?.id == op.id;

                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onOperatorSelected(op),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.all(14.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF4E03D0).withValues(alpha: 0.1)
                                  : const Color(0xFF0A0A0A),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF4E03D0)
                                    : const Color(0xFF2D2D2D),
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                // Operator logo or placeholder
                                Container(
                                  width: 44.w,
                                  height: 44.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: op.logoUrl.isNotEmpty
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(10.r),
                                          child: Image.network(
                                            op.logoUrl,
                                            width: 44.w,
                                            height: 44.w,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Icon(
                                              Icons.cell_tower_sharp,
                                              color: const Color(0xFF4E03D0),
                                              size: 22.sp,
                                            ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.cell_tower_sharp,
                                          color: const Color(0xFF4E03D0),
                                          size: 22.sp,
                                        ),
                                ),
                                SizedBox(width: 14.w),

                                // Operator details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              op.operatorName,
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (isDetected) ...[
                                            SizedBox(width: 6.w),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                                                borderRadius: BorderRadius.circular(4.r),
                                              ),
                                              child: Text(
                                                'DETECTED',
                                                style: TextStyle(
                                                  fontSize: 9.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color(0xFF10B981),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          if (op.fxRate > 0) ...[
                                            Text(
                                              '1 ${op.destCurrencyCode} ≈ ${op.fxRate.toStringAsFixed(2)} ${op.senderCurrencyCode}',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: const Color(0xFF9CA3AF),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                          ],
                                          Text(
                                            op.isFixed ? 'Fixed denominations' : 'Range',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              color: isSelected
                                                  ? const Color(0xFF4E03D0)
                                                  : const Color(0xFF6B7280),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (op.isFixed) ...[
                                        SizedBox(height: 4.h),
                                        Text(
                                          _getFixedAmountsPreview(op),
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color(0xFF6B7280),
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                // Selection indicator
                                if (isSelected)
                                  Icon(Icons.check_circle, color: const Color(0xFF4E03D0), size: 20.sp)
                                else
                                  Icon(Icons.radio_button_unchecked, color: const Color(0xFF4B5563), size: 20.sp),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _getFixedAmountsPreview(IntlAirtimeOperator op) {
    final amounts = op.parsedLocalFixedAmounts;
    if (amounts.isEmpty) return '';
    final preview = amounts.take(3).map((a) => '${a.toStringAsFixed(0)}${op.destCurrencyCode}').join(', ');
    return amounts.length > 3 ? '$preview +${amounts.length - 3} more' : preview;
  }
}
