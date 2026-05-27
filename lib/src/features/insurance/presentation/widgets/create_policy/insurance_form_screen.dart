import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// Prefixed to dodge an `ImageSource` symbol collision with
// flutter_widget_from_html_core (which exports its own ImageSource for
// HTML img tags). Using `picker.picker.ImageSource.camera/.gallery` is
// unambiguous and keeps both imports.
import 'package:image_picker/image_picker.dart' as picker;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/utils/debouncer.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../../domain/repositories/insurance_repository.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';
import 'array_form_field.dart';
import 'multi_select_array_field.dart';
import 'monetary_form_field.dart';

/// Screen 2: Dynamic form fields from MyCover.ai product
class InsuranceFormScreen extends StatefulWidget {
  const InsuranceFormScreen({super.key});

  @override
  State<InsuranceFormScreen> createState() => _InsuranceFormScreenState();
}

class _InsuranceFormScreenState extends State<InsuranceFormScreen> {
  final Map<String, TextEditingController> _controllers = {};
  final Debouncer _debouncer = Debouncer(milliseconds: 300);
  final Map<String, List<AuxiliaryItem>> _auxiliaryCache = {};
  final Map<String, bool> _auxiliaryLoading = {};
  final Map<String, String?> _auxiliaryError = {};
  final Map<String, bool> _fileUploading = {};
  final Map<String, CountryLocale> _phoneCountryCodes = {}; // per-field country code

  /// Detects if a field requires file upload based on name patterns
  bool _isFileField(InsuranceProductFormField field) {
    final name = field.name.toLowerCase();
    final type = field.type.toLowerCase();
    return type == 'file' ||
        name.contains('image') ||
        name.contains('photo') ||
        name.contains('proof') ||
        name.contains('id_url') ||
        name.endsWith('_url');
  }

  /// Returns the utility ID for fields that need auxiliary data, or null.
  /// Backend-driven: the field's `utilityId` comes from MyCover's
  /// per-product schema via the probe-discovery mechanism in
  /// financial-products-service. If the backend sends one, we use it;
  /// otherwise we fall back to the legacy static map for products
  /// the schema discovery couldn't probe.
  String? _getUtilityIdForField(InsuranceProductFormField field) {
    if (field.utilityId.isNotEmpty) return field.utilityId;
    final name = field.name.toLowerCase();
    // Legacy fallback for any pre-discovery code paths.
    if (name.contains('vehicle_make') || name == 'make') {
      return InsuranceUtilityIds.vehicleMakes;
    }
    if (name.contains('vehicle_model') || name == 'model') {
      return InsuranceUtilityIds.vehicleModels;
    }
    return null;
  }

  /// Gets the dependent query value for a field (e.g., vehicle_model
  /// depends on vehicle_make). Prefers backend's `dependsOn`; falls
  /// back to legacy hardcoded mapping for older schemas.
  String? _getDependentQuery(InsuranceProductFormField field, Map<String, String> formData) {
    if (field.dependsOn.isNotEmpty) {
      return formData[field.dependsOn];
    }
    final name = field.name.toLowerCase();
    if (name.contains('vehicle_model') || name == 'model') {
      return formData['vehicle_make'] ?? formData['make'];
    }
    return null;
  }

  @override
  void dispose() {
    for (final c in _controllers.values) { c.dispose(); }
    _debouncer.dispose();
    super.dispose();
  }

  TextEditingController _getController(String name, String initialValue) {
    if (!_controllers.containsKey(name)) {
      _controllers[name] = TextEditingController(text: initialValue);
    } else if (_controllers[name]!.text != initialValue && initialValue.isNotEmpty) {
      // Sync controller text if form data was updated externally (e.g., auto-fill)
      // Only update if initialValue is non-empty to avoid clearing user input
      final controller = _controllers[name]!;
      if (controller.text.isEmpty && initialValue.isNotEmpty) {
        controller.text = initialValue;
      }
    }
    return _controllers[name]!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        // Handle InsuranceProductSelected directly
        if (state is InsuranceProductSelected) {
          return _buildForm(state.product, state.formData, state.formErrors);
        }

        // Also handle states that occur while form is still visible
        // (e.g. quote loading after pressing Continue, or late SWR emission)
        final cubit = context.read<CreatePolicyCubit>();
        if (cubit.selectedProduct != null) {
          return _buildForm(cubit.selectedProduct!, cubit.formData, const {});
        }

        return Center(child: Text('Please select a product first',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))));
      },
    );
  }

  /// Filters the product's form fields based on conditional-display
  /// rules. Currently only one such rule exists: the `insured_*` family
  /// is hidden when `bought_for_self` is anything other than the
  /// canonical "false" (matches the cubit + backend validators).
  /// When the field set itself contains no `bought_for_self` toggle
  /// (products that don't expose the choice), insured_* fields stay
  /// hidden — they're only meaningful in tandem with the toggle.
  Iterable<InsuranceProductFormField> _visibleFields(
    InsuranceProduct product,
    Map<String, String> formData,
  ) {
    final raw = (formData['bought_for_self'] ?? '').trim().toLowerCase();
    final buyingForSomeoneElse = raw == 'false' || raw == '0' || raw == 'no';
    return product.formFields.where((f) {
      if (f.name.startsWith('insured_')) return buyingForSomeoneElse;
      return true;
    });
  }

  Widget _buildForm(InsuranceProduct product, Map<String, String> formData, Map<String, String> formErrors) {
    // Snapshot for cross-field validators (e.g. arrival_date must be
    // ≥ departure_date). Refreshed on every rebuild so validators
    // always read the latest values.
    _lastFormData = formData;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          _buildProductHeader(product),
          SizedBox(height: 24.h),
          Text('Your Details', style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 4.h),
          Text('Fill in the required information for your insurance',
            style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
          SizedBox(height: 20.h),
          ..._visibleFields(product, formData).map((field) =>
            _buildFormField(context, field, formData[field.name] ?? '', formErrors[field.name])),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildProductHeader(InsuranceProduct product) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
      ),
      child: Row(children: [
        Container(
          width: 40.w, height: 40.w,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8.r)),
          child: Center(child: Icon(product.category.icon, size: 22.sp, color: const Color(0xFF6366F1))),
        ),
        SizedBox(width: 12.w),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(product.name, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          Text(product.providerName, style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
        ])),
        GestureDetector(
          onTap: () => _showProductInfoSheet(context, product),
          child: Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
            ),
            child: Icon(Icons.info_outline, color: const Color(0xFF6366F1), size: 18.sp),
          ),
        ),
      ]),
    );
  }

  void _showProductInfoSheet(BuildContext context, InsuranceProduct product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.85,
        minChildSize: 0.35,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    Row(children: [
                      Container(
                        width: 48.w, height: 48.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(product.category.icon, size: 26.sp, color: const Color(0xFF6366F1)),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(product.name, style: GoogleFonts.inter(
                          fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                        SizedBox(height: 2.h),
                        Text(product.providerName, style: GoogleFonts.inter(
                          fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                      ])),
                    ]),
                    SizedBox(height: 16.h),
                    // Premium + category
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.premiumRange, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.category.displayName, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6366F1))),
                      ),
                    ]),
                    SizedBox(height: 20.h),
                    // Description
                    _buildInfoSectionTitle('About'),
                    SizedBox(height: 8.h),
                    _buildInfoRichContent(product.description),
                    // How It Works
                    if (product.howItWorks.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('How It Works'),
                      SizedBox(height: 8.h),
                      _buildInfoRichContent(product.howItWorks),
                    ],
                    // Benefits
                    if (product.benefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('Benefits'),
                      SizedBox(height: 8.h),
                      ...product.benefits.map((b) => Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Icon(Icons.check_circle, size: 16.sp, color: const Color(0xFF10B981)),
                          SizedBox(width: 8.w),
                          Expanded(child: Text(b, style: GoogleFonts.inter(
                            fontSize: 13.sp, color: Colors.white, height: 1.4))),
                        ]),
                      )),
                    ],
                    // Full Benefits
                    if (product.fullBenefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildInfoSectionTitle('Full Coverage Details'),
                      SizedBox(height: 8.h),
                      _buildInfoRichContent(product.fullBenefits),
                    ],
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSectionTitle(String title) {
    return Text(title, style: GoogleFonts.inter(
      fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white));
  }

  Widget _buildInfoRichContent(String content) {
    if (content.contains('<') && content.contains('>')) {
      return HtmlWidget(
        content,
        textStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5),
        customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'},
      );
    }
    return Text(content, style: GoogleFonts.inter(
      fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5));
  }

  Widget _buildFormField(BuildContext context, InsuranceProductFormField field, String value, String? error) {
    final cubit = context.read<CreatePolicyCubit>();

    // Check for file upload fields
    if (_isFileField(field)) {
      return _buildFileUploadField(cubit, field, value, error);
    }

    // Check for auxiliary data select fields (states, vehicle makes/models).
    // BACKEND-FIRST: if the product's schema already shipped inline `options`,
    // use those directly — the backend pre-fetched them from MyCover (or the
    // DB-backed static fallback) when it built the product list. Firing a
    // second gRPC round-trip for the same data was producing HTTP/2
    // CANCEL/error-10 spam and infinite "Loading options…" spinners on
    // products whose dropdown values were already in our hand. The auxiliary
    // RPC stays the path for vehicle-make/model (cascading + huge sets that
    // we DON'T inline) and any product whose options arrive empty.
    final utilityId = _getUtilityIdForField(field);
    if (utilityId != null && field.options.isEmpty) {
      final state = context.read<CreatePolicyCubit>().state;
      final formData = state is InsuranceProductSelected ? state.formData : <String, String>{};
      return _buildAuxiliarySelectField(cubit, field, value, error, utilityId, formData);
    }

    switch (field.type.toLowerCase()) {
      case 'select':
      case 'dropdown':
        return _buildDropdownField(cubit, field, value, error);
      case 'date':
        return _buildDateField(context, cubit, field, value, error);
      case 'boolean':
        return _buildBooleanField(cubit, field, value);
      case 'number':
        // MyCover.ai exposes amount inputs as plain "number" fields with
        // names like vehicle_value, property_value, contents_value,
        // cargo_value, device_value, value, amount. Surface those with
        // the active-currency prefix + thousands separators so the user
        // sees what currency they're in and reads "1,000,000" not
        // "1000000". Backend still receives a clean numeric string.
        if (_isMonetaryField(field)) {
          return _buildMonetaryField(cubit, field, value, error);
        }
        // Travel: MyCover caps num_of_passengers at 9. Restrict input to a
        // single digit and reject 0 at the formatter layer — the validator
        // would still catch it, but stopping the bad keystroke means the
        // user never sees an error toast for "10" they can't enter.
        final formatters = <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[\d.]')),
        ];
        if (field.name.toLowerCase() == 'num_of_passengers') {
          formatters
            ..add(LengthLimitingTextInputFormatter(1))
            ..add(FilteringTextInputFormatter.allow(RegExp(r'[1-9]')));
        }
        return _buildTextField(cubit, field, value, error,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: formatters);
      case 'email':
        return _buildTextField(cubit, field, value, error, keyboardType: TextInputType.emailAddress);
      case 'phone':
        return _buildPhoneField(cubit, field, value, error);
      case 'array':
        // Life's `benefits` is a multi-select string-array (chips UI
        // over fixed dictionary options). All other array fields
        // (items, item_details, beneficiaries, benefit_details) are
        // structured per-item cards — handled by _buildArrayField.
        // The discriminator is whether the dictionary entry carries
        // non-empty `options`.
        if (field.options.isNotEmpty) {
          return _buildMultiSelectArrayField(cubit, field, value, error);
        }
        return _buildArrayField(cubit, field, value, error);
      default:
        return _buildTextField(cubit, field, value, error);
    }
  }

  // RFC 5322-compatible email regex (intentionally a practical subset:
  // local@domain.tld with at least one dot in the domain). Matches
  // MyCover's server-side validator, which rejects e.g. "a@b" or
  // "a@.b".
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$",
  );

  // Per-country mobile number rules. Maps ISO-2 country code → (local
  // digits length, valid starting digits for mobile lines). All
  // numbers are validated AFTER the international dial code prefix
  // has been stripped and any leading 0 removed.
  //
  // Sources: ITU national numbering plans + carrier patterns.
  static const Map<String, _PhoneRule> _phoneRulesByCountry = {
    // Nigeria: 10 digits, starts with 7/8/9 (MTN 803/806, Airtel 802, Glo 805, 9mobile 809…)
    'NG': _PhoneRule(localDigits: 10, validStartDigits: ['7', '8', '9']),
    // United States: 10 digits, area code starts with 2-9
    'US': _PhoneRule(localDigits: 10, validStartDigits: ['2', '3', '4', '5', '6', '7', '8', '9']),
    // United Kingdom: 10 digits, mobile starts with 7
    'GB': _PhoneRule(localDigits: 10, validStartDigits: ['7']),
    // Ghana: 9 digits, mobile starts with 2/5
    'GH': _PhoneRule(localDigits: 9, validStartDigits: ['2', '5']),
    // Kenya: 9 digits, mobile starts with 1/7
    'KE': _PhoneRule(localDigits: 9, validStartDigits: ['1', '7']),
    // South Africa: 9 digits, mobile starts with 6/7/8
    'ZA': _PhoneRule(localDigits: 9, validStartDigits: ['6', '7', '8']),
  };

  // NIN / BVN must be exactly 11 digits per MyCover docs.
  static final RegExp _elevenDigitId = RegExp(r'^\d{11}$');

  /// Validate `+<dial><local>` against the rule for the country the user
  /// picked in the phone-field's flag dropdown. Falls back to a loose
  /// 7-15 digits check for unknown countries.
  String? _validatePhoneNumber(String fullValue, String? countryCode) {
    final cleaned = fullValue.replaceAll(RegExp(r'[\s\-()]'), '');
    String local = cleaned;
    String? cc = countryCode;
    // If we don't have an explicit country from the picker, try to
    // detect from the dial-code prefix.
    if (cc == null && cleaned.startsWith('+')) {
      for (final c in CountryLocales.all) {
        if (cleaned.startsWith(c.dialCode)) {
          cc = c.countryCode;
          local = cleaned.substring(c.dialCode.length);
          break;
        }
      }
    } else if (cc != null) {
      final entry = CountryLocales.findByCountryCode(cc);
      if (entry != null && cleaned.startsWith(entry.dialCode)) {
        local = cleaned.substring(entry.dialCode.length);
      } else if (cleaned.startsWith('+')) {
        // User pasted a foreign number into a country-locked field
        return 'Phone country does not match selection';
      }
    }
    // Strip a single leading zero (national trunk prefix) if present.
    if (local.startsWith('0')) local = local.substring(1);
    if (!RegExp(r'^\d+$').hasMatch(local)) {
      return 'Phone number must be digits only';
    }
    final rule = cc != null ? _phoneRulesByCountry[cc] : null;
    if (rule == null) {
      // Unknown country → loose check.
      if (local.length < 7 || local.length > 15) {
        return 'Enter a valid phone number';
      }
      return null;
    }
    if (local.length != rule.localDigits) {
      return 'Phone must be ${rule.localDigits} digits after country code';
    }
    if (!rule.validStartDigits.contains(local[0])) {
      return 'Not a valid mobile number for this country';
    }
    return null;
  }

  /// Latest form data — populated on each rebuild by `_buildForm`. Used
  /// for cross-field validation (e.g. arrival_date ≥ departure_date)
  /// without changing every per-widget call signature.
  Map<String, String> _lastFormData = const {};

  String? _validateField(InsuranceProductFormField field, String value) {
    if (value.isEmpty) return null;
    final name = field.name.toLowerCase();
    final type = field.type.toLowerCase();
    if (type == 'email' && !_emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    if (type == 'phone') {
      final selectedCountry = _phoneCountryCodes[field.name]?.countryCode;
      final err = _validatePhoneNumber(value, selectedCountry);
      if (err != null) return err;
    }
    if (type == 'number') {
      if (double.tryParse(value) == null) return 'Please enter a valid number';
      if (double.parse(value) < 0) return 'Value must be positive';
      // Travel: num_of_passengers must be 1-9 per MyCover's
      // /v1/products/allianz/compute-travel-premium schema.
      if (name == 'num_of_passengers') {
        final n = int.tryParse(value);
        if (n == null || n < 1 || n > 9) return 'Enter 1 to 9 passengers';
      }
    }
    if (type == 'date') {
      final parsed = DateTime.tryParse(value);
      if (parsed == null) return 'Use YYYY-MM-DD';
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      if (name == 'date_of_birth') {
        if (!parsed.isBefore(now)) return 'Date of birth must be in the past';
        final age = now.year - parsed.year - (now.isBefore(DateTime(parsed.year, parsed.month, parsed.day)) ? 1 : 0);
        if (age < 18) return 'You must be at least 18';
        if (age > 120) return 'Please enter a valid date of birth';
      } else if (name == 'departure_date') {
        // Travel: trip start must be today or later.
        if (parsed.isBefore(today)) return 'Departure date must be today or later';
        // Sanity-cap to avoid 100-year-in-future taps.
        if (parsed.isAfter(today.add(const Duration(days: 365 * 2)))) {
          return 'Departure date is too far in the future';
        }
      } else if (name == 'device_purchase_date' || name == 'disbursement_date') {
        // Gadget: device_purchase_date must be in the past — can't
        // insure a device that hasn't shipped yet.
        // Life: disbursement_date is when a loan was disbursed —
        // also past-only.
        if (parsed.isAfter(today)) return 'Date must be today or earlier';
        if (parsed.isBefore(today.subtract(const Duration(days: 365 * 20)))) {
          return 'Date is too far in the past';
        }
      } else if (name == 'shipping_date') {
        // Package (Marine + GIT): shipping date can be today, recent
        // past (cargo already in transit), or near-future (planned
        // shipment). Allow a ±90 day past / +365 day future window.
        if (parsed.isBefore(today.subtract(const Duration(days: 90)))) {
          return 'Shipping date is too far in the past';
        }
        if (parsed.isAfter(today.add(const Duration(days: 365)))) {
          return 'Shipping date is too far in the future';
        }
      } else if (name == 'arrival_date' || name == 'return_date') {
        if (parsed.isBefore(today)) return 'Return date must be today or later';
        // Cross-field: arrival/return must be ≥ departure.
        final dep = _lastFormData['departure_date'] ?? '';
        if (dep.isNotEmpty) {
          final depDate = DateTime.tryParse(dep);
          if (depDate != null && parsed.isBefore(depDate)) {
            return 'Return date cannot be before departure';
          }
        }
        if (parsed.isAfter(today.add(const Duration(days: 365 * 2)))) {
          return 'Return date is too far in the future';
        }
      }
    }
    if ((name == 'nin' || name == 'bvn') && !_elevenDigitId.hasMatch(value.trim())) {
      return 'Must be exactly 11 digits';
    }
    if (type == 'text' && field.required) {
      // Address-like fields need enough context for MyCover's KYC
      // checks (street + city minimum). Two chars is fine for things
      // like "Mr" or initials, but an address like "ab" gets the
      // policy rejected at MyCover.
      final isAddressLike = name == 'address' ||
          name.endsWith('_address') ||
          name == 'nok_address' ||
          name == 'next_of_kin_address' ||
          name == 'pickup_location' ||
          name == 'drop_off_location';
      final minLen = isAddressLike ? 5 : 2;
      if (value.trim().length < minLen) {
        return isAddressLike
            ? 'Please enter a full address (street + city)'
            : 'Must be at least $minLen characters';
      }
    }
    return null;
  }

  /// Authoritative list of MyCover.ai monetary form-field names, mirroring
  /// the server-side `coerceFormDataTypes` map in
  /// financial_products_handler.go. Keep in sync with that list.
  static const Set<String> _monetaryFieldNames = {
    'amount',
    'cargo_value',
    'contents_value',
    'device_value',
    'property_value',
    'value', // Device Value, etc.
    'vehicle_value',
  };

  /// Label-substring fallback so we still surface a currency prefix on
  /// future product types where the backend names a money field we
  /// haven't seen yet (e.g. "consignment_value", "stock_value"). Matches
  /// substrings like "value", "amount", "premium", "sum insured",
  /// "coverage". The substring set is intentionally narrow — we don't
  /// want to dress up unrelated number fields (age, count, year) with a
  /// currency prefix.
  static const List<String> _monetaryLabelHints = [
    'value',
    'amount',
    'premium',
    'sum insured',
    'sum assured',
    'coverage',
    'price',
    'worth',
  ];

  /// Excluded label substrings that share a word with the hints above
  /// but aren't actually money (e.g. "Property Value" matches "value"
  /// but "True Value" would too). Tighten if false positives appear.
  static const List<String> _monetaryLabelNegativeHints = [
    'percentage',
    'percent',
  ];

  bool _isMonetaryField(InsuranceProductFormField field) {
    final name = field.name.toLowerCase();
    if (_monetaryFieldNames.contains(name)) return true;
    final label = field.label.toLowerCase();
    if (_monetaryLabelNegativeHints.any((h) => label.contains(h))) {
      return false;
    }
    return _monetaryLabelHints.any((h) => label.contains(h));
  }

  Widget _buildMonetaryField(CreatePolicyCubit cubit,
      InsuranceProductFormField field, String value, String? error) {
    final inlineError = error ?? _validateField(field, value);
    // MyCover.ai is Nigeria-only — all insurance values (vehicle, property,
    // contents, cargo, etc.) MUST be in NGN regardless of the user's home
    // currency. The user's active currency only affects their wallet
    // display, not the insurance product schema.
    const currencyCode = 'NGN';
    final symbol = CurrencySymbols.getSymbol(currencyCode);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: MonetaryFormField(
        currencyCode: currencyCode,
        currencySymbol: symbol,
        initialRawValue: value,
        label: field.label,
        required: field.required,
        helperText: field.description.isNotEmpty
            ? _stripHtmlTags(field.description)
            : (field.placeholder.isNotEmpty ? field.placeholder : null),
        errorText: inlineError,
        onChanged: (raw) {
          // Persist the clean numeric string in the cubit (and therefore
          // on the wire). The backend's coerceFormDataTypes will turn it
          // into a real number before forwarding to MyCover.
          _debouncer.run(() => cubit.updateFormField(field.name, raw));
        },
      ),
    );
  }

  /// Tiny HTML-tag stripper for the helper line under monetary fields.
  /// We can't render the existing HtmlWidget inside an InputDecoration's
  /// helperText slot, so we flatten to plain text. Most MyCover field
  /// descriptions are already plain.
  String _stripHtmlTags(String html) {
    return html.replaceAll(RegExp(r'<[^>]+>'), '').trim();
  }

  /// Renders MyCover.ai `array`-type fields (`item_details`, `items`)
  /// as a repeating {name, value, description} list. The serialized
  /// JSON ends up in formData[field.name] and is forwarded as-is to
  /// the backend → MyCover.
  Widget _buildArrayField(CreatePolicyCubit cubit,
      InsuranceProductFormField field, String value, String? error) {
    // MyCover.ai is Nigeria-only — all insurance values (vehicle, property,
    // contents, cargo, etc.) MUST be in NGN regardless of the user's home
    // currency. The user's active currency only affects their wallet
    // display, not the insurance product schema.
    const currencyCode = 'NGN';
    final symbol = CurrencySymbols.getSymbol(currencyCode);
    return ArrayFormField(
      field: field,
      currencyCode: currencyCode,
      currencySymbol: symbol,
      initialJson: value,
      errorText: error,
      onChanged: (json) {
        _debouncer.run(() => cubit.updateFormField(field.name, json));
      },
      // Wire the per-item image upload to the same pre-construct-URL
      // pipeline the top-level file fields use. The cubit hands back
      // the deterministic public URL synchronously; the array field
      // stamps it into the item and the actual PUT lands in the
      // background before the purchase saga submits.
      stageItemImage: ({
        required List<int> bytes,
        required String filename,
        required String contentType,
      }) async {
        return cubit.stageArrayItemImage(
          bytes: bytes,
          filename: filename,
          contentType: contentType,
        );
      },
    );
  }

  /// Multi-select array widget for `type=array` fields whose dictionary
  /// entry carries non-empty `options`. Used today by Life's
  /// `benefits` field (six fixed coverage options). Emits a
  /// JSON-encoded array of selected strings; the backend's
  /// `coerceFormDataTypes` array-arm parses it into a real JSON array
  /// before forwarding to MyCover — identical wire shape to the
  /// structured-array widget so no per-field-name special-casing is
  /// needed downstream.
  Widget _buildMultiSelectArrayField(CreatePolicyCubit cubit,
      InsuranceProductFormField field, String value, String? error) {
    return MultiSelectArrayField(
      field: field,
      initialJson: value,
      errorText: error,
      onChanged: (json) {
        _debouncer.run(() => cubit.updateFormField(field.name, json));
      },
    );
  }

  Widget _buildTextField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error,
      {TextInputType keyboardType = TextInputType.text, List<TextInputFormatter>? inputFormatters}) {
    final controller = _getController(field.name, value);
    final inlineError = error ?? _validateField(field, controller.text);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller, keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: (v) => _debouncer.run(() => cubit.updateFormField(field.name, v)),
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          decoration: InputDecoration(
            hintText: field.placeholder.isNotEmpty ? field.placeholder : 'Enter ${field.label.toLowerCase()}',
            hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
            filled: true, fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF6366F1))),
            errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFFEF4444))),
            errorText: inlineError,
            errorStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)),
            contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
          ),
        ),
      ]),
    );
  }

  Widget _buildPhoneField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    // Initialize country code for this field if not yet set
    _phoneCountryCodes.putIfAbsent(field.name, () {
      // 1) Detect from the existing stored value (e.g. user edited form,
      //    came back, the cubit has `+44…` already).
      if (value.startsWith('+')) {
        final sorted = List<CountryLocale>.from(CountryLocales.all)
          ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
        for (final c in sorted) {
          if (value.startsWith(c.dialCode)) return c;
        }
      }
      // 2) Default to the user's home country from LocaleManager — not a
      //    hardcoded Nigeria. A US user filling a Nigerian product still
      //    sees +1 first; they can override via the picker.
      try {
        final userCountry = GetIt.I<LocaleManager>().currentCountry;
        final match = CountryLocales.findByCountryCode(userCountry);
        if (match != null) return match;
      } catch (_) {/* GetIt not ready / not registered → fall through */}
      // 3) Absolute fallback for cold-boot / DI failure.
      return CountryLocales.all.first;
    });

    final country = _phoneCountryCodes[field.name]!;

    // Strip dial code from displayed value so controller only has local digits
    String localValue = value;
    if (value.startsWith(country.dialCode)) {
      localValue = value.substring(country.dialCode.length);
    } else if (value.startsWith('+')) {
      // Strip any other dial code prefix
      final sorted = List<CountryLocale>.from(CountryLocales.all)
        ..sort((a, b) => b.dialCode.length.compareTo(a.dialCode.length));
      for (final c in sorted) {
        if (value.startsWith(c.dialCode)) {
          localValue = value.substring(c.dialCode.length);
          break;
        }
      }
    }

    final controller = _getController(field.name, localValue);
    // Sync controller if value changed externally
    if (controller.text != localValue && localValue != value) {
      controller.text = localValue;
    }

    // Resolve the per-country rule so live validation matches the
    // server-side validator MyCover applies. Falls back to a 7-15 digit
    // length range for any country we don't have a specific rule for.
    final countryRule = _phoneRulesByCountry[country.countryCode];
    final maxLocal = countryRule?.localDigits ?? 15;

    final digits = controller.text.replaceAll(RegExp(r'[^\d]'), '');
    // National trunk-zero prefix support: NG/GB/KE/etc. write
    // "08012345678" instead of "+2348012345678". Treat any input that
    // starts with '0' as if the user typed the local-format number; the
    // canonical E.164 form sent to MyCover always has the leading 0
    // stripped. The input formatter below uses this same flag to set
    // the right hard cap so the user can't overshoot.
    final stripped = digits.startsWith('0') ? digits.substring(1) : digits;
    String? inlineError = error;
    if (inlineError == null && digits.isNotEmpty) {
      if (countryRule != null) {
        // Country-specific rule. We only ever show two states now: the
        // start-digit error (user typed a non-mobile prefix) and a
        // "needs N more digits" hint. The "too many digits" branch is
        // unreachable because the formatter caps input at exactly the
        // allowed length.
        if (stripped.isNotEmpty &&
            !countryRule.validStartDigits.contains(stripped[0])) {
          final starts = countryRule.validStartDigits.join('/');
          inlineError = 'Number must start with $starts after the country code';
        } else if (stripped.length < countryRule.localDigits) {
          final remaining = countryRule.localDigits - stripped.length;
          inlineError = remaining == 1
              ? 'Enter 1 more digit'
              : 'Enter $remaining more digits';
        }
      } else {
        if (stripped.length < 7) {
          inlineError = 'Enter at least 7 digits';
        }
      }
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: inlineError != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D),
            ),
          ),
          child: Row(
            children: [
              // Country code button
              GestureDetector(
                onTap: () => _showPhoneCountryPicker(field.name, cubit, field, controller),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  decoration: const BoxDecoration(
                    border: Border(right: BorderSide(color: Color(0xFF2D2D2D), width: 1)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(country.flag, style: TextStyle(fontSize: 18.sp)),
                      SizedBox(width: 4.w),
                      Text(country.dialCode,
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                      SizedBox(width: 2.w),
                      Icon(Icons.keyboard_arrow_down, color: const Color(0xFF6B7280), size: 16.sp),
                    ],
                  ),
                ),
              ),
              // Local number input. The formatter caps the input to
              // EXACTLY the allowed length for the selected country:
              // `localDigits` if the first digit is non-zero, or
              // `localDigits + 1` if the user is typing the national-
              // trunk form (`08…` in NG). That way the user can never
              // type one digit too many, so we never need a "too many
              // digits" error. The canonical E.164 form sent to MyCover
              // always has the leading 0 stripped (see onChanged below).
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    _LeadingZeroAwareLengthFormatter(localDigits: maxLocal),
                  ],
                  onChanged: (v) {
                    // Mirror the server-side normalizer: digits only,
                    // strip a single leading 0, build canonical E.164
                    // `<dialCode><local>`. The full value is what MyCover
                    // receives; even when the input is still invalid we
                    // store the canonical form so submit-time validation
                    // operates on the same shape.
                    final local = v.replaceAll(RegExp(r'[^\d]'), '');
                    final s = local.startsWith('0') ? local.substring(1) : local;
                    final full = s.isEmpty ? '' : '${country.dialCode}$s';
                    _debouncer.run(() => cubit.updateFormField(field.name, full));
                  },
                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                  decoration: InputDecoration(
                    hintText: country.countryCode == 'NG'
                        ? '08012345678'
                        : 'Mobile number',
                    hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (inlineError != null)
          Padding(
            padding: EdgeInsets.only(top: 6.h, left: 4.w),
            child: Text(inlineError, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444))),
          ),
      ]),
    );
  }

  void _showPhoneCountryPicker(String fieldName, CreatePolicyCubit cubit, InsuranceProductFormField field, TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final filtered = searchQuery.isEmpty ? CountryLocales.all : CountryLocales.search(searchQuery);
            return DraggableScrollableSheet(
              initialChildSize: 0.7, maxChildSize: 0.9, minChildSize: 0.4,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                      width: 40.w, height: 4.h,
                      decoration: BoxDecoration(color: const Color(0xFF2D2D2D), borderRadius: BorderRadius.circular(2.r)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Select Country Code', style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        GestureDetector(onTap: () => Navigator.pop(context), child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp)),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      child: TextField(
                        onChanged: (v) => setSheetState(() => searchQuery = v),
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                        decoration: InputDecoration(
                          hintText: 'Search country...', hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                          prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                          filled: true, fillColor: const Color(0xFF0A0A0A),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final c = filtered[index];
                          final isSelected = c.countryCode == _phoneCountryCodes[fieldName]?.countryCode;
                          return GestureDetector(
                            onTap: () {
                              setState(() => _phoneCountryCodes[fieldName] = c);
                              // Re-send full phone to cubit
                              final local = controller.text.replaceAll(RegExp(r'[^\d]'), '');
                              final s = local.startsWith('0') ? local.substring(1) : local;
                              cubit.updateFormField(field.name, '${c.dialCode}$s');
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                              decoration: BoxDecoration(
                                color: isSelected ? const Color(0xFF3B82F6).withValues(alpha: 0.1) : const Color(0xFF0A0A0A),
                                borderRadius: BorderRadius.circular(12.r),
                                border: isSelected ? Border.all(color: const Color(0xFF3B82F6), width: 1.5) : null,
                              ),
                              child: Row(children: [
                                Text(c.flag, style: TextStyle(fontSize: 24.sp)),
                                SizedBox(width: 12.w),
                                Expanded(child: Text(c.countryName, style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500))),
                                Text(c.dialCode, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp, fontWeight: FontWeight.w600)),
                                if (isSelected) ...[SizedBox(width: 8.w), Icon(Icons.check_circle, color: const Color(0xFF3B82F6), size: 20.sp)],
                              ]),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDropdownField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showSelectBottomSheet(cubit, field, value),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: error != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
            ),
            child: Row(children: [
              Expanded(
                child: Text(
                  value.isNotEmpty ? value : 'Select ${field.label.toLowerCase()}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: value.isNotEmpty ? Colors.white : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                ),
              ),
              Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
            ]),
          ),
        ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  void _showSelectBottomSheet(CreatePolicyCubit cubit, InsuranceProductFormField field, String currentValue) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final options = field.options;
            final filtered = searchQuery.isEmpty
                ? options
                : options.where((o) => o.toLowerCase().contains(searchQuery.toLowerCase())).toList();
            return DraggableScrollableSheet(
              initialChildSize: options.length > 6 ? 0.7 : 0.45,
              maxChildSize: 0.9,
              minChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
                  ),
                  child: Column(children: [
                    Container(
                      margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                      width: 40.w, height: 4.h,
                      decoration: BoxDecoration(color: const Color(0xFF2D2D2D), borderRadius: BorderRadius.circular(2.r)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text('Select ${field.label}',
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                        ),
                      ]),
                    ),
                    if (options.length > 5)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                        child: TextField(
                          onChanged: (v) => setSheetState(() => searchQuery = v),
                          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                            prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                            filled: true, fillColor: const Color(0xFF0A0A0A),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          ),
                        ),
                      ),
                    Expanded(
                      child: filtered.isEmpty
                        ? Center(child: Text('No options found', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14.sp)))
                        : ListView.builder(
                            controller: scrollController,
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            itemCount: filtered.length,
                            itemBuilder: (context, index) {
                              final option = filtered[index];
                              final isSelected = option == currentValue;
                              return GestureDetector(
                                onTap: () {
                                  cubit.updateFormField(field.name, option);
                                  Navigator.pop(context);
                                  setState(() {}); // Refresh the form
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 6.h),
                                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.1) : const Color(0xFF0A0A0A),
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: isSelected ? Border.all(color: const Color(0xFF6366F1), width: 1.5) : null,
                                  ),
                                  child: Row(children: [
                                    Expanded(child: Text(option,
                                      style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400))),
                                    if (isSelected)
                                      Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 20.sp),
                                  ]),
                                ),
                              );
                            },
                          ),
                    ),
                  ]),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDateField(BuildContext context, CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    final controller = _getController(field.name, value);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final now = DateTime.now();
            final today = DateTime(now.year, now.month, now.day);
            final fieldName = field.name.toLowerCase();
            // Per-field bounds:
            //   • date_of_birth     → 1900-01-01 … today (must be past)
            //   • departure_date    → today    … today+2y
            //   • arrival_date /
            //     return_date       → max(today, departure_date) … today+2y
            //   • other date fields → 2000 … 2100 (legacy default)
            DateTime firstDate = DateTime(2000);
            DateTime lastDate = DateTime(2100);
            DateTime initial = now;
            if (fieldName == 'date_of_birth') {
              firstDate = DateTime(1900);
              lastDate = today;
              initial = DateTime(now.year - 30, now.month, now.day);
            } else if (fieldName == 'departure_date') {
              // MyCover occasionally rejects today-of-purchase as "not
              // today or a future date" — likely a timezone skew between
              // their server and our wall clock. Default the picker to
              // tomorrow so the happy path never hits that edge case;
              // user can still pick today if they really want to.
              firstDate = today;
              lastDate = today.add(const Duration(days: 365 * 2));
              initial = today.add(const Duration(days: 1));
            } else if (fieldName == 'arrival_date' || fieldName == 'return_date') {
              final dep = DateTime.tryParse(_lastFormData['departure_date'] ?? '');
              // Default arrival to departure + 7 days (typical short trip)
              // when departure is set, otherwise today + 8 days so the
              // picker lands on a sane future date instead of today.
              firstDate = (dep != null && dep.isAfter(today)) ? dep : today;
              lastDate = today.add(const Duration(days: 365 * 2));
              if (dep != null && dep.isAfter(today)) {
                initial = dep.add(const Duration(days: 7));
              } else {
                initial = today.add(const Duration(days: 8));
              }
              if (initial.isAfter(lastDate)) initial = lastDate;
            } else if (fieldName == 'device_purchase_date' || fieldName == 'disbursement_date') {
              // Gadget: device must have been purchased on or before today.
              // Life: disbursement_date is when a loan was disbursed — past-only.
              firstDate = today.subtract(const Duration(days: 365 * 20));
              lastDate = today;
              initial = today.subtract(const Duration(days: 30));
            } else if (fieldName == 'shipping_date') {
              // Package (Marine + GIT): shipping date can be past or
              // future within a ±window — see _validateField.
              firstDate = today.subtract(const Duration(days: 90));
              lastDate = today.add(const Duration(days: 365));
              initial = today;
            }
            final date = await showDatePicker(
              context: context,
              initialDate: initial.isBefore(firstDate) ? firstDate : initial,
              firstDate: firstDate, lastDate: lastDate,
              builder: (context, child) => Theme(
                data: ThemeData.dark().copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFF6366F1), surface: Color(0xFF1F1F1F))),
                child: child!));
            if (date != null && mounted) {
              final formatted = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
              cubit.updateFormField(field.name, formatted);
              controller.text = formatted;
              // When departure changes, force re-validation of arrival.
              if (fieldName == 'departure_date') setState(() {});
            }
          },
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Select date',
                hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5)),
                filled: true, fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                errorText: error,
                suffixIcon: Icon(Icons.calendar_today, color: const Color(0xFF9CA3AF), size: 18.sp),
                contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildBooleanField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.description.isNotEmpty)
            field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
        ])),
        Switch(
          value: value.toLowerCase() == 'true' || value == '1' || value.toLowerCase() == 'yes',
          onChanged: (v) => cubit.updateFormField(field.name, v.toString()),
          activeColor: const Color(0xFF6366F1),
          activeTrackColor: const Color(0xFF6366F1).withValues(alpha: 0.3),
          inactiveThumbColor: const Color(0xFF9CA3AF),
          inactiveTrackColor: const Color(0xFF2D2D2D),
        ),
      ]),
    );
  }

  Widget _buildFileUploadField(CreatePolicyCubit cubit, InsuranceProductFormField field, String value, String? error) {
    final isStaging = _fileUploading[field.name] ?? false;
    final staged = cubit.stagedFile(field.name);
    final hasPending = staged != null || value == CreatePolicyCubit.pendingUploadMarker;
    final hasRemoteUrl = value.isNotEmpty && value != CreatePolicyCubit.pendingUploadMarker;

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        if (field.description.isNotEmpty)
          Padding(padding: EdgeInsets.only(top: 2.h),
            child: field.description.contains('<') && field.description.contains('>')
              ? HtmlWidget(field.description, textStyle: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)),
                  customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'})
              : Text(field.description, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF)))),
        SizedBox(height: 8.h),
        if (staged != null)
          _buildStagedFilePreview(cubit, field, staged)
        else
          GestureDetector(
            onTap: isStaging ? null : () => _showUploadSourceSheet(cubit, field),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: error != null
                    ? const Color(0xFFEF4444)
                    : hasPending || hasRemoteUrl
                        ? const Color(0xFF10B981)
                        : const Color(0xFF2D2D2D)),
              ),
              child: Row(children: [
                Icon(
                  hasPending || hasRemoteUrl ? Icons.check_circle : Icons.cloud_upload_outlined,
                  color: hasPending || hasRemoteUrl ? const Color(0xFF10B981) : const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(child: Text(
                  isStaging
                      ? 'Preparing…'
                      : hasRemoteUrl
                          ? 'File uploaded'
                          : 'Tap to attach file',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: hasPending || hasRemoteUrl
                        ? const Color(0xFF10B981)
                        : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  ),
                )),
                if (isStaging)
                  SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6366F1))),
              ]),
            ),
          ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  /// Preview row for a staged (not-yet-uploaded) file. Shows a thumbnail
  /// for images, a doc icon for everything else, the filename, an
  /// upload-pending hint, and Replace / Remove actions. Tapping the
  /// thumbnail opens the full-screen viewer.
  Widget _buildStagedFilePreview(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field,
    StagedInsuranceFile staged,
  ) {
    final heroTag = 'staged-preview-${field.name}';
    final sizeKb = (staged.bytes.length / 1024).round();
    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
      ),
      child: Row(children: [
        GestureDetector(
          onTap: () => _openFullScreenPreview(staged, heroTag),
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                width: 56.w,
                height: 56.w,
                color: const Color(0xFF2D2D2D),
                child: staged.isImage
                    ? Image.memory(
                        Uint8List.fromList(staged.bytes),
                        fit: BoxFit.cover,
                        gaplessPlayback: true,
                      )
                    : Icon(
                        Icons.insert_drive_file_outlined,
                        color: const Color(0xFF6366F1),
                        size: 28.sp,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              staged.filename,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${sizeKb < 1024 ? "$sizeKb KB" : "${(sizeKb / 1024).toStringAsFixed(1)} MB"} · Uploads on purchase',
              style: GoogleFonts.inter(
                fontSize: 11.sp,
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ]),
        ),
        IconButton(
          tooltip: 'Replace file',
          onPressed: () => _showUploadSourceSheet(cubit, field),
          icon: Icon(Icons.swap_horiz_rounded,
              color: const Color(0xFF9CA3AF), size: 20.sp),
        ),
        IconButton(
          tooltip: 'Remove file',
          onPressed: () {
            cubit.clearPendingFile(field.name);
            setState(() {});
          },
          icon: Icon(Icons.delete_outline_rounded,
              color: const Color(0xFFEF4444), size: 20.sp),
        ),
      ]),
    );
  }

  /// Full-screen preview. Images get InteractiveViewer for pinch/zoom;
  /// non-image documents (PDFs etc) show the filename + size with a
  /// note that the file uploads during purchase — we don't ship an
  /// in-app PDF renderer for the preview slot to keep the dependency
  /// surface small.
  void _openFullScreenPreview(StagedInsuranceFile staged, String heroTag) {
    Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      barrierColor: Colors.black.withValues(alpha: 0.92),
      pageBuilder: (_, __, ___) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            staged.filename,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Center(
          child: Hero(
            tag: heroTag,
            child: staged.isImage
                ? InteractiveViewer(
                    minScale: 0.8,
                    maxScale: 4.0,
                    child: Image.memory(
                      Uint8List.fromList(staged.bytes),
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.description_outlined,
                            color: const Color(0xFF6366F1), size: 80.sp),
                        SizedBox(height: 16.h),
                        Text(
                          staged.filename,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Preview not available for ${staged.contentType.isEmpty ? "this file type" : staged.contentType}.\n'
                          'The file uploads during purchase.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF9CA3AF),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    ));
  }

  // 10MB — matches MyCover.ai's upload endpoint limit. The gateway also
  // enforces this server-side; this client check just gives faster
  // feedback than waiting for an upload to fail mid-way.
  static const int _maxUploadBytes = 10 * 1024 * 1024;

  Future<void> _pickAndUploadFile(CreatePolicyCubit cubit, InsuranceProductFormField field) async {
    // FileType.custom + allowedExtensions covers ID-card photos
    // (jpg/jpeg/png), receipts (pdf), and existing document scans —
    // the same set we accept on MyCover's upload endpoint. The
    // camera/gallery path lives in _captureFromImagePicker so users
    // who want to snap an ID don't need to navigate Files first.
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );
    if (result == null || result.files.isEmpty || result.files.first.bytes == null) return;
    final file = result.files.first;
    await _uploadBytes(cubit, field, bytes: file.bytes!.toList(), filename: file.name);
  }

  /// Bottom sheet that lets the user choose between Take Photo (camera)
  /// and Upload File (gallery / files). The two paths converge on
  /// `_uploadBytes` so the network + cubit handling stays in one place.
  /// Surfaced for any field that goes through `_buildFileUploadField` —
  /// identification documents, claim evidence, device photos, etc.
  Future<void> _showUploadSourceSheet(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field,
  ) async {
    if (!mounted) return;
    final choice = await showModalBottomSheet<_UploadSource>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add ${field.label.toLowerCase()}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _uploadSourceTile(
                sheetContext,
                icon: Icons.photo_camera_outlined,
                title: 'Take photo',
                subtitle: 'Use your camera',
                value: _UploadSource.camera,
              ),
              _uploadSourceTile(
                sheetContext,
                icon: Icons.image_outlined,
                title: 'Choose from gallery',
                subtitle: 'Pick an existing image',
                value: _UploadSource.gallery,
              ),
              _uploadSourceTile(
                sheetContext,
                icon: Icons.upload_file_outlined,
                title: 'Upload file',
                subtitle: 'PDF, JPG, or PNG (max 10 MB)',
                value: _UploadSource.file,
              ),
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
    if (choice == null) return;
    switch (choice) {
      case _UploadSource.camera:
        await _captureFromImagePicker(cubit, field, picker.ImageSource.camera);
        break;
      case _UploadSource.gallery:
        await _captureFromImagePicker(cubit, field, picker.ImageSource.gallery);
        break;
      case _UploadSource.file:
        await _pickAndUploadFile(cubit, field);
        break;
    }
  }

  /// Shared list-row in the upload-source sheet. Wraps a tap target in
  /// our card styling so all three options read uniformly.
  Widget _uploadSourceTile(
    BuildContext sheetContext, {
    required IconData icon,
    required String title,
    required String subtitle,
    required _UploadSource value,
  }) {
    return InkWell(
      onTap: () => Navigator.of(sheetContext).pop(value),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: const Color(0xFF6366F1), size: 20.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: const Color(0xFF9CA3AF), size: 18.sp),
          ],
        ),
      ),
    );
  }

  /// Camera + gallery path. Uses `image_picker` (already in pubspec) and
  /// feeds the result into `_uploadBytes` so the upload + cubit handling
  /// matches the file-picker path. Compression set to 80% jpeg quality
  /// + max 2048px wide so an ID-card photo lands well under MyCover's
  /// 10 MB limit even on phones with high-megapixel cameras.
  Future<void> _captureFromImagePicker(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field,
    picker.ImageSource source,
  ) async {
    try {
      final imagePicker = picker.ImagePicker();
      final shot = await imagePicker.pickImage(
        source: source,
        maxWidth: 2048,
        imageQuality: 80,
      );
      if (shot == null) return; // user cancelled
      final bytes = await File(shot.path).readAsBytes();
      if (!mounted) return;
      await _uploadBytes(
        cubit,
        field,
        bytes: bytes,
        filename: shot.name,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not capture image: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  /// Stages a file for upload during the purchase saga instead of
  /// hitting the network now. The form renders a preview thumbnail
  /// (Image.memory or doc icon) + full-screen viewer + Replace/Remove
  /// actions while the file sits in cubit memory; the bytes are flushed
  /// to MyCover during `InsuranceProcessingStep.uploadingDocuments`,
  /// so the user can swap or delete the file freely without burning
  /// upload quota.
  Future<void> _uploadBytes(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field, {
    required List<int> bytes,
    required String filename,
  }) async {
    if (bytes.length > _maxUploadBytes) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('File too large. Maximum size is 10 MB.'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
      return;
    }
    if (!mounted) return;
    setState(() => _fileUploading[field.name] = true);
    try {
      // Await the stage flow so the "Preparing…" spinner stays until
      // the backend hands back the upload + public URL pair. The
      // actual PUT runs in the background after this returns — we
      // don't block on the bytes finishing upload, only on the URL
      // resolution.
      await cubit.stagePendingFile(
        fieldName: field.name,
        bytes: bytes,
        filename: filename,
        contentType: _sniffContentType(filename),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Couldn't attach file: $e"),
              backgroundColor: const Color(0xFFEF4444)),
        );
      }
    } finally {
      if (mounted) setState(() => _fileUploading[field.name] = false);
    }
  }

  /// Best-effort content-type sniff from the filename extension. The
  /// staged preview uses this to choose between Image.memory and the
  /// generic document icon; the actual upload during purchase passes
  /// raw bytes so MyCover does its own content-type detection.
  String _sniffContentType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.pdf')) return 'application/pdf';
    return 'application/octet-stream';
  }

  Widget _buildAuxiliarySelectField(
    CreatePolicyCubit cubit,
    InsuranceProductFormField field,
    String value,
    String? error,
    String utilityId,
    Map<String, String> formData,
  ) {
    final cacheKey = '$utilityId:${_getDependentQuery(field, formData) ?? ""}';
    final items = _auxiliaryCache[cacheKey];
    final isLoading = _auxiliaryLoading[cacheKey] ?? false;
    final loadError = _auxiliaryError[cacheKey];

    // Load auxiliary data if not cached and not in an error state
    // (otherwise we'd re-fire the request every rebuild on a flaky
    // network). Retry is wired to the inline error tap below.
    // _loadAuxiliaryData calls setState — illegal during build — so DEFER it
    // to just after this frame. Without this, any product whose form has an
    // auxiliary/utility-backed select crashes on first render with
    // "setState() called during build". Guarded by mounted + the idempotency
    // check inside _loadAuxiliaryData (several frames can schedule a load
    // before the first callback flips the loading flag).
    if (items == null && !isLoading && loadError == null) {
      final depQuery = _getDependentQuery(field, formData);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _loadAuxiliaryData(cacheKey, utilityId, depQuery);
      });
    }

    final options = items?.map((i) => i.value).toList() ?? field.options;
    final labels = items != null ? {for (var i in items) i.value: i.label} : <String, String>{};

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text(field.label, style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: Colors.white)),
          if (field.required) Text(' *', style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444))),
        ]),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: error != null ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D)),
          ),
          child: isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Row(children: [
                  SizedBox(width: 16.w, height: 16.w, child: const CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6366F1))),
                  SizedBox(width: 10.w),
                  Text('Loading options...', style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
                ]),
              )
            : loadError != null
              ? GestureDetector(
                  onTap: () {
                    setState(() => _auxiliaryError[cacheKey] = null);
                    _loadAuxiliaryData(cacheKey, utilityId, _getDependentQuery(field, formData));
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    child: Row(children: [
                      Icon(Icons.refresh, color: const Color(0xFFEF4444), size: 18.sp),
                      SizedBox(width: 10.w),
                      Expanded(child: Text(loadError, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFFEF4444)))),
                    ]),
                  ),
                )
              : options.length > 20
                ? _buildSearchableSelectTrigger(
                    cubit: cubit,
                    field: field,
                    value: value,
                    options: options,
                    labels: labels,
                  )
                : DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value.isNotEmpty && options.contains(value) ? value : null,
                    hint: Text('Select ${field.label.toLowerCase()}',
                      style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.5))),
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1F1F1F),
                    style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                    icon: Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
                    items: options.map((o) => DropdownMenuItem(value: o, child: Text(labels[o] ?? o))).toList(),
                    onChanged: (v) { if (v != null) cubit.updateFormField(field.name, v); },
                  ),
                ),
        ),
        if (error != null)
          Padding(padding: EdgeInsets.only(top: 6.h, left: 14.w),
            child: Text(error, style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFFEF4444)))),
      ]),
    );
  }

  /// Tap-target shown in place of the inline dropdown when an auxiliary
  /// select has > 20 options (countries, banks, vehicle makes). Opens a
  /// searchable bottom sheet so the user doesn't have to scroll a
  /// 200-row dropdown to find their destination country.
  Widget _buildSearchableSelectTrigger({
    required CreatePolicyCubit cubit,
    required InsuranceProductFormField field,
    required String value,
    required List<String> options,
    required Map<String, String> labels,
  }) {
    final selectedLabel = value.isNotEmpty ? (labels[value] ?? value) : '';
    return GestureDetector(
      onTap: () => _showSearchableOptionsSheet(
        title: field.label,
        options: options,
        labels: labels,
        currentValue: value,
        onPick: (picked) => cubit.updateFormField(field.name, picked),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(children: [
          Expanded(child: Text(
            selectedLabel.isNotEmpty ? selectedLabel : 'Select ${field.label.toLowerCase()}',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: selectedLabel.isNotEmpty ? Colors.white : const Color(0xFF9CA3AF).withValues(alpha: 0.5),
            ),
          )),
          Icon(Icons.keyboard_arrow_down, color: const Color(0xFF9CA3AF), size: 20.sp),
        ]),
      ),
    );
  }

  /// Generic searchable bottom-sheet picker. Mirrors the country-code
  /// sheet in policy_holder_info_screen.dart but operates on a flat
  /// list of values + a value→label map (so we can display friendly
  /// names while sending the canonical value back to the form).
  void _showSearchableOptionsSheet({
    required String title,
    required List<String> options,
    required Map<String, String> labels,
    required String currentValue,
    required void Function(String) onPick,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        String query = '';
        return StatefulBuilder(builder: (ctx, setSheetState) {
          final filtered = query.isEmpty
              ? options
              : options.where((o) {
                  final label = (labels[o] ?? o).toLowerCase();
                  final q = query.toLowerCase();
                  return label.contains(q) || o.toLowerCase().contains(q);
                }).toList();
          return DraggableScrollableSheet(
            initialChildSize: 0.7, maxChildSize: 0.9, minChildSize: 0.4,
            builder: (_, scrollCtl) => Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                  width: 40.w, height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Select $title',
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
                    GestureDetector(
                      onTap: () => Navigator.pop(sheetCtx),
                      child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 24.sp),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                  child: TextField(
                    autofocus: true,
                    onChanged: (v) => setSheetState(() => query = v),
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 14.sp),
                      prefixIcon: Icon(Icons.search, color: const Color(0xFF6B7280), size: 20.sp),
                      filled: true, fillColor: const Color(0xFF0A0A0A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    ),
                  ),
                ),
                Expanded(child: ListView.builder(
                  controller: scrollCtl,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: filtered.length,
                  itemBuilder: (_, i) {
                    final opt = filtered[i];
                    final isSelected = opt == currentValue;
                    return GestureDetector(
                      onTap: () {
                        onPick(opt);
                        Navigator.pop(sheetCtx);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8.h),
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: isSelected
                            ? const Color(0xFF3B82F6).withValues(alpha: 0.1)
                            : const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(12.r),
                          border: isSelected
                            ? Border.all(color: const Color(0xFF3B82F6), width: 1.5)
                            : null,
                        ),
                        child: Row(children: [
                          Expanded(child: Text(
                            labels[opt] ?? opt,
                            style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500))),
                          if (isSelected) Icon(Icons.check_circle, color: const Color(0xFF3B82F6), size: 20.sp),
                        ]),
                      ),
                    );
                  },
                )),
              ]),
            ),
          );
        });
      },
    );
  }

  Future<void> _loadAuxiliaryData(String cacheKey, String utilityId, String? query) async {
    // Idempotent: a single build can schedule several post-frame loads before
    // the first flips the loading flag, so ignore re-entrant calls for a key
    // that is already loading or already cached.
    if ((_auxiliaryLoading[cacheKey] ?? false) || _auxiliaryCache[cacheKey] != null) {
      return;
    }
    setState(() {
      _auxiliaryLoading[cacheKey] = true;
      _auxiliaryError[cacheKey] = null;
    });
    try {
      final repo = GetIt.I<InsuranceRepository>();
      final items = await repo.getInsuranceAuxiliaryData(utilityId: utilityId, query: query);
      if (mounted) {
        setState(() {
          _auxiliaryCache[cacheKey] = items;
          _auxiliaryLoading[cacheKey] = false;
        });
      }
    } catch (e) {
      // Surface the error inline rather than silently hiding it — the
      // user sees an empty dropdown otherwise and can't progress.
      if (mounted) {
        setState(() {
          _auxiliaryLoading[cacheKey] = false;
          _auxiliaryError[cacheKey] = 'Could not load options. Tap to retry.';
        });
      }
    }
  }
}

/// Per-country mobile-number rule used by [_validatePhoneNumber]. Local
/// digits length is exact (no range) because every supported country's
/// numbering plan is fixed length once the trunk prefix is stripped.
/// Source the user selected in the file-upload bottom sheet. We use an
/// enum (rather than a string) so the switch in `_showUploadSourceSheet`
/// is exhaustive — adding a new source means the compiler flags any
/// branch that hasn't handled it.
enum _UploadSource { camera, gallery, file }

class _PhoneRule {
  final int localDigits;
  final List<String> validStartDigits;
  const _PhoneRule({required this.localDigits, required this.validStartDigits});
}

/// Input formatter that caps phone-number input to `localDigits` digits
/// normally, but allows `localDigits + 1` when the user starts with a
/// '0' (the national trunk prefix that several countries — NG, GB, KE,
/// ZA, GH — use when writing the number locally). The cubit strips that
/// leading zero before sending the canonical E.164 form to MyCover, so
/// the user can type either `8012345678` or `08012345678` for NG and
/// both produce `+2348012345678` on the wire.
///
/// We do this in a formatter (rather than a `LengthLimitingTextInput
/// Formatter` configured to `localDigits + 1` unconditionally) so the
/// "too many digits" error is impossible to reach — a user who didn't
/// type a leading zero is hard-stopped at the correct length.
class _LeadingZeroAwareLengthFormatter extends TextInputFormatter {
  final int localDigits;

  const _LeadingZeroAwareLengthFormatter({required this.localDigits});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) return newValue;
    // FilteringTextInputFormatter.digitsOnly runs before us, but be
    // defensive — strip anything that's not a digit just in case.
    final digits = text.replaceAll(RegExp(r'[^\d]'), '');
    final cap = digits.startsWith('0') ? localDigits + 1 : localDigits;
    if (digits.length <= cap) {
      // If the formatter above us stripped non-digits, keep the new
      // value's selection but use the digit-only text.
      if (digits == text) return newValue;
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(offset: digits.length),
      );
    }
    final clipped = digits.substring(0, cap);
    return TextEditingValue(
      text: clipped,
      selection: TextSelection.collapsed(offset: clipped.length),
    );
  }
}
