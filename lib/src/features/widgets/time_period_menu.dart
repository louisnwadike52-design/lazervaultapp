import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/typedef.dart';

class TimePeriodMenu extends StatefulWidget {
  const TimePeriodMenu({super.key});

  @override
  State<TimePeriodMenu> createState() => _TimePeriodMenuState();
}

class _TimePeriodMenuState extends State<TimePeriodMenu> {
  String? selectedValue;
  final List<TimePeriod> dropdownItems = [
    TimePeriod.weekly,
    TimePeriod.monthly,
    TimePeriod.yearly
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 105.w,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromARGB(255, 239, 234, 234),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          initialValue: selectedValue,
          decoration: const InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
          ),
          hint: const Text("Weekly"),
          items: dropdownItems.map((item) {
            return DropdownMenuItem<String>(
              value: item.displayName,
              child: Text(item.displayName),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
        ),
      ),
    );
  }
}
