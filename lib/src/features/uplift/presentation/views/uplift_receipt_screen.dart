import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/features/widgets/unified_transaction_receipt.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Maps an Uplift receipt to the shared UnifiedTransaction model so releases
/// and refunds render on the same receipt surface as every other money flow
/// (screenshot / share / download included). For releases the amount is the NET
/// the business received; the gross/fee breakdown (from receipt_data) is shown
/// as metadata lines.
UnifiedTransaction upliftReceiptToUnified(up.UpliftReceiptMessage r) {
  final isRelease = r.referenceType == 'milestone_release';
  final currency = r.currency.isEmpty ? 'NGN' : r.currency;
  final metadata = <String, dynamic>{
    'Fund': r.fundTitle,
    'Type': isRelease ? 'Milestone release' : 'Escrow refund',
    'Receipt No.': r.receiptNumber,
  };
  // receipt_data for releases: {"gross":..,"fee":..,"net":..,"fee_type":".."}
  if (isRelease && r.receiptData.trim().isNotEmpty) {
    try {
      final d = jsonDecode(r.receiptData) as Map<String, dynamic>;
      final gross = (d['gross'] as num?)?.toInt() ?? 0;
      final fee = (d['fee'] as num?)?.toInt() ?? 0;
      if (fee > 0) {
        metadata['Gross'] = upNaira(gross, currency);
        metadata['Platform fee'] = '- ${upNaira(fee, currency)}';
      }
    } catch (_) {/* ignore malformed */}
  }
  return UnifiedTransaction(
    id: r.id,
    serviceType: TransactionServiceType.unknown,
    title: isRelease ? 'Lazerfunds investment received' : 'Lazerfunds refund',
    description: r.fundTitle,
    amount: r.amount.toInt() / 100.0,
    currency: currency,
    createdAt: r.hasGeneratedAt() ? r.generatedAt.toDateTime() : DateTime.now(),
    status: UnifiedTransactionStatus.completed,
    flow: TransactionFlow.incoming,
    transactionReference: r.receiptNumber,
    metadata: metadata,
  );
}

/// Renders a single Uplift receipt via the shared receipt widget.
class UpliftReceiptScreen extends StatelessWidget {
  const UpliftReceiptScreen({required this.receipt, super.key});
  final up.UpliftReceiptMessage receipt;

  @override
  Widget build(BuildContext context) {
    return UnifiedTransactionReceipt(transaction: upliftReceiptToUnified(receipt));
  }
}

/// Lists the current user's Uplift receipts (releases received as a funded
/// business + refunds received as a funder). Tapping opens the shared receipt.
class UpliftReceiptsListScreen extends StatefulWidget {
  const UpliftReceiptsListScreen({super.key});

  @override
  State<UpliftReceiptsListScreen> createState() => _UpliftReceiptsListScreenState();
}

class _UpliftReceiptsListScreenState extends State<UpliftReceiptsListScreen> {
  final _repo = serviceLocator<UpliftRepository>();
  List<up.UpliftReceiptMessage> _receipts = [];
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
      final r = await _repo.listReceipts();
      setState(() {
        _receipts = r;
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
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Receipts'),
      body: UpGradientScaffoldBody(
        child: _loading
          ? const UpLoading()
          : _error != null
              ? UpErrorState(message: _error!, onRetry: _load)
              : _receipts.isEmpty
                  ? const Center(child: Text('No receipts yet.', style: TextStyle(color: kUpTextSecondary)))
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: _receipts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (_, i) {
                          final r = _receipts[i];
                          final isRelease = r.referenceType == 'milestone_release';
                          return Material(
                            color: kUpCard,
                            borderRadius: BorderRadius.circular(12),
                            child: ListTile(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              leading: CircleAvatar(
                                backgroundColor: (isRelease ? kUpSuccess : kUpPrimary).withOpacity(0.15),
                                child: Icon(isRelease ? Icons.south_west : Icons.reply, color: isRelease ? kUpSuccess : kUpPrimary),
                              ),
                              title: Text(isRelease ? 'Funding received' : 'Escrow refund', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                              subtitle: Text(r.fundTitle, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: kUpTextSecondary)),
                              trailing: Text(upNaira(r.amount.toInt(), r.currency), style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => UpliftReceiptScreen(receipt: r)),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
      ),
    );
  }
}
