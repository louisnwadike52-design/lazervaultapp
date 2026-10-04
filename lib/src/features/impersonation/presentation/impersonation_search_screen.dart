import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

import '../data/impersonation_service.dart';

/// The admin's searchable directory for starting a read-only session.
///
/// Reachable only by an admin: the route is gated before push, and the two
/// endpoints behind it refuse anyone below `admin` anyway — so a user who
/// reaches this screen by any other means sees an empty list and a 403, not
/// a directory of everyone on the platform.
class ImpersonationSearchScreen extends StatefulWidget {
  const ImpersonationSearchScreen({super.key});

  @override
  State<ImpersonationSearchScreen> createState() =>
      _ImpersonationSearchScreenState();
}

class _ImpersonationSearchScreenState extends State<ImpersonationSearchScreen> {
  final TextEditingController _query = TextEditingController();
  Timer? _debounce;

  List<ImpersonationCandidate> _results = const [];
  bool _loading = true;
  String? _error;
  bool _starting = false;

  ImpersonationService get _service => GetIt.I<ImpersonationService>();

  @override
  void initState() {
    super.initState();
    // Load before anything is typed: the server orders by last sign-in, so the
    // first page is the people most likely to be the subject of a live support
    // conversation rather than whoever registered first.
    _run('');
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _query.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    // 350ms: long enough that typing an email is one request, short enough
    // that it does not feel laggy.
    _debounce = Timer(const Duration(milliseconds: 350), () => _run(value));
  }

  Future<void> _run(String q) async {
    if (!mounted) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final rows = await _service.search(query: q);
      if (!mounted) return;
      setState(() {
        _results = rows;
        _loading = false;
      });
    } on ImpersonationException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
        _results = const [];
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Server not reachable. Please try again shortly.';
        _loading = false;
        _results = const [];
      });
    }
  }

  Future<void> _confirmAndStart(ImpersonationCandidate c) async {
    // A confirmation step, not a straight tap.
    //
    // Opening someone else's account is audited under the admin's name, and a
    // mis-tap in a list of similar names would put them in the wrong person's
    // account without noticing. The sheet also states read-only up front, so
    // nobody starts a session expecting to fix something.
    final reasonController = TextEditingController();
    final go = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (sheetCtx) => Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          16.h,
          16.w,
          16.h + MediaQuery.of(sheetCtx).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('View ${c.displayName}?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 6.h),
            Text(
              'You will see their account exactly as they do. '
              'Everything is READ-ONLY — payments, transfers and any change '
              'are refused by the server. This is recorded against your '
              'account.',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.75), fontSize: 12.sp),
            ),
            SizedBox(height: 14.h),
            TextField(
              controller: reasonController,
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
              decoration: InputDecoration(
                labelText: 'Reason (optional)',
                labelStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12.sp),
                hintText: 'e.g. ticket #1423 — transfer stuck',
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 12.sp),
                filled: true,
                fillColor: const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(false),
                    child: const Text('Cancel'),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(sheetCtx).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFB45309),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('View account'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final reason = reasonController.text;
    reasonController.dispose();
    if (go != true || !mounted) return;

    setState(() => _starting = true);
    try {
      final started = await _service.start(c, reason: reason);
      if (!mounted) return;
      // The caller owns what happens next — it has to rebuild the app as the
      // target, because every screen on the stack was built from the admin's
      // data. Returning the result rather than navigating from here keeps this
      // screen reusable and testable.
      Navigator.of(context).pop(started);
    } on ImpersonationException catch (e) {
      if (!mounted) return;
      setState(() => _starting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red[700]),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _starting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not start the session.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        title: Text('View as user',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700)),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: TextField(
              controller: _query,
              onChanged: _onChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: _run,
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Search name, email, username or phone',
                hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 13.sp),
                prefixIcon: Icon(Icons.search,
                    color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
                suffixIcon: _query.text.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(Icons.close,
                            size: 18.sp,
                            color: Colors.white.withValues(alpha: 0.5)),
                        onPressed: () {
                          _query.clear();
                          _run('');
                        },
                      ),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(Icons.lock_outline,
                    size: 13.sp, color: Colors.white.withValues(alpha: 0.45)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Read-only. Every session is recorded against your account.',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.45),
                        fontSize: 10.sp),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_starting) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return _Message(
        icon: Icons.cloud_off,
        title: _error!,
        action: TextButton(
          onPressed: () => _run(_query.text),
          child: const Text('Try again'),
        ),
      );
    }
    if (_results.isEmpty) {
      return _Message(
        icon: Icons.person_search,
        title: _query.text.trim().isEmpty
            ? 'No users to show.'
            : 'No one matches “${_query.text.trim()}”.',
      );
    }
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 24.h),
      itemCount: _results.length,
      separatorBuilder: (_, __) => SizedBox(height: 6.h),
      itemBuilder: (context, i) => _Row(
        candidate: _results[i],
        onTap: () => _confirmAndStart(_results[i]),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.candidate, required this.onTap});

  final ImpersonationCandidate candidate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final blocked = !candidate.selectable;
    final initials = candidate.displayName.trim().isEmpty
        ? '?'
        : candidate.displayName
            .trim()
            .split(RegExp(r'\s+'))
            .take(2)
            .map((w) => w.characters.first.toUpperCase())
            .join();

    return Opacity(
      // A disabled row is SHOWN rather than hidden. Hiding it would read as
      // "that person doesn't exist"; greying it with a reason answers the
      // question the admin actually has.
      opacity: blocked ? 0.45 : 1,
      child: Material(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: blocked ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFF3A3A3A),
                    shape: BoxShape.circle,
                  ),
                  child: Text(initials,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700)),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              candidate.displayName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          if (candidate.highestRole.isNotEmpty &&
                              candidate.highestRole != 'user')
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: _Chip(text: candidate.highestRole),
                            ),
                          if (candidate.accountStatus != 'active')
                            Padding(
                              padding: EdgeInsets.only(left: 6.w),
                              child: _Chip(
                                  text: candidate.accountStatus,
                                  color: const Color(0xFF7F1D1D)),
                            ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        candidate.email.isNotEmpty
                            ? candidate.email
                            : (candidate.phone.isNotEmpty
                                ? candidate.phone
                                : candidate.id),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.55),
                            fontSize: 11.sp),
                      ),
                      if (blocked)
                        Padding(
                          padding: EdgeInsets.only(top: 3.h),
                          child: Text(
                            candidate.blockedReason,
                            style: TextStyle(
                                color: const Color(0xFFFCA5A5),
                                fontSize: 10.sp),
                          ),
                        ),
                    ],
                  ),
                ),
                if (!blocked)
                  Icon(Icons.chevron_right,
                      size: 18.sp, color: Colors.white.withValues(alpha: 0.4)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.text, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF3730A3),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(text.replaceAll('_', ' '),
          style: TextStyle(
              color: Colors.white,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _Message extends StatelessWidget {
  const _Message({required this.icon, required this.title, this.action});
  final IconData icon;
  final String title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 34.sp, color: Colors.white.withValues(alpha: 0.3)),
            SizedBox(height: 10.h),
            Text(title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12.sp)),
            if (action != null) ...[SizedBox(height: 6.h), action!],
          ],
        ),
      ),
    );
  }
}
