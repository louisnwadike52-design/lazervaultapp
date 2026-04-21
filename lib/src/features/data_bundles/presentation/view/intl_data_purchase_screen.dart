import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/intl_data_bundle.dart';
import '../../domain/entities/intl_data_operator.dart';
import '../cubit/intl_data_cubit.dart';
import 'intl_data_checkout_screen.dart';

/// Screen 1 of the international data purchase flow.
/// Country picker -> Operator picker -> Bundle grid.
/// When a bundle is tapped, navigates to [IntlDataCheckoutScreen].
class IntlDataPurchaseScreen extends StatelessWidget {
  IntlDataPurchaseScreen({super.key});

  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _primary = Color(0xFF4E03D0);
  static const Color _text2 = Color(0xFF9CA3AF);

  /// User's active locale currency (e.g. NGN for Nigeria). This is what the
  /// wallet is debited in — mirrors intl_airtime_purchase_screen's pattern.
  final String _activeCurrency = GetIt.I<LocaleManager>().currentCurrency;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocBuilder<IntlDataCubit, IntlDataState>(
                builder: (context, state) {
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 24.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _sectionHeader('1. Country'),
                        SizedBox(height: 10.h),
                        _countryGrid(context, state),
                        if (state.selectedCountryCode.isNotEmpty) ...[
                          SizedBox(height: 20.h),
                          _sectionHeader('2. Operator'),
                          SizedBox(height: 10.h),
                          _operatorList(context, state),
                        ],
                        if (state.selectedOperator != null) ...[
                          SizedBox(height: 20.h),
                          _sectionHeader('3. Bundle'),
                          SizedBox(height: 10.h),
                          _bundleGrid(context, state),
                        ],
                      ],
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
            'International Data',
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

  Widget _sectionHeader(String s) => Text(
        s,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      );

  /// Country selector — tap-to-open field that launches a searchable
  /// bottomsheet. Replaces the old pill grid: 36 pills overwhelmed the
  /// page and made the list impossible to search. Selected state shows
  /// the flag + country name; placeholder prompts when unset.
  Widget _countryGrid(BuildContext context, IntlDataState state) {
    final selected = state.selectedCountryCode.isEmpty
        ? null
        : IntlDataCountry.byCode(state.selectedCountryCode);
    return GestureDetector(
      onTap: () => _openCountryPicker(context),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          children: [
            if (selected != null) ...[
              Text(selected.flag, style: TextStyle(fontSize: 20.sp)),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selected.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${selected.code} · ${selected.dial}',
                      style: TextStyle(color: _text2, fontSize: 11.sp),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Icon(Icons.public, color: _text2, size: 20.sp),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Choose a country',
                  style: TextStyle(color: _text2, fontSize: 15.sp),
                ),
              ),
            ],
            Icon(Icons.keyboard_arrow_down, color: _text2, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _openCountryPicker(BuildContext context) async {
    final cubit = context.read<IntlDataCubit>();
    final picked = await showModalBottomSheet<IntlDataCountry>(
      context: context,
      isScrollControlled: true,
      backgroundColor: _card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => _CountryPickerSheet(
        selectedCode: cubit.state.selectedCountryCode,
      ),
    );
    if (picked != null) {
      cubit.loadOperators(picked.code, picked.name);
    }
  }

  Widget _operatorList(BuildContext context, IntlDataState state) {
    if (state.operatorsLoading) {
      return _pill('Loading operators\u2026');
    }
    if (state.operatorsError != null) {
      return _errorPill(state.operatorsError!);
    }
    if (state.operators.isEmpty) {
      return _pill('No data operators for this country.');
    }
    return Column(
      children: state.operators
          .map((op) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: _operatorTile(
                    context, op, state.selectedOperator?.id == op.id),
              ))
          .toList(),
    );
  }

  Widget _operatorTile(
      BuildContext context, IntlDataOperator op, bool selected) {
    return GestureDetector(
      onTap: () => context.read<IntlDataCubit>().loadBundles(op),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: selected
                ? _primary
                : Colors.white.withValues(alpha: 0.05),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: _primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.signal_cellular_alt,
                  color: _primary, size: 18.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(op.operatorName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(height: 2.h),
                  Text('${op.bundleCount} bundles \u2022 ${op.destCurrencyCode}',
                      style: TextStyle(color: _text2, fontSize: 11.sp)),
                ],
              ),
            ),
            if (selected)
              Icon(Icons.check_circle, color: _primary, size: 18.sp),
          ],
        ),
      ),
    );
  }

  Widget _bundleGrid(BuildContext context, IntlDataState state) {
    if (state.bundlesLoading) return _pill('Loading bundles\u2026');
    if (state.bundlesError != null) return _errorPill(state.bundlesError!);
    if (state.bundles.isEmpty) return _pill('No bundles available.');

    // Resolve the country spec for navigation args.
    final country =
        IntlDataCountry.byCode(state.selectedCountryCode);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: state.bundles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 1.6,
      ),
      itemBuilder: (_, i) {
        final b = state.bundles[i];
        return GestureDetector(
          onTap: () {
            if (country == null || state.selectedOperator == null) return;
            Get.toNamed(
              AppRoutes.intlDataCheckout,
              arguments: {
                'country': country,
                'operator': state.selectedOperator!,
                'bundle': b,
              },
            );
          },
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: _card,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.05),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${b.destCurrencyCode} ${b.localAmount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  b.description,
                  style: TextStyle(color: _text2, fontSize: 11.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                // Show cost in the user's active locale currency (e.g. NGN)
                // computed from dest amount * FX rate, mirroring intl airtime.
                _youPayLabel(b, state),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _pill(String s) => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(s, style: TextStyle(color: _text2, fontSize: 12.sp)),
      );

  Widget _errorPill(String s) => Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
              color: const Color(0xFFEF4444).withValues(alpha: 0.3)),
        ),
        child: Text(s,
            style: TextStyle(color: const Color(0xFFEF4444), fontSize: 12.sp)),
      );

  /// "You pay" label in the user's active locale currency, computed from
  /// dest amount * Reloadly FX rate. Prefers the bundle-level `fxRate`
  /// (snapshotted live from Reloadly at bundle-list time) over the
  /// operator rate. When neither is available, we render "Rate
  /// unavailable" rather than falling back to Reloadly's sender wallet
  /// currency (GBP/USD) — users must see prices in their own currency.
  Widget _youPayLabel(IntlDataBundle b, IntlDataState state) {
    final op = state.selectedOperator;
    final rate = b.fxRate > 0 ? b.fxRate : (op?.fxRate ?? 0);
    if (rate <= 0) {
      return Text(
        'Rate unavailable',
        style: TextStyle(color: _text2, fontSize: 11.sp),
      );
    }
    final senderAmt = b.localAmount * rate;
    return Text(
      'You pay $_activeCurrency ${senderAmt.toStringAsFixed(2)}',
      style: TextStyle(color: _text2, fontSize: 11.sp),
    );
  }
}

/// Bottomsheet country picker with live search. Search matches the
/// country name, ISO-2 code, or dial code (case-insensitive) so users
/// can type "KE" / "+254" / "kenya" and get the same result. Selecting
/// a country pops the sheet with the [IntlDataCountry] — caller wires
/// it into whatever state it needs.
class _CountryPickerSheet extends StatefulWidget {
  final String selectedCode;

  const _CountryPickerSheet({required this.selectedCode});

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IntlDataCountry> _filtered() {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return IntlDataCountry.all;
    return IntlDataCountry.all.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.code.toLowerCase().contains(q) ||
          c.dial.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final results = _filtered();
    const primary = Color(0xFF4E03D0);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: FractionallySizedBox(
        heightFactor: 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                'Select country',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (v) => setState(() => _query = v),
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                decoration: InputDecoration(
                  hintText: 'Search by name, code, or dial…',
                  hintStyle: TextStyle(
                    color: const Color(0xFF6B7280),
                    fontSize: 14.sp,
                  ),
                  prefixIcon: Icon(Icons.search,
                      color: const Color(0xFF6B7280), size: 20.sp),
                  filled: true,
                  fillColor: const Color(0xFF0A0A0A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 14.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            Expanded(
              child: results.isEmpty
                  ? Center(
                      child: Text(
                        'No countries match "$_query"',
                        style: TextStyle(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 14.sp,
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: results.length,
                      separatorBuilder: (_, __) => Divider(
                        color: const Color(0xFF2D2D2D),
                        height: 1.h,
                      ),
                      itemBuilder: (ctx, i) {
                        final c = results[i];
                        final isSelected = c.code == widget.selectedCode;
                        return ListTile(
                          onTap: () => Navigator.of(ctx).pop(c),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 4.w),
                          leading: Text(c.flag,
                              style: TextStyle(fontSize: 24.sp)),
                          title: Text(
                            c.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${c.code} · ${c.dial}',
                            style: TextStyle(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 12.sp,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(Icons.check_circle,
                                  color: primary, size: 20.sp)
                              : null,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
