import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_analytics_charts.dart';

/// "How am I doing?", answered as charts instead of a paragraph of figures.
///
/// Asked about their transactions, their spending, or how their finances are
/// going, every agent replied in prose — a list of amounts the user had to hold
/// in their head and compare by reading. The app already draws these exact
/// breakdowns on the statistics screens, so chat was the one surface where the
/// data arrived in its least usable form.
///
/// Payload comes from `attach_analytics_card`
/// (chat_services_shared/protocol_emit.py) on `metadata.analytics_card`, and is
/// persisted with the turn, so reopening the thread redraws the same chart
/// rather than leaving a sentence referring to a chart that is gone.
///
/// Amounts arrive in MAJOR units (naira). The source is
/// `transactions.amount`, a `numeric(_,2)`, passed through unscaled by the
/// accounts-service analytics handlers — so nothing here divides. Dividing is
/// what reported a ₦1,844 balance as ₦18.44.
class ChatAnalyticsCard extends StatelessWidget {
  const ChatAnalyticsCard({super.key, required this.payload});

  final Map<String, dynamic> payload;

  static const _bg = Color(0xFF1F1F2E);
  static const _border = Color(0xFF2D2D3D);
  static const _muted = Color(0xFF8A8AA3);
  static const _bright = Color(0xFFD6D6E2);
  static const _positive = Color(0xFF34D399);
  static const _negative = Color(0xFFFB7185);

  String _str(String key) => payload[key]?.toString().trim() ?? '';

  Map<String, dynamic> get _totals {
    final raw = payload['totals'];
    return raw is Map ? Map<String, dynamic>.from(raw) : <String, dynamic>{};
  }

  double _amount(String key) {
    final v = _totals[key];
    if (v is num) return v.toDouble();
    return double.tryParse(v?.toString() ?? '') ?? 0.0;
  }

  /// Null and 0 mean different things here: 0 is "no change", null is "there was
  /// no previous period to compare against". Rendering null as 0% would tell the
  /// user their spending held steady on the strength of data that does not exist.
  double? _change(String key) {
    final v = _totals[key];
    if (v == null) return null;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString());
  }

  int get _txCount {
    final v = _totals['transaction_count'];
    if (v is num) return v.toInt();
    return int.tryParse(v?.toString() ?? '') ?? 0;
  }

  List<Widget> _charts(String currency) {
    final raw = payload['charts'];
    if (raw is! List) return const [];

    final out = <Widget>[];
    for (final entry in raw) {
      if (entry is! Map) continue;
      final chart = Map<String, dynamic>.from(entry);
      final points = <AnalyticsPointView>[];
      final rawPoints = chart['points'];
      if (rawPoints is List) {
        for (final p in rawPoints) {
          final parsed = AnalyticsPointView.fromJson(p);
          if (parsed != null) points.add(parsed);
        }
      }
      if (points.isEmpty) continue;

      final kind = chart['kind']?.toString() ?? '';
      final Widget body;
      switch (kind) {
        case 'donut':
          body = AnalyticsDonut(points: points, currency: currency);
          break;
        case 'bar':
          body = AnalyticsBars(points: points, currency: currency);
          break;
        case 'line':
          final labels = (chart['series_labels'] is List)
              ? List<String>.from(
                  (chart['series_labels'] as List).map((e) => e.toString()))
              : const <String>['Money in', 'Money out'];
          body = AnalyticsTrendLine(
            points: points,
            currency: currency,
            seriesLabels: labels,
          );
          break;
        default:
          // An unknown kind is SKIPPED, not guessed at. A newer backend adding
          // a chart type should degrade to "that chart is missing", never to a
          // chart drawn in the wrong shape.
          continue;
      }

      out.add(Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chart['title']?.toString() ?? '',
              style: GoogleFonts.inter(
                color: _bright,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10.h),
            body,
            if ((chart['footnote']?.toString() ?? '').isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                chart['footnote'].toString(),
                style: GoogleFonts.inter(color: _muted, fontSize: 10.sp),
              ),
            ],
          ],
        ),
      ));
    }
    return out;
  }

  Widget _totalTile({
    required String label,
    required double value,
    required String currency,
    required Color color,
    double? change,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(color: _muted, fontSize: 10.5.sp),
          ),
          SizedBox(height: 3.h),
          Text(
            analyticsMoney(value, currency),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (change != null) ...[
            SizedBox(height: 2.h),
            Text(
              // Sub-half-percent movement is rounding, not a trend — printing
              // "0%" beside an arrow implies a direction it does not have.
              change.abs() < 0.5
                  ? 'about level'
                  : '${change > 0 ? '▲' : '▼'} ${change.abs().toStringAsFixed(0)}%',
              style: GoogleFonts.inter(
                color: change.abs() < 0.5
                    ? _muted
                    : (change > 0 ? _positive : _negative),
                fontSize: 9.5.sp,
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currency = _str('currency').isEmpty ? 'NGN' : _str('currency');
    final charts = _charts(currency);
    final income = _amount('total_income');
    final expenses = _amount('total_expenses');
    final net = _amount('net');
    final partial = _str('partial_reason');

    // Nothing to show at all. The agent's own sentence already said so in
    // words, and an empty card under it would read as a widget that failed.
    if (charts.isEmpty && income == 0 && expenses == 0 && _txCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _str('title').isEmpty ? 'Your money' : _str('title'),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                _str('period_label'),
                style: GoogleFonts.inter(color: _muted, fontSize: 11.sp),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _totalTile(
                label: 'Money in',
                value: income,
                currency: currency,
                color: _positive,
                change: _change('income_change_percent'),
              ),
              SizedBox(width: 10.w),
              _totalTile(
                label: 'Money out',
                value: expenses,
                currency: currency,
                color: _negative,
                change: _change('expense_change_percent'),
              ),
              SizedBox(width: 10.w),
              _totalTile(
                label: net >= 0 ? 'Ahead by' : 'Behind by',
                value: net.abs(),
                currency: currency,
                color: net >= 0 ? _positive : _negative,
              ),
            ],
          ),
          if (_txCount > 0) ...[
            SizedBox(height: 8.h),
            Text(
              'Across $_txCount transaction${_txCount == 1 ? '' : 's'}',
              style: GoogleFonts.inter(color: _muted, fontSize: 10.5.sp),
            ),
          ],
          ...charts,
          if (partial.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline_rounded,
                    size: 13.sp, color: const Color(0xFFF59E0B)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    // Said out loud, because a card missing one of its charts
                    // otherwise passes itself off as the complete picture.
                    partial,
                    style: GoogleFonts.inter(
                      color: const Color(0xFFF59E0B),
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
