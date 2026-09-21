import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/p2p_chat/domain/repositories/p2p_chat_repository.dart';
import 'package:lazervault/src/features/sprayme/domain/entities/session_invite.dart';

/// Picking people to tag into a Lazerspray session.
///
/// Returns the chosen [SprayInvitee]s, or null if dismissed. It does NOT send
/// the invites itself: the create-session flow tags people only once the
/// session exists, and a sheet that had already sent them would leave invites
/// pointing at a session that was never created.
class TagPeopleSheet extends StatefulWidget {
  const TagPeopleSheet({
    super.key,
    this.alreadyTagged = const {},
    this.initialSelection = const [],
  });

  /// User ids already tagged into this session. Shown as such and not
  /// selectable — re-tagging is a server-side no-op, and offering it implies
  /// something will happen.
  final Set<String> alreadyTagged;

  /// Selections carried back in when the sheet is reopened mid-flow.
  final List<SprayInvitee> initialSelection;

  @override
  State<TagPeopleSheet> createState() => _TagPeopleSheetState();
}

class _TagPeopleSheetState extends State<TagPeopleSheet> {
  static const _bg = Color(0xFF1F1F1F);
  static const _card = Color(0xFF2A2A2C);
  static const _accent = Color(0xFFD946EF);

  final _controller = TextEditingController();
  final _selected = <String, SprayInvitee>{};

  List<Map<String, dynamic>> _results = const [];
  bool _searching = false;
  String? _error;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    for (final i in widget.initialSelection) {
      _selected[i.userId] = i;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onQueryChanged(String q) {
    _debounce?.cancel();
    // Debounced: a search per keystroke is a request per keystroke against the
    // user directory, and the answer for a half-typed name is never the one
    // wanted anyway.
    _debounce = Timer(const Duration(milliseconds: 350), () => _search(q));
  }

  Future<void> _search(String q) async {
    final query = q.trim();
    if (query.length < 2) {
      // One character matches most of the directory; the result is a long list
      // that is slower to read than typing another letter.
      setState(() {
        _results = const [];
        _error = null;
        _searching = false;
      });
      return;
    }
    setState(() {
      _searching = true;
      _error = null;
    });
    try {
      final users = await serviceLocator<P2PChatRepository>().searchUsers(query);
      if (!mounted) return;
      setState(() {
        _results = users;
        _searching = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not search right now. Check your connection.';
        _searching = false;
      });
    }
  }

  static String _nameOf(Map<String, dynamic> u) {
    for (final k in ['full_name', 'name', 'username', 'email']) {
      final v = (u[k] ?? '').toString().trim();
      if (v.isNotEmpty) return v;
    }
    return 'LazerVault user';
  }

  static String _idOf(Map<String, dynamic> u) =>
      (u['user_id'] ?? u['id'] ?? '').toString();

  void _toggle(Map<String, dynamic> u) {
    final id = _idOf(u);
    if (id.isEmpty || widget.alreadyTagged.contains(id)) return;
    HapticFeedback.selectionClick();
    setState(() {
      if (_selected.containsKey(id)) {
        _selected.remove(id);
      } else {
        _selected[id] = SprayInvitee(userId: id, name: _nameOf(u));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.78,
        decoration: BoxDecoration(
          color: _bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: _card,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Tag people',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'They will see this celebration on their own Lazerspray page.',
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 14.h),
            _searchField(),
            if (_selected.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _selectedChips(),
            ],
            SizedBox(height: 12.h),
            Expanded(child: _resultsList()),
            SizedBox(height: 8.h),
            _confirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _searchField() => TextField(
        controller: _controller,
        onChanged: _onQueryChanged,
        autofocus: true,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search by name, username or email',
          hintStyle:
              TextStyle(color: const Color(0xFF6B7280), fontSize: 13.5.sp),
          prefixIcon:
              Icon(Icons.search, color: const Color(0xFF9CA3AF), size: 20.sp),
          filled: true,
          fillColor: _card,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      );

  Widget _selectedChips() => Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: [
          for (final i in _selected.values)
            Chip(
              label: Text(i.name, style: TextStyle(fontSize: 12.sp)),
              backgroundColor: _accent.withValues(alpha: 0.16),
              labelStyle: const TextStyle(color: Colors.white),
              deleteIconColor: Colors.white70,
              onDeleted: () => setState(() => _selected.remove(i.userId)),
              side: BorderSide.none,
            ),
        ],
      );

  Widget _resultsList() {
    if (_searching) {
      return const Center(child: LazerVaultLoader.medium());
    }
    if (_error != null) {
      return _hint(_error!, retry: () => _search(_controller.text));
    }
    if (_controller.text.trim().length < 2) {
      return _hint('Start typing a name to find people.');
    }
    if (_results.isEmpty) {
      return _hint('Nobody matched that.');
    }
    return ListView.separated(
      itemCount: _results.length,
      separatorBuilder: (_, __) => SizedBox(height: 4.h),
      itemBuilder: (_, i) => _userTile(_results[i]),
    );
  }

  Widget _userTile(Map<String, dynamic> u) {
    final id = _idOf(u);
    final name = _nameOf(u);
    final tagged = widget.alreadyTagged.contains(id);
    final picked = _selected.containsKey(id);

    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
      onTap: tagged ? null : () => _toggle(u),
      leading: CircleAvatar(
        radius: 18.r,
        backgroundColor: _accent.withValues(alpha: 0.18),
        child: Text(
          name.isNotEmpty ? name[0].toUpperCase() : '?',
          style: TextStyle(color: Colors.white, fontSize: 14.sp),
        ),
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: tagged ? const Color(0xFF6B7280) : Colors.white,
          fontSize: 14.sp,
        ),
      ),
      subtitle: tagged
          ? Text('Already tagged',
              style: TextStyle(
                  color: const Color(0xFF6B7280), fontSize: 11.5.sp))
          : null,
      trailing: tagged
          ? Icon(Icons.check_circle,
              color: const Color(0xFF4B5563), size: 20.sp)
          : Icon(
              picked
                  ? Icons.check_circle_rounded
                  : Icons.radio_button_unchecked,
              color: picked ? _accent : const Color(0xFF4B5563),
              size: 20.sp,
            ),
    );
  }

  Widget _hint(String text, {VoidCallback? retry}) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            if (retry != null)
              TextButton(onPressed: retry, child: const Text('Try again')),
          ],
        ),
      );

  Widget _confirmButton() => SizedBox(
        width: double.infinity,
        height: 50.h,
        child: ElevatedButton(
          onPressed: _selected.isEmpty
              ? null
              : () => Navigator.of(context).pop(_selected.values.toList()),
          style: ElevatedButton.styleFrom(
            backgroundColor: _accent,
            disabledBackgroundColor: _accent.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            _selected.isEmpty
                ? 'Select people to tag'
                : 'Tag ${_selected.length} ${_selected.length == 1 ? "person" : "people"}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
}
