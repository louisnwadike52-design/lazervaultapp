import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/education_history_entity.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../domain/repositories/education_repository.dart';
import '../cubit/education_cubit.dart';
import '../cubit/education_history_cubit.dart';
import '../cubit/education_state.dart';

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

  void _handleRebuyPurchase(
      Map<String, dynamic> rebuyPurchase, List<EducationProviderEntity> providers) {
    final serviceId = rebuyPurchase['serviceId'] as String?;
    if (serviceId == null || serviceId.isEmpty) return;
    final matchingProvider = providers.firstWhere(
      (p) => p.serviceId == serviceId,
      orElse: () => providers.first,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.toNamed(AppRoutes.educationPurchase, arguments: {
        'provider': matchingProvider,
        'rebuyPurchase': rebuyPurchase,
      });
    });
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
      ),
      body: SafeArea(
        child: BlocBuilder<EducationCubit, EducationState>(
          builder: (context, state) {
            final args = Get.arguments as Map<String, dynamic>?;
            final rebuyPurchase =
                args?['rebuyPurchase'] as Map<String, dynamic>?;

            if (state is EducationProvidersLoaded && rebuyPurchase != null) {
              _handleRebuyPurchase(rebuyPurchase, state.providers);
              return const Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(_primary),
                ),
              );
            }

            if (state is EducationLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(_primary),
                ),
              );
            }

            if (state is EducationError) {
              return _buildErrorState(state.message);
            }

            if (state is EducationProvidersLoaded) {
              if (state.providers.isEmpty) {
                return _buildEmptyState();
              }
              return _buildContent(state.providers);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(List<EducationProviderEntity> providers) {
    return RefreshIndicator(
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
            // Quick actions (matches internet / water pattern)
            _buildQuickActions(),
            SizedBox(height: 20.h),

            // Hero card
            _buildHeroCard(),
            SizedBox(height: 24.h),

            Text(
              'Select Provider',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),

            ...providers.map((provider) => _buildProviderCard(provider)),

            SizedBox(height: 24.h),

            // Recent purchases strip
            _buildRecentPurchases(),

            SizedBox(height: 20.h),
          ],
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

  Widget _buildProviderCard(EducationProviderEntity provider) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.educationPurchase, arguments: {
          'provider': provider,
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: _getProviderColor(provider.name).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(child: _getProviderIcon(provider.name)),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    provider.description,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\u20A6${_formatAmount(provider.amount)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: _primary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'per PIN',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
          ],
        ),
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

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline,
                size: 64.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 16.h),
            Text(
              'Failed to load providers',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<EducationCubit>().getProviders(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                padding:
                    EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_outlined,
                size: 64.sp, color: const Color(0xFF9CA3AF)),
            SizedBox(height: 16.h),
            Text(
              'No Education PIN Providers Available',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Check back later for available providers',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => context.read<EducationCubit>().getProviders(),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
                padding:
                    EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getProviderColor(String name) {
    final n = name.toLowerCase();
    if (n.contains('waec')) return const Color(0xFF10B981);
    if (n.contains('jamb')) return _primary;
    return const Color(0xFFFB923C);
  }

  Widget _getProviderIcon(String name) {
    final n = name.toLowerCase();
    if (n.contains('waec')) {
      return Icon(Icons.assignment, color: const Color(0xFF10B981), size: 28.sp);
    } else if (n.contains('jamb')) {
      return Icon(Icons.menu_book, color: _primary, size: 28.sp);
    }
    return Icon(Icons.school, color: const Color(0xFFFB923C), size: 28.sp);
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) result.write(',');
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
