import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/domain/entities/id_document.dart';

class IDVerificationScreen extends StatefulWidget {
  const IDVerificationScreen({super.key});

  @override
  State<IDVerificationScreen> createState() => _IDVerificationScreenState();
}

class _IDVerificationScreenState extends State<IDVerificationScreen> {
  DocumentType _selectedDocumentType = DocumentType.passport;
  File? _frontImage;
  File? _backImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickFrontImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _frontImage = File(image.path);
      });
    }
  }

  Future<void> _pickBackImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _backImage = File(image.path);
      });
    }
  }

  Future<void> _uploadDocument() async {
    if (_frontImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please capture the front of your document')),
      );
      return;
    }

    final Uint8List frontBytes = await _frontImage!.readAsBytes();
    Uint8List? backBytes;
    if (_backImage != null) {
      backBytes = await _backImage!.readAsBytes();
    }

    context.read<IdentityCubit>().uploadIDDocument(
          documentType: _selectedDocumentType,
          frontImage: frontBytes,
          backImage: backBytes,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ID Verification'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: BlocConsumer<IdentityCubit, IdentityState>(
        listener: (context, state) {
          if (state is IDDocumentUploaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context);
          } else if (state is IdentityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IdentityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Upload your ID document for verification',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),

                // Document Type Selector
                const Text('Document Type', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                DropdownButtonFormField<DocumentType>(
                  initialValue: _selectedDocumentType,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: DocumentType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_getDocumentTypeLabel(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _selectedDocumentType = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),

                // Front Image
                const Text('Front of Document', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickFrontImage,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade100,
                    ),
                    child: _frontImage == null
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                              SizedBox(height: 8),
                              Text('Tap to capture front'),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(_frontImage!, fit: BoxFit.cover),
                          ),
                  ),
                ),
                const SizedBox(height: 24),

                // Back Image (optional for some document types)
                if (_selectedDocumentType != DocumentType.passport) ...[
                  const Text('Back of Document', style: TextStyle(fontSize: 16)),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: _pickBackImage,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade100,
                      ),
                      child: _backImage == null
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt, size: 48, color: Colors.grey),
                                SizedBox(height: 8),
                                Text('Tap to capture back (optional)'),
                              ],
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(_backImage!, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],

                // Upload Button
                ElevatedButton(
                  onPressed: _uploadDocument,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple.shade700,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Upload Document',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getDocumentTypeLabel(DocumentType type) {
    switch (type) {
      case DocumentType.passport:
        return 'Passport';
      case DocumentType.driversLicense:
        return "Driver's License";
      case DocumentType.nationalId:
        return 'National ID';
      case DocumentType.residencePermit:
        return 'Residence Permit';
    }
  }
}
