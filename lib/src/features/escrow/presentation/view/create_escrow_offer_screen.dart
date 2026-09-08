import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../widgets/escrow_offer_fund_sheet.dart';
import 'package:lazervault/src/features/recipients/domain/entities/unified_search_result.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/unified_user_search_sheet.dart';

import '../../data/services/escrow_media_upload_service.dart';
import '../cubit/escrow_cubit.dart';
import '../widgets/escrow_attachment_picker.dart';
import 'escrow_theme.dart';

part 'create_escrow_offer_screen_widgets.dart';

/// Publish an escrow OFFER — the money-free first half of a standard
/// two-sided escrow.
///
/// Route args: {'direction': 'sell_offer' | 'buy_request'} (default sell).
///   sell_offer  — "Sell something": list the item (specs, photos, price);
///                 address it to a buyer OR leave open and share by link.
///   buy_request — "Request to buy": describe what you want from a NAMED
///                 seller; they must accept before you fund.
///
/// NO PIN and NO fund-from here — nothing moves. The PIN gate lives where the
/// money is: the buyer's funding sheet on the offer page.
class CreateEscrowOfferScreen extends StatefulWidget {
  const CreateEscrowOfferScreen({super.key});

  @override
  State<CreateEscrowOfferScreen> createState() =>
      _CreateEscrowOfferScreenState();
}

class _CreateEscrowOfferScreenState extends State<CreateEscrowOfferScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 3;

  String _direction = 'sell_offer';
  bool get _isSell => _direction == 'sell_offer';

  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();

  UnifiedSearchResult? _counterparty;
  String _counterpartyQuery = '';
  // Item condition grade. Required for a sell listing (a marketplace listing
  // without a grade is what condition disputes are made of); optional for a
  // buy request ('' = any condition is acceptable).
  String _condition = '';
  int _deliveryDays = 0;
  List<EscrowMediaUploadResult> _media = const [];
  bool _submitting = false;

  /// setState bridge for the part-file extension (setState is protected and
  /// unreachable from an extension).
  void _refresh([VoidCallback? fn]) => setState(fn ?? () {});

  List<String> get _pageNames => _isSell
      ? const ['What you\'re selling', 'Price & terms', 'Review & publish']
      : const ['What you want', 'Price & terms', 'Review & send'];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map && args['direction'] is String) {
      final d = args['direction'] as String;
      if (d == 'buy_request' || d == 'sell_offer') _direction = d;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  double get _amount => double.tryParse(_amountCtrl.text.trim()) ?? 0;

  bool get _page1Valid {
    if (_titleCtrl.text.trim().isEmpty) return false;
    // A buy request must name its seller; a sell offer may stay open.
    if (!_isSell && _counterparty == null) return false;
    if (_isSell && _condition.isEmpty) return false;
    return true;
  }

  bool get _page2Valid => _amount > 0;

  void _next() {
    if (_currentPage == 0 && !_page1Valid) {
      showAppSnackbar(
          'Escrow Pay',
          _titleCtrl.text.trim().isEmpty
              ? (_isSell
                  ? 'Give your listing a title.'
                  : 'Describe what you want to buy.')
              : (_isSell && _condition.isEmpty
                  ? 'Pick the item\'s condition.'
                  : 'Search for and select the seller.'),
          type: AppSnackbarType.error);
      return;
    }
    if (_currentPage == 1 && !_page2Valid) {
      showAppSnackbar('Escrow Pay', 'Enter a valid amount.',
          type: AppSnackbarType.error);
      return;
    }
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  void _back() {
    if (_currentPage == 0) {
      Get.back();
    } else {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  Future<void> _pickCounterparty() async {
    final result = await UnifiedUserSearchSheet.show(
      context,
      title: _isSell ? 'Offer to (optional)' : 'Find the seller',
      subtitle: _isSell
          ? 'Pick a buyer, or skip and share the offer by link instead.'
          : 'The seller must be on Lazervault. They\'ll review and accept before you pay.',
      internalOnly: true,
    );
    if (result == null) return;
    setState(() {
      _counterparty = result;
      _counterpartyQuery = result.username.isNotEmpty
          ? result.username
          : (result.phoneNumber.isNotEmpty ? result.phoneNumber : result.email);
    });
  }

  Future<void> _publish() async {
    // Guard set BEFORE the first await so a double-tap can't publish twice.
    if (_submitting) return;
    setState(() => _submitting = true);
    final cubit = context.read<EscrowCubit>();
    try {
      final offer = await cubit.createOffer(
        direction: _direction,
        counterpartyQuery: _counterpartyQuery,
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        amount: _amount,
        deliveryDeadlineDays: _deliveryDays,
        condition: _condition,
      );
      if (offer == null) return; // listener surfaced the error

      // Attach listing media (best effort — never blocks the published offer,
      // but the loss is surfaced, same contract as the deal flow).
      if (_media.isNotEmpty) {
        var failed = 0;
        for (final m in _media) {
          final ok = await cubit.addOfferAttachment(
            offerId: offer.id,
            mediaKind: m.mediaKind,
            url: m.publicUrl,
            contentType: m.contentType,
            sizeBytes: m.sizeBytes,
            durationSeconds: m.durationSeconds,
          );
          if (!ok) failed++;
        }
        final warning = escrowAttachWarning(failed);
        if (warning != null) {
          Get.snackbar('Some media not attached', warning,
              backgroundColor: EscrowTheme.error,
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 6),
              margin: EdgeInsets.all(12.w));
        }
      }

      // A buyer-created escrow holds the money AT CREATION — no separate
      // funding stage later. Open the funding sheet right here so publish →
      // PIN → funded deal is one continuous flow. A sell listing stays money-
      // free and just lands on its shareable offer page.
      if (!_isSell && mounted) {
        final deal = await showEscrowOfferFundSheet(context, offer: offer);
        if (deal != null && mounted) {
          Get.offNamed(AppRoutes.escrowReceipt,
              arguments: {'deal': deal, 'kind': 'funded'});
          return;
        }
        // Dismissed without funding: the request is created but unpaid. Land on
        // the offer page where the "Fund the escrow now" button still finishes it.
      }
      Get.offNamed(AppRoutes.escrowOfferView, arguments: {'offerId': offer.id});
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(_isSell ? 'Sell with escrow' : 'Request to buy',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
      ),
      body: BlocListener<EscrowCubit, EscrowState>(
        listener: (context, state) {
          if (state is EscrowError) {
            showAppSnackbar('Escrow Pay', state.message,
                type: AppSnackbarType.error);
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              _progress(),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    _page1Details(),
                    _page2Terms(),
                    _page3Review(),
                  ],
                ),
              ),
              _navButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
