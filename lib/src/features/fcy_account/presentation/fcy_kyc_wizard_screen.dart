import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/shared_widgets/lazer_vault_loader.dart';
import '../../../../core/shared_widgets/wizard_progress_bar.dart';
import '../../../../core/theme/app_surfaces.dart';
import '../data/fcy_account_service.dart';
import 'cubit/fcy_kyc_cubit.dart';
import 'cubit/fcy_kyc_state.dart';
import 'cubit/fcy_kyc_steps.dart';
import 'widgets/fcy_document_tile.dart';
import 'widgets/fcy_kyc_field_input.dart';

/// The FCY KYC wizard.
///
/// Replaces a single 737-line page that asked for all 24 fields at once, with no
/// prefill and no document preview. Three things changed and each has a reason:
///
///   - STEPS, because 24 inputs on one screen is where people stop;
///   - PREFILL, because roughly a third of those fields were already verified for
///     that same user and asking again reads as us not knowing who they are;
///   - PREVIEW, because a green tick does not tell anyone their ID photo is legible.
///
/// The step list is VARIABLE LENGTH — see FcyKycCubit. A user whose profile is
/// complete may never see the "About you" step at all, so the progress bar's total
/// is per-user rather than a constant.
class FcyKycWizardScreen extends StatefulWidget {
  const FcyKycWizardScreen({super.key});

  @override
  State<FcyKycWizardScreen> createState() => _FcyKycWizardScreenState();
}

class _FcyKycWizardScreenState extends State<FcyKycWizardScreen> {
  final _service = FCYAccountService();
  bool _uploadingId = false;
  bool _uploadingProof = false;

  @override
  void initState() {
    super.initState();
    // Loaded here rather than in the cubit constructor so the loading state is
    // observable and the first frame is not a form we are about to reshape.
    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<FcyKycCubit>().load());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FcyKycCubit>();

    // PopScope, because leaving mid-flow silently discards everything: the field
    // values live on the cubit, which dies with the route, and both uploaded documents
    // go with it. Re-uploading a passport photo and a utility bill is the most
    // expensive part of this form to redo, so an accidental swipe-back must ask first.
    //
    // canPop is false ONLY while there is something to lose. A user who has entered
    // nothing gets the normal instant back gesture rather than a pointless prompt.
    return PopScope(
      canPop: !_hasUnsavedWork(cubit),
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmDiscard(cubit);
      },
      child: _buildScaffold(context, cubit),
    );
  }

  /// True when leaving would discard work the user would have to redo.
  bool _hasUnsavedWork(FcyKycCubit cubit) {
    if (_uploadingId || _uploadingProof) return true;
    if ((cubit.idDocumentUrl ?? '').isNotEmpty) return true;
    if ((cubit.addressProofUrl ?? '').isNotEmpty) return true;
    // Values seeded from prefill do not count — those are recoverable for free on the
    // next visit. Only something the USER typed is worth warning about.
    return cubit.values.entries.any(
      (e) => e.value.trim().isNotEmpty && !_isPrefilled(cubit, e.key),
    );
  }

  bool _isPrefilled(FcyKycCubit cubit, FcyKycFieldId id) {
    final p = cubit.prefill;
    switch (id) {
      case FcyKycFieldId.firstName:
        return p.firstName.prefilled;
      case FcyKycFieldId.lastName:
        return p.lastName.prefilled;
      case FcyKycFieldId.email:
        return p.email.prefilled;
      case FcyKycFieldId.phone:
        return p.phone.prefilled;
      case FcyKycFieldId.birthDate:
        return p.birthDate.prefilled;
      case FcyKycFieldId.nationality:
        return p.nationality.prefilled;
      case FcyKycFieldId.countryOfResidence:
        return p.countryOfResidence.prefilled;
      case FcyKycFieldId.addressStreet:
        return p.addressStreet.prefilled;
      case FcyKycFieldId.addressCity:
        return p.addressCity.prefilled;
      case FcyKycFieldId.addressState:
        return p.addressState.prefilled;
      case FcyKycFieldId.addressZip:
        return p.addressZip.prefilled;
      case FcyKycFieldId.documentNumber:
        return p.documentNumber.prefilled;
      case FcyKycFieldId.documentIssuedCountry:
        return p.documentIssuedCountry.prefilled;
      // documentType, employmentStatus and sourceOfIncome are seeded with DEFAULTS
      // rather than prefill, so they are not user work either.
      case FcyKycFieldId.documentType:
      case FcyKycFieldId.employmentStatus:
      case FcyKycFieldId.sourceOfIncome:
        return true;
      default:
        return false;
    }
  }

  Future<void> _confirmDiscard(FcyKycCubit cubit) async {
    final uploading = _uploadingId || _uploadingProof;
    final leave = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppSurfaces.cardTop,
        title: Text(
          uploading ? 'Still uploading' : 'Leave without finishing?',
          style: TextStyle(color: Colors.white, fontSize: 17.sp),
        ),
        content: Text(
          uploading
              ? 'A document is still uploading. Leaving now will cancel it.'
              : "Your answers and any documents you've uploaded won't be saved, "
                  'and you would need to add them again.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 14.sp,
            height: 1.45,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text('Keep going',
                style: TextStyle(color: AppSurfaces.accentPurple)),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text('Leave',
                style: TextStyle(color: Colors.white.withValues(alpha: 0.7))),
          ),
        ],
      ),
    );
    if (leave == true && mounted) Get.back();
  }

  Widget _buildScaffold(BuildContext context, FcyKycCubit cubit) {
    return Scaffold(
      backgroundColor: AppSurfaces.pageTop,
      appBar: AppBar(
        backgroundColor: AppSurfaces.pageTop,
        elevation: 0,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            // Back moves between steps before it leaves the flow, so a mistyped
            // field on step 2 does not cost the whole form.
            if (cubit.step > 0) {
              cubit.back();
            } else if (_hasUnsavedWork(cubit)) {
              // Same prompt as the system back gesture — two ways out must not
              // behave differently.
              _confirmDiscard(cubit);
            } else {
              Get.back();
            }
          },
        ),
        title: BlocBuilder<FcyKycCubit, FcyKycState>(
          builder: (context, _) {
            final steps = cubit.visibleSteps;
            if (steps.isEmpty) return Text('${cubit.currency} account');
            final s = steps[cubit.step.clamp(0, steps.length - 1)];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Step ${cubit.step + 1} of ${steps.length}',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    color: Colors.white.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Container(
        decoration: AppSurfaces.pageBackground,
        child: BlocConsumer<FcyKycCubit, FcyKycState>(
          listener: (context, state) {
            if (state is FcyKycValidationError) {
              // The message names ONE field, so it fits a snackbar and the user
              // knows exactly what to fix.
              Get.snackbar(
                'Almost there',
                state.message,
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
                duration: const Duration(seconds: 4),
              );
            }
            if (state is FcyKycSubmitted) {
              _showOutcome(state);
            }
            if (state is FcyKycError) {
              Get.snackbar(
                'Something went wrong',
                state.message,
                backgroundColor: const Color(0xFF7F1D1D),
                colorText: Colors.white,
                snackPosition: SnackPosition.BOTTOM,
                margin: EdgeInsets.all(16.w),
                duration: const Duration(seconds: 5),
              );
            }
          },
          builder: (context, state) {
            if (state is FcyKycInitial || state is FcyKycLoading) {
              return const Center(child: LazerVaultLoader());
            }

            // Already issued, or already with the provider: there is no form to
            // show. Reached when the user arrives from the account card, which
            // (unlike the exchange gate) does not pre-check status.
            if (state is FcyKycAccountState) {
              return _AccountStateView(
                currency: cubit.currency,
                status: state.status,
              );
            }

            final steps = cubit.visibleSteps;
            if (steps.isEmpty) {
              // Defensive: the documents step is never dropped, so this is
              // unreachable today. It exists so a future change that makes every
              // step conditional degrades to a message rather than a blank screen.
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Text(
                    'Nothing left to collect. Please go back and try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 14.sp),
                  ),
                ),
              );
            }

            final index = cubit.step.clamp(0, steps.length - 1);
            final step = steps[index];
            final submitting = state is FcyKycSubmitting;

            return Column(
              children: [
                WizardProgressBar(
                  currentStep: index,
                  totalSteps: steps.length,
                  accent: AppSurfaces.accentPurple,
                ),
                if (cubit.prefill.filledCount > 0 && index == 0)
                  _prefillNotice(cubit.prefill.filledCount),
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: ListView(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                      children: [
                        Text(
                          step.subtitle,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.6),
                            fontSize: 13.sp,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ...step.fields.map(
                          (id) => FcyKycFieldInput(
                            id: id,
                            currency: cubit.currency,
                            value: cubit.values[id] ?? '',
                            onChanged: (v) => cubit.setValue(id, v),
                          ),
                        ),
                        // The documents step has no text fields; it renders pickers.
                        if (step.fields.isEmpty) ..._documentTiles(cubit),
                      ],
                    ),
                  ),
                ),
                _bottomBar(cubit, steps.length, submitting),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Tells the user prefill happened.
  ///
  /// Without this the only evidence is a form that is shorter than they expected,
  /// which reads as fields being missing rather than as work already done.
  Widget _prefillNotice(int count) => Container(
        margin: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 4.h),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: const Color(0xFF10B981).withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.verified_user_outlined,
                size: 17.sp, color: const Color(0xFF10B981)),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                '$count detail${count == 1 ? '' : 's'} filled in from your '
                'verified profile.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.82),
                  fontSize: 12.5.sp,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      );

  List<Widget> _documentTiles(FcyKycCubit cubit) => [
        FcyDocumentTile(
          title: 'Your ID document',
          description:
              'A clear photo of the document you entered on the last step.',
          url: cubit.idDocumentUrl,
          uploading: _uploadingId,
          onPick: () => _pick(
            cubit,
            isIdDocument: true,
          ),
          onClear: cubit.idDocumentUrl == null
              ? null
              : () => cubit.setIdDocumentUrl(null),
        ),
        FcyDocumentTile(
          title: 'Proof of address',
          description:
              'A utility bill or bank statement from the last 3 months, showing '
              'the address you entered.',
          url: cubit.addressProofUrl,
          uploading: _uploadingProof,
          onPick: () => _pick(
            cubit,
            isIdDocument: false,
          ),
          onClear: cubit.addressProofUrl == null
              ? null
              : () => cubit.setAddressProofUrl(null),
        ),
      ];

  Future<void> _pick(FcyKycCubit cubit, {required bool isIdDocument}) async {
    setState(() {
      if (isIdDocument) {
        _uploadingId = true;
      } else {
        _uploadingProof = true;
      }
    });
    try {
      final url = await _service.pickAndUploadDocument();
      if (url == null) return; // user cancelled
      if (isIdDocument) {
        cubit.setIdDocumentUrl(url);
      } else {
        cubit.setAddressProofUrl(url);
      }
    } on FCYAccountException catch (e) {
      Get.snackbar(
        'Upload failed',
        e.message,
        backgroundColor: const Color(0xFF7F1D1D),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
      );
    } finally {
      if (mounted) {
        setState(() {
          if (isIdDocument) {
            _uploadingId = false;
          } else {
            _uploadingProof = false;
          }
        });
      }
    }
  }

  Widget _bottomBar(FcyKycCubit cubit, int total, bool submitting) {
    final isLast = cubit.step >= total - 1;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      decoration: BoxDecoration(
        color: AppSurfaces.pageBottom,
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Row(
        children: [
          if (cubit.step > 0)
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 52.h,
                child: OutlinedButton(
                  onPressed: submitting ? null : cubit.back,
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.18)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 14.5.sp),
                  ),
                ),
              ),
            ),
          if (cubit.step > 0) SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: submitting
                    ? null
                    : () => isLast ? cubit.submit() : cubit.next(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSurfaces.accentPurple,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor:
                      AppSurfaces.accentPurple.withValues(alpha: 0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                ),
                child: submitting
                    ? LazerVaultLoader.small()
                    : Text(
                        isLast ? 'Submit for review' : 'Continue',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w600),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// The outcome sheet.
  ///
  /// [FcyKycSubmitted.queued] gets its own copy on purpose. Foreign-account opening
  /// is currently disabled at the provider level, so a perfectly good package cannot
  /// be sent yet — and a user told "failed" would go back and edit fields that were
  /// already right. They are told it is saved and will be sent automatically.
  void _showOutcome(FcyKycSubmitted state) {
    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => Container(
        padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 32.h),
        decoration: BoxDecoration(
          color: AppSurfaces.pageTop,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (state.queued
                        ? const Color(0xFFF59E0B)
                        : const Color(0xFF10B981))
                    .withValues(alpha: 0.15),
              ),
              child: Icon(
                state.queued
                    ? Icons.schedule_rounded
                    : Icons.check_circle_outline_rounded,
                size: 30.sp,
                color: state.queued
                    ? const Color(0xFFF59E0B)
                    : const Color(0xFF10B981),
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              state.queued ? 'Saved and queued' : 'Submitted for review',
              style: TextStyle(
                color: Colors.white,
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.7),
                fontSize: 13.5.sp,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppSurfaces.accentPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                ),
                child: Text('Done',
                    style: TextStyle(
                        fontSize: 15.sp, fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shown instead of the form when the account already exists.
///
/// Two cases, and the difference matters to the user: `active` means money can
/// arrive today and they need the account details; `creating` means we are waiting
/// on a review they cannot speed up, so the honest thing is to say so rather than
/// present a spinner that implies something is happening this second.
class _AccountStateView extends StatelessWidget {
  const _AccountStateView({required this.currency, required this.status});

  final String currency;
  final FCYStatus status;

  bool get _isActive => status.status.toLowerCase() == 'active';

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 28.h, 20.w, 32.h),
      children: [
        Center(
          child: Container(
            width: 72.w,
            height: 72.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (_isActive
                      ? const Color(0xFF10B981)
                      : const Color(0xFFF59E0B))
                  .withValues(alpha: 0.15),
            ),
            child: Icon(
              _isActive ? Icons.account_balance_rounded : Icons.hourglass_top_rounded,
              size: 33.sp,
              color: _isActive
                  ? const Color(0xFF10B981)
                  : const Color(0xFFF59E0B),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          _isActive
              ? 'Your $currency account is ready'
              : 'Your $currency account is being set up',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          status.message.trim().isNotEmpty
              ? status.message
              : (_isActive
                  ? 'Share these details to receive $currency.'
                  : 'We have everything we need. This usually takes a few '
                      'business days, and we will let you know the moment it is '
                      'ready — there is nothing for you to do.'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.65),
            fontSize: 13.5.sp,
            height: 1.5,
          ),
        ),
        if (_isActive && status.accountNumber.trim().isNotEmpty) ...[
          SizedBox(height: 26.h),
          Container(
            padding: EdgeInsets.all(18.w),
            decoration: AppSurfaces.card(radius: 16),
            child: Column(
              children: [
                _row('Account number', status.accountNumber),
                if (status.bankName.trim().isNotEmpty)
                  _row('Bank', status.bankName),
                if (status.accountName.trim().isNotEmpty)
                  _row('Account name', status.accountName),
                _row('Currency', currency),
              ],
            ),
          ),
        ],
        SizedBox(height: 28.h),
        SizedBox(
          height: 52.h,
          child: ElevatedButton(
            onPressed: Get.back,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppSurfaces.accentPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14.r)),
            ),
            child: Text('Done',
                style:
                    TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600)),
          ),
        ),
      ],
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12.5.sp,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.5.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
}
