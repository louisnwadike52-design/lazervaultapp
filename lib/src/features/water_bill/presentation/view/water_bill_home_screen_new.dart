import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/water_provider_entity.dart';
import '../../domain/entities/water_payment_entity.dart';
import '../cubit/water_bill_cubit.dart';
import '../cubit/water_bill_state.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../widgets/water_history_actions_sheet.dart';

/// Water Bill landing screen.
///
/// Layout (top → bottom, consolidated for at-a-glance):
///   1. Quick actions: Saved Accounts · Auto-Recharge · Reminders
///   2. Flat provider grid (no primary / other split — same shape as
///      cable TV and internet bill landings)
///   3. Recent payments strip via the shared [BillHistoryItem] + taps
///      open the shared [BillHistoryActionsSheet] for repeat / save /
///      reminder / auto-renew actions.
///
/// AppBar carries no history icon — "View All" in the recent-payments
/// footer is the single discoverable path into the full history list.
class WaterBillHomeScreenNew extends StatefulWidget {
  const WaterBillHomeScreenNew({super.key});

  @override
  State<WaterBillHomeScreenNew> createState() => _WaterBillHomeScreenNewState();
}

class _WaterBillHomeScreenNewState extends State<WaterBillHomeScreenNew> {
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _border = Color(0xFF2D2D2D);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  List<WaterProviderEntity> _providers = [];
  List<WaterPaymentEntity> _payments = [];
  bool _isLoadingProviders = true;
  bool _isLoadingPayments = true;

  @override
  void initState() {
    super.initState();
    context.read<WaterBillCubit>().getProviders();
    context.read<WaterBillCubit>().getPaymentHistory(limit: 5);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) Get.offAllNamed(AppRoutes.billsHub);
      },
      child: Scaffold(
        backgroundColor: _bg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.offAllNamed(AppRoutes.billsHub),
            icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          ),
          title: Text(
            'Water Bills',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocConsumer<WaterBillCubit, WaterBillState>(
            listener: (context, state) {
              if (state is ProvidersLoaded) {
                setState(() {
                  _providers = state.providers;
                  _isLoadingProviders = false;
                });
              } else if (state is PaymentHistoryLoaded) {
                setState(() {
                  _payments = state.payments;
                  _isLoadingPayments = false;
                });
              } else if (state is WaterBillError && _providers.isEmpty) {
                setState(() => _isLoadingProviders = false);
              }
            },
            builder: (context, state) {
              if (_isLoadingProviders && _providers.isEmpty) {
                return _buildLoading();
              }
              if (_providers.isEmpty) {
                final msg = state is WaterBillError
                    ? state.message
                    : 'No water providers available';
                return _buildError(msg);
              }
              return _buildContent();
            },
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Main content
  // ---------------------------------------------------------------------------

  Widget _buildContent() {
    return RefreshIndicator(
      color: _primary,
      backgroundColor: _card,
      onRefresh: () async {
        final cubit = context.read<WaterBillCubit>();
        await cubit.getProviders();
        await cubit.getPaymentHistory(limit: 5);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickActions(),
            SizedBox(height: 24.h),
            _buildSectionTitle('Choose Your Provider'),
            SizedBox(height: 12.h),
            _buildProviderGrid(_providers),
            SizedBox(height: 28.h),
            _buildRecentPaymentsSection(),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Quick Actions row: Saved / Auto-Recharge / Reminders
  // ---------------------------------------------------------------------------

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _QuickActionCard(
            title: 'Saved\nAccounts',
            icon: Icons.bookmark_border,
            onTap: () => Get.toNamed(AppRoutes.waterBillSavedAccounts),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Auto-\nRecharge',
            icon: Icons.autorenew,
            onTap: () => Get.toNamed(AppRoutes.waterBillAutoRecharge),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _QuickActionCard(
            title: 'Reminders',
            icon: Icons.notifications_outlined,
            onTap: () => Get.toNamed(AppRoutes.waterBillReminders),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Provider grid — flat, no primary / other split
  // ---------------------------------------------------------------------------

  Widget _buildProviderGrid(List<WaterProviderEntity> providers) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: providers.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: providers.length >= 3 ? 3 : 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) => _buildProviderTile(providers[i]),
    );
  }

  Widget _buildProviderTile(WaterProviderEntity provider) {
    return GestureDetector(
      onTap: () => _navigateToPayment(provider),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.water_drop, color: _primary, size: 20.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              provider.providerName,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Recent payments — top 3 rows via shared BillHistoryItem
  // ---------------------------------------------------------------------------

  Widget _buildRecentPaymentsSection() {
    // Mirror the airtime landing layout (see
    // features/airtime/presentation/widgets/recent_transactions_card.dart):
    // section header + a bare Column of BillHistoryItem rows, each with its
    // OWN card background + border. The previous revision wrapped the
    // header + all three rows inside one big Container, so the rows
    // visually blurred into a single block — user feedback called it out.
    // No outer padding/border here; each BillHistoryItem brings its own.
    final items = _payments.take(3).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle('Recent Payments'),
            if (_payments.isNotEmpty)
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.waterBillHistory),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: _primary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 12.h),
        if (_isLoadingPayments)
          _buildPaymentsLoading()
        else if (items.isEmpty)
          _buildPaymentsEmpty()
        else
          Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                _buildPaymentRow(items[i]),
                if (i != items.length - 1) SizedBox(height: 10.h),
              ],
            ],
          ),
      ],
    );
  }

  Widget _buildPaymentRow(WaterPaymentEntity p) {
    // Water-specific payload into the shared BillHistoryItem — same
    // contract every utility uses (see airtime / data / electricity).
    // Leading icon is the water-drop glyph in the service accent colour
    // so the row is recognisable as a water row in any mixed list.
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Icon(Icons.water_drop, color: _primary, size: 20.sp),
      ),
      title:
          p.providerName.isNotEmpty ? p.providerName : 'Water Bill',
      subtitle:
          p.customerNumber.isNotEmpty ? p.customerNumber : 'Account',
      date: _relativeTime(p.createdAt),
      amount: p.amount,
      status: p.status.name,
      onTap: () => _showHistoryActions(p),
    );
  }

  String _relativeTime(DateTime dt) {
    // Matches the airtime / data landing strips (just now / 2h ago /
    // 3d ago / "Apr 22"). Kept inline to avoid a third-party import
    // for such a small helper.
    final diff = DateTime.now().difference(dt);
    if (diff.isNegative || diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('MMM dd').format(dt);
  }

  Widget _buildPaymentsLoading() => Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Center(
          child: SizedBox(
            width: 20.w,
            height: 20.w,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(_primary),
            ),
          ),
        ),
      );

  Widget _buildPaymentsEmpty() => Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Column(
          children: [
            Icon(Icons.receipt_long, color: const Color(0xFF6B7280), size: 28.sp),
            SizedBox(height: 8.h),
            Text(
              'No recent payments',
              style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.sp),
            ),
          ],
        ),
      );

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  Widget _buildSectionTitle(String text) => Text(
        text,
        style: GoogleFonts.inter(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      );

  Widget _buildLoading() => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 36.w,
              height: 36.w,
              child: const CircularProgressIndicator(
                  color: _primary, strokeWidth: 3),
            ),
            SizedBox(height: 16.h),
            Text('Loading water providers…',
                style: GoogleFonts.inter(
                    color: _textSecondary, fontSize: 13.sp)),
          ],
        ),
      );

  Widget _buildError(String message) => Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 48.sp),
              SizedBox(height: 16.h),
              Text('Failed to load providers',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 8.h),
              Text(message,
                  style: GoogleFonts.inter(
                      color: _textSecondary, fontSize: 13.sp),
                  textAlign: TextAlign.center),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => context.read<WaterBillCubit>().getProviders(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  padding: EdgeInsets.symmetric(
                      horizontal: 28.w, vertical: 12.h),
                ),
                child: Text('Retry',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      );

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  void _navigateToPayment(WaterProviderEntity provider) {
    Get.toNamed(
      AppRoutes.waterBillCustomerInput,
      arguments: {'provider': provider},
    );
  }

  // Delegates to the shared water-specific actions sheet so the landing
  // and history screens dispatch through one code path (saved-contact
  // detection, receipt, repeat, reminder, auto-pay, save/edit).
  void _showHistoryActions(WaterPaymentEntity payment) {
    WaterHistoryActionsSheet.show(context, payment);
  }
}

// ---------------------------------------------------------------------------
// Quick action card — small tile with icon + label (mirrors cable TV landing).
// ---------------------------------------------------------------------------

class _QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _primary = Color(0xFF4E03D0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, color: _primary, size: 18.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
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
}
