import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/account_manager.dart';
import 'all_assets_screen.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/core/grpc/crypto_grpc_client.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_config_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_cubit.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_state.dart';
import 'package:lazervault/src/features/crypto/cubit/crypto_withdraw_cubit.dart';
import 'package:lazervault/src/features/crypto/domain/entities/crypto_entity.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/crypto_asset_avatar.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/crypto_fiat_wallet_pill.dart';
import 'package:lazervault/src/features/crypto/presentation/utils/crypto_address_validator.dart';
import 'package:lazervault/src/features/crypto/presentation/view/crypto_address_scanner_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/view/send_crypto_receipt_screen.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/network_picker_sheet.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/crypto_kyc_gate.dart';
import 'package:lazervault/src/features/crypto/presentation/widgets/asset_network_badge.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import 'package:lazervault/src/generated/crypto.pbgrpc.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';

// SendCryptoScreen (PR6) — single-screen send flow:
//   1. Pick asset (from user's holdings).
//   2. Pick network from the holding's `networks` list.
//   3. Enter recipient (address or Lazervault user_id for internal).
//   4. Enter amount + optional note/narration/destination tag.
//   5. PIN bottom sheet via TransactionPinMixin.
//   6. Submit → CryptoWithdrawCubit → receipt sheet.
//
// Server is the security boundary; client-side gating is purely UX (e.g. min
// order from CryptoConfigCubit). Network list comes from the holding's
// per-asset metadata, never hardcoded.

class SendCryptoScreen extends StatefulWidget {
  final CryptoHolding? preselectedHolding;

  const SendCryptoScreen({super.key, this.preselectedHolding});

  @override
  State<SendCryptoScreen> createState() => _SendCryptoScreenState();
}

class _SendCryptoScreenState extends State<SendCryptoScreen>
    with TransactionPinMixin {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  final _narrationController = TextEditingController();
  final _destinationTagController = TextEditingController();
  final _networkController = TextEditingController();

  CryptoHolding? _selected;
  bool _isInternal = false;
  bool _isSubmitting = false;

  // The amount field can be entered in FIAT or CRYPTO; the toggle flips the unit
  // and converts the current value so the trade size is preserved. Defaults to
  // crypto (send is quantity-first). Fiat entry needs a live price; when the
  // price is unknown the toggle is disabled and we stay in crypto.
  bool _amountInFiat = false;
  double get _typedAmount => double.tryParse(_amountController.text.trim()) ?? 0.0;
  double get _priceOf => _selected?.currentPrice ?? 0.0;
  // Fiat value of a holding's full balance (locale currency). Prefers the
  // server-computed totalValue; falls back to quantity × current price.
  double _fiatBalanceOf(CryptoHolding h) =>
      h.totalValue > 0 ? h.totalValue : h.quantity * h.currentPrice;
  // The crypto quantity being sent, whichever unit was typed.
  double get _cryptoAmount =>
      _amountInFiat ? (_priceOf > 0 ? _typedAmount / _priceOf : 0.0) : _typedAmount;
  // The fiat value of the send, whichever unit was typed.
  double get _fiatAmount =>
      _amountInFiat ? _typedAmount : _typedAmount * _priceOf;

  void _toggleAmountUnit() {
    final price = _priceOf;
    if (price <= 0) return; // no rate → can't convert; stay in crypto
    final typed = _typedAmount;
    setState(() {
      if (_amountInFiat) {
        _amountController.text = typed > 0 ? _trimNum(typed / price) : '';
      } else {
        _amountController.text = typed > 0 ? (typed * price).toStringAsFixed(2) : '';
      }
      _amountInFiat = !_amountInFiat;
    });
  }

  // Selected Lazervault recipient (internal / user-to-user send). When set, the
  // send routes as a free/instant INTERNAL Quidax transfer — the server
  // resolves the recipient's sub-account from _recipientUserId (no address, no
  // network). External-address sends leave these null and use _addressController.
  String? _recipientUserId;
  String? _recipientUsername;
  String? _recipientDisplay;

  // Advanced (internal mode): when true, send to the recipient's on-network
  // deposit address on the selected chain instead of the default free/instant
  // internal transfer. The address is resolved server-side at send time.
  bool _advancedOnNetwork = false;

  // Network catalogue (dropdown sourced from GetSupportedAssetNetworks). Loaded
  // once per asset; filtered to withdraw-enabled networks. Falls back to the
  // free-text field when the asset has no configured networks.
  List<QuidaxAssetNetwork> _networks = const [];
  String? _selectedNetwork;
  bool _loadingNetworks = false;

  // Inline validation error for the external destination address, keyed to the
  // currently-selected network. Null when the address is empty or plausible.
  String? _addressError;

  // Snapshot of the last submitted send, used to build the receipt screen once
  // the cubit reports Processing / Completed.
  _SentDetails? _lastSent;
  bool _receiptShown = false;

  CryptoGrpcClient get _client => GetIt.I<CryptoGrpcClient>();

  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  @override
  void initState() {
    super.initState();
    _selected = widget.preselectedHolding;
    // Quidax-as-source-of-truth: refresh holdings from the backend
    // (which itself overlays Quidax-live balances) on every mount,
    // so a deposit that landed on the user's Quidax sub-account from
    // an external wallet shows up here immediately. Without this the
    // screen could read a stale CryptoCubit snapshot from the last
    // landing-page load and miss assets the user can legitimately
    // send.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      // ignore: use_build_context_synchronously
      context.read<CryptoCubit>().refreshHoldingsLive();
    });
    if (_selected != null) _loadNetworks();
  }

  /// Load the withdraw-enabled network catalogue for the selected asset from
  /// GetSupportedAssetNetworks. Picks the `is_default` network (or the first
  /// withdraw-enabled one). On failure/empty the selector falls back to a
  /// free-text field so the user is never blocked.
  Future<void> _loadNetworks() async {
    final sym = _selected?.cryptoSymbol.toLowerCase();
    if (sym == null || sym.isEmpty) return;
    setState(() => _loadingNetworks = true);
    try {
      final resp = await _client.getSupportedAssetNetworks(currency: sym);
      final withdrawable =
          resp.networks.where((n) => n.withdrawEnabled).toList();
      String? def;
      if (withdrawable.isNotEmpty) {
        final d = withdrawable.firstWhere((n) => n.isDefault,
            orElse: () => withdrawable.first);
        def = d.network;
      }
      if (!mounted) return;
      setState(() {
        _networks = withdrawable;
        _selectedNetwork = def;
      });
    } catch (_) {
      // Leave _networks empty → the free-text fallback field renders.
    } finally {
      if (mounted) setState(() => _loadingNetworks = false);
    }
  }

  /// Resolve the network string to submit: empty for internal transfers; the
  /// dropdown selection when networks are configured; otherwise the free-text
  /// fallback field.
  String _networkValue() {
    if (_isInternal) return '';
    if (_networks.isNotEmpty) return _selectedNetwork ?? '';
    return _networkController.text.trim();
  }

  /// Human label for the currently-selected network (for the review sheet).
  String _networkLabel() {
    final net = _networkValue();
    if (net.isEmpty) return 'Default';
    final match = _networks.where((n) => n.network == net);
    if (match.isNotEmpty && match.first.networkName.isNotEmpty) {
      return '${match.first.networkName} (${net.toUpperCase()})';
    }
    return net.toUpperCase();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _narrationController.dispose();
    _destinationTagController.dispose();
    _networkController.dispose();
    super.dispose();
  }

  int _toMinor(double major) {
    try {
      return GetIt.I<CryptoConfigCubit>().config.toMinorUnits(
            major,
            _selected?.cryptoSymbol ?? 'usdt',
          );
    } catch (_) {
      // Fallback when the cubit isn't registered (tests). Mirror the backend
      // ledger scale (quidax.LedgerMinorUnitDecimals): fiat=2, 6-dp stables=6,
      // every other coin=8 — a flat 1e8 would under/over-scale usdt & fiat.
      final s = (_selected?.cryptoSymbol ?? 'usdt').toLowerCase();
      final dp = const {'ngn': 2, 'ghs': 2, 'usd': 2, 'usdt': 6, 'usdc': 6, 'qdx': 6}[s] ?? 8;
      return (major * math.pow(10, dp)).round();
    }
  }

  /// Releases the send re-entrancy claim taken synchronously at the top of
  /// _onSend + refreshes the CTA busy state. Called on every early-return
  /// validation path so a rejected send never leaves the button frozen.
  void _releaseSend() {
    if (mounted) {
      setState(() => _isSubmitting = false);
    } else {
      _isSubmitting = false;
    }
  }

  Future<void> _onSend() async {
    if (_selected == null || _isSubmitting) return;
    // Claim SYNCHRONOUSLY to close the double-tap window: _isSubmitting was
    // previously only set (line ~304) AFTER the KYC gate + validation awaits, so
    // two fast taps both passed the guard above and drove two independent
    // withdrawals (the send cubit mints a fresh intentId per call). Every early
    // return below releases it via _releaseSend().
    _isSubmitting = true;
    // Preventive KYC gate — sending crypto out is a regulated money movement.
    if (!await ensureCryptoTradeAllowed(context, operation: 'send crypto')) {
      _releaseSend();
      return;
    }
    if (!mounted) return;
    // Always resolve to the CRYPTO quantity, regardless of whether the user
    // typed fiat or crypto — the withdraw + balance check are crypto-denominated.
    final amount = _cryptoAmount;
    if (amount <= 0) {
      _toast('Enter a valid amount');
      _releaseSend();
      return;
    }
    if (amount > _selected!.quantity) {
      _toast('Amount exceeds your ${_selected!.cryptoSymbol.toUpperCase()} balance');
      _releaseSend();
      return;
    }
    // Quidax minimum: the crypto amount must clear Quidax's floor (from
    // GetCryptoConfig — Quidax /markets minimum_order_size + the ~$1 notional).
    // Validated BEFORE the confirm/tx-PIN sheet, mirroring buy/sell/swap, so a
    // sub-min send never reaches Quidax (which would debit the sub then reject).
    try {
      final cfg = GetIt.I<CryptoConfigCubit>().config;
      final sym = _selected!.cryptoSymbol.toLowerCase();
      final minMinor = cfg.minOrderFor(sym);
      if (minMinor != null && minMinor > 0) {
        final minCrypto = minMinor / math.pow(10, cfg.decimalsFor(sym));
        if (amount < minCrypto) {
          _toast('Minimum is $minCrypto ${sym.toUpperCase()}');
          _releaseSend();
          return;
        }
      }
    } catch (_) {}
    // Validate the recipient (display string used in review/receipt).
    final String recipient;
    if (_isInternal) {
      if ((_recipientUserId ?? '').isEmpty) {
        _toast('Select a Lazervault recipient');
        _releaseSend();
        return;
      }
      recipient = _recipientDisplay ?? _recipientUsername ?? 'Lazervault user';
      if (_advancedOnNetwork && _networkValue().isEmpty) {
        _toast('Pick a network to send on');
        _releaseSend();
        return;
      }
    } else {
      recipient = _addressController.text.trim();
      if (recipient.isEmpty) {
        _toast('Enter a destination address');
        _releaseSend();
        return;
      }
      // An EXTERNAL (coin_address) send MUST carry a network. When the asset has
      // no configured networks the picker falls back to a free-text field; if it
      // is left blank validateCryptoAddress(network:'') fails OPEN (returns null),
      // silently disabling the wrong-chain guard and letting the send go to
      // Quidax's default chain — an irreversible mis-send. Require a network.
      if (_networkValue().isEmpty) {
        _toast('Select the network to send on');
        _releaseSend();
        return;
      }
      // Client-side address validation (mirrors the server) — catches the
      // catastrophic wrong-chain paste before we ever submit.
      final addrErr = validateCryptoAddress(
        network: _networkValue(),
        address: recipient,
      );
      if (addrErr != null) {
        setState(() => _addressError = addrErr);
        _toast(addrErr);
        _releaseSend();
        return;
      }
    }

    final accountId = _resolveAccountId();
    if (accountId == null) {
      _toast('No active account. Add one to continue.');
      _releaseSend();
      return;
    }

    setState(() => _isSubmitting = true);

    // Compute the on-wire routing:
    //  • internal + advanced → resolve the recipient's on-network deposit
    //    address and send it as a normal coin_address (recipient_user_id kept
    //    for audit).
    //  • internal (default) → recipient_user_id + empty fund_uid → the server
    //    does a free/instant Quidax sub→sub transfer (no network).
    //  • external → the pasted on-chain address.
    final String recipientType;
    final String fundUid;
    final String sendNetwork;
    if (_isInternal && _advancedOnNetwork) {
      final net = _networkValue();
      try {
        final res = await _client.resolveRecipientWallet(
          recipientUserId: _recipientUserId!,
          currency: _selected!.cryptoSymbol.toLowerCase(),
          network: net,
        );
        if (!mounted) return;
        if (res.address.isEmpty) {
          setState(() => _isSubmitting = false);
          _toast(
              'The recipient’s ${net.toUpperCase()} address is still being set up. Please try again shortly');
          return;
        }
        recipientType = 'coin_address';
        fundUid = res.address;
        sendNetwork = net;
      } catch (_) {
        if (mounted) setState(() => _isSubmitting = false);
        _toast(
            'Couldn’t get the recipient’s address on that network. Please try another network');
        return;
      }
    } else if (_isInternal) {
      recipientType = 'internal';
      fundUid = '';
      sendNetwork = '';
    } else {
      recipientType = 'coin_address';
      fundUid = _addressController.text.trim();
      sendNetwork = _networkValue();
    }

    // Review sheet FIRST (mirrors the buy/sell/swap quote sheet): the user
    // reviews the send details, then entering the PIN finalizes. Send has no
    // Quidax rate quote, so this is a plain summary rather than a timed quote.
    final confirmed = await _showSendReviewSheet(amount, recipient);
    if (confirmed != true || !mounted) {
      if (mounted) setState(() => _isSubmitting = false);
      return;
    }

    final intentId =
        'WD-${DateTime.now().millisecondsSinceEpoch}-${_selected!.cryptoSymbol}';
    final cubit = context.read<CryptoWithdrawCubit>();

    // PIN bottom-sheet. onPinValidated callback runs the saga. The mixin
    // keeps the sheet open through the processing phase; we explicitly
    // disable the built-in processing phase (showProcessingPhase: false) so
    // the bloc listener can show our own receipt sheet on terminal state.
    await validateTransactionPin(
      context: context,
      transactionId: intentId,
      transactionType: 'crypto_send',
      amount: amount,
      currency: _selected!.cryptoSymbol.toUpperCase(),
      title: 'Confirm Send',
      message: 'Send ${amount.toStringAsFixed(6)} ${_selected!.cryptoSymbol.toUpperCase()}',
      showProcessingPhase: false,
      onPinValidated: (_) async {
        if (!mounted) return;
        // Snapshot the submitted send so the receipt screen can render the
        // crypto amount / recipient / network without re-reading the form.
        _lastSent = _SentDetails(
          amount: amount,
          symbol: _selected!.cryptoSymbol.toUpperCase(),
          recipient: recipient,
          network: sendNetwork,
          note: _noteController.text.trim(),
          isInternal: _isInternal,
        );
        _receiptShown = false;
        await cubit.submit(
          accountId: accountId,
          recipientType: recipientType,
          currency: _selected!.cryptoSymbol,
          amountMinor: _toMinor(amount),
          fundUid: fundUid,
          network: sendNetwork,
          destinationTag: _destinationTagController.text.trim(),
          transactionNote: _noteController.text.trim(),
          narration: _narrationController.text.trim(),
          // Keep the recipient user id for audit on BOTH internal paths
          // (default sub→sub and advanced on-network address).
          recipientUserId: _isInternal ? (_recipientUserId ?? '') : '',
          recipientUsername: _isInternal ? (_recipientUsername ?? '') : '',
        );
      },
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    // Navigate to the receipt NOW that the PIN sheet has closed. cubit.submit
    // was awaited inside onPinValidated, so the terminal state is already set.
    // Navigating from the BlocConsumer listener instead raced the still-open
    // PIN modal (receipt landed under it / got popped when the sheet closed).
    final st = context.read<CryptoWithdrawCubit>().state;
    if (st is CryptoWithdrawProcessing || st is CryptoWithdrawCompleted) {
      _openReceipt(st);
    }
  }

  /// Review-before-PIN sheet. Shows the send summary and returns `true` when
  /// the user taps Confirm (proceed to PIN), `false`/`null` on cancel/dismiss.
  Future<bool?> _showSendReviewSheet(double amount, String recipient) {
    final symbol = _selected!.cryptoSymbol.toUpperCase();
    final networkLabel = _networkLabel();
    final note = _noteController.text.trim();
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        return Material(
          color: const Color(0xFF0A0A0A),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 48,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Confirm Send',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                _reviewRow('Asset', symbol),
                _reviewRow('Amount', '${amount.toStringAsFixed(6)} $symbol'),
                _reviewRow(_isInternal ? 'To (Lazervault)' : 'To', recipient),
                // Show the network for external sends AND advanced on-network
                // user-to-user sends (the default internal transfer has none).
                if (!_isInternal || _advancedOnNetwork)
                  _reviewRow('Network', networkLabel),
                if (_isInternal && !_advancedOnNetwork)
                  _reviewRow('Transfer', 'Instant Lazervault transfer'),
                if (note.isNotEmpty) _reviewRow('Note', note),
                // Transaction fee — labeled like the Buy/Sell/Swap sheets so the
                // user always sees whether a fee applies BEFORE authorizing.
                // Internal Lazervault transfers are free; an external on-network
                // send incurs a network fee the provider sets at send time.
                _reviewRow(
                  'Transaction fee',
                  (_isInternal && !_advancedOnNetwork)
                      ? 'Free'
                      : 'Network fee applies',
                ),
                if (!_isInternal || _advancedOnNetwork) ...[
                  const SizedBox(height: 8),
                  const Text(
                    'The network fee is set by the network/provider at send time and '
                    'deducted from the amount; the exact figure appears on your receipt.',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(sheetCtx).pop(false),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(sheetCtx).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7C3AED),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Confirm'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _reviewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF))),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String? _resolveAccountId() {
    try {
      return GetIt.I<AccountManager>().activeAccountId;
    } catch (_) {
      return null;
    }
  }

  void _toast(String msg) {
    Get.snackbar('Send', msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xCCEF4444),
        colorText: const Color(0xFFFFFFFF),
        duration: const Duration(seconds: 3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: Text('Send Crypto',
            style: GoogleFonts.inter(
                color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocConsumer<CryptoWithdrawCubit, CryptoWithdrawState>(
        listener: _onWithdrawState,
        builder: (context, state) {
          // Read the user's holdings from the CryptoCubit (passed in by
          // the route's BlocProvider.value). If the user has no
          // spendable balance, render an empty-state instead of the
          // form — gives them a path forward (Buy / Receive) rather
          // than a dead-end input they can't fill out.
          final cryptoState = context.watch<CryptoCubit>().state;
          if (cryptoState is! CryptosLoaded) {
            // Holdings still loading — a loader, not the empty state (which
            // would wrongly claim "no crypto to send" mid-load).
            return const Center(child: LazerVaultLoader.small());
          }
          final holdings =
              cryptoState.holdings.where((h) => h.quantity > 0).toList();
          if (holdings.isEmpty) {
            return _buildEmptyState();
          }
          // Auto-select the first sendable asset so the form is immediately
          // usable. The old screen showed "No asset selected" with no picker,
          // which dead-ended the whole send flow from the main entry.
          final hasValidSelection = _selected != null &&
              holdings.any((h) => h.cryptoId == _selected!.cryptoId);
          if (!hasValidSelection) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              final stillInvalid = _selected == null ||
                  !holdings.any((h) => h.cryptoId == _selected!.cryptoId);
              if (stillInvalid) _selectAsset(holdings.first);
            });
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: ListView(
                children: [
                  _buildAssetCard(holdings),
                  // Active network for this asset — shown on BOTH tabs. Quidax
                  // holds one unified balance per currency; this is the chain
                  // the balance is received/sent on, with any others as "+N".
                  if (_selected != null) ...[
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AssetNetworkBadge(
                        symbol: _selected!.cryptoSymbol,
                        heldHint: true,
                      ),
                    ),
                  ],
                  SizedBox(height: 12.h),
                  const CryptoFiatWalletPill(caption: 'Your wallet balance'),
                  SizedBox(height: 12.h),
                  _buildRecipientToggle(),
                  SizedBox(height: 12.h),
                  if (!_isInternal) _buildNetworkSelector(),
                  if (!_isInternal) SizedBox(height: 12.h),
                  if (_isInternal)
                    _buildRecipientPicker()
                  else
                    _buildAddressField(),
                  // Advanced (internal only): send on a specific chain to the
                  // recipient's on-network deposit address instead of the
                  // default free/instant internal transfer.
                  if (_isInternal && (_recipientUserId ?? '').isNotEmpty) ...[
                    SizedBox(height: 12.h),
                    _buildAdvancedNetworkToggle(),
                    if (_advancedOnNetwork) ...[
                      SizedBox(height: 12.h),
                      _buildNetworkSelector(),
                    ],
                  ],
                  SizedBox(height: 12.h),
                  _buildAmountCard(),
                  if (!_isInternal) ...[
                    SizedBox(height: 12.h),
                    _buildField(_destinationTagController,
                        'Destination tag (optional)'),
                  ],
                  SizedBox(height: 12.h),
                  _buildField(_noteController, 'Transaction note (optional)'),
                  SizedBox(height: 12.h),
                  _buildField(_narrationController, 'Narration (optional)'),
                  SizedBox(height: 24.h),
                  _buildSendCta(
                      busy: state is CryptoWithdrawSubmitting || _isSubmitting),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onWithdrawState(BuildContext context, CryptoWithdrawState state) {
    // Only the failure path is surfaced here. The receipt navigation happens in
    // _onSend AFTER the PIN sheet closes (a listener push races the open modal).
    if (state is CryptoWithdrawFailed) {
      Get.snackbar('Send failed', state.reason,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xCCEF4444),
          colorText: const Color(0xFFFFFFFF),
          duration: const Duration(seconds: 4));
    }
  }

  /// Navigate once to the Revolut-style send receipt, which polls
  /// GetCryptoWithdrawalStatus until the send reaches a terminal state.
  void _openReceipt(CryptoWithdrawState state) {
    if (_receiptShown) return;
    final sent = _lastSent;
    if (sent == null) return;

    String transactionId;
    String reference;
    String txid = '';
    UnifiedTransactionStatus status;
    if (state is CryptoWithdrawCompleted) {
      transactionId = state.transactionId;
      reference = state.reference;
      txid = state.txid;
      status = UnifiedTransactionStatus.completed;
    } else if (state is CryptoWithdrawProcessing) {
      transactionId = state.transactionId;
      reference = state.reference;
      status = UnifiedTransactionStatus.processing;
    } else {
      return;
    }
    _receiptShown = true;

    // Push the receipt and REMOVE the send screen (+ any intermediate routes)
    // down to the named crypto landing, so ONE Back from the receipt returns to
    // the crypto landing (not the send form), and a second Back to the dashboard
    // (carousel state preserved). The receipt is self-contained (polls via a
    // GetIt gRPC client), so removing the send screen's cubit is safe.
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (_) => SendCryptoReceiptScreen(
          transactionId: transactionId,
          reference: reference,
          amount: sent.amount,
          symbol: sent.symbol,
          recipient: sent.recipient,
          network: sent.network,
          note: sent.note,
          isInternal: sent.isInternal,
          createdAt: DateTime.now(),
          initialStatus: status,
          initialTxid: txid,
        ),
      ),
      (route) => route.settings.name == AppRoutes.crypto || route.isFirst,
    );
  }

  /// Empty-state render when the user has zero spendable holdings.
  /// Replaces the prior crypto-screen snackbar dead-end with an
  /// actionable screen: explains the situation, then routes the user
  /// to Buy or Receive (the two paths that produce a spendable
  /// balance). Mirrors the empty-state UX the giftcards screens already
  /// use for new users.
  Widget _buildEmptyState() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 72.sp,
              color: Colors.white.withValues(alpha: 0.35),
            ),
            SizedBox(height: 24.h),
            Text(
              'No crypto to send yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'To send crypto, you first need a balance to send from. '
              'Buy crypto with your wallet or receive it from an external address.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              onPressed: () {
                // Route into the integrated buy path (asset picker → buy bottom
                // sheet). Pass the shared CryptoCubit so a completed buy
                // refreshes the same holdings this screen watches. Captured
                // before Get.back() pops this dead-end (no balance to send
                // from) screen.
                final cubit = context.read<CryptoCubit>();
                Get.back();
                Get.to(() => BlocProvider.value(
                      value: cubit,
                      child: const AllAssetsScreen(mode: AssetSelectionMode.buy),
                    ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                'Buy crypto',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ),
            SizedBox(height: 12.h),
            OutlinedButton(
              onPressed: () {
                // Open the receive/deposit picker directly (pick asset →
                // deposit-address sheet) instead of bouncing to the landing.
                final cubit = context.read<CryptoCubit>();
                Get.back();
                Get.to(() => BlocProvider.value(
                      value: cubit,
                      child:
                          const AllAssetsScreen(mode: AssetSelectionMode.receive),
                    ));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF3B82F6)),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(
                'Receive crypto',
                style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Trim a crypto quantity to a clean string (≤8 dp, no trailing zeros).
  String _trimNum(double v) {
    var s = v.toStringAsFixed(8);
    if (s.contains('.')) {
      s = s.replaceAll(RegExp(r'0+$'), '').replaceAll(RegExp(r'\.$'), '');
    }
    return s.isEmpty ? '0' : s;
  }

  /// Per-asset avatar: the asset's REAL logo (resolved by symbol), with a
  /// deterministic initials chip fallback — so USDT/TRX/etc. never borrow the
  /// Bitcoin logo. See [CryptoAssetAvatar].
  Widget _assetChip(String symbol, {double size = 40}) {
    return CryptoAssetAvatar(
      symbol: symbol,
      imageUrl: _imageForSymbol(symbol),
      size: size,
    );
  }

  /// Resolves an asset's logo URL by ticker from whatever the CryptoCubit has
  /// loaded (holdings + supported + full catalogue all carry the CoinGecko/
  /// Quidax `image`). Null when not found → the avatar shows its initials chip.
  String? _imageForSymbol(String symbol) {
    final s = symbol.trim().toLowerCase();
    if (s.isEmpty) return null;
    try {
      final st = context.read<CryptoCubit>().state;
      if (st is! CryptosLoaded) return null;
      for (final c in [...st.cryptos, ...st.supportedAssets]) {
        if (c.symbol.toLowerCase() == s && c.image.trim().isNotEmpty) {
          return c.image;
        }
      }
    } catch (_) {
      // No CryptoCubit in scope → avatar shows its initials chip.
    }
    return null;
  }

  /// Set the asset to send: reset the network selection + reload the network
  /// catalogue for the new asset.
  void _selectAsset(CryptoHolding h) {
    if (!mounted) return;
    setState(() {
      _selected = h;
      _networks = const [];
      _selectedNetwork = null;
      _networkController.clear();
    });
    _loadNetworks();
  }

  /// Bottom-sheet asset picker over the user's sendable holdings.
  Future<void> _pickAsset(List<CryptoHolding> holdings) async {
    final picked = await showModalBottomSheet<CryptoHolding>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => Container(
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 44.w,
                height: 4.h,
                decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r)),
              ),
            ),
            SizedBox(height: 16.h),
            Text('Select asset to send',
                style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
            SizedBox(height: 8.h),
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: holdings.length,
                itemBuilder: (_, i) {
                  final h = holdings[i];
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    onTap: () => Navigator.of(sheetCtx).pop(h),
                    leading: _assetChip(h.cryptoSymbol, size: 38),
                    title: Text(h.cryptoSymbol.toUpperCase(),
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp)),
                    subtitle: Text(h.cryptoName,
                        style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                    trailing: Text(_trimNum(h.quantity),
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 14.sp)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
    if (picked != null) _selectAsset(picked);
  }

  /// Tappable asset card — opens the picker; shows the selected asset + balance.
  Widget _buildAssetCard(List<CryptoHolding> holdings) {
    final h = _selected;
    return GestureDetector(
      onTap: () => _pickAsset(holdings),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF161616), Color(0xFF0C0C0C)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: const Color(0xFF7C3AED).withValues(alpha: 0.28)),
        ),
        child: Row(children: [
          _assetChip(h?.cryptoSymbol ?? '?'),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(h == null ? 'Select asset' : h.cryptoSymbol.toUpperCase(),
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp)),
                SizedBox(height: 2.h),
                Text(
                    h == null
                        ? 'Choose what to send'
                        : 'Balance ${_trimNum(h.quantity)} ${h.cryptoSymbol.toUpperCase()}',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 12.sp)),
                if (h != null && _fiatBalanceOf(h) > 0) ...[
                  SizedBox(height: 2.h),
                  Text('≈ ${CurrencySymbols.formatAmount(_fiatBalanceOf(h))}',
                      style: GoogleFonts.inter(
                          color: const Color(0xFF7C3AED),
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp)),
                ],
              ],
            ),
          ),
          Icon(Icons.keyboard_arrow_down,
              color: const Color(0xFF9F7AEA), size: 22.sp),
        ]),
      ),
    );
  }

  /// Amount input card with a Max button, unit toggle (fiat/crypto), live ≈
  /// conversion, and over-balance error.
  Widget _buildAmountCard() {
    final h = _selected;
    final over = h != null && _cryptoAmount > h.quantity;
    final canToggle = _priceOf > 0;
    final sym = h?.cryptoSymbol.toUpperCase() ?? '';
    final fiatCode = CurrencySymbols.currentCurrency.toUpperCase();
    final fiatSym = CurrencySymbols.currentSymbol;
    // The "≈" line shows the OTHER unit's value.
    final approx = _amountInFiat
        ? (_cryptoAmount > 0 ? '≈ ${_trimNum(_cryptoAmount)} $sym' : '')
        : (_fiatAmount > 0 ? '≈ $fiatSym${_fiatAmount.toStringAsFixed(2)}' : '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF161616), Color(0xFF0C0C0C)],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
                color: over
                    ? const Color(0xFFEF4444).withValues(alpha: 0.55)
                    : const Color(0xFF7C3AED).withValues(alpha: 0.28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Amount',
                      style: GoogleFonts.inter(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.7))),
                  if (h != null)
                    GestureDetector(
                      // FLOOR both units so Max never parses back ABOVE the
                      // holding: fiat rounds UP → implied crypto (fiat/price)
                      // exceeds balance → "Amount exceeds your balance"; crypto
                      // _trimNum rounds at 8dp → same over-balance tick. Flooring
                      // leaves only dust unsent (money-safe, never an over-send).
                      onTap: () => setState(() => _amountController.text =
                          _amountInFiat
                              ? ((h.quantity * _priceOf * 100).floorToDouble() /
                                      100)
                                  .toStringAsFixed(2)
                              : _trimNum((h.quantity * 1e8).floorToDouble() /
                                  1e8)),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withValues(alpha: 0.16),
                          borderRadius: BorderRadius.circular(9.r),
                          border: Border.all(
                              color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
                        ),
                        child: Text('Max',
                            style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF3B82F6))),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 14.h),
              Row(children: [
                Expanded(
                  child: TextField(
                    controller: _amountController,
                    onChanged: (_) => setState(() {}),
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
                    ],
                    style: GoogleFonts.inter(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      hintText: '0.00',
                      hintStyle: GoogleFonts.inter(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.25)),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                // Unit chip doubles as the fiat<->crypto toggle.
                GestureDetector(
                  onTap: canToggle ? _toggleAmountUnit : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9F7AEA).withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(9.r),
                      border: Border.all(
                          color: const Color(0xFF9F7AEA).withValues(alpha: 0.35)),
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text(_amountInFiat ? fiatCode : sym,
                          style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF9F7AEA))),
                      if (canToggle) ...[
                        SizedBox(width: 4.w),
                        Icon(Icons.swap_vert_rounded,
                            size: 16.sp, color: const Color(0xFF9F7AEA)),
                      ],
                    ]),
                  ),
                ),
              ]),
              if (approx.isNotEmpty) ...[
                SizedBox(height: 8.h),
                Text(approx,
                    style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        color: Colors.white.withValues(alpha: 0.55))),
              ],
            ],
          ),
        ),
        if (over)
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 4.w),
            child: Row(children: [
              Icon(Icons.error_outline, size: 13.sp, color: const Color(0xFFEF4444)),
              SizedBox(width: 4.w),
              Text('Exceeds your ${h.cryptoSymbol.toUpperCase()} balance',
                  style: GoogleFonts.inter(
                      fontSize: 12.sp, color: const Color(0xFFEF4444))),
            ]),
          ),
      ],
    );
  }

  Widget _buildRecipientToggle() {
    Widget seg(String label, IconData icon, bool selected, VoidCallback onTap) {
      return Expanded(
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(vertical: 11.h),
            decoration: BoxDecoration(
              gradient: selected
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF8B5CF6), Color(0xFF4E03D0)])
                  : null,
              color: selected ? null : const Color(0xFF161616),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                  color: selected
                      ? Colors.transparent
                      : const Color(0xFF2D2D2D)),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(icon,
                  size: 15.sp,
                  color: selected ? Colors.white : const Color(0xFF9CA3AF)),
              SizedBox(width: 6.w),
              Text(label,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : const Color(0xFF9CA3AF))),
            ]),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0C0C0C),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(children: [
        seg('External address', Icons.link_rounded, !_isInternal,
            () => setState(() => _isInternal = false)),
        SizedBox(width: 4.w),
        seg('Lazervault user', Icons.person_rounded, _isInternal,
            () => setState(() => _isInternal = true)),
      ]),
    );
  }

  // Recipient picker for the "Lazervault user" (internal) mode. Opens the
  // canonical unified user search; the picked user's id drives a free/instant
  // internal transfer (the server resolves their Quidax sub-account — no
  // address, no network to match).
  Widget _buildRecipientPicker() {
    final hasRecipient = (_recipientUserId ?? '').isNotEmpty;
    return GestureDetector(
      onTap: _pickRecipient,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF161616),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(children: [
          Icon(Icons.person_search_rounded,
              size: 18.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(width: 10.w),
          Expanded(
            child: hasRecipient
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_recipientDisplay ?? 'Lazervault user',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600)),
                      if ((_recipientUsername ?? '').isNotEmpty)
                        Text('@${_recipientUsername!}',
                            style: GoogleFonts.inter(
                                color: const Color(0xFF9CA3AF),
                                fontSize: 12.sp)),
                    ],
                  )
                : Text('Select a Lazervault recipient',
                    style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF), fontSize: 14.sp)),
          ),
          if (hasRecipient)
            GestureDetector(
              onTap: () => setState(() {
                _recipientUserId = null;
                _recipientUsername = null;
                _recipientDisplay = null;
              }),
              child: Icon(Icons.close_rounded,
                  size: 18.sp, color: const Color(0xFF9CA3AF)),
            )
          else
            Icon(Icons.chevron_right_rounded,
                size: 18.sp, color: const Color(0xFF9CA3AF)),
        ]),
      ),
    );
  }

  Widget _buildAdvancedNetworkToggle() {
    return GestureDetector(
      onTap: () => setState(() => _advancedOnNetwork = !_advancedOnNetwork),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0C0C0C),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(children: [
          Icon(Icons.hub_outlined, size: 16.sp, color: const Color(0xFF9CA3AF)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Send on a specific network',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600)),
              Text(
                  _advancedOnNetwork
                      ? 'Uses the recipient’s deposit address on the chosen chain'
                      : 'Advanced. Default is an instant, free internal transfer',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 11.sp)),
            ]),
          ),
          Switch.adaptive(
            value: _advancedOnNetwork,
            activeTrackColor: const Color(0xFF4E03D0),
            onChanged: (v) => setState(() => _advancedOnNetwork = v),
          ),
        ]),
      ),
    );
  }

  Future<void> _pickRecipient() async {
    final result = await UnifiedUserSearchSheet.show(
      context,
      title: 'Send crypto to',
      subtitle: 'Search any Lazervault user',
      // Crypto variant: only Lazervault users (they receive an internal Quidax
      // sub→sub transfer) — external/bank recipients are filtered out inside
      // the sheet, so there's nothing here that can't receive crypto.
      internalOnly: true,
    );
    if (result == null || !mounted) return;
    // Defensive: internalOnly should guarantee a userId, but never proceed
    // without one (an internal transfer is keyed entirely on the recipient's
    // userId).
    if (result.userId.isEmpty) {
      _toast("That recipient can't receive crypto — pick a Lazervault user");
      return;
    }
    setState(() {
      _recipientUserId = result.userId;
      _recipientUsername = result.username;
      _recipientDisplay = result.displayName.isNotEmpty
          ? result.displayName
          : (result.name.isNotEmpty ? result.name : result.username);
    });
  }

  Widget _buildNetworkSelector() {
    // Dropdown sourced from GetSupportedAssetNetworks (withdraw-enabled rows).
    // While loading: a compact loader. When the asset has no configured
    // networks (or the call failed): fall back to a free-text field so the
    // user is never blocked — an empty value means Quidax's default network.
    if (_loadingNetworks) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
        decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(children: [
          LazerVaultLoader.tiny(),
          SizedBox(width: 12.w),
          Text('Loading networks…',
              style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
        ]),
      );
    }
    if (_networks.isEmpty) {
      return _buildField(
        _networkController,
        'Network (e.g. trc20, erc20, bep20)',
        onChanged: (_) => _revalidateAddress(),
      );
    }
    // Emphasized network card. Sending on the wrong chain can lose funds,
    // so the choice is loud (accent border + prominent "Change" affordance)
    // and opens the shared picker sheet rather than a subtle dropdown.
    const accent = Color(0xFF7C3AED);
    final sym = _selected!.cryptoSymbol.toUpperCase();
    final hasSelection =
        _networks.any((n) => n.network == _selectedNetwork);
    final label =
        hasSelection ? _networkNameFor(_selectedNetwork!) : 'Choose network';
    final canChange = _networks.length > 1;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            accent.withValues(alpha: 0.16),
            accent.withValues(alpha: 0.06),
          ],
        ),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: accent.withValues(alpha: 0.40)),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.w,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.lan_rounded,
                color: const Color(0xFF93C5FD), size: 18.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Send network',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  hasSelection
                      ? 'Sending $sym on $label'
                      : 'Pick the network to send on',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Material(
            color: canChange ? accent : accent.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(10.r),
            child: InkWell(
              onTap: canChange || !hasSelection ? _pickSendNetwork : null,
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      canChange ? 'Change' : label,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (canChange) ...[
                      SizedBox(width: 4.w),
                      Icon(Icons.keyboard_arrow_down_rounded,
                          color: Colors.white, size: 16.sp),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Plain network name for a slug (no fee suffix), for the emphasized card.
  String _networkNameFor(String slug) {
    for (final n in _networks) {
      if (n.network == slug) {
        return n.networkName.isEmpty ? n.network.toUpperCase() : n.networkName;
      }
    }
    return slug.toUpperCase();
  }

  /// Opens the shared network picker for the send flow. `_networks` is already
  /// filtered to withdraw-enabled chains at load time. Stores the chosen slug
  /// in `_selectedNetwork` (the same var the withdraw call reads).
  Future<void> _pickSendNetwork() async {
    if (_selected == null || _networks.isEmpty) return;
    final sym = _selected!.cryptoSymbol.toUpperCase();
    final chosen = await showNetworkPickerSheet(
      context,
      currency: _selected!.cryptoSymbol.toLowerCase(),
      networks: _networks,
      selectedNetwork: _selectedNetwork,
      title: 'Send $sym via',
      subtitle:
          'Pick the network to send on. Sending on the wrong network can lose funds.',
    );
    if (chosen == null || !mounted) return;
    setState(() => _selectedNetwork = chosen);
    // A valid address for the old chain may be invalid for the new one.
    _revalidateAddress();
  }

  /// Re-runs address validation against the current network. Called when the
  /// address text OR the selected network changes (a valid ETH address becomes
  /// invalid the moment the user switches to the TRON network, etc.).
  void _revalidateAddress() {
    final err = validateCryptoAddress(
      network: _networkValue(),
      address: _addressController.text,
    );
    if (err != _addressError) {
      setState(() => _addressError = err);
    }
  }

  /// True when the form can be submitted. External sends additionally require a
  /// non-empty, structurally-valid destination address.
  bool get _canSubmit {
    if (_isInternal) return true;
    final addr = _addressController.text.trim();
    if (addr.isEmpty) return false;
    return _addressError == null;
  }

  /// Open the camera to scan the recipient's crypto-address QR, then fill the
  /// address field with the parsed address. Validated against the selected
  /// network exactly like a typed/pasted address — a scanned wrong-chain address
  /// is caught the same way (an irreversible-loss guard), never silently sent.
  Future<void> _scanRecipientAddress() async {
    final scanned = await Get.to<String>(
      () => const CryptoAddressScannerScreen(),
      fullscreenDialog: true,
    );
    if (scanned == null || !mounted) return;
    final addr = scanned.trim();
    if (addr.isEmpty) return;
    _addressController.text = addr;
    final err = validateCryptoAddress(network: _networkValue(), address: addr);
    setState(() => _addressError = err);
    if (err != null) {
      Get.snackbar(
        'Check the network',
        "The scanned address doesn't match the selected "
            '${_networkValue().toUpperCase()} network. Make sure you picked the '
            'right network before sending.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    }
  }

  /// Destination-address field for external sends, with inline per-network
  /// validation and a hard max-length cap.
  Widget _buildAddressField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _addressController,
          maxLength: kMaxCryptoAddressLength,
          buildCounter: (_,
                  {required int currentLength,
                  required bool isFocused,
                  int? maxLength}) =>
              null,
          onChanged: (_) => _revalidateAddress(),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            hintText: 'Destination address',
            hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: _addressError == null
                    ? BorderSide.none
                    : const BorderSide(color: Color(0xFFEF4444))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                    color: _addressError == null
                        ? const Color(0xFF7C3AED)
                        : const Color(0xFFEF4444))),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
            // Scan the recipient's address QR — the alternative to typing/
            // pasting. Fills the same field, validated the same way.
            suffixIcon: IconButton(
              tooltip: 'Scan address QR',
              icon: Icon(Icons.qr_code_scanner_rounded,
                  color: const Color(0xFF7C3AED), size: 22.sp),
              onPressed: _scanRecipientAddress,
            ),
          ),
        ),
        if (_addressError != null) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.error_outline,
                  size: 14.sp, color: const Color(0xFFEF4444)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  _addressError!,
                  style: GoogleFonts.inter(
                      color: const Color(0xFFEF4444), fontSize: 12.sp),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  /// Bottom send CTA — purple gradient (matches the crypto theme; the flow was
  /// the only screen still on the generic blue) with a send icon. Disabled +
  /// greyed while submitting or when the form isn't submittable.
  Widget _buildSendCta({required bool busy}) {
    final enabled = !busy && _canSubmit;
    return GestureDetector(
      onTap: enabled ? _onSend : null,
      child: Container(
        height: 52.h,
        decoration: BoxDecoration(
          gradient: enabled
              ? const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF4E03D0)])
              : null,
          color: enabled ? null : const Color(0xFF3A3A3A),
          borderRadius: BorderRadius.circular(12.r),
        ),
        alignment: Alignment.center,
        child: busy
            ? LazerVaultLoader.tiny()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_upward_rounded,
                      size: 18.sp,
                      color: enabled ? Colors.white : const Color(0xFF9CA3AF)),
                  SizedBox(width: 8.w),
                  Text('Send',
                      style: GoogleFonts.inter(
                          color:
                              enabled ? Colors.white : const Color(0xFF9CA3AF),
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp)),
                ],
              ),
      ),
    );
  }

  Widget _buildField(TextEditingController c, String label,
      {TextInputType? keyboardType,
      List<TextInputFormatter>? inputFormatters,
      ValueChanged<String>? onChanged}) {
    return TextField(
      controller: c,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        hintText: label,
        hintStyle: GoogleFonts.inter(color: const Color(0xFF9CA3AF)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none),
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      ),
    );
  }
}

/// Immutable snapshot of a submitted send — captured at PIN-confirm time so the
/// receipt screen can render the crypto amount, recipient, and network without
/// re-reading the (possibly-cleared) form controllers.
class _SentDetails {
  final double amount;
  final String symbol;
  final String recipient;
  final String network;
  final String note;
  final bool isInternal;
  const _SentDetails({
    required this.amount,
    required this.symbol,
    required this.recipient,
    required this.network,
    required this.note,
    required this.isInternal,
  });
}
