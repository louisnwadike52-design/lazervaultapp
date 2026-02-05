import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class InsuranceDetailsScreen extends StatefulWidget {
  final Insurance insurance;

  const InsuranceDetailsScreen({
    super.key,
    required this.insurance,
  });

  @override
  State<InsuranceDetailsScreen> createState() => _InsuranceDetailsScreenState();
}

class _InsuranceDetailsScreenState extends State<InsuranceDetailsScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
      late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _tabController = TabController(length: 3, vsync: this);
    
    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        final userId = authState is AuthenticationSuccess 
            ? authState.profile.user.id 
            : 'guest_user';
        
        final cubit = context.read<InsuranceCubit>();
        cubit.setUserId(userId);
      },
      builder: (context, authState) {
        final userId = authState is AuthenticationSuccess 
            ? authState.profile.user.id 
            : 'guest_user';
        
        // Initialize the details screen with the passed insurance data
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final cubit = context.read<InsuranceCubit>();
          cubit.setUserId(userId);
          // Load details using the passed insurance data (only once)
          if (cubit.state is! InsuranceDetailsLoaded || 
              (cubit.state as InsuranceDetailsLoaded).insurance.id != widget.insurance.id) {
            cubit.loadInsuranceDetailsWithData(widget.insurance);
          }
        });
        
        return _buildDetailsScreen();
      },
    );
  }

  Widget _buildDetailsScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: _buildPaymentFAB(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0A0E27),
              const Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<InsuranceCubit, InsuranceState>(
            listener: (context, state) {
              if (state is InsuranceError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.message,
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                    backgroundColor: Colors.red[700],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is InsuranceDetailsLoaded) {
                return _buildDetailsView(state);
              }

              if (state is InsuranceLoading) {
                return _buildLoadingState();
              }

              if (state is InsuranceError) {
                return _buildErrorState(state.message);
              }

              // If no state is loaded yet, show loading while we initialize
              return _buildLoadingState();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetailsView(InsuranceDetailsLoaded state) {
    return Column(
      children: [
        _buildHeader(state.insurance),
        _buildPolicyOverview(state.insurance),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildCoverageTab(state.insurance),
              _buildPaymentsTab(state.payments),
              _buildClaimsTab(state.claims),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Insurance insurance) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insurance.type.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  insurance.provider,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24.sp,
            ),
            color: const Color(0xFF1F1F1F),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'pay',
                child: Row(
                  children: [
                    Icon(Icons.payment, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Make Payment',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'claim',
                child: Row(
                  children: [
                    Icon(Icons.report_problem, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'File Claim',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) => _handleMenuAction(value, insurance),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyOverview(Insurance insurance) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Text(
                    insurance.type.icon,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insurance.policyNumber,
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    _buildStatusBadge(insurance.status),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildOverviewItem('Premium', '\$${insurance.premiumAmount.toStringAsFixed(2)}'),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              Expanded(
                child: _buildOverviewItem('Coverage', '\$${(insurance.coverageAmount / 1000).toStringAsFixed(0)}K'),
              ),
              Container(
                width: 1.w,
                height: 40.h,
                color: Colors.white.withValues(alpha: 0.1),
              ),
              Expanded(
                child: _buildOverviewItem('Expires', '${insurance.daysUntilExpiry} days'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(InsuranceStatus status) {
    Color color;
    switch (status) {
      case InsuranceStatus.active:
        color = const Color(0xFF10B981);
        break;
      case InsuranceStatus.pending:
        color = const Color(0xFFF59E0B);
        break;
      case InsuranceStatus.expired:
        color = const Color(0xFFEF4444);
        break;
      case InsuranceStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
      case InsuranceStatus.suspended:
        color = const Color(0xFF8B5CF6);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        tabs: const [
          Tab(text: 'Coverage'),
          Tab(text: 'Payments'),
          Tab(text: 'Claims'),
        ],
      ),
    );
  }

  Widget _buildCoverageTab(Insurance insurance) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoverageSection('Policy Holder Information', [
            _buildInfoRow('Name', insurance.policyHolderName),
            _buildInfoRow('Email', insurance.policyHolderEmail),
            _buildInfoRow('Phone', insurance.policyHolderPhone),
          ]),
          SizedBox(height: 24.h),
          _buildCoverageSection('Coverage Details', [
            _buildInfoRow('Deductible', '\$${insurance.coverageDetails['deductible']?.toStringAsFixed(2) ?? '0.00'}'),
            _buildInfoRow('Coverage Limit', '\$${insurance.coverageDetails['coverage_limit']?.toStringAsFixed(2) ?? '0.00'}'),
            _buildInfoRow('Currency', insurance.currency),
          ]),
          SizedBox(height: 24.h),
          _buildCoverageSection('Policy Dates', [
            _buildInfoRow('Start Date', '${insurance.startDate.day}/${insurance.startDate.month}/${insurance.startDate.year}'),
            _buildInfoRow('End Date', '${insurance.endDate.day}/${insurance.endDate.month}/${insurance.endDate.year}'),
            _buildInfoRow('Next Payment', '${insurance.nextPaymentDate.day}/${insurance.nextPaymentDate.month}/${insurance.nextPaymentDate.year}'),
          ]),
          if (insurance.beneficiaries.isNotEmpty) ...[
            SizedBox(height: 24.h),
            _buildBeneficiariesSection(insurance.beneficiaries),
          ],
          if (insurance.coverageDetails['features'] != null) ...[
            SizedBox(height: 24.h),
            _buildFeaturesSection(List<String>.from(insurance.coverageDetails['features'])),
          ],
          if (insurance.description != null) ...[
            SizedBox(height: 24.h),
            _buildDescriptionSection(insurance.description!),
          ],
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Widget _buildCoverageSection(String title, List<Widget> children) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBeneficiariesSection(List<String> beneficiaries) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beneficiaries',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: beneficiaries.map((beneficiary) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
                ),
                child: Text(
                  beneficiary,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF6366F1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(List<String> features) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Features',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: features.map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                ),
                child: Text(
                  feature,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection(String description) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab(List<InsurancePayment> payments) {
    if (payments.isEmpty) {
      return _buildEmptyPayments();
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: payments.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildPaymentCard(payments[index]),
    );
  }

  Widget _buildPaymentCard(InsurancePayment payment) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                payment.paymentMethod.displayName,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              _buildPaymentStatusBadge(payment.status),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                '\$${payment.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                '${payment.paymentDate.day}/${payment.paymentDate.month}/${payment.paymentDate.year}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          if (payment.transactionId != null) ...[
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transaction ID',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                                 Text(
                   payment.transactionId!,
                   style: GoogleFonts.inter(
                     fontSize: 14.sp,
                     color: Colors.white,
                   ),
                 ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPaymentStatusBadge(PaymentStatus status) {
    Color color;
    switch (status) {
      case PaymentStatus.completed:
        color = const Color(0xFF10B981);
        break;
      case PaymentStatus.pending:
        color = const Color(0xFFF59E0B);
        break;
      case PaymentStatus.failed:
        color = const Color(0xFFEF4444);
        break;
      case PaymentStatus.processing:
        color = const Color(0xFF6366F1);
        break;
      case PaymentStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
      case PaymentStatus.refunded:
        color = const Color(0xFF8B5CF6);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyPayments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment,
            size: 64.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Payments',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No payment history available for this policy',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClaimsTab(List<InsuranceClaim> claims) {
    if (claims.isEmpty) {
      return _buildEmptyClaims();
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: claims.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildClaimCard(claims[index]),
    );
  }

  Widget _buildClaimCard(InsuranceClaim claim) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                claim.title,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              _buildClaimStatusBadge(claim.status),
            ],
          ),
          SizedBox(height: 8.h),
                     Text(
             claim.claimNumber,
             style: GoogleFonts.inter(
               fontSize: 12.sp,
               color: const Color(0xFF9CA3AF),
             ),
           ),
          SizedBox(height: 12.h),
          Text(
            claim.description,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.4,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Claim Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                '\$${claim.claimAmount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Incident Date',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              Text(
                '${claim.incidentDate.day}/${claim.incidentDate.month}/${claim.incidentDate.year}',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClaimStatusBadge(ClaimStatus status) {
    Color color;
    switch (status) {
      case ClaimStatus.approved:
        color = const Color(0xFF10B981);
        break;
      case ClaimStatus.submitted:
        color = const Color(0xFF6366F1);
        break;
      case ClaimStatus.underReview:
        color = const Color(0xFFF59E0B);
        break;
      case ClaimStatus.rejected:
        color = const Color(0xFFEF4444);
        break;
      case ClaimStatus.settled:
        color = const Color(0xFF8B5CF6);
        break;
      case ClaimStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 10.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyClaims() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.report_problem_outlined,
            size: 64.sp,
            color: const Color(0xFF6366F1),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Claims',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No claims have been filed for this policy',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF6366F1)),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading policy details...',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
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
            size: 64.sp,
            color: Colors.red[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Error Loading Policy',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentFAB() {
    return BlocBuilder<InsuranceCubit, InsuranceState>(
      builder: (context, state) {
        if (state is InsuranceDetailsLoaded) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1),
                  const Color(0xFF8B5CF6),
                ],
              ),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: FloatingActionButton.extended(
              onPressed: () => Get.toNamed(AppRoutes.insurancePayment, arguments: state.insurance),
              backgroundColor: Colors.transparent,
              elevation: 0,
              icon: Icon(
                Icons.payment,
                color: Colors.white,
                size: 20.sp,
              ),
              label: Text(
                'Pay Premium',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _handleMenuAction(String action, Insurance insurance) {
    switch (action) {
      case 'pay':
        Get.toNamed(AppRoutes.insurancePayment, arguments: insurance);
        break;
      case 'claim':
        Get.toNamed(AppRoutes.createClaim, arguments: insurance.id);
        break;
    }
  }
} 