import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';

/// Document upload screen for Tier 3 KYC verification.
///
/// Guides the user through selecting, capturing, previewing, and uploading
/// identity documents (Government ID front/back, Proof of Address).
class DocumentUploadScreen extends StatefulWidget {
  final String userId;

  const DocumentUploadScreen({
    super.key,
    required this.userId,
  });

  static const String route = '/kyc/document-upload';

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  // Theme colors
  static const _background = Color(0xFF0A0A0A);
  static const _cardBackground = Color(0xFF1F1F1F);
  static const _primary = Color(0xFF3B82F6);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFFB923C);
  static const _error = Color(0xFFEF4444);
  static const _divider = Color(0xFF2D2D2D);

  static const _maxFileSizeBytes = 5 * 1024 * 1024; // 5 MB
  static const _supportedExtensions = ['jpg', 'jpeg', 'png', 'pdf'];

  final ImagePicker _picker = ImagePicker();
  final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(seconds: 30),
  ));

  int _currentStep = 0;

  // Document type selection
  IDType _selectedDocType = IDType.internationalPassport;

  // Captured files
  XFile? _frontImage;
  XFile? _backImage;
  XFile? _proofOfAddress;

  // Upload state
  bool _isUploading = false;
  int _totalFilesToUpload = 0;
  int _filesUploaded = 0;
  double _currentFileProgress = 0;
  String? _uploadError;

  double get _overallProgress {
    if (_totalFilesToUpload == 0) return 0;
    return (_filesUploaded + _currentFileProgress) / _totalFilesToUpload;
  }

  // Review submitted
  bool _submitted = false;

  final List<IDType> _documentTypes = [
    IDType.internationalPassport,
    IDType.driversLicense,
    IDType.nin,
    IDType.votersCard,
  ];

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Step titles
  // ---------------------------------------------------------------------------

  List<String> get _stepTitles => [
        'Select Document',
        'Capture Documents',
        'Preview & Confirm',
        'Upload',
      ];

  // ---------------------------------------------------------------------------
  // File picking / camera
  // ---------------------------------------------------------------------------

  Future<XFile?> _pickImage({required ImageSource source}) async {
    try {
      final file = await _picker.pickImage(
        source: source,
        maxWidth: 2048,
        maxHeight: 2048,
        imageQuality: 85,
      );
      if (file == null) return null;

      // Validate size
      final bytes = await file.length();
      if (bytes > _maxFileSizeBytes) {
        if (mounted) {
          _showSnackBar('File too large. Maximum size is 5 MB.', isError: true);
        }
        return null;
      }

      // Validate extension
      final ext = file.path.split('.').last.toLowerCase();
      if (!_supportedExtensions.contains(ext)) {
        if (mounted) {
          _showSnackBar(
            'Unsupported format. Use JPEG, PNG, or PDF.',
            isError: true,
          );
        }
        return null;
      }

      return file;
    } on PlatformException catch (e) {
      debugPrint('[DocUpload] Picker error: $e');
      if (mounted) {
        _showSnackBar('Could not access camera or gallery.', isError: true);
      }
      return null;
    }
  }

  Future<void> _captureDocument({
    required String label,
    required void Function(XFile file) onPicked,
  }) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: _cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: _divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: _primary),
                title: const Text(
                  'Take Photo',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(ctx, ImageSource.camera),
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library_rounded, color: _primary),
                title: const Text(
                  'Choose from Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () => Navigator.pop(ctx, ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );

    if (source == null) return;

    final file = await _pickImage(source: source);
    if (file != null) {
      onPicked(file);
    }
  }

  // ---------------------------------------------------------------------------
  // Upload helpers
  // ---------------------------------------------------------------------------

  String _mimeTypeForFile(XFile file) {
    final ext = file.path.split('.').last.toLowerCase();
    switch (ext) {
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      case 'jpg':
      case 'jpeg':
      default:
        return 'image/jpeg';
    }
  }

  /// Requests a presigned GCS upload URL from backend, then uploads file bytes directly to GCS.
  /// Returns the storage key and object URL on success, null on failure.
  Future<_GCSUploadResult?> _uploadDocToGCS({
    required KYCCubit cubit,
    required XFile file,
    required String docType,
    required String contentType,
  }) async {
    try {
      // Step 1: Get presigned upload URL from backend
      final uploadURLResult = await cubit.repository.getDocumentUploadURL(
        documentType: docType,
        contentType: contentType,
      );

      return uploadURLResult.fold(
        (failure) {
          debugPrint('[DocUpload] Failed to get upload URL: ${failure.message}');
          if (mounted) {
            setState(() {
              _uploadError = 'Failed to get upload URL: ${failure.message}';
            });
          }
          return null;
        },
        (uploadInfo) async {
          // Step 2: Upload file bytes directly to GCS via presigned PUT URL
          final Uint8List bytes = await file.readAsBytes();

          await _dio.put<dynamic>(
            uploadInfo.uploadUrl,
            data: Stream.fromIterable([bytes]),
            options: Options(
              headers: {
                'Content-Type': contentType,
                'Content-Length': bytes.length,
              },
              followRedirects: true,
            ),
            onSendProgress: (sent, total) {
              if (total > 0 && mounted) {
                setState(() {
                  _currentFileProgress = sent / total;
                });
              }
            },
          );

          // Strip query params from presigned URL to get the object URL
          final uri = Uri.parse(uploadInfo.uploadUrl);
          final objectUrl = '${uri.scheme}://${uri.host}${uri.path}';

          return _GCSUploadResult(
            storageKey: uploadInfo.storageKey,
            objectUrl: objectUrl,
          );
        },
      );
    } on DioException catch (e) {
      debugPrint('[DocUpload] GCS upload failed: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('[DocUpload] Upload error: $e');
      return null;
    }
  }

  Future<void> _uploadAllDocuments() async {
    if (_isUploading || !mounted) return;

    setState(() {
      _isUploading = true;
      _totalFilesToUpload = [_frontImage, _backImage, _proofOfAddress].where((f) => f != null).length;
      _filesUploaded = 0;
      _currentFileProgress = 0;
      _uploadError = null;
    });

    final KYCCubit cubit;
    try {
      cubit = context.read<KYCCubit>();
    } catch (e) {
      debugPrint('[DocUpload] KYCCubit not available: $e');
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadError = 'Service unavailable. Please try again.';
        });
      }
      return;
    }
    final List<DocumentSubmissionItem> uploadedDocs = [];

    try {
      // Upload front image via GCS presigned URL
      if (_frontImage != null) {
        final mime = _mimeTypeForFile(_frontImage!);
        final result = await _uploadDocToGCS(
          cubit: cubit,
          file: _frontImage!,
          docType: 'gov_id_front',
          contentType: mime,
        );
        if (result != null) {
          uploadedDocs.add(DocumentSubmissionItem(
            storageKey: result.storageKey,
            documentType: 'gov_id_front',
            contentType: mime,
          ));
          setState(() { _filesUploaded++; _currentFileProgress = 0; });
        }
      }

      // Upload back image via GCS presigned URL
      if (_backImage != null) {
        final mime = _mimeTypeForFile(_backImage!);
        final result = await _uploadDocToGCS(
          cubit: cubit,
          file: _backImage!,
          docType: 'gov_id_back',
          contentType: mime,
        );
        if (result != null) {
          uploadedDocs.add(DocumentSubmissionItem(
            storageKey: result.storageKey,
            documentType: 'gov_id_back',
            contentType: mime,
          ));
          setState(() { _filesUploaded++; _currentFileProgress = 0; });
        }
      }

      // Upload proof of address via GCS presigned URL
      if (_proofOfAddress != null) {
        final mime = _mimeTypeForFile(_proofOfAddress!);
        final result = await _uploadDocToGCS(
          cubit: cubit,
          file: _proofOfAddress!,
          docType: 'proof_of_address',
          contentType: mime,
        );
        if (result != null) {
          uploadedDocs.add(DocumentSubmissionItem(
            storageKey: result.storageKey,
            documentType: 'proof_of_address',
            contentType: mime,
          ));
          setState(() { _filesUploaded++; _currentFileProgress = 0; });
        }
      }

      if (uploadedDocs.isEmpty) {
        throw Exception('No documents were uploaded successfully');
      }

      // Submit all uploaded documents for admin review
      cubit.submitDocumentsForReview(
        userId: widget.userId,
        documents: uploadedDocs,
      );
    } catch (e) {
      debugPrint('[DocUpload] Upload error: $e');
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadError = 'Upload failed: ${e.toString()}';
        });
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  bool get _canProceed {
    switch (_currentStep) {
      case 0:
        return true; // Doc type always selected
      case 1:
        return _frontImage != null; // At minimum front is required
      case 2:
        return true; // Preview step
      case 3:
        return false; // Upload in progress
      default:
        return false;
    }
  }

  void _nextStep() {
    if (_currentStep < 3) {
      setState(() => _currentStep++);
      if (_currentStep == 3) {
        _uploadAllDocuments();
      }
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  // ---------------------------------------------------------------------------
  // Snackbar
  // ---------------------------------------------------------------------------

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? _error : _success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KYCCubit, KYCState>(
      listener: (context, state) {
        if (!mounted) return;

        if (state is IDVerificationSuccess) {
          setState(() {
            _isUploading = false;
            _submitted = true;
          });
          HapticFeedback.mediumImpact();
        } else if (state is KYCError) {
          setState(() {
            _isUploading = false;
            _uploadError =
                state.userMessage ?? 'Something went wrong. Please try again.';
          });
        }
      },
      builder: (context, state) {
        return PopScope(
          canPop: !_isUploading,
          onPopInvokedWithResult: (didPop, result) {
            if (!didPop && _isUploading) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Upload in progress. Please wait.')),
              );
            }
          },
          child: Scaffold(
          backgroundColor: _background,
          appBar: AppBar(
            backgroundColor: _background,
            elevation: 0,
            title: const Text(
              'Document Verification',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white,
                  size: 20),
              onPressed: () {
                if (_currentStep > 0 && !_submitted) {
                  _previousStep();
                } else {
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          body: SafeArea(
            child: _submitted
                ? _buildSubmittedView()
                : Column(
                    children: [
                      _buildStepIndicator(),
                      Expanded(child: _buildStepContent()),
                      if (!_isUploading && _currentStep < 3)
                        _buildBottomBar(),
                    ],
                  ),
          ),
        ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Step indicator
  // ---------------------------------------------------------------------------

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: List.generate(_stepTitles.length, (i) {
          final isActive = i == _currentStep;
          final isCompleted = i < _currentStep;
          return Expanded(
            child: Row(
              children: [
                if (i > 0)
                  Expanded(
                    child: Container(
                      height: 2,
                      color: isCompleted ? _primary : _divider,
                    ),
                  ),
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? _primary
                        : isActive
                            ? _primary.withValues(alpha: 0.2)
                            : _cardBackground,
                    shape: BoxShape.circle,
                    border: isActive
                        ? Border.all(color: _primary, width: 2)
                        : null,
                  ),
                  child: Center(
                    child: isCompleted
                        ? const Icon(Icons.check, color: Colors.white, size: 16)
                        : Text(
                            '${i + 1}',
                            style: TextStyle(
                              color: isActive ? _primary : _textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step content
  // ---------------------------------------------------------------------------

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildDocTypeStep();
      case 1:
        return _buildCaptureStep();
      case 2:
        return _buildPreviewStep();
      case 3:
        return _buildUploadStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // Step 1: Document type
  Widget _buildDocTypeStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Select Document Type',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Choose the type of government-issued ID you want to upload.',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),
          ..._documentTypes.map((type) => _buildDocTypeOption(type)),
          const SizedBox(height: 24),

          // Proof of address note
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _warning.withValues(alpha: 0.3)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded, color: _warning, size: 20),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'You will also need to upload a Proof of Address '
                    '(utility bill or bank statement less than 3 months old).',
                    style: TextStyle(color: _warning, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocTypeOption(IDType type) {
    final isSelected = _selectedDocType == type;
    return GestureDetector(
      onTap: () => setState(() => _selectedDocType = type),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: _cardBackground,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? _primary : _divider,
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? _primary : _textSecondary,
                  width: 2,
                ),
                color: isSelected ? _primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 14)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                type.displayName,
                style: TextStyle(
                  color: isSelected ? Colors.white : _textSecondary,
                  fontSize: 15,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: _primary, size: 20),
          ],
        ),
      ),
    );
  }

  // Step 2: Capture documents
  Widget _buildCaptureStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            'Capture ${_selectedDocType.displayName}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Take a clear photo or select from your gallery.',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),

          // Front
          _buildCaptureCard(
            label: 'Front of Document',
            file: _frontImage,
            isRequired: true,
            onCapture: () => _captureDocument(
              label: 'Front of Document',
              onPicked: (f) => setState(() => _frontImage = f),
            ),
            onClear: () => setState(() => _frontImage = null),
          ),
          const SizedBox(height: 16),

          // Back
          _buildCaptureCard(
            label: 'Back of Document',
            file: _backImage,
            isRequired: false,
            onCapture: () => _captureDocument(
              label: 'Back of Document',
              onPicked: (f) => setState(() => _backImage = f),
            ),
            onClear: () => setState(() => _backImage = null),
          ),
          const SizedBox(height: 16),

          // Proof of Address
          _buildCaptureCard(
            label: 'Proof of Address',
            file: _proofOfAddress,
            isRequired: true,
            onCapture: () => _captureDocument(
              label: 'Proof of Address',
              onPicked: (f) => setState(() => _proofOfAddress = f),
            ),
            onClear: () => setState(() => _proofOfAddress = null),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildCaptureCard({
    required String label,
    required XFile? file,
    required bool isRequired,
    required VoidCallback onCapture,
    required VoidCallback onClear,
  }) {
    final hasFile = file != null;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: hasFile ? _success.withValues(alpha: 0.5) : _divider,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
            child: Row(
              children: [
                Icon(
                  hasFile ? Icons.check_circle : Icons.upload_file_rounded,
                  color: hasFile ? _success : _textSecondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (isRequired && !hasFile)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: _error.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Required',
                      style: TextStyle(color: _error, fontSize: 11),
                    ),
                  ),
                if (hasFile)
                  GestureDetector(
                    onTap: onClear,
                    child: const Icon(Icons.close, color: _textSecondary,
                        size: 18),
                  ),
              ],
            ),
          ),

          if (hasFile) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
              child: SizedBox(
                height: 160,
                width: double.infinity,
                child: file.path.toLowerCase().endsWith('.pdf')
                    ? Container(
                        color: _background,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.picture_as_pdf,
                                  color: _error, size: 40),
                              SizedBox(height: 6),
                              Text(
                                'PDF Document',
                                style: TextStyle(
                                    color: _textSecondary, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Image.file(
                        File(file.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ] else ...[
            GestureDetector(
              onTap: onCapture,
              child: Container(
                margin: const EdgeInsets.all(12),
                height: 100,
                decoration: BoxDecoration(
                  color: _background,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _divider,
                    style: BorderStyle.solid,
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_a_photo_rounded,
                          color: _primary, size: 28),
                      SizedBox(height: 6),
                      Text(
                        'Tap to capture',
                        style: TextStyle(color: _textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Step 3: Preview
  Widget _buildPreviewStep() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Review Your Documents',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Make sure all documents are clear and legible before uploading.',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
          const SizedBox(height: 24),

          _buildPreviewTile('Front of Document', _frontImage),
          if (_backImage != null)
            _buildPreviewTile('Back of Document', _backImage),
          if (_proofOfAddress != null)
            _buildPreviewTile('Proof of Address', _proofOfAddress),

          const SizedBox(height: 16),

          // Re-take hint
          Center(
            child: TextButton.icon(
              onPressed: _previousStep,
              icon: const Icon(Icons.refresh_rounded, color: _primary, size: 18),
              label: const Text(
                'Re-take a document',
                style: TextStyle(color: _primary, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPreviewTile(String label, XFile? file) {
    if (file == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: _cardBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: GestureDetector(
              onTap: () => _showFullPreview(file),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: file.path.toLowerCase().endsWith('.pdf')
                    ? Container(
                        color: _background,
                        child: const Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.picture_as_pdf,
                                  color: _error, size: 48),
                              SizedBox(height: 6),
                              Text(
                                'PDF Document - Tap to preview',
                                style: TextStyle(
                                    color: _textSecondary, fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Image.file(
                        File(file.path),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFullPreview(XFile file) {
    if (file.path.toLowerCase().endsWith('.pdf')) return;

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: InteractiveViewer(
            minScale: 0.5,
            maxScale: 4.0,
            child: Center(
              child: Image.file(File(file.path)),
            ),
          ),
        ),
      ),
    );
  }

  // Step 4: Upload
  Widget _buildUploadStep() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isUploading) ...[
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: _overallProgress > 0 ? _overallProgress : null,
                  strokeWidth: 4,
                  backgroundColor: _cardBackground,
                  valueColor: const AlwaysStoppedAnimation<Color>(_primary),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Uploading Documents... (${_filesUploaded}/$_totalFilesToUpload)',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${(_overallProgress * 100).toInt()}%',
                style: const TextStyle(color: _textSecondary, fontSize: 14),
              ),
            ],
            if (_uploadError != null && !_isUploading) ...[
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: _error.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                    Icons.error_outline_rounded, color: _error, size: 36),
              ),
              const SizedBox(height: 24),
              const Text(
                'Upload Failed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _uploadError!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: _textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _uploadAllDocuments,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('Retry Upload',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Submitted (Under Review)
  // ---------------------------------------------------------------------------

  Widget _buildSubmittedView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: _success.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.task_alt_rounded,
                color: _success,
                size: 44,
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Documents Submitted',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your documents are now under review.\n'
              'This usually takes 1-2 business days. '
              'We\'ll notify you once verification is complete.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _textSecondary, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 12),

            // Status badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _warning.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: _warning.withValues(alpha: 0.3)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.hourglass_top_rounded, color: _warning, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'Under Review',
                    style: TextStyle(
                      color: _warning,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom bar
  // ---------------------------------------------------------------------------

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
      decoration: const BoxDecoration(
        color: _background,
        border: Border(top: BorderSide(color: _divider)),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: _canProceed ? _nextStep : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _primary,
            disabledBackgroundColor: _primary.withValues(alpha: 0.3),
            foregroundColor: Colors.white,
            disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 0,
          ),
          child: Text(
            _currentStep == 2 ? 'Upload Documents' : 'Continue',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

/// Result of uploading a document to GCS via presigned URL
class _GCSUploadResult {
  final String storageKey;
  final String objectUrl;

  const _GCSUploadResult({
    required this.storageKey,
    required this.objectUrl,
  });
}
