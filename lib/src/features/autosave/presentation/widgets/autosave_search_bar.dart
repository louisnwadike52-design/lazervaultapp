import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/debouncer.dart';

class AutoSaveSearchBar extends StatefulWidget {
  final Function(String) onSearchChanged;
  final String? initialQuery;

  const AutoSaveSearchBar({
    super.key,
    required this.onSearchChanged,
    this.initialQuery,
  });

  @override
  State<AutoSaveSearchBar> createState() => _AutoSaveSearchBarState();
}

class _AutoSaveSearchBarState extends State<AutoSaveSearchBar> {
  late TextEditingController _controller;
  final Debouncer _debouncer = Debouncer.search();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialQuery);
  }

  @override
  void dispose() {
    _debouncer.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    _debouncer.run(() {
      widget.onSearchChanged(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search rules...',
          hintStyle:
              TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
          prefixIcon: Icon(Icons.search,
              color: const Color(0xFF9CA3AF), size: 20.sp),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged('');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
      ),
    );
  }
}
