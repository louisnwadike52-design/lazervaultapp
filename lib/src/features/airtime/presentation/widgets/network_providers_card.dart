import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../../../../../core/types/app_routes.dart';

/// Static Nigerian network providers for instant display (no API call needed).
/// These are the canonical providers from our database — IDs and operator IDs
/// match the actual records so the purchase flow works immediately.
final List<NetworkProvider> _staticNigerianProviders = [
  NetworkProvider(
    id: 'mtn-ng',
    type: NetworkProviderType.mtn,
    name: 'MTN',
    shortName: 'MTN',
    logo: '',
    primaryColor: '#FFCC00',
    prefixes: ['0803', '0806', '0810', '0813', '0814', '0816', '0903', '0906', '0913', '0916'],
    countryCode: 'NG',
    isActive: true,
    minAmount: 50,
    maxAmount: 50000,
    operatorId: 'MTN',
    reloadlyOperatorId: '341',
  ),
  NetworkProvider(
    id: 'airtel-ng',
    type: NetworkProviderType.airtel,
    name: 'Airtel',
    shortName: 'Airtel',
    logo: '',
    primaryColor: '#FF0000',
    prefixes: ['0701', '0708', '0802', '0808', '0812', '0901', '0902', '0904', '0907', '0912'],
    countryCode: 'NG',
    isActive: true,
    minAmount: 50,
    maxAmount: 50000,
    operatorId: 'AIRTEL',
    reloadlyOperatorId: '340',
  ),
  NetworkProvider(
    id: 'glo-ng',
    type: NetworkProviderType.glo,
    name: 'Glo',
    shortName: 'Glo',
    logo: '',
    primaryColor: '#00AA00',
    prefixes: ['0705', '0805', '0807', '0811', '0815', '0905', '0915'],
    countryCode: 'NG',
    isActive: true,
    minAmount: 50,
    maxAmount: 50000,
    operatorId: 'GLO',
    reloadlyOperatorId: '344',
  ),
  NetworkProvider(
    id: '9mobile-ng',
    type: NetworkProviderType.ninemobile,
    name: '9mobile',
    shortName: '9mobile',
    logo: '',
    primaryColor: '#006B3F',
    prefixes: ['0809', '0817', '0818', '0908', '0909'],
    countryCode: 'NG',
    isActive: true,
    minAmount: 50,
    maxAmount: 50000,
    operatorId: '9MOBILE',
    reloadlyOperatorId: '342',
  ),
];

class NetworkProvidersCard extends StatelessWidget {
  const NetworkProvidersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                'Network Providers',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
              BlocBuilder<AirtimeCubit, AirtimeState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => _showAllProvidersSheet(context, state),
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF4E03D0),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Show static providers immediately, update when API response arrives
          BlocBuilder<AirtimeCubit, AirtimeState>(
            buildWhen: (previous, current) {
              return current is AirtimeNetworkProvidersLoaded ||
                  current is AirtimeNetworkProvidersLoading ||
                  current is AirtimeNetworkProvidersError ||
                  current is AirtimeInitial;
            },
            builder: (context, state) {
              if (state is AirtimeNetworkProvidersLoaded &&
                  state.providers.isNotEmpty) {
                // API providers loaded — use them (most up-to-date)
                return _buildProvidersList(state.providers);
              }
              // Show static providers immediately (no loading spinner)
              return _buildProvidersList(_staticNigerianProviders);
            },
          ),
        ],
      ),
    );
  }

  void _showAllProvidersSheet(BuildContext context, AirtimeState state) {
    final providers = (state is AirtimeNetworkProvidersLoaded && state.providers.isNotEmpty)
        ? state.providers
        : _staticNigerianProviders;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
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
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.cell_tower,
                      color: const Color(0xFF4E03D0),
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Network Providers',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Select a network to buy airtime',
                          style: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(sheetContext),
                    child: Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.close,
                        color: const Color(0xFF9CA3AF),
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: providers.length,
                itemBuilder: (ctx, index) {
                  final provider = providers[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(sheetContext);
                      Get.find<AirtimeCubit>().selectNetworkProvider(
                        DefaultCountries.nigeria,
                        provider,
                      );
                      Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
                        'country': DefaultCountries.nigeria,
                        'networkProvider': provider,
                        'isBuyForSelf': true,
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F1F1F),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 44.w,
                            height: 44.w,
                            decoration: BoxDecoration(
                              color: provider.type.color,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Center(
                              child: Text(
                                provider.name.isNotEmpty ? provider.name[0] : '?',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 14.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.name,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  'Prefixes: ${provider.prefixes.take(4).join(", ")}${provider.prefixes.length > 4 ? "..." : ""}',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xFF9CA3AF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: const Color(0xFF4E03D0),
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildProvidersList(List<NetworkProvider> providers) {
    return Row(
      children: providers.take(4).map((provider) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: _buildProviderItem(provider),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProviderItem(NetworkProvider provider) {
    return GestureDetector(
      onTap: () {
        Get.find<AirtimeCubit>().selectNetworkProvider(
          DefaultCountries.nigeria,
          provider,
        );
        Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
          'country': DefaultCountries.nigeria,
          'networkProvider': provider,
          'isBuyForSelf': true,
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: provider.type.color,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  provider.name.isNotEmpty ? provider.name[0] : '?',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              provider.shortName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
