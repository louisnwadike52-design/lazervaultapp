import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TikTok-style name slide animation that slides the sprayer's name
/// in from the corner, holds briefly, then fades out.
class SprayNameSlideOverlay extends StatefulWidget {
  const SprayNameSlideOverlay({super.key});

  @override
  SprayNameSlideOverlayState createState() => SprayNameSlideOverlayState();
}

class SprayNameSlideOverlayState extends State<SprayNameSlideOverlay> {
  final List<_NameSlideData> _activeSlides = [];
  final List<_NameSlideData> _queue = [];
  int _idCounter = 0;
  static const _maxVisible = 3;
  static const _maxQueue = 12;

  void showNameSlide({
    required String name,
    required String action,
    String? emoji,
    String? avatarUrl,
    Color nameColor = const Color(0xFFFFD700),
  }) {
    if (!mounted) return;
    final data = _NameSlideData(
      id: _idCounter++,
      name: name.isNotEmpty ? name : 'Guest',
      action: action,
      emoji: emoji ?? '',
      avatarUrl: avatarUrl,
      nameColor: nameColor,
    );

    setState(() {
      if (_activeSlides.length < _maxVisible) {
        _activeSlides.add(data);
      } else if (_queue.length < _maxQueue) {
        _queue.add(data);
      }
    });
  }

  void _onComplete(int id) {
    if (!mounted) return;
    setState(() {
      _activeSlides.removeWhere((s) => s.id == id);
      if (_queue.isNotEmpty && _activeSlides.length < _maxVisible) {
        _activeSlides.add(_queue.removeAt(0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _activeSlides.map((data) {
          return _NameSlideItem(
            key: ValueKey('name_slide_${data.id}'),
            data: data,
            onComplete: () => _onComplete(data.id),
          );
        }).toList(),
      ),
    );
  }
}

class _NameSlideData {
  final int id;
  final String name;
  final String action;
  final String emoji;
  final String? avatarUrl;
  final Color nameColor;

  const _NameSlideData({
    required this.id,
    required this.name,
    required this.action,
    required this.emoji,
    this.avatarUrl,
    required this.nameColor,
  });
}

class _NameSlideItem extends StatefulWidget {
  final _NameSlideData data;
  final VoidCallback onComplete;

  const _NameSlideItem({super.key, required this.data, required this.onComplete});

  @override
  State<_NameSlideItem> createState() => _NameSlideItemState();
}

class _NameSlideItemState extends State<_NameSlideItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideIn;
  late final Animation<double> _fadeIn;
  late final Animation<double> _fadeOut;
  Timer? _dismissTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4500),
      vsync: this,
    );

    // Slide in from left (0-15%)
    _slideIn = Tween<Offset>(
      begin: const Offset(-1.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.15, curve: Curves.easeOutCubic),
    ));

    // Fade in (0-10%)
    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.1, curve: Curves.easeOut),
      ),
    );

    // Fade out (75-100%)
    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.75, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward().then((_) {
      widget.onComplete();
    });
  }

  @override
  void dispose() {
    _dismissTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final opacity = _controller.value < 0.75
            ? _fadeIn.value
            : _fadeOut.value;

        return SlideTransition(
          position: _slideIn,
          child: Opacity(
            opacity: opacity.clamp(0.0, 1.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 6.h),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.data.nameColor.withValues(alpha: 0.7),
                    widget.data.nameColor.withValues(alpha: 0.0),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.data.emoji.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(right: 6.w),
                      child: Text(
                        widget.data.emoji,
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ),
                  Text(
                    widget.data.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      shadows: const [
                        Shadow(color: Colors.black54, blurRadius: 4),
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    widget.data.action,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 11.sp,
                      shadows: const [
                        Shadow(color: Colors.black38, blurRadius: 2),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
