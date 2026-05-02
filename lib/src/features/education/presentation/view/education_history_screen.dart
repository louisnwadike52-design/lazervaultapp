import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/widgets/bill_history_actions_sheet.dart';
import '../../../../../core/widgets/bill_history_item.dart';
import '../../domain/entities/education_history_entity.dart';
import '../cubit/education_history_cubit.dart';

class EducationHistoryScreen extends StatefulWidget {
  const EducationHistoryScreen({super.key});

  @override
  State<EducationHistoryScreen> createState() => _EducationHistoryScreenState();
}

class _EducationHistoryScreenState extends State<EducationHistoryScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _accent = Color(0xFF4E03D0);
  static const _success = Color(0xFF10B981);
  static const _danger = Color(0xFFEF4444);
  static const _textSecondary = Color(0xFF9CA3AF);

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _loadHistory() {
    context.read<EducationHistoryCubit>().loadHistory(refresh: true);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<EducationHistoryCubit>().loadMore();
    }
  }

  /// "View Receipt" — fetches the full purchase (with PINs) and routes to
  /// the PIN details screen, which doubles as the receipt for this flow
  /// (provider, qty, amount, reference, status, date + the PIN cards).
  Future<void> _viewPurchaseDetails(EducationHistoryEntity purchase) async {
    final purchaseDetails = await context
        .read<EducationHistoryCubit>()
        .getPurchaseById(purchase.id);

    if (!mounted) return;
    if (purchaseDetails == null) {
      Get.snackbar(
        'Unavailable',
        'Could not load receipt for this purchase',
        backgroundColor: _danger,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    Get.toNamed(
      AppRoutes.educationPinDetails,
      arguments: <String, dynamic>{
        'purchase': purchaseDetails,
        'providerName': purchase.providerName,
      },
    );
  }

  /// Copy the purchase's PIN(s) to the clipboard. If only one PIN was
  /// purchased, the value lands on the clipboard directly; multiple PINs
  /// are joined newline-separated. When the row in the list view doesn't
  /// already carry the PINs (older paginated payloads), we fetch the
  /// full purchase first via the cubit so the user never sees an empty
  /// copy.
  Future<void> _copyPins(EducationHistoryEntity purchase) async {
    var pins = purchase.pins;
    if (pins.isEmpty) {
      final full = await context
          .read<EducationHistoryCubit>()
          .getPurchaseById(purchase.id);
      if (!mounted) return;
      if (full != null) pins = full.pins;
    }
    if (pins.isEmpty) {
      Get.snackbar(
        'Nothing to copy',
        'No PINs found for this purchase yet',
        backgroundColor: _danger,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }
    final text = pins.map((p) => p.pin).join('\n');
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    Get.snackbar(
      'Copied',
      pins.length == 1
          ? 'PIN copied to clipboard'
          : '${pins.length} PINs copied to clipboard',
      backgroundColor: _success,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void _rebuyPurchase(EducationHistoryEntity purchase) {
    // Map shape (NOT the entity) — `education_home_screen` casts to
    // `Map<String, dynamic>?` and crashes if it gets the entity.
    Get.toNamed(
      AppRoutes.educationHome,
      arguments: <String, dynamic>{
        'rebuyPurchase': <String, dynamic>{
          'serviceId': purchase.serviceId,
          'phone': purchase.phoneNumber,
          'billersCode': purchase.billersCode,
          'quantity': purchase.quantity,
        },
      },
    );
  }

  void _openActionsSheet(EducationHistoryEntity purchase) {
    final isCompleted = _isCompleted(purchase);
    final pinCount = purchase.pins.length;
    final hasPins = pinCount > 0;

    BillHistoryActionsSheet.show(
      context,
      title: '${purchase.providerName} · ${purchase.quantity} '
          '${purchase.quantity == 1 ? 'PIN' : 'PINs'}',
      subtitle: '₦${_formatAmount(purchase.amount)} · '
          '${_statusLabel(purchase)}',
      actions: [
        // "View Receipt" routes into the PIN details screen — that page
        // already renders the receipt header (reference, status, date,
        // amount, qty) above the PIN list, so it's the natural target.
        BillHistoryAction(
          icon: Icons.receipt_long,
          color: _accent,
          label: 'View Receipt',
          onTap: () {
            Get.back();
            _viewPurchaseDetails(purchase);
          },
        ),
        // Copy PIN: only meaningful for completed purchases that have
        // PINs delivered. Hide for pending/failed rows so the user
        // doesn't tap an action that could only show "nothing to copy".
        if (isCompleted && hasPins)
          BillHistoryAction(
            icon: Icons.copy,
            color: _success,
            label: pinCount == 1 ? 'Copy PIN' : 'Copy all PINs',
            subtitle: pinCount == 1 ? null : '$pinCount PINs',
            onTap: () {
              Get.back();
              _copyPins(purchase);
            },
          ),
        BillHistoryAction(
          icon: Icons.replay,
          color: _success,
          label: 'Rebuy',
          onTap: () {
            Get.back();
            _rebuyPurchase(purchase);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
        ),
        title: Text(
          'PIN Purchase History',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _loadHistory,
            icon: Icon(Icons.refresh, color: Colors.white, size: 22.sp),
          ),
        ],
      ),
      body: BlocBuilder<EducationHistoryCubit, EducationHistoryState>(
        builder: (context, state) {
          if (state is EducationHistoryLoading &&
              state is! EducationHistoryLoaded) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_accent),
              ),
            );
          }

          if (state is EducationHistoryError) {
            return _buildErrorState(state.message);
          }

          if (state is EducationHistoryInitial) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(_accent),
              ),
            );
          }

          if (state is EducationHistoryLoaded) {
            if (state.history.isEmpty) return _buildEmptyState();
            return RefreshIndicator(
              onRefresh: () async {
                _loadHistory();
                await Future.delayed(const Duration(seconds: 1));
              },
              color: _accent,
              backgroundColor: _card,
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(20.w),
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.history.length + (state.hasMore ? 1 : 0),
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  if (index >= state.history.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(_accent),
                        ),
                      ),
                    );
                  }
                  return _buildRow(state.history[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildRow(EducationHistoryEntity p) {
    final pinCount = p.pins.length;
    return BillHistoryItem(
      leadingIcon: Container(
        decoration: BoxDecoration(
          color: _accent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Icon(Icons.school, color: _accent, size: 20.sp),
        ),
      ),
      title: p.providerName,
      subtitle: [
        '${p.quantity} ${p.quantity == 1 ? 'PIN' : 'PINs'}',
        if (p.billersCode.isNotEmpty) p.billersCode,
      ].join(' · '),
      reference: p.reference,
      date: _formatDate(p.createdAt),
      amount: p.amount,
      status: p.status,
      onTap: () => _openActionsSheet(p),
      // Mirror the electricity-bill receipt: render a quick "Copy PIN"
      // affordance directly on the row when only one PIN was issued so
      // the user can grab it without opening the actions sheet. For
      // multi-PIN rows we link to the full list instead — copy-all is
      // still available from the actions sheet.
      trailing: pinCount > 0 && _isCompleted(p)
          ? _buildPinCopyStrip(p, pinCount)
          : null,
    );
  }

  Widget _buildPinCopyStrip(EducationHistoryEntity p, int pinCount) {
    final isSingle = pinCount == 1;
    final pinPreview = isSingle ? p.pins.first.pin : '$pinCount PINs available';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: _accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(Icons.vpn_key, size: 14.sp, color: _accent),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              pinPreview,
              style: GoogleFonts.robotoMono(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: isSingle ? 1.5 : 0,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 8.w),
          GestureDetector(
            onTap: () =>
                isSingle ? _copyPins(p) : _viewPurchaseDetails(p),
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isSingle ? Icons.copy : Icons.visibility,
                  size: 14.sp,
                  color: _accent,
                ),
                SizedBox(width: 4.w),
                Text(
                  isSingle ? 'Copy' : 'View',
                  style: GoogleFonts.inter(
                    color: _accent,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 60.h),
      children: [
        Icon(Icons.history, color: _textSecondary, size: 48.sp),
        SizedBox(height: 12.h),
        Text(
          'No purchase history',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Your education PIN purchases will appear here.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 12.sp),
        ),
      ],
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48.sp, color: _danger),
            SizedBox(height: 12.h),
            Text(
              'Failed to load history',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp),
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: _loadHistory,
              style: ElevatedButton.styleFrom(
                backgroundColor: _accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCompleted(EducationHistoryEntity p) {
    final s = p.status.toLowerCase();
    return s == 'completed' || s == 'success' || s == 'successful';
  }

  String _statusLabel(EducationHistoryEntity p) {
    final info = BillHistoryItem.statusInfo(p.status);
    if (info != null) return info.$2;
    return p.status.isEmpty ? 'Unknown' : p.status;
  }

  String _formatAmount(double amount) {
    final intAmount = amount.toInt();
    if (intAmount < 1000) return amount.toStringAsFixed(0);
    final str = intAmount.toString();
    final result = StringBuffer();
    for (var i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) result.write(',');
      result.write(str[i]);
    }
    return result.toString();
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString).toLocal();
      final now = DateTime.now();
      final difference = now.difference(date);
      String time() =>
          '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      if (difference.inDays == 0) return 'Today, ${time()}';
      if (difference.inDays == 1) return 'Yesterday, ${time()}';
      if (difference.inDays < 7) return '${difference.inDays} days ago';
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateString;
    }
  }
}
