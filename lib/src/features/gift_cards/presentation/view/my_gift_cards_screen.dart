import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';

class MyGiftCardsScreen extends StatefulWidget {
  const MyGiftCardsScreen({super.key});

  @override
  State<MyGiftCardsScreen> createState() => _MyGiftCardsScreenState();
}

class _MyGiftCardsScreenState extends State<MyGiftCardsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF1A1A1A),
              const Color(0xFF2D2D2D).withOpacity(0.8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: BlocBuilder<GiftCardCubit, GiftCardState>(
                  builder: (context, state) {
                    if (state is GiftCardLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is GiftCardError) {
                      return Center(child: Text(state.message));
                    } else if (state is MyGiftCardsLoaded) {
                      return _buildGiftCardList(state.giftCards);
                    }
                    return const Center(child: Text('No gift cards found'));
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
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          SizedBox(width: 8.w),
          Text(
            'My Gift Cards',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF6C63FF),
              const Color(0xFF4CAF50),
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: 'Active'),
          Tab(text: 'Pending'),
          Tab(text: 'Used'),
        ],
      ),
    );
  }

  Widget _buildGiftCardList(List<GiftCard> giftCards) {
    final filteredCards = giftCards.where((card) {
      switch (_selectedTabIndex) {
        case 0:
          return card.status == GiftCardStatus.active;
        case 1:
          return card.status == GiftCardStatus.pending;
        case 2:
          return card.status == GiftCardStatus.used;
        default:
          return false;
      }
    }).toList();

    if (filteredCards.isEmpty) {
      return Center(
        child: Text(
          'No ${_getStatusText(_selectedTabIndex)} gift cards',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16.sp,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: filteredCards.length,
      itemBuilder: (context, index) {
        final card = filteredCards[index];
        return _buildGiftCardItem(card);
      },
    );
  }

  Widget _buildGiftCardItem(GiftCard card) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: CachedNetworkImage(
                imageUrl: card.logoUrl,
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[800],
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.brandName,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '\$${card.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Expires: ${_formatDate(card.expiryDate)}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: _getStatusColor(card.status).withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                card.status.name.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: _getStatusColor(card.status),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText(int index) {
    switch (index) {
      case 0:
        return 'active';
      case 1:
        return 'pending';
      case 2:
        return 'used';
      default:
        return '';
    }
  }

  Color _getStatusColor(GiftCardStatus status) {
    switch (status) {
      case GiftCardStatus.active:
        return Colors.green;
      case GiftCardStatus.pending:
        return Colors.orange;
      case GiftCardStatus.used:
        return Colors.grey;
      case GiftCardStatus.expired:
        return Colors.red;
      case GiftCardStatus.cancelled:
        return Colors.red;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
} 