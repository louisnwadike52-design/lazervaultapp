import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/tax/domain/entities/tax_document_entity.dart';
import '../cubit/tax_cubit.dart';
import '../cubit/tax_state.dart';

class TaxDocumentsScreen extends StatefulWidget {
  const TaxDocumentsScreen({super.key});

  @override
  State<TaxDocumentsScreen> createState() => _TaxDocumentsScreenState();
}

class _TaxDocumentsScreenState extends State<TaxDocumentsScreen> {
  @override
  void initState() {
    super.initState();
    _loadDocuments();
  }

  void _loadDocuments() {
    context.read<TaxCubit>().listDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Tax Documents',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _buildBody(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showUploadDialog(),
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.upload_file, color: Colors.white),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<TaxCubit, TaxState>(
      listener: (context, state) {
        if (state is TaxError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
        if (state is DocumentUploaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Document uploaded successfully'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadDocuments();
        }
        if (state is DocumentDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Document deleted'),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadDocuments();
        }
      },
      builder: (context, state) {
        if (state is TaxLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is DocumentsLoaded) {
          if (state.documents.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadDocuments(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemCount: state.documents.length,
              itemBuilder: (context, index) =>
                  _buildDocumentCard(state.documents[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Document Card
  // ---------------------------------------------------------------------------

  Widget _buildDocumentCard(TaxDocumentEntity document) {
    return Dismissible(
      key: Key(document.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDelete(document),
      background: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20.w),
        child: Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            // Document type icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: _documentIconColor(document.documentType)
                    .withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                _documentIcon(document.documentType),
                color: _documentIconColor(document.documentType),
                size: 22.sp,
              ),
            ),
            SizedBox(width: 12.w),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    document.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    document.documentTypeDisplay,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                    ),
                  ),
                  if (document.expiryDate != null) ...[
                    SizedBox(height: 4.h),
                    _buildExpiryLabel(document),
                  ],
                ],
              ),
            ),

            SizedBox(width: 8.w),

            // Chevron
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF9CA3AF),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpiryLabel(TaxDocumentEntity document) {
    final String label;
    final Color color;

    if (document.isExpired) {
      label = 'Expired';
      color = const Color(0xFFEF4444);
    } else if (document.isExpiringSoon) {
      final days = document.expiryDate!.difference(DateTime.now()).inDays;
      label = days == 0
          ? 'Expires today'
          : days == 1
              ? 'Expires in 1 day'
              : 'Expires in $days days';
      color = const Color(0xFFFB923C);
    } else {
      label = 'Expires ${_formatDate(document.expiryDate!)}';
      color = const Color(0xFF9CA3AF);
    }

    return Row(
      children: [
        if (document.isExpired || document.isExpiringSoon)
          Padding(
            padding: EdgeInsets.only(right: 4.w),
            child: Icon(
              Icons.warning_amber_rounded,
              color: color,
              size: 13.sp,
            ),
          ),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 11.sp,
              fontWeight: (document.isExpired || document.isExpiringSoon)
                  ? FontWeight.w600
                  : FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Delete Confirmation
  // ---------------------------------------------------------------------------

  Future<bool> _confirmDelete(TaxDocumentEntity document) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Delete Document',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${document.name}"? This action cannot be undone.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                'Delete',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      if (mounted) {
        context.read<TaxCubit>().deleteDocument(document.id);
      }
      return true;
    }

    return false;
  }

  // ---------------------------------------------------------------------------
  // Upload Dialog
  // ---------------------------------------------------------------------------

  void _showUploadDialog() {
    TaxDocumentType selectedType = TaxDocumentType.tinCert;
    final nameController = TextEditingController();
    final fileUrlController = TextEditingController();
    final notesController = TextEditingController();
    DateTime? selectedExpiryDate;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Text(
                'Upload Document',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Document Type dropdown
                    Text(
                      'Document Type',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<TaxDocumentType>(
                          value: selectedType,
                          isExpanded: true,
                          dropdownColor: const Color(0xFF1F1F1F),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: const Color(0xFF9CA3AF),
                            size: 20.sp,
                          ),
                          items: TaxDocumentType.values.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_documentTypeLabel(type)),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => selectedType = value);
                            }
                          },
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Name
                    _buildDialogTextField(
                      label: 'Document Name',
                      hint: 'e.g. TIN Certificate 2026',
                      controller: nameController,
                    ),

                    SizedBox(height: 16.h),

                    // File URL
                    _buildDialogTextField(
                      label: 'File URL',
                      hint: 'https://...',
                      controller: fileUrlController,
                      keyboardType: TextInputType.url,
                    ),

                    SizedBox(height: 16.h),

                    // Expiry Date
                    Text(
                      'Expiry Date (optional)',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: dialogContext,
                          initialDate: selectedExpiryDate ??
                              DateTime.now().add(const Duration(days: 365)),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 3650)),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: const ColorScheme.dark(
                                  primary: Color(0xFF3B82F6),
                                  surface: Color(0xFF1F1F1F),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setDialogState(() => selectedExpiryDate = picked);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 14.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedExpiryDate != null
                                  ? _formatDate(selectedExpiryDate!)
                                  : 'Select date (optional)',
                              style: GoogleFonts.inter(
                                color: selectedExpiryDate != null
                                    ? Colors.white
                                    : const Color(0xFF6B7280),
                                fontSize: 14.sp,
                              ),
                            ),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: const Color(0xFF9CA3AF),
                              size: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Notes
                    _buildDialogTextField(
                      label: 'Notes (optional)',
                      hint: 'Additional notes...',
                      controller: notesController,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    final fileUrl = fileUrlController.text.trim();

                    if (name.isEmpty || fileUrl.isEmpty) {
                      ScaffoldMessenger.of(dialogContext).showSnackBar(
                        SnackBar(
                          content:
                              const Text('Please fill in name and file URL'),
                          backgroundColor: const Color(0xFFEF4444),
                        ),
                      );
                      return;
                    }

                    Navigator.of(dialogContext).pop();
                    context.read<TaxCubit>().uploadDocument(
                          documentType: selectedType.index,
                          name: name,
                          fileUrl: fileUrl,
                          expiryDate: selectedExpiryDate != null
                              ? '${selectedExpiryDate!.year}-${selectedExpiryDate!.month.toString().padLeft(2, '0')}-${selectedExpiryDate!.day.toString().padLeft(2, '0')}'
                              : null,
                          notes: notesController.text.trim(),
                        );
                  },
                  child: Text(
                    'Upload',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF3B82F6),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDialogTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: Color(0xFF3B82F6)),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  IconData _documentIcon(TaxDocumentType type) {
    switch (type) {
      case TaxDocumentType.tinCert:
        return Icons.badge_outlined;
      case TaxDocumentType.vatRegistration:
        return Icons.receipt_long_outlined;
      case TaxDocumentType.taxClearance:
        return Icons.verified_outlined;
      case TaxDocumentType.whtReceipt:
        return Icons.description_outlined;
      case TaxDocumentType.filingReceipt:
        return Icons.description_outlined;
    }
  }

  Color _documentIconColor(TaxDocumentType type) {
    switch (type) {
      case TaxDocumentType.tinCert:
        return const Color(0xFF3B82F6);
      case TaxDocumentType.vatRegistration:
        return const Color(0xFF10B981);
      case TaxDocumentType.taxClearance:
        return const Color(0xFF8B5CF6);
      case TaxDocumentType.whtReceipt:
        return const Color(0xFFFB923C);
      case TaxDocumentType.filingReceipt:
        return const Color(0xFF3B82F6);
    }
  }

  String _documentTypeLabel(TaxDocumentType type) {
    switch (type) {
      case TaxDocumentType.tinCert:
        return 'TIN Certificate';
      case TaxDocumentType.vatRegistration:
        return 'VAT Registration';
      case TaxDocumentType.taxClearance:
        return 'Tax Clearance';
      case TaxDocumentType.whtReceipt:
        return 'WHT Receipt';
      case TaxDocumentType.filingReceipt:
        return 'Filing Receipt';
    }
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadDocuments(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.folder_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No tax documents',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap the upload button to add a document',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
