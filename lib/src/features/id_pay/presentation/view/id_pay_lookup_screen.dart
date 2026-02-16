import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/types/app_routes.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';
import '../widgets/id_pay_status_badge.dart';

class IDPayLookupScreen extends StatefulWidget {
  const IDPayLookupScreen({super.key});

  @override
  State<IDPayLookupScreen> createState() => _IDPayLookupScreenState();
}

class _IDPayLookupScreenState extends State<IDPayLookupScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['payId'] != null) {
      final payId = args['payId'] as String;
      _searchController.text = payId;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _onSearch(payId);
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch(String payId) {
    final trimmed = payId.trim();
    if (trimmed.isEmpty) return;
    setState(() => _hasSearched = true);
    context.read<IDPayCubit>().lookupIDPay(payId: trimmed);
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
            size: 24.sp,
          ),
        ),
        title: Text(
          'Lookup PayID',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: TextField(
                controller: _searchController,
                textCapitalization: TextCapitalization.characters,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter PayID code',
                  hintStyle: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 16.sp,
                  ),
                  prefixText: 'PAY-',
                  prefixStyle: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () => _onSearch(_searchController.text),
                    child: Container(
                      margin: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1F1F1F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                ),
                onSubmitted: _onSearch,
              ),
            ),
            Expanded(
              child: _hasSearched ? _buildResult() : _buildInitialState(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.qr_code_scanner,
              size: 36.sp,
              color: const Color(0xFF6B7280),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Enter a PayID to get started',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    return BlocConsumer<IDPayCubit, IDPayState>(
      listener: (context, state) {
        if (state is IDPayError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      builder: (context, state) {
        if (state is IDPayLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          );
        }

        if (state is IDPayLookedUp) {
          return _buildIDPayResultCard(state.idPay);
        }

        if (state is IDPayError) {
          return _buildNotFoundState();
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildIDPayResultCard(IDPayEntity idPay) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 52.w,
                        height: 52.w,
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF3B82F6).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(26.r),
                        ),
                        child: Center(
                          child: Text(
                            idPay.creatorName.isNotEmpty
                                ? idPay.creatorName[0].toUpperCase()
                                : '?',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 22.sp,
                              fontWeight: FontWeight.w700,
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
                              idPay.creatorName,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '@${idPay.creatorUsername}',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IDPayStatusBadge(status: idPay.status),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Divider(color: const Color(0xFF2D2D2D), height: 1.h),
                  SizedBox(height: 20.h),
                  _buildInfoRow(
                    'Amount',
                    idPay.isFixed
                        ? '${_currencySymbol(idPay.currency)}${idPay.amount.toStringAsFixed(2)}'
                        : 'Flexible',
                  ),
                  if (idPay.isFlexible && idPay.minAmount > 0) ...[
                    SizedBox(height: 12.h),
                    _buildInfoRow(
                      'Min',
                      '${_currencySymbol(idPay.currency)}${idPay.minAmount.toStringAsFixed(2)}',
                    ),
                  ],
                  if (idPay.isFlexible && idPay.maxAmount > 0) ...[
                    SizedBox(height: 12.h),
                    _buildInfoRow(
                      'Max',
                      '${_currencySymbol(idPay.currency)}${idPay.maxAmount.toStringAsFixed(2)}',
                    ),
                  ],
                  SizedBox(height: 12.h),
                  _buildInfoRow('Currency', idPay.currency),
                  if (idPay.description.isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildInfoRow('Description', idPay.description),
                  ],
                  SizedBox(height: 12.h),
                  _buildInfoRow('Status', idPay.status.displayName),
                  SizedBox(height: 12.h),
                  _buildInfoRow(
                    'Expires',
                    _formatExpiryCountdown(idPay.expiresAt),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (idPay.isActive)
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed('/id-pay/payment', arguments: {'idPay': idPay});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Pay Now',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 16.w),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotFoundState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEF4444).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(36.r),
            ),
            child: Icon(
              Icons.search_off,
              size: 32.sp,
              color: const Color(0xFFEF4444),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'PayID Not Found',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please check the code and try again',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  String _formatExpiryCountdown(DateTime expiresAt) {
    final now = DateTime.now();
    final diff = expiresAt.difference(now);

    if (diff.isNegative) return 'Expired';
    if (diff.inDays > 0) return '${diff.inDays}d ${diff.inHours % 24}h remaining';
    if (diff.inHours > 0) return '${diff.inHours}h ${diff.inMinutes % 60}m remaining';
    return '${diff.inMinutes}m remaining';
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
  }
}
