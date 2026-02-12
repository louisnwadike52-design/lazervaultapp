import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';

import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class InsurancePolicyDetailView extends StatefulWidget {
  final Insurance insurance;

  const InsurancePolicyDetailView({
    super.key,
    required this.insurance,
  });

  @override
  State<InsurancePolicyDetailView> createState() => _InsurancePolicyDetailViewState();
}

class _InsurancePolicyDetailViewState extends State<InsurancePolicyDetailView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InsuranceCubit>().loadInsuranceDetailsWithData(widget.insurance);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Policy Details',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Text(
              widget.insurance.policyNumber,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF6366F1),
          labelColor: const Color(0xFF6366F1),
          unselectedLabelColor: const Color(0xFF9CA3AF),
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(text: 'Coverage'),
            Tab(text: 'Payments'),
            Tab(text: 'Claims'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCoverageTab(),
          _buildPaymentsTab(),
          _buildClaimsTab(),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _tabController,
        builder: (context, _) {
          if (_tabController.index == 2) {
            return FloatingActionButton.extended(
              onPressed: () => Get.toNamed(AppRoutes.createClaim, arguments: widget.insurance.id),
              backgroundColor: const Color(0xFF6366F1),
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'File Claim',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            );
          }
          return FloatingActionButton.extended(
            onPressed: () {
              Get.toNamed(
                AppRoutes.insuranceEdit,
                arguments: widget.insurance,
              );
            },
            backgroundColor: const Color(0xFF6366F1),
            icon: const Icon(Icons.edit, color: Colors.white),
            label: Text(
              'Edit Policy',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoverageTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyOverviewCard(),
          SizedBox(height: 20.h),
          _buildSectionHeader('Policy Holder Information'),
          SizedBox(height: 12.h),
          _buildPolicyHolderInfo(),
          SizedBox(height: 20.h),
          _buildSectionHeader('Coverage Details'),
          SizedBox(height: 12.h),
          _buildCoverageDetails(),
          SizedBox(height: 20.h),
          _buildSectionHeader('Policy Dates'),
          SizedBox(height: 12.h),
          _buildPolicyDates(),
          SizedBox(height: 20.h),
          if (widget.insurance.beneficiaries.isNotEmpty) ...[
            _buildSectionHeader('Beneficiaries'),
            SizedBox(height: 12.h),
            _buildBeneficiaries(),
            SizedBox(height: 20.h),
          ],
          _buildSectionHeader('Features'),
          SizedBox(height: 12.h),
          _buildFeatures(),
          SizedBox(height: 20.h),
          _buildOptionalFieldsSection(),
          SizedBox(height: 80.h), // Space for FAB
        ],
      ),
    );
  }

  Widget _buildPaymentsTab() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          );
        }

        if (state is InsuranceDetailsLoaded) {
          final payments = state.payments;
          if (payments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.payment,
                    size: 80.sp,
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No payments recorded',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Payment history will appear here',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            );
          }

          final dateFormat = DateFormat('MMM dd, yyyy');
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index];
              return _buildPaymentCard(payment, dateFormat);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPaymentCard(InsurancePayment payment, DateFormat dateFormat) {
    Color statusColor;
    switch (payment.status) {
      case PaymentStatus.completed:
        statusColor = const Color(0xFF10B981);
        break;
      case PaymentStatus.pending:
      case PaymentStatus.processing:
        statusColor = const Color(0xFFFBBF24);
        break;
      case PaymentStatus.failed:
        statusColor = const Color(0xFFEF4444);
        break;
      case PaymentStatus.cancelled:
      case PaymentStatus.refunded:
        statusColor = const Color(0xFF6B7280);
        break;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              payment.paymentMethod.icon,
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${payment.amount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  dateFormat.format(payment.paymentDate),
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              payment.status.displayName,
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsTab() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          );
        }

        if (state is InsuranceDetailsLoaded) {
          final claims = state.claims;
          if (claims.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.description_outlined,
                    size: 80.sp,
                    color: const Color(0xFF9CA3AF).withValues(alpha: 0.3),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No claims filed',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'File a claim if you need to',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.createClaim, arguments: widget.insurance.id),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'File a Claim',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          final dateFormat = DateFormat('MMM dd, yyyy');
          return ListView.builder(
            padding: EdgeInsets.all(20.w),
            itemCount: claims.length,
            itemBuilder: (context, index) {
              final claim = claims[index];
              return _buildClaimCard(claim, dateFormat);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildClaimCard(InsuranceClaim claim, DateFormat dateFormat) {
    Color statusColor;
    switch (claim.status) {
      case ClaimStatus.submitted:
        statusColor = const Color(0xFF6366F1);
        break;
      case ClaimStatus.underReview:
        statusColor = const Color(0xFFFB923C);
        break;
      case ClaimStatus.approved:
        statusColor = const Color(0xFF10B981);
        break;
      case ClaimStatus.rejected:
        statusColor = const Color(0xFFEF4444);
        break;
      case ClaimStatus.settled:
        statusColor = const Color(0xFF8B5CF6);
        break;
      case ClaimStatus.cancelled:
        statusColor = const Color(0xFF6B7280);
        break;
    }

    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceClaimTracking, arguments: claim),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.description,
                color: statusColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    claim.title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${claim.claimNumber} • ${dateFormat.format(claim.createdAt)}',
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
                Text(
                  '${claim.currency} ${claim.claimAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    claim.status.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyOverviewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.insurance.type.icon,
                style: TextStyle(fontSize: 32.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.insurance.type.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.insurance.provider,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(widget.insurance.status),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.white.withValues(alpha: 0.3)),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Premium',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${widget.insurance.premiumAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coverage',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '\$${widget.insurance.coverageAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(InsuranceStatus status) {
    Color color;
    switch (status) {
      case InsuranceStatus.active:
        color = const Color(0xFF10B981);
        break;
      case InsuranceStatus.pending:
        color = const Color(0xFFFBBF24);
        break;
      case InsuranceStatus.expired:
        color = const Color(0xFFEF4444);
        break;
      case InsuranceStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
      case InsuranceStatus.suspended:
        color = const Color(0xFFF97316);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: color,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildPolicyHolderInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow('Name', widget.insurance.policyHolderName, Icons.person),
          SizedBox(height: 12.h),
          _buildDetailRow('Email', widget.insurance.policyHolderEmail, Icons.email),
          SizedBox(height: 12.h),
          _buildDetailRow('Phone', widget.insurance.policyHolderPhone, Icons.phone),
        ],
      ),
    );
  }

  Widget _buildCoverageDetails() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Premium Amount',
            '\$${widget.insurance.premiumAmount.toStringAsFixed(2)}',
            Icons.attach_money,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Coverage Amount',
            '\$${widget.insurance.coverageAmount.toStringAsFixed(2)}',
            Icons.account_balance_wallet,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Currency',
            widget.insurance.currency,
            Icons.monetization_on,
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyDates() {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Start Date',
            dateFormat.format(widget.insurance.startDate),
            Icons.calendar_today,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'End Date',
            dateFormat.format(widget.insurance.endDate),
            Icons.event,
          ),
          SizedBox(height: 12.h),
          _buildDetailRow(
            'Next Payment Date',
            dateFormat.format(widget.insurance.nextPaymentDate),
            Icons.payment,
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiaries() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: widget.insurance.beneficiaries.map((beneficiary) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF6366F1).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 14.sp,
                  color: const Color(0xFF6366F1),
                ),
                SizedBox(width: 6.w),
                Text(
                  beneficiary,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildFeatures() {
    final features = widget.insurance.coverageDetails['features'] as List? ?? [];

    if (features.isEmpty) {
      return Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          'No features listed',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: features.map((feature) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  size: 14.sp,
                  color: const Color(0xFF10B981),
                ),
                SizedBox(width: 6.w),
                Text(
                  feature.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOptionalFieldsSection() {
    final coverageDetails = widget.insurance.coverageDetails;
    bool hasOptionalFields = false;
    List<Widget> fieldWidgets = [];

    // Check and display deductible
    if (coverageDetails.containsKey('deductible')) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Deductible',
        '\$${(coverageDetails['deductible'] as num).toStringAsFixed(2)}',
        Icons.attach_money,
      ));
      fieldWidgets.add(SizedBox(height: 12.h));
    }

    // Check and display coverage limit
    if (coverageDetails.containsKey('coverage_limit')) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Coverage Limit',
        '\$${(coverageDetails['coverage_limit'] as num).toStringAsFixed(2)}',
        Icons.trending_up,
      ));
      fieldWidgets.add(SizedBox(height: 12.h));
    }

    // Check and display description
    if (widget.insurance.description != null && widget.insurance.description!.isNotEmpty) {
      hasOptionalFields = true;
      fieldWidgets.add(_buildDetailRow(
        'Description',
        widget.insurance.description!,
        Icons.description,
      ));
    }

    if (!hasOptionalFields) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Additional Information'),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            children: fieldWidgets,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 18.sp,
            color: const Color(0xFF6366F1),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
