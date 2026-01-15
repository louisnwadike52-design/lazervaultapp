import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/services/compliance/kyc_service.dart';
import 'dart:io';

class KYCVerificationScreen extends StatefulWidget {
  final KYCLevel targetLevel;

  const KYCVerificationScreen({
    Key? key,
    required this.targetLevel,
  }) : super(key: key);

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  int _currentStep = 0;
  bool _isLoading = false;

  // Personal Info
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;
  String? _nationality;

  // Address Info
  final _addressLine1Controller = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String? _country;

  // Documents
  XFile? _frontDocument;
  XFile? _backDocument;
  XFile? _selfie;
  DocumentType _selectedDocumentType = DocumentType.passport;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressLine1Controller.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  List<Step> _getSteps() {
    return [
      Step(
        title: const Text('Personal Information'),
        content: _buildPersonalInfoStep(),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Identity Document'),
        content: _buildDocumentStep(),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: const Text('Selfie Verification'),
        content: _buildSelfieStep(),
        isActive: _currentStep >= 2,
        state: _currentStep > 2 ? StepState.complete : StepState.indexed,
      ),
      if (widget.targetLevel == KYCLevel.advanced)
        Step(
          title: const Text('Address Verification'),
          content: _buildAddressStep(),
          isActive: _currentStep >= 3,
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
    ];
  }

  Widget _buildPersonalInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _firstNameController,
          decoration: const InputDecoration(
            labelText: 'First Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your first name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _lastNameController,
          decoration: const InputDecoration(
            labelText: 'Last Name',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your last name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ListTile(
          title: const Text('Date of Birth'),
          subtitle: Text(_dateOfBirth?.toString().split(' ')[0] ?? 'Select date'),
          trailing: const Icon(Icons.calendar_today),
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(const Duration(days: 6570)), // 18 years ago
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              setState(() {
                _dateOfBirth = date;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _nationality,
          decoration: const InputDecoration(
            labelText: 'Nationality',
            border: OutlineInputBorder(),
          ),
          items: _getCountries().map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _nationality = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDocumentStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload your government-issued ID',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        DropdownButton<DocumentType>(
          value: _selectedDocumentType,
          isExpanded: true,
          items: [
            DropdownMenuItem(
              value: DocumentType.passport,
              child: const Text('Passport'),
            ),
            DropdownMenuItem(
              value: DocumentType.driversLicense,
              child: const Text('Driver\'s License'),
            ),
            DropdownMenuItem(
              value: DocumentType.nationalId,
              child: const Text('National ID Card'),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedDocumentType = value;
              });
            }
          },
        ),
        const SizedBox(height: 24),
        _buildDocumentUploadCard(
          title: 'Front of Document',
          image: _frontDocument,
          onTap: () async {
            final image = await _imagePicker.pickImage(source: ImageSource.camera);
            if (image != null) {
              setState(() {
                _frontDocument = image;
              });
            }
          },
        ),
        const SizedBox(height: 16),
        if (_selectedDocumentType != DocumentType.passport)
          _buildDocumentUploadCard(
            title: 'Back of Document',
            image: _backDocument,
            onTap: () async {
              final image = await _imagePicker.pickImage(source: ImageSource.camera);
              if (image != null) {
                setState(() {
                  _backDocument = image;
                });
              }
            },
          ),
        const SizedBox(height: 16),
        const Text(
          'Tips for best results:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Ensure document is well-lit and in focus'),
        const Text('• All corners of document should be visible'),
        const Text('• Avoid glare and shadows'),
      ],
    );
  }

  Widget _buildSelfieStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Take a selfie for identity verification',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildDocumentUploadCard(
          title: 'Selfie',
          image: _selfie,
          onTap: () async {
            final image = await _imagePicker.pickImage(
              source: ImageSource.camera,
              preferredCameraDevice: CameraDevice.front,
            );
            if (image != null) {
              setState(() {
                _selfie = image;
              });
            }
          },
          icon: Icons.face,
        ),
        const SizedBox(height: 16),
        const Text(
          'Tips for best results:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Look directly at the camera'),
        const Text('• Remove glasses and hats'),
        const Text('• Ensure face is well-lit'),
        const Text('• Neutral expression'),
      ],
    );
  }

  Widget _buildAddressStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload proof of address (Utility bill or Bank statement)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _addressLine1Controller,
          decoration: const InputDecoration(
            labelText: 'Address Line 1',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your address';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _cityController,
          decoration: const InputDecoration(
            labelText: 'City',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your city';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _postalCodeController,
          decoration: const InputDecoration(
            labelText: 'Postal Code',
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your postal code';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _country,
          decoration: const InputDecoration(
            labelText: 'Country',
            border: OutlineInputBorder(),
          ),
          items: _getCountries().map((country) {
            return DropdownMenuItem(
              value: country,
              child: Text(country),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _country = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDocumentUploadCard({
    required String title,
    required XFile? image,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon ?? Icons.camera_alt,
                      size: 48,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Tap to capture',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                )
              : Stack(
                  children: [
                    Center(
                      child: Image.file(
                        File(image.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          setState(() {
                            if (title.contains('Front')) {
                              _frontDocument = null;
                            } else if (title.contains('Back')) {
                              _backDocument = null;
                            } else if (title.contains('Selfie')) {
                              _selfie = null;
                            }
                          });
                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _submitVerification() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Create personal info
      final personalInfo = PersonalInfo(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        dateOfBirth: _dateOfBirth!,
        nationality: _nationality,
      );

      // Create address info if needed
      AddressInfo? addressInfo;
      if (widget.targetLevel == KYCLevel.advanced) {
        addressInfo = AddressInfo(
          addressLine1: _addressLine1Controller.text,
          city: _cityController.text,
          postalCode: _postalCodeController.text,
          country: _country!,
        );
      }

      // Submit verification
      final kycService = KYCService(
        baseUrl: 'https://api.lazervault.com',
        apiKey: 'your-api-key',
      );

      final response = await kycService.createVerification(
        userId: 'current-user-id',
        targetLevel: widget.targetLevel,
        personalInfo: personalInfo,
        addressInfo: addressInfo,
      );

      // Upload documents
      if (_frontDocument != null) {
        await kycService.uploadDocument(
          verificationId: response.verification.id,
          documentType: _selectedDocumentType,
          file: _frontDocument!,
        );
      }

      // Upload selfie
      if (_selfie != null) {
        await kycService.submitLivenessCheck(
          verificationId: response.verification.id,
          selfie: _selfie!,
        );
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification submitted successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to submit verification: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KYC Verification - ${widget.targetLevel.toString().split('.').last}'),
      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: _currentStep,
          onStepContinue: () {
            if (_currentStep < _getSteps().length - 1) {
              setState(() {
                _currentStep += 1;
              });
            } else {
              _submitVerification();
            }
          },
          onStepCancel: () {
            if (_currentStep > 0) {
              setState(() {
                _currentStep -= 1;
              });
            }
          },
          steps: _getSteps(),
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: _isLoading ? null : details.onStepContinue,
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(_currentStep == _getSteps().length - 1
                            ? 'Submit'
                            : 'Continue'),
                  ),
                  const SizedBox(width: 8),
                  if (_currentStep > 0)
                    TextButton(
                      onPressed: details.onStepCancel,
                      child: const Text('Back'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<String> _getCountries() {
    return [
      'United States',
      'United Kingdom',
      'Canada',
      'Australia',
      'Germany',
      'France',
      'Spain',
      'Italy',
      // Add more countries as needed
    ];
  }
}
