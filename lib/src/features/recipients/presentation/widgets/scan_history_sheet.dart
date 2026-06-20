import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:lazervault/src/features/recipients/data/datasources/bank_scan_datasource.dart';

const Color _purple = Color.fromARGB(255, 78, 3, 208);
const Color _sheetBg = Color(0xFF1F1F1F);
const Color _rowDivider = Color(0xFF2D2D2D);

/// Bottom sheet listing the user's past smart-scans (newest-first).
///
/// Self-contained: it owns the [BankScanDataSource] it builds, fetches
/// `GET /scan/history`, and renders loading / empty / error / list states
/// in the same dark-theme shape the rest of the scan flow uses.
///
/// Tapping a row pops the sheet and hands the chosen [ScanHistoryItem]
/// back to the caller (via [onSelectScan]) so the caller can re-apply the
/// stored extraction through its existing live-scan routing — we do NOT
/// duplicate the verify / route logic here.
class ScanHistorySheet extends StatefulWidget {
  /// Builds a fresh [BankScanDataSource]. Supplied by the caller so the
  /// gateway-root + DI wiring stays identical to the live scan and isn't
  /// re-derived here.
  final BankScanDataSource Function() dataSourceBuilder;

  /// Called when the user taps a past scan to re-apply it. The sheet has
  /// already closed by the time this fires.
  final void Function(ScanHistoryItem item) onSelectScan;

  const ScanHistorySheet({
    super.key,
    required this.dataSourceBuilder,
    required this.onSelectScan,
  });

  /// Show the history sheet. The caller passes the same datasource builder
  /// it uses for the live scan and a callback to re-apply a chosen scan.
  static Future<void> show(
    BuildContext context, {
    required BankScanDataSource Function() dataSourceBuilder,
    required void Function(ScanHistoryItem item) onSelectScan,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: _sheetBg,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => ScanHistorySheet(
        dataSourceBuilder: dataSourceBuilder,
        onSelectScan: onSelectScan,
      ),
    );
  }

  @override
  State<ScanHistorySheet> createState() => _ScanHistorySheetState();
}

class _ScanHistorySheetState extends State<ScanHistorySheet> {
  bool _loading = true;
  String? _error;
  List<ScanHistoryItem> _items = const [];

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

    BankScanDataSource? ds;
    try {
      ds = widget.dataSourceBuilder();
      final items = await ds.getScanHistory(limit: 20, offset: 0);
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } on BankScanException catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.message;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _error = 'Something went wrong loading scan history.';
        _loading = false;
      });
    } finally {
      ds?.dispose();
    }
  }

  void _onTapItem(ScanHistoryItem item) {
    // Close the history sheet first, then let the caller re-apply the scan
    // through its existing routing (result sheet / prefilled transfer).
    Navigator.of(context).pop();
    widget.onSelectScan(item);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 12.h),
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 16.h),
            _buildHeader(),
            SizedBox(height: 12.h),
            Flexible(child: _buildBody()),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _purple.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.history, color: _purple, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Scan History',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'Tap a past scan to reuse it',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.6),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          if (!_loading)
            IconButton(
              onPressed: _load,
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withValues(alpha: 0.7),
                size: 20.sp,
              ),
              tooltip: 'Refresh',
            ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(_purple),
          ),
        ),
      );
    }

    if (_error != null) {
      return _buildErrorState(_error!);
    }

    if (_items.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      itemCount: _items.length,
      separatorBuilder: (_, __) => Divider(
        color: _rowDivider,
        height: 1,
        indent: 20.w,
        endIndent: 20.w,
      ),
      itemBuilder: (_, index) => _buildRow(_items[index]),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 48.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.history_toggle_off,
            color: Colors.white.withValues(alpha: 0.3),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No scans yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Bank details you scan will appear here so you can reuse them.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.55),
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            color: Colors.white.withValues(alpha: 0.3),
            size: 48.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton.icon(
            onPressed: _load,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _purple,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(ScanHistoryItem item) {
    final (icon, _) = _typeMeta(item.extractionType);
    return InkWell(
      onTap: () => _onTapItem(item),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: _purple.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _purple, size: 22.sp),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _summary(item),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Text(
                        _typeLabel(item.extractionType),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11.5.sp,
                        ),
                      ),
                      if (item.createdAt != null) ...[
                        Text(
                          '  •  ',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 11.5.sp,
                          ),
                        ),
                        Text(
                          _relativeTime(item.createdAt!),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 11.5.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            _buildConfidenceChip(item.confidence),
          ],
        ),
      ),
    );
  }

  Widget _buildConfidenceChip(double confidence) {
    final percent = (confidence * 100).round();
    final color = confidence >= 0.8
        ? const Color(0xFF10B981)
        : confidence >= 0.5
            ? const Color(0xFFFB923C)
            : const Color(0xFFEF4444);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        '$percent%',
        style: TextStyle(
          color: color,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ── Summaries & labels ──────────────────────────────────────────────────

  String _str(Map<String, dynamic> d, String key) {
    final v = d[key];
    return v is String ? v.trim() : (v?.toString() ?? '').trim();
  }

  /// One-line summary per extraction type, e.g.
  ///   bank_details   → "Zenith • 2233445566 • CHRIS OKAFOR"
  ///   internal_user  → "@username"
  ///   phone_number   → "0803…"
  ///   email          → "chris@x.com"
  String _summary(ScanHistoryItem item) {
    final d = item.data;
    switch (item.extractionType) {
      case 'bank_details':
        final parts = [
          _str(d, 'bank_name'),
          _str(d, 'account_number'),
          _str(d, 'account_name'),
        ].where((p) => p.isNotEmpty).toList();
        return parts.isEmpty ? 'Bank details' : parts.join(' • ');
      case 'internal_user':
        final username = _str(d, 'username');
        if (username.isNotEmpty) return '@$username';
        final display = _str(d, 'display_name');
        return display.isNotEmpty ? display : 'LazerVault user';
      case 'phone_number':
        final phone = _str(d, 'phone_number');
        return phone.isNotEmpty ? phone : 'Phone number';
      case 'email':
        final email = _str(d, 'email');
        return email.isNotEmpty ? email : 'Email';
      case 'ambiguous':
        return 'Unresolved scan';
      default:
        return 'No details';
    }
  }

  String _typeLabel(String type) => switch (type) {
        'bank_details' => 'Bank account',
        'internal_user' => 'LazerVault user',
        'phone_number' => 'Phone number',
        'email' => 'Email',
        'ambiguous' => 'Needs review',
        _ => 'No data',
      };

  (IconData, bool) _typeMeta(String type) => switch (type) {
        'bank_details' => (Icons.account_balance_outlined, true),
        'internal_user' => (Icons.person_outline, true),
        'phone_number' => (Icons.phone_outlined, true),
        'email' => (Icons.email_outlined, true),
        'ambiguous' => (Icons.help_outline, false),
        _ => (Icons.image_not_supported_outlined, false),
      };

  String _relativeTime(DateTime when) {
    final diff = DateTime.now().difference(when);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) {
      final m = diff.inMinutes;
      return '$m min${m == 1 ? '' : 's'} ago';
    }
    if (diff.inHours < 24) {
      final h = diff.inHours;
      return '$h hour${h == 1 ? '' : 's'} ago';
    }
    if (diff.inDays < 7) {
      final d = diff.inDays;
      return '$d day${d == 1 ? '' : 's'} ago';
    }
    if (diff.inDays < 30) {
      final w = (diff.inDays / 7).floor();
      return '$w week${w == 1 ? '' : 's'} ago';
    }
    if (diff.inDays < 365) {
      final mo = (diff.inDays / 30).floor();
      return '$mo month${mo == 1 ? '' : 's'} ago';
    }
    final y = (diff.inDays / 365).floor();
    return '$y year${y == 1 ? '' : 's'} ago';
  }
}
