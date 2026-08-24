import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:permission_handler/permission_handler.dart' show openAppSettings;

import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/features/contacts/domain/usecases/find_lazervault_users_usecase.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/unified_user_search_cubit.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';
part 'unified_user_search_sheet_widgets.dart';


/// THE shared user-search bottom sheet for the whole app.
///
/// Local-first → global: the caller's saved recipients (alias-aware, so
/// "send to Mum" resolves the nickname) appear first under "Your contacts",
/// then the global directory under "Everyone else". Paginated (scroll to load
/// more), 90% screen height, polished header.
///
/// Returns the picked [UnifiedSearchResult] (or null if dismissed). Callers
/// adapt with `.toUserSearchResultEntity()` / `.toRecipientModel()`.
class UnifiedUserSearchSheet extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String? initialQuery;
  final ValueChanged<UnifiedSearchResult> onSelected;

  /// When true, only recipients that are Lazervault users (non-empty userId)
  /// are shown/selectable — external bank recipients are hidden. Used by flows
  /// that can ONLY pay a Lazervault account (e.g. crypto send, which routes an
  /// internal Quidax sub→sub transfer keyed on the recipient's userId). This is
  /// the crypto "variant" of the shared sheet.
  final bool internalOnly;

  const UnifiedUserSearchSheet({
    super.key,
    required this.onSelected,
    this.title = 'Find recipient',
    this.subtitle,
    this.initialQuery,
    this.internalOnly = false,
  });

  /// Opens the sheet and resolves to the picked result (null if dismissed).
  ///
  /// Presented with [showModalBottomSheet] (like `BankPickerSheet`) so the
  /// sheet stays a FIXED height and the keyboard OVERLAYS it — rather than
  /// GetX's bottom-sheet route lifting the whole sheet up the screen. The pick
  /// pops the modal route with the value, resolving this future directly.
  static Future<UnifiedSearchResult?> show(
    BuildContext context, {
    String title = 'Find recipient',
    String? subtitle,
    String? initialQuery,
    bool internalOnly = false,
  }) {
    return showModalBottomSheet<UnifiedSearchResult>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => UnifiedUserSearchSheet(
        title: title,
        subtitle: subtitle,
        initialQuery: initialQuery,
        internalOnly: internalOnly,
        onSelected: (r) => Navigator.pop(sheetCtx, r),
      ),
    );
  }

  @override
  State<UnifiedUserSearchSheet> createState() => _UnifiedUserSearchSheetState();
}

class _UnifiedUserSearchSheetState extends State<UnifiedUserSearchSheet>
    with WidgetsBindingObserver {
  late final UnifiedUserSearchCubit _cubit;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scroll = ScrollController();
  final FocusNode _focus = FocusNode();

  // Grows the sheet from 75% → 85% of the screen once the user starts typing
  // (in either the "Search Lazervault" or "From contacts" tab), so more results
  // are visible before scrolling. Flipped in [_onQueryChanged]; reset when the
  // query is cleared or the mode toggles.
  bool _hasQuery = false;

  static const _brand = Color(0xFF4E03D0);
  static const _green = Color(0xFF10B981);

  // ---- Device-contacts mode -------------------------------------------------
  // Two distinct surfaces share this sheet: the default backend directory
  // search (any Lazervault user by name/alias/username/phone/email) and a
  // "From contacts" mode that reads the phone's address book and badges each
  // entry as on-Lazervault (selectable) or not (Invite). They are kept separate
  // so neither leaks into the other.
  bool _contactsMode = false;
  bool _loadingContacts = false;
  String? _contactsError;
  // When contact permission isn't granted we show a "Grant access" CTA (or
  // "Open settings" when the OS won't prompt again) instead of a bare Retry.
  bool _needsContactPermission = false;
  bool _contactPermPermanentlyDenied = false;
  List<_ContactRow> _contactRows = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = serviceLocator<UnifiedUserSearchCubit>();
    // Scope the shared cubit to this sheet's mode so the backend returns only
    // LazerVault users (no saved external bank recipients) in person-search.
    _cubit.internalOnly = widget.internalOnly;
    _scroll.addListener(_onScroll);
    if ((widget.initialQuery ?? '').trim().isNotEmpty) {
      _controller.text = widget.initialQuery!.trim();
      _hasQuery = true; // open already-expanded when seeded with a query
      _cubit.onQueryChanged(_controller.text);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scroll.removeListener(_onScroll);
    _scroll.dispose();
    _controller.dispose();
    _focus.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Returning from the OS settings page: if the user was blocked on contact
    // permission and is on the contacts tab, re-check + load automatically.
    if (state == AppLifecycleState.resumed &&
        _contactsMode &&
        _needsContactPermission) {
      _fetchContacts();
    }
  }

  void _onScroll() {
    if (_scroll.position.pixels >=
        _scroll.position.maxScrollExtent - 300) {
      _cubit.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Height grows 75% → 90% once the user starts typing (either tab) so more
    // results show before scrolling; it animates smoothly via AnimatedContainer.
    // Because we're presented via showModalBottomSheet (not GetX), the keyboard
    // OVERLAYS this fixed sheet instead of pushing it up the screen — the header
    // + search field stay put and the list simply gets covered from the bottom.
    // No viewInsets math.
    return BlocProvider.value(
      value: _cubit,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        height:
            MediaQuery.of(context).size.height * (_hasQuery ? 0.90 : 0.75),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _contactsMode
                  ? _buildContactsBody()
                  : BlocBuilder<UnifiedUserSearchCubit, UnifiedUserSearchState>(
                      builder: (context, state) => _buildBody(state),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final subtitle = (widget.subtitle ?? '').trim();
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 8.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 14.h),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          // Title + close on one line. The long default subtitle was removed to
          // keep the header compact (matching the bank-picker sheet); a caller
          // may still pass its own short subtitle, which renders below.
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  widget.title,
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(Icons.close, size: 22.w, color: Colors.grey[700]),
              ),
            ],
          ),
          if (subtitle.isNotEmpty) ...[
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
          SizedBox(height: 12.h),
          _buildSearchField(),
          SizedBox(height: 10.h),
          _buildModeToggle(),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }

  /// Two-segment switch: search the Lazervault directory vs read the phone's
  /// contacts. Distinct CTAs so "find a user" and "find from contacts" never
  /// blur together (the contacts side adds the invite path).
  Widget _buildModeToggle() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _modeSegment(
            label: 'Search Lazervault',
            icon: Icons.search,
            selected: !_contactsMode,
            onTap: _exitContactsMode,
          ),
          _modeSegment(
            label: 'From contacts',
            icon: Icons.contacts_outlined,
            selected: _contactsMode,
            onTap: _enterContactsMode,
          ),
        ],
      ),
    );
  }

  Widget _modeSegment({
    required String label,
    required IconData icon,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(vertical: 9.h),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 16.w,
                  color: selected ? _brand : Colors.grey[600]),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12.5.sp,
                    fontWeight: FontWeight.w600,
                    color: selected ? Colors.black87 : Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onQueryChanged(String value) {
    // Grow the sheet to 85% as soon as there's a query (so more results are
    // visible before scrolling); shrink back to 75% when it's cleared.
    final hasQuery = value.trim().isNotEmpty;
    final growthChanged = hasQuery != _hasQuery;
    _hasQuery = hasQuery;
    if (_contactsMode) {
      setState(() {}); // local filter over loaded contacts (also resizes sheet)
    } else {
      if (growthChanged) setState(() {}); // resize the sheet
      _cubit.onQueryChanged(value);
    }
  }

  Widget _buildSearchField() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: TextField(
        controller: _controller,
        focusNode: _focus,
        style: GoogleFonts.inter(fontSize: 15.sp, color: Colors.black87),
        textInputAction: TextInputAction.search,
        onChanged: _onQueryChanged,
        decoration: InputDecoration(
          hintText: _contactsMode
              ? 'Filter your contacts'
              : 'Name, alias, username, phone or email',
          // Smaller hint + tighter icon box so the long hint stays on one line.
          hintStyle: GoogleFonts.inter(
              fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
          prefixIcon: Icon(Icons.search, size: 18.w, color: Colors.grey[500]),
          prefixIconConstraints: BoxConstraints(minWidth: 38.w, minHeight: 38.w),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (_, value, __) => value.text.isEmpty
                ? const SizedBox.shrink()
                : IconButton(
                    icon: Icon(Icons.clear,
                        size: 18.w, color: Colors.grey[500]),
                    onPressed: () {
                      _controller.clear();
                      // Shrink back to 75% and rebuild (contacts re-filter over
                      // the now-empty query; directory results reset below).
                      setState(() => _hasQuery = false);
                      if (!_contactsMode) _cubit.reset();
                    },
                  ),
          ),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        ),
      ),
    );
  }

  Widget _buildBody(UnifiedUserSearchState state) {
    switch (state.status) {
      case UnifiedSearchStatus.initial:
        return _hint(Icons.person_search_outlined,
            'Search for a contact or anyone on Lazervault');
      case UnifiedSearchStatus.loading:
        return const Center(child: LazerVaultLoader.small());
      case UnifiedSearchStatus.error:
        return _hint(Icons.error_outline,
            state.error ?? 'Something went wrong', isError: true);
      case UnifiedSearchStatus.success:
      case UnifiedSearchStatus.loadingMore:
        if (state.results.isEmpty) {
          return _hint(Icons.search_off,
              'No matches for “${state.query}”');
        }
        return _buildList(state);
    }
  }

  Widget _buildList(UnifiedUserSearchState state) {
    // Edge case: a short first page (e.g. 5 results) doesn't fill the sheet, so
    // there's nothing to scroll and load-more can never fire. If more exist,
    // pull the next page automatically until the list is scrollable or dry.
    if (state.hasMore && state.status == UnifiedSearchStatus.success) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted &&
            _scroll.hasClients &&
            _scroll.position.maxScrollExtent <= 0) {
          _cubit.loadMore();
        }
      });
    }
    final loadingMore = state.status == UnifiedSearchStatus.loadingMore;
    // Split results into the "Your contacts" (local/saved) and "Everyone else"
    // (global directory) segments. In internalOnly mode we drop any recipient
    // that isn't a Lazervault user (empty userId) — e.g. saved external bank
    // beneficiaries — since those can't receive crypto.
    final localAll = state.results.take(state.localCount).toList();
    final globalAll = state.results.skip(state.localCount).toList();
    final local =
        widget.internalOnly ? localAll.where(_canReceive).toList() : localAll;
    final global =
        widget.internalOnly ? globalAll.where(_canReceive).toList() : globalAll;

    // Everything was filtered out (internalOnly and no Lazervault matches):
    // show the empty state rather than two bare section headers.
    if (widget.internalOnly &&
        local.isEmpty &&
        global.isEmpty &&
        state.status == UnifiedSearchStatus.success) {
      return _hint(Icons.search_off,
          'No Lazervault user found for “${state.query}”');
    }

    final children = <Widget>[];
    if (local.isNotEmpty) {
      children.add(_sectionHeader('Your contacts'));
      for (final r in local) {
        children.add(_resultTile(r));
      }
    }
    if (global.isNotEmpty) {
      children.add(_sectionHeader('Everyone else'));
      for (final r in global) {
        children.add(_resultTile(r));
      }
    }
    if (loadingMore) {
      children.add(Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: const Center(child: LazerVaultLoader.small()),
      ));
    }
    children.add(SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h));

    return ListView(
      controller: _scroll,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: children,
    );
  }

  /// A recipient can receive an internal (Lazervault-user) transfer only when
  /// it resolves to a real user account — i.e. a non-empty userId. External
  /// bank beneficiaries come back with an empty userId and are excluded in
  /// internalOnly mode.
  bool _canReceive(UnifiedSearchResult r) => r.userId.trim().isNotEmpty;

  Widget _sectionHeader(String label) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 16.h, 4.w, 8.h),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
          color: Colors.grey[500],
        ),
      ),
    );
  }

  Widget _resultTile(UnifiedSearchResult r) {
    return InkWell(
      onTap: () => widget.onSelected(r),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        child: Row(
          children: [
            _avatar(r),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          r.displayName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      if (r.isSavedHit) ...[
                        SizedBox(width: 6.w),
                        _savedBadge(r),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _subtitleFor(r),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: 20.w, color: Colors.grey[350]),
          ],
        ),
      ),
    );
  }

  Widget _savedBadge(UnifiedSearchResult r) {
    final isAlias = r.aliasMatched || r.alias.isNotEmpty;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: _brand.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isAlias ? Icons.bookmark : Icons.star,
              size: 11.w, color: _brand),
          SizedBox(width: 3.w),
          Text(
            isAlias ? 'Alias' : 'Saved',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: _brand,
            ),
          ),
        ],
      ),
    );
  }

  /// Secondary line: for a saved alias hit show the real name; otherwise the
  /// best identifier (@username, masked phone/email, or bank • account).
  String _subtitleFor(UnifiedSearchResult r) {
    final bits = <String>[];
    if (r.isSavedHit && r.alias.isNotEmpty && r.name.isNotEmpty &&
        r.name.toLowerCase() != r.displayName.toLowerCase()) {
      bits.add(r.name);
    }
    if (r.username.isNotEmpty) {
      bits.add('@${r.username}');
    } else if (r.phoneNumber.isNotEmpty) {
      bits.add(r.phoneNumber);
    } else if (r.email.isNotEmpty) {
      bits.add(r.email);
    } else if (r.accountNumber.isNotEmpty) {
      final bank = r.bankName.isNotEmpty ? r.bankName : 'Bank';
      bits.add('$bank • ${r.accountNumber}');
    }
    if (bits.isEmpty) {
      bits.add(r.isLazervault ? 'Lazervault user' : 'Recipient');
    }
    return bits.join('  •  ');
  }

  Widget _avatar(UnifiedSearchResult r) {
    final initials = _initials(r.displayName.isNotEmpty ? r.displayName : r.name);
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: _brand.withValues(alpha: 0.10),
        shape: BoxShape.circle,
        image: r.profilePicture.isNotEmpty
            ? DecorationImage(
                image: _avatarImage(r.profilePicture), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: r.profilePicture.isNotEmpty
          ? null
          : Text(
              initials,
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: _brand,
              ),
            ),
    );
  }

  /// Target decode size (physical px) for the 44.w list avatars. Decoding a
  /// full-resolution profile photo (often 1000px+) for a 44px circle wastes a
  /// lot of memory — multiplied across a scrolling list of results/contacts it
  /// balloons the image cache. ResizeImage decodes to ~display size instead.
  int get _avatarCachePx {
    final dpr = MediaQuery.maybeOf(context)?.devicePixelRatio ?? 2.5;
    return (48 * dpr).round(); // 48.logical ≥ 44.w avatar, crisp on all DPRs
  }

  ImageProvider _avatarImage(String url) =>
      ResizeImage(NetworkImage(url), width: _avatarCachePx, height: _avatarCachePx);

  String _initials(String name) {
    final parts =
        name.trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) {
      return parts.first.characters.take(2).toString().toUpperCase();
    }
    return (parts.first.characters.first + parts[1].characters.first)
        .toUpperCase();
  }

  Widget _hint(IconData icon, String text, {bool isError = false}) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                size: 48.w,
                color: isError ? const Color(0xFFEF4444) : Colors.grey[400]),
            SizedBox(height: 12.h),
            Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: isError ? const Color(0xFFEF4444) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // Device-contacts mode
  // ===========================================================================

  void _enterContactsMode() {
    if (_contactsMode) return;
    _focus.unfocus();
    _controller.clear();
    setState(() {
      _contactsMode = true;
      _contactsError = null;
      _hasQuery = false; // cleared query → back to 75% until they type again
    });
    // Load once; reopening the tab keeps the already-resolved list.
    if (_contactRows.isEmpty && !_loadingContacts) _fetchContacts();
  }

  void _exitContactsMode() {
    if (!_contactsMode) return;
    _controller.clear();
    _cubit.reset();
    setState(() {
      _contactsMode = false;
      _hasQuery = false; // cleared query → back to 75% until they type again
    });
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _loadingContacts = true;
      _contactsError = null;
      _needsContactPermission = false;
    });
    final svc = serviceLocator<ContactService>();
    try {
      // Gate on permission FIRST: reading contacts without it returns an empty
      // list, which used to render as "no contacts". If it isn't granted, ask
      // for it inline (the OS prompt) and branch on the precise outcome so the
      // UI can offer the right action (grant vs open settings).
      if (!await svc.hasPermission()) {
        final res = await svc.requestPermissionDetailed();
        if (res != ContactPermissionResult.granted) {
          if (!mounted) return;
          final permanent = res == ContactPermissionResult.permanentlyDenied;
          setState(() {
            _loadingContacts = false;
            _contactRows = [];
            _needsContactPermission = true;
            _contactPermPermanentlyDenied = permanent;
            _contactsError = permanent
                ? 'Contact access is turned off. Turn it on in Settings to find people you know on Lazervault.'
                : 'Allow access to your contacts to quickly find people you know on Lazervault.';
          });
          return;
        }
      }

      // Bound the device-contacts read: on a huge address book (or a wedged
      // plugin channel) this could otherwise never return and leave the spinner
      // stuck. A timeout surfaces the friendly error via the outer catch.
      final contacts = await svc
          .getContactsWithPhone()
          .timeout(const Duration(seconds: 20));
      if (contacts.isEmpty) {
        if (!mounted) return;
        setState(() {
          _loadingContacts = false;
          _contactRows = [];
          _contactsError =
              'No contacts with a phone number were found on this device.';
        });
        return;
      }
      // One bulk match against Lazervault (all phones + emails on file).
      final phones = <String>[];
      final emails = <String>[];
      for (final c in contacts) {
        phones.addAll(c.phoneNumbers);
        if ((c.email ?? '').isNotEmpty) emails.add(c.email!);
      }
      List<LazerVaultUserMatchModel> matches = const [];
      try {
        // Bounded: a hung gRPC match (no deadline on the wire) must NOT freeze
        // the contacts spinner. On timeout/failure we simply fall through with
        // no matches — every contact then shows "Invite" (best-effort).
        matches = await serviceLocator<FindLazerVaultUsersUseCase>()(
          phoneNumbers: phones,
          emails: emails,
        ).timeout(const Duration(seconds: 15));
      } catch (_) {/* best-effort; unmatched contacts simply show "Invite" */}

      // The match doesn't echo the phone/email it hit, so correlate back to a
      // device contact by normalized name (best-effort). Unmatched → Invite.
      final byName = <String, LazerVaultUserMatchModel>{};
      for (final m in matches) {
        final k = m.name.trim().toLowerCase();
        if (k.isNotEmpty) byName[k] = m;
      }
      final rows = contacts
          .map((c) => _ContactRow(c, byName[c.name.trim().toLowerCase()]))
          .toList()
        // On-Lazervault contacts first, then alphabetical.
        ..sort((a, b) {
          if (a.isLazervaultUser != b.isLazervaultUser) {
            return a.isLazervaultUser ? -1 : 1;
          }
          return a.contact.name
              .toLowerCase()
              .compareTo(b.contact.name.toLowerCase());
        });

      if (!mounted) return;
      setState(() {
        _contactRows = rows;
        _loadingContacts = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loadingContacts = false;
        _contactsError =
            'Couldn\'t read your contacts. Check the permission and try again.';
      });
    }
  }

  /// Grant-access CTA. When the OS can still prompt (denied, not permanent) we
  /// re-run the fetch, which re-requests permission. When permanently denied we
  /// deep-link to app settings; the app-resume hook re-checks on return.
  Future<void> _onGrantContactAccess() async {
    if (_contactPermPermanentlyDenied) {
      await openAppSettings();
      // openAppSettings resolves when settings opens, not on return — the
      // didChangeAppLifecycleState(resumed) hook re-checks + loads afterwards.
      return;
    }
    await _fetchContacts();
  }

  List<_ContactRow> get _filteredContactRows {
    final q = _controller.text.trim().toLowerCase();
    if (q.isEmpty) return _contactRows;
    return _contactRows
        .where((r) => r.contact.matchesQuery(q))
        .toList(growable: false);
  }

  Widget _buildContactsBody() {
    if (_loadingContacts) {
      return const Center(child: LazerVaultLoader.small());
    }
    if (_contactsError != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.contacts_outlined, size: 48.w, color: Colors.grey[400]),
              SizedBox(height: 12.h),
              Text(
                _contactsError!,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 16.h),
              if (_needsContactPermission)
                // Primary action grants access inline: the OS prompt when it
                // can still be shown, otherwise deep-link to app settings.
                ElevatedButton.icon(
                  onPressed: _onGrantContactAccess,
                  icon: Icon(
                    _contactPermPermanentlyDenied ? Icons.settings_outlined : Icons.contacts_rounded,
                    size: 18.w, color: Colors.white),
                  label: Text(
                    _contactPermPermanentlyDenied ? 'Open settings' : 'Allow contact access',
                    style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _brand,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  ),
                )
              else
                TextButton.icon(
                  onPressed: _fetchContacts,
                  icon: Icon(Icons.refresh, size: 18.w, color: _brand),
                  label: Text('Retry',
                      style: GoogleFonts.inter(color: _brand, fontWeight: FontWeight.w600)),
                ),
            ],
          ),
        ),
      );
    }
    final rows = _filteredContactRows;
    if (rows.isEmpty) {
      return _hint(Icons.search_off,
          _contactRows.isEmpty ? 'No contacts to show' : 'No contacts match your filter');
    }
    return ListView.builder(
      controller: _scroll,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: rows.length + 1,
      itemBuilder: (context, i) {
        if (i == rows.length) {
          return SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h);
        }
        return _contactTile(rows[i]);
      },
    );
  }

  Widget _contactTile(_ContactRow row) {
    final isUser = row.isLazervaultUser;
    return InkWell(
      onTap: () => isUser
          ? widget.onSelected(_matchToResult(row.match!, row.contact))
          : _inviteContact(row.contact),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        child: Row(
          children: [
            _contactAvatar(row.contact),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row.contact.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    isUser
                        ? (row.match!.username.isNotEmpty
                            ? '@${row.match!.username}'
                            : 'On Lazervault')
                        : (row.contact.phoneNumber ?? row.contact.email ?? ''),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            isUser ? _onLazervaultBadge() : _inviteBadge(),
          ],
        ),
      ),
    );
  }

  Widget _onLazervaultBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: _green.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified, size: 13.w, color: _green),
          SizedBox(width: 4.w),
          Text(
            'On Lazervault',
            style: GoogleFonts.inter(
                fontSize: 11.sp, fontWeight: FontWeight.w600, color: _green),
          ),
        ],
      ),
    );
  }

  Widget _inviteBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.send_outlined, size: 13.w, color: Colors.grey[700]),
          SizedBox(width: 4.w),
          Text(
            'Invite',
            style: GoogleFonts.inter(
                fontSize: 11.sp, fontWeight: FontWeight.w600, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }

  Widget _contactAvatar(DeviceContact c) {
    return Container(
      width: 44.w,
      height: 44.w,
      decoration: BoxDecoration(
        color: _brand.withValues(alpha: 0.10),
        shape: BoxShape.circle,
        image: (c.photoUrl ?? '').isNotEmpty
            ? DecorationImage(image: _avatarImage(c.photoUrl!), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: (c.photoUrl ?? '').isNotEmpty
          ? null
          : Text(
              c.initials.isNotEmpty ? c.initials : _initials(c.name),
              style: GoogleFonts.inter(
                  fontSize: 15.sp, fontWeight: FontWeight.w700, color: _brand),
            ),
    );
  }

  /// Build a [UnifiedSearchResult] for a matched device contact so every caller
  /// (which already consumes UnifiedSearchResult) treats it exactly like a
  /// directory hit — internal, on-Lazervault, with the resolved @handle + id.
  UnifiedSearchResult _matchToResult(LazerVaultUserMatchModel m, DeviceContact c) {
    final display = m.name.trim().isNotEmpty ? m.name.trim() : c.name;
    return UnifiedSearchResult(
      source: 'global',
      userId: m.userId,
      displayName: display,
      name: display,
      username: m.username,
      profilePicture: m.profilePhotoUrl ?? '',
      isLazervault: true,
      type: 'internal',
      matchedField: m.matchedBy, // 'phone' | 'email'
    );
  }

  void _inviteContact(DeviceContact contact) {
    final to = contact.name.isNotEmpty ? contact.name : 'there';
    SharePlus.instance.share(ShareParams(
        // iOS: a non-zero popover anchor is required — CGRectZero throws
        // PlatformException and the share silently fails on iPhone/iPad.
        sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      text: 'Hi $to, join me on Lazervault — fast, secure transfers. '
          'Download the app: https://lazervault.app',
    ));
  }
}
