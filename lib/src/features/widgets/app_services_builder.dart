import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';

// Quick Services carousel - 3 rows with reduced indicator spacing
class AppServicesBuilder extends StatefulWidget {
  const AppServicesBuilder({super.key});

  @override
  State<AppServicesBuilder> createState() => _AppServicesBuilderState();
}

class _AppServicesBuilderState extends State<AppServicesBuilder> {
  int _currentIndex = 0;
  static const int _itemsPerRow = 4;
  static const int _maxRows = 3;
  static const int _itemsPerPage = _itemsPerRow * _maxRows; // 12 items per page
  final List<AppService> appServices = [
    const AppService(
        serviceName: AppServiceName.sendFunds,
        serviceImg: AppServiceImg.sendFunds),
    const AppService(
        serviceName: AppServiceName.batchTransfer,
        serviceImg: AppServiceImg.batchTransfer),
    const AppService(
        serviceName: AppServiceName.tagPay,
        serviceImg: AppServiceImg.tagPay),
    const AppService(
        serviceName: AppServiceName.invoice,
        serviceImg: AppServiceImg.invoice),
    const AppService(
        serviceName: AppServiceName.payElectricityBill,
        serviceImg: AppServiceImg.payElectricityBill),
    const AppService(
        serviceName: AppServiceName.invest,
        serviceImg: AppServiceImg.invest),
    const AppService(
        serviceName: AppServiceName.exchange,
        serviceImg: AppServiceImg.exchange),
    const AppService(
        serviceName: AppServiceName.crypto,
        serviceImg: AppServiceImg.crypto),
    const AppService(
        serviceName: AppServiceName.giftCards,
        serviceImg: AppServiceImg.giftCards),
    const AppService(
        serviceName: AppServiceName.aiScanToPay,
        serviceImg: AppServiceImg.aiScanToPay),
    const AppService(
        serviceName: AppServiceName.barcodeQuickPay,
        serviceImg: AppServiceImg.barcodeQuickPay),
    const AppService(
        serviceName: AppServiceName.groupAccount,
        serviceImg: AppServiceImg.groupAccount),
    const AppService(
        serviceName: AppServiceName.insurance,
        serviceImg: AppServiceImg.insurance),
    const AppService(
        serviceName: AppServiceName.airtime,
        serviceImg: AppServiceImg.airtime),
    const AppService(
        serviceName: AppServiceName.autoSave,
        serviceImg: AppServiceImg.autoSave),
  ];

  // Split services into pages
  List<List<AppService>> _getServicePages() {
    List<List<AppService>> pages = [];
    for (int i = 0; i < appServices.length; i += _itemsPerPage) {
      int end = (i + _itemsPerPage < appServices.length)
          ? i + _itemsPerPage
          : appServices.length;
      pages.add(appServices.sublist(i, end));
    }
    return pages;
  }

  // Calculate carousel height based on grid content
  double _calculateCarouselHeight(BuildContext context) {
    // Screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Container horizontal padding (left + right)
    final containerHorizontalPadding = 16.w * 2;

    // Available width for grid
    final availableWidth = screenWidth - containerHorizontalPadding;

    // Grid spacing
    const crossAxisSpacing = 8.0; // spacing between columns
    const mainAxisSpacing = 8.0;  // spacing between rows
    const childAspectRatio = 0.85;

    // Calculate item width
    // Formula: (availableWidth - (crossAxisSpacing × (columns - 1))) / columns
    final itemWidth = (availableWidth - (crossAxisSpacing.w * (_itemsPerRow - 1))) / _itemsPerRow;

    // Calculate item height from aspect ratio
    // If aspectRatio = width/height, then height = width/aspectRatio
    final itemHeight = itemWidth / childAspectRatio;

    // Calculate total height for 3 rows
    // Formula: (itemHeight × rows) + (mainAxisSpacing × (rows - 1))
    final totalHeight = (itemHeight * _maxRows) + (mainAxisSpacing.h * (_maxRows - 1));

    return totalHeight;
  }

  @override
  Widget build(BuildContext context) {
    final servicePages = _getServicePages();
    final carouselHeight = _calculateCarouselHeight(context);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Quick Services",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 78, 3, 208),
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14.sp,
                      color: Color.fromARGB(255, 78, 3, 208),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Services Carousel
          CarouselSlider.builder(
            itemCount: servicePages.length,
            options: CarouselOptions(
              height: carouselHeight, // Dynamic height based on content
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                setState(() => _currentIndex = index);
              },
            ),
            itemBuilder: (context, pageIndex, realIndex) {
              final servicesOnPage = servicePages[pageIndex];

              return GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _itemsPerRow,
                  crossAxisSpacing: 8.w,
                  mainAxisSpacing: 8.h,
                  childAspectRatio: 0.85,
                ),
                itemCount: servicesOnPage.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return AppServiceBuilder(appService: servicesOnPage[index]);
                },
              );
            },
          ),

          // Carousel Indicators (only show if more than 1 page)
          if (servicePages.length > 1) ...[
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                servicePages.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: _currentIndex == index ? 24.w : 8.w,
                  height: 8.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Color.fromARGB(255, 78, 3, 208)
                        : Color.fromARGB(255, 78, 3, 208).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
