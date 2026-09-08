import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

import '../../data/services/escrow_share_service.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import '../cubit/escrow_cubit.dart';
import '../widgets/escrow_media_viewer.dart';
import '../widgets/escrow_offer_fund_sheet.dart';
import 'escrow_theme.dart';

/// Escrow OFFER view — the listing page both sides see before money moves.
///
/// Entry points (Get.arguments as Map, or path params from deep links):
///   {'offerId': …}     — party opening from home / a notification
///   {'shareToken': …}  — share-link / web-handoff entry (any signed-in user)
///
/// Role-aware CTAs:
///   buyer (addressed, or link-opener on an open sell_offer) → Buy securely
///   seller on a buy_request                                → Accept / Decline
///   creator                                                → Share / Withdraw
///   terminal states                                        → status banner
class EscrowOfferViewScreen extends StatefulWidget {
  const EscrowOfferViewScreen({super.key});

  @override
  State<EscrowOfferViewScreen> createState() => _EscrowOfferViewScreenState();
}

class _EscrowOfferViewScreenState extends State<EscrowOfferViewScreen> {
  final _share = EscrowShareService();
  String _offerId = '';
  String _shareToken = '';

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map) {
      _offerId = (args['offerId'] as String?) ?? '';
      _shareToken = (args['shareToken'] as String?) ?? '';
    }
    _shareToken = _shareToken.isNotEmpty
        ? _shareToken
        : (Get.parameters['shareToken'] ?? '');
    _offerId =
        _offerId.isNotEmpty ? _offerId : (Get.parameters['offerId'] ?? '');
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  void _load() {
    final cubit = context.read<EscrowCubit>();
    if (_offerId.isNotEmpty) {
      cubit.loadOffer(_offerId);
    } else if (_shareToken.isNotEmpty) {
      cubit.loadOfferByShareToken(_shareToken);
    } else {
      // Neither identifier arrived — a malformed link, or a deep link whose
      // arguments were lost. Surface the same "not available" state the error
      // path uses rather than sitting on a blank spinner forever.
      cubit.failOfferLoad('This link is missing its offer reference.');
    }
  }

  Future<void> _buy(EscrowOfferEntity offer) async {
    final deal = await showEscrowOfferFundSheet(context, offer: offer);
    if (deal != null && mounted) {
      Get.offNamed(AppRoutes.escrowReceipt,
          arguments: {'deal': deal, 'kind': 'funded'});
    }
  }

  // Show the "not addressed to you" dialog exactly once per screen when a
  // share link meant for a specific person is opened by someone else.
  bool _foreignPrompted = false;
  void _maybeWarnForeignViewer(EscrowOfferEntity offer, String userId) {
    if (_foreignPrompted) return;
    if (!offer.isOpen) return; // taken/terminal links get a status banner instead
    if (!offer.isForeignViewer(userId)) return;
    _foreignPrompted = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final who =
          offer.counterpartyName.isNotEmpty ? offer.counterpartyName : 'someone else';
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: EscrowTheme.card,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r)),
          title: Text('This escrow isn\'t for you',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700)),
          content: Text(
              'This ${offer.isSellOffer ? 'listing' : 'request'} is addressed to $who. '
              'You can see the details, but only they can confirm or decline it.',
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary, fontSize: 13.5.sp, height: 1.5)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text('Got it',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      );
    });
  }

  // Decline only — there is no separate acceptance stage. Confirming an offer
  // is funding it; declining marks it declined and notifies the creator.
  Future<void> _respond(EscrowOfferEntity offer, bool accept) async {
    final cubit = context.read<EscrowCubit>();
    final note = await _noteSheet(
      title: offer.isSellOffer ? 'Decline this offer?' : 'Decline this request?',
      subtitle:
          'The ${offer.isSellOffer ? 'seller' : 'buyer'} will be notified. You can add a short reason.',
      confirmLabel: 'Decline',
      accent: EscrowTheme.error,
    );
    if (note == null) return;
    await cubit.respondOffer(offerId: offer.id, accept: false, note: note);
  }

  Future<void> _cancel(EscrowOfferEntity offer) async {
    final note = await _noteSheet(
      title: 'Withdraw this offer?',
      subtitle:
          'It will no longer be viewable or fundable. This can\'t be undone.',
      confirmLabel: 'Withdraw offer',
      accent: EscrowTheme.error,
    );
    if (note == null) return;
    if (!mounted) return;
    await context.read<EscrowCubit>().cancelOffer(offer.id);
  }

  Future<String?> _noteSheet({
    required String title,
    required String subtitle,
    required String confirmLabel,
    required Color accent,
  }) {
    final ctrl = TextEditingController();
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: EscrowTheme.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 6.h),
            Text(subtitle,
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
            SizedBox(height: 14.h),
            TextField(
              controller: ctrl,
              maxLines: 2,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: 'Add a note (optional)',
                hintStyle: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 13.sp),
                filled: true,
                fillColor: EscrowTheme.bg,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: EscrowTheme.border)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: accent)),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx, ctrl.text.trim()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: accent,
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(confirmLabel,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareOffer(EscrowOfferEntity offer) {
    if (offer.shareToken.isEmpty) return;
    final url = _share.shareUrlForToken(offer.shareToken);
    SharePlus.instance.share(ShareParams(
      sharePositionOrigin: const Rect.fromLTWH(0, 0, 1, 1),
      text:
          '${offer.title} — ${_money(offer)} on Lazervault Escrow Pay. Buy it securely: $url',
    ));
  }

  void _copyLink(EscrowOfferEntity offer) {
    if (offer.shareToken.isEmpty) return;
    Clipboard.setData(
        ClipboardData(text: _share.shareUrlForToken(offer.shareToken)));
    showAppSnackbar('Escrow Pay', 'Link copied',
        type: AppSnackbarType.success);
  }

  void _showQr(EscrowOfferEntity offer) {
    if (offer.shareToken.isEmpty) return;
    final url = _share.shareUrlForToken(offer.shareToken);
    showDialog<void>(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: EscrowTheme.card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Scan to view this offer',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 14.h),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r)),
                child: QrImageView(data: url, size: 200.w),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Done',
                    style: GoogleFonts.inter(
                        color: EscrowTheme.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _money(EscrowOfferEntity o) =>
      '${o.currency} ${NumberFormat('#,##0.00').format(o.amount)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Escrow offer',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700)),
      ),
      body: BlocConsumer<EscrowCubit, EscrowState>(
        listener: (context, state) {
          if (state is EscrowError) {
            showAppSnackbar('Escrow Pay', state.message,
                type: AppSnackbarType.error);
          }
          if (state is EscrowOfferActionSuccess) {
            showAppSnackbar('Escrow Pay', state.message,
                type: AppSnackbarType.success);
          }
          if (state is EscrowActionSuccess && state.deal.isFunded) {
            // Funding succeeded through the sheet's cubit call while this
            // screen listens — the sheet handles navigation; nothing here.
          }
        },
        builder: (context, state) {
          if (state is EscrowOfferLoaded) {
            _maybeWarnForeignViewer(state.offer, state.currentUserId);
            return _body(state.offer, state.currentUserId);
          }
          if (state is EscrowOfferActionSuccess) {
            return _body(state.offer, null);
          }
          if (state is EscrowError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.link_off_rounded,
                        color: EscrowTheme.textSecondary, size: 44.sp),
                    SizedBox(height: 10.h),
                    Text('This offer isn\'t available',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(height: 6.h),
                    Text(state.message,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                            color: EscrowTheme.textSecondary,
                            fontSize: 12.5.sp)),
                    SizedBox(height: 14.h),
                    TextButton(
                        onPressed: _load,
                        child: Text('Try again',
                            style: GoogleFonts.inter(
                                color: EscrowTheme.primary,
                                fontSize: 13.5.sp,
                                fontWeight: FontWeight.w600))),
                  ],
                ),
              ),
            );
          }
          return const Center(child: LazerVaultLoader.large());
        },
      ),
    );
  }

  Widget _body(EscrowOfferEntity offer, String? uid) {
    final userId = uid ?? '';
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Text(offer.title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700)),
              ),
              EscrowTheme.offerStatusChip(offer.status),
            ]),
            SizedBox(height: 4.h),
            Text(
                offer.isSellOffer
                    ? 'Listed by ${offer.creatorName.isNotEmpty ? offer.creatorName : 'a Lazervault user'}'
                    : 'Requested by ${offer.creatorName.isNotEmpty ? offer.creatorName : 'a Lazervault user'}',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 12.sp)),
            SizedBox(height: 16.h),
            _priceCard(offer),
            if (offer.attachments.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _mediaGallery(offer),
            ],
            if (offer.description.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Text('Details',
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600)),
              SizedBox(height: 6.h),
              Text(offer.description,
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: 13.5.sp, height: 1.5)),
            ],
            SizedBox(height: 16.h),
            _metaCard(offer),
            if (offer.isDeclined && offer.declineReason.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _banner(offer.declineReason, EscrowTheme.error),
            ],
            SizedBox(height: 24.h),
            ..._actions(offer, userId),
            SizedBox(height: 8.h),
            _disclaimer(),
          ],
        ),
      ),
    );
  }

  Widget _priceCard(EscrowOfferEntity offer) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0x1A4E03D0), EscrowTheme.card],
          ),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: EscrowTheme.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 12.sp)),
            SizedBox(height: 4.h),
            Text(_money(offer),
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700)),
            SizedBox(height: 6.h),
            Text('Held in escrow until you confirm delivery',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            if (EscrowTheme.conditionChip(offer.condition) != null) ...[
              SizedBox(height: 8.h),
              EscrowTheme.conditionChip(offer.condition)!,
            ],
          ],
        ),
      );

  Widget _mediaGallery(EscrowOfferEntity offer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Photos & video',
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: [
              for (final a in offer.attachments) _thumb(a),
            ],
          ),
        ],
      );

  Widget _thumb(EscrowAttachmentEntity a) {
    final box = 104.w;
    final heroTag = 'escrow-offer-media-${a.id}';
    void open() => showEscrowMediaViewer(context,
        url: a.url, isVideo: a.isVideo, heroTag: heroTag);
    return GestureDetector(
      onTap: open,
      child: Hero(
        tag: heroTag,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: a.isVideo
              ? Container(
                  width: box,
                  height: box,
                  color: Colors.black,
                  child: Icon(Icons.play_circle_outline,
                      color: Colors.white, size: 30.sp),
                )
              : Image.network(a.url,
                  width: box,
                  height: box,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                        width: box,
                        height: box,
                        color: EscrowTheme.card,
                        child: Icon(Icons.broken_image_outlined,
                            color: EscrowTheme.textSecondary, size: 22.sp),
                      )),
        ),
      ),
    );
  }

  Widget _metaCard(EscrowOfferEntity offer) {
    final fmt = DateFormat('d MMM yyyy');
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(children: [
        _metaRow('Reference', offer.reference),
        if (offer.condition.isNotEmpty)
          _metaRow(offer.isSellOffer ? 'Condition' : 'Condition wanted',
              EscrowTheme.conditionLabel(offer.condition)),
        if (offer.counterpartyName.isNotEmpty)
          _metaRow(
              offer.isSellOffer
                  ? (offer.isConverted ? 'Bought by' : 'Offered to')
                  : 'Seller',
              offer.counterpartyName),
        if (offer.deliveryDeadlineDays > 0)
          _metaRow('Delivery window', '${offer.deliveryDeadlineDays} days'),
        if (offer.isOpen && offer.expiresAt != null)
          _metaRow('Offer expires', fmt.format(offer.expiresAt!)),
        if (offer.isAwaitingFunding && offer.fundingDeadlineAt != null)
          _metaRow('Fund before', fmt.format(offer.fundingDeadlineAt!)),
      ]),
    );
  }

  Widget _metaRow(String l, String v) => Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110.w,
              child: Text(l,
                  style: GoogleFonts.inter(
                      color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
            ),
            Expanded(
              child: Text(v,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      );

  Widget _banner(String text, Color color) => Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(text,
            style: GoogleFonts.inter(color: color, fontSize: 12.5.sp)),
      );

  List<Widget> _actions(EscrowOfferEntity offer, String userId) {
    final out = <Widget>[];

    // Terminal states first — status-aware AND party-aware, so a later opener
    // of a taken link sees an honest "no longer available" instead of buy
    // buttons or a wrong "addressed to someone else" warning.
    if (offer.isTerminal) {
      final isCreator = offer.viewerIsCreator || offer.creatorUserId == userId;
      final isCounterparty = offer.counterpartyUserId.isNotEmpty &&
          offer.counterpartyUserId == userId;
      final isParty = isCreator || isCounterparty;
      final thing = offer.isSellOffer ? 'listing' : 'request';
      if (offer.isConverted) {
        final who = offer.counterpartyName.isNotEmpty
            ? offer.counterpartyName
            : 'the buyer';
        if (offer.isSellOffer) {
          if (isCreator) {
            out.add(_banner(
                'Sold to $who — the money is held in escrow. Deliver to get paid.',
                EscrowTheme.success));
          } else if (isCounterparty) {
            out.add(_banner(
                'You bought this. Track delivery and release the money from the deal.',
                EscrowTheme.success));
          } else {
            out.add(_banner(
                'This listing has already been bought and is no longer available.',
                EscrowTheme.warning));
          }
        } else {
          if (isCreator) {
            out.add(_banner(
                'You funded this request — the money is held in escrow until delivery.',
                EscrowTheme.success));
          } else if (isCounterparty) {
            out.add(_banner(
                '${offer.creatorName.isNotEmpty ? offer.creatorName : 'The buyer'} funded this request. Deliver to get paid.',
                EscrowTheme.success));
          } else {
            out.add(_banner(
                'This request has already been funded and is no longer available.',
                EscrowTheme.warning));
          }
        }
        if (isParty && offer.dealId.isNotEmpty) {
          out.add(_primaryBtn('View the deal', () {
            Get.toNamed(AppRoutes.escrowDetail, arguments: offer.dealId);
          }));
        }
        return out;
      }
      if (offer.isDeclined) {
        final reason = offer.declineReason.isNotEmpty
            ? ' Reason: ${offer.declineReason}'
            : '';
        out.add(_banner(
            isParty
                ? 'This $thing was declined.$reason'
                : 'This $thing is no longer available.',
            EscrowTheme.error));
        return out;
      }
      if (offer.isCancelled) {
        out.add(_banner(
            isCreator
                ? 'You withdrew this $thing.'
                : 'This $thing was withdrawn and is no longer available.',
            EscrowTheme.warning));
        return out;
      }
      out.add(_banner(
          'This $thing expired before it was completed.', EscrowTheme.warning));
      return out;
    }

    // Someone who opened a share link meant for a specific person: view-only,
    // no confirm/decline. The modal (shown on load) already explained why.
    if (offer.isForeignViewer(userId)) {
      out.add(_banner(
          'This escrow is addressed to ${offer.counterpartyName.isNotEmpty ? offer.counterpartyName : 'someone else'}. '
          'Only they can confirm or decline it.',
          EscrowTheme.warning));
      return out;
    }

    // Confirmation IS the money action: fund a sell listing / a buy request.
    if (offer.canFund(userId)) {
      out.add(_primaryBtn(
          offer.isSellOffer ? 'Buy securely' : 'Fund the escrow now',
          () => _buy(offer)));
    }
    // The addressed counterparty can DECLINE while the offer is still open.
    if (offer.canDecline(userId)) {
      out.add(_secondaryBtn(
          'Decline', EscrowTheme.error, () => _respond(offer, false)));
    }
    if (offer.viewerIsCreator || offer.creatorUserId == userId) {
      if (!offer.isTerminal && offer.shareToken.isNotEmpty) {
        out.add(Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(children: [
            Expanded(
                child: _utilityBtn(
                    'Share link', Icons.ios_share, () => _shareOffer(offer))),
            SizedBox(width: 10.w),
            Expanded(
                child: _utilityBtn(
                    'Copy', Icons.copy_rounded, () => _copyLink(offer))),
            SizedBox(width: 10.w),
            Expanded(
                child: _utilityBtn(
                    'QR', Icons.qr_code_2_rounded, () => _showQr(offer))),
          ]),
        ));
      }
      if (offer.canCancel(userId)) {
        out.add(_secondaryBtn(
            'Withdraw offer', EscrowTheme.error, () => _cancel(offer)));
      }
    }
    if (out.isEmpty) {
      final (label, color) = EscrowTheme.offerStatusMeta(offer.status);
      out.add(_banner('This offer is ${label.toLowerCase()}.', color));
    }
    return out;
  }

  Widget _primaryBtn(String label, VoidCallback onTap) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: EscrowTheme.primary,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(label,
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w700)),
          ),
        ),
      );

  Widget _secondaryBtn(String label, Color color, VoidCallback onTap) =>
      Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: color),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(label,
                style: GoogleFonts.inter(
                    color: color,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      );

  Widget _utilityBtn(String label, IconData icon, VoidCallback onTap) =>
      TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, color: EscrowTheme.primaryLight, size: 17.sp),
        label: Text(label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
                color: EscrowTheme.primaryLight,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600)),
        style: TextButton.styleFrom(
          backgroundColor: EscrowTheme.primary.withValues(alpha: 0.14),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
            side: BorderSide(
                color: EscrowTheme.primaryLight.withValues(alpha: 0.45)),
          ),
        ),
      );

  Widget _disclaimer() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user_outlined,
              color: EscrowTheme.textSecondary, size: 14.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'Money moves only after both sides agree. The buyer\'s payment is held by Lazervault and released to the seller after the buyer confirms delivery.',
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary,
                  fontSize: 11.sp,
                  height: 1.5),
            ),
          ),
        ],
      );
}
