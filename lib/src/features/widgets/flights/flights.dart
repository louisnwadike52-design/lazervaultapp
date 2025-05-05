import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';

class Flights extends StatefulWidget {
  const Flights({super.key});

  @override
  State<Flights> createState() => _FlightsState();
}

class _FlightsState extends State<Flights> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  DateTime? _departureDate;
  DateTime? _returnDate;
  int _passengerCount = 1;
  String _selectedClass = 'Economy';
  bool _isRoundTrip = true;

  final List<String> _travelClasses = ['Economy', 'Business', 'First Class'];
  
  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Align(
              alignment: Alignment.topLeft,
              child: BackNavigator(),
            ),
          ),
          // Header Section with reduced padding
          Container(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

          
                Text(
                  'Book Your\nFlight',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.sp, // Slightly reduced for better fit
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Find the best prices for your next trip',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),

          // Main Booking Card with reduced margin
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                // Trip Type Toggle
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      _buildTripTypeButton('Round Trip', true),
                      SizedBox(width: 12.w),
                      _buildTripTypeButton('One Way', false),
                    ],
                  ),
                ),

                // From Field
                _buildLocationField(
                  'From',
                  Icons.flight_takeoff_rounded,
                  _fromController,
                  'Departure City',
                ),

                // Swap Button
                Center(
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.swap_vert_rounded,
                        color: Color.fromARGB(255, 78, 3, 208),
                      ),
                      onPressed: () {
                        final temp = _fromController.text;
                        _fromController.text = _toController.text;
                        _toController.text = temp;
                      },
                    ),
                  ),
                ),

                // To Field
                _buildLocationField(
                  'To',
                  Icons.flight_land_rounded,
                  _toController,
                  'Destination City',
                ),

                // Dates Section
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildDateField(
                          'Departure',
                          _departureDate,
                          (date) => setState(() => _departureDate = date),
                        ),
                      ),
                      if (_isRoundTrip) ...[
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _buildDateField(
                            'Return',
                            _returnDate,
                            (date) => setState(() => _returnDate = date),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Passengers and Class
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildPassengerCounter(),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildClassSelector(),
                      ),
                    ],
                  ),
                ),

                // Search Button
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () => _searchFlights(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 78, 3, 208),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Search Flights',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Popular Destinations with updated design
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Destinations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 160.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    children: [
                      _buildDestinationCard(
                        'London',
                        'United Kingdom',
                        Icons.account_balance_rounded,
                        '£299',
                      ),
                      _buildDestinationCard(
                        'Paris',
                        'France',
                        Icons.architecture_rounded,
                        '£249',
                      ),
                      _buildDestinationCard(
                        'New York',
                        'United States',
                        Icons.location_city_rounded,
                        '£499',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripTypeButton(String label, bool isRoundTrip) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _isRoundTrip = isRoundTrip),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: _isRoundTrip == isRoundTrip
                ? Color.fromARGB(255, 78, 3, 208)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _isRoundTrip == isRoundTrip
                    ? Colors.white
                    : Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField(
    String label,
    IconData icon,
    TextEditingController controller,
    String hint,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  icon,
                  color: Color.fromARGB(255, 78, 3, 208),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateField(
    String label,
    DateTime? selectedDate,
    Function(DateTime?) onDateSelected,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
            );
            if (date != null) onDateSelected(date);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today_rounded,
                  color: Color.fromARGB(255, 78, 3, 208),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Text(
                  selectedDate != null
                      ? DateFormat('MMM d, y').format(selectedDate)
                      : 'Select Date',
                  style: TextStyle(
                    color: selectedDate != null
                        ? Colors.black
                        : Colors.grey.shade400,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPassengerCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Passengers',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.remove_circle_outline),
                color: Color.fromARGB(255, 78, 3, 208),
                onPressed: () {
                  if (_passengerCount > 1) {
                    setState(() => _passengerCount--);
                  }
                },
              ),
              Text(
                '$_passengerCount',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                color: Color.fromARGB(255, 78, 3, 208),
                onPressed: () {
                  setState(() => _passengerCount++);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildClassSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Class',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 4.h,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: DropdownButton<String>(
            value: _selectedClass,
            isExpanded: true,
            underline: SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down_rounded,
              color: Color.fromARGB(255, 78, 3, 208),
            ),
            items: _travelClasses.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedClass = value);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDestinationCard(
    String city,
    String country,
    IconData icon,
    String price,
  ) {
    return Container(
      width: 150.w,
      margin: EdgeInsets.only(right: 12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 129, 73, 226),
            Color.fromARGB(255, 98, 37, 208),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 78, 3, 208).withOpacity(0.2),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32.sp,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            city,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            country,
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 12.sp,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'from $price',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _searchFlights() {
    if (_fromController.text.isEmpty || _toController.text.isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please enter departure and destination cities',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
        borderRadius: 12,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    if (_departureDate == null) {
      Get.snackbar(
        'Missing Information',
        'Please select departure date',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
        borderRadius: 12,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    if (_isRoundTrip && _returnDate == null) {
      Get.snackbar(
        'Missing Information',
        'Please select return date',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(16),
        borderRadius: 12,
        duration: Duration(seconds: 3),
        icon: Icon(Icons.error_outline, color: Colors.white),
      );
      return;
    }

    // Show success snackbar
    Get.snackbar(
      'Searching Flights',
      'Looking for the best options...',
      backgroundColor: Color.fromARGB(255, 78, 3, 208),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      duration: Duration(seconds: 2),
      icon: Icon(Icons.flight_takeoff_rounded, color: Colors.white),
    );

    // TODO: Implement navigation to search results screen
    print('Searching flights...');
    print('From: ${_fromController.text}');
    print('To: ${_toController.text}');
    print('Departure: $_departureDate');
    print('Return: $_returnDate');
    print('Passengers: $_passengerCount');
    print('Class: $_selectedClass');
  }
}
