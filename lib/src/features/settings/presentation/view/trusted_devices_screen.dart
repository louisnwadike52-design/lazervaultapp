import 'package:flutter/material.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// Security center — Trusted Devices. Lists every device the user has logged in
/// from (backend device registry) and lets them revoke any device, which ends
/// that device's sessions. Reads via [IAuthRepository.listDevices] /
/// [IAuthRepository.revokeDevice].
class TrustedDevicesScreen extends StatefulWidget {
  const TrustedDevicesScreen({super.key});

  @override
  State<TrustedDevicesScreen> createState() => _TrustedDevicesScreenState();
}

class _TrustedDevicesScreenState extends State<TrustedDevicesScreen> {
  // Dark theme palette (matches the app convention).
  static const _background = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _primary = Color(0xFF3B82F6);
  static const _success = Color(0xFF10B981);
  static const _errorColor = Color(0xFFEF4444);

  final IAuthRepository _repo = serviceLocator<IAuthRepository>();

  bool _loading = true;
  String? _error;
  List<TrustedDevice> _devices = const [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final result = await _repo.listDevices();
    if (!mounted) return;
    result.fold(
      (failure) => setState(() {
        _loading = false;
        _error = 'Could not load devices. Pull to retry.';
      }),
      (devices) => setState(() {
        _loading = false;
        // Current device first, then most-recent login.
        final sorted = [...devices]..sort((a, b) {
            if (a.isCurrent != b.isCurrent) return a.isCurrent ? -1 : 1;
            final at = a.lastLoginAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            final bt = b.lastLoginAt ?? DateTime.fromMillisecondsSinceEpoch(0);
            return bt.compareTo(at);
          });
        _devices = sorted;
      }),
    );
  }

  Future<void> _confirmRevoke(TrustedDevice device) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        title: const Text('Revoke device?', style: TextStyle(color: Colors.white)),
        content: Text(
          'This signs out "${device.model.isEmpty ? device.platform : device.model}" '
          'and blocks it until it is verified again.',
          style: const TextStyle(color: _textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: _textSecondary)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Revoke', style: TextStyle(color: _errorColor)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    final res = await _repo.revokeDevice(deviceUuid: device.deviceUuid);
    if (!mounted) return;
    res.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not revoke device')),
      ),
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Device revoked')),
        );
        _load();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        elevation: 0,
        title: const Text('Trusted Devices', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _primary));
    }
    if (_error != null) {
      return ListView(
        children: [
          const SizedBox(height: 120),
          Center(child: Text(_error!, style: const TextStyle(color: _textSecondary))),
        ],
      );
    }
    if (_devices.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 120),
          Center(child: Text('No devices yet', style: TextStyle(color: _textSecondary))),
        ],
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: _devices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _deviceCard(_devices[i]),
    );
  }

  Widget _deviceCard(TrustedDevice d) {
    final isIOS = d.platform.toLowerCase() == 'ios';
    final title = d.model.isNotEmpty ? d.model : (isIOS ? 'iOS device' : 'Android device');
    return Container(
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _divider),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(isIOS ? Icons.phone_iphone : Icons.phone_android, color: _primary),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(title,
                              style: const TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.w600)),
                        ),
                        if (d.isCurrent) ...[
                          const SizedBox(width: 8),
                          _chip('This device', _success),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(_statusLabel(d.trustStatus),
                        style: TextStyle(color: _statusColor(d.trustStatus), fontSize: 12)),
                  ],
                ),
              ),
              if (!d.isCurrent)
                IconButton(
                  icon: const Icon(Icons.block, color: _errorColor, size: 20),
                  tooltip: 'Revoke',
                  onPressed: () => _confirmRevoke(d),
                ),
            ],
          ),
          const SizedBox(height: 10),
          if (d.lastIp.isNotEmpty) _detail('IP', d.lastIp),
          if (d.lastLocation.isNotEmpty) _detail('Location', d.lastLocation),
          if (d.lastLoginAt != null) _detail('Last login', _fmt(d.lastLoginAt!)),
          if (d.firstSeenAt != null) _detail('First seen', _fmt(d.firstSeenAt!)),
        ],
      ),
    );
  }

  Widget _detail(String label, String value) => Padding(
        padding: const EdgeInsets.only(top: 2),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(label, style: const TextStyle(color: _textSecondary, fontSize: 12)),
            ),
            Expanded(
              child: Text(value, style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ),
          ],
        ),
      );

  Widget _chip(String text, Color color) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.w600)),
      );

  String _statusLabel(String s) {
    switch (s) {
      case 'trusted':
        return 'Trusted';
      case 'revoked':
        return 'Revoked';
      case 'compromised':
        return 'Blocked';
      default:
        return 'Pending verification';
    }
  }

  Color _statusColor(String s) {
    switch (s) {
      case 'trusted':
        return _success;
      case 'revoked':
      case 'compromised':
        return _errorColor;
      default:
        return _textSecondary;
    }
  }

  String _fmt(DateTime dt) {
    final l = dt.toLocal();
    String two(int n) => n.toString().padLeft(2, '0');
    return '${l.year}-${two(l.month)}-${two(l.day)} ${two(l.hour)}:${two(l.minute)}';
  }
}
