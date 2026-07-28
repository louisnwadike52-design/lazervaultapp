import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/config/country_config.dart';

/// A phone input field with pre-filled, non-editable country selection
///
/// This widget is designed for use in the signup flow after the user has
/// already selected their country. The country code and flag are pre-filled
/// and cannot be changed, ensuring consistency with the initial selection.
class LockedCountryPhoneInput extends StatefulWidget {
  final String countryCode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? hintText;
  final bool isRequired;
  final String? Function(String?)? validator;
  final bool enabled;
  // When provided, the country code/flag becomes tappable (shows a caret) and
  // invokes this callback so the caller can present a country picker. When
  // null the country stays locked (original behaviour, unchanged).
  final VoidCallback? onCountryTap;

  const LockedCountryPhoneInput({
    super.key,
    required this.countryCode,
    this.initialValue,
    this.onChanged,
    this.labelText,
    this.hintText,
    this.isRequired = true,
    this.validator,
    this.enabled = true,
    this.onCountryTap,
  });

  @override
  State<LockedCountryPhoneInput> createState() =>
      _LockedCountryPhoneInputState();
}

class _LockedCountryPhoneInputState extends State<LockedCountryPhoneInput> {
  late final TextEditingController _controller;
  late final CountryConfig _countryConfig;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _countryConfig = CountryConfigs.getByCode(widget.countryCode) ??
        CountryConfigs.nigeria; // Fallback
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF262626),
            ),
          ),
          SizedBox(height: 8.h),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Country code section (left side - matches BuildFormField leading).
            // Tappable when onCountryTap is supplied (shows a caret).
            GestureDetector(
              onTap: widget.enabled ? widget.onCountryTap : null,
              child: Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    bottomLeft: Radius.circular(24.r),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _countryConfig.flag,
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _countryConfig.dialingCode,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    if (widget.onCountryTap != null) ...[
                      SizedBox(width: 2.w),
                      Icon(Icons.arrow_drop_down,
                          size: 18.sp, color: Colors.grey.shade600),
                    ],
                  ],
                ),
              ),
            ),
            // Phone number input (right side - matches BuildFormField).
            // Pin to the SAME fixed height as the country pill so both rounded
            // halves are always identical height. Without this the right half
            // sized to the TextField's intrinsic height (font metrics +
            // text-scale), which differs per device — the cause of the two
            // halves looking misaligned on some phones but not others.
            Expanded(
              child: Container(
                height: 48.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F0F0),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.r),
                    bottomRight: Radius.circular(24.r),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        enabled: widget.enabled,
                        keyboardType: TextInputType.phone,
                        // Center the text within the fixed-height pill so it
                        // lines up with the country code half on every device.
                        textAlignVertical: TextAlignVertical.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          // Limit typing to the country's national number length
                          // PLUS one, so a user may optionally type the leading
                          // trunk "0" (e.g. NG: 10 digits, or 11 with the 0).
                          LengthLimitingTextInputFormatter(
                            _countryConfig.nationalNumberLength + 1,
                          ),
                        ],
                        decoration: InputDecoration(
                          hintText: widget.hintText ?? 'Phone number',
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade600,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: widget.enabled ? Colors.black : Colors.grey.shade600,
                        ),
                        onChanged: _onChanged,
                      ),
                    ),
                    // Clear button
                    if (_controller.text.isNotEmpty && widget.enabled)
                      Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: GestureDetector(
                          onTap: _clearInput,
                          child: Icon(
                            Icons.clear,
                            size: 20.sp,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        if (_errorText != null) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              _errorText!,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red.shade600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Handle input change
  void _onChanged(String value) {
    setState(() {
      _errorText = null;
    });

    // Format to E.164
    final formatted = _formatToE164(value);
    widget.onChanged?.call(formatted);
  }

  /// Format phone number to E.164.
  ///
  /// The user may type the national number with or without the leading trunk
  /// "0" (e.g. NG "08031234567" or "8031234567") and may even paste a full
  /// "+234..."/"234..." string. We normalise all of these to a clean E.164
  /// (plus sign, dialing code, then the national number) by dropping the dialing
  /// code and the single leading trunk "0" before re-prefixing, so we never
  /// produce a malformed value like "+23408031234567".
  String _formatToE164(String number) {
    var digits = number.replaceAll(RegExp(r'[^\d]'), '');
    if (digits.isEmpty) return '';

    final dialingCode = _countryConfig.dialingCode.replaceAll('+', '');
    // Drop the dialing code if the user typed/pasted it.
    if (digits.startsWith(dialingCode)) {
      digits = digits.substring(dialingCode.length);
    }
    // Drop a single leading national trunk "0".
    if (digits.startsWith('0')) {
      digits = digits.substring(1);
    }
    if (digits.isEmpty) return '';
    return '+$dialingCode$digits';
  }

  /// Clear input
  void _clearInput() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  /// Validate phone number
  String? validate() {
    if (!widget.enabled) return null;

    final value = _controller.text;

    if (widget.isRequired && value.isEmpty) {
      setState(() => _errorText = 'Phone number is required');
      return 'Phone number is required';
    }

    if (value.isNotEmpty) {
      // Strip the dialing code and a single leading trunk "0" to get the NSN,
      // then require it to match the country's expected national length.
      var nsn = value.replaceAll(RegExp(r'[^\d]'), '');
      final dialingCode = _countryConfig.dialingCode.replaceAll('+', '');
      if (nsn.startsWith(dialingCode)) {
        nsn = nsn.substring(dialingCode.length);
      }
      if (nsn.startsWith('0')) {
        nsn = nsn.substring(1);
      }
      final expected = _countryConfig.nationalNumberLength;
      if (nsn.length != expected) {
        final msg = 'Enter a valid ${_countryConfig.name} phone number '
            '($expected digits after ${_countryConfig.dialingCode})';
        setState(() => _errorText = msg);
        return msg;
      }
    }

    setState(() => _errorText = null);
    return widget.validator?.call(value);
  }

  /// Get the complete phone number in E.164 format
  String get completeNumber => _formatToE164(_controller.text);

  /// Get the national number (without country code)
  String get nationalNumber {
    final dialingCode = _countryConfig.dialingCode.replaceAll('+', '');
    return _controller.text.replaceAll(RegExp(r'[^\d]'), '').replaceFirst(
          RegExp('^$dialingCode'),
          '',
        );
  }
}

/// A compact version of the phone input for use in tight spaces
class CompactLockedCountryPhoneInput extends StatefulWidget {
  final String countryCode;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final bool enabled;

  const CompactLockedCountryPhoneInput({
    super.key,
    required this.countryCode,
    this.initialValue,
    this.onChanged,
    this.hintText,
    this.enabled = true,
  });

  @override
  State<CompactLockedCountryPhoneInput> createState() =>
      _CompactLockedCountryPhoneInputState();
}

class _CompactLockedCountryPhoneInputState
    extends State<CompactLockedCountryPhoneInput> {
  late final TextEditingController _controller;
  late final CountryConfig _countryConfig;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue ?? '');
    _countryConfig = CountryConfigs.getByCode(widget.countryCode) ??
        CountryConfigs.nigeria;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Country indicator (matches BuildFormField leading)
        Container(
          height: 48.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12.r),
              bottomLeft: Radius.circular(12.r),
            ),
          ),
          child: Row(
            children: [
              Text(_countryConfig.flag, style: TextStyle(fontSize: 18.sp)),
              SizedBox(width: 6.w),
              Text(
                _countryConfig.dialingCode,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
        // Input (matches BuildFormField)
        Expanded(
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F0),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12.r),
                bottomRight: Radius.circular(12.r),
              ),
            ),
            child: TextField(
              controller: _controller,
              enabled: widget.enabled,
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: widget.hintText ?? 'Phone number',
                hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
              ),
              style: TextStyle(fontSize: 14.sp),
              onChanged: (value) {
                final dialingCode = _countryConfig.dialingCode;
                widget.onChanged?.call('$dialingCode$value');
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Phone number display widget (read-only)
class PhoneDisplayWidget extends StatelessWidget {
  final String countryCode;
  final String phoneNumber;
  final VoidCallback? onEdit;

  const PhoneDisplayWidget({
    super.key,
    required this.countryCode,
    required this.phoneNumber,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final config = CountryConfigs.getByCode(countryCode);
    if (config == null) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(config.flag, style: TextStyle(fontSize: 20.sp)),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Phone Number',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  phoneNumber,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit, size: 18),
              onPressed: onEdit,
              color: Colors.blue,
            ),
        ],
      ),
    );
  }
}
