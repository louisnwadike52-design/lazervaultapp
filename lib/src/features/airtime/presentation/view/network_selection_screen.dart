import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';

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
    // Load providers if they weren't passed as arguments
    if (networkProviders.isEmpty && selectedCountry != null) {
      shouldLoadProviders = true;
      context.read<AirtimeCubit>().loadNetworkProviders(selectedCountry!.code);
    }
  }

  void _extractArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      // Handle both country object and countryCode scenarios
      selectedCountry = args['country'] as Country?;
      
      // If no country object but we have countryCode, create a default country
      if (selectedCountry == null && args['countryCode'] != null) {
        final countryCode = args['countryCode'] as String;
        // For now, default to Nigeria since most providers are Nigerian
        selectedCountry = Country(
          id: countryCode.toLowerCase(),
          code: countryCode,
          name: countryCode == 'NG' ? 'Nigeria' : countryCode,
          currency: countryCode == 'NG' ? 'NGN' : 'USD',
          dialCode: countryCode == 'NG' ? '+234' : '+1',
          flag: countryCode == 'NG' ? '🇳🇬' : '🌍',
          currencySymbol: countryCode == 'NG' ? '₦' : '\$',
        );
      }
      
      // Set default country if none provided
      selectedCountry ??= Country(
          id: 'ng',
          code: 'NG',
          name: 'Nigeria',
          currency: 'NGN',
          dialCode: '+234',
          flag: '🇳🇬',
          currencySymbol: '₦',
        );
      
      networkProviders = args['networkProviders'] as List<NetworkProvider>? ?? [];
    } else {
      // No arguments provided, set default country
      selectedCountry = Country(
        id: 'ng',
        code: 'NG',
        name: 'Nigeria',
        currency: 'NGN',
        dialCode: '+234',
        flag: '🇳🇬',
        currencySymbol: '₦',
      );
    }
  }

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
              
              // Content
              Expanded(
                child: shouldLoadProviders 
                    ? BlocConsumer<AirtimeCubit, AirtimeState>(
                        listener: (context, state) {
                          if (state is AirtimeNetworkProvidersError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to load providers: ${state.message}'),
                                backgroundColor: Colors.red,
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
                  'Select Network',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  selectedCountry != null 
                      ? '${selectedCountry!.flag} ${selectedCountry!.name} providers'
                      : 'Choose your network provider',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                    fontWeight: FontWeight.w400,
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

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          
          // Popular providers section
          _buildSectionHeader('Available Networks'),
          SizedBox(height: 16.h),
          
          ...providers.map((provider) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildProviderCard(provider),
          )),
          
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProviderCard(NetworkProvider provider) {
    return GestureDetector(
      onTap: () {
        // Ensure we have a country object, create a default one if needed
        final country = selectedCountry ?? Country(
          id: 'ng',
          code: 'NG',
          name: 'Nigeria',
          currency: 'NGN',
          dialCode: '+234',
          flag: '🇳🇬',
          currencySymbol: '₦',
        );
        
        context.read<AirtimeCubit>().selectNetworkProvider(country, provider);
        Get.toNamed(AppRoutes.airtimeRecipientInput, arguments: {
          'country': country,
          'networkProvider': provider,
        });
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Provider logo/icon
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: Color(int.parse(provider.primaryColor.replaceFirst('#', '0xFF'))),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Color(int.parse(provider.primaryColor.replaceFirst('#', '0xFF'))).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  provider.shortName.substring(0, 1),
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            
            SizedBox(width: 16.w),
            
            // Provider details
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
                  
                  if (provider.promoMessage != null)
                    Text(
                      provider.promoMessage!,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  
                  SizedBox(height: 8.h),
                  
                  // Prefixes
                  Wrap(
                    spacing: 4.w,
                    children: provider.prefixes.take(3).map((prefix) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        child: Text(
                          prefix,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.white.withValues(alpha: 0.8),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            
            // Discount badge and arrow
            Column(
              children: [
                if (provider.discount != null && provider.discount! > 0)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF10B981), Color(0xFF059669)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '${provider.discount!.toStringAsFixed(0)}% OFF',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                
                SizedBox(height: 8.h),
                
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withValues(alpha: 0.4),
                  size: 16.sp,
                ),
              ],
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
            size: 64.sp,
            color: Colors.white.withValues(alpha: 0.4),
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
            selectedCountry != null
                ? 'No network providers found for ${selectedCountry!.name}'
                : 'No network providers available',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Get.back(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF3B82F6),
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
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
          SizedBox(height: 24.h),
          Text(
            'Loading Network Providers...',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please wait while we fetch available networks',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
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
            color: Colors.red.withValues(alpha: 0.7),
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
              color: Colors.white.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Retry loading
                  if (selectedCountry != null) {
                    context.read<AirtimeCubit>().loadNetworkProviders(selectedCountry!.code);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B82F6),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
                  side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
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
    );
  }
} 