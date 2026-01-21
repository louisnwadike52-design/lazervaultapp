import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/core/shared_widgets/app_loading_button.dart';

/// ID Verification screen for BVN/NIN input
class IdVerificationScreen extends StatefulWidget {
  final KYCTier targetTier;
  final IDType? preferredIdType;

  const IdVerificationScreen({
    super.key,
    this.targetTier = KYCTier.tier2,
    this.preferredIdType,
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

  @override
  void initState() {
    super.initState();
    _selectedIdType = widget.preferredIdType ?? IDType.bvn;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select ID Type',
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildIdTypeChip(
              context,
              type: IDType.bvn,
              label: 'BVN',
              description: 'Bank Verification Number',
            ),
            const SizedBox(width: 12),
            _buildIdTypeChip(
              context,
              type: IDType.nin,
              label: 'NIN',
              description: 'National Identity Number',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIdTypeChip(
    BuildContext context, {
    required IDType type,
    required String label,
    required String description,
  }) {
    final theme = Theme.of(context);
    final isSelected = _selectedIdType == type;

    return Expanded(
      child: InkWell(
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
      ),
    );
  }

  Widget _buildIdNumberField(BuildContext context) {
    final theme = Theme.of(context);
    final label = _selectedIdType == IDType.bvn ? 'BVN' : 'NIN';
    final hint = _selectedIdType == IDType.bvn
        ? 'Enter your 11-digit BVN'
        : 'Enter your 11-digit NIN';
    final controller = _selectedIdType == IDType.bvn
        ? _bvnController
        : _ninController;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11),
      ],
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
        if (value.length != 11) {
          return '$label must be 11 digits';
        }
        return null;
      },
    );
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
    final request = IDVerificationRequest(
      userId: 'current_user_id', // Get from auth state in real app
      idType: _selectedIdType,
      idNumber: _selectedIdType == IDType.bvn
          ? _bvnController.text
          : _ninController.text,
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
