import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../../../../core/types/app_routes.dart';
import 'widgets/gift_card_error_widget.dart';

class MyGiftCardsScreen extends StatefulWidget {
  const MyGiftCardsScreen({super.key});

  @override
  State<MyGiftCardsScreen> createState() => _MyGiftCardsScreenState();
}

class _MyGiftCardsScreenState extends State<MyGiftCardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          _selectedTabIndex = _tabController.index;
        });
      }
    });
    context.read<GiftCardCubit>().loadMyGiftCards();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    context.read<GiftCardCubit>().loadMyGiftCards();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GiftCardCubit, GiftCardState>(
      listener: (context, state) {
        if (state is RedeemCodeLoaded) {
          // Show redeem code in a snackbar or navigate to details
          if (state.status == 'available') {
            Get.snackbar(
              'Redeem Code',
              'Code: ${state.redemptionCode}${state.redemptionPin.isNotEmpty ? " PIN: ${state.redemptionPin}" : ""}',
              snackPosition: SnackPosition.TOP,
              backgroundColor: const Color(0xFF10B981).withValues(alpha: 0.9),
              colorText: Colors.white,
              borderRadius: 12.r,
              margin: EdgeInsets.all(16.w),
              duration: const Duration(seconds: 8),
            );
          }
        } else if (state is GiftCardRedeemError) {
          Get.snackbar(
            'Redeem Failed',
            friendlyGiftCardError(state.message),
            snackPosition: SnackPosition.TOP,
            backgroundColor: const Color(0xFFEF4444).withValues(alpha: 0.9),
            colorText: Colors.white,
            borderRadius: 12.r,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              // Quick actions removed — redeem code is on card details
              Expanded(
                child: BlocBuilder<GiftCardCubit, GiftCardState>(
                  buildWhen: (prev, curr) =>
                      curr is GiftCardLoading ||
                      curr is GiftCardError ||
                      curr is GiftCardNetworkError ||
                      curr is GiftCardTimeoutError ||
                      curr is GiftCardServerUnavailable ||
                      curr is MyGiftCardsLoaded ||
                      curr is UserGiftCardsEmpty,
                  builder: (context, state) {
                    if (state is GiftCardLoading) {
                      return _buildLoadingView();
                    } else if (state is GiftCardError) {
                      return _buildErrorView(state.message);
                    } else if (state is GiftCardNetworkError) {
                      return _buildErrorView(state.message);
                    } else if (state is GiftCardTimeoutError) {
                      return _buildErrorView('Request timed out. Pull down to retry.');
                    } else if (state is GiftCardServerUnavailable) {
                      return _buildErrorView('Service temporarily unavailable. Pull down to retry.');
                    } else if (state is MyGiftCardsLoaded) {
                      return _buildGiftCardList(state.giftCards);
                    }
                    return _buildEmptyView();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
            ),
          ),
          Expanded(
            child: Text(
              'My Gift Cards',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.giftCardTransactions),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Icon(Icons.receipt_long_rounded,
                  color: const Color(0xFF3B82F6), size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicatorPadding: EdgeInsets.all(3.w),
        tabs: const [
          Tab(text: 'Available'),
          Tab(text: 'Expired'),
          Tab(text: 'Transferred'),
          Tab(text: 'All'),
        ],
      ),
    );
  }

  bool _isExpired(GiftCard card) {
    if (card.status == 'expired') return true;
    if (card.expiryDate.isEmpty) return false;
    try {
      return DateTime.parse(card.expiryDate).isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  Widget _buildGiftCardList(List<GiftCard> giftCards) {
    final filteredCards = giftCards.where((card) {
      switch (_selectedTabIndex) {
        case 0: // Available: active status AND not expired
          return card.status == 'available' && !_isExpired(card);
        case 1: // Expired: status is expired OR expiry date has passed
          return _isExpired(card);
        case 2:
          return card.status == 'transferred';
        case 3:
          return true; // All cards
        default:
          return true;
      }
    }).toList();

    if (filteredCards.isEmpty) {
      return _buildEmptyTabView();
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: filteredCards.length,
        itemBuilder: (context, index) {
          return _buildGiftCardItem(filteredCards[index]);
        },
      ),
    );
  }

  Widget _buildGiftCardItem(GiftCard card) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.giftCardDetails, arguments: card),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: card.logoUrl,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => Icon(
                    Icons.image_rounded,
                    color: Colors.grey.shade400,
                    size: 22.sp,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.card_giftcard_rounded,
                    color: Colors.grey.shade400,
                    size: 22.sp,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.brandName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${card.currency} ${card.originalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF3B82F6),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Expires: ${_formatDate(card.expiryDate)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getDisplayStatusColor(card).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    _getDisplayStatus(card).toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: _getDisplayStatusColor(card),
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: const Color(0xFF9CA3AF),
                  size: 14.sp,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color(0xFF3B82F6),
        strokeWidth: 2.5,
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return GiftCardErrorList.fromRaw(
      rawMessage: message,
      onRetry: _onRefresh,
    );
  }

  Widget _buildEmptyTabView() {
    final IconData icon;
    final String title;
    final String subtitle;

    switch (_selectedTabIndex) {
      case 0:
        icon = Icons.card_giftcard_outlined;
        title = 'No available gift cards';
        subtitle = 'Gift cards you purchase will appear here';
      case 1:
        icon = Icons.timer_off_outlined;
        title = 'No expired gift cards';
        subtitle = 'Cards past their expiry date will show up here';
      case 2:
        icon = Icons.swap_horiz_rounded;
        title = 'No transferred gift cards';
        subtitle = 'Gift cards you send to others will appear here';
      default:
        icon = Icons.card_giftcard_outlined;
        title = 'No gift cards yet';
        subtitle = 'Your gift cards will appear here';
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  icon,
                  size: 40.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyView() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.card_giftcard_outlined,
                  size: 40.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'No Gift Cards Yet',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Purchase your first gift card to get started',
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.giftCards),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  padding:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Browse Gift Cards',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getDisplayStatus(GiftCard card) {
    if (_isExpired(card)) return 'expired';
    if (card.status == 'available') return 'available';
    return card.status;
  }

  Color _getDisplayStatusColor(GiftCard card) {
    if (_isExpired(card)) return const Color(0xFFEF4444);
    switch (card.status) {
      case 'available':
        return const Color(0xFF10B981);
      case 'pending':
        return const Color(0xFFFB923C);
      case 'transferred':
        return const Color(0xFF3B82F6);
      case 'expired':
        return const Color(0xFFEF4444);
      case 'cancelled':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _formatDate(String date) {
    if (date.isEmpty) return '';
    try {
      final parsed = DateTime.parse(date);
      return '${parsed.day}/${parsed.month}/${parsed.year}';
    } catch (_) {
      return date;
    }
  }
}
