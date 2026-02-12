import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/entities/insurance_entity.dart';
import '../cubit/insurance_cubit.dart';

class CreateInsurancePolicyView extends StatefulWidget {
  final ScrollController scrollController;
  final VoidCallback onPolicyCreated;

  const CreateInsurancePolicyView({
    super.key,
    required this.scrollController,
    required this.onPolicyCreated,
  });

  @override
  State<CreateInsurancePolicyView> createState() => _CreateInsurancePolicyViewState();
}

class _CreateInsurancePolicyViewState extends State<CreateInsurancePolicyView> {
  final _formKey = GlobalKey<FormState>();
  final _policyHolderNameController = TextEditingController();
  final _policyHolderEmailController = TextEditingController();
  final _policyHolderPhoneController = TextEditingController();
  final _providerController = TextEditingController();
  final _premiumAmountController = TextEditingController();
  final _coverageAmountController = TextEditingController();
  final _descriptionController = TextEditingController();

  InsuranceType _selectedType = InsuranceType.health;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 365));
  DateTime _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
  final List<String> _beneficiaries = [];
  final TextEditingController _beneficiaryController = TextEditingController();

  // Dynamic optional field controllers (lazy initialization)
  final Map<String, TextEditingController> _optionalFieldControllers = {};

  // Track which optional fields are currently visible
  final Set<String> _visibleOptionalFields = {};

  final List<String> _features = [];
  final TextEditingController _featureController = TextEditingController();

  // Available optional fields configuration
  static const List<Map<String, dynamic>> _availableOptionalFields = [
    {
      'id': 'deductible',
      'label': 'Deductible',
      'icon': Icons.attach_money,
      'description': 'Amount you pay before insurance covers costs',
      'inputType': 'currency',
    },
    {
      'id': 'coverage_limit',
      'label': 'Coverage Limit',
      'icon': Icons.trending_up,
      'description': 'Maximum coverage amount for this policy',
      'inputType': 'currency',
    },
    {
      'id': 'description',
      'label': 'Description',
      'icon': Icons.description,
      'description': 'Additional notes about this policy',
      'inputType': 'text',
    },
  ];

  // Predefined data for dialogs
  final List<String> _availableProviders = [
    'SafeGuard Insurance',
    'Allstate Insurance',
    'State Farm Insurance',
    'Progressive Insurance',
    'GEICO Insurance',
    'Nationwide Insurance',
    'Liberty Mutual',
    'Farmers Insurance',
    'Travelers Insurance',
    'American Family Insurance',
    'USAA Insurance',
    'Aetna Health Insurance',
    'Blue Cross Blue Shield',
    'Cigna Health Insurance',
    'UnitedHealth Group',
    'Humana Health Insurance',
  ];

  final List<String> _availableFeatures = [
    '24/7 Customer Support',
    'Online Claims Processing',
    'Mobile App Access',
    'Roadside Assistance',
    'Telemedicine Services',
    'Emergency Medical Coverage',
    'Worldwide Coverage',
    'No Deductible for Preventive Care',
    'Prescription Drug Coverage',
    'Mental Health Coverage',
    'Dental Coverage',
    'Vision Coverage',
    'Maternity Coverage',
    'Emergency Room Coverage',
    'Specialist Consultations',
    'Physical Therapy Coverage',
    'Home Health Care',
    'Ambulance Coverage',
    'Rehabilitation Services',
    'Chronic Disease Management',
  ];

  final List<String> _commonBeneficiaryRelations = [
    'Spouse',
    'Child',
    'Parent',
    'Sibling',
    'Partner',
    'Guardian',
    'Other Family Member',
    'Trust',
    'Estate',
  ];

  @override
  void initState() {
    super.initState();
    _initializeDefaultValues();
  }

  void _initializeDefaultValues() {
    // Leave fields empty for user input - no hardcoded demo values
  }

  @override
  void dispose() {
    _policyHolderNameController.dispose();
    _policyHolderEmailController.dispose();
    _policyHolderPhoneController.dispose();
    _providerController.dispose();
    _premiumAmountController.dispose();
    _coverageAmountController.dispose();
    _descriptionController.dispose();
    _beneficiaryController.dispose();
    _featureController.dispose();
    // Dispose dynamic optional field controllers
    for (final controller in _optionalFieldControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  // Lazy controller initialization for optional fields
  TextEditingController _getOrCreateController(String fieldId) {
    if (!_optionalFieldControllers.containsKey(fieldId)) {
      _optionalFieldControllers[fieldId] = TextEditingController();
    }
    return _optionalFieldControllers[fieldId]!;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        controller: widget.scrollController,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Policy Type'),
            SizedBox(height: 12.h),
            _buildInsuranceTypeSelector(),
            SizedBox(height: 24.h),

            _buildSectionHeader('Policy Holder Information'),
            SizedBox(height: 12.h),
            _buildInputField(
              'Full Name',
              _policyHolderNameController,
              validator: (value) => value?.isEmpty == true ? 'Name is required' : null,
            ),
            SizedBox(height: 16.h),
            _buildInputField(
              'Email Address',
              _policyHolderEmailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty == true) return 'Email is required';
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            SizedBox(height: 16.h),
            _buildInputField(
              'Phone Number',
              _policyHolderPhoneController,
              keyboardType: TextInputType.phone,
              validator: (value) => value?.isEmpty == true ? 'Phone number is required' : null,
            ),
            SizedBox(height: 24.h),

            _buildSectionHeader('Insurance Provider'),
            SizedBox(height: 12.h),
            _buildProviderSelector(),
            SizedBox(height: 24.h),

            _buildSectionHeader('Coverage Details'),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    'Premium Amount',
                    _premiumAmountController,
                    keyboardType: TextInputType.number,
                    prefix: '\$',
                    validator: (value) => value?.isEmpty == true ? 'Premium amount is required' : null,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildInputField(
                    'Coverage Amount',
                    _coverageAmountController,
                    keyboardType: TextInputType.number,
                    prefix: '\$',
                    validator: (value) => value?.isEmpty == true ? 'Coverage amount is required' : null,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            _buildSectionHeader('Policy Dates'),
            SizedBox(height: 12.h),
            _buildDateSelector('Start Date', _startDate, (date) => setState(() => _startDate = date)),
            SizedBox(height: 16.h),
            _buildDateSelector('End Date', _endDate, (date) => setState(() => _endDate = date)),
            SizedBox(height: 16.h),
            _buildDateSelector('Next Payment Date', _nextPaymentDate, (date) => setState(() => _nextPaymentDate = date)),
            SizedBox(height: 24.h),

            _buildSectionHeader('Beneficiaries'),
            SizedBox(height: 12.h),
            _buildBeneficiariesSection(),
            SizedBox(height: 24.h),

            _buildSectionHeader('Features'),
            SizedBox(height: 12.h),
            _buildFeaturesSection(),
            SizedBox(height: 24.h),

            _buildOptionalFieldsSection(),
            SizedBox(height: 32.h),

            _buildCreateButton(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    );
  }

  Widget _buildInsuranceTypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: InsuranceType.values.map((type) {
          final isSelected = _selectedType == type;
          return GestureDetector(
            onTap: () => setState(() => _selectedType = type),
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.1) : null,
                borderRadius: BorderRadius.circular(12.r),
                border: isSelected ? Border.all(color: const Color(0xFF6366F1)) : null,
              ),
              child: Row(
                children: [
                  Text(
                    type.icon,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      type.displayName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? const Color(0xFF6366F1) : Colors.white,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Icon(
                      Icons.check_circle,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildInputField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    int maxLines = 1,
    String? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            prefixText: prefix,
            prefixStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: const Color(0xFF9CA3AF),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Colors.red),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }

  Widget _buildDateSelector(String label, DateTime date, Function(DateTime) onDateSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () async {
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.dark(
                      primary: Color(0xFF6366F1),
                      surface: Color(0xFF1A1A1A),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selectedDate != null) {
              onDateSelected(selectedDate);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${date.day}/${date.month}/${date.year}',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProviderSelector() {
    return GestureDetector(
      onTap: _showProviderSelectionDialog,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                _providerController.text.isEmpty ? 'Select Provider' : _providerController.text,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: _providerController.text.isEmpty 
                      ? const Color(0xFF9CA3AF) 
                      : Colors.white,
                ),
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: const Color(0xFF9CA3AF),
              size: 24.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBeneficiariesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Beneficiaries',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _showBeneficiariesDialog,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people,
                          color: const Color(0xFF6366F1),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Manage',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF6366F1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _addBeneficiary,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF6366F1),
                      size: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (_beneficiaries.isNotEmpty) ...[
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _beneficiaries.map((beneficiary) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      beneficiary,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF6366F1),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => _removeBeneficiary(beneficiary),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
        ],
        TextFormField(
          controller: _beneficiaryController,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Add beneficiary name',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: const Color(0xFF9CA3AF),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            suffixIcon: GestureDetector(
              onTap: _addBeneficiary,
              child: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          onFieldSubmitted: (_) => _addBeneficiary(),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Features',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF9CA3AF),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: _showFeaturesDialog,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.featured_play_list,
                          color: const Color(0xFF10B981),
                          size: 14.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Browse',
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: const Color(0xFF10B981),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: _addFeature,
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                    ),
                    child: Icon(
                      Icons.add,
                      color: const Color(0xFF10B981),
                      size: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        if (_features.isNotEmpty) ...[
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: _features.map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      feature,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: const Color(0xFF10B981),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => _removeFeature(feature),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 16.h),
        ],
        TextFormField(
          controller: _featureController,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Add feature',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: const Color(0xFF9CA3AF),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF10B981)),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            suffixIcon: GestureDetector(
              onTap: _addFeature,
              child: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
          ),
          onFieldSubmitted: (_) => _addFeature(),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _createPolicy,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Text(
          'Create Insurance Policy',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _addBeneficiary() {
    if (_beneficiaryController.text.trim().isNotEmpty) {
      setState(() {
        _beneficiaries.add(_beneficiaryController.text.trim());
        _beneficiaryController.clear();
      });
    }
  }

  void _removeBeneficiary(String beneficiary) {
    setState(() {
      _beneficiaries.remove(beneficiary);
    });
  }

  void _addFeature() {
    if (_featureController.text.trim().isNotEmpty) {
      setState(() {
        _features.add(_featureController.text.trim());
        _featureController.clear();
      });
    }
  }

  void _removeFeature(String feature) {
    setState(() {
      _features.remove(feature);
    });
  }

  Future<void> _createPolicy() async {
    if (_formKey.currentState!.validate()) {
      // Build coverage details with only visible optional fields
      final coverageDetails = <String, dynamic>{
        'features': List.from(_features),
      };

      // Add optional fields only if they're visible and have values
      if (_visibleOptionalFields.contains('deductible')) {
        final deductible = double.tryParse(_getOrCreateController('deductible').text);
        if (deductible != null && deductible > 0) {
          coverageDetails['deductible'] = deductible;
        }
      }

      if (_visibleOptionalFields.contains('coverage_limit')) {
        final coverageLimit = double.tryParse(_getOrCreateController('coverage_limit').text);
        if (coverageLimit != null && coverageLimit > 0) {
          coverageDetails['coverage_limit'] = coverageLimit;
        }
      }

      // Handle description
      String? description;
      if (_visibleOptionalFields.contains('description')) {
        final descriptionText = _getOrCreateController('description').text;
        if (descriptionText.isNotEmpty) {
          description = descriptionText;
        }
      }

      final providerText = _providerController.text;

      final insurance = Insurance(
        id: '',
        policyNumber: '',
        policyHolderName: _policyHolderNameController.text,
        policyHolderEmail: _policyHolderEmailController.text,
        policyHolderPhone: _policyHolderPhoneController.text,
        type: _selectedType,
        provider: providerText,
        providerLogo: '',
        premiumAmount: double.parse(_premiumAmountController.text),
        coverageAmount: double.parse(_coverageAmountController.text),
        currency: 'USD',
        startDate: _startDate,
        endDate: _endDate,
        nextPaymentDate: _nextPaymentDate,
        status: InsuranceStatus.active,
        beneficiaries: List.from(_beneficiaries),
        coverageDetails: coverageDetails,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        userId: context.read<InsuranceCubit>().currentUserId,
      );

      await context.read<InsuranceCubit>().createInsurance(insurance);
      if (mounted) {
        widget.onPolicyCreated();
      }
    }
  }

  // Dialog Methods
  void _showProviderSelectionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business,
                        color: const Color(0xFF6366F1),
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Select Insurance Provider',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(
                          Icons.close,
                          color: const Color(0xFF9CA3AF),
                          size: 24.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                // Provider List
                Container(
                  constraints: BoxConstraints(maxHeight: 400.h),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _availableProviders.length,
                    itemBuilder: (context, index) {
                      final provider = _availableProviders[index];
                      final isSelected = _providerController.text == provider;
                      
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _providerController.text = provider;
                          });
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                          decoration: BoxDecoration(
                            color: isSelected 
                                ? const Color(0xFF6366F1).withValues(alpha: 0.1)
                                : Colors.transparent,
                            border: Border(
                              bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Center(
                                  child: Text(
                                    provider[0],
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF6366F1),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Text(
                                  provider,
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: const Color(0xFF6366F1),
                                  size: 24.sp,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFeaturesDialog() {
    List<String> selectedFeatures = List.from(_features);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.featured_play_list,
                            color: const Color(0xFF10B981),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Select Features',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${selectedFeatures.length} selected',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color(0xFF10B981),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Features List
                    Container(
                      constraints: BoxConstraints(maxHeight: 400.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _availableFeatures.length,
                        itemBuilder: (context, index) {
                          final feature = _availableFeatures[index];
                          final isSelected = selectedFeatures.contains(feature);
                          
                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                if (isSelected) {
                                  selectedFeatures.remove(feature);
                                } else {
                                  selectedFeatures.add(feature);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                              decoration: BoxDecoration(
                                color: isSelected 
                                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                                    : Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: isSelected 
                                          ? const Color(0xFF10B981)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4.r),
                                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16.sp,
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Text(
                                      feature,
                                      style: GoogleFonts.inter(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Footer
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF10B981)),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF10B981),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF10B981), Color(0xFF059669)],
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _features.clear();
                                    _features.addAll(selectedFeatures);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Apply',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showBeneficiariesDialog() {
    final nameController = TextEditingController();
    final relationController = TextEditingController();
    List<Map<String, String>> tempBeneficiaries = _beneficiaries
        .map((b) => {'name': b, 'relation': 'Other Family Member'})
        .toList();
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: const Color(0xFF6366F1),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Manage Beneficiaries',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${tempBeneficiaries.length} added',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color(0xFF6366F1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Add Beneficiary Form
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.02),
                        border: Border(
                          bottom: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: TextFormField(
                                  controller: nameController,
                                  style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
                                  decoration: InputDecoration(
                                    hintText: 'Beneficiary name',
                                    hintStyle: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: 14.sp,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white.withValues(alpha: 0.05),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    // Show relation selector
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => Dialog(
                                        backgroundColor: const Color(0xFF1A1A1A),
                                        child: Container(
                                          padding: EdgeInsets.all(16.w),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Select Relation',
                                                style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(height: 16.h),
                                              ..._commonBeneficiaryRelations.map((relation) =>
                                                ListTile(
                                                  title: Text(
                                                    relation,
                                                    style: GoogleFonts.inter(color: Colors.white),
                                                  ),
                                                  onTap: () {
                                                    relationController.text = relation;
                                                    Navigator.pop(ctx);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(8.r),
                                      boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
                                    ),
                                    child: Text(
                                      relationController.text.isEmpty ? 'Relation' : relationController.text,
                                      style: GoogleFonts.inter(
                                        fontSize: 14.sp,
                                        color: relationController.text.isEmpty 
                                            ? const Color(0xFF9CA3AF)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () {
                                  if (nameController.text.trim().isNotEmpty) {
                                    setDialogState(() {
                                      tempBeneficiaries.add({
                                        'name': nameController.text.trim(),
                                        'relation': relationController.text.isEmpty 
                                            ? 'Other Family Member' 
                                            : relationController.text,
                                      });
                                      nameController.clear();
                                      relationController.clear();
                                    });
                                  }
                                },
                                child: Container(
                                  width: 36.w,
                                  height: 36.w,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                    ),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Icon(Icons.add, color: Colors.white, size: 20.sp),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Beneficiaries List
                    if (tempBeneficiaries.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 300.h),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tempBeneficiaries.length,
                          itemBuilder: (context, index) {
                            final beneficiary = tempBeneficiaries[index];
                            
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 36.w,
                                    height: 36.w,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(18.r),
                                    ),
                                    child: Center(
                                      child: Text(
                                        beneficiary['name']![0].toUpperCase(),
                                        style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF6366F1),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          beneficiary['name']!,
                                          style: GoogleFonts.inter(
                                            fontSize: 14.sp,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          beneficiary['relation']!,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            color: const Color(0xFF9CA3AF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setDialogState(() {
                                        tempBeneficiaries.removeAt(index);
                                      });
                                    },
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                      size: 20.sp,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    // Footer
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xFF6366F1)),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF6366F1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _beneficiaries.clear();
                                    _beneficiaries.addAll(
                                      tempBeneficiaries.map((b) => b['name']!).toList(),
                                    );
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Save',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildOptionalFieldsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Additional Fields (Optional)',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: _showOptionalFieldsDialog,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: const Color(0xFF8B5CF6),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Add Fields',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: const Color(0xFF8B5CF6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),

        // Display currently visible optional fields
        if (_visibleOptionalFields.isNotEmpty) ...[
          ..._buildVisibleOptionalFields(),
        ] else ...[
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.02),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF9CA3AF),
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'No additional fields added. Tap "Add Fields" to include optional information.',
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  List<Widget> _buildVisibleOptionalFields() {
    List<Widget> widgets = [];

    for (String fieldId in _visibleOptionalFields) {
      final fieldConfig = _availableOptionalFields.firstWhere(
        (f) => f['id'] == fieldId,
      );

      widgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildOptionalFieldInput(fieldId, fieldConfig),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () => _removeOptionalField(fieldId),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
          ],
        ),
      );
    }

    return widgets;
  }

  Widget _buildOptionalFieldInput(String fieldId, Map<String, dynamic> config) {
    final controller = _getOrCreateController(fieldId);

    if (config['inputType'] == 'currency') {
      return _buildInputField(
        config['label'],
        controller,
        keyboardType: TextInputType.number,
        prefix: '\$',
      );
    } else if (config['inputType'] == 'text') {
      return _buildInputField(
        config['label'],
        controller,
        maxLines: 3,
      );
    }

    return const SizedBox.shrink();
  }

  void _removeOptionalField(String fieldId) {
    setState(() {
      _visibleOptionalFields.remove(fieldId);
      // Clear the controller value when removing
      if (_optionalFieldControllers.containsKey(fieldId)) {
        _optionalFieldControllers[fieldId]!.clear();
      }
    });
  }

  void _showOptionalFieldsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Set<String> tempSelectedFields = Set.from(_visibleOptionalFields);

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(maxHeight: 500.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_box,
                            color: const Color(0xFF8B5CF6),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'Add Optional Fields',
                              style: GoogleFonts.inter(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            '${tempSelectedFields.length} selected',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              color: const Color(0xFF8B5CF6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Fields List
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _availableOptionalFields.length,
                        itemBuilder: (context, index) {
                          final field = _availableOptionalFields[index];
                          final fieldId = field['id'] as String;
                          final isSelected = tempSelectedFields.contains(fieldId);

                          return GestureDetector(
                            onTap: () {
                              setDialogState(() {
                                if (isSelected) {
                                  tempSelectedFields.remove(fieldId);
                                } else {
                                  tempSelectedFields.add(fieldId);
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF8B5CF6).withValues(alpha: 0.1)
                                    : Colors.transparent,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.white.withValues(alpha: 0.05),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF8B5CF6)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(4.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF8B5CF6)
                                            : Colors.white.withValues(alpha: 0.3),
                                      ),
                                    ),
                                    child: isSelected
                                        ? Icon(
                                            Icons.check,
                                            color: Colors.white,
                                            size: 16.sp,
                                          )
                                        : null,
                                  ),
                                  SizedBox(width: 16.w),
                                  Icon(
                                    field['icon'] as IconData,
                                    color: const Color(0xFF8B5CF6),
                                    size: 20.sp,
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          field['label'] as String,
                                          style: GoogleFonts.inter(
                                            fontSize: 15.sp,
                                            color: Colors.white,
                                            fontWeight: isSelected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 2.h),
                                        Text(
                                          field['description'] as String,
                                          style: GoogleFonts.inter(
                                            fontSize: 12.sp,
                                            color: const Color(0xFF9CA3AF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // Footer Buttons
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: Colors.white.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xFF8B5CF6),
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Cancel',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: const Color(0xFF8B5CF6),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF8B5CF6), Color(0xFF6366F1)],
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _visibleOptionalFields.clear();
                                    _visibleOptionalFields.addAll(tempSelectedFields);
                                  });
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Apply',
                                  style: GoogleFonts.inter(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
} 