part of 'tag_pay_home_screen.dart';

class TagPayHomeScreen extends StatefulWidget {
  const TagPayHomeScreen({super.key});

  @override
  State<TagPayHomeScreen> createState() => _TagPayHomeScreenState();
}

class _TagPayHomeScreenState extends State<TagPayHomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TagPayCubit>()..loadHomeData(),
      child: const _TagPayHomeView(),
    );
  }
}

class _TagPayHomeView extends StatefulWidget {
  const _TagPayHomeView();

  @override
  State<_TagPayHomeView> createState() => _TagPayHomeViewState();
}

class _SetUsernameSheet extends StatefulWidget {
  const _SetUsernameSheet();

  @override
  State<_SetUsernameSheet> createState() => _SetUsernameSheetState();
}

class _SetUsernameSheetState extends State<_SetUsernameSheet> {
  final _controller = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    final username = _controller.text.trim();
    if (username.isEmpty) return;

    setState(() => _isLoading = true);

    context.read<ProfileCubit>().updateUserProfile(username: username);

    // Same pattern as edit_profile_dialog: close after short delay
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D3D3D),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Set Your Username',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose a unique username for your Lazertag. Others can use this to send you money or tag you.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            TextField(
              controller: _controller,
              enabled: !_isLoading,
              autofocus: true,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Enter username',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 16.sp,
                ),
                prefixText: '@ ',
                prefixStyle: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              ),
              onSubmitted: (_) => _handleSave(),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSave,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  disabledBackgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 0,
                ),
                child: _isLoading
                    ? LazerVaultLoader(size: 22)
                    : Text(
                        'Set Username',
                        style: GoogleFonts.inter(
                          color: Colors.white,
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
    );
  }
}
