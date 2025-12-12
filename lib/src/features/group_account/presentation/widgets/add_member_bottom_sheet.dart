import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import 'contact_picker_bottom_sheet.dart';

class AddMemberBottomSheet extends StatefulWidget {
  final GroupAccount group;

  const AddMemberBottomSheet({
    super.key,
    required this.group,
  });

  @override
  State<AddMemberBottomSheet> createState() => _AddMemberBottomSheetState();
}

class _AddMemberBottomSheetState extends State<AddMemberBottomSheet>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _displayNameController = TextEditingController();
  GroupMemberRole _selectedRole = GroupMemberRole.member;
  bool _isLoading = false;
  late TabController _tabController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    _displayNameController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is GroupAccountSuccess) {
          setState(() => _isLoading = false);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
            ),
          );
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
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(),
            _buildTabs(),
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color.fromARGB(255, 78, 3, 208),
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(4.w),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[500],
        labelStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Email'),
          Tab(text: 'Username'),
          Tab(text: 'Contact'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_currentTab == 0) _buildEmailTab(),
            if (_currentTab == 1) _buildUsernameTab(),
            if (_currentTab == 2) _buildContactTab(),

            SizedBox(height: 20.h),
            _buildRoleSelection(),
            SizedBox(height: 32.h),
            _buildActionButtons(),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Can invite unregistered users - they\'ll receive an invite',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter member\'s email',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 78, 3, 208),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color(0xFFEF4444),
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            prefixIcon: Icon(
              Icons.email_outlined,
              color: Colors.grey[500],
              size: 20.sp,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email address';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Please enter a valid email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildUsernameTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Only for existing registered users on the platform',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _usernameController,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter username',
            hintStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[500],
            ),
            filled: true,
            fillColor: const Color(0xFF0A0A0A),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 78, 3, 208),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: const Color(0xFFEF4444),
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            prefixIcon: Icon(
              Icons.alternate_email,
              color: Colors.grey[500],
              size: 20.sp,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a username';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildContactTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Import from Contacts',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'Can invite unregistered users - they\'ll receive an invite',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: _openContactPicker,
          icon: Icon(
            Icons.contacts,
            color: const Color.fromARGB(255, 78, 3, 208),
            size: 20.sp,
          ),
          label: Text(
            'Select from Contacts',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: BorderSide(
              color: const Color.fromARGB(255, 78, 3, 208),
              width: 1.5,
            ),
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        if (_phoneController.text.isNotEmpty || _displayNameController.text.isNotEmpty) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 78, 3, 208),
                        const Color.fromARGB(255, 78, 3, 208).withOpacity(0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Center(
                    child: Text(
                      _displayNameController.text.isNotEmpty
                          ? _displayNameController.text[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _displayNameController.text.isNotEmpty
                            ? _displayNameController.text
                            : 'Selected Contact',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _emailController.text.isNotEmpty
                            ? _emailController.text
                            : _phoneController.text,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _phoneController.clear();
                      _emailController.clear();
                      _displayNameController.clear();
                    });
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildRoleSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Member Role',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Column(
          children: GroupMemberRole.values.map((role) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: _buildRoleOption(role),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: _isLoading ? null : () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: Colors.grey[700]!,
              ),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: ElevatedButton(
            onPressed: _isLoading ? null : _addMember,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 78, 3, 208),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              disabledBackgroundColor: Colors.grey[800],
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
                    'Add Member',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.person_add,
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
                  'Add Member',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Invite someone to ${widget.group.name}',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openContactPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ContactPickerBottomSheet(
        onContactSelected: (name, identifier, type) {
          setState(() {
            _displayNameController.text = name;
            if (type == ContactIdentifierType.email) {
              _emailController.text = identifier;
            } else {
              _phoneController.text = identifier;
            }
          });
        },
      ),
    );
  }

  Widget _buildRoleOption(GroupMemberRole role) {
    final isSelected = _selectedRole == role;
    
    Color backgroundColor;
    Color borderColor;
    String description;
    IconData icon;
    
    switch (role) {
      case GroupMemberRole.admin:
        backgroundColor = const Color(0xFFEF4444).withOpacity(0.1);
        borderColor = isSelected ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D);
        description = 'Full control over group settings and members';
        icon = Icons.admin_panel_settings;
        break;
      case GroupMemberRole.moderator:
        backgroundColor = const Color(0xFFF59E0B).withOpacity(0.1);
        borderColor = isSelected ? const Color(0xFFF59E0B) : const Color(0xFF2D2D2D);
        description = 'Can manage contributions and moderate discussions';
        icon = Icons.shield;
        break;
      case GroupMemberRole.member:
        backgroundColor = const Color(0xFF10B981).withOpacity(0.1);
        borderColor = isSelected ? const Color(0xFF10B981) : const Color(0xFF2D2D2D);
        description = 'Can view group content and make contributions';
        icon = Icons.person;
        break;
    }
    
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? backgroundColor : const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? (role == GroupMemberRole.admin 
                      ? const Color(0xFFEF4444)
                      : role == GroupMemberRole.moderator
                          ? const Color(0xFFF59E0B)
                          : const Color(0xFF10B981))
                  : Colors.grey[500],
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: role == GroupMemberRole.admin 
                    ? const Color(0xFFEF4444)
                    : role == GroupMemberRole.moderator
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFF10B981),
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  void _addMember() {
    // Validate based on current tab
    if (_currentTab == 0 && _emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter an email address'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_currentTab == 1 && _usernameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a username'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    if (_currentTab == 2 && _emailController.text.trim().isEmpty && _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a contact first'),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Determine display name
    String displayName = _displayNameController.text.trim();
    if (displayName.isEmpty) {
      if (_emailController.text.isNotEmpty) {
        displayName = _emailController.text.split('@')[0];
      } else if (_usernameController.text.isNotEmpty) {
        displayName = _usernameController.text;
      }
    }

    // Don't generate fake userId - let backend handle finding/creating user
    context.read<GroupAccountCubit>().addMemberToGroupAccount(
      groupId: widget.group.id,
      userId: '', // Empty - backend will use email/phone/username to find or create partial user
      userName: displayName,
      email: _emailController.text.trim(),
      role: _selectedRole,
    );
  }
} 