import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';

/// Admin Alerts — operational alerts (Prometheus/Alertmanager → notifications-
/// service) for admin-role users. Reachable only by users whose profile roles
/// include an admin role; the alert also arrives as a push notification.
///
/// Read-only: lists recent ops alerts (severity, service, firing/resolved). The
/// backend feed is admin-gated server-side; this screen additionally hides
/// itself from non-admins via [isAdminRoles].
class AdminAlertsScreen extends StatefulWidget {
  const AdminAlertsScreen({super.key});

  static const String routeName = '/admin/alerts';

  @override
  State<AdminAlertsScreen> createState() => _AdminAlertsScreenState();
}

/// Whether a roles list grants access to the Admin Alerts surface.
bool isAdminRoles(List<String>? roles) {
  if (roles == null) return false;
  const adminRoles = {'admin', 'super_admin', 'operations', 'support', 'auditor'};
  return roles.any((r) => adminRoles.contains(r.toLowerCase()));
}

class _OpsAlert {
  final String id, alertName, severity, service, status, summary, description;
  final String createdAt;
  _OpsAlert({
    required this.id,
    required this.alertName,
    required this.severity,
    required this.service,
    required this.status,
    required this.summary,
    required this.description,
    required this.createdAt,
  });

  factory _OpsAlert.fromJson(Map<String, dynamic> j) => _OpsAlert(
        id: (j['ID'] ?? j['id'] ?? '').toString(),
        alertName: (j['AlertName'] ?? j['alert_name'] ?? 'Alert').toString(),
        severity: (j['Severity'] ?? j['severity'] ?? 'warning').toString(),
        service: (j['Service'] ?? j['service'] ?? '').toString(),
        status: (j['Status'] ?? j['status'] ?? 'firing').toString(),
        summary: (j['Summary'] ?? j['summary'] ?? '').toString(),
        description: (j['Description'] ?? j['description'] ?? '').toString(),
        createdAt: (j['CreatedAt'] ?? j['created_at'] ?? '').toString(),
      );
}

class _AdminAlertsScreenState extends State<AdminAlertsScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _divider = Color(0xFF2D2D2D);
  static const _textSecondary = Color(0xFF9CA3AF);
  static const _error = Color(0xFFEF4444);
  static const _warning = Color(0xFFFB923C);
  static const _success = Color(0xFF10B981);

  List<_OpsAlert> _alerts = [];
  bool _loading = true;
  String? _err;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _err = null;
    });
    try {
      final dio = serviceLocator<Dio>();
      final resp = await dio.get(endpointRegistry.opsAlerts);
      final data = resp.data;
      final list = (data is Map && data['alerts'] is List) ? data['alerts'] as List : const [];
      setState(() {
        _alerts = list
            .whereType<Map>()
            .map((m) => _OpsAlert.fromJson(m.cast<String, dynamic>()))
            .toList();
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _err = 'Could not load alerts. ${e is DioException ? (e.message ?? '') : e}';
        _loading = false;
      });
    }
  }

  Color _sevColor(String s) {
    switch (s.toLowerCase()) {
      case 'critical':
        return _error;
      case 'warning':
        return _warning;
      default:
        return _textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        title: const Text('Admin Alerts', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(onPressed: _load, icon: const Icon(Icons.refresh, color: Colors.white)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        color: _success,
        backgroundColor: _card,
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : _err != null
                ? ListView(children: [
                    const SizedBox(height: 120),
                    Center(child: Text(_err!, style: const TextStyle(color: _error))),
                  ])
                : _alerts.isEmpty
                    ? ListView(children: const [
                        SizedBox(height: 140),
                        Icon(Icons.shield_outlined, color: _success, size: 48),
                        SizedBox(height: 12),
                        Center(child: Text('All clear — no ops alerts.', style: TextStyle(color: _textSecondary))),
                      ])
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _alerts.length,
                        separatorBuilder: (_, __) => const Divider(color: _divider, height: 16),
                        itemBuilder: (_, i) => _tile(_alerts[i]),
                      ),
      ),
    );
  }

  Widget _tile(_OpsAlert a) {
    final sev = _sevColor(a.severity);
    final resolved = a.status.toLowerCase() == 'resolved';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: _card, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: sev.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(6)),
                child: Text(a.severity.toUpperCase(),
                    style: TextStyle(color: sev, fontSize: 10, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(width: 8),
              if (resolved)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: _success.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(6)),
                  child: const Text('RESOLVED', style: TextStyle(color: _success, fontSize: 10, fontWeight: FontWeight.w700)),
                ),
              const Spacer(),
              Text(a.service, style: const TextStyle(color: _textSecondary, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 8),
          Text(a.alertName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
          if (a.summary.isNotEmpty || a.description.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(a.summary.isNotEmpty ? a.summary : a.description,
                style: const TextStyle(color: _textSecondary, fontSize: 12)),
          ],
        ],
      ),
    );
  }
}
