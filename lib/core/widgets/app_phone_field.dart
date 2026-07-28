import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';

import 'package:lazervault/core/theme/invoice_theme_colors.dart';

/// A themed international phone field.
///
/// - Country flag + dial code sit on the LEFT; tapping them opens a searchable
///   country picker (native to [IntlPhoneField]).
/// - The national-number input tolerates a leading zero (e.g. `0801…` and
///   `801…` are both accepted).
/// - Length is validated against the SELECTED country's min/max, with the error
///   shown in red below the field.
///
/// Capture the value via [onChanged] into a `PhoneNumber?` and submit the E.164
/// string with [AppPhoneField.complete], e.g. `phone: AppPhoneField.complete(_phone)`.
class AppPhoneField extends StatelessWidget {
  final String label;
  final String initialCountryCode;
  final String? initialNumber;
  final bool isRequired;
  final ValueChanged<PhoneNumber> onChanged;

  const AppPhoneField({
    super.key,
    this.label = 'Phone Number',
    this.initialCountryCode = 'NG',
    this.initialNumber,
    this.isRequired = false,
    required this.onChanged,
  });

  /// The national number with any leading zero(s) removed.
  static String _national(PhoneNumber? phone) =>
      (phone?.number.trim() ?? '').replaceFirst(RegExp(r'^0+'), '');

  /// Full E.164 number (dial code + national, leading zero stripped), or '' when
  /// empty. Use this at submit time instead of `phone.completeNumber` so a
  /// leading zero can never leak into the stored number.
  static String complete(PhoneNumber? phone) {
    final national = _national(phone);
    if (national.isEmpty) return '';
    return '${phone!.countryCode}$national';
  }

  String? _validate(PhoneNumber? phone) {
    final national = _national(phone);
    if (national.isEmpty) {
      return isRequired ? 'Phone number is required' : null;
    }
    Country? c;
    for (final country in countries) {
      if (country.code == phone!.countryISOCode) {
        c = country;
        break;
      }
    }
    if (c != null &&
        (national.length < c.minLength || national.length > c.maxLength)) {
      return 'Enter a valid ${c.name} number';
    }
    return null;
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: color == Colors.transparent
            ? BorderSide.none
            : BorderSide(color: color),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: InvoiceThemeColors.textGray400,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        IntlPhoneField(
          initialCountryCode: initialCountryCode,
          initialValue: initialNumber,
          disableLengthCheck: true, // our validator owns length + optionality
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          dropdownTextStyle:
              GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          dropdownIcon: const Icon(Icons.arrow_drop_down,
              color: InvoiceThemeColors.textGray400),
          flagsButtonPadding: EdgeInsets.only(left: 8.w),
          decoration: InputDecoration(
            hintText: '801 234 5678',
            hintStyle: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray500, fontSize: 15.sp),
            filled: true,
            fillColor: InvoiceThemeColors.secondaryBackground,
            border: _border(Colors.transparent),
            enabledBorder: _border(Colors.transparent),
            focusedBorder: _border(InvoiceThemeColors.primaryPurple),
            errorBorder: _border(InvoiceThemeColors.errorRed),
            focusedErrorBorder: _border(InvoiceThemeColors.errorRed),
            errorStyle: GoogleFonts.inter(
                color: InvoiceThemeColors.errorRed, fontSize: 12.sp),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: InvoiceThemeColors.secondaryBackground,
            countryNameStyle: GoogleFonts.inter(color: Colors.white),
            countryCodeStyle: GoogleFonts.inter(
                color: InvoiceThemeColors.textGray400,
                fontWeight: FontWeight.w600),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country',
              hintStyle:
                  GoogleFonts.inter(color: InvoiceThemeColors.textGray500),
              prefixIcon: const Icon(Icons.search,
                  color: InvoiceThemeColors.textGray400),
            ),
          ),
          validator: _validate,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
