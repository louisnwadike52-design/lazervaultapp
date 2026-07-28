import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/account_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/features/uplift/data/uplift_repository.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;

/// Styled commit-to-escrow confirmation. The funding source and locale are the
/// dashboard's ACTIVE account + locale — shown read-only, with no pickers (the
/// user chooses those on the dashboard, not here). Confirms with the PIN modal.
class UpliftCommitScreen extends StatefulWidget {
  const UpliftCommitScreen({required this.fund, super.key});
  final up.UpliftFundMessage fund;

  @override
  State<UpliftCommitScreen> createState() => _UpliftCommitScreenState();
}

class _UpliftCommitScreenState extends State<UpliftCommitScreen> with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  final _repo = serviceLocator<UpliftRepository>();
  final _amount = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    final major = double.tryParse(_amount.text.trim());
    if (major == null || major <= 0) {
      Get.snackbar('Enter an amount', 'Type the amount to commit to escrow',
          backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final account = serviceLocator<AccountManager>();
    final sourceId = account.activeAccountId;
    if (sourceId == null || sourceId.isEmpty) {
      Get.snackbar('No active account', 'Select an account on the dashboard first',
          backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    final amountKobo = (major * 100).round();
    final txId = 'UPLIFT-COMMIT-${DateTime.now().microsecondsSinceEpoch}';
    setState(() => _submitting = true);
    try {
      await validateTransactionPin(
        context: context,
        transactionId: txId,
        transactionType: 'uplift_pool_commit',
        amount: major,
        currency: widget.fund.currency,
        title: 'Commit to escrow',
        onPinValidated: (verificationToken) async {
          await _repo.commitPool(
            fundId: widget.fund.id,
            amountKobo: amountKobo,
            sourceAccountId: sourceId,
            pinToken: verificationToken,
            transactionId: txId,
          );
          Get.back(result: true);
          Get.snackbar('Committed', '${upNaira(amountKobo, widget.fund.currency)} moved to escrow',
              backgroundColor: kUpCard, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        },
      );
    } catch (e) {
      Get.snackbar('Could not commit', upFriendlyError(e),
          backgroundColor: kUpError, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final account = serviceLocator<AccountManager>().activeAccountDetails;
    final locale = serviceLocator<LocaleManager>();
    return Scaffold(
      backgroundColor: kUpBg,
      appBar: upAppBar('Commit funds'),
      body: UpGradientScaffoldBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Fund hero
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(gradient: kUpAccentGradient, borderRadius: BorderRadius.circular(16)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.fund.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                const SizedBox(height: 4),
                Text('Escrow available: ${upNaira(widget.fund.escrowAvailable.toInt(), widget.fund.currency)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ]),
            ),
            const SizedBox(height: 16),
            _readOnlyTile(
              icon: Icons.account_balance_wallet,
              label: 'Funding account',
              value: account == null
                  ? 'Active account'
                  : '${_titleCase(account.accountType)} · ${_maskAccount(account.accountNumber)}',
              sub: account == null ? null : 'Balance ${account.currency} ${account.balance.toStringAsFixed(2)}',
            ),
            const SizedBox(height: 10),
            _readOnlyTile(icon: Icons.public, label: 'Locale', value: locale.currentCountry, sub: locale.currentCurrency),
            const SizedBox(height: 18),
            TextField(
              controller: _amount,
              keyboardType: TextInputType.number,
              autofocus: true,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
              decoration: InputDecoration(
                labelText: 'Amount to commit (${widget.fund.currency})',
                labelStyle: const TextStyle(color: kUpTextSecondary),
                prefixText: '₦ ',
                prefixStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
                filled: true,
                fillColor: kUpCard,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(52)),
              onPressed: _submitting ? null : _confirm,
              child: _submitting
                  ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Confirm & enter PIN'),
            ),
            const SizedBox(height: 10),
            const Text('Funds are held in escrow and released to businesses per approved milestone.',
                textAlign: TextAlign.center, style: TextStyle(color: kUpTextSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _readOnlyTile({required IconData icon, required String label, required String value, String? sub}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: kUpCard, borderRadius: BorderRadius.circular(12), border: Border.all(color: kUpDivider)),
      child: Row(children: [
        Container(
          width: 40, height: 40, alignment: Alignment.center,
          decoration: BoxDecoration(color: kUpPrimary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: kUpPrimarySoft, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
            const SizedBox(height: 2),
            Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
            if (sub != null) Text(sub, style: const TextStyle(color: kUpTextSecondary, fontSize: 11)),
          ]),
        ),
        const Icon(Icons.lock, size: 14, color: kUpTextSecondary),
      ]),
    );
  }

  String _maskAccount(String n) => n.length <= 4 ? n : '••${n.substring(n.length - 4)}';
  String _titleCase(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
