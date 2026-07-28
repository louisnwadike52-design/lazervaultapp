import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../../data/services/escrow_image_upload_service.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/shared_widgets/app_loading_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/escrow_cubit.dart';
import '../widgets/escrow_shimmer.dart';
import '../widgets/escrow_empty_state.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import 'escrow_theme.dart';

class EscrowDealDetailScreen extends StatefulWidget {
  const EscrowDealDetailScreen({super.key});

  @override
  State<EscrowDealDetailScreen> createState() => _EscrowDealDetailScreenState();
}

class _EscrowDealDetailScreenState extends State<EscrowDealDetailScreen>
    with TransactionPinMixin<EscrowDealDetailScreen> {
  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  late final String _dealId;

  @override
  void initState() {
    super.initState();
    // In-app navigation passes the deal id as Get.arguments; the chat receipt
    // "View receipt" deeplink (/escrow/detail/:reference) passes it as a path
    // parameter instead. Accept either so both entry points resolve the deal.
    _dealId = (Get.arguments as String?) ?? Get.parameters['reference'] ?? '';
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EscrowCubit>().loadDeal(_dealId);
    });
  }

  Future<void> _release(EscrowDealEntity deal) async {
    final cubit = context.read<EscrowCubit>();
    HapticFeedback.mediumImpact();
    final txnId = 'ESCROW-REL-${const Uuid().v4().substring(0, 8)}';
    final idem = const Uuid().v4();
    String? token;
    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'escrow_release',
      amount: deal.sellerNet,
      currency: deal.currency,
      title: 'Release funds',
      message: 'Release ${deal.currency} ${deal.sellerNet.toStringAsFixed(2)} to ${deal.sellerName}',
      showProcessingPhase: false,
      onPinValidated: (t) async => token = t,
    );
    if (!ok || token == null) return;
    await cubit.validateRelease(
        dealId: deal.id, transactionId: txnId, verificationToken: token!, idempotencyKey: idem);
  }

  Future<void> _markDelivered(EscrowDealEntity deal) async {
    final cubit = context.read<EscrowCubit>();
    // One sheet captures an optional note AND an optional proof-of-delivery
    // photo (the seller's side of the two-way image flow).
    final result = await _deliverySheet();
    if (result == null) return; // dismissed
    String proofUrl = '';
    final file = result.image;
    if (file != null) {
      try {
        final uploader = EscrowImageUploadService(
          endpoints: endpointRegistry,
        );
        proofUrl = (await uploader.uploadFromFile(file)).publicUrl;
      } catch (_) {
        // Non-fatal — mark delivered without the proof image.
      }
    }
    await cubit.markDelivered(
      dealId: deal.id,
      deliveryNote: result.note,
      sellerProofImageUrl: proofUrl,
    );
  }

  /// Bottom sheet for the seller to mark delivery: optional note + optional
  /// proof-of-delivery photo. Returns null if dismissed.
  Future<_DeliveryResult?> _deliverySheet() async {
    final noteCtrl = TextEditingController();
    File? picked;
    final picker = ImagePicker();
    return showModalBottomSheet<_DeliveryResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: EscrowTheme.card,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheet) => Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
              top: 20.h,
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 20.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.local_shipping_outlined,
                      color: EscrowTheme.primary, size: 22.sp),
                  SizedBox(width: 10.w),
                  Text('Mark as delivered',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700)),
                ]),
                SizedBox(height: 6.h),
                Text('Add a photo of what you delivered so the buyer can confirm.',
                    style: GoogleFonts.inter(
                        color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
                SizedBox(height: 16.h),
                GestureDetector(
                  onTap: () async {
                    final XFile? x = await picker.pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1600,
                        imageQuality: 85);
                    if (x != null) setSheet(() => picked = File(x.path));
                  },
                  child: Container(
                    height: picked != null ? 170.h : 92.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: EscrowTheme.bg,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: EscrowTheme.border),
                      image: picked != null
                          ? DecorationImage(
                              image: FileImage(picked!), fit: BoxFit.cover)
                          : null,
                    ),
                    child: picked != null
                        ? null
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo_outlined,
                                  color: EscrowTheme.primary, size: 22.sp),
                              SizedBox(height: 6.h),
                              Text('Add proof photo (optional)',
                                  style: GoogleFonts.inter(
                                      color: EscrowTheme.textSecondary,
                                      fontSize: 12.sp)),
                            ],
                          ),
                  ),
                ),
                SizedBox(height: 14.h),
                TextField(
                  controller: noteCtrl,
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
                        borderSide:
                            const BorderSide(color: EscrowTheme.primary)),
                  ),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(
                        ctx,
                        _DeliveryResult(
                            note: noteCtrl.text.trim(), image: picked)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EscrowTheme.primary,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: Text('Mark delivered',
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
      },
    );
  }

  Future<void> _cancel(EscrowDealEntity deal) async {
    final cubit = context.read<EscrowCubit>();
    final reason = await _promptSheet(
      title: 'Cancel & refund',
      subtitle: 'The held funds go back to the buyer. This can\'t be undone.',
      hint: 'Reason (optional)',
      confirmLabel: 'Cancel & refund',
      icon: Icons.undo_rounded,
      accent: EscrowTheme.error,
      required: false,
    );
    if (reason == null) return;
    await cubit.cancelDeal(dealId: deal.id, reason: reason, idempotencyKey: const Uuid().v4());
  }

  Future<void> _dispute(EscrowDealEntity deal) async {
    final cubit = context.read<EscrowCubit>();
    final result = await _disputeSheet();
    if (result == null) return;
    await cubit.openDispute(
      dealId: deal.id,
      reason: result.reason,
      evidenceUrl: result.evidence,
    );
  }

  /// Shared drag-handle bottom sheet collecting a single optional/required note.
  /// Returns the entered text, or null if dismissed.
  Future<String?> _promptSheet({
    required String title,
    required String subtitle,
    required String hint,
    required String confirmLabel,
    required IconData icon,
    required Color accent,
    required bool required,
  }) async {
    final ctrl = TextEditingController();
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: _sheetShell(
            icon: icon,
            accent: accent,
            title: title,
            subtitle: subtitle,
            children: [
              _sheetField(ctrl, hint),
              SizedBox(height: 18.h),
              AppLoadingButton(
                text: confirmLabel,
                backgroundColor: accent,
                onPressed: () {
                  if (required && ctrl.text.trim().isEmpty) return;
                  Navigator.pop(ctx, ctrl.text);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Dispute sheet: a required problem description plus an optional evidence
  /// link/description that is forwarded to the backend.
  Future<({String reason, String evidence})?> _disputeSheet() async {
    final reasonCtrl = TextEditingController();
    final evidenceCtrl = TextEditingController();
    return showModalBottomSheet<({String reason, String evidence})>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(builder: (ctx, setSheetState) {
          final canSubmit = reasonCtrl.text.trim().isNotEmpty;
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: _sheetShell(
              icon: Icons.gavel_rounded,
              accent: EscrowTheme.warning,
              title: 'Open a dispute',
              subtitle: 'Tell us what went wrong. Our team reviews every dispute.',
              children: [
                _sheetLabel('What\'s the problem?'),
                _sheetField(reasonCtrl, 'Describe the issue',
                    onChanged: (_) => setSheetState(() {})),
                SizedBox(height: 14.h),
                _sheetLabel('Evidence link or details (optional)'),
                _sheetField(evidenceCtrl,
                    'Paste a link to a photo/chat, or describe your proof',
                    maxLines: 2),
                SizedBox(height: 18.h),
                AppLoadingButton(
                  text: 'Submit dispute',
                  backgroundColor: EscrowTheme.warning,
                  onPressed: canSubmit
                      ? () => Navigator.pop(ctx, (
                            reason: reasonCtrl.text.trim(),
                            evidence: evidenceCtrl.text.trim(),
                          ))
                      : null,
                ),
              ],
            ),
          );
        });
      },
    );
  }

  Widget _sheetShell({
    required IconData icon,
    required Color accent,
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        border: const Border(top: BorderSide(color: EscrowTheme.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: EscrowTheme.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: accent, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700)),
                    SizedBox(height: 2.h),
                    Text(subtitle,
                        style: GoogleFonts.inter(
                            color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          ...children,
        ],
      ),
    );
  }

  Widget _sheetLabel(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: GoogleFonts.inter(
                color: EscrowTheme.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600)),
      );

  Widget _sheetField(TextEditingController c, String hint,
      {int maxLines = 3, void Function(String)? onChanged}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      onChanged: onChanged,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: EscrowTheme.bg,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.primary)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Deal details',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: BlocConsumer<EscrowCubit, EscrowState>(
        listener: (context, state) {
          if (state is EscrowError) {
            showAppSnackbar('Escrow', state.message, type: AppSnackbarType.error);
          }
          if (state is EscrowActionSuccess) {
            final d = state.deal;
            // Terminal money events route to a branded receipt; intermediate
            // actions (delivered / disputed) just refresh the detail in place.
            if (d.isReleased) {
              Get.offNamed(AppRoutes.escrowReceipt,
                  arguments: {'deal': d, 'kind': 'released'});
            } else if (d.isRefunded) {
              Get.offNamed(AppRoutes.escrowReceipt,
                  arguments: {'deal': d, 'kind': 'refunded'});
            } else {
              showAppSnackbar('Escrow', state.message,
                  type: AppSnackbarType.success);
              context.read<EscrowCubit>().loadDeal(_dealId);
            }
          }
        },
        builder: (context, state) {
          if (state is EscrowDealLoaded) {
            return _body(state.deal, state.currentUserId);
          }
          if (state is EscrowError) {
            return EscrowEmptyState.error(
              onRetry: () => context.read<EscrowCubit>().loadDeal(_dealId),
            );
          }
          if (state is EscrowActionInProgress) {
            return const Center(child: LazerVaultLoader.medium());
          }
          // First load (EscrowLoading / EscrowInitial) — skeleton, not a spinner.
          return const EscrowDetailShimmer();
        },
      ),
    );
  }

  Widget _body(EscrowDealEntity deal, String uid) {
    final isBuyer = deal.isBuyer(uid);
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(deal.title,
                      style: GoogleFonts.inter(
                          color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
                ),
                EscrowTheme.statusChip(deal.status),
              ],
            ),
            SizedBox(height: 4.h),
            Text('Ref ${deal.reference}',
                style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 11.sp)),
            if (!deal.requiresAdminReview) ...[
              SizedBox(height: 12.h),
              _waitingBanner(deal, uid),
            ],
            SizedBox(height: 16.h),
            _amountCard(deal, isBuyer),
            if (deal.requiresAdminReview) ...[
              SizedBox(height: 12.h),
              _reviewBanner(),
            ],
            if (deal.description.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _section('Terms', deal.description),
            ],
            if (deal.buyerItemImageUrl.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _imageSection('What the buyer wants', deal.buyerItemImageUrl),
            ],
            if (deal.sellerProofImageUrl.isNotEmpty) ...[
              SizedBox(height: 16.h),
              _imageSection('Delivery proof', deal.sellerProofImageUrl),
            ],
            SizedBox(height: 16.h),
            _parties(deal, isBuyer),
            SizedBox(height: 16.h),
            _timeline(deal),
            SizedBox(height: 24.h),
            ..._actions(deal, uid),
          ],
        ),
      ),
    );
  }

  Widget _amountCard(EscrowDealEntity deal, bool isBuyer) {
    Widget row(String l, String v, {bool bold = false}) => Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l, style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
              Text(v,
                  style: GoogleFonts.inter(
                      color: Colors.white, fontSize: bold ? 15.sp : 13.sp,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
            ],
          ),
        );
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        children: [
          row('Deal amount', '${deal.currency} ${deal.amount.toStringAsFixed(2)}'),
          row('Escrow fee (${deal.feePayer}-paid)', '${deal.currency} ${deal.fee.toStringAsFixed(2)}'),
          Divider(color: EscrowTheme.border, height: 18.h),
          row(isBuyer ? 'You paid' : 'Buyer paid', '${deal.currency} ${deal.buyerTotal.toStringAsFixed(2)}', bold: true),
          row(isBuyer ? 'Seller receives' : 'You receive', '${deal.currency} ${deal.sellerNet.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  Widget _reviewBanner() => Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: EscrowTheme.warning.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: EscrowTheme.warning.withValues(alpha: 0.4)),
        ),
        child: Row(
          children: [
            Icon(Icons.shield_outlined, color: EscrowTheme.warning, size: 18.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text('This deal is under review for your protection. Release is paused until it clears.',
                  style: GoogleFonts.inter(color: EscrowTheme.warning, fontSize: 11.5.sp)),
            ),
          ],
        ),
      );

  // Role-aware progress line: emphasises (violet) when it's the viewer's turn,
  // neutral otherwise. Hidden for states with no useful waiting text.
  Widget _waitingBanner(EscrowDealEntity deal, String uid) {
    final s = deal.waitingSubtitle(uid);
    if (s.text.isEmpty) return const SizedBox.shrink();
    final color = s.yourTurn ? EscrowTheme.primary : EscrowTheme.textSecondary;
    final icon = s.yourTurn
        ? Icons.touch_app_outlined
        : (deal.isActive ? Icons.hourglass_bottom : Icons.check_circle_outline);
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(s.text,
                style: GoogleFonts.inter(
                    color: color, fontSize: 12.sp, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, String body) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 6.h),
          Text(body, style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
        ],
      );

  /// An image section (buyer's item / seller's proof) — tap to view full-screen.
  Widget _imageSection(String title, String url) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.inter(
                  color: EscrowTheme.textSecondary,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          GestureDetector(
            onTap: () => _openImageViewer(url),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.network(
                url,
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
                loadingBuilder: (c, child, progress) => progress == null
                    ? child
                    : Container(
                        height: 180.h,
                        color: EscrowTheme.card,
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(
                            color: EscrowTheme.primary, strokeWidth: 2),
                      ),
                errorBuilder: (c, e, s) => Container(
                  height: 180.h,
                  color: EscrowTheme.card,
                  alignment: Alignment.center,
                  child: Icon(Icons.broken_image_outlined,
                      color: EscrowTheme.textSecondary, size: 28.sp),
                ),
              ),
            ),
          ),
        ],
      );

  void _openImageViewer(String url) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              child: Image.network(url,
                  errorBuilder: (c, e, s) => Icon(Icons.broken_image_outlined,
                      color: Colors.white54, size: 48.sp)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _parties(EscrowDealEntity deal, bool isBuyer) {
    return Row(
      children: [
        Expanded(child: _partyTile('Buyer', deal.buyerName, isBuyer)),
        SizedBox(width: 12.w),
        Expanded(child: _partyTile('Seller', deal.sellerName, !isBuyer)),
      ],
    );
  }

  Widget _partyTile(String role, String name, bool you) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: you ? EscrowTheme.primary : EscrowTheme.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(you ? '$role (you)' : role,
              style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 11.sp)),
          SizedBox(height: 4.h),
          Text(name.isEmpty ? '—' : name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _timeline(EscrowDealEntity deal) {
    if (deal.events.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Timeline',
            style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        ...deal.events.map((e) => Padding(
              padding: EdgeInsets.symmetric(vertical: 6.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 4.h, right: 10.w),
                    width: 8.w, height: 8.w,
                    decoration: const BoxDecoration(color: EscrowTheme.primary, shape: BoxShape.circle),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_eventLabel(e.eventType),
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
                        if (e.detail.isNotEmpty)
                          Text(e.detail,
                              style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 11.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  String _eventLabel(String t) {
    switch (t) {
      case 'funded':
        return 'Funded & created';
      case 'delivered':
        return 'Marked delivered';
      case 'released':
        return 'Funds released';
      case 'cancelled':
        return 'Cancelled & refunded';
      case 'disputed':
        return 'Dispute opened';
      default:
        return t;
    }
  }

  List<Widget> _actions(EscrowDealEntity deal, String uid) {
    final widgets = <Widget>[];
    if (deal.canMarkDelivered(uid)) {
      widgets.add(_primaryBtn('Mark as delivered', () => _markDelivered(deal)));
    }
    if (deal.canRelease(uid)) {
      widgets.add(_primaryBtn('Confirm delivery & release funds', () => _release(deal)));
    }
    if (deal.canDispute(uid)) {
      widgets.add(_secondaryBtn('Open a dispute', EscrowTheme.warning, () => _dispute(deal)));
    }
    if (deal.canCancel(uid)) {
      widgets.add(_secondaryBtn('Cancel & refund', EscrowTheme.error, () => _cancel(deal)));
    }

    // Always available: view the escrow agreement (invoice).
    widgets.add(_ghostBtn('View agreement', Icons.description_outlined, () {
      Get.toNamed(AppRoutes.escrowInvoice, arguments: {'deal': deal});
    }));

    // Receipt shortcut once money has moved (funded / released / refunded).
    final receiptKind = deal.isReleased
        ? 'released'
        : deal.isRefunded
            ? 'refunded'
            : (deal.isFunded || deal.isDelivered)
                ? 'funded'
                : null;
    if (receiptKind != null) {
      widgets.add(_ghostBtn('View receipt', Icons.receipt_long_outlined, () {
        Get.toNamed(AppRoutes.escrowReceipt,
            arguments: {'deal': deal, 'kind': receiptKind});
      }));
    }
    return widgets;
  }

  Widget _ghostBtn(String label, IconData icon, VoidCallback onTap) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: onTap,
            icon: Icon(icon, color: EscrowTheme.textSecondary, size: 18.sp),
            label: Text(label,
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary,
                    fontSize: 13.5.sp,
                    fontWeight: FontWeight.w600)),
            style: TextButton.styleFrom(
              backgroundColor: EscrowTheme.card,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
                side: const BorderSide(color: EscrowTheme.border),
              ),
            ),
          ),
        ),
      );

  Widget _primaryBtn(String label, VoidCallback onTap) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: EscrowTheme.primary,
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(label,
                style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w700)),
          ),
        ),
      );

  Widget _secondaryBtn(String label, Color color, VoidCallback onTap) => Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onTap,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: color),
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text(label, style: GoogleFonts.inter(color: color, fontSize: 13.5.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      );
}

/// Result of the seller's mark-delivered sheet: an optional note + optional
/// proof-of-delivery image file (uploaded to storage before markDelivered).
class _DeliveryResult {
  final String note;
  final File? image;
  const _DeliveryResult({required this.note, this.image});
}
