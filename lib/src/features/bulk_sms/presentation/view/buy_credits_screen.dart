import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lv_snackbar.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Buy SMS units: package grid on a sticky provider → confirm → tx-PIN →
/// purchaseSmsCredits. One of only two money calls in this feature.
class BuyCreditsScreen extends StatefulWidget {
  const BuyCreditsScreen({super.key});

  @override
  State<BuyCreditsScreen> createState() => _BuyCreditsScreenState();
}

class _BuyCreditsScreenState extends State<BuyCreditsScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      serviceLocator<ITransactionPinService>();

  String? _selectedPackageId;
  bool _isProcessing = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<BulkSmsCubit>();
    cubit.loadPackages();
    cubit.loadBalance();
  }

  SmsPackageEntity? _selected(BulkSmsState state) {
    if (_selectedPackageId == null) return null;
    for (final p in state.packages) {
      if (p.id == _selectedPackageId) return p;
    }
    return null;
  }

  Future<void> _confirm() async {
    if (_isProcessing) return;
    final state = context.read<BulkSmsCubit>().state;
    final pkg = _selected(state);
    if (pkg == null) {
      LVSnackbar.showError(title: 'Select a package', message: 'Choose a unit bundle to continue.');
      return;
    }
    setState(() => _isProcessing = true);

    final txId = 'bulk_sms_${DateTime.now().millisecondsSinceEpoch}';
    final idem = const Uuid().v4();
    final currency = pkg.currency.isEmpty ? 'NGN' : pkg.currency;
    String? token;

    final ok = await validateTransactionPin(
      context: context,
      transactionId: txId,
      transactionType: 'bulk_sms_purchase',
      amount: pkg.priceNaira,
      currency: currency,
      title: 'Confirm purchase',
      message:
          'Buy ${pkg.creditCount} SMS units for ₦${pkg.priceNaira.toStringAsFixed(0)}',
      showProcessingPhase: false,
      onPinValidated: (t) async {
        token = t;
      },
    );

    if (!ok || token == null) {
      if (mounted) setState(() => _isProcessing = false);
      return;
    }
    if (!mounted) return;

    await context.read<BulkSmsCubit>().buyCredits(
          packageId: pkg.id,
          providerName: pkg.providerName,
          currency: currency,
          transactionId: txId,
          verificationToken: token!,
          idempotencyKey: idem,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BulkSmsCubit, BulkSmsState>(
      listenWhen: (p, c) => p.purchaseStatus != c.purchaseStatus,
      listener: (context, state) {
        if (state.purchaseStatus == ActionStatus.success) {
          final r = state.purchaseResult;
          LVSnackbar.showSuccess(
            title: 'Units added',
            message: r == null
                ? 'Your SMS units have been topped up.'
                : '${r.creditsPurchased} units added · balance ${r.newCreditBalance}.',
          );
          Get.back();
        } else if (state.purchaseStatus == ActionStatus.failed) {
          if (mounted) setState(() => _isProcessing = false);
          LVSnackbar.showError(
            title: 'Purchase failed',
            message: state.errorMessage ?? 'Please try again.',
          );
        }
      },
      child: Scaffold(
        backgroundColor: BulkSmsTheme.bg,
        body: SafeArea(
          child: Column(
            children: [
              BulkSmsHeader(
                title: 'Buy units',
                subtitle: 'Top up your SMS balance',
                onBack: () => Get.back(),
              ),
              Expanded(
                child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                  builder: (context, state) => _body(state),
                ),
              ),
              _confirmBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(BulkSmsState state) {
    if (state.packagesStatus == SectionStatus.loading &&
        state.packages.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(color: BulkSmsTheme.primary),
      );
    }
    if (state.packagesStatus == SectionStatus.error && state.packages.isEmpty) {
      return BulkSmsEmptyState(
        icon: Icons.error_outline,
        title: 'Couldn\'t load packages',
        subtitle: state.errorMessage ?? 'Please try again.',
      );
    }
    if (state.packages.isEmpty) {
      return const BulkSmsEmptyState(
        icon: Icons.inbox_outlined,
        title: 'No packages available',
        subtitle: 'Unit bundles are not available right now. Try again later.',
      );
    }

    final provider = state.packages.first.providerName;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      children: [
        SizedBox(height: 4.h),
        _stickyProvider(provider, state.balance?.creditsRemaining ?? 0),
        SizedBox(height: 16.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.92,
          ),
          itemCount: state.packages.length,
          itemBuilder: (context, i) => _packageCard(state.packages[i]),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _stickyProvider(String provider, int balance) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: BulkSmsTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: BulkSmsTheme.divider),
      ),
      child: Row(
        children: [
          Icon(Icons.router_rounded, color: BulkSmsTheme.primary, size: 18.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              provider.isEmpty ? 'SMS provider' : 'Provider · $provider',
              style: TextStyle(color: Colors.white, fontSize: 13.sp),
            ),
          ),
          Text(
            'Balance $balance',
            style: TextStyle(
                color: BulkSmsTheme.textSecondary, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }

  Widget _packageCard(SmsPackageEntity pkg) {
    final selected = pkg.id == _selectedPackageId;
    return GestureDetector(
      onTap: () => setState(() => _selectedPackageId = pkg.id),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: selected
              ? BulkSmsTheme.primary.withValues(alpha: 0.12)
              : BulkSmsTheme.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: selected ? BulkSmsTheme.primary : BulkSmsTheme.divider,
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    pkg.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (pkg.isPopular)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: BulkSmsTheme.warning.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text('POPULAR',
                        style: TextStyle(
                            color: BulkSmsTheme.warning,
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w800)),
                  ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              '${pkg.creditCount}',
              style: TextStyle(
                color: BulkSmsTheme.primary,
                fontSize: 26.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text('units',
                style: TextStyle(
                    color: BulkSmsTheme.textSecondary, fontSize: 11.sp)),
            const Spacer(),
            Text(
              '₦${pkg.priceNaira.toStringAsFixed(0)}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            if (pkg.validityDays > 0)
              Text('Valid ${pkg.validityDays} days',
                  style: TextStyle(
                      color: BulkSmsTheme.textSecondary, fontSize: 10.sp)),
          ],
        ),
      ),
    );
  }

  Widget _confirmBar() {
    return BlocBuilder<BulkSmsCubit, BulkSmsState>(
      builder: (context, state) {
        final pkg = _selected(state);
        final enabled = pkg != null && !_isProcessing;
        return Container(
          padding: EdgeInsets.all(20.w),
          child: SizedBox(
            width: double.infinity,
            height: 54.h,
            child: ElevatedButton(
              onPressed: enabled ? _confirm : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: BulkSmsTheme.primary,
                disabledBackgroundColor:
                    BulkSmsTheme.primary.withValues(alpha: 0.4),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r)),
              ),
              child: _isProcessing
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : Text(
                      pkg == null
                          ? 'Select a package'
                          : 'Pay ₦${pkg.priceNaira.toStringAsFixed(0)}',
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w700),
                    ),
            ),
          ),
        );
      },
    );
  }
}
