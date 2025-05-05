import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/countries.dart';

class CountryRateCard extends StatefulWidget {
  final CountryRateDetails countryRateDetails;
  const CountryRateCard({super.key, required this.countryRateDetails});

  @override
  State<CountryRateCard> createState() => _CountryRateCardState();
}

class _CountryRateCardState extends State<CountryRateCard> {
  @override
  Widget build(BuildContext context) {
    final bool isPositive = widget.countryRateDetails.rate > 0;
    
    return SizedBox(
      width: 180.w,
      height: 220.h,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white,
              Color.fromARGB(255, 78, 3, 208).withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Currency Header
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        widget.countryRateDetails.to.flag,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.countryRateDetails.to.code,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.countryRateDetails.to.name,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Rate Value
                        Text(
                          '${widget.countryRateDetails.rate * 1000}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            letterSpacing: 0.5,
                          ),
                        ),
                    
                        // Rate Change
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: isPositive 
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isPositive 
                                    ? Icons.trending_up_rounded
                                    : Icons.trending_down_rounded,
                                size: 14.sp,
                                color: isPositive ? Colors.green : Colors.red,
                              ),
                              SizedBox(width: 2.w),
                              Text(
                                '${widget.countryRateDetails.rate}%',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isPositive ? Colors.green : Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Base Currency
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.03),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Base: ',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        widget.countryRateDetails.from.code,
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
