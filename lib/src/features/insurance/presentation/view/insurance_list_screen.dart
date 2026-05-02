import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/cache/swr_cache_manager.dart';
import 'package:lazervault/core/offline/mutation_queue.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../cubit/create_policy_cubit.dart';
import '../widgets/insurance_voice_agent_button.dart';
import 'create_insurance_policy_carousel.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

class InsuranceListScreen extends StatefulWidget {
  const InsuranceListScreen({super.key});

  @override
  State<InsuranceListScreen> createState() => _InsuranceListScreenState();
}

class _InsuranceListScreenState extends State<InsuranceListScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

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
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();

    // Initialize userId once on mount
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthenticationCubit>().state;
      final userId = authState is AuthenticationSuccess
          ? authState.profile.user.id
          : 'guest_user';
      context.read<InsuranceCubit>().setUserId(userId);
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, authState) {
        // Handle auth state changes (e.g., re-login)
        final userId = authState is AuthenticationSuccess
            ? authState.profile.user.id
            : 'guest_user';
        context.read<InsuranceCubit>().setUserId(userId);
      },
      builder: (context, authState) {
        return _buildInsuranceScreen();
      },
    );
  }

  Widget _buildInsuranceScreen() {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
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
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: BlocConsumer<InsuranceCubit, InsuranceState>(
                      listener: (context, state) {
                        // Show snackbar only for transient errors (when there's already data showing)
                        // Don't show snackbar for errors that have their own full-screen error state
                        if (state is InsuranceError) {
                          // The builder below will show the error state inline
                          // No need for a duplicate snackbar
                        }
                        if (state is InsuranceCreated || state is InsuranceUpdated || state is InsuranceDeleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Operation successful',
                                style: GoogleFonts.inter(color: Colors.white)),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is InsuranceLoading) {
                          return _buildLoadingState();
                        }

                        if (state is InsurancesLoaded) {
                          return _buildInsurancesView(state);
                        }

                        if (state is InsuranceError) {
                          return _buildErrorState(state.message);
                        }

                        return _buildEmptyState();
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InsuranceVoiceAgentButton(
            accessToken: _getAccessToken(),
            onConnected: () {
              // Optional: Handle connection
            },
            onDisconnected: () {
              // Optional: Handle disconnection
            },
          ),
          SizedBox(height: 16.h),
          _buildFAB(),
        ],
      ),
    );
  }

  String? _getAccessToken() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      return authState.profile.session.accessToken;
    }
    return null;
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18.r),
              ),
              child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              'Insurance',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ServiceVoiceButton(serviceName: 'insurance'),
          SizedBox(width: 6.w),
          MicroserviceChatIcon(serviceName: 'Insurance', sourceContext: 'insurance'),
          SizedBox(width: 6.w),
          _buildHeaderIcon(Icons.help_outline, () => Get.toNamed(AppRoutes.insuranceFaq)),
          SizedBox(width: 6.w),
          _buildHeaderIcon(Icons.menu_book_outlined, () => Get.toNamed(AppRoutes.insuranceGuide)),
          SizedBox(width: 6.w),
          _buildHeaderIcon(Icons.settings_outlined, () => Get.toNamed(AppRoutes.insuranceManagement)),
        ],
      ),
    );
  }

  Widget _buildHeaderIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Icon(icon, color: Colors.white70, size: 16.sp),
      ),
    );
  }

  Widget _buildInsurancesView(InsurancesLoaded state) {
    final activePolicies = state.insurances.where((i) => i.status == InsuranceStatus.active).toList();
    final pendingPolicies = state.insurances.where((i) => i.status == InsuranceStatus.pending).toList();
    final expiredPolicies = state.insurances.where((i) => i.status == InsuranceStatus.expired).toList();

    return RefreshIndicator(
      onRefresh: () async => context.read<InsuranceCubit>().loadInsurances(),
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF6366F1),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Compact stat row
            _buildCompactStats(state.statistics, state.insurances.length),
            SizedBox(height: 16.h),

            // Quick status filters
            _buildStatusChips(activePolicies.length, pendingPolicies.length, expiredPolicies.length),
            SizedBox(height: 20.h),

            // Policies preview (max 3) with View All
            _buildSectionHeader('Your Policies', state.insurances.length),
            SizedBox(height: 10.h),
            _buildInsurancesList(state.insurances.take(3).toList()),
            if (state.insurances.length > 3) ...[
              SizedBox(height: 8.h),
              _buildViewAllButton('View All ${state.insurances.length} Policies', null),
            ],
            SizedBox(height: 20.h),

            // Recent activity section
            _buildRecentActivity(state.insurances),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCompactStats(Map<String, dynamic> statistics, int totalPolicies) {
    final activePolicies = statistics['activePolicies'] ?? 0;
    final totalCoverage = (statistics['totalCoverageAmount'] ?? 0.0) as double;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F35).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          _buildCompactStatItem(Icons.shield_outlined, '$activePolicies', 'Active', const Color(0xFF10B981)),
          _buildStatDivider(),
          _buildCompactStatItem(Icons.policy_outlined, '$totalPolicies', 'Total', const Color(0xFF6366F1)),
          _buildStatDivider(),
          _buildCompactStatItem(Icons.account_balance_outlined,
            totalCoverage >= 1000 ? '\$${(totalCoverage / 1000).toStringAsFixed(0)}K' : '\$${totalCoverage.toStringAsFixed(0)}',
            'Coverage', const Color(0xFFFB923C)),
        ],
      ),
    );
  }

  Widget _buildCompactStatItem(IconData icon, String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(height: 4.h),
          Text(value, style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          Text(label, style: GoogleFonts.inter(fontSize: 10.sp, color: const Color(0xFF9CA3AF))),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(width: 1, height: 36.h, color: Colors.white.withValues(alpha: 0.08));
  }

  Widget _buildStatusChips(int active, int pending, int expired) {
    return SizedBox(
      height: 32.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          if (active > 0) _buildChip('Active ($active)', const Color(0xFF10B981), 'active'),
          if (pending > 0) _buildChip('Pending ($pending)', const Color(0xFFF59E0B), 'pending'),
          if (expired > 0) _buildChip('Expired ($expired)', const Color(0xFFEF4444), 'expired'),
          _buildChip('View All', const Color(0xFF6366F1), null),
        ],
      ),
    );
  }

  Widget _buildChip(String label, Color color, String? filterStatus) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceAllPolicies, arguments: filterStatus),
      child: Container(
        margin: EdgeInsets.only(right: 8.w),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Text(label, style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color)),
      ),
    );
  }

  Widget _buildViewAllButton(String text, String? filter) {
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.insuranceAllPolicies, arguments: filter),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: const Color(0xFF6366F1).withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(text, style: GoogleFonts.inter(
            fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6366F1))),
        ),
      ),
    );
  }

  Widget _buildRecentActivity(List<Insurance> insurances) {
    // Show overdue, expiring soon, or recently added
    final now = DateTime.now();
    final expiringSoon = insurances
        .where((i) => i.status == InsuranceStatus.active && i.daysUntilExpiry <= 30 && i.daysUntilExpiry > 0)
        .toList();
    final paymentDue = insurances.where((i) => i.isPaymentDue).toList();
    final recentlyAdded = insurances.where((i) =>
        now.difference(i.createdAt).inDays <= 7).toList();

    if (expiringSoon.isEmpty && paymentDue.isEmpty && recentlyAdded.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Activity & Alerts', style: GoogleFonts.inter(
          fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
        SizedBox(height: 10.h),

        // Payment due alerts
        ...paymentDue.map((i) => _buildActivityTile(
          Icons.payment,
          'Payment Due',
          '${i.type.displayName} - ${i.policyNumber}',
          const Color(0xFFF59E0B),
          i,
        )),

        // Expiring soon alerts
        ...expiringSoon.map((i) => _buildActivityTile(
          Icons.timer_outlined,
          'Expiring in ${i.daysUntilExpiry} days',
          '${i.type.displayName} - ${i.provider}',
          const Color(0xFFEF4444),
          i,
        )),

        // Recently added
        ...recentlyAdded.take(2).map((i) => _buildActivityTile(
          Icons.new_releases_outlined,
          'New Policy',
          '${i.type.displayName} - ${i.provider}',
          const Color(0xFF10B981),
          i,
        )),
      ],
    );
  }

  Widget _buildActivityTile(IconData icon, String title, String subtitle, Color color, Insurance insurance) {
    return GestureDetector(
      onTap: () => _navigateToInsuranceDetails(insurance),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: color.withValues(alpha: 0.15)),
        ),
        child: Row(
          children: [
            Container(
              width: 36.w, height: 36.w,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: color, size: 18.sp),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: color)),
                  Text(subtitle, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
          ),
          child: Text(
            '$count ${count == 1 ? 'policy' : 'policies'}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInsurancesList(List<Insurance> insurances) {
    if (insurances.isEmpty) {
      return _buildEmptyInsurances();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: insurances.length,
      separatorBuilder: (context, index) => SizedBox(height: 10.h),
      itemBuilder: (context, index) => _buildInsuranceCard(insurances[index]),
    );
  }

  Widget _buildInsuranceCard(Insurance insurance) {
    return GestureDetector(
      onTap: () => _navigateToInsuranceDetails(insurance),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Container(
              width: 42.w,
              height: 42.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: Text(insurance.type.icon, style: TextStyle(fontSize: 18.sp))),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(insurance.type.displayName,
                          style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      _buildStatusBadge(insurance.status),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Text('${insurance.provider} \u2022 ${insurance.policyNumber}',
                    style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                    maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text('\$${insurance.premiumAmount.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w700, color: const Color(0xFF10B981))),
                      const Spacer(),
                      Text('Exp: ${insurance.endDate.day}/${insurance.endDate.month}/${insurance.endDate.year}',
                        style: GoogleFonts.inter(fontSize: 10.sp, color: const Color(0xFF9CA3AF))),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4.w),
            Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
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
        color = const Color(0xFFF59E0B);
        break;
      case InsuranceStatus.expired:
        color = const Color(0xFFEF4444);
        break;
      case InsuranceStatus.cancelled:
        color = const Color(0xFF6B7280);
        break;
      case InsuranceStatus.suspended:
        color = const Color.fromARGB(255, 78, 3, 208);
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        status.displayName,
        style: GoogleFonts.inter(
          fontSize: 12.sp,
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmptyInsurances() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'No Insurance Policies',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Get started by adding your first insurance policy',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF6366F1).withValues(alpha: 0.3),
                  const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(
              Icons.shield_outlined,
              size: 40.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Welcome to Insurance',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Manage all your insurance policies in one place',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 32.h),
          _buildGetStartedButton(),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.insuranceHowItWorks),
            child: Text(
              'How does insurance work?',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: const Color(0xFF6366F1),
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xFF6366F1),
              ),
            ),
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
            'Loading insurance policies...',
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(36.r),
              ),
              child: Icon(Icons.cloud_off_outlined, size: 36.sp, color: const Color(0xFFEF4444)),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
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
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () => context.read<InsuranceCubit>().loadInsurances(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 18.sp),
                    SizedBox(width: 8.w),
                    Text('Try Again', style: GoogleFonts.inter(
                      fontSize: 15.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () => _showCreateInsuranceDialog(),
              child: Text(
                'Or browse insurance plans',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: const Color(0xFF6366F1),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFF6366F1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1),
            const Color.fromARGB(255, 78, 3, 208),
          ],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.read<InsuranceCubit>().loadInsurances(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Get Started',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF6366F1),
            const Color.fromARGB(255, 78, 3, 208),
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
        onPressed: () => _showCreateInsuranceDialog(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20.sp,
        ),
        label: Text(
          'New Policy',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }

  void _showCreateInsuranceDialog() {
    // Capture cubits from current context before navigation
    final insuranceCubit = context.read<InsuranceCubit>();
    final authCubit = context.read<AuthenticationCubit>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: insuranceCubit),
            BlocProvider.value(value: authCubit),
            BlocProvider(create: (context) => CreatePolicyCubit(
              repository: serviceLocator<InsuranceRepository>(),
              cacheManager: serviceLocator<SWRCacheManager>(),
              localeManager: serviceLocator<LocaleManager>(),
            )),
          ],
          child: const CreateInsurancePolicyCarousel(),
        ),
      ),
    ).then((_) {
      // Refresh insurance list after carousel closes
      insuranceCubit.loadInsurances();
    });
  }

  void _navigateToInsuranceDetails(Insurance insurance) async {
    // Navigate with the insurance object directly (simulates API approach)
    Get.toNamed(AppRoutes.insuranceDetails, arguments: insurance);
  }
}