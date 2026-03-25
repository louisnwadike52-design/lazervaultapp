import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// TikTok-style gift announcement banner overlay.
///
/// Shows sliding banners from the left when gifts/money are sent.
/// Supports combo counting (x1 → x2 → x3) when same user sends
/// the same gift within 5 seconds.
///
/// Usage: Attach a GlobalKey<GiftBannerOverlayState> and call
/// `key.currentState?.showGiftBanner(...)` from event handlers.
class GiftBannerOverlay extends StatefulWidget {
  const GiftBannerOverlay({super.key});

  @override
  GiftBannerOverlayState createState() => GiftBannerOverlayState();
}

class _BannerData {
  final String id;
  final String senderId;
  final String senderName;
  final String? senderAvatarUrl;
  final String giftId;
  final String giftName;
  final String giftEmoji;
  final String category;
  bool get isMoney => category == 'money';
  int comboCount;
  int totalAmount;
  String currency;
  DateTime lastUpdated;

  _BannerData({
    required this.senderId,
    required this.senderName,
    this.senderAvatarUrl,
    required this.giftId,
    required this.giftName,
    required this.giftEmoji,
    this.category = 'basic',
    this.comboCount = 1,
    this.totalAmount = 0,
    this.currency = 'NGN',
  })  : id = '${senderId}_${giftId}_${DateTime.now().millisecondsSinceEpoch}',
        lastUpdated = DateTime.now();
}

class GiftBannerOverlayState extends State<GiftBannerOverlay> {
  static const _maxVisible = 2;
  static const _maxQueueSize = 10;
  static const _bannerDuration = Duration(seconds: 5);
  static const _comboWindow = Duration(seconds: 5);

  final List<_BannerData> _banners = [];
  final List<_BannerData> _queue = [];
  final Map<String, Timer> _dismissTimers = {};

  @override
  void dispose() {
    for (final timer in _dismissTimers.values) {
      timer.cancel();
    }
    super.dispose();
  }

  /// Show a gift banner. If same sender+gift within combo window,
  /// increments the combo counter instead of adding a new banner.
  void showGiftBanner({
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String giftId,
    required String giftName,
    required String giftEmoji,
    int quantity = 1,
    int amount = 0,
    String category = 'basic',
    String currency = 'NGN',
  }) {
    if (!mounted) return;
    setState(() {
      // Check for combo: same sender + same gift within window
      final existing = _banners
          .where((b) =>
              b.senderId == senderId &&
              b.giftId == giftId &&
              DateTime.now().difference(b.lastUpdated) < _comboWindow)
          .firstOrNull;

      if (existing != null) {
        // Combo! Increment counter
        existing.comboCount += quantity;
        existing.totalAmount += amount;
        existing.lastUpdated = DateTime.now();
        // Reset the dismiss timer
        _dismissTimers[existing.id]?.cancel();
        _scheduleDismiss(existing);
      } else if (_banners.length < _maxVisible) {
        _addBanner(
          senderId: senderId,
          senderName: senderName,
          senderAvatarUrl: senderAvatarUrl,
          giftId: giftId,
          giftName: giftName,
          giftEmoji: giftEmoji,
          category: category,
          quantity: quantity,
          amount: amount,
          currency: currency,
        );
      } else if (_queue.length < _maxQueueSize) {
        // Queue it (capped to prevent unbounded growth)
        _queue.add(_BannerData(
          senderId: senderId,
          senderName: senderName,
          senderAvatarUrl: senderAvatarUrl,
          giftId: giftId,
          giftName: giftName,
          giftEmoji: giftEmoji,
          category: category,
          comboCount: quantity,
          totalAmount: amount,
          currency: currency,
        ));
      }
    });
  }

  /// Show a money spray banner.
  void showMoneyBanner({
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required int amount,
    String currency = 'NGN',
  }) {
    showGiftBanner(
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      giftId: 'money_spray',
      giftName: 'Sprayed',
      giftEmoji: '\u{1F4B5}',
      quantity: 1,
      amount: amount,
      category: 'money',
      currency: currency,
    );
  }

  void _addBanner({
    required String senderId,
    required String senderName,
    String? senderAvatarUrl,
    required String giftId,
    required String giftName,
    required String giftEmoji,
    required String category,
    required int quantity,
    required int amount,
    required String currency,
  }) {
    final banner = _BannerData(
      senderId: senderId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      giftId: giftId,
      giftName: giftName,
      giftEmoji: giftEmoji,
      category: category,
      comboCount: quantity,
      totalAmount: amount,
      currency: currency,
    );
    _banners.add(banner);
    _scheduleDismiss(banner);
  }

  void _scheduleDismiss(_BannerData banner) {
    _dismissTimers[banner.id] = Timer(_bannerDuration, () {
      if (!mounted) return;
      setState(() {
        _banners.remove(banner);
        _dismissTimers.remove(banner.id);
        // Promote queued banner
        if (_queue.isNotEmpty) {
          final next = _queue.removeAt(0);
          _banners.add(next);
          _scheduleDismiss(next);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: MediaQuery.of(context).padding.top + 80.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: _banners.map((banner) {
          return _GiftBannerItem(
            key: ValueKey(banner.id),
            data: banner,
          );
        }).toList(),
      ),
    );
  }
}

// ─── Individual Banner Widget ─────────────────────────────────────

class _GiftBannerItem extends StatefulWidget {
  final _BannerData data;

  const _GiftBannerItem({super.key, required this.data});

  @override
  State<_GiftBannerItem> createState() => _GiftBannerItemState();
}

class _GiftBannerItemState extends State<_GiftBannerItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;
  int _lastComboCount = 0;

  @override
  void initState() {
    super.initState();
    _lastComboCount = widget.data.comboCount;

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideController,
        curve: const Interval(0.0, 0.6),
      ),
    );

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  Color _gradientStart() {
    switch (widget.data.category) {
      case 'premium':
        return const Color(0xFF7C3AED).withValues(alpha: 0.9);
      case 'deluxe':
      case 'luxury':
      case 'legendary':
        return const Color(0xFFD97706).withValues(alpha: 0.9);
      case 'money':
        return const Color(0xFF059669).withValues(alpha: 0.9);
      default:
        return const Color(0xFF2563EB).withValues(alpha: 0.85);
    }
  }

  Color _gradientEnd() {
    switch (widget.data.category) {
      case 'premium':
        return const Color(0xFF7C3AED).withValues(alpha: 0.0);
      case 'deluxe':
      case 'luxury':
      case 'legendary':
        return const Color(0xFFD97706).withValues(alpha: 0.0);
      case 'money':
        return const Color(0xFF059669).withValues(alpha: 0.0);
      default:
        return const Color(0xFF2563EB).withValues(alpha: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final comboChanged = data.comboCount != _lastComboCount;
    if (comboChanged) _lastComboCount = data.comboCount;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Banner body
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [_gradientStart(), _gradientEnd()],
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.r),
                    bottomRight: Radius.circular(24.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Sender avatar
                    CircleAvatar(
                      radius: 16.r,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      backgroundImage: data.senderAvatarUrl != null &&
                              data.senderAvatarUrl!.isNotEmpty
                          ? NetworkImage(data.senderAvatarUrl!)
                          : null,
                      child: data.senderAvatarUrl == null ||
                              data.senderAvatarUrl!.isEmpty
                          ? Icon(Icons.person,
                              size: 16.sp, color: Colors.white70)
                          : null,
                    ),
                    SizedBox(width: 8.w),

                    // Name + action text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          data.senderName.isNotEmpty
                              ? data.senderName
                              : 'Someone',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(color: Colors.black38, blurRadius: 2)
                            ],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          data.isMoney ? 'lazersprayed money' : 'lazersprayed a ${data.giftName}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 10.sp,
                            shadows: const [
                              Shadow(color: Colors.black26, blurRadius: 2)
                            ],
                          ),
                          maxLines: 1,
                        ),
                      ],
                    ),
                    SizedBox(width: 8.w),

                    // Gift emoji (large)
                    Text(
                      data.giftEmoji,
                      style: TextStyle(fontSize: 30.sp),
                    ),
                  ],
                ),
              ),

              // Combo counter (outside gradient, pops out)
              SizedBox(width: 4.w),
              _ComboCounter(
                count: data.comboCount,
                category: data.category,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Combo Counter with Bounce Animation ──────────────────────────

class _ComboCounter extends StatefulWidget {
  final int count;
  final String category;

  const _ComboCounter({required this.count, this.category = 'basic'});

  @override
  State<_ComboCounter> createState() => _ComboCounterState();
}

class _ComboCounterState extends State<_ComboCounter>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _scaleAnimation;
  int _previousCount = 0;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.count;

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.6), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 1.6, end: 0.9), weight: 30),
      TweenSequenceItem(tween: Tween(begin: 0.9, end: 1.0), weight: 40),
    ]).animate(CurvedAnimation(
      parent: _bounceController,
      curve: Curves.easeOut,
    ));

    // Animate on first appear
    _bounceController.forward();
  }

  @override
  void didUpdateWidget(_ComboCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.count != _previousCount) {
      _previousCount = widget.count;
      _bounceController.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Color _comboColor() {
    if (widget.count >= 10) return const Color(0xFFFFD700);
    if (widget.count >= 5) return const Color(0xFFFF6B6B);
    switch (widget.category) {
      case 'premium':
        return const Color(0xFFA78BFA);
      case 'deluxe':
      case 'luxury':
      case 'legendary':
        return const Color(0xFFFFD700);
      case 'money':
        return const Color(0xFF34D399);
      default:
        return const Color(0xFF60A5FA);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.count <= 1) return const SizedBox.shrink();

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        'x${widget.count}',
        style: TextStyle(
          color: _comboColor(),
          fontSize: 22.sp,
          fontWeight: FontWeight.w900,
          fontStyle: FontStyle.italic,
          shadows: [
            Shadow(color: _comboColor().withValues(alpha: 0.6), blurRadius: 8),
            const Shadow(color: Colors.black54, blurRadius: 4),
          ],
        ),
      ),
    );
  }
}
