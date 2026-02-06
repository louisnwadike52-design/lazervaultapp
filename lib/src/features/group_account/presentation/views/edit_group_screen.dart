import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class EditGroupScreen extends StatefulWidget {
  final GroupAccount group;

  const EditGroupScreen({
    super.key,
    required this.group,
  });

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _whatsappLinkController;
  late TextEditingController _telegramLinkController;
  late GroupAccountStatus _selectedStatus;
  bool _isLoading = false;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.group.name);
    _descriptionController = TextEditingController(text: widget.group.description);
    _whatsappLinkController = TextEditingController(text: widget.group.whatsappGroupLink ?? '');
    _telegramLinkController = TextEditingController(text: widget.group.telegramGroupLink ?? '');
    _selectedStatus = widget.group.status;

    _nameController.addListener(_onFieldChanged);
    _descriptionController.addListener(_onFieldChanged);
    _whatsappLinkController.addListener(_onFieldChanged);
    _telegramLinkController.addListener(_onFieldChanged);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _whatsappLinkController.dispose();
    _telegramLinkController.dispose();
    super.dispose();
  }

  void _onFieldChanged() {
    final hasChanges = _nameController.text != widget.group.name ||
        _descriptionController.text != widget.group.description ||
        _whatsappLinkController.text != (widget.group.whatsappGroupLink ?? '') ||
        _telegramLinkController.text != (widget.group.telegramGroupLink ?? '') ||
        _selectedStatus != widget.group.status;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => _handleBack(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Edit Group',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_hasChanges)
            TextButton(
              onPressed: _isLoading ? null : _saveChanges,
              child: Text(
                'Save',
                style: GoogleFonts.inter(
                  color: const Color.fromARGB(255, 78, 3, 208),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: BlocListener<GroupAccountCubit, GroupAccountState>(
        listener: (context, state) {
          if (state is GroupAccountLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is GroupAccountSuccess) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Group updated successfully'),
                backgroundColor: const Color(0xFF10B981),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                behavior: SnackBarBehavior.floating,
              ),
            );
            Get.back(result: true);
          } else if (state is GroupAccountError) {
            setState(() {
              _isLoading = false;
            });
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroupIcon(),
                  SizedBox(height: 32.h),
                  _buildNameField(),
                  SizedBox(height: 24.h),
                  _buildDescriptionField(),
                  SizedBox(height: 24.h),
                  _buildStatusSelector(),
                  SizedBox(height: 32.h),
                  _buildExternalLinksSection(),
                  SizedBox(height: 32.h),
                  _buildSaveButton(),
                  SizedBox(height: 16.h),
                  _buildDeleteButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupIcon() {
    return Center(
      child: Container(
        width: 80.w,
        height: 80.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 78, 3, 208),
              const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Center(
          child: Text(
            _nameController.text.isNotEmpty ? _nameController.text[0].toUpperCase() : 'G',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Group Name',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _nameController,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter group name',
            hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
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
              borderSide: const BorderSide(
                color: Color(0xFFEF4444),
                width: 1,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please enter a group name';
            }
            if (value.trim().length < 3) {
              return 'Group name must be at least 3 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _descriptionController,
          style: GoogleFonts.inter(color: Colors.white),
          maxLines: 4,
          decoration: InputDecoration(
            hintText: 'Describe your group',
            hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 78, 3, 208),
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Status',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Column(
            children: GroupAccountStatus.values.map((status) {
              final isSelected = _selectedStatus == status;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedStatus = status;
                  });
                  _onFieldChanged();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: status != GroupAccountStatus.values.last
                          ? BorderSide(color: Colors.grey[800]!, width: 0.5)
                          : BorderSide.none,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: _getStatusColor(status),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getStatusLabel(status),
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              _getStatusDescription(status),
                              style: GoogleFonts.inter(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: const Color.fromARGB(255, 78, 3, 208),
                          size: 24.sp,
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _hasChanges && !_isLoading ? _saveChanges : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 78, 3, 208),
          disabledBackgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                'Save Changes',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: _showDeleteConfirmation,
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFFEF4444),
          side: const BorderSide(color: Color(0xFFEF4444)),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Delete Group',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildExternalLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.link,
              color: const Color.fromARGB(255, 78, 3, 208),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'External Social Media Links',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          'Link your group to external WhatsApp or Telegram groups for easy member access',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildLinkField(
          controller: _whatsappLinkController,
          label: 'WhatsApp Group Link',
          hint: 'https://chat.whatsapp.com/...',
          icon: Icons.message,
          color: const Color(0xFF25D366),
        ),
        SizedBox(height: 16.h),
        _buildLinkField(
          controller: _telegramLinkController,
          label: 'Telegram Group Link',
          hint: 'https://t.me/...',
          icon: Icons.send,
          color: const Color(0xFF0088CC),
        ),
      ],
    );
  }

  Widget _buildLinkField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          style: GoogleFonts.inter(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: color,
                width: 2,
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
            suffixIcon: controller.text.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                    onPressed: () {
                      controller.clear();
                    },
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return const Color(0xFF10B981);
      case GroupAccountStatus.suspended:
        return const Color(0xFFFB923C);
      case GroupAccountStatus.deleted:
        return const Color(0xFFEF4444);
    }
  }

  String _getStatusLabel(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return 'Active';
      case GroupAccountStatus.suspended:
        return 'Suspended';
      case GroupAccountStatus.deleted:
        return 'Closed';
    }
  }

  String _getStatusDescription(GroupAccountStatus status) {
    switch (status) {
      case GroupAccountStatus.active:
        return 'Group is active and members can contribute';
      case GroupAccountStatus.suspended:
        return 'Group is paused, no new contributions allowed';
      case GroupAccountStatus.deleted:
        return 'Group is closed and cannot be reactivated';
    }
  }

  void _handleBack() {
    if (_hasChanges) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: Text(
            'Discard Changes?',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          content: Text(
            'You have unsaved changes. Are you sure you want to discard them?',
            style: GoogleFonts.inter(color: Colors.grey[300]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Keep Editing',
                style: GoogleFonts.inter(color: Colors.grey[400]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Get.back();
              },
              child: Text(
                'Discard',
                style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
              ),
            ),
          ],
        ),
      );
    } else {
      Get.back();
    }
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Build metadata with external links
      final metadata = Map<String, dynamic>.from(widget.group.metadata ?? {});

      // Update WhatsApp link
      if (_whatsappLinkController.text.trim().isNotEmpty) {
        metadata['whatsapp_group_link'] = _whatsappLinkController.text.trim();
      } else {
        metadata.remove('whatsapp_group_link');
      }

      // Update Telegram link
      if (_telegramLinkController.text.trim().isNotEmpty) {
        metadata['telegram_group_link'] = _telegramLinkController.text.trim();
      } else {
        metadata.remove('telegram_group_link');
      }

      // Create updated group object
      final updatedGroup = widget.group.copyWith(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        status: _selectedStatus,
        metadata: metadata,
      );

      context.read<GroupAccountCubit>().updateGroupDetails(updatedGroup);
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Delete Group?',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'This action cannot be undone. All contributions and payment history will be lost.',
          style: GoogleFonts.inter(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<GroupAccountCubit>().deleteGroupAccount(widget.group.id);
              Get.back(result: 'deleted');
            },
            child: Text(
              'Delete',
              style: GoogleFonts.inter(color: const Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }
}
