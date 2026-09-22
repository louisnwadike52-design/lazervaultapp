import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_surfaces.dart';
import '../cubit/fcy_kyc_steps.dart';

/// Renders one KYC field.
///
/// A single place that knows each field's label, hint, keyboard and input
/// formatting — rather than 24 hand-written TextFormFields, which is what the
/// original single-page form was and why its fields drifted apart in style.
///
/// Styling follows AppSurfaces: one soft accent-tinted edge on a gradient card,
/// radius 14. Not the stack of grey hairlines the old form used — the brief was
/// explicitly "no tiny borders".
class FcyKycFieldInput extends StatelessWidget {
  const FcyKycFieldInput({
    super.key,
    required this.id,
    required this.value,
    required this.onChanged,
    required this.currency,
  });

  final FcyKycFieldId id;
  final String value;
  final ValueChanged<String> onChanged;
  final String currency;

  @override
  Widget build(BuildContext context) {
    final spec = _specFor(id, currency);

    if (spec.options != null) {
      return _dropdown(context, spec);
    }
    return _text(context, spec);
  }

  Widget _text(BuildContext context, _FieldSpec spec) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(spec.label),
          SizedBox(height: 7.h),
          Container(
            decoration: AppSurfaces.card(radius: 14, accentAlpha: 0.18),
            child: TextFormField(
              // initialValue rather than a controller: the cubit owns the value,
              // and a controller here would be a second source of truth that has
              // to be kept in step with it.
              initialValue: value,
              onChanged: onChanged,
              keyboardType: spec.keyboard,
              textCapitalization: spec.capitalization,
              style: TextStyle(color: Colors.white, fontSize: 15.sp),
              decoration: InputDecoration(
                hintText: spec.hint,
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
              ),
            ),
          ),
          if (spec.helper != null) ...[
            SizedBox(height: 6.h),
            Text(
              spec.helper!,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.45),
                fontSize: 11.5.sp,
                height: 1.35,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dropdown(BuildContext context, _FieldSpec spec) {
    // A value that is not in the option list would make DropdownButton throw, and
    // the list is currency-dependent (document types differ for EUR), so fall back
    // to the first option rather than crashing the step.
    final options = spec.options!;
    final current = options.contains(value) ? value : options.first;

    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label(spec.label),
          SizedBox(height: 7.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: AppSurfaces.card(radius: 14, accentAlpha: 0.18),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: current,
                isExpanded: true,
                dropdownColor: AppSurfaces.cardTop,
                icon: Icon(Icons.expand_more_rounded,
                    color: Colors.white.withValues(alpha: 0.5)),
                style: TextStyle(color: Colors.white, fontSize: 15.sp),
                padding: EdgeInsets.symmetric(vertical: 4.h),
                items: options
                    .map((o) => DropdownMenuItem(
                          value: o,
                          child: Text(_humanize(o)),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) onChanged(v);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String text) => Text(
        text,
        style: TextStyle(
          // primaryPurpleLight, not the brand purple: #4E03D0 fails WCAG contrast
          // on a near-black ground, so labels and thin borders use the lighter tone.
          color: const Color(0xFFA78BFA),
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      );
}

/// Turns an enum-ish wire value into something readable.
String _humanize(String raw) {
  if (raw.isEmpty) return raw;
  final words = raw.replaceAll('_', ' ').split(' ');
  return words
      .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
      .join(' ');
}

class _FieldSpec {
  const _FieldSpec({
    required this.label,
    this.hint,
    this.helper,
    this.keyboard = TextInputType.text,
    this.capitalization = TextCapitalization.none,
    this.options,
  });

  final String label;
  final String? hint;
  final String? helper;
  final TextInputType keyboard;
  final TextCapitalization capitalization;
  final List<String>? options;
}

/// Label, hint and keyboard per field.
///
/// The date fields carry an explicit YYYY-MM-DD hint because that is the format the
/// provider requires and the one thing a free-text date field reliably gets wrong.
_FieldSpec _specFor(FcyKycFieldId id, String currency) {
  switch (id) {
    case FcyKycFieldId.firstName:
      return const _FieldSpec(
          label: 'First name', capitalization: TextCapitalization.words);
    case FcyKycFieldId.lastName:
      return const _FieldSpec(
          label: 'Last name', capitalization: TextCapitalization.words);
    case FcyKycFieldId.email:
      return const _FieldSpec(
          label: 'Email address',
          hint: 'you@example.com',
          keyboard: TextInputType.emailAddress);
    case FcyKycFieldId.phone:
      return const _FieldSpec(
          label: 'Phone number', keyboard: TextInputType.phone);
    case FcyKycFieldId.birthDate:
      return const _FieldSpec(
          label: 'Date of birth',
          hint: 'YYYY-MM-DD',
          keyboard: TextInputType.datetime,
          helper: 'Must match your ID document exactly.');
    case FcyKycFieldId.nationality:
      return const _FieldSpec(
          label: 'Nationality',
          hint: 'NG',
          helper: 'Two-letter country code.',
          capitalization: TextCapitalization.characters);

    case FcyKycFieldId.addressStreet:
      return const _FieldSpec(
          label: 'Street address',
          hint: '12 Herbert Macaulay Way',
          capitalization: TextCapitalization.words);
    case FcyKycFieldId.addressCity:
      return const _FieldSpec(
          label: 'City', capitalization: TextCapitalization.words);
    case FcyKycFieldId.addressState:
      return const _FieldSpec(
          label: 'State', capitalization: TextCapitalization.words);
    case FcyKycFieldId.addressZip:
      return const _FieldSpec(
          label: 'Postcode',
          helper: 'If your area has no postcode, enter the nearest one.');
    case FcyKycFieldId.countryOfResidence:
      return const _FieldSpec(
          label: 'Country of residence',
          hint: 'NG',
          capitalization: TextCapitalization.characters);

    case FcyKycFieldId.occupation:
      return const _FieldSpec(
          label: 'Occupation',
          hint: 'Software engineer',
          capitalization: TextCapitalization.sentences);
    case FcyKycFieldId.employmentStatus:
      return const _FieldSpec(label: 'Employment status', options: [
        'Employed',
        'Self-employed',
        'Business',
        'Student',
        'Retired',
        'Unemployed',
      ]);
    case FcyKycFieldId.sourceOfIncome:
      return const _FieldSpec(label: 'Source of income', options: [
        'Salary',
        'Business',
        'Investments',
        'Savings',
        'Pension',
        'Family support',
      ]);
    case FcyKycFieldId.incomeLower:
      return const _FieldSpec(
          label: 'Annual income from',
          hint: '1000000',
          keyboard: TextInputType.number);
    case FcyKycFieldId.incomeUpper:
      return const _FieldSpec(
          label: 'Annual income to',
          hint: '5000000',
          keyboard: TextInputType.number);
    case FcyKycFieldId.monthlyTxCount:
      return const _FieldSpec(
          label: 'Transactions per month',
          hint: '10',
          keyboard: TextInputType.number,
          helper: 'Roughly how many transfers you expect to make.');
    case FcyKycFieldId.monthlyTxVolume:
      return const _FieldSpec(
          label: 'Monthly volume',
          hint: '500000',
          keyboard: TextInputType.number,
          helper: 'Roughly how much you expect to move each month.');
    case FcyKycFieldId.taxNumber:
      return const _FieldSpec(
          label: 'Tax identification number',
          helper: 'Required for US dollar accounts.');

    case FcyKycFieldId.documentType:
      return _FieldSpec(
          label: 'Document type', options: acceptedDocumentTypes(currency));
    case FcyKycFieldId.documentNumber:
      return const _FieldSpec(
          label: 'Document number',
          capitalization: TextCapitalization.characters);
    case FcyKycFieldId.documentIssuedCountry:
      return const _FieldSpec(
          label: 'Issuing country',
          hint: 'NG',
          capitalization: TextCapitalization.characters);
    case FcyKycFieldId.documentIssuedDate:
      return const _FieldSpec(
          label: 'Issue date',
          hint: 'YYYY-MM-DD',
          keyboard: TextInputType.datetime);
    case FcyKycFieldId.documentExpiryDate:
      return const _FieldSpec(
          label: 'Expiry date',
          hint: 'YYYY-MM-DD',
          keyboard: TextInputType.datetime,
          helper: 'Your document must still be valid.');
  }
}
