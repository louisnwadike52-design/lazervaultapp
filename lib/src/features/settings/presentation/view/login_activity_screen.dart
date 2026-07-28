import 'package:flutter/material.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Security center — Login Activity. A chronological feed of recent sign-ins
/// (successes and failures) for the account, from the backend login_history.
/// Complements Trusted Devices (which is per-device); this shows the timeline,
/// including failed attempts, so a user can spot anything they didn't do.
class LoginActivityScreen extends StatefulWidget {
  const LoginActivityScreen({super.key});

  @override
  State<LoginActivityScreen> createState() => _LoginActivityScreenState();
}

class _LoginActivityScreenState extends State<LoginActivityScreen> {
  static const _background = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _primary = Color(0xFF3B82F6);
  static const _success = Color(0xFF10B981);
  static const _errorColor = Color(0xFFEF4444);

  final IAuthRepository _repo = serviceLocator<IAuthRepository>();

  /// One backend page. Small so the "load more on scroll" is exercised and we
  /// never pull the whole history in one shot (backend clamps at 100 anyway).
  static const int _pageSize = 20;

  final ScrollController _scrollController = ScrollController();

  bool _loading = true; // first-page load
  bool _loadingMore = false; // appending a subsequent page
  bool _hasMore = true; // server may have more rows past what we hold
  String? _error; // first-page error only
  List<LoginActivity> _items = <LoginActivity>[];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _load();
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    // Trigger the next page a little before the very bottom for a seamless feel.
    if (!_scrollController.hasClients) return;
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 240) {
      _loadMore();
    }
  }

  /// First page / pull-to-refresh: resets the list.
  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _hasMore = true;
    });
    final result = await _repo.getLoginActivity(limit: _pageSize, offset: 0);
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _loading = false;
        _error = 'Could not load activity. Pull to retry.';
      }),
      (items) => setState(() {
        _loading = false;
        _items = List.of(items);
        _hasMore = items.length >= _pageSize;
      }),
    );
  }

  /// Append the next page when the user scrolls to the bottom. Guarded so we
  /// never fire concurrent requests (which would DDoS the backend) or page past
  /// the end.
  Future<void> _loadMore() async {
    if (_loadingMore || !_hasMore || _loading || _error != null) return;
    setState(() => _loadingMore = true);
    final result =
        await _repo.getLoginActivity(limit: _pageSize, offset: _items.length);
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        // Soft-fail a page append: stop paging, keep what we have.
        _loadingMore = false;
        _hasMore = false;
      }),
      (items) => setState(() {
        _loadingMore = false;
        _items.addAll(items);
        _hasMore = items.length >= _pageSize;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        title: const Text('Login Activity', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(onRefresh: _load, child: _buildBody()),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _primary));
    }
    if (_error != null) {
      return ListView(children: [
        const SizedBox(height: 120),
        Center(child: Text(_error!, style: const TextStyle(color: _textSecondary))),
      ]);
    }
    if (_items.isEmpty) {
      return ListView(children: const [
        SizedBox(height: 120),
        Center(child: Text('No sign-in activity yet', style: TextStyle(color: _textSecondary))),
      ]);
    }
    return ListView.separated(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      // +1 slot for the footer (spinner while appending, or end-of-list hint).
      itemCount: _items.length + 1,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, i) {
        if (i >= _items.length) return _footer();
        return _row(_items[i]);
      },
    );
  }

  Widget _footer() {
    if (_loadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(strokeWidth: 2.4, color: _primary),
          ),
        ),
      );
    }
    if (!_hasMore && _items.isNotEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text('That\'s all your recent activity',
              style: TextStyle(color: _textSecondary, fontSize: 12)),
        ),
      );
    }
    return const SizedBox(height: 8);
  }

  Widget _row(LoginActivity a) {
    final color = a.success ? _success : _errorColor;
    final title = a.success ? 'Successful sign-in' : 'Failed sign-in';
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(a.success ? Icons.check_circle_outline : Icons.cancel_outlined,
              color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                if (a.deviceName.isNotEmpty) _line('Device', a.deviceName),
                if (a.ipAddress.isNotEmpty) _line('IP', a.ipAddress),
                if (!a.success && a.failReason.isNotEmpty)
                  _line('Reason', _humanReason(a.failReason)),
                if (a.at != null) _line('When', _fmt(a.at!)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _line(String label, String value) => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Row(
          children: [
            SizedBox(width: 64, child: Text(label, style: const TextStyle(color: _textSecondary, fontSize: 12))),
            Expanded(child: Text(value, style: const TextStyle(color: Colors.white70, fontSize: 12))),
          ],
        ),
      );

  String _humanReason(String r) {
    switch (r) {
      case 'invalid_password':
      case 'invalid_credentials':
        return 'Wrong credentials';
      case 'invalid_passcode':
        return 'Wrong passcode';
      case 'account_locked':
        return 'Account locked';
      case 'rate_limited':
        return 'Too many attempts';
      case 'device_revoked':
        return 'Revoked device';
      default:
        return r.replaceAll('_', ' ');
    }
  }

  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)} ${two(l.hour)}:${two(l.minute)}';
  }
}
