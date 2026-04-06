import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/education_history_entity.dart';
import '../cubit/education_history_cubit.dart';

class EducationHistoryScreen extends StatefulWidget {
  const EducationHistoryScreen({super.key});

  @override
  State<EducationHistoryScreen> createState() => _EducationHistoryScreenState();
}

class _EducationHistoryScreenState extends State<EducationHistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadHistory() {
    context.read<EducationHistoryCubit>().loadHistory(refresh: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<EducationHistoryCubit>().loadMore();
    }
  }

  void _viewPurchaseDetails(EducationHistoryEntity purchase) async {
    final purchaseDetails = await context
        .read<EducationHistoryCubit>()
        .getPurchaseById(purchase.id);

    if (purchaseDetails != null && mounted) {
      Get.toNamed(
        AppRoutes.educationPinDetails,
        arguments: {
          'purchase': purchaseDetails,
          'providerName': purchase.providerName,
        },
      );
    }
  }

  void _rebuyPurchase(EducationHistoryEntity purchase) {
    Get.toNamed(
      AppRoutes.educationHome,
      arguments: {
        'rebuyPurchase': purchase,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 22.sp,
          ),
        ),
        title: Text(
          'PIN Purchase History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _loadHistory,
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
        ],
      ),
      body: BlocBuilder<EducationHistoryCubit, EducationHistoryState>(
        builder: (context, state) {
          if (state is EducationHistoryLoading && state is! EducationHistoryLoaded) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is EducationHistoryError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64.sp,
                    color: const Color(0xFFEF4444),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Failed to load history',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    state.message,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  ElevatedButton(
                    onPressed: _loadHistory,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
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

          if (state is EducationHistoryInitial) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is EducationHistoryLoaded) {
            if (state.history.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'No Purchase History',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'You haven\'t purchased any education PINs yet',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                _loadHistory();
                await Future.delayed(const Duration(seconds: 1));
              },
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(20.w),
                itemCount: state.history.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= state.history.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                        ),
                      ),
                    );
                  }

                  final purchase = state.history[index];
                  return _buildHistoryCard(purchase);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHistoryCard(EducationHistoryEntity purchase) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase.providerName,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${purchase.quantity} ${purchase.quantity == 1 ? 'PIN' : 'PINs'}',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _parseColor(_getStatusColor(purchase)).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: _parseColor(_getStatusColor(purchase)).withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  _getStatusText(purchase),
                  style: GoogleFonts.inter(
                    color: _parseColor(_getStatusColor(purchase)),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Amount and reference
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Amount',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '₦${_formatAmount(purchase.amount)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Reference',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    purchase.reference,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Date
          Text(
            _formatDate(purchase.createdAt),
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 16.h),

          // Action buttons
          Row(
            children: [
              // View Details button (only if has PINs)
              if (_hasPins(purchase))
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _viewPurchaseDetails(purchase),
                    icon: Icon(Icons.visibility, size: 16.sp),
                    label: Text(
                      'View PINs',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: const BorderSide(color: Color(0xFF3B82F6)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),

              if (_hasPins(purchase)) SizedBox(width: 12.w),

              // Rebuy button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _rebuyPurchase(purchase),
                  icon: Icon(Icons.shopping_cart, size: 16.sp),
                  label: Text(
                    'Rebuy',
                    style: TextStyle(fontSize: 13.sp),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _parseColor(String hexColor) {
    final color = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$color', radix: 16));
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'Today, ${_formatTime(date)}';
      } else if (difference.inDays == 1) {
        return 'Yesterday, ${_formatTime(date)}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return '${date.day}/${date.month}/${date.year}';
      }
    } catch (e) {
      return dateString;
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Helper methods for EducationHistoryEntity
  String _getStatusColor(EducationHistoryEntity purchase) {
    switch (purchase.status.toLowerCase()) {
      case 'completed':
      case 'success':
        return '#10B981';
      case 'pending':
        return '#F59E0B';
      case 'failed':
        return '#EF4444';
      default:
        return '#6B7280';
    }
  }

  String _getStatusText(EducationHistoryEntity purchase) {
    switch (purchase.status.toLowerCase()) {
      case 'completed':
      case 'success':
        return 'Completed';
      case 'pending':
        return 'Pending';
      case 'failed':
        return 'Failed';
      default:
        return purchase.status.toUpperCase();
    }
  }

  String _formatAmount(double amount) {
    return amount.toStringAsFixed(2);
  }

  bool _hasPins(EducationHistoryEntity purchase) {
    return purchase.pins.isNotEmpty;
  }
}
