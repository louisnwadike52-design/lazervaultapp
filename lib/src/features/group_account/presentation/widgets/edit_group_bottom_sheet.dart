import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/utils/social_link_helpers.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class EditGroupBottomSheet extends StatefulWidget {
  final GroupAccount group;

  const EditGroupBottomSheet({
    super.key,
    required this.group,
  });

  @override
  State<EditGroupBottomSheet> createState() => _EditGroupBottomSheetState();
}

class _EditGroupBottomSheetState extends State<EditGroupBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _whatsappLinkController;
  late final TextEditingController _telegramLinkController;
  // FocusNodes drive the focus-aware prefix coloring (lighter on
  // focus, dimmer when idle) — same pattern the create-contribution
  // and create-group sheets use. Without these, the prefix would
  // stay flat regardless of which field the user is editing.
  final FocusNode _whatsappFocus = FocusNode();
  final FocusNode _telegramFocus = FocusNode();
  // Drives the button's spinner + disabled state. Set true the
  // moment the user taps Update; cleared only by the BlocListener on
  // a save-related terminal state (Success / Error). The cubit's
  // optimistic _patchLoaded fires GroupAccountGroupLoaded BEFORE
  // the network call returns, so we deliberately do NOT clear
  // _isLoading on that — see _isSaveTerminal below.
  bool _isLoading = false;
  // Token that gates the in-flight save. Each tap on Update bumps
  // it; we only react to a state emit if its associated token still
  // matches. Defends against double-taps and against this sheet
  // being reopened over a stale cubit listener.
  int _saveToken = 0;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.group.name);
    _descriptionController = TextEditingController(text: widget.group.description);

    // Pre-fill external links from metadata. Strip the canonical
    // prefix so the controller holds only the suffix; the prefix is
    // rendered as InputDecoration.prefixText below.
    final metadata = widget.group.metadata ?? {};
    _whatsappLinkController = TextEditingController(
      text: stripCanonicalPrefix(metadata['whatsapp_group_link']?.toString(), whatsappLinkPrefix),
    );
    _telegramLinkController = TextEditingController(
      text: stripCanonicalPrefix(metadata['telegram_group_link']?.toString(), telegramLinkPrefix),
    );
    _whatsappFocus.addListener(_onSocialFocusRebuild);
    _telegramFocus.addListener(_onSocialFocusRebuild);
  }

  void _onSocialFocusRebuild() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _whatsappLinkController.dispose();
    _telegramLinkController.dispose();
    _whatsappFocus.removeListener(_onSocialFocusRebuild);
    _telegramFocus.removeListener(_onSocialFocusRebuild);
    _whatsappFocus.dispose();
    _telegramFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      // listenWhen filters out emits that aren't related to a save:
      //   * GroupAccountLoading — only when WE kicked off a save.
      //   * GroupAccountSuccess — terminal save success.
      //   * GroupAccountError — terminal save failure.
      // The cubit's optimistic _patchLoaded fires GroupAccountGroupLoaded
      // mid-save; we ignore it so the loader doesn't blink off and
      // re-enable the button while the network call is still flying.
      listenWhen: (_, curr) =>
          _isLoading &&
          (curr is GroupAccountLoading ||
              curr is GroupAccountSuccess ||
              curr is GroupAccountError),
      listener: (context, state) {
        // Snapshot the token at listen-time; any state delivered for
        // a stale save (e.g. user re-tapped Update before the first
        // call returned) is ignored here.
        final token = _saveToken;

        if (state is GroupAccountSuccess) {
          if (!mounted || token != _saveToken) return;
          // Auto-close. Use Navigator instead of Get.back so we
          // pop THIS sheet's route specifically, not whatever
          // route GetX has at the top of its stack (avoids a
          // bug where another GetX-managed nav action races us).
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Group updated'),
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is GroupAccountError) {
          if (!mounted || token != _saveToken) return;
          // Surface the failure but keep the sheet open so the user
          // can fix what went wrong without retyping everything.
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
        // GroupAccountLoading: we've already set _isLoading=true at
        // tap time. Nothing to do here.
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
                            Icons.edit,
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
                                'Edit Group',
                                style: GoogleFonts.inter(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Update group info and social links',
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

                    // Group Name Field (Read-only)
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
                      enabled: false,
                      style: GoogleFonts.inter(color: Colors.grey[500]),
                      decoration: InputDecoration(
                        hintText: 'Group name',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.group,
                          color: Colors.grey[600],
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
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                      ),
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
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.trim().length < 10) {
                          return 'Description must be at least 10 characters';
                        }
                        return null;
                      },
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
                          'Social Media Links',
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
                      decoration: InputDecoration(
                        hintText: _whatsappFocus.hasFocus ? 'invite-code' : '',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.message,
                          color: const Color(0xFF25D366),
                          size: 20.sp,
                        ),
                        // Always-visible prefix (Material's prefixText
                        // hides when unfocused + empty). Color shifts
                        // lighter on focus / dimmer when idle to match
                        // the create-contribution + create-group sheets.
                        prefix: Text(
                          whatsappLinkPrefix,
                          style: GoogleFonts.inter(
                            color: _whatsappFocus.hasFocus
                                ? Colors.grey[200]
                                : Colors.grey[500],
                            fontSize: 14.sp,
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
                            color: Color(0xFF25D366),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Telegram Link Field
                    TextFormField(
                      controller: _telegramLinkController,
                      focusNode: _telegramFocus,
                      style: GoogleFonts.inter(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: _telegramFocus.hasFocus ? 'group-handle' : '',
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey[500],
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.send,
                          color: const Color(0xFF0088CC),
                          size: 20.sp,
                        ),
                        prefix: Text(
                          telegramLinkPrefix,
                          style: GoogleFonts.inter(
                            color: _telegramFocus.hasFocus
                                ? Colors.grey[200]
                                : Colors.grey[500],
                            fontSize: 14.sp,
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
                            color: Color(0xFF0088CC),
                            width: 2,
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0A0A0A),
                      ),
                    ),
                    SizedBox(height: 32.h),

                    // Update Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _updateGroup,
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
                                'Update Group',
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

  void _updateGroup() {
    // Guard 1: already saving. The button's onPressed is null while
    // _isLoading=true, but a fast double-tap can still squeeze through
    // before the next frame paints; explicit early-return keeps us safe.
    if (_isLoading) return;
    // Guard 2: form invalid. Keep the button enabled so subsequent
    // edits re-validate; just bail.
    if (!_formKey.currentState!.validate()) return;

    // Build metadata with external links, preserving existing metadata
    final metadata = Map<String, dynamic>.from(widget.group.metadata ?? {});

    // Update external links
    // Controllers hold suffix only; rebuild full URL with the
    // canonical prefix that lived in InputDecoration.prefixText.
    final whatsappFull = buildSocialFullUrl(_whatsappLinkController.text, whatsappLinkPrefix);
    if (whatsappFull != null) {
      metadata['whatsapp_group_link'] = whatsappFull;
    } else {
      metadata.remove('whatsapp_group_link');
    }
    final telegramFull = buildSocialFullUrl(_telegramLinkController.text, telegramLinkPrefix);
    if (telegramFull != null) {
      metadata['telegram_group_link'] = telegramFull;
    } else {
      metadata.remove('telegram_group_link');
    }

    // Flip into in-flight state BEFORE invoking the cubit so the
    // BlocListener's listenWhen sees _isLoading=true the moment the
    // first emit lands. Each save bumps _saveToken so a stale
    // success/error from a previous attempt can't dismiss/dirty the
    // sheet for a current one.
    setState(() {
      _isLoading = true;
      _saveToken++;
    });

    context.read<GroupAccountCubit>().updateGroupDetails(
          widget.group.copyWith(
            name: _nameController.text.trim(),
            description: _descriptionController.text.trim(),
            metadata: metadata,
          ),
        );
  }
}
