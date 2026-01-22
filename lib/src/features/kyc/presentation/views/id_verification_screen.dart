import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/core/shared_widgets/app_loading_button.dart';
import 'package:lazervault/core/config/country_config.dart';

/// ID Verification screen for BVN/NIN input
class IdVerificationScreen extends StatefulWidget {
  final KYCTier targetTier;
  final IDType? preferredIdType;
  final String? countryCode; // ISO country code for showing country-specific ID options

  const IdVerificationScreen({
    super.key,
    this.targetTier = KYCTier.tier2,
    this.preferredIdType,
    this.countryCode,
  });

  static const String route = '/kyc/verify-id';

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bvnController = TextEditingController();
  final _ninController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _dobController = TextEditingController();

  IDType _selectedIdType = IDType.bvn;
  bool _acceptTerms = false;
  late final CountryConfig? _countryConfig;

  @override
  void initState() {
    super.initState();
    _countryConfig = widget.countryCode != null
        ? CountryConfigs.getByCode(widget.countryCode!)
        : null;
    _selectedIdType = widget.preferredIdType ?? _getDefaultIdType();
  }

  /// Get the default ID type based on country or fallback to BVN
  IDType _getDefaultIdType() {
    if (_countryConfig != null && _countryConfig!.supportedIdTypes.isNotEmpty) {
      final defaultDocType = _countryConfig!.defaultIdType;
      // Convert IdentityDocumentType to IDType
      return _mapDocTypeToIDType(defaultDocType);
    }
    return IDType.bvn;
  }

  /// Map IdentityDocumentType to IDType enum
  IDType _mapDocTypeToIDType(IdentityDocumentType docType) {
    switch (docType) {
      // Nigeria
      case IdentityDocumentType.bvn:
        return IDType.bvn;
      case IdentityDocumentType.nin:
        return IDType.nin;
      case IdentityDocumentType.intlPassport:
        return IDType.internationalPassport;
      case IdentityDocumentType.driverLicense:
        return IDType.driversLicense;

      // UK
      case IdentityDocumentType.ukPassport:
        return IDType.ukPassport;
      case IdentityDocumentType.ukDriverLicense:
        return IDType.ukDrivingLicense;
      case IdentityDocumentType.niNumber:
        return IDType.driversLicense; // Map to a valid ID type

      // US
      case IdentityDocumentType.ssn:
        return IDType.usSsn;
      case IdentityDocumentType.ssnLast4:
        return IDType.usSsn; // Map to SSN
      case IdentityDocumentType.usPassport:
        return IDType.usPassport;
      case IdentityDocumentType.usStateId:
        return IDType.usStateId;

      // Ghana
      case IdentityDocumentType.ghanaCard:
        return IDType.ghanaCard;
      case IdentityDocumentType.ghanaVoterCard:
        return IDType.votersCard;
      case IdentityDocumentType.ghanaSsnit:
        return IDType.kraPin; // Map to KRA PIN as placeholder
      case IdentityDocumentType.ghanaPassport:
        return IDType.internationalPassport;

      // Kenya
      case IdentityDocumentType.kenyaNationalId:
        return IDType.kenyaNationalId;
      case IdentityDocumentType.kenyaKraPin:
        return IDType.kraPin;
      case IdentityDocumentType.kenyaPassport:
        return IDType.internationalPassport;
      case IdentityDocumentType.kenyaAlienId:
        return IDType.kenyaNationalId;

      // South Africa
      case IdentityDocumentType.saId:
        return IDType.saIdCard;
      case IdentityDocumentType.saPassport:
        return IDType.saPassport;

      default:
        return IDType.bvn;
    }
  }

  /// Get available ID types based on country
  List<IDType> _getAvailableIdTypes() {
    if (_countryConfig != null) {
      return _countryConfig!.supportedIdTypes
          .map((docType) => _mapDocTypeToIDType(docType))
          .toSet()
          .toList();
    }
    // Default to Nigeria options if no country specified
    return [IDType.bvn, IDType.nin];
  }

  @override
  void dispose() {
    _bvnController.dispose();
    _ninController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        elevation: 0,
      ),
      body: BlocListener<KYCCubit, KYCState>(
        listener: (context, state) {
          if (state is IDVerificationSuccess) {
            _handleVerificationSuccess(context, state.response);
          } else if (state is KYCError) {
            _showError(context, state);
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context),
                const SizedBox(height: 32),
                _buildIdTypeSelector(context),
                const SizedBox(height: 24),
                _buildIdNumberField(context),
                const SizedBox(height: 24),
                _buildNameFields(context),
                const SizedBox(height: 24),
                _buildDobField(context),
                const SizedBox(height: 32),
                _buildTermsSection(context),
                const SizedBox(height: 32),
                _buildSubmitButton(context),
                const SizedBox(height: 16),
                _buildSkipButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Verify Your Identity',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Enter your details to verify your identity. This helps us keep your account secure.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildIdTypeSelector(BuildContext context) {
    final theme = Theme.of(context);
    final availableTypes = _getAvailableIdTypes();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ID Type',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        if (_countryConfig != null)
          Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 8),
            child: Text(
              'Verifying for ${_countryConfig!.name}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: availableTypes.map((type) {
            return SizedBox(
              width: availableTypes.length > 2
                  ? (MediaQuery.of(context).size.width - 72) / 2
                  : (MediaQuery.of(context).size.width - 48) / availableTypes.length,
              child: _buildIdTypeChip(
                context,
                type: type,
                label: _getIdTypeLabel(type),
                description: _getIdTypeDescription(type),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _getIdTypeLabel(IDType type) {
    return type.displayName;
  }

  String _getIdTypeDescription(IDType type) {
    switch (type) {
      case IDType.bvn:
        return 'Bank Verification Number';
      case IDType.nin:
        return 'National Identity Number';
      case IDType.driversLicense:
        return "Driver's License";
      case IDType.internationalPassport:
        return 'International Passport';
      case IDType.ghanaCard:
        return 'Ghana Card';
      case IDType.kenyaNationalId:
        return 'National ID';
      case IDType.saIdCard:
        return 'Smart ID Card';
      case IDType.ukPassport:
      case IDType.saPassport:
        return 'Passport';
      case IDType.ukDrivingLicense:
        return 'Driving Licence';
      case IDType.usSsn:
        return 'Social Security Number';
      case IDType.usStateId:
        return 'State ID';
      default:
        return 'Identity Document';
    }
  }

  Widget _buildIdTypeChip(
    BuildContext context, {
    required IDType type,
    required String label,
    required String description,
  }) {
    final theme = Theme.of(context);
    final isSelected = _selectedIdType == type;

    return InkWell(
      onTap: () => setState(() => _selectedIdType = type),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.textTheme.labelLarge?.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdNumberField(BuildContext context) {
    final theme = Theme.of(context);
    final label = _selectedIdType.displayName;
    final hint = _getIdNumberHint(_selectedIdType);
    final controller = _getIdController(_selectedIdType);
    final maxLength = _getIdNumberMaxLength(_selectedIdType);

    return TextFormField(
      controller: controller,
      keyboardType: _getIdNumberKeyboardType(_selectedIdType),
      inputFormatters: _getIdNumberInputFormatters(_selectedIdType, maxLength),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.badge),
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (value.length < _getIdNumberMinLength(_selectedIdType)) {
          return '$label must be at least ${_getIdNumberMinLength(_selectedIdType)} digits';
        }
        return null;
      },
    );
  }

  TextEditingController _getIdController(IDType type) {
    switch (type) {
      case IDType.bvn:
        return _bvnController;
      case IDType.nin:
        return _ninController;
      default:
        return _bvnController;
    }
  }

  String _getIdNumberHint(IDType type) {
    switch (type) {
      case IDType.bvn:
        return 'Enter your 11-digit BVN';
      case IDType.nin:
        return 'Enter your 11-digit NIN';
      case IDType.ghanaCard:
        return 'Enter your Ghana Card (GHA-XXXXXXXXX-X)';
      case IDType.kenyaNationalId:
        return 'Enter your 7-8 digit National ID';
      case IDType.saIdCard:
        return 'Enter your 13-digit South African ID';
      case IDType.driversLicense:
        return "Enter your Driver's License number";
      case IDType.internationalPassport:
        return 'Enter your Passport number';
      default:
        return 'Enter your ID number';
    }
  }

  int _getIdNumberMaxLength(IDType type) {
    switch (type) {
      case IDType.bvn:
      case IDType.nin:
        return 11;
      case IDType.saIdCard:
        return 13;
      case IDType.kenyaNationalId:
        return 8;
      case IDType.ghanaCard:
        return 15;
      default:
        return 20;
    }
  }

  int _getIdNumberMinLength(IDType type) {
    switch (type) {
      case IDType.bvn:
      case IDType.nin:
        return 11;
      case IDType.saIdCard:
        return 13;
      case IDType.kenyaNationalId:
        return 7;
      default:
        return 6;
    }
  }

  TextInputType _getIdNumberKeyboardType(IDType type) {
    switch (type) {
      case IDType.bvn:
      case IDType.nin:
      case IDType.saIdCard:
      case IDType.kenyaNationalId:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _getIdNumberInputFormatters(IDType type, int maxLength) {
    switch (type) {
      case IDType.bvn:
      case IDType.nin:
      case IDType.saIdCard:
      case IDType.kenyaNationalId:
        return [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLength),
        ];
      default:
        return [
          LengthLimitingTextInputFormatter(maxLength),
        ];
    }
  }

  Widget _buildNameFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _firstNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'First Name',
              prefixIcon: Icon(Icons.person),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: _lastNameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Last Name',
              prefixIcon: Icon(Icons.person_outline),
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Required';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDobField(BuildContext context) {
    return TextFormField(
      controller: _dobController,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _DateInputFormatter(),
      ],
      decoration: const InputDecoration(
        labelText: 'Date of Birth',
        hintText: 'DD/MM/YYYY',
        prefixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now().subtract(const Duration(days: 18 * 365)),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );

        if (date != null) {
          _dobController.text =
              '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your date of birth';
        }
        // Validate DD/MM/YYYY format
        final regex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
        if (!regex.hasMatch(value)) {
          return 'Use DD/MM/YYYY format';
        }
        return null;
      },
    );
  }

  Widget _buildTermsSection(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _acceptTerms,
            onChanged: (value) => setState(() => _acceptTerms = value ?? false),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: GestureDetector(
                onTap: () =>
                    setState(() => _acceptTerms = !_acceptTerms),
                child: RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodyMedium,
                    children: [
                      const TextSpan(
                        text: 'I agree to the ',
                      ),
                      TextSpan(
                        text: 'Terms of Service',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: ' and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      const TextSpan(
                        text: '. I understand that my information will be verified securely.',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    final cubit = context.read<KYCCubit>();
    final isLoading = cubit.state is KYCLoading;

    return SizedBox(
      width: double.infinity,
      child: AppLoadingButton(
        onPressed: isLoading ? null : _submitVerification,
        isLoading: isLoading,
        text: 'Verify Identity',
      ),
    );
  }

  Widget _buildSkipButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'I\'ll do this later',
          style: TextStyle(
            color: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.color
                ?.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  void _submitVerification() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please accept the terms to continue')),
      );
      return;
    }

    final cubit = context.read<KYCCubit>();
    final controller = _getIdController(_selectedIdType);
    final request = IDVerificationRequest(
      userId: 'current_user_id', // Get from auth state in real app
      idType: _selectedIdType,
      idNumber: controller.text.trim(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      dateOfBirth: _dobController.text,
      phoneNumber: '', // Get from auth state
    );

    cubit.verifyID(request);
  }

  void _handleVerificationSuccess(
    BuildContext context,
    VerifyIDResponse response,
  ) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Verification submitted successfully! We\'ll notify you once approved.',
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showError(BuildContext context, KYCError state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.userMessage ?? state.failure.message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}

/// Date input formatter for DD/MM/YYYY
class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var text = newValue.text;

    // Remove any non-digit characters
    text = text.replaceAll(RegExp(r'[^\d]'), '');

    // Add slashes
    if (text.length >= 2 && text.length < 4) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    } else if (text.length >= 4) {
      text = '${text.substring(0, 2)}/${text.substring(2, 4)}/${text.substring(4, math.min(8, text.length))}';
    }

    // Limit to 10 characters (DD/MM/YYYY)
    if (text.length > 10) {
      text = text.substring(0, 10);
    }

    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
