import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../data/datasources/data_beneficiary_remote_datasource.dart';
import '../../domain/entities/data_beneficiary.dart';
import '../../domain/entities/data_purchase_entity.dart';
import '../cubit/data_bundles_cubit.dart';
import '../cubit/data_bundles_state.dart';
import '../widgets/data_history_actions_sheet.dart';

/// Full-list data purchase history. Powered by DataBundlesCubit's
/// loadDataPurchaseHistory / cachedPurchases (SWR pattern, mirrors
/// AirtimeHistoryScreen). Accepts a `scope` Get.arguments key to
/// filter to `local` (bill_type='data') or `intl` (bill_type='intl_data').
class DataBundlesHistoryScreen extends StatefulWidget {
  const DataBundlesHistoryScreen({super.key});

  @override
  State<DataBundlesHistoryScreen> createState() =>
      _DataBundlesHistoryScreenState();
}

class _DataBundlesHistoryScreenState extends State<DataBundlesHistoryScreen> {
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _textSecondary = Color(0xFF9CA3AF);

  String _scope = 'all';

  /// When set, list is filtered to purchases for this phone. Landing's
  /// "View All" CTA omits it; the saved-contacts sheet supplies it so
  /// tapping "View Purchases" from a contact drills into just that
  /// contact's history. Dismissible via the filter chip — clears the
  /// filter in place without popping the route.
  String? _filterPhone;
  String? _filterLabel;
  String? _filterNetworkName;

  /// Lookup of `normalizedPhone -> DataBeneficiary` so history rows can
  /// render the saved contact's nickname when the purchase phone matches.
  /// Populated once on entry; we don't block the list on it — if the
  /// fetch fails, rows simply show the raw phone number.
  Map<String, DataBeneficiary> _savedByPhone = const {};

  @override
  void initState() {
    super.initState();
    // Read scope + optional contact filter from Get.arguments.
    final args = Get.arguments as Map<String, dynamic>?;
    final s = args?['scope'] as String?;
    if (s == 'intl' || s == 'local') _scope = s!;

    final phone = args?['phoneNumber'] as String?;
    if (phone != null && phone.isNotEmpty) {
      _filterPhone = _normalizePhone(phone);
      final nickname = args?['nickname'] as String?;
      _filterLabel =
          (nickname != null && nickname.isNotEmpty) ? nickname : phone;
      _filterNetworkName = args?['networkName'] as String?;
      // Don't auto-narrow the scope to local — legacy purchases may
      // have been stored with `bill_type=''` (before the column
      // existed) which would pass the scope check, but filtering by
      // scope here was hiding perfectly valid rows that seeded the
      // very contact the user tapped into. Let the phone filter alone
      // decide which rows belong to this contact.
      if (s == null) _scope = 'all';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<DataBundlesCubit>().loadDataPurchaseHistory(limit: 50);
    });
    _loadSavedContacts();
  }

  Future<void> _loadSavedContacts() async {
    try {
      final ds = GetIt.I<DataBeneficiaryRemoteDataSource>();
      final list = await ds.getBeneficiaries();
      if (!mounted) return;
      setState(() {
        _savedByPhone = {
          for (final b in list) _normalizePhone(b.phoneNumber): b,
        };
      });
    } catch (_) {
      // Non-fatal — history still renders with raw phone numbers.
    }
  }

  /// Compare phones by their last 10 digits — stored purchases may use
  /// `+234...`, beneficiaries may use `0...` or `234...`.
  static String _normalizePhone(String raw) {
    final digits = raw.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 10) return digits.substring(digits.length - 10);
    return digits;
  }

  /// Forgiving phone match: equal after digits-only normalisation, or
  /// one is a suffix of the other (min 7 shared trailing digits). Covers
  /// rows where the purchase was stored as `08...` (11 digits) and the
  /// beneficiary as `+234...` (13 digits) or similar cross-format
  /// mismatches that would otherwise look like different numbers.
  static bool _phoneMatches(String a, String b) {
    final da = a.replaceAll(RegExp(r'\D'), '');
    final db = b.replaceAll(RegExp(r'\D'), '');
    if (da.isEmpty || db.isEmpty) return false;
    if (da == db) return true;
    final n = da.length < db.length ? da.length : db.length;
    if (n < 7) return false;
    return da.substring(da.length - n) == db.substring(db.length - n);
  }

  void _clearContactFilter() {
    setState(() {
      _filterPhone = null;
      _filterLabel = null;
      _filterNetworkName = null;
    });
  }

  Future<void> _refresh() async {
    await context.read<DataBundlesCubit>().loadDataPurchaseHistory(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 8.h),
            if (_filterPhone != null) ...[
              _buildContactFilterChip(),
              SizedBox(height: 8.h),
            ],
            _buildScopeToggle(),
            SizedBox(height: 16.h),
            Expanded(
              child: BlocBuilder<DataBundlesCubit, DataBundlesState>(
                buildWhen: (prev, next) =>
                    next is DataPurchaseHistoryLoading ||
                    next is DataPurchaseHistoryLoaded ||
                    next is DataPurchaseHistoryError,
                builder: (context, state) {
                  List<DataPurchaseEntity>? source;
                  bool isFresh = false;
                  String? errorMsg;
                  if (state is DataPurchaseHistoryLoaded) {
                    source = state.purchases;
                    isFresh = !state.isStale;
                  } else if (state is DataPurchaseHistoryError) {
                    errorMsg = state.message;
                    source = context.read<DataBundlesCubit>().cachedPurchases;
                  } else {
                    source = context.read<DataBundlesCubit>().cachedPurchases;
                  }

                  if (source == null && errorMsg == null) {
                    return _buildLoading();
                  }
                  if (source == null && errorMsg != null) {
                    return _buildError(errorMsg);
                  }

                  // Scope filter. `bill_type='data'` → local,
                  // `bill_type='intl_data'` → international. `all` keeps both.
                  final all = source ?? const <DataPurchaseEntity>[];
                  var filtered = switch (_scope) {
                    'intl' => all.where((p) => p.isInternational).toList(),
                    'local' => all.where((p) => !p.isInternational).toList(),
                    _ => all,
                  };
                  if (_filterPhone != null) {
                    // Forgiving match: strict-equal last-10 or suffix-
                    // equal (min 7 shared trailing digits). Handles
                    // stored-phone-format mismatches between purchases
                    // (`+234...`, `234...`) and beneficiaries (`0...`).
                    filtered = filtered
                        .where((p) => _phoneMatches(p.phoneNumber, _filterPhone!))
                        .toList();
                  }

                  if (filtered.isEmpty && isFresh) {
                    return _buildEmpty();
                  }
                  if (filtered.isEmpty) {
                    return _buildLoading();
                  }

                  return RefreshIndicator(
                    onRefresh: _refresh,
                    color: _primary,
                    backgroundColor: _card,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (_, __) => SizedBox(height: 10.h),
                      itemBuilder: (_, i) => _buildRow(filtered[i]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Text(
            'Data History',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactFilterChip() {
    final networkSuffix = (_filterNetworkName != null &&
            _filterNetworkName!.isNotEmpty)
        ? ' • $_filterNetworkName'
        : '';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: _primary.withValues(alpha: 0.35)),
        ),
        child: Row(
          children: [
            Icon(Icons.filter_alt_outlined, color: _primary, size: 16.sp),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Showing purchases for ${_filterLabel ?? ''}$networkSuffix',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: _clearContactFilter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.close, color: _primary, size: 12.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'Clear',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: _primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScopeToggle() {
    Widget chip(String value, String label) {
      final selected = _scope == value;
      return GestureDetector(
        onTap: () => setState(() => _scope = value),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: selected ? _primary : _card,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: selected
                  ? _primary
                  : Colors.white.withValues(alpha: 0.08),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : _textSecondary,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          chip('all', 'All'),
          SizedBox(width: 8.w),
          chip('local', 'Local'),
          SizedBox(width: 8.w),
          chip('intl', 'International'),
        ],
      ),
    );
  }

  Widget _buildRow(DataPurchaseEntity p) {
    // When the purchase phone matches a saved contact, lift the nickname
    // into the title and keep the phone (plus any intl bundle) in the
    // subtitle. The reference stays visible on its own line. All three
    // lines in BillHistoryItem are maxLines:1 + ellipsis so long
    // nicknames or references can't blow out the row horizontally.
    DataBeneficiary? saved;
    if (p.phoneNumber.isNotEmpty) {
      saved = _savedByPhone[_normalizePhone(p.phoneNumber)];
    }
    final hasNickname =
        saved?.nickname != null && saved!.nickname!.trim().isNotEmpty;

    // For intl rows, show the dest bundle (e.g. "KES 200") in the subtitle
    // so users can tell at a glance what they bought in the foreign
    // currency, while the trailing amount shows what their wallet was
    // debited in the active locale currency.
    final destAmt = p.destAmount;
    final destCur = p.destCurrency;
    final intlBundle = p.isInternational && destAmt != null && destCur.isNotEmpty
        ? '$destCur ${destAmt.toStringAsFixed(2)}'
        : null;

    final title = hasNickname
        ? saved!.nickname!.trim()
        : (p.phoneNumber.isEmpty ? 'Data purchase' : p.phoneNumber);
    final String subtitle;
    final String? reference;
    if (hasNickname) {
      // Nickname lifted to title → show phone (+ intl bundle) as subtitle,
      // and keep the reference on its own line underneath.
      subtitle = intlBundle != null
          ? '${p.phoneNumber} \u00B7 $intlBundle'
          : p.phoneNumber;
      reference = p.reference;
    } else {
      // Preserve the pre-existing intl subtitle shape when there's no
      // saved contact to surface.
      subtitle = intlBundle != null
          ? '$intlBundle \u00B7 ${p.reference}'
          : p.reference;
      reference = null;
    }

    // Currency displayed is the one the wallet was charged in — NEVER
    // Reloadly's sender wallet currency. Prefer the entity's resolved
    // currency (from metadata.sender_currency); fall back to the user's
    // active locale currency from LocaleManager so we never accidentally
    // render a bare number.
    final active = GetIt.I<LocaleManager>().currentCurrency;
    final display = p.resolvedCurrency.isNotEmpty ? p.resolvedCurrency : active;
    final symbol = _currencyPrefix(display);

    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _primary.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Icon(Icons.wifi, color: _primary, size: 20.sp),
      ),
      title: title,
      subtitle: subtitle,
      reference: reference,
      date: p.createdAt,
      amount: p.amount,
      currencySymbol: symbol,
      // `displayStatus` collapses `awaiting_webhook`/`awaiting_verification`
      // to "Processing" (users don't care about webhooks) and promotes
      // refunded-via-source rows to "Refunded" — so the chip stays in
      // sync with the receipt-screen category.
      status: p.displayStatus,
      refundSource: p.refundSource.isEmpty ? null : p.refundSource,
      onTap: () => DataHistoryActionsSheet.show(
        context,
        p,
        countryCode: 'NG',
      ),
    );
  }

  /// Map ISO-4217 code to a short prefix for the trailing amount.
  /// Keeps the BillHistoryItem contract (takes a `currencySymbol`
  /// string) — codes we don't have a canonical symbol for render as
  /// `CODE ` so the number never appears unlabelled.
  static String _currencyPrefix(String code) {
    switch (code.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$code ';
    }
  }

  Widget _buildLoading() => Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(_primary),
        ),
      );

  Widget _buildEmpty() {
    final intl = _scope == 'intl';
    final contactFilter = _filterPhone != null;
    final title = contactFilter
        ? 'No purchases for ${_filterLabel ?? 'this contact'} yet'
        : (intl ? 'No international data yet' : 'No data purchases yet');
    final subtitle = contactFilter
        ? 'Older purchases past the 50-item window may not appear here. Clear the filter to see your full history.'
        : (intl
            ? 'International data is rolling out soon. When it ships, your purchases will appear here.'
            : 'Buy your first data bundle from the Local tab and it will show up here.');
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              contactFilter
                  ? Icons.person_search_outlined
                  : (intl ? Icons.public : Icons.history),
              color: _textSecondary,
              size: 56.sp,
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
            if (contactFilter) ...[
              SizedBox(height: 16.h),
              TextButton(
                onPressed: _clearContactFilter,
                child: Text(
                  'Clear filter',
                  style: TextStyle(
                    color: _primary,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) => Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline,
                  color: const Color(0xFFEF4444), size: 56.sp),
              SizedBox(height: 16.h),
              Text(
                'Couldn\u2019t load history',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _textSecondary,
                  fontSize: 12.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: _refresh,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Retry',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
