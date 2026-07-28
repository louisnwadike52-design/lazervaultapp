import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Funder audit of money movement for one fund: milestone disbursements
/// (escrow→business) and escrow refunds (escrow→funder), with status + errors.
/// Backed by ListUpliftMilestoneReleases / ListUpliftEscrowRefunds.
class UpliftFundingActivityScreen extends StatefulWidget {
  const UpliftFundingActivityScreen({required this.fundId, required this.currency, super.key});
  final String fundId;
  final String currency;

  @override
  State<UpliftFundingActivityScreen> createState() => _UpliftFundingActivityScreenState();
}

class _UpliftFundingActivityScreenState extends State<UpliftFundingActivityScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  List<up.UpliftMilestoneReleaseRecord> _releases = [];
  List<up.UpliftEscrowRefundRecord> _refunds = [];
  bool _loading = true;
  String? _error;

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
    try {
      final results = await Future.wait([
        _repo.listReleases(fundId: widget.fundId),
        _repo.listRefunds(fundId: widget.fundId),
      ]);
      setState(() {
        _releases = results[0] as List<up.UpliftMilestoneReleaseRecord>;
        _refunds = results[1] as List<up.UpliftEscrowRefundRecord>;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = upFriendlyError(e);
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kUpBg,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          title: Text('Funding activity',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          bottom: TabBar(
            indicatorColor: kUpPrimary,
            labelColor: Colors.white,
            unselectedLabelColor: kUpTextSecondary,
            tabs: [
              Tab(text: 'Disbursements (${_releases.length})'),
              Tab(text: 'Refunds (${_refunds.length})'),
            ],
          ),
        ),
        body: UpGradientScaffoldBody(
          child: _loading
              ? const UpLoading()
              : _error != null
                  ? UpErrorState(message: _error!, onRetry: _load)
                  : TabBarView(
                      children: [
                        _releasesList(),
                        _refundsList(),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget _releasesList() {
    if (_releases.isEmpty) return const Center(child: Text('No disbursements yet.', style: TextStyle(color: kUpTextSecondary)));
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _releases.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final r = _releases[i];
          return _activityTile(
            title: 'Milestone release',
            amount: r.amount.toInt(),
            status: r.status,
            attempt: r.attemptCount,
            error: r.lastError,
            reference: r.creditReference.isNotEmpty ? r.creditReference : r.debitReference,
          );
        },
      ),
    );
  }

  Widget _refundsList() {
    if (_refunds.isEmpty) return const Center(child: Text('No refunds yet.', style: TextStyle(color: kUpTextSecondary)));
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _refunds.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final r = _refunds[i];
          return _activityTile(
            title: 'Escrow refund${r.reason.isNotEmpty ? ' (${r.reason})' : ''}',
            amount: r.amount.toInt(),
            status: r.status,
            attempt: r.attemptCount,
            error: r.lastError,
          );
        },
      ),
    );
  }

  Widget _activityTile({
    required String title,
    required int amount,
    required String status,
    required int attempt,
    String error = '',
    String reference = '',
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
              Text(upNaira(amount, widget.currency), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 6),
          Row(children: [
            UpStatusChip(label: status),
            if (attempt > 1) ...[
              const SizedBox(width: 8),
              Text('attempt $attempt', style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
            ],
          ]),
          if (reference.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(reference, style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
          ],
          if (error.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(error, style: const TextStyle(color: kUpError, fontSize: 11)),
          ],
        ],
      ),
    );
  }
}
