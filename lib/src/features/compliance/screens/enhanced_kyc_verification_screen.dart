import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:lazervault/core/config/country_config.dart';
import 'package:lazervault/core/services/document_extraction_service.dart';
import 'package:lazervault/src/generated/user.pbgrpc.dart';
import 'package:lazervault/src/generated/user.pb.dart' as user_pb;
import 'package:get/get.dart';

/// Enhanced KYC Verification Screen with AI Document Extraction
///
/// This screen handles country-specific KYC requirements including:
/// - Document type selection based on country
/// - Front/back document capture
/// - Selfie verification
/// - AI-powered data extraction from documents
/// - Manual fallback when extraction fails
/// - Address verification for advanced KYC
class EnhancedKYCVerificationScreen extends StatefulWidget {
  final String countryCode;
  final KycLevel targetLevel;
  final String? userId;

  const EnhancedKYCVerificationScreen({
    super.key,
    required this.countryCode,
    this.targetLevel = KycLevel.standard,
    this.userId,
  });

  @override
  State<EnhancedKYCVerificationScreen> createState() =>
      _EnhancedKYCVerificationScreenState();
}

class _EnhancedKYCVerificationScreenState
    extends State<EnhancedKYCVerificationScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  late final DocumentExtractionService _extractionService;

  // Country configuration
  late final CountryConfig _countryConfig;

  // Current step
  int _currentStep = 0;
  bool _isLoading = false;

  // Personal Info
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;

  // Selected document type
  IdentityDocumentType? _selectedDocumentType;
  List<IdentityDocumentType> _availableDocumentTypes = [];

  // Document images
  XFile? _frontDocument;
  XFile? _backDocument;
  XFile? _selfie;
  XFile? _proofOfAddress;

  // Extraction results
  DocumentExtractionResult? _frontExtractionResult;
  DocumentExtractionResult? _backExtractionResult;

  // Manual entry mode (when extraction fails)
  bool _isManualEntryMode = false;
  final _manualDocumentNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _extractionService = DocumentExtractionService();
    _countryConfig = CountryConfigs.getByCode(widget.countryCode) ??
        CountryConfigs.nigeria; // Fallback to Nigeria
    _availableDocumentTypes = _countryConfig.supportedIdTypes;
    _selectedDocumentType = _countryConfig.defaultIdType;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _manualDocumentNumberController.dispose();
    super.dispose();
  }

  /// Get steps based on country and KYC level
  List<KycStep> _getSteps() {
    final steps = <KycStep>[
      KycStep(
        title: 'Personal Information',
        subtitle: 'Enter your personal details',
        icon: Icons.person_outline,
      ),
      KycStep(
        title: 'Identity Document',
        subtitle: 'Upload your ID document',
        icon: Icons.badge_outlined,
      ),
      KycStep(
        title: 'Selfie Verification',
        subtitle: 'Take a selfie for verification',
        icon: Icons.face_outlined,
      ),
    ];

    // Add address verification step for advanced KYC
    if (widget.targetLevel == KycLevel.advanced) {
      steps.add(KycStep(
        title: 'Address Verification',
        subtitle: 'Verify your address',
        icon: Icons.home_outlined,
      ));
    }

    return steps;
  }

  @override
  Widget build(BuildContext context) {
    final steps = _getSteps();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Identity Verification'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(steps.length),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: _buildCurrentStepContent(),
              ),
            ),

            // Navigation buttons
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  /// Build progress indicator
  Widget _buildProgressIndicator(int totalSteps) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Row(
            children: List.generate(
              totalSteps,
              (index) => Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.only(
                    right: index < totalSteps - 1 ? 8.w : 0,
                  ),
                  decoration: BoxDecoration(
                    color: index <= _currentStep
                        ? Colors.blue
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  /// Build current step content
  Widget _buildCurrentStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildPersonalInfoStep();
      case 1:
        return _buildDocumentStep();
      case 2:
        return _buildSelfieStep();
      case 3:
        return _buildAddressStep();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Build navigation buttons
  Widget _buildNavigationButtons() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // "Complete verification anytime" notice
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Colors.blue.shade700,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'You can complete verification anytime from Settings',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.blue.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Navigation buttons
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _isLoading ? null : _goBack,
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Back',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _goNext,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: _isLoading
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            _currentStep == _getSteps().length - 1
                                ? 'Submit'
                                : 'Continue',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// ============================================
  /// STEP 0: Personal Information
  /// ============================================
  Widget _buildPersonalInfoStep() {
    final steps = _getSteps();
    final step = steps[0];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(step),
        SizedBox(height: 24.h),

        // Country indicator (read-only)
        _buildCountryIndicator(),
        SizedBox(height: 24.h),

        // First Name
        _buildTextField(
          controller: _firstNameController,
          label: 'First Name',
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'First name is required';
            }
            if (value.length < 2) {
              return 'First name must be at least 2 characters';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),

        // Last Name
        _buildTextField(
          controller: _lastNameController,
          label: 'Last Name',
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Last name is required';
            }
            if (value.length < 2) {
              return 'Last name must be at least 2 characters';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),

        // Date of Birth
        _buildDatePicker(
          label: 'Date of Birth',
          selectedDate: _dateOfBirth,
          onTap: _showDatePicker,
          validator: (value) {
            if (value == null) {
              return 'Date of birth is required';
            }
            final age = DateTime.now().year - value.year;
            if (age < 18) {
              return 'You must be at least 18 years old';
            }
            return null;
          },
        ),

        // Regulatory notice
        if (_countryConfig.regulatoryNotes.isNotEmpty) ...[
          SizedBox(height: 24.h),
          _buildRegulatoryNotice(),
        ],
      ],
    );
  }

  /// Build country indicator (read-only, since already selected in signup)
  Widget _buildCountryIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Text(
            _countryConfig.flag,
            style: TextStyle(fontSize: 24.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Country',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _countryConfig.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.lock,
            size: 16.sp,
            color: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  /// Build regulatory notice
  Widget _buildRegulatoryNotice() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20.sp),
              SizedBox(width: 8.w),
              Text(
                'Regulatory Notice',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ..._countryConfig.regulatoryNotes.map(
            (note) => Padding(
              padding: EdgeInsets.only(left: 28.w, bottom: 4.h),
              child: Text(
                '• $note',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.blue.shade700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ============================================
  /// STEP 1: Document Upload
  /// ============================================
  Widget _buildDocumentStep() {
    final steps = _getSteps();
    final step = steps[1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(step),
        SizedBox(height: 24.h),

        // Document type selector
        _buildDocumentTypeSelector(),
        SizedBox(height: 24.h),

        // Show extraction results if available
        if (_frontExtractionResult != null) ...[
          _buildExtractionResultCard(),
          SizedBox(height: 16.h),
        ],

        // Manual entry fallback
        if (_isManualEntryMode) ...[
          _buildManualEntryCard(),
          SizedBox(height: 16.h),
        ],

        // Front document
        _buildDocumentUploadCard(
          title: 'Front of Document',
          image: _frontDocument,
          onTap: _captureFrontDocument,
          isRequired: true,
          extractionResult: _frontExtractionResult,
        ),

        // Back document (if needed)
        if (_needsBackDocument()) ...[
          SizedBox(height: 16.h),
          _buildDocumentUploadCard(
            title: 'Back of Document',
            image: _backDocument,
            onTap: _captureBackDocument,
            isRequired: true,
            extractionResult: _backExtractionResult,
          ),
        ],

        SizedBox(height: 24.h),

        // Photo tips
        _buildPhotoTipsCard(),
      ],
    );
  }

  /// Check if current document type needs back photo
  bool _needsBackDocument() {
    if (_selectedDocumentType == null) return false;
    return _selectedDocumentType == IdentityDocumentType.ukDriverLicense ||
        _selectedDocumentType == IdentityDocumentType.driverLicense ||
        _selectedDocumentType == IdentityDocumentType.ghanaCard ||
        _selectedDocumentType == IdentityDocumentType.kenyaNationalId ||
        _selectedDocumentType == IdentityDocumentType.saId ||
        _selectedDocumentType == IdentityDocumentType.usStateId;
  }

  /// Build document type selector
  Widget _buildDocumentTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Document Type',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _availableDocumentTypes.map((type) {
            final isSelected = _selectedDocumentType == type;
            return InkWell(
              onTap: () => _selectDocumentType(type),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.blue : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  type.displayName,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Build extraction result card
  Widget _buildExtractionResultCard() {
    final result = _frontExtractionResult!;
    final data = result.extractedData ?? {};

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: result.isHighConfidence
            ? Colors.green.shade50
            : Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: result.isHighConfidence
              ? Colors.green.shade300
              : Colors.orange.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                result.isHighConfidence ? Icons.check_circle : Icons.warning,
                color: result.isHighConfidence
                    ? Colors.green.shade700
                    : Colors.orange.shade700,
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  result.isHighConfidence
                      ? 'Document extracted successfully!'
                      : 'Document partially extracted. Please verify.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: result.isHighConfidence
                        ? Colors.green.shade700
                        : Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
          if (data.isNotEmpty) ...[
            SizedBox(height: 12.h),
            ...data.entries
                .where((e) =>
                    !e.key.startsWith('_') &&
                    e.key != 'faceImage' &&
                    e.value != null)
                .map((e) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Row(
                        children: [
                          Text(
                            '${_formatFieldName(e.key)}: ',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              e.value.toString(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
          ],
        ],
      ),
    );
  }

  /// Format field name for display
  String _formatFieldName(String fieldName) {
    final mapping = {
      'firstName': 'First Name',
      'lastName': 'Last Name',
      'dateOfBirth': 'Date of Birth',
      'documentNumber': 'Document Number',
      'expirationDate': 'Expiration Date',
      'sex': 'Sex',
    };
    return mapping[fieldName] ??
        fieldName
            .replaceAllMapped(
              RegExp(r'[A-Z]'),
              (match) => ' ${match.group(0)}',
            )
            .replaceAll('_', ' ')
            .split(' ')
            .map((word) =>
                word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1))
            .join(' ');
  }

  /// Build manual entry card
  Widget _buildManualEntryCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.orange.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.edit, color: Colors.orange.shade700, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Manual Entry Required',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          TextField(
            controller: _manualDocumentNumberController,
            decoration: InputDecoration(
              labelText: 'Enter ${_selectedDocumentType?.displayName} Number',
              hintText: DocumentHelper.getPlaceholder(
                  _selectedDocumentType ?? IdentityDocumentType.bvn),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              isDense: true,
            ),
            keyboardType: _selectedDocumentType?.inputType == 'numeric'
                ? TextInputType.number
                : TextInputType.text,
            inputFormatters: _selectedDocumentType?.inputType == 'numeric'
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
          ),
        ],
      ),
    );
  }

  /// Build document upload card
  Widget _buildDocumentUploadCard({
    required String title,
    required XFile? image,
    required VoidCallback onTap,
    required bool isRequired,
    DocumentExtractionResult? extractionResult,
  }) {
    final hasExtractionError =
        extractionResult != null && !extractionResult.success;
    final hasExtractionSuccess =
        extractionResult != null && extractionResult.success;

    return GestureDetector(
      onTap: _isLoading ? null : onTap,
      child: Container(
        height: 220.h,
        decoration: BoxDecoration(
          color: hasExtractionSuccess
              ? Colors.green.shade50
              : hasExtractionError
                  ? Colors.red.shade50
                  : Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: hasExtractionSuccess
                ? Colors.green.shade300
                : hasExtractionError
                    ? Colors.red.shade300
                    : Colors.grey.shade300,
            width: hasExtractionSuccess || hasExtractionError ? 2 : 1,
          ),
        ),
        child: image == null
            ? _buildEmptyUploadCard(
                title: title,
                isRequired: isRequired,
                hasError: hasExtractionError,
              )
            : _buildImagePreview(
                image: image,
                title: title,
                extractionResult: extractionResult,
              ),
      ),
    );
  }

  /// Build empty upload card
  Widget _buildEmptyUploadCard({
    required String title,
    required bool isRequired,
    required bool hasError,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 80.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: hasError ? Colors.red.shade100 : Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.camera_alt_outlined,
            size: 40.sp,
            color: hasError ? Colors.red.shade400 : Colors.grey.shade400,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Tap to capture',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
        if (isRequired) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'Required',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.red.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  /// Build image preview
  Widget _buildImagePreview({
    required XFile image,
    required String title,
    DocumentExtractionResult? extractionResult,
  }) {
    return Stack(
      children: [
        Center(
          child: Image.file(
            File(image.path),
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Title overlay
        Positioned(
          top: 12.h,
          left: 12.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        // Status indicator
        Positioned(
          top: 12.h,
          right: 12.w,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Icon(
              extractionResult?.success == true
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: extractionResult?.success == true
                  ? Colors.green
                  : Colors.grey,
              size: 24.sp,
            ),
          ),
        ),
        // Remove button
        Positioned(
          bottom: 12.h,
          right: 12.w,
          child: InkWell(
            onTap: () {
              setState(() {
                _frontDocument = null;
                _backDocument = null;
                _frontExtractionResult = null;
                _backExtractionResult = null;
                _isManualEntryMode = false;
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.refresh, color: Colors.white, size: 16.sp),
                  SizedBox(width: 4.w),
                  Text(
                    'Retake',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Build photo tips card
  Widget _buildPhotoTipsCard() {
    final tips = DocumentExtractionService.getPhotoTips(
      countryCode: widget.countryCode,
      documentType: _selectedDocumentType,
    );

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.light_mode_outlined,
                  color: Colors.grey.shade700, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                'Tips for best results:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ...tips.map(
            (tip) => Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• ', style: TextStyle(fontSize: 12.sp)),
                  Expanded(
                    child: Text(
                      tip,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// ============================================
  /// STEP 2: Selfie Verification
  /// ============================================
  Widget _buildSelfieStep() {
    final steps = _getSteps();
    final step = steps[2];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(step),
        SizedBox(height: 24.h),

        // Selfie upload card
        GestureDetector(
          onTap: _isLoading ? null : _captureSelfie,
          child: Container(
            height: 300.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _selfie != null ? Colors.green.shade300 : Colors.grey.shade300,
                width: _selfie != null ? 2 : 1,
              ),
            ),
            child: _selfie == null
                ? _buildEmptySelfieCard()
                : _buildSelfiePreview(),
          ),
        ),

        SizedBox(height: 24.h),

        // Selfie tips
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.face_outlined,
                      color: Colors.blue.shade700, size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Selfie Guidelines:',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              ..._getSelfieTips().map(
                (tip) => Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('• ', style: TextStyle(fontSize: 12.sp)),
                      Expanded(
                        child: Text(
                          tip,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.blue.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build empty selfie card
  Widget _buildEmptySelfieCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.face_outlined,
            size: 50.sp,
            color: Colors.grey.shade400,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Take a Selfie',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'We need to verify it\'s really you',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  /// Build selfie preview
  Widget _buildSelfiePreview() {
    return Stack(
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.file(
              File(_selfie!.path),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 20.sp),
          ),
        ),
        Positioned(
          bottom: 12.h,
          left: 0,
          right: 0,
          child: Center(
            child: InkWell(
              onTap: () {
                setState(() => _selfie = null);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 16.sp),
                    SizedBox(width: 8.w),
                    Text(
                      'Retake',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Get selfie tips
  List<String> _getSelfieTips() {
    return [
      'Look directly at the camera',
      'Remove glasses and hats',
      'Ensure your face is well-lit',
      'Keep a neutral expression',
      'Make sure your entire face is visible',
    ];
  }

  /// ============================================
  /// STEP 3: Address Verification (Advanced KYC)
  /// ============================================
  Widget _buildAddressStep() {
    final steps = _getSteps();
    final step = steps[3];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStepHeader(step),
        SizedBox(height: 24.h),

        // Address form
        _buildTextField(
          label: 'Address Line 1',
          prefixIcon: Icons.home_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Address is required';
            }
            return null;
          },
        ),
        SizedBox(height: 16.h),

        _buildTextField(
          label: 'City',
          prefixIcon: Icons.location_city_outlined,
        ),
        SizedBox(height: 16.h),

        Row(
          children: [
            Expanded(
              child: _buildTextField(
                label: 'Postal Code',
                prefixIcon: Icons.markunread_mailbox_outlined,
              ),
            ),
          ],
        ),

        SizedBox(height: 24.h),

        // Proof of address upload
        GestureDetector(
          onTap: _isLoading ? null : _captureProofOfAddress,
          child: Container(
            height: 180.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: _proofOfAddress != null
                    ? Colors.green.shade300
                    : Colors.grey.shade300,
                width: _proofOfAddress != null ? 2 : 1,
              ),
            ),
            child: _proofOfAddress == null
                ? _buildEmptyProofOfAddressCard()
                : _buildProofOfAddressPreview(),
          ),
        ),

        SizedBox(height: 16.h),

        // Proof of address info
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.orange.shade700, size: 18.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  'Acceptable documents: Utility bill, Bank statement, '
                  'or Government correspondence (not older than 3 months).',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build empty proof of address card
  Widget _buildEmptyProofOfAddressCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.description_outlined,
          size: 48.sp,
          color: Colors.grey.shade400,
        ),
        SizedBox(height: 12.h),
        Text(
          'Proof of Address',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Upload utility bill or bank statement',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  /// Build proof of address preview
  Widget _buildProofOfAddressPreview() {
    return Stack(
      children: [
        Center(
          child: Image.file(
            File(_proofOfAddress!.path),
            fit: BoxFit.contain,
          ),
        ),
        Positioned(
          top: 12.h,
          right: 12.w,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.check, color: Colors.white, size: 20.sp),
          ),
        ),
        Positioned(
          bottom: 12.h,
          right: 12.w,
          child: InkWell(
            onTap: () {
              setState(() => _proofOfAddress = null);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                'Retake',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// ============================================
  /// Shared Widgets
  /// ============================================
  Widget _buildStepHeader(KycStep step) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                step.icon,
                color: Colors.blue,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    step.subtitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        LinearProgressIndicator(
          value: (_currentStep + 1) / _getSteps().length,
          backgroundColor: Colors.grey.shade200,
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
      ],
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? label,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.red.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
      validator: validator,
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required VoidCallback onTap,
    String? Function(DateTime?)? validator,
  }) {
    return InkWell(
      onTap: onTap,
      child: FormField<DateTime>(
        validator: validator,
        builder: (state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: state.hasError
                        ? Colors.red.shade300
                        : Colors.grey.shade300,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.grey),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? label
                            : '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: selectedDate == null
                              ? Colors.grey.shade600
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (state.hasError) ...[
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: Text(
                    state.errorText ?? '',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red.shade600,
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  /// ============================================
  /// Actions
  /// ============================================

  /// Select document type
  void _selectDocumentType(IdentityDocumentType type) {
    setState(() {
      _selectedDocumentType = type;
      // Reset document images when type changes
      _frontDocument = null;
      _backDocument = null;
      _frontExtractionResult = null;
      _backExtractionResult = null;
      _isManualEntryMode = false;
    });
  }

  /// Capture front document
  Future<void> _captureFrontDocument() async {
    setState(() => _isLoading = true);

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        // Perform AI extraction
        final result = await _extractionService.extractFromDocument(
          imageFile: File(image.path),
          countryCode: widget.countryCode,
        );

        setState(() {
          _frontDocument = image;
          _frontExtractionResult = result;

          // Enable manual entry if extraction failed
          if (!result.success || result.confidence == ExtractionConfidence.low) {
            _isManualEntryMode = true;
          }

          // Auto-fill personal info if extraction succeeded
          if (result.success && result.extractedData != null) {
            _autoFillFromExtraction(result.extractedData!);
          }
        });

        // Show message based on result
        if (!result.success) {
          _showErrorSnackBar(
            DocumentExtractionService.getUserFriendlyError(result.errorMessage),
          );
        }
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Capture back document
  Future<void> _captureBackDocument() async {
    setState(() => _isLoading = true);

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (image != null) {
        // Perform AI extraction
        final result = await _extractionService.extractFromDocument(
          imageFile: File(image.path),
          countryCode: widget.countryCode,
        );

        setState(() {
          _backDocument = image;
          _backExtractionResult = result;
        });
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Capture selfie
  Future<void> _captureSelfie() async {
    setState(() => _isLoading = true);

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        preferredCameraDevice: CameraDevice.front,
      );

      if (image != null) {
        setState(() => _selfie = image);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture selfie: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Capture proof of address
  Future<void> _captureProofOfAddress() async {
    setState(() => _isLoading = true);

    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (image != null) {
        setState(() => _proofOfAddress = image);
      }
    } catch (e) {
      _showErrorSnackBar('Failed to capture document: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Auto-fill form from extraction result
  void _autoFillFromExtraction(Map<String, dynamic> data) {
    final firstName = data['firstName'] as String?;
    final lastName = data['lastName'] as String?;
    final dobStr = data['dateOfBirth'] as String?;

    if (firstName != null) _firstNameController.text = firstName;
    if (lastName != null) _lastNameController.text = lastName;

    if (dobStr != null) {
      try {
        final parts = dobStr.split('-');
        if (parts.length == 3) {
          _dateOfBirth = DateTime(
            int.parse(parts[0]),
            int.parse(parts[1]),
            int.parse(parts[2]),
          );
        }
      } catch (_) {
        // Try other date formats
        // ...
      }
    }
  }

  /// Show date picker
  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1990),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() => _dateOfBirth = picked);
    }
  }

  /// Go to next step
  void _goNext() {
    if (!_validateCurrentStep()) return;

    if (_currentStep < _getSteps().length - 1) {
      setState(() => _currentStep++);
    } else {
      _submitVerification();
    }
  }

  /// Go back
  void _goBack() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  /// Validate current step
  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _validatePersonalInfo();
      case 1:
        return _validateDocument();
      case 2:
        return _validateSelfie();
      case 3:
        return _validateAddress();
      default:
        return true;
    }
  }

  bool _validatePersonalInfo() {
    if (_firstNameController.text.isEmpty) {
      _showErrorSnackBar('Please enter your first name');
      return false;
    }
    if (_lastNameController.text.isEmpty) {
      _showErrorSnackBar('Please enter your last name');
      return false;
    }
    if (_dateOfBirth == null) {
      _showErrorSnackBar('Please select your date of birth');
      return false;
    }
    return true;
  }

  bool _validateDocument() {
    if (_frontDocument == null) {
      _showErrorSnackBar('Please capture the front of your document');
      return false;
    }
    if (_needsBackDocument() && _backDocument == null) {
      _showErrorSnackBar('Please capture the back of your document');
      return false;
    }
    return true;
  }

  bool _validateSelfie() {
    if (_selfie == null) {
      _showErrorSnackBar('Please take a selfie');
      return false;
    }
    return true;
  }

  bool _validateAddress() {
    // Address validation is flexible
    return true;
  }

  /// Submit verification
  Future<void> _submitVerification() async {
    setState(() => _isLoading = true);

    try {
      // Get UserServiceClient from service locator
      final userServiceClient = GetIt.I<UserServiceClient>();

      // Map identity document type to proto enum
      final documentType = _mapIdentityTypeToProto(_selectedDocumentType!);

      // Convert images to bytes
      final List<int>? frontImageBytes = await _frontDocument?.readAsBytes();
      final List<int>? backImageBytes = _backDocument != null
          ? await _backDocument?.readAsBytes()
          : null;

      if (frontImageBytes == null) {
        _showErrorSnackBar('Document image not available');
        return;
      }

      // Create upload request
      final request = user_pb.UploadIDDocumentRequest(
        documentType: documentType,
        frontImage: frontImageBytes,
        backImage: backImageBytes,
      );

      // Call the upload API
      final response = await userServiceClient.uploadIDDocument(request);

      if (response.success) {
        final uploadedDoc = response.hasDocument()
            ? response.document
            : null;

        if (uploadedDoc != null && uploadedDoc.hasId()) {
          // Now verify the uploaded document
          final verifyRequest = user_pb.VerifyIDDocumentRequest(
            documentId: uploadedDoc.id,
          );

          final verifyResponse = await userServiceClient.verifyIDDocument(verifyRequest);

          if (verifyResponse.success) {
            _showSuccessSnackBar('Verification submitted successfully! Your ID is being reviewed.');
            await Future.delayed(const Duration(milliseconds: 500));
            Get.back(result: true);
          } else {
            _showErrorSnackBar('Document uploaded but verification failed: ${verifyResponse.message}');
          }
        } else {
          _showSuccessSnackBar('Document uploaded successfully!');
          await Future.delayed(const Duration(milliseconds: 500));
          Get.back(result: true);
        }
      } else {
        _showErrorSnackBar('Failed to upload document: ${response.message}');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to submit verification: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  /// Map identity document type to proto enum
  user_pb.DocumentType _mapIdentityTypeToProto(IdentityDocumentType type) {
    switch (type) {
      // Nigeria
      case IdentityDocumentType.bvn:
        return user_pb.DocumentType.DOCUMENT_TYPE_BVN;
      case IdentityDocumentType.nin:
        return user_pb.DocumentType.DOCUMENT_TYPE_NIN;
      case IdentityDocumentType.intlPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case IdentityDocumentType.driverLicense:
        return user_pb.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE;

      // UK
      case IdentityDocumentType.ukPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case IdentityDocumentType.ukDriverLicense:
        return user_pb.DocumentType.DOCUMENT_TYPE_DRIVERS_LICENSE;
      case IdentityDocumentType.niNumber:
        return user_pb.DocumentType.DOCUMENT_TYPE_NIN_NUMBER;

      // US
      case IdentityDocumentType.ssn:
        return user_pb.DocumentType.DOCUMENT_TYPE_SSN;
      case IdentityDocumentType.ssnLast4:
        return user_pb.DocumentType.DOCUMENT_TYPE_SSN_LAST4;
      case IdentityDocumentType.usPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case IdentityDocumentType.usStateId:
        return user_pb.DocumentType.DOCUMENT_TYPE_STATE_ID;
      case IdentityDocumentType.usItin:
        return user_pb.DocumentType.DOCUMENT_TYPE_ITIN;

      // Ghana
      case IdentityDocumentType.ghanaCard:
        return user_pb.DocumentType.DOCUMENT_TYPE_GHANA_CARD;
      case IdentityDocumentType.ghanaVoterCard:
        return user_pb.DocumentType.DOCUMENT_TYPE_VOTER_CARD;
      case IdentityDocumentType.ghanaSsnit:
        return user_pb.DocumentType.DOCUMENT_TYPE_SSNIT;
      case IdentityDocumentType.ghanaPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;

      // Kenya
      case IdentityDocumentType.kenyaNationalId:
        return user_pb.DocumentType.DOCUMENT_TYPE_NATIONAL_ID;
      case IdentityDocumentType.kenyaKraPin:
        return user_pb.DocumentType.DOCUMENT_TYPE_KRA_PIN;
      case IdentityDocumentType.kenyaPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;
      case IdentityDocumentType.kenyaAlienId:
        return user_pb.DocumentType.DOCUMENT_TYPE_ALIEN_ID;

      // South Africa
      case IdentityDocumentType.saId:
        return user_pb.DocumentType.DOCUMENT_TYPE_NATIONAL_ID;
      case IdentityDocumentType.saPassport:
        return user_pb.DocumentType.DOCUMENT_TYPE_PASSPORT;

    }
  }

  /// Show error snackbar
  void _showErrorSnackBar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade400,
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Icon(Icons.error, color: Colors.white),
    );
  }

  /// Show success snackbar
  void _showSuccessSnackBar(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.shade400,
      colorText: Colors.white,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }
}

/// KYC Step model
class KycStep {
  final String title;
  final String subtitle;
  final IconData icon;

  const KycStep({
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
