import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/src/features/widgets/dashboard/country_rate_card.dart';
import 'package:get/get.dart';

class ExchangeRates extends StatefulWidget {
  const ExchangeRates({super.key});

  @override
  State<ExchangeRates> createState() => _ExchangeRatesState();
}

class _ExchangeRatesState extends State<ExchangeRates> {
  List<List<CountryRateDetails>> countryRateDetails = [];

  final List<Country> countries = [
    Country(
      flag: '🇺🇸', // US flag
      name: 'United States',
      code: 'USD',
      symbol: '\$',
    ),
    Country(
      flag: '🇪🇺', // EU flag
      name: 'European Union',
      code: 'EUR',
      symbol: '€',
    ),
    Country(
      flag: '🇬🇧', // UK flag
      name: 'United Kingdom',
      code: 'GBP',
      symbol: '£',
    ),
    Country(
      flag: '🇨🇦', // Canada flag
      name: 'Canada',
      code: 'CAD',
      symbol: 'C\$',
    ),
    Country(
      flag: '🇦🇺', // Australia flag
      name: 'Australia',
      code: 'AUD',
      symbol: 'A\$',
    ),
    Country(
      flag: '🇯🇵', // Japan flag
      name: 'Japan',
      code: 'JPY',
      symbol: '¥',
    ),
    Country(
      flag: '🇨🇭', // Switzerland flag
      name: 'Switzerland',
      code: 'CHF',
      symbol: 'Fr',
    ),
    Country(
      flag: '🇨🇳', // China flag
      name: 'China',
      code: 'CNY',
      symbol: '¥',
    ),
  ];

  final List<ExchangeRate> exchangeRates = [
    ExchangeRate(
      base: 'USD',
      timestamp: DateTime.now(),
      rates: {
        'EUR': 0.85,
        'GBP': 0.72,
        'CAD': 1.34,
        'AUD': 1.45,
        'JPY': 110.23,
        'CHF': 0.91,
        'CNY': 6.45,
      },
    ),
    ExchangeRate(
      base: 'USD',
      timestamp: DateTime.now(),
      rates: {
        'EUR': 0.85,
        'GBP': 0.72,
        'CAD': 1.34,
        'AUD': 1.45,
        'JPY': 110.23,
        'CHF': 0.91,
        'CNY': 6.45,
      },
    ),
  ];

  @override
  void initState() {
    super.initState();
    countryRateDetails = exchangeRates.map((exchangeRate) {
      final from =
          countries.firstWhere((country) => country.code == exchangeRate.base);
      final to = exchangeRate.rates.keys
          .toList()
          .map(
              (code) => countries.firstWhere((country) => country.code == code))
          .toList();
      return to
          .map((country) => CountryRateDetails(
                from: from,
                to: country,
                rate: exchangeRate.rates[country.code]!,
              ))
          .toList();
    }).toList();
  }

  double getResponsiveHeight() {
    if (Get.width >= 1200) return Get.height * 0.35; // Desktop
    if (Get.width >= 768) return Get.height * 0.3; // Tablet
    if (Get.width >= 480) return Get.height * 0.25; // Large Phone
    return Get.height * 0.21; // Small Phone
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280.h, // Fixed height instead of responsive
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.currency_exchange_rounded,
                        color: Color.fromARGB(255, 78, 3, 208),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Flexible(
                      child: Text(
                        'Exchange Rates',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                          letterSpacing: 0.5,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),

          // Rates List
          SizedBox(
            height: 160.h, // Fixed height for list container
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: countryRateDetails.expand((list) => list).length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final flatList = countryRateDetails.expand((list) => list).toList();
                return Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: CountryRateCard(
                    countryRateDetails: flatList[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
