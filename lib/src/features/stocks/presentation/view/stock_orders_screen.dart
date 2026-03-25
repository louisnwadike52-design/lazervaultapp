import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/stock_cubit.dart';
import '../../cubit/stock_state.dart';
import '../../../../../core/utils/currency_formatter.dart';

/// Bamboo-style Orders Screen
/// Order history with status indicators and filtering
class StockOrdersScreen extends StatefulWidget {
  const StockOrdersScreen({super.key});

  @override
  State<StockOrdersScreen> createState() => _StockOrdersScreenState();
}

class _StockOrdersScreenState extends State<StockOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'all';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadOrders() {
    context.read<StockCubit>().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A0A2E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildOrdersList('all'),
                    _buildOrdersList('pending'),
                    _buildOrdersList('completed'),
                    _buildOrdersList('cancelled'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Orders',
                  style: GoogleFonts.inter(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Your order history',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
                size: 20.sp,
              ),
              onPressed: _loadOrders,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        isScrollable: true,
        labelColor: Colors.white.withValues(alpha: 0.7),
        unselectedLabelColor: Colors.white.withValues(alpha: 0.5),
        labelStyle: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 13.sp),
        indicatorPadding: EdgeInsets.all(4.w),
        dividerColor: Colors.transparent,
        labelPadding: EdgeInsets.symmetric(horizontal: 12.w),
        tabs: const [
          Tab(text: 'All'),
          Tab(text: 'Pending'),
          Tab(text: 'Completed'),
          Tab(text: 'Cancelled'),
        ],
      ),
    );
  }

  Widget _buildOrdersList(String status) {
    return BlocBuilder<StockCubit, StockState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return _buildLoadingState();
        }

        if (state is OrdersError) {
          return _buildErrorState(state.message);
        }

        final orders = state is OrdersLoaded
            ? _filterOrders(state.orders, status)
            : <StockOrder>[];

        if (orders.isEmpty) {
          return _buildEmptyState(status);
        }

        return RefreshIndicator(
          onRefresh: () async {
            _loadOrders();
          },
          backgroundColor: const Color(0xFF1E293B),
          color: const Color(0xFF6366F1),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return _buildOrderCard(orders[index]);
            },
          ),
        );
      },
    );
  }

  List<StockOrder> _filterOrders(List<StockOrder> orders, String status) {
    if (status == 'all') return orders;
    return orders.where((order) => order.status.toLowerCase() == status).toList();
  }

  Widget _buildOrderCard(StockOrder order) {
    final isBuy = order.type.toLowerCase() == 'buy';
    final statusColor = _getStatusColor(order.status);
    final statusIcon = _getStatusIcon(order.status);

    return GestureDetector(
      onTap: () => _showOrderDetails(order),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: (isBuy ? Colors.green : Colors.red).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                isBuy ? Icons.arrow_upward : Icons.arrow_downward,
                color: isBuy ? Colors.green : Colors.red,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        order.symbol,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: (isBuy ? Colors.green : Colors.red).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          order.type.toUpperCase(),
                          style: GoogleFonts.inter(
                            color: isBuy ? Colors.green : Colors.red,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${order.quantity} shares @ ${CurrencySymbols.formatAmountWithCurrency(order.price, order.currency)}',
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.6),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatDate(order.createdAt),
                    style: GoogleFonts.inter(
                      color: Colors.white.withValues(alpha: 0.4),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  CurrencySymbols.formatAmountWithCurrency(order.totalValue, order.currency),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        color: statusColor,
                        size: 12.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        order.status.toUpperCase(),
                        style: GoogleFonts.inter(
                          color: statusColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDetails(StockOrder order) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A0A2E),
              const Color(0xFF0F0F23),
            ],
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Order Details',
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    _buildDetailItem('Order ID', order.id),
                    _buildDetailItem('Stock', order.symbol),
                    _buildDetailItem('Type', order.type.toUpperCase()),
                    _buildDetailItem('Quantity', '${order.quantity} shares'),
                    _buildDetailItem('Price', CurrencySymbols.formatAmountWithCurrency(order.price, order.currency)),
                    _buildDetailItem('Total Value', CurrencySymbols.formatAmountWithCurrency(order.totalValue, order.currency)),
                    _buildDetailItem('Status', order.status.toUpperCase()),
                    _buildDetailItem('Created', _formatDate(order.createdAt)),
                    if (order.status.toLowerCase() == 'completed')
                      _buildDetailItem('Executed', _formatDate(order.executedAt)),
                    SizedBox(height: 24.h),
                    if (order.status.toLowerCase() == 'pending')
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back();
                                _cancelOrder(order.id);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                              ),
                              child: Text(
                                'Cancel Order',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'filled':
        return Colors.green;
      case 'pending':
      case 'open':
      case 'processing':
        return Colors.orange;
      case 'cancelled':
      case 'rejected':
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'filled':
        return Icons.check_circle;
      case 'pending':
      case 'open':
      case 'processing':
        return Icons.access_time;
      case 'cancelled':
        return Icons.cancel;
      case 'rejected':
      case 'failed':
        return Icons.error;
      default:
        return Icons.help_outline;
    }
  }

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _cancelOrder(String orderId) {
    context.read<StockCubit>().cancelOrder(orderId);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 40.w,
            height: 40.w,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                const Color(0xFF6366F1),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading orders...',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String status) {
    final statusText = status == 'all' ? 'orders' : '$status orders';
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.receipt_long,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No $statusText',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            status == 'all'
                ? 'Your order history will appear here'
                : 'You don\'t have any $statusText',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48.sp,
            color: Colors.red,
          ),
          SizedBox(height: 16.h),
          Text(
            'Error loading orders',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: _loadOrders,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper class for Orders
class StockOrder {
  final String id;
  final String symbol;
  final String type;
  final int quantity;
  final double price;
  final double totalValue;
  final String status;
  final String currency;
  final DateTime createdAt;
  final DateTime executedAt;

  StockOrder({
    required this.id,
    required this.symbol,
    required this.type,
    required this.quantity,
    required this.price,
    required this.totalValue,
    required this.status,
    required this.currency,
    required this.createdAt,
    required this.executedAt,
  });
}
