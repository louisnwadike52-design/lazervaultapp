import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hybrid_hex_color_converter/hybrid_hex_color_converter.dart';

class IncomeTabs extends StatefulWidget {
  final void Function(int) onChanged;
  final int activeTab;

  const IncomeTabs({
    required this.onChanged,
    required this.activeTab,
    super.key,
  });

  @override
  State<IncomeTabs> createState() => _IncomeTabsState();
}

class _IncomeTabsState extends State<IncomeTabs> {
  late int _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.activeTab;
  }

  @override
  void didUpdateWidget(covariant IncomeTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.activeTab != widget.activeTab) {
      setState(() {
        _activeTab = widget.activeTab;
      });
    }
  }

  void _handleTabPress(int index) {
    widget.onChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 232, 235, 245),
          borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    _activeTab == 0 ? Colors.blue : Colors.transparent,
                foregroundColor: _activeTab == 0
                    ? Colors.white
                    : HexColor.fromHex("#262626"),
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () => _handleTabPress(0),
              child: const Text('Income'),
            ),
          ),
          Expanded(
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor:
                    _activeTab == 1 ? Colors.blue : Colors.transparent,
                foregroundColor: _activeTab == 1
                    ? Colors.white
                    : HexColor.fromHex("#262626"),
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                textStyle: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () => _handleTabPress(1),
              child: const Text('Expenses'),
            ),
          ),
        ],
      ),
    );
  }
}
