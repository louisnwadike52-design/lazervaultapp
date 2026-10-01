import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/data/repositories/unified_user_search_repository.dart';
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
      // The SAME search Select Recipients uses.
      //
      // This sheet had its own via P2PChatRepository.searchUsers, which looks at
      // chat contacts rather than the platform directory — so the people a host
      // could tag were a different, smaller set than the people they could send
      // money to, for no reason a user could infer. One directory, one ranking,
      // one set of results.
      //
      // internalOnly: a tagged person has to be able to OPEN the session on
      // their own Lazerspray page, which an external bank recipient cannot do.
      final page = await serviceLocator<UnifiedUserSearchRepository>()
          .search(query, internalOnly: true);
      if (!mounted) return;
      final users = [
        for (final r in [...page.local, ...page.global])
          if (r.userId.isNotEmpty)
            <String, dynamic>{
              'user_id': r.userId,
              'id': r.userId,
              'full_name': r.displayName.isNotEmpty ? r.displayName : r.name,
              'name': r.name,
              'username': r.username,
              'email': r.email,
              'profile_picture': r.profilePicture,
            },
      ];
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
    return 'Lazervault user';
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
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
            // A heading with an icon and a running count, rather than a bare
            // line of text. The sheet is a picker — the number chosen is the
            // single thing a user checks before confirming, and it was only
            // visible on the button at the far bottom of a 78%-height sheet.
            Row(
              children: [
                Container(
                  width: 34.w,
                  height: 34.w,
                  decoration: BoxDecoration(
                    color: _accent.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child:
                      Icon(Icons.person_add_alt_1, color: _accent, size: 18.sp),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Tag people',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'They will see this celebration on their own '
                        'Lazerspray page.',
                        style: TextStyle(
                            color: const Color(0xFF9CA3AF), fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                if (_selected.isNotEmpty)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: _accent.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text('${_selected.length}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w700)),
                  ),
              ],
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
        textInputAction: TextInputAction.search,
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
        decoration: InputDecoration(
          hintText: 'Search by name, username or email',
          hintStyle:
              TextStyle(color: const Color(0xFF6B7280), fontSize: 13.5.sp),
          prefixIcon:
              Icon(Icons.search, color: const Color(0xFF9CA3AF), size: 20.sp),
          // Clearing a query took selecting the whole field and deleting it.
          // On a search that needs two characters before it does anything,
          // starting over is a common move.
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  icon: Icon(Icons.close,
                      color: const Color(0xFF9CA3AF), size: 18.sp),
                  onPressed: () {
                    _controller.clear();
                    _onQueryChanged('');
                    setState(() {});
                  },
                ),
          filled: true,
          fillColor: _card,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          // A focused field that looks identical to an unfocused one gives no
          // sign the keyboard is going anywhere.
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: _accent.withValues(alpha: 0.7)),
          ),
        ),
      );

  /// The people picked so far, in a single scrolling row.
  ///
  /// This was a Wrap, so twenty selections became five rows of chips that ate
  /// the results list they were being chosen from — the sheet got less usable
  /// the more it was used. One row that scrolls keeps the height fixed however
  /// many people are tagged.
  Widget _selectedChips() => SizedBox(
        height: 36.h,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _selected.length,
          separatorBuilder: (_, __) => SizedBox(width: 8.w),
          itemBuilder: (_, idx) {
            final i = _selected.values.elementAt(idx);
            return Container(
              padding: EdgeInsets.only(left: 10.w, right: 4.w),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(18.r),
                border: Border.all(color: _accent.withValues(alpha: 0.35)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    i.name,
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints:
                        BoxConstraints(minWidth: 28.w, minHeight: 28.w),
                    icon: Icon(Icons.close,
                        size: 14.sp, color: Colors.white70),
                    onPressed: () =>
                        setState(() => _selected.remove(i.userId)),
                  ),
                ],
              ),
            );
          },
        ),
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

    final avatar = (u['profile_picture'] ?? '').toString();
    final username = (u['username'] ?? '').toString().trim();

    // A selected row is a filled card, not just a changed tick.
    //
    // Selection used to be a 20px icon at the right edge of an otherwise
    // identical row: on a list of a dozen similar names, checking who you had
    // picked meant reading every trailing icon. The whole row carries the
    // state now.
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      decoration: BoxDecoration(
        color: picked ? _accent.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: picked ? _accent.withValues(alpha: 0.45) : Colors.transparent,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        onTap: tagged ? null : () => _toggle(u),
        leading: CircleAvatar(
          radius: 19.r,
          backgroundColor: _accent.withValues(alpha: 0.18),
          // Use the real picture when the directory gave us one — initials on
          // every row makes a list of people look like a list of records.
          backgroundImage: avatar.isNotEmpty ? NetworkImage(avatar) : null,
          child: avatar.isNotEmpty
              ? null
              : Text(
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
            fontWeight: picked ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        // The username disambiguates two people with the same display name,
        // which the directory certainly contains and this list could not tell
        // apart at all.
        subtitle: tagged
            ? Text('Already tagged',
                style: TextStyle(
                    color: const Color(0xFF6B7280), fontSize: 11.5.sp))
            : (username.isEmpty
                ? null
                : Text('@$username',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: const Color(0xFF6B7280), fontSize: 11.5.sp))),
        trailing: tagged
            ? Icon(Icons.check_circle,
                color: const Color(0xFF4B5563), size: 20.sp)
            : Icon(
                picked
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked,
                color: picked ? _accent : const Color(0xFF4B5563),
                size: 22.sp,
              ),
      ),
    );
  }

  Widget _hint(String text, {VoidCallback? retry}) => Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                retry != null
                    ? Icons.cloud_off_rounded
                    : Icons.person_search_rounded,
                size: 34.sp,
                color: const Color(0xFF3A3A3A),
              ),
              SizedBox(height: 10.h),
              Text(
                text,
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
              ),
              if (retry != null)
                TextButton(
                  onPressed: retry,
                  child: Text('Try again',
                      style: TextStyle(color: _accent, fontSize: 13.sp)),
                ),
            ],
          ),
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
