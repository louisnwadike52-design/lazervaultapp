// User-facing insurance purchase detail screen.
//
// Loads live MyCover purchase by id via repository.getMyCoverPurchaseById,
// renders premium + product + provider + policy info + a "View Certificate"
// button when the policy has a certificate URL.
//
// Edge cases handled:
//   * empty certificate URL → button disabled with hint text
//   * RPC failure → error state with retry
//   * Missing purchase id arg → guarded with error message

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/services/injection_container.dart';
import '../../domain/entities/mycover_management_entities.dart';
import '../../domain/repositories/insurance_repository.dart';

class PurchaseDetailUserScreen extends StatefulWidget {
  final String purchaseId;
  const PurchaseDetailUserScreen({super.key, required this.purchaseId});

  @override
  State<PurchaseDetailUserScreen> createState() => _PurchaseDetailUserScreenState();
}

class _PurchaseDetailUserScreenState extends State<PurchaseDetailUserScreen> {
  Future<MyCoverPurchase>? _future;

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() {
    setState(() {
      _future = serviceLocator<InsuranceRepository>()
          .getMyCoverPurchaseById(widget.purchaseId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Purchase Detail',
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: FutureBuilder<MyCoverPurchase>(
        future: _future,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF6366F1)),
            );
          }
          if (snap.hasError || !snap.hasData) {
            return _buildError(snap.error?.toString());
          }
          return _buildBody(snap.data!);
        },
      ),
    );
  }

  Widget _buildError(String? msg) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, size: 48.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text("Couldn't load purchase",
                style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF9CA3AF),
                )),
            if (msg != null) ...[
              SizedBox(height: 6.h),
              Text(msg, textAlign: TextAlign.center,
                  style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF6B7280))),
            ],
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: _fetch,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Try Again',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(MyCoverPurchase p) {
    final amount = double.tryParse(p.amount) ?? 0;
    final policyAmount = double.tryParse(p.policyAmount) ?? 0;
    return RefreshIndicator(
      onRefresh: () async {
        _fetch();
        // FutureBuilder rebuilds on _future swap.
        await _future;
      },
      color: const Color(0xFF6366F1),
      backgroundColor: const Color(0xFF1F1F1F),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero card
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(p.productName.isNotEmpty ? p.productName : 'Insurance purchase',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      )),
                  if (p.providerName.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(p.providerName,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: const Color(0xFF9CA3AF),
                        )),
                  ],
                  SizedBox(height: 12.h),
                  Text(
                    NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2)
                        .format(amount),
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  if (p.isRenewal) ...[
                    SizedBox(height: 4.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text('Renewal',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFB923C),
                          )),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Details card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Column(
                children: [
                  _row('Policy number', p.policyNumber),
                  if (p.policyAmount.isNotEmpty)
                    _row('Sum insured',
                        NumberFormat.currency(locale: 'en_NG', symbol: '₦', decimalDigits: 2)
                            .format(policyAmount)),
                  _row('Category', p.productCategoryName),
                  _row('Payment option', p.paymentOption),
                  _row('Active', p.policyIsActive ? 'Yes' : 'No'),
                  _row('Created', _fmtIso(p.createdAt)),
                ],
              ),
            ),

            SizedBox(height: 16.h),
            // Certificate CTA
            if (p.certificateUrl.isNotEmpty)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final uri = Uri.tryParse(p.certificateUrl);
                    if (uri != null) {
                      await launchUrl(uri, mode: LaunchMode.externalApplication);
                    }
                  },
                  icon: Icon(Icons.description_outlined, color: Colors.white, size: 18.sp),
                  label: Text('View Certificate',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: Center(
                  child: Text(
                    'Certificate not available yet',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(label,
                style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
          ),
          Expanded(
            child: Text(value,
                style: GoogleFonts.inter(fontSize: 13.sp, color: Colors.white, fontWeight: FontWeight.w500),
                textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  String _fmtIso(String iso) {
    if (iso.isEmpty) return '';
    try {
      return DateFormat('dd MMM yyyy, HH:mm').format(DateTime.parse(iso));
    } catch (_) {
      return iso;
    }
  }
}
