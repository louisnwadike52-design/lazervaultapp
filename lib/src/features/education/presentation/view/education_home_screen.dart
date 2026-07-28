import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/education_history_entity.dart';
import '../../domain/repositories/education_repository.dart';
import '../cubit/education_cubit.dart';
import '../widgets/education_quick_buy.dart';
import '../cubit/education_history_cubit.dart';

/// Education PINs landing. Mirrors the internet / water landing pattern:
/// quick-actions row (Saved Candidates, Reminders, History) → hero
/// gradient card → provider list → recent purchases strip.
class EducationHomeScreen extends StatefulWidget {
  const EducationHomeScreen({super.key});

  @override
  State<EducationHomeScreen> createState() => _EducationHomeScreenState();
}

class _EducationHomeScreenState extends State<EducationHomeScreen> {
  static const Color _primary = Color(0xFF4E03D0);

  late final EducationHistoryCubit _historyCubit;

  @override
  void initState() {
    super.initState();
    context.read<EducationCubit>().getProviders();

    // History cubit is local to this screen so we can show a "Recent
    // Purchases" strip without coupling to the full history page.
    // Reuse the already-registered repository singleton instead of
    // hand-wiring a fresh gRPC client stack on every mount (the previous
    // code also had a `GetIt.I<GrpcClient>()` lookup that bypassed the
    // `commerceGrpcClient` instance name → "not registered" crash on
    // open).
    _historyCubit = EducationHistoryCubit(GetIt.I<EducationRepository>())
      ..loadHistory(refresh: true);
  }

  @override
  void dispose() {
    _historyCubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Both AppBar back and the OS/Android back button always route to
      // the utility bills hub. Education PINs is reached as a sub-hub of
      // utilities; popping to whatever happened to be underneath (search
      // results, deep links, rebuy flows) is confusing.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.billsHub);
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Education PINs',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // Per-bill voice + chat icons removed — unified utility bills
        // landing page hosts the single chat/mic entry point now.
      ),
      body: SafeArea(
        child: RefreshIndicator(
            color: _primary,
            backgroundColor: const Color(0xFF1F1F1F),
            onRefresh: () async {
              await context.read<EducationCubit>().getProviders();
              await _historyCubit.loadHistory(refresh: true);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Streamlined single-page purchase (see EducationQuickBuy).
                  _buildQuickActions(),
                  SizedBox(height: 20.h),
                  _buildHeroCard(),
                  SizedBox(height: 24.h),
                  const EducationQuickBuy(),
                  SizedBox(height: 24.h),
                  _buildRecentPurchases(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
      ),
    ),
    );
  }


  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _quickCard(
            title: 'Saved\nCandidates',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(AppRoutes.educationSavedCandidates),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _quickCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(AppRoutes.educationReminders),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _quickCard(
            title: 'History',
            icon: Icons.history,
            onTap: () => Get.toNamed(AppRoutes.educationHistory),
          ),
        ),
      ],
    );
  }

  Widget _quickCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14.r),
          border:
              Border.all(color: _primary.withValues(alpha: 0.25), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: _primary, size: 22.sp),
            SizedBox(height: 6.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [_primary, Color.fromARGB(255, 78, 3, 208)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.school, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Buy Education PINs',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Purchase WAEC, JAMB, and other exam PINs instantly',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRecentPurchases() {
    return BlocBuilder<EducationHistoryCubit, EducationHistoryState>(
      bloc: _historyCubit,
      builder: (context, state) {
        if (state is EducationHistoryLoading ||
            state is EducationHistoryInitial) {
          return const SizedBox.shrink();
        }
        if (state is EducationHistoryError) {
          return const SizedBox.shrink();
        }
        if (state is EducationHistoryLoaded) {
          final recent = state.history.take(3).toList();
          if (recent.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Recent Purchases',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.educationHistory),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: _primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              ...recent.map(_buildRecentRow),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRecentRow(EducationHistoryEntity h) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: BillHistoryItem(
        leadingIcon: Container(
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.school, color: _primary, size: 18.sp),
        ),
        title: h.providerName.isEmpty ? 'Education PIN' : h.providerName,
        subtitle:
            '${h.quantity} ${h.quantity == 1 ? 'PIN' : 'PINs'} \u00B7 ${h.billersCode}',
        date: h.createdAt,
        amount: h.amount,
        status: h.status,
        onTap: () => Get.toNamed(
          AppRoutes.educationPinDetails,
          arguments: {'purchaseId': h.id},
        ),
      ),
    );
  }





}
