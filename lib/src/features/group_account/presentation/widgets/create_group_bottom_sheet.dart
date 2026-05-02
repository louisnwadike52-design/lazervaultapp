import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../utils/group_validators.dart';

class CreateGroupBottomSheet extends StatefulWidget {
  const CreateGroupBottomSheet({super.key});

  @override
  State<CreateGroupBottomSheet> createState() => _CreateGroupBottomSheetState();
}

class _CreateGroupBottomSheetState extends State<CreateGroupBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _whatsappLinkController = TextEditingController();
  final _telegramLinkController = TextEditingController();
  bool _isLoading = false;
  bool _isPublic = false;

  // Focus-aware error display for the optional social-link fields.
  // Pattern: error text shows when (a) the field has lost focus at least
  // once AND (b) the current value fails the canonical-link regex. As
  // soon as the user starts editing again the error clears, so they
  // aren't shouted at while mid-type.
  final FocusNode _whatsappFocus = FocusNode();
  final FocusNode _telegramFocus = FocusNode();
  String? _whatsappError;
  String? _telegramError;

  @override
  void initState() {
    super.initState();
    _whatsappFocus.addListener(_onWhatsappFocusChanged);
    _telegramFocus.addListener(_onTelegramFocusChanged);
    _whatsappLinkController.addListener(_clearWhatsappErrorOnEdit);
    _telegramLinkController.addListener(_clearTelegramErrorOnEdit);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _whatsappLinkController.removeListener(_clearWhatsappErrorOnEdit);
    _telegramLinkController.removeListener(_clearTelegramErrorOnEdit);
    _whatsappLinkController.dispose();
    _telegramLinkController.dispose();
    _whatsappFocus.dispose();
    _telegramFocus.dispose();
    super.dispose();
  }

  void _onWhatsappFocusChanged() {
    if (_whatsappFocus.hasFocus) return;
    setState(() {
      _whatsappError = GroupValidators.whatsappLink(_whatsappLinkController.text);
    });
  }

  void _onTelegramFocusChanged() {
    if (_telegramFocus.hasFocus) return;
    setState(() {
      _telegramError = GroupValidators.telegramLink(_telegramLinkController.text);
    });
  }

  void _clearWhatsappErrorOnEdit() {
    if (_whatsappError == null) return;
    setState(() => _whatsappError = null);
  }

  void _clearTelegramErrorOnEdit() {
    if (_telegramError == null) return;
    setState(() => _telegramError = null);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listenWhen: (previous, current) {
        // Only listen to states relevant to group creation
        return current is GroupAccountLoading ||
            current is GroupAccountGroupCreated ||
            current is GroupAccountError;
      },
      listener: (context, state) {
        if (state is GroupAccountLoading) {
          setState(() => _isLoading = true);
        } else if (state is GroupAccountGroupCreated) {
          setState(() => _isLoading = false);
          Get.back(); // Close bottom sheet
        } else if (state is GroupAccountError) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          border: Border(
            top: BorderSide(color: const Color(0xFF2D2D2D)),
            left: BorderSide(color: const Color(0xFF2D2D2D)),
            right: BorderSide(color: const Color(0xFF2D2D2D)),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle bar
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[600],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Header
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 78, 3, 208),
                                const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.group_add,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create New Group',
                                style: GoogleFonts.inter(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Start managing shared contributions',
                                style: GoogleFonts.inter(
                                  fontSize: 13.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: Icon(
                            Icons.close,
                            color: Colors.grey[400],
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),

                    // Group Name Field
                    Text(
                      'Group Name',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _nameController,
                      style: GoogleFonts.inter(color: Colors.white),
                      // Hard cap at the storage limit. Counter shown so the
                      // user knows they're approaching the limit.
                      maxLength: GroupValidators.nameMaxLength,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(GroupValidators.nameMaxLength),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Enter group name',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.group,
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 20.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 78, 3, 208),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                        counterStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 11.sp,
                        ),
                      ),
                      validator: GroupValidators.name,
                    ),
                    SizedBox(height: 24.h),

                    // Description Field
                    Text(
                      'Description',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      maxLength: GroupValidators.descriptionMaxLength,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(GroupValidators.descriptionMaxLength),
                      ],
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Describe the purpose of this group...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(bottom: 40.h),
                          child: Icon(
                            Icons.description,
                            color: const Color.fromARGB(255, 78, 3, 208),
                            size: 20.sp,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 78, 3, 208),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                        counterStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 11.sp,
                        ),
                      ),
                      validator: GroupValidators.description,
                    ),
                    SizedBox(height: 24.h),

                    // Visibility Selection
                    Text(
                      'Visibility',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPublic = false),
                            child: Container(
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A0A0A),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: !_isPublic
                                      ? const Color.fromARGB(255, 78, 3, 208)
                                      : const Color(0xFF2D2D2D),
                                  width: !_isPublic ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    color: !_isPublic
                                        ? const Color.fromARGB(255, 78, 3, 208)
                                        : const Color(0xFF9CA3AF),
                                    size: 24.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Private',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: !_isPublic ? Colors.white : const Color(0xFF9CA3AF),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Only invited members can see and join',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPublic = true),
                            child: Container(
                              padding: EdgeInsets.all(14.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF0A0A0A),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: _isPublic
                                      ? const Color.fromARGB(255, 78, 3, 208)
                                      : const Color(0xFF2D2D2D),
                                  width: _isPublic ? 2 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: _isPublic
                                        ? const Color.fromARGB(255, 78, 3, 208)
                                        : const Color(0xFF9CA3AF),
                                    size: 24.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'Public',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: _isPublic ? Colors.white : const Color(0xFF9CA3AF),
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Anyone can discover and join your group',
                                    style: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      color: Colors.grey[500],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // External Links Section
                    Row(
                      children: [
                        Icon(
                          Icons.link,
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Social Media Links (Optional)',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Add WhatsApp or Telegram group links for members',
                      style: GoogleFonts.inter(
                        color: Colors.grey[400],
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // WhatsApp Link Field
                    TextFormField(
                      controller: _whatsappLinkController,
                      focusNode: _whatsappFocus,
                      style: GoogleFonts.inter(color: Colors.white),
                      keyboardType: TextInputType.url,
                      maxLength: GroupValidators.linkMaxLength,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(GroupValidators.linkMaxLength),
                      ],
                      // The TextFormField has its own validator so it gets
                      // checked again at form-submit time. The errorText
                      // below is what drives the focus-aware "show on blur,
                      // hide on type" behaviour: we set _whatsappError on
                      // focus loss, clear it as soon as the user starts
                      // typing again. Both gates the submit button.
                      validator: GroupValidators.whatsappLink,
                      decoration: InputDecoration(
                        hintText: 'https://chat.whatsapp.com/...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.message,
                          color: const Color(0xFF25D366),
                          size: 20.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF25D366),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                        errorText: _whatsappError,
                        errorStyle: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                        ),
                        counterText: '',
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Telegram Link Field
                    TextFormField(
                      controller: _telegramLinkController,
                      focusNode: _telegramFocus,
                      style: GoogleFonts.inter(color: Colors.white),
                      keyboardType: TextInputType.url,
                      maxLength: GroupValidators.linkMaxLength,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(GroupValidators.linkMaxLength),
                      ],
                      validator: GroupValidators.telegramLink,
                      decoration: InputDecoration(
                        hintText: 'https://t.me/...',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.send,
                          color: const Color(0xFF0088CC),
                          size: 20.sp,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Color(0xFF0088CC),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Color(0xFFEF4444)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                        errorText: _telegramError,
                        errorStyle: GoogleFonts.inter(
                          color: const Color(0xFFEF4444),
                          fontSize: 12.sp,
                        ),
                        counterText: '',
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Info Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: const Color.fromARGB(255, 78, 3, 208),
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              'You will be the admin of this group and can add members and manage contributions.',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.grey[300],
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Create Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _createGroup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                          foregroundColor: Colors.white,
                          disabledBackgroundColor: Colors.grey[700],
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Text(
                                'Create Group',
                                style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _createGroup() {
    if (_formKey.currentState!.validate()) {
      // Set loading immediately for responsive button state
      setState(() => _isLoading = true);

      // Build metadata with external links
      final metadata = <String, dynamic>{};

      if (_whatsappLinkController.text.trim().isNotEmpty) {
        metadata['whatsapp_group_link'] = _whatsappLinkController.text.trim();
      }

      if (_telegramLinkController.text.trim().isNotEmpty) {
        metadata['telegram_group_link'] = _telegramLinkController.text.trim();
      }

      context.read<GroupAccountCubit>().createNewGroup(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            metadata: metadata.isEmpty ? null : metadata,
            visibility: _isPublic ? GroupVisibility.public : GroupVisibility.private,
          );
    }
  }
} 