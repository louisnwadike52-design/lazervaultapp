import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/intl_airtime_country.dart';
import '../cubit/intl_airtime_cubit.dart';
import '../cubit/intl_airtime_state.dart';
import '../widgets/airtime_shimmer.dart';

class IntlCountrySelectionScreen extends StatefulWidget {
  const IntlCountrySelectionScreen({super.key});

  @override
  State<IntlCountrySelectionScreen> createState() =>
      _IntlCountrySelectionScreenState();
}

class _IntlCountrySelectionScreenState
    extends State<IntlCountrySelectionScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  static const _popularCodes = ['GH', 'KE', 'ZA', 'IN', 'GB', 'US', 'CA', 'DE'];

  @override
  void initState() {
    super.initState();
    context.read<IntlAirtimeCubit>().loadCountries();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text.toLowerCase());
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<IntlAirtimeCountry> _filter(List<IntlAirtimeCountry> all) {
    if (_searchQuery.isEmpty) return all;
    return all.where((c) =>
        c.countryName.toLowerCase().contains(_searchQuery) ||
        c.countryCode.toLowerCase().contains(_searchQuery)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildSearch(),
          Expanded(
            child: BlocBuilder<IntlAirtimeCubit, IntlAirtimeState>(
              builder: (context, state) {
                if (state is IntlAirtimeLoading ||
                    state is IntlAirtimeInitial) {
                  return const IntlCountryShimmer(itemCount: 8);
                }
                if (state is IntlAirtimeError) {
                  return _buildError(state.message);
                }
                if (state is IntlAirtimeCountriesLoaded) {
                  return _buildList(state.countries);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() => AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          'Select Country',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      );

  Widget _buildSearch() => Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search countries...',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFF9CA3AF)),
            border: InputBorder.none,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      );

  Widget _buildList(List<IntlAirtimeCountry> all) {
    final filtered = _filter(all);
    if (filtered.isEmpty) {
      return Center(
        child: Text('No countries found',
            style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
      );
    }

    final popular = filtered
        .where((c) => _popularCodes.contains(c.countryCode))
        .toList()
      ..sort((a, b) =>
          _popularCodes.indexOf(a.countryCode) -
          _popularCodes.indexOf(b.countryCode));
    final others =
        filtered.where((c) => !_popularCodes.contains(c.countryCode)).toList()
          ..sort((a, b) => a.countryName.compareTo(b.countryName));

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        if (popular.isNotEmpty && _searchQuery.isEmpty) ...[
          _sectionLabel('Popular Countries'),
          ...popular.map(_countryTile),
          SizedBox(height: 8.h),
        ],
        if (others.isNotEmpty || _searchQuery.isNotEmpty) ...[
          if (_searchQuery.isEmpty) _sectionLabel('All Countries'),
          ...(others.isEmpty ? popular : others).map(_countryTile),
        ],
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _sectionLabel(String label) => Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
        child: Text(
          label,
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      );

  Widget _countryTile(IntlAirtimeCountry country) => GestureDetector(
        onTap: () => Get.toNamed(
          AppRoutes.intlAirtimePurchase,
          arguments: {'country': country},
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text(
                country.flagEmoji.isNotEmpty ? country.flagEmoji : '🌍',
                style: TextStyle(fontSize: 28.sp),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      country.countryName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${country.dialCode}  •  ${country.currencyCode}',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (country.operatorCount > 0)
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    '${country.operatorCount} networks',
                    style: TextStyle(
                      color: const Color(0xFF4E03D0),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              SizedBox(width: 8.w),
              const Icon(Icons.chevron_right,
                  color: Color(0xFF9CA3AF), size: 20),
            ],
          ),
        ),
      );

  Widget _buildError(String message) => Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Color(0xFFEF4444), size: 48),
              SizedBox(height: 16.h),
              Text(message,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp)),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () =>
                    context.read<IntlAirtimeCubit>().loadCountries(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
}
