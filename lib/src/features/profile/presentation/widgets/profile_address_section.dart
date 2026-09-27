import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/authentication/domain/entities/postal_address.dart';

/// The address block of the profile form.
///
/// Exists because an account statement without the holder's address is not
/// accepted as proof of residence — which is the main reason people export
/// one. Nothing in the app could capture an address before this.
///
/// Every field is optional. Requiring a full address would leave most users
/// with none at all, and a partial address still prints usefully; the server
/// treats line 1 alone as enough to render a block.
class ProfileAddressSection extends StatefulWidget {
  final PostalAddress initial;
  final ValueChanged<PostalAddress> onChanged;

  /// True when the address was filled from a verified KYC record. Shown so the
  /// user understands where it came from and that they may correct it — a
  /// provider's address is often years stale.
  final bool fromVerification;

  const ProfileAddressSection({
    super.key,
    required this.initial,
    required this.onChanged,
    this.fromVerification = false,
  });

  @override
  State<ProfileAddressSection> createState() => _ProfileAddressSectionState();
}

class _ProfileAddressSectionState extends State<ProfileAddressSection> {
  late final TextEditingController _line1;
  late final TextEditingController _line2;
  late final TextEditingController _city;
  late final TextEditingController _state;
  late final TextEditingController _postalCode;
  late final TextEditingController _country;

  static const Color _brand = Color(0xFF4E03D0);

  @override
  void initState() {
    super.initState();
    _line1 = TextEditingController(text: widget.initial.line1);
    _line2 = TextEditingController(text: widget.initial.line2);
    _city = TextEditingController(text: widget.initial.city);
    _state = TextEditingController(text: widget.initial.state);
    _postalCode = TextEditingController(text: widget.initial.postalCode);
    _country = TextEditingController(text: widget.initial.country);
  }

  @override
  void dispose() {
    _line1.dispose();
    _line2.dispose();
    _city.dispose();
    _state.dispose();
    _postalCode.dispose();
    _country.dispose();
    super.dispose();
  }

  void _emit() {
    widget.onChanged(PostalAddress(
      line1: _line1.text.trim(),
      line2: _line2.text.trim(),
      city: _city.text.trim(),
      state: _state.text.trim(),
      postalCode: _postalCode.text.trim(),
      country: _country.text.trim(),
    ));
  }

  InputDecoration _decoration(String label, {String? hint, IconData? icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      isDense: true,
      prefixIcon: icon == null ? null : Icon(icon, size: 20.sp),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: _brand, width: 2),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    String? hint,
    IconData? icon,
    int maxLength = 160,
    TextCapitalization capitalization = TextCapitalization.words,
  }) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      textCapitalization: capitalization,
      onChanged: (_) => _emit(),
      decoration: _decoration(label, hint: hint, icon: icon)
          .copyWith(counterText: ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(Icons.home_outlined, size: 18.sp, color: _brand),
            SizedBox(width: 8.w),
            Text(
              'Address',
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Text(
          widget.fromVerification
              ? 'Filled from your verified identity. Correct it if it is out of date.'
              : 'Printed on your account statements and official letters. Optional.',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: const Color(0xFF6B7280),
            height: 1.4,
          ),
        ),
        SizedBox(height: 12.h),
        _field(_line1, 'Address line 1',
            hint: 'Street and number', icon: Icons.location_on_outlined),
        SizedBox(height: 12.h),
        _field(_line2, 'Address line 2',
            hint: 'Apartment, suite (optional)'),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(child: _field(_city, 'City', maxLength: 80)),
            SizedBox(width: 12.w),
            Expanded(child: _field(_state, 'State / region', maxLength: 80)),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _field(
                _postalCode,
                'Postal code',
                maxLength: 20,
                // Postcodes are not words: title-casing "SW1A 1AA" or a
                // Nigerian 6-digit code is wrong in both directions.
                capitalization: TextCapitalization.characters,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(child: _field(_country, 'Country', maxLength: 80)),
          ],
        ),
      ],
    );
  }
}
