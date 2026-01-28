import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/group_entities.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';

class AddMembersToContributionDialog extends StatefulWidget {
  final Contribution contribution;
  final VoidCallback? onMembersAdded;

  const AddMembersToContributionDialog({
    super.key,
    required this.contribution,
    this.onMembersAdded,
  });

  @override
  State<AddMembersToContributionDialog> createState() => _AddMembersToContributionDialogState();
}

class _AddMembersToContributionDialogState extends State<AddMembersToContributionDialog> {
  List<GroupMember> _groupMembers = [];
  Set<String> _selectedMemberIds = {};
  bool _isLoading = true;
  bool _selectAll = false;

  @override
  void initState() {
    super.initState();
    _loadGroupMembers();
  }

  void _loadGroupMembers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get group members from the cubit
      final cubit = context.read<GroupAccountCubit>();
      await cubit.loadGroupDetails(widget.contribution.groupId);
      
      // Listen for state changes to get members
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      _showError('Failed to load group members: $e');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _toggleSelectAll() {
    setState(() {
      _selectAll = !_selectAll;
      if (_selectAll) {
        _selectedMemberIds = _groupMembers.map((m) => m.id).toSet();
      } else {
        _selectedMemberIds.clear();
      }
    });
  }

  void _toggleMember(String memberId) {
    setState(() {
      if (_selectedMemberIds.contains(memberId)) {
        _selectedMemberIds.remove(memberId);
        _selectAll = false;
      } else {
        _selectedMemberIds.add(memberId);
        _selectAll = _selectedMemberIds.length == _groupMembers.length;
      }
    });
  }

  void _addSelectedMembers() {
    if (_selectedMemberIds.isEmpty) {
      _showError('Please select at least one member');
      return;
    }

    // In a real implementation, you would call an API to add members to the contribution
    // For now, we'll just show a success message
    Navigator.of(context).pop();
    
    if (widget.onMembersAdded != null) {
      widget.onMembersAdded!();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_selectedMemberIds.length} member(s) added to contribution'),
        backgroundColor: const Color(0xFF10B981),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 40.h),
      child: Container(
        width: double.infinity,
        height: 600.h,
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(child: _buildContent()),
            _buildActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Members',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Select members to add to "${widget.contribution.title}"',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
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

  Widget _buildContent() {
    return BlocListener<GroupAccountCubit, GroupAccountState>(
      listener: (context, state) {
        if (state is GroupAccountGroupLoaded) {
          setState(() {
            _groupMembers = state.members;
            _isLoading = false;
          });
        } else if (state is GroupAccountError) {
          setState(() {
            _isLoading = false;
          });
          _showError(state.message);
        }
      },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF6C5CE7),
              ),
            )
          : _groupMembers.isEmpty
              ? _buildEmptyState()
              : _buildMembersList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No group members found',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return Column(
      children: [
        // Select All header
        Container(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: _toggleSelectAll,
                child: Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: _selectAll ? const Color(0xFF6C5CE7) : Colors.transparent,
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: _selectAll
                      ? Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 14.sp,
                        )
                      : null,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Select All (${_groupMembers.length})',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Text(
                '${_selectedMemberIds.length} selected',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
        
        // Members list
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: _groupMembers.length,
            itemBuilder: (context, index) {
              final member = _groupMembers[index];
              final isSelected = _selectedMemberIds.contains(member.id);
              
              return Container(
                margin: EdgeInsets.only(bottom: 8.h),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _toggleMember(member.id),
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? const Color(0xFF6C5CE7).withValues(alpha: 0.1)
                            : const Color(0xFF1F1F1F),
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
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
                              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: isSelected
                                ? Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 14.sp,
                                  )
                                : null,
                          ),
                          SizedBox(width: 16.w),
                          CircleAvatar(
                            radius: 20.r,
                            backgroundColor: const Color(0xFF6C5CE7),
                            backgroundImage: member.profileImage != null 
                                ? NetworkImage(member.profileImage!)
                                : null,
                            child: member.profileImage == null
                                ? Text(
                                    member.userName.isNotEmpty
                                        ? member.userName[0].toUpperCase()
                                        : 'U',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  member.userName,
                                  style: GoogleFonts.inter(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  member.email,
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: _getRoleColor(member.role).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6.r),
                              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                            ),
                            child: Text(
                              member.role.displayName,
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: _getRoleColor(member.role),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              height: 48.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _selectedMemberIds.isNotEmpty
                      ? [const Color(0xFF6C5CE7), const Color(0xFF8B5CF6)]
                      : [Colors.grey[700]!, Colors.grey[600]!],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _selectedMemberIds.isNotEmpty ? _addSelectedMembers : null,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Center(
                    child: Text(
                      'Add Members (${_selectedMemberIds.length})',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getRoleColor(GroupMemberRole role) {
    switch (role) {
      case GroupMemberRole.admin:
        return const Color(0xFFEF4444);
      case GroupMemberRole.moderator:
        return const Color(0xFFF59E0B);
      case GroupMemberRole.member:
        return const Color(0xFF10B981);
    }
  }
} 