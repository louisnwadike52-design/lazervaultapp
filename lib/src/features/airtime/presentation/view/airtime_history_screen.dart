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

class AirtimeHistoryScreen extends StatefulWidget {
  const AirtimeHistoryScreen({super.key});

  @override
  State<AirtimeHistoryScreen> createState() => _AirtimeHistoryScreenState();
}

/// Filter state held by the history screen. Applied on top of the pill
/// scope so the user can drill down by query/network/status/date/amount.
class _AirtimeFilters {
  final String query;
  final Set<NetworkProviderType> networks;
  final Set<AirtimeTransactionStatus> statuses;
  final DateTime? from;
  final DateTime? to;
  final double? minAmount;
  final double? maxAmount;

  const _AirtimeFilters({
    this.query = '',
    this.networks = const {},
    this.statuses = const {},
    this.from,
    this.to,
    this.minAmount,
    this.maxAmount,
  });

  bool get isActive =>
      query.trim().isNotEmpty ||
      networks.isNotEmpty ||
      statuses.isNotEmpty ||
      from != null ||
      to != null ||
      minAmount != null ||
      maxAmount != null;

  int get activeCount {
    var n = 0;
    if (query.trim().isNotEmpty) n++;
    if (networks.isNotEmpty) n++;
    if (statuses.isNotEmpty) n++;
    if (from != null || to != null) n++;
    if (minAmount != null || maxAmount != null) n++;
    return n;
  }

  bool match(AirtimeTransaction t) {
    if (networks.isNotEmpty && !networks.contains(t.networkProvider)) {
      return false;
    }
    if (statuses.isNotEmpty && !statuses.contains(t.status)) return false;
    if (from != null && t.createdAt.isBefore(from!)) return false;
    if (to != null && t.createdAt.isAfter(to!)) return false;
    if (minAmount != null && t.amount < minAmount!) return false;
    if (maxAmount != null && t.amount > maxAmount!) return false;
    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      final digits = q.replaceAll(RegExp(r'[^\d]'), '');
      final phoneDigits =
          t.recipientPhoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      final inPhone = digits.isNotEmpty && phoneDigits.contains(digits);
      final inRef = t.transactionReference.toLowerCase().contains(q);
      final inName = (t.recipientName ?? '').toLowerCase().contains(q);
      final inNetwork =
          t.networkProvider.displayName.toLowerCase().contains(q) ||
              t.networkProvider.shortName.toLowerCase().contains(q);
      if (!(inPhone || inRef || inName || inNetwork)) return false;
    }
    return true;
  }
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
          ),
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

/// Stateful bottom sheet that lets the user refine the airtime history by
/// text (phone/reference/name/network), network, status, date range and
/// amount range. Returns the new filter set via [onApply] when the user
/// taps the apply button; "Clear All" wipes everything and applies.
class _AirtimeFilterSheet extends StatefulWidget {
  final _AirtimeFilters initial;
  final Color accent;
  final Set<NetworkProviderType> availableNetworks;
  final ValueChanged<_AirtimeFilters> onApply;

  const _AirtimeFilterSheet({
    required this.initial,
    required this.accent,
    required this.availableNetworks,
    required this.onApply,
  });

  @override
  State<_AirtimeFilterSheet> createState() => _AirtimeFilterSheetState();
}

class _AirtimeFilterSheetState extends State<_AirtimeFilterSheet> {
  late TextEditingController _queryCtrl;
  late TextEditingController _minCtrl;
  late TextEditingController _maxCtrl;
  late Set<NetworkProviderType> _networks;
  late Set<AirtimeTransactionStatus> _statuses;
  DateTime? _from;
  DateTime? _to;

  @override
  void initState() {
    super.initState();
    _queryCtrl = TextEditingController(text: widget.initial.query);
    _minCtrl = TextEditingController(
        text: widget.initial.minAmount?.toStringAsFixed(0) ?? '');
    _maxCtrl = TextEditingController(
        text: widget.initial.maxAmount?.toStringAsFixed(0) ?? '');
    _networks = {...widget.initial.networks};
    _statuses = {...widget.initial.statuses};
    _from = widget.initial.from;
    _to = widget.initial.to;
  }

  @override
  void dispose() {
    _queryCtrl.dispose();
    _minCtrl.dispose();
    _maxCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  Text(
                    'Filter Transactions',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: _clearAll,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 4.h),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Clear All',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: widget.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Search'),
                    SizedBox(height: 8.h),
                    _searchField(),
                    SizedBox(height: 20.h),
                    if (widget.availableNetworks.isNotEmpty) ...[
                      _sectionLabel('Network'),
                      SizedBox(height: 8.h),
                      _networkChips(),
                      SizedBox(height: 20.h),
                    ],
                    _sectionLabel('Status'),
                    SizedBox(height: 8.h),
                    _statusChips(),
                    SizedBox(height: 20.h),
                    _sectionLabel('Date range'),
                    SizedBox(height: 8.h),
                    _dateRangeRow(),
                    SizedBox(height: 20.h),
                    _sectionLabel('Amount range'),
                    SizedBox(height: 8.h),
                    _amountRangeRow(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 20.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _apply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.accent,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'Apply Filters',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white.withValues(alpha: 0.85),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _searchField() {
    return TextField(
      controller: _queryCtrl,
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: 'Phone, reference, name or network',
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 13.sp,
        ),
        prefixIcon: Icon(Icons.search,
            color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
        suffixIcon: _queryCtrl.text.isEmpty
            ? null
            : IconButton(
                icon: Icon(Icons.close,
                    color: Colors.white.withValues(alpha: 0.5), size: 18.sp),
                onPressed: () => setState(() => _queryCtrl.clear()),
              ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: (_) => setState(() {}),
    );
  }

  Widget _networkChips() {
    final networks = widget.availableNetworks.toList()
      ..sort((a, b) => a.displayName.compareTo(b.displayName));
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: networks.map((n) {
        final selected = _networks.contains(n);
        return _chip(
          label: n.shortName,
          selected: selected,
          leading: Container(
            width: 10.w,
            height: 10.w,
            decoration: BoxDecoration(
              color: n.color,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () => setState(() {
            selected ? _networks.remove(n) : _networks.add(n);
          }),
        );
      }).toList(),
    );
  }

  Widget _statusChips() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: AirtimeTransactionStatus.values.map((s) {
        final selected = _statuses.contains(s);
        return _chip(
          label: s.displayName,
          selected: selected,
          leading: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: s.color,
              shape: BoxShape.circle,
            ),
          ),
          onTap: () => setState(() {
            selected ? _statuses.remove(s) : _statuses.add(s);
          }),
        );
      }).toList(),
    );
  }

  Widget _chip({
    required String label,
    required bool selected,
    required VoidCallback onTap,
    Widget? leading,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: selected
              ? widget.accent.withValues(alpha: 0.2)
              : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: selected
                ? widget.accent
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (leading != null) ...[
              leading,
              SizedBox(width: 6.w),
            ],
            Text(
              label,
              style: TextStyle(
                color: selected ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateRangeRow() {
    return Row(
      children: [
        Expanded(
          child: _dateButton(
            label: _from == null
                ? 'From'
                : DateFormat('MMM dd, yyyy').format(_from!),
            onTap: () => _pickDate(isFrom: true),
            onClear: _from == null ? null : () => setState(() => _from = null),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: _dateButton(
            label:
                _to == null ? 'To' : DateFormat('MMM dd, yyyy').format(_to!),
            onTap: () => _pickDate(isFrom: false),
            onClear: _to == null ? null : () => setState(() => _to = null),
          ),
        ),
      ],
    );
  }

  Widget _dateButton({
    required String label,
    required VoidCallback onTap,
    VoidCallback? onClear,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today_outlined,
                color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onClear != null)
              GestureDetector(
                onTap: onClear,
                child: Icon(Icons.close,
                    color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
              ),
          ],
        ),
      ),
    );
  }

  Widget _amountRangeRow() {
    return Row(
      children: [
        Expanded(child: _amountField(_minCtrl, 'Min')),
        SizedBox(width: 10.w),
        Expanded(child: _amountField(_maxCtrl, 'Max')),
      ],
    );
  }

  Widget _amountField(TextEditingController ctrl, String hint) {
    return TextField(
      controller: ctrl,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
        TextInputFormatter.withFunction((oldValue, newValue) {
          final dotCount = '.'.allMatches(newValue.text).length;
          if (dotCount > 1) return oldValue;
          return newValue;
        }),
      ],
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 13.sp,
        ),
        prefixText: '\u20A6 ',
        prefixStyle: TextStyle(
          color: Colors.white.withValues(alpha: 0.7),
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final initial = isFrom ? (_from ?? now) : (_to ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 5),
      lastDate: now,
      builder: (ctx, child) => Theme(
        data: Theme.of(ctx).copyWith(
          colorScheme: ColorScheme.dark(
            primary: widget.accent,
            onPrimary: Colors.white,
            surface: const Color(0xFF1F1F1F),
            onSurface: Colors.white,
          ),
        ),
        child: child!,
      ),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (isFrom) {
        _from = DateTime(picked.year, picked.month, picked.day);
        if (_to != null && _to!.isBefore(_from!)) _to = null;
      } else {
        _to = DateTime(picked.year, picked.month, picked.day, 23, 59, 59);
        if (_from != null && _from!.isAfter(_to!)) _from = null;
      }
    });
  }

  void _clearAll() {
    setState(() {
      _queryCtrl.clear();
      _minCtrl.clear();
      _maxCtrl.clear();
      _networks.clear();
      _statuses.clear();
      _from = null;
      _to = null;
    });
  }

  void _apply() {
    final minText = _minCtrl.text.trim();
    final maxText = _maxCtrl.text.trim();
    var minAmt = minText.isEmpty ? null : double.tryParse(minText);
    var maxAmt = maxText.isEmpty ? null : double.tryParse(maxText);

    // Reject non-parseable non-empty inputs (e.g. a lone ".") rather than
    // silently dropping them — the user's intent is otherwise ambiguous.
    if (minText.isNotEmpty && minAmt == null) {
      _showSnackBar('Min amount isn\u2019t a valid number');
      return;
    }
    if (maxText.isNotEmpty && maxAmt == null) {
      _showSnackBar('Max amount isn\u2019t a valid number');
      return;
    }

    // Clamp negatives to zero (the input formatters block '-' but
    // paste/IME edge cases can still sneak a negative through).
    if (minAmt != null && minAmt < 0) minAmt = 0;
    if (maxAmt != null && maxAmt < 0) maxAmt = 0;

    // Swap when min > max so the user still gets a sensible range
    // instead of an always-empty result set.
    if (minAmt != null && maxAmt != null && minAmt > maxAmt) {
      final tmp = minAmt;
      minAmt = maxAmt;
      maxAmt = tmp;
    }

    widget.onApply(_AirtimeFilters(
      query: _queryCtrl.text,
      networks: Set.unmodifiable(_networks),
      statuses: Set.unmodifiable(_statuses),
      from: _from,
      to: _to,
      minAmount: minAmt,
      maxAmount: maxAmt,
    ));
    Navigator.of(context).pop();
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF2D2D2D),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
