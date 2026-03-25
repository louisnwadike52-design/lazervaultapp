import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';
import 'package:lazervault/src/features/sprayme/data/gift_catalog_defaults.dart';

/// TikTok-style gift shop bottom sheet with categorized gifts
class GiftShopSheet extends StatefulWidget {
  final List<SprayGift> gifts;
  final double walletBalance; // in major units
  final String currency;
  final void Function(SprayGift gift, int quantity) onSendGift;

  const GiftShopSheet({
    super.key,
    required this.gifts,
    required this.walletBalance,
    required this.currency,
    required this.onSendGift,
  });

  @override
  State<GiftShopSheet> createState() => _GiftShopSheetState();
}

class _GiftShopSheetState extends State<GiftShopSheet>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  String? _selectedGiftId;
  int _quantity = 1;
  late final List<SprayGift> _allGifts;

  static const _categories = ['All', 'Free', 'Basic', 'Premium', 'Luxury', 'Legendary'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    // Merge backend gifts with rich default catalog to fill empty categories
    _allGifts = GiftCatalogDefaults.mergeWithBackend(widget.gifts);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool _canIncrement() {
    if (_selectedGiftId == null) return false;
    final gift = _allGifts.where((g) => g.id == _selectedGiftId).firstOrNull;
    if (gift == null || gift.isFree) return true;
    return widget.walletBalance >= gift.priceMajor * (_quantity + 1);
  }

  List<SprayGift> _filteredGifts(int tabIndex) {
    if (tabIndex == 0) return _allGifts;
    final cat = _categories[tabIndex].toLowerCase();
    return _allGifts.where((g) => g.category == cat).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: EdgeInsets.only(top: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF9CA3AF).withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),

          // Title + wallet balance
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Send a Gift',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.account_balance_wallet, color: const Color(0xFFFFD700), size: 16.sp),
                      SizedBox(width: 6.w),
                      Text(
                        '${widget.currency} ${widget.walletBalance.toStringAsFixed(0)}',
                        style: TextStyle(
                          color: const Color(0xFFFFD700),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),

          // Category tabs
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            indicatorColor: const Color(0xFF3B82F6),
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF9CA3AF),
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            tabs: _categories.map((c) => Tab(text: c)).toList(),
          ),

          // Gift grid
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: List.generate(_categories.length, (tabIdx) {
                final gifts = _filteredGifts(tabIdx);
                if (gifts.isEmpty) {
                  return Center(
                    child: Text(
                      'No gifts in this category',
                      style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp),
                    ),
                  );
                }
                return GridView.builder(
                  padding: EdgeInsets.all(12.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 8.h,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: gifts.length,
                  itemBuilder: (context, index) {
                    final gift = gifts[index];
                    final isSelected = _selectedGiftId == gift.id;
                    final canAfford = gift.isFree || widget.walletBalance >= gift.priceMajor;
                    return GestureDetector(
                      onTap: () {
                        if (!canAfford) return;
                        HapticFeedback.selectionClick();
                        setState(() {
                          _selectedGiftId = isSelected ? null : gift.id;
                          _quantity = 1;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _categoryHighlightColor(gift.category).withValues(alpha: 0.2)
                              : const Color(0xFF2D2D2D).withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: isSelected
                                ? _categoryHighlightColor(gift.category)
                                : Colors.transparent,
                            width: 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: _categoryHighlightColor(gift.category).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: Opacity(
                          opacity: canAfford ? 1.0 : 0.4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedScale(
                                scale: isSelected ? 1.2 : 1.0,
                                duration: const Duration(milliseconds: 200),
                                child: Text(gift.emoji, style: TextStyle(fontSize: 30.sp)),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                gift.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                gift.isFree ? 'Free' : _formatGiftPrice(gift.priceMajor),
                                style: TextStyle(
                                  color: gift.isFree
                                      ? const Color(0xFF10B981)
                                      : _categoryPriceColor(gift.category),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ),

          // Send button
          if (_selectedGiftId != null) ...[
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFF2D2D2D))),
              ),
              child: Row(
                children: [
                  // Quantity selector
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
                          icon: Icon(Icons.remove, size: 18.sp),
                          color: Colors.white,
                          constraints: BoxConstraints(maxWidth: 36.w, maxHeight: 36.h),
                          padding: EdgeInsets.zero,
                        ),
                        SizedBox(
                          width: 32.w,
                          child: Text(
                            '$_quantity',
                            style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                          onPressed: _quantity < 20 && _canIncrement()
                              ? () => setState(() => _quantity++)
                              : null,
                          icon: Icon(Icons.add, size: 18.sp),
                          color: Colors.white,
                          constraints: BoxConstraints(maxWidth: 36.w, maxHeight: 36.h),
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Send button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final gift = _allGifts.where((g) => g.id == _selectedGiftId).firstOrNull;
                        if (gift == null) return;
                        // Final balance check before sending
                        if (!gift.isFree && widget.walletBalance < gift.priceMajor * _quantity) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Insufficient wallet balance'),
                              backgroundColor: Color(0xFFEF4444),
                            ),
                          );
                          return;
                        }
                        HapticFeedback.mediumImpact();
                        widget.onSendGift(gift, _quantity);
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Builder(
                        builder: (_) {
                          final gift = _allGifts.where((g) => g.id == _selectedGiftId).firstOrNull;
                          if (gift == null) return const SizedBox.shrink();
                          final total = gift.priceMajor * _quantity;
                          return Text(
                            gift.isFree
                                ? 'Send ${gift.emoji} x$_quantity'
                                : 'Send ${gift.emoji} x$_quantity (${widget.currency} ${total.toStringAsFixed(0)})',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _categoryHighlightColor(String category) {
    switch (category) {
      case 'legendary':
        return const Color(0xFFFFD700);
      case 'luxury':
        return const Color(0xFFFF6B35);
      case 'premium':
        return const Color(0xFF7C3AED);
      case 'basic':
        return const Color(0xFF3B82F6);
      default:
        return const Color(0xFF10B981);
    }
  }

  Color _categoryPriceColor(String category) {
    switch (category) {
      case 'legendary':
        return const Color(0xFFFFD700);
      case 'luxury':
        return const Color(0xFFFF6B35);
      case 'premium':
        return const Color(0xFFA78BFA);
      default:
        return const Color(0xFFFFD700);
    }
  }

  String _formatGiftPrice(double price) {
    if (price >= 1000) {
      return '${(price / 1000).toStringAsFixed(price % 1000 == 0 ? 0 : 1)}K';
    }
    return price.toStringAsFixed(0);
  }
}
