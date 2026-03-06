import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Modal bottom sheet showing user search results during voice sessions.
/// User taps a result to select the recipient.
class VoiceUserSearchDialog extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  final String query;
  final void Function(String userId, String username) onUserSelected;
  final VoidCallback onCancel;

  const VoiceUserSearchDialog({
    super.key,
    required this.users,
    required this.query,
    required this.onUserSelected,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.5),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 16.h),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Icon(Icons.person_search_rounded, color: const Color(0xFF3B82F6), size: 24.sp),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Select Recipient',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onCancel,
                  child: Icon(Icons.close, color: const Color(0xFF9CA3AF), size: 22.sp),
                ),
              ],
            ),
          ),

          if (query.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 54.w, top: 4.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Results for "$query"',
                  style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF)),
                ),
              ),
            ),

          SizedBox(height: 12.h),

          Divider(color: const Color(0xFF2D2D2D), height: 1),

          // User list
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 8.h),
              itemCount: users.length,
              separatorBuilder: (_, __) => Divider(
                color: const Color(0xFF2D2D2D),
                height: 1,
                indent: 60.w,
              ),
              itemBuilder: (context, index) {
                final user = users[index];
                final username = user['username'] as String? ?? '';
                final fullName = user['full_name'] as String? ?? username;
                final userId = user['user_id'] as String? ?? '';

                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
                  leading: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    child: Text(
                      fullName.isNotEmpty ? fullName[0].toUpperCase() : '?',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF3B82F6),
                      ),
                    ),
                  ),
                  title: Text(
                    fullName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: username.isNotEmpty
                      ? Text(
                          '@$username',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            color: const Color(0xFF9CA3AF),
                          ),
                        )
                      : null,
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                  onTap: () => onUserSelected(userId, username),
                );
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).padding.bottom + 8.h),
        ],
      ),
    );
  }
}
