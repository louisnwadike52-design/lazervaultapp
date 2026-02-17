import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../widgets/airtime_step_indicator.dart';

class NetworkSelectionScreen extends StatefulWidget {
  const NetworkSelectionScreen({super.key});

  @override
  State<NetworkSelectionScreen> createState() => _NetworkSelectionScreenState();
}

class _NetworkSelectionScreenState extends State<NetworkSelectionScreen> {
  Country? selectedCountry;
  List<NetworkProvider> networkProviders = [];
  bool shouldLoadProviders = false;

  @override
  void initState() {
    super.initState();
    _extractArguments();
    if (networkProviders.isEmpty) {
      shouldLoadProviders = true;
      final countryCode = selectedCountry?.code ?? 'NG';
      context.read<AirtimeCubit>().loadNetworkProviders(countryCode);
    }
  }

  void _extractArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      selectedCountry = args['country'] as Country?;

      if (selectedCountry == null && args['countryCode'] != null) {
        final countryCode = args['countryCode'] as String;
        selectedCountry = Country(
          id: countryCode.toLowerCase(),
          code: countryCode,
          name: countryCode == 'NG' ? 'Nigeria' : countryCode,
          currency: countryCode == 'NG' ? 'NGN' : 'USD',
          dialCode: countryCode == 'NG' ? '+234' : '+1',
          flag: countryCode == 'NG' ? '\u{1F1F3}\u{1F1EC}' : '\u{1F30D}',
          currencySymbol: countryCode == 'NG' ? '\u{20A6}' : '\$',
        );
      }

      networkProviders =
          args['networkProviders'] as List<NetworkProvider>? ?? [];
    }

    // Default to Nigeria
    selectedCountry ??= DefaultCountries.nigeria;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const AirtimeStepIndicator(currentStep: 0),
            Expanded(
              child: shouldLoadProviders
                  ? BlocConsumer<AirtimeCubit, AirtimeState>(
                      listener: (context, state) {
                        if (state is AirtimeNetworkProvidersError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Failed to load providers: ${state.message}'),
                              backgroundColor: const Color(0xFFEF4444),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AirtimeNetworkProvidersLoaded &&
                            state.countryCode == selectedCountry?.code) {
                          return _buildProvidersList(state.providers);
                        } else if (state is AirtimeNetworkProvidersLoading) {
                          return _buildLoadingState();
                        } else if (state is AirtimeNetworkProvidersError) {
                          return _buildErrorState(state.message);
                        }
                        return _buildLoadingState();
                      },
                    )
                  : _buildProvidersList(networkProviders),
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
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Network',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${selectedCountry?.flag ?? ''} ${selectedCountry?.name ?? 'Nigeria'} providers',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProvidersList(List<NetworkProvider> providers) {
    if (providers.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: providers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: _buildProviderCard(providers[index]),
        );
      },
    );
  }

  Widget _buildProviderCard(NetworkProvider provider) {
    return GestureDetector(
      onTap: () {
        final country = selectedCountry ?? DefaultCountries.nigeria;

        context.read<AirtimeCubit>().selectNetworkProvider(country, provider);
        Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
          'country': country,
          'networkProvider': provider,
        });
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 52.w,
              height: 52.w,
              decoration: BoxDecoration(
                color: Color(int.parse(
                    provider.primaryColor.replaceFirst('#', '0xFF'))),
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Center(
                child: Text(
                  provider.shortName.substring(0, 1),
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
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
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (provider.promoMessage != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      provider.promoMessage!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ],
                  SizedBox(height: 6.h),
                  Wrap(
                    spacing: 4.w,
                    children: provider.prefixes.take(3).map((prefix) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          prefix,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF9CA3AF),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: 56.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Networks Available',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No network providers found for ${selectedCountry?.name ?? 'this country'}',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF9CA3AF),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Go Back',
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

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor:
                const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
          SizedBox(height: 24.h),
          Text(
            'Loading Network Providers...',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
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
            Icon(
              Icons.error_outline,
              size: 56.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to Load Providers',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedCountry != null) {
                      context
                          .read<AirtimeCubit>()
                          .loadNetworkProviders(selectedCountry!.code);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                SizedBox(width: 12.w),
                OutlinedButton(
                  onPressed: () => Get.back(),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF2D2D2D)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Go Back',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
