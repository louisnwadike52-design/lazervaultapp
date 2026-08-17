import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/airtime_transaction.dart';
import '../../domain/entities/network_provider.dart';
import '../utils/airtime_navigation_utils.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../widgets/recent_transactions_card.dart' show AirtimeScope;
import '../widgets/airtime_history_actions_sheet.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'airtime_history_screen_widgets.dart';


class AirtimeHistoryScreen extends StatefulWidget {
  const AirtimeHistoryScreen({super.key});

  @override
  State<AirtimeHistoryScreen> createState() => _AirtimeHistoryScreenState();
}

class _AirtimeHistoryScreenState extends State<AirtimeHistoryScreen> {
  /// Active pill. Seeded from `Get.arguments['scope']` so that jumping in
  /// from a tab's 'View All' link opens the pre-filtered list.
  String _scope = AirtimeScope.buy;

  _AirtimeFilters _filters = const _AirtimeFilters();

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      final arg = args['scope']?.toString();
      if (arg == AirtimeScope.all ||
          arg == AirtimeScope.buy ||
          arg == AirtimeScope.intl ||
          arg == AirtimeScope.sell) {
        _scope = arg!;
      }
      // Seed the query filter from `phoneNumber` so deep-linking from the
      // saved-contacts "View Purchases" entry lands on a list filtered to
      // just this contact's top-ups. _AirtimeFilters.match already routes
      // numeric queries against recipientPhoneNumber digits.
      final phone = args['phoneNumber']?.toString();
      if (phone != null && phone.trim().isNotEmpty) {
        _filters = _AirtimeFilters(query: phone.trim());
      }
    }
    final userId = context.read<AuthenticationCubit>().userId ?? '';
    context.read<AirtimeCubit>().loadTransactionHistory(userId);
  }

  Color get _scopeAccent => switch (_scope) {
        AirtimeScope.intl || AirtimeScope.sell => const Color(0xFF4E03D0),
        _ => const Color(0xFF4E03D0),
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F1F1F),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(),
              _buildScopePills(),

              // Content
              Expanded(
                child: BlocBuilder<AirtimeCubit, AirtimeState>(
                  builder: (context, state) {
                    if (state is AirtimeTransactionHistoryLoaded) {
                      final inScope = state.transactions
                          .where((t) => AirtimeScope.match(t, _scope))
                          .toList();
                      final filtered =
                          inScope.where(_filters.match).toList();
                      if (filtered.isEmpty) {
                        final hasFilters = _filters.isActive;
                        return RefreshIndicator(
                          onRefresh: () async {
                            final userId = context
                                    .read<AuthenticationCubit>()
                                    .userId ??
                                '';
                            context
                                .read<AirtimeCubit>()
                                .loadTransactionHistory(userId);
                          },
                          backgroundColor: const Color(0xFF1F1F1F),
                          color: _scopeAccent,
                          child: hasFilters
                              ? _buildFilteredEmptyState()
                              : _buildEmptyState(),
                        );
                      }
                      return _buildTransactionsList(filtered);
                    } else if (state is AirtimeError) {
                      return _buildErrorState(state.message);
                    }
                    return _buildLoadingState();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transaction History',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Your airtime purchase history',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          
          // Filter button
          GestureDetector(
            onTap: () => _showFilterBottomSheet(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    Icons.filter_list,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  if (_filters.isActive)
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _scopeAccent,
                          shape: BoxShape.circle,
                          border:
                              Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScopePills() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 16.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildPill(AirtimeScope.all, 'All', const Color(0xFF4E03D0)),
            SizedBox(width: 8.w),
            _buildPill(AirtimeScope.buy, 'Buy', const Color(0xFF4E03D0)),
            SizedBox(width: 8.w),
            _buildPill(
                AirtimeScope.intl, 'International', const Color(0xFF4E03D0)),
            SizedBox(width: 8.w),
            _buildPill(AirtimeScope.sell, 'Sell', const Color(0xFF4E03D0)),
          ],
        ),
      ),
    );
  }

  Widget _buildPill(String value, String label, Color accent) {
    final isActive = _scope == value;
    return GestureDetector(
      onTap: () => setState(() => _scope = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isActive ? accent : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isActive ? accent : const Color(0xFF2D2D2D),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList(List<AirtimeTransaction> transactions) {
    return RefreshIndicator(
      onRefresh: () async {
        final userId = context.read<AuthenticationCubit>().userId ?? '';
        context.read<AirtimeCubit>().loadTransactionHistory(userId);
      },
      backgroundColor: Color(0xFF1F1F1F),
      color: Color(0xFF4E03D0),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildTransactionCard(transaction),
          );
        },
      ),
    );
  }

  /// Builds a history row using the shared [BillHistoryItem] widget so
  /// airtime, data bundles, electricity, and every other utility all
  /// render transaction history rows with the same visual + behavior.
  /// Only the payload differs — leading icon uses the network colour,
  /// the metadata-derived `refundSource` (probed from the transaction
  /// metadata) flips a `failed` row's chip to "Refunded".
  Widget _buildTransactionCard(AirtimeTransaction transaction) {
    return GestureDetector(
      onLongPress: () => _showQuickActions(transaction),
      child: BillHistoryItem(
        leadingIcon: Container(
          decoration: BoxDecoration(
            color: transaction.networkProvider.color,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Center(
            child: Text(
              transaction.networkProvider.displayName.isNotEmpty
                  ? transaction.networkProvider.displayName.substring(0, 1)
                  : '?',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
        title: transaction.displayTitle,
        subtitle: transaction.displayRecipientNumber,
        reference: transaction.transactionReference,
        date: DateFormat('MMM dd, yyyy \u2022 hh:mm a')
            .format(transaction.createdAt),
        amount: transaction.amount,
        currencySymbol: transaction.currencySymbol,
        status: transaction.status.name,
        refundSource: _refundSourceFor(transaction),
        onTap: () => AirtimeHistoryActionsSheet.show(context, transaction),
      ),
    );
  }

  /// Reads a refund-source string off the airtime transaction's metadata
  /// map. Backend writes `refund_source` / `refundSource` when a failed
  /// row was actually auto-released so the Flutter badge reads
  /// "Refunded" instead of "Failed".
  String? _refundSourceFor(AirtimeTransaction t) {
    final meta = t.metadata;
    if (meta == null) return null;
    final v = meta['refund_source'] ?? meta['refundSource'];
    if (v is String && v.isNotEmpty) return v;
    return null;
  }

  /// Empty state shown when filters are active and remove every row —
  /// distinct from the "no transactions yet" copy so the user knows
  /// their filter is responsible (and offers a one-tap reset).
  Widget _buildFilteredEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.filter_alt_off_outlined,
          size: 72.sp,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        SizedBox(height: 20.h),
        Text(
          'No matches',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.h),
        Text(
          'No transactions match your current filters.',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 24.h),
        Center(
          child: OutlinedButton(
            onPressed: () =>
                setState(() => _filters = const _AirtimeFilters()),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: _scopeAccent),
              padding:
                  EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Clear filters',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: _scopeAccent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 120.h),
        Icon(
          Icons.history,
          size: 80.sp,
          color: Colors.white.withValues(alpha: 0.3),
        ),
        SizedBox(height: 24.h),
        Text(
          'No Transactions Yet',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          'Your airtime purchase history will appear here',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white.withValues(alpha: 0.6),
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 32.h),
        Center(
          child: ElevatedButton(
            onPressed: () => Get.offNamed(AppRoutes.airtime),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E03D0),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              'Buy Airtime',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading transactions...',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
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
            color: Colors.red.withValues(alpha: 0.6),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error',
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
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () {
              final userId = context.read<AuthenticationCubit>().userId ?? '';
              context.read<AirtimeCubit>().loadTransactionHistory(userId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF4E03D0),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Collects all network providers currently present in the loaded
  /// transactions so the filter sheet only offers networks the user has
  /// actually used. Falls back to an empty set if no data is loaded yet.
  Set<NetworkProviderType> _networksInView() {
    final state = context.read<AirtimeCubit>().state;
    if (state is! AirtimeTransactionHistoryLoaded) return {};
    return state.transactions
        .where((t) => AirtimeScope.match(t, _scope))
        .map((t) => t.networkProvider)
        .toSet();
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) => _AirtimeFilterSheet(
        initial: _filters,
        accent: _scopeAccent,
        availableNetworks: _networksInView(),
        onApply: (next) => setState(() => _filters = next),
      ),
    );
  }

  void _showQuickActions(AirtimeTransaction transaction) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            
            // Transaction info
            Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: transaction.networkProvider.color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      transaction.networkProvider.displayName.isNotEmpty
                          ? transaction.networkProvider.displayName
                              .substring(0, 1)
                          : '?',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${transaction.networkProvider.displayName} Airtime',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        transaction.displayRecipientNumber,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '${transaction.currencySymbol}${transaction.amount.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 24.h),
            
            // Action buttons
            Column(
              children: [
                // Repeat Transaction
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back(); // Close bottom sheet
                      repeatAirtimeTransaction(context, transaction);
                    },
                    icon: Icon(Icons.repeat, color: Colors.white, size: 20.sp),
                    label: Text(
                      'Repeat Transaction',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: 12.h),
                
                // View Details
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.back(); // Close bottom sheet
                      Get.toNamed(AppRoutes.airtimeDetails, arguments: {'transaction': transaction});
                    },
                    icon: Icon(Icons.receipt_long, color: Colors.white.withValues(alpha: 0.8), size: 20.sp),
                    label: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

}
