import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/crowdfund_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:lazervault/src/features/crowdfund/data/services/crowdfund_image_upload_service.dart';
import 'package:lazervault/src/features/widgets/pay_flow_theme.dart';

/// Edit the editable surface of an active or paused campaign.
///
/// Server-side constraints (financial_products_service.go:UpdateCrowdfund):
///   • Status must be active or paused.
///   • Target can only stay the same or increase (never below
///     current_amount). UI pre-validates to surface a clean error.
///   • Deadline must be in the future. UI pre-validates same.
///   • category, title, description, image_url, status, target are
///     accepted. Story is not yet supported by the FP service
///     signature, so this screen omits it.
class EditCrowdfundScreen extends StatefulWidget {
  final Crowdfund crowdfund;

  const EditCrowdfundScreen({super.key, required this.crowdfund});

  @override
  State<EditCrowdfundScreen> createState() => _EditCrowdfundScreenState();
}

class _EditCrowdfundScreenState extends State<EditCrowdfundScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _targetController;
  late DateTime? _deadline;
  late String _category;
  bool _submitting = false;
  /// A locally picked replacement image, uploaded on save.
  ///
  /// Edit offered an "Image URL (optional)" text box only, while CREATE has
  /// always let you upload a photo or paste a URL. Nobody has a hosted URL for
  /// a photo on their phone, so editing a campaign's image was effectively
  /// impossible unless you had already hosted it somewhere.
  File? _pickedImageFile;
  bool _uploadingImage = false;
  final CrowdfundImageUploadService _uploadService =
      CrowdfundImageUploadService();

  // Mirror the seven built-in categories the create wizard uses.
  // User-defined custom categories don't appear here on edit — the
  // service accepts any non-empty string anyway, so a custom one
  // from creation is preserved untouched if the user doesn't change
  // it.
  static const _builtInCategories = <String>[
    'medical',
    'education',
    'business',
    'charity',
    'emergency',
    'community',
    'creative',
  ];

  @override
  void initState() {
    super.initState();
    final cf = widget.crowdfund;
    _titleController = TextEditingController(text: cf.title);
    _descriptionController = TextEditingController(text: cf.description);
    _imageUrlController = TextEditingController(text: cf.imageUrl ?? '');
    _targetController = TextEditingController(
      text: cf.targetAmount > 0 ? cf.targetAmount.toStringAsFixed(0) : '',
    );
    _deadline = cf.deadline;
    _category = cf.category.isEmpty ? 'medical' : cf.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  String? _validate() {
    final cf = widget.crowdfund;
    if (_titleController.text.trim().isEmpty) return 'Title is required';
    if (_descriptionController.text.trim().isEmpty) {
      return 'Description is required';
    }
    final target =
        double.tryParse(_targetController.text.replaceAll(',', '').trim()) ?? 0;
    if (target <= 0) return 'Target must be greater than zero';
    if (target < cf.currentAmount) {
      return 'Target cannot be less than the current raised (${cf.currency} ${cf.currentAmount.toStringAsFixed(2)})';
    }
    if (_deadline == null) return 'Deadline is required';
    // 'now' minus a small slack so a user picking "today" doesn't
    // trip an immediate-expiry error.
    if (_deadline!.isBefore(DateTime.now().subtract(const Duration(minutes: 5)))) {
      return 'Deadline must be in the future';
    }
    return null;
  }

  Future<void> _pickDeadline() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _deadline ?? DateTime.now().add(const Duration(days: 14)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
      builder: (ctx, child) => Theme(
        data: ThemeData.dark().copyWith(
          colorScheme: const ColorScheme.dark(primary: Color(0xFF4E03D0)),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _deadline = picked);
  }

  /// Pick a replacement image from the gallery. Mirrors the create flow: the
  /// file is only held for preview here and uploaded on save, so abandoning the
  /// edit never leaves an orphaned blob in storage.
  Future<void> _pickImage() async {
    if (_submitting) return;
    try {
      final picked = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() {
        _pickedImageFile = File(picked.path);
        // A picked file supersedes a typed URL — keeping both would leave the
        // user guessing which one is about to be saved.
        _imageUrlController.clear();
      });
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Could not open your photos.'),
          backgroundColor: Color(0xFFEF4444)));
    }
  }

  Widget _buildImagePicker() {
    final picked = _pickedImageFile;
    final existing = (widget.crowdfund.imageUrl ?? '').trim();
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 132.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
          image: picked != null
              ? DecorationImage(image: FileImage(picked), fit: BoxFit.cover)
              : (existing.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(existing), fit: BoxFit.cover)
                  : null),
        ),
        child: (picked == null && existing.isEmpty)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_photo_alternate_outlined,
                      size: 28.sp, color: PayFlowTheme.accentOnDark),
                  SizedBox(height: 6.h),
                  Text('Upload an image',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                          color: PayFlowTheme.accentOnDark)),
                ],
              )
            : Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_uploadingImage) ...[
                        SizedBox(
                            width: 12.sp,
                            height: 12.sp,
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white)),
                        SizedBox(width: 6.w),
                      ] else ...[
                        Icon(Icons.edit, size: 13.sp, color: Colors.white),
                        SizedBox(width: 4.w),
                      ],
                      Text(_uploadingImage ? 'Uploading…' : 'Change',
                          style: GoogleFonts.inter(
                              fontSize: 12.sp, color: Colors.white)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _save() async {
    final err = _validate();
    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err), backgroundColor: const Color(0xFFEF4444)),
      );
      return;
    }
    final cf = widget.crowdfund;
    final target = double.parse(_targetController.text.replaceAll(',', '').trim());
    setState(() => _submitting = true);

    // A picked file wins over whatever is in the URL box: it's the more recent
    // intent. Upload BEFORE the update call so a failed upload leaves the
    // campaign untouched rather than saving a half-applied edit.
    String? resolvedImageUrl =
        _imageUrlController.text.trim() != (cf.imageUrl ?? '')
            ? _imageUrlController.text.trim()
            : null;
    final picked = _pickedImageFile;
    if (picked != null) {
      setState(() => _uploadingImage = true);
      try {
        resolvedImageUrl = await _uploadService.uploadImage(picked);
      } on ImageUploadException catch (e) {
        if (!mounted) return;
        setState(() {
          _submitting = false;
          _uploadingImage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
            backgroundColor: const Color(0xFFEF4444)));
        return;
      } catch (_) {
        if (!mounted) return;
        setState(() {
          _submitting = false;
          _uploadingImage = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not upload image. Please try again.'),
            backgroundColor: Color(0xFFEF4444)));
        return;
      }
      if (!mounted) return;
      setState(() => _uploadingImage = false);
    }
    context.read<CrowdfundCubit>().updateCrowdfund(
          crowdfundId: cf.id,
          title: _titleController.text.trim() != cf.title
              ? _titleController.text.trim()
              : null,
          description: _descriptionController.text.trim() != cf.description
              ? _descriptionController.text.trim()
              : null,
          imageUrl: resolvedImageUrl,
          category: _category != cf.category ? _category : null,
          targetAmount: target != cf.targetAmount ? target : null,
          deadline: _deadline != null && _deadline != cf.deadline ? _deadline : null,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      listenWhen: (prev, curr) =>
          _submitting && (curr is CrowdfundUpdated || curr is CrowdfundError),
      listener: (ctx, state) {
        if (!mounted) return;
        if (state is CrowdfundUpdated) {
          Navigator.pop(context);
          return;
        }
        if (state is CrowdfundError) {
          setState(() => _submitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: const Color(0xFF0A0A0A),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            'Edit campaign',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _label('Title'),
                _textField(_titleController, maxLines: 1),
                SizedBox(height: 14.h),
                _label('Description'),
                _textField(_descriptionController, maxLines: 4, minLines: 3),
                SizedBox(height: 14.h),
                _label('Category'),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _builtInCategories.map((c) {
                    final selected = c == _category;
                    return InkWell(
                      onTap: () => setState(() => _category = c),
                      borderRadius: BorderRadius.circular(20.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF4E03D0)
                              : const Color(0xFF1F1F1F),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          _titleCase(c),
                          style: GoogleFonts.inter(
                            color: selected
                                ? Colors.white
                                : const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 14.h),
                _label('Target amount (${widget.crowdfund.currency})'),
                _textField(
                  _targetController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  'Target can only increase. Already raised: ${widget.crowdfund.currency} ${widget.crowdfund.currentAmount.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 14.h),
                _label('Deadline'),
                InkWell(
                  onTap: _pickDeadline,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _deadline == null
                              ? 'Pick a date'
                              : DateFormat.yMMMd().format(_deadline!),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                          ),
                        ),
                        const Icon(Icons.calendar_today_outlined,
                            color: Color(0xFF9CA3AF), size: 16),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 14.h),
                _label('Campaign image (optional)'),
                SizedBox(height: 8.h),
                _buildImagePicker(),
                SizedBox(height: 10.h),
                Text(
                  'or paste an image link',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: Colors.grey[500]),
                ),
                SizedBox(height: 6.h),
                _textField(_imageUrlController, maxLines: 1),
                SizedBox(height: 28.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitting ? null : _save,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4E03D0),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      disabledBackgroundColor:
                          const Color(0xFF4E03D0).withValues(alpha: 0.4),
                    ),
                    child: _submitting
                        ? LazerVaultLoader(size: 18)
                        : Text(
                            'Save changes',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      );

  Widget _textField(
    TextEditingController controller, {
    int? maxLines = 1,
    int? minLines,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      ),
    );
  }

  String _titleCase(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }
}
