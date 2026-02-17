import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_transaction_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';
import '../widgets/id_pay_status_badge.dart';

class IDPayDetailsScreen extends StatefulWidget {
  const IDPayDetailsScreen({super.key});

  @override
  State<IDPayDetailsScreen> createState() => _IDPayDetailsScreenState();
}

class _IDPayDetailsScreenState extends State<IDPayDetailsScreen> {
  late IDPayEntity _idPay;
  List<IDPayTransactionEntity> _transactions = [];
  bool _transactionsLoaded = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _idPay = args['idPay'] as IDPayEntity;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IDPayCubit>().getIDPayTransactions(payId: _idPay.payId);
    });
  }

  void _cancelIDPay() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Cancel IDPay',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to cancel this IDPay? This action cannot be undone.',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'No, Keep It',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<IDPayCubit>().cancelIDPay(id: _idPay.id);
            },
            child: Text(
              'Yes, Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<IDPayCubit, IDPayState>(
      listener: (context, state) {
        if (state is IDPayTransactionsLoaded) {
          setState(() {
            _transactions = state.transactions;
            _transactionsLoaded = true;
          });
        } else if (state is IDPayCancelled) {
          Get.snackbar(
            'Cancelled',
            'IDPay has been cancelled successfully',
            backgroundColor: const Color(0xFF10B981),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
          Get.offAllNamed(AppRoutes.idPayHome);
        } else if (state is IDPayDetailsLoaded) {
          setState(() {
            _idPay = state.idPay;
          });
        } else if (state is IDPayError) {
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
              'IDPay Details',
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
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPayIDCard(),
                        SizedBox(height: 24.h),
                        _buildInfoSection(),
                        SizedBox(height: 24.h),
                        _buildTransactionsSection(state),
                      ],
                    ),
                  ),
                ),
                if (_idPay.isActive) _buildCancelButton(state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPayIDCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IDPayStatusBadge(status: _idPay.status),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            'PayID Code',
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            _idPay.displayPayId,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildActionChip(
                icon: Icons.copy,
                label: 'Copy',
                onTap: () {
                  Clipboard.setData(ClipboardData(text: _idPay.displayPayId));
                  Get.snackbar(
                    'Copied',
                    'PayID code copied to clipboard',
                    backgroundColor: const Color(0xFF10B981),
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                    margin: EdgeInsets.all(16.w),
                    duration: const Duration(seconds: 2),
                  );
                },
              ),
              SizedBox(width: 16.w),
              _buildActionChip(
                icon: Icons.share,
                label: 'Share',
                onTap: () {
                  Share.share(
                    'Pay me using IDPay: ${_idPay.displayPayId}\n\n${_idPay.description.isNotEmpty ? _idPay.description : "Send payment via LazerVault"}',
                    subject: 'IDPay Payment Request',
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 18.sp),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          _buildInfoRow('Status', _idPay.status.displayName),
          SizedBox(height: 12.h),
          _buildInfoRow('Type', _idPay.type.displayName),
          SizedBox(height: 12.h),
          _buildInfoRow('Amount Mode', _idPay.amountMode.displayName),
          SizedBox(height: 12.h),
          if (_idPay.isFixed) ...[
            _buildInfoRow(
              'Amount',
              '${_currencySymbol(_idPay.currency)}${_idPay.amount.toStringAsFixed(2)}',
            ),
          ] else ...[
            if (_idPay.minAmount > 0) ...[
              _buildInfoRow(
                'Min Amount',
                '${_currencySymbol(_idPay.currency)}${_idPay.minAmount.toStringAsFixed(2)}',
              ),
              SizedBox(height: 12.h),
            ],
            if (_idPay.maxAmount > 0) ...[
              _buildInfoRow(
                'Max Amount',
                '${_currencySymbol(_idPay.currency)}${_idPay.maxAmount.toStringAsFixed(2)}',
              ),
              SizedBox(height: 12.h),
            ],
            if (_idPay.minAmount <= 0 && _idPay.maxAmount <= 0) ...[
              _buildInfoRow('Amount', 'Any amount'),
              SizedBox(height: 12.h),
            ],
          ],
          _buildInfoRow(
            'Total Received',
            '${_currencySymbol(_idPay.currency)}${_idPay.totalReceived.toStringAsFixed(2)}',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Payment Count',
            '${_idPay.paymentCount}',
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Created',
            _formatDateTime(_idPay.createdAt),
          ),
          SizedBox(height: 12.h),
          _buildInfoRow(
            'Expires',
            _idPay.neverExpires
                ? 'Never'
                : _formatDateTime(_idPay.expiresAt),
          ),
          if (_idPay.description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            _buildInfoRow('Description', _idPay.description),
          ],
        ],
      ),
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

  Widget _buildTransactionsSection(IDPayState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transactions',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        if (!_transactionsLoaded && state is IDPayLoading) ...[
          Center(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            ),
          ),
        ] else if (_transactions.isEmpty) ...[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.receipt_long_outlined,
                  size: 36.sp,
                  color: const Color(0xFF6B7280),
                ),
                SizedBox(height: 12.h),
                Text(
                  'No Transactions Yet',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ] else ...[
          ..._transactions.map((tx) => _buildTransactionItem(tx)),
        ],
      ],
    );
  }

  Widget _buildTransactionItem(IDPayTransactionEntity transaction) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(22.r),
            ),
            child: Icon(
              Icons.arrow_downward,
              color: const Color(0xFF10B981),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.payerName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '@${transaction.payerUsername}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+${_currencySymbol(transaction.currency)}${transaction.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                _formatShortDate(transaction.createdAt),
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCancelButton(IDPayState state) {
    final isLoading = state is IDPayLoading;
    return Container(
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
        child: OutlinedButton(
          onPressed: isLoading ? null : _cancelIDPay,
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFFEF4444),
            side: const BorderSide(color: Color(0xFFEF4444)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFFEF4444)),
                  ),
                )
              : Text(
                  'Cancel IDPay',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatShortDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';
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
