import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utils/currency_utils.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/qr_payment_entity.dart';
import '../../domain/entities/qr_transaction_entity.dart';
import '../../domain/repositories/qr_payment_repository.dart';
import '../../utils/qr_unified_mapper.dart';
import 'package:lazervault/src/features/transaction_history/presentation/screens/transaction_detail_screen.dart';

/// Creator's payers view for one QR code: everyone who paid it (a reusable
/// menu-item code accumulates many), with the running total. Each row opens
/// the SAME rich receipt (and PDF/JPG share) the dashboard history uses.
class QRPayersScreen extends StatefulWidget {
  final QRPaymentEntity qrCode;
  const QRPayersScreen({super.key, required this.qrCode});

  @override
  State<QRPayersScreen> createState() => _QRPayersScreenState();
}

class _QRPayersScreenState extends State<QRPayersScreen> {
  List<QRTransactionEntity> _payments = [];
  int _total = 0;
  double _collected = 0;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await serviceLocator<QRPaymentRepository>()
        .getQRPayers(qrId: widget.qrCode.id, limit: 200);
    if (!mounted) return;
    result.fold(
      (f) => setState(() {
        _loading = false;
        _error = f.message;
      }),
      (data) => setState(() {
        _loading = false;
        _payments = data.$1;
        _total = data.$2;
        _collected = data.$3;
      }),
    );
  }

  String get _symbol => CurrencyUtils.getSymbol(widget.qrCode.currency);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Payments received',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w700)),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        color: const Color(0xFF3B82F6),
        backgroundColor: const Color(0xFF1F1F1F),
        child: _loading
            ? const Center(child: LazerVaultLoader.small())
            : _error != null
                ? _message(_error!)
                : Column(
                    children: [
                      _summaryCard(),
                      Expanded(
                        child: _payments.isEmpty
                            ? _message(
                                'No payments yet. Share the QR code — every payment lands here with its own receipt.')
                            : ListView.builder(
                                physics:
                                    const AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.fromLTRB(
                                    16.w, 4.h, 16.w, 16.h),
                                itemCount: _payments.length,
                                itemBuilder: (_, i) =>
                                    _paymentTile(_payments[i]),
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }

  Widget _summaryCard() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.qrCode.description.isNotEmpty
                        ? widget.qrCode.description
                        : widget.qrCode.qrCode,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600)),
                SizedBox(height: 4.h),
                Text(
                    '${widget.qrCode.usageModeLabel} · $_total payment${_total == 1 ? '' : 's'}',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Collected',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
              Text('$_symbol${_collected.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _paymentTile(QRTransactionEntity txn) {
    final fmt = DateFormat('MMM d, h:mm a');
    return GestureDetector(
      onTap: () {
        final viewerId = context.read<AuthenticationCubit>().userId;
        Get.to(() => TransactionDetailScreen(
            transaction: qrTxnToUnified(txn, viewerUserId: viewerId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF262626)),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.14),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  txn.payerName.isNotEmpty
                      ? txn.payerName[0].toUpperCase()
                      : '?',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontWeight: FontWeight.w700,
                      fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      txn.payerName.isNotEmpty
                          ? txn.payerName
                          : '@${txn.payerUsername}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(height: 2.h),
                  Text(fmt.format(txn.createdAt),
                      style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF), fontSize: 11.5.sp)),
                ],
              ),
            ),
            Text('+$_symbol${txn.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right_rounded,
                color: const Color(0xFF4B5563), size: 20.sp),
          ],
        ),
      ),
    );
  }

  Widget _message(String text) => ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.all(40.w),
            child: Text(text,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    height: 1.5)),
          ),
        ],
      );
}
