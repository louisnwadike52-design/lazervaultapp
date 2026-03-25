import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';

class FileCreditLifeClaimScreen extends StatefulWidget {
  final String policyId;
  final String policyNumber;

  const FileCreditLifeClaimScreen({
    super.key,
    required this.policyId,
    this.policyNumber = '',
  });

  @override
  State<FileCreditLifeClaimScreen> createState() =>
      _FileCreditLifeClaimScreenState();
}

class _FileCreditLifeClaimScreenState
    extends State<FileCreditLifeClaimScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  String _selectedClaimType = 'death';
  final List<String> _uploadedDocumentIds = [];
  final List<String> _documentNames = [];
  bool _isUploading = false;

  static const _maxFileSizeBytes = 10 * 1024 * 1024; // 10MB

  final _claimTypes = const [
    {'value': 'death', 'label': 'Death'},
    {'value': 'disability', 'label': 'Disability'},
    {'value': 'critical_illness', 'label': 'Critical Illness'},
    {'value': 'job_loss', 'label': 'Job Loss'},
    {'value': 'other', 'label': 'Other'},
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('File Credit-Life Claim',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<InsuranceCubit, InsuranceState>(
        listener: (context, state) {
          if (state is CreditLifeClaimFiled) {
            Get.snackbar(
              'Claim Filed',
              'Claim ${state.claimNumber} submitted successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.back();
          } else if (state is InsuranceError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (widget.policyNumber.isNotEmpty) ...[
                Card(
                  color: const Color(0xFF1F1F1F),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        const Icon(Icons.policy,
                            color: Color(0xFF3B82F6), size: 20),
                        const SizedBox(width: 12),
                        Text('Policy: ${widget.policyNumber}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              // Claim type
              const Text('Claim Type',
                  style: TextStyle(
                      color: Color(0xFF9CA3AF), fontSize: 13)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedClaimType,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1F1F1F),
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14),
                    items: _claimTypes
                        .map((t) => DropdownMenuItem(
                              value: t['value'],
                              child: Text(t['label']!),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedClaimType = v!),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Amount
              const Text('Claim Amount (\u20A6)',
                  style: TextStyle(
                      color: Color(0xFF9CA3AF), fontSize: 13)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Enter amount'),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Amount is required';
                  }
                  final amount = double.tryParse(v);
                  if (amount == null || amount <= 0) {
                    return 'Enter a valid amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Description
              const Text('Description',
                  style: TextStyle(
                      color: Color(0xFF9CA3AF), fontSize: 13)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                style: const TextStyle(color: Colors.white),
                decoration:
                    _inputDecoration('Describe the claim...'),
                validator: (v) => (v == null || v.isEmpty)
                    ? 'Description is required'
                    : null,
              ),
              const SizedBox(height: 24),
              // Documents
              const Text('Supporting Documents',
                  style: TextStyle(
                      color: Color(0xFF9CA3AF), fontSize: 13)),
              const SizedBox(height: 4),
              const Text('Max 10MB per file. PDF, DOC, PNG, JPG supported.',
                  style: TextStyle(
                      color: Color(0xFF6B7280), fontSize: 11)),
              const SizedBox(height: 8),
              ..._documentNames.asMap().entries.map((entry) =>
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Card(
                      color: const Color(0xFF1F1F1F),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        dense: true,
                        leading: const Icon(Icons.description,
                            color: Color(0xFF3B82F6), size: 20),
                        title: Text(
                          entry.value,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.close,
                              color: Color(0xFFEF4444), size: 18),
                          onPressed: () =>
                              _removeDocument(entry.key),
                        ),
                      ),
                    ),
                  )),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _isUploading ? null : _pickDocument,
                      icon:
                          const Icon(Icons.upload_file, size: 18),
                      label: const Text('Upload File'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        side: const BorderSide(
                            color: Color(0xFF3B82F6)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed:
                          _isUploading ? null : _takePhoto,
                      icon:
                          const Icon(Icons.camera_alt, size: 18),
                      label: const Text('Take Photo'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        side: const BorderSide(
                            color: Color(0xFF3B82F6)),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isUploading) ...[
                const SizedBox(height: 12),
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(0xFF3B82F6))),
                      SizedBox(width: 8),
                      Text('Uploading...',
                          style: TextStyle(
                              color: Color(0xFF9CA3AF),
                              fontSize: 13)),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 32),
              // Submit
              BlocBuilder<InsuranceCubit, InsuranceState>(
                builder: (context, state) {
                  final isLoading = state is InsuranceLoading;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          isLoading || _isUploading ? null : _submitClaim,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF3B82F6),
                        disabledBackgroundColor:
                            const Color(0xFF3B82F6)
                                .withValues(alpha: 0.5),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12)),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2))
                          : const Text('Submit Claim',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16)),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFF6B7280)),
      filled: true,
      fillColor: const Color(0xFF1F1F1F),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6))),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFEF4444))),
    );
  }

  Future<void> _pickDocument() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'doc',
          'docx',
          'png',
          'jpg',
          'jpeg'
        ],
        withData: true,
      );
      if (result != null && result.files.single.bytes != null) {
        final bytes = result.files.single.bytes!;
        if (bytes.length > _maxFileSizeBytes) {
          Get.snackbar('File Too Large',
              'Maximum file size is 10MB. Please select a smaller file.',
              backgroundColor: const Color(0xFFFB923C),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP);
          return;
        }
        await _uploadFile(bytes.toList(), result.files.single.name);
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar('Error', 'Failed to pick file: $e',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final picker = ImagePicker();
      final photo = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      if (photo != null) {
        final bytes = await File(photo.path).readAsBytes();
        if (bytes.length > _maxFileSizeBytes) {
          if (mounted) {
            Get.snackbar('Photo Too Large',
                'Photo exceeds 10MB. Please try again with lower resolution.',
                backgroundColor: const Color(0xFFFB923C),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP);
          }
          return;
        }
        await _uploadFile(bytes.toList(), photo.name);
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar('Error', 'Failed to take photo: $e',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white);
      }
    }
  }

  Future<void> _uploadFile(List<int> bytes, String filename) async {
    if (!mounted) return;
    setState(() => _isUploading = true);
    try {
      final cubit = context.read<InsuranceCubit>();
      final uploadId = await cubit.uploadInsuranceDocument(
        fileData: bytes,
        filename: filename,
        documentType: 'claim_evidence',
      );
      if (mounted) {
        setState(() {
          _uploadedDocumentIds.add(uploadId);
          _documentNames.add(filename);
        });
      }
    } catch (e) {
      if (mounted) {
        Get.snackbar(
            'Upload Failed',
            'Could not upload document. Please try again.',
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP);
      }
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _removeDocument(int index) {
    setState(() {
      _uploadedDocumentIds.removeAt(index);
      _documentNames.removeAt(index);
    });
  }

  void _submitClaim() {
    if (!_formKey.currentState!.validate()) return;

    context.read<InsuranceCubit>().fileCreditLifeClaim(
          policyId: widget.policyId,
          claimType: _selectedClaimType,
          description: _descriptionController.text.trim(),
          amount: double.parse(_amountController.text),
          documents: _uploadedDocumentIds.isNotEmpty
              ? _uploadedDocumentIds
              : null,
        );
  }
}
