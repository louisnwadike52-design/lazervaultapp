import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/data/app_data.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/core/types/recipient.dart';
import 'package:lazervault/src/features/widgets/avatar_with_details.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';
import 'package:lazervault/src/features/widgets/country_selection_bottom_sheet.dart';

class SendFund extends StatefulWidget {
  const SendFund({super.key, required this.recipient});

  final Recipient recipient;

  @override
  State<SendFund> createState() => _SendFundState();
}

class _SendFundState extends State<SendFund> {
  Country selectedCountry = AppData.countries.first;

  final List<String> categories = [
    "Food",
    "Rent",
    "Utilities",
    "Groceries",
    "Shopping",
    "Miscellaneous"
  ];
  late TextEditingController _categoryController;
  late TextEditingController _notesController;
  late TextEditingController _paymentScheduleController;

  @override
  void initState() {
    super.initState();
    _categoryController = TextEditingController(text: "Miscellaneous");
    _notesController = TextEditingController(text: "Your monthly salary");
    _paymentScheduleController = TextEditingController(text: "Now");
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _notesController.dispose();
    _paymentScheduleController.dispose();
    super.dispose();
  }

  Future<void> _showCountrySelectionBottomSheet() async {
    final selected = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true,
      builder: (context) => CountrySelectionBottomSheet(
        selectedCountry: selectedCountry,
        onSelect: (country) {
          Navigator.pop(context, country);
        },
      ),
    );

    if (selected != null) {
      setState(() {
        selectedCountry = selected;
      });
    }
  }

  void _showCategoryBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16.0),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.0.w),
          height: 400.0.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Select Category",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        categories[index],
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      onTap: () {
                        setState(() {
                          _categoryController.text = categories[index];
                        });
                        if (Navigator.canPop(context)) {
                          Get.back();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectDateTime() async {
    DateTime now = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final DateTime fullDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        setState(() {
          _paymentScheduleController.text =
              DateFormat("yyyy-MM-dd HH:mm").format(fullDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AvatarWithDetails(
            avatar: widget.recipient.imageUri ?? "",
            title: widget.recipient.name,
            subTitle: widget.recipient.accountNumber.toString(),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.0.h,
              children: [
                BuildFormField(
                  name: "Amount",
                  placeholder: "Enter amount",
                  labelText: "Enter Amount",
                  leading: GestureDetector(
                    onTap: _showCountrySelectionBottomSheet,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0.r,
                          backgroundImage: AssetImage(selectedCountry.flag),
                        ),
                        SizedBox(width: 8.0.w),
                        Text(
                          selectedCountry.code,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                BuildFormField(
                  name: "Category",
                  labelText: "Category",
                  placeholder: "Select category",
                  suffixIcon: Icon(Icons.arrow_drop_down, color: Colors.grey),
                  disabled: true,
                  onTap: _showCategoryBottomSheet,
                  controller: _categoryController,
                ),
                BuildFormField(
                  name: "notes",
                  labelText: "Notes",
                  placeholder: "E.g: Your monthly salary",
                  controller: _notesController,
                ),
                BuildFormField(
                  name: "paymentSchedule",
                  labelText: "Schedule",
                  placeholder: "Now",
                  width: 50.0.w,
                  disabled: true,
                  onTap: _selectDateTime,
                  controller: _paymentScheduleController,
                  leading: Icon(Icons.calendar_today, color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Get.toNamed(AppRoutes.reviewFundsTransfer,
                  arguments: widget.recipient),
              child: const Text("Continue"),
            ),
          ),
        ],
      ),
    );
  }
}
