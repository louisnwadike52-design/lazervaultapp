import 'dart:async';
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
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_state.dart';
import 'package:lazervault/src/features/account_cards_summary/domain/entities/account_summary_entity.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/transaction_pin/mixins/transaction_pin_mixin.dart';
import 'package:lazervault/src/features/transaction_pin/services/transaction_pin_service.dart';
import '../cubit/escrow_cubit.dart';
import '../../domain/entities/escrow_deal_entity.dart';
import 'escrow_theme.dart';

class CreateEscrowDealScreen extends StatefulWidget {
  const CreateEscrowDealScreen({super.key});

  @override
  State<CreateEscrowDealScreen> createState() => _CreateEscrowDealScreenState();
}

class _CreateEscrowDealScreenState extends State<CreateEscrowDealScreen>
    with TransactionPinMixin<CreateEscrowDealScreen> {
  @override
  ITransactionPinService get transactionPinService => GetIt.I<ITransactionPinService>();

  final _sellerCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedAccountId;
  EscrowFeeQuote? _quote;
  Timer? _debounce;
  bool _submitting = false;
  int _deadlineDays = 0; // 0 = no deadline

  // 2-page progress-slide creation (mirrors the invoice carousel).
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 2;
  static const List<String> _pageNames = ['Deal details', 'Amount & funding'];

  // Buyer's product/service image — picked on page 1, uploaded to storage on
  // submit, then persisted as the deal's buyer_item_image_url.
  File? _buyerItemImage;
  final ImagePicker _imagePicker = ImagePicker();

  static const List<(int days, String label)> _deadlineOptions = [
    (0, 'None'),
    (3, '3 days'),
    (7, '7 days'),
    (14, '14 days'),
    (30, '30 days'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<AccountCardsSummaryCubit>().state;
      if (state is! AccountCardsSummaryLoaded) {
        final userId = context.read<AuthenticationCubit>().userId ?? '';
        context.read<AccountCardsSummaryCubit>().fetchAccountSummaries(userId: userId);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _pageController.dispose();
    _sellerCtrl.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _amountCtrl.dispose();
    super.dispose();
  }

  // ---- page navigation ----
  void _goToNextPage() {
    FocusScope.of(context).unfocus();
    if (_currentPage == 0) {
      if (_sellerCtrl.text.trim().isEmpty) {
        _snack('Enter the seller (username, tag or phone)', EscrowTheme.error);
        return;
      }
      if (_titleCtrl.text.trim().isEmpty) {
        _snack('Tell us what this deal is for', EscrowTheme.error);
        return;
      }
      _pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _submit();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage == 0) {
      Get.back();
    } else {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  Future<void> _pickBuyerImage() async {
    try {
      final XFile? picked = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (picked != null && mounted) {
        setState(() => _buyerItemImage = File(picked.path));
      }
    } catch (_) {
      _snack('Could not open the image picker', EscrowTheme.error);
    }
  }

  void _onAmountChanged(String v) {
    _debounce?.cancel();
    final amt = double.tryParse(v) ?? 0;
    if (amt <= 0) {
      setState(() => _quote = null);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 450), () async {
      final q = await context.read<EscrowCubit>().quoteFee(amt);
      if (mounted) setState(() => _quote = q);
    });
  }

  List<AccountSummaryEntity> _ngnAccounts() {
    final state = context.read<AccountCardsSummaryCubit>().state;
    if (state is AccountCardsSummaryLoaded) {
      return state.accountSummaries
          .where((a) => a.currency.toUpperCase() == 'NGN')
          .toList();
    }
    return [];
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // A field on page 1 failed — jump back so the user sees it.
      if (_sellerCtrl.text.trim().isEmpty || _titleCtrl.text.trim().isEmpty) {
        _pageController.animateToPage(0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      }
      return;
    }
    if (_selectedAccountId == null) {
      _snack('Select an account to fund the deal', EscrowTheme.error);
      return;
    }
    final amount = double.parse(_amountCtrl.text);
    final accounts = _ngnAccounts();
    final acct = accounts.firstWhere((a) => a.id.toString() == _selectedAccountId,
        orElse: () => accounts.first);
    final buyerTotal = _quote?.buyerTotal ?? amount;
    if (acct.availableBalance < buyerTotal) {
      _snack('Insufficient balance. You need ${acct.currency} ${buyerTotal.toStringAsFixed(2)}',
          EscrowTheme.error);
      return;
    }

    final cubit = context.read<EscrowCubit>();
    HapticFeedback.mediumImpact();
    final txnId = 'ESCROW-${const Uuid().v4().substring(0, 8)}';
    final idem = const Uuid().v4();
    String? token;

    final ok = await validateTransactionPin(
      context: context,
      transactionId: txnId,
      transactionType: 'escrow_fund',
      amount: buyerTotal,
      currency: acct.currency,
      title: 'Fund escrow',
      message: 'Lock ${acct.currency} ${buyerTotal.toStringAsFixed(2)} in escrow for "${_titleCtrl.text.trim()}"',
      showProcessingPhase: false,
      onPinValidated: (t) async => token = t,
    );
    if (!ok || token == null) return;

    setState(() => _submitting = true);

    // Upload the buyer's product image (best-effort — a failed upload never
    // blocks funding; the deal is created without the image and it can be
    // added conceptually later). Runs after PIN so we don't upload on abandon.
    String buyerImageUrl = '';
    if (_buyerItemImage != null) {
      try {
        final uploader = EscrowImageUploadService(
          endpoints: endpointRegistry,
        );
        final res = await uploader.uploadFromFile(_buyerItemImage!);
        buyerImageUrl = res.publicUrl;
      } catch (_) {
        // Non-fatal: continue funding without the image.
      }
    }

    // Success navigation (→ receipt) is handled in the BlocListener so the
    // funded deal flows straight into the branded receipt screen.
    await cubit.createDeal(
      buyerAccountId: _selectedAccountId!,
      sellerQuery: _sellerCtrl.text.trim(),
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      amount: amount,
      deadlineDays: _deadlineDays,
      transactionId: txnId,
      verificationToken: token!,
      idempotencyKey: idem,
      buyerItemImageUrl: buyerImageUrl,
    );
  }

  void _snack(String m, Color c) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m), backgroundColor: c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: EscrowTheme.bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('New escrow deal',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: BlocListener<EscrowCubit, EscrowState>(
        listener: (context, state) {
          if (state is EscrowError) {
            if (mounted) setState(() => _submitting = false);
            _snack(state.message, EscrowTheme.error);
          }
          if (state is EscrowActionSuccess) {
            Get.offNamed(AppRoutes.escrowReceipt,
                arguments: {'deal': state.deal, 'kind': 'funded'});
          }
        },
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _buildProgressIndicator(),
                SizedBox(height: 6.h),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    children: [
                      _page1Details(),
                      _page2AmountFunding(),
                    ],
                  ),
                ),
                _buildNavButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---- progress indicator (mirrors the invoice carousel) ----
  Widget _buildProgressIndicator() {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 4.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step ${_currentPage + 1} of $_totalPages · ${_pageNames[_currentPage]}',
            style: GoogleFonts.inter(
                color: EscrowTheme.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 10.h),
          Row(
            children: List.generate(_totalPages, (i) {
              final active = i <= _currentPage;
              return Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.only(right: i == _totalPages - 1 ? 0 : 6.w),
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: active ? EscrowTheme.primary : EscrowTheme.border,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _page1Details() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Seller (username, tag or phone)'),
          _field(_sellerCtrl,
              hint: 'e.g. @jane or 080...',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null),
          SizedBox(height: 16.h),
          _label('What is this deal for?'),
          _field(_titleCtrl,
              hint: 'e.g. iPhone 14 Pro',
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null),
          SizedBox(height: 16.h),
          _label('Terms / description (optional)'),
          _field(_descCtrl,
              hint: 'Describe the item, condition, delivery…', maxLines: 3),
          SizedBox(height: 16.h),
          _label('Photo of the product / service (optional)'),
          _buyerImagePicker(),
          SizedBox(height: 16.h),
          _disclaimer(),
        ],
      ),
    );
  }

  Widget _page2AmountFunding() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _label('Amount (NGN)'),
          _field(_amountCtrl,
              hint: '0.00',
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onChanged: _onAmountChanged,
              validator: (v) {
                final n = double.tryParse(v ?? '');
                if (n == null || n <= 0) return 'Enter a valid amount';
                return null;
              }),
          SizedBox(height: 16.h),
          _label('Delivery deadline (optional)'),
          _deadlinePicker(),
          SizedBox(height: 16.h),
          _label('Fund from'),
          _accountPicker(),
          if (_quote != null) ...[
            SizedBox(height: 16.h),
            _feeBreakdown(_quote!),
          ],
          SizedBox(height: 16.h),
          _disclaimer(),
        ],
      ),
    );
  }

  Widget _buyerImagePicker() {
    return GestureDetector(
      onTap: _pickBuyerImage,
      child: Container(
        height: _buyerItemImage != null ? 180.h : 96.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: EscrowTheme.card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: EscrowTheme.border),
          image: _buyerItemImage != null
              ? DecorationImage(
                  image: FileImage(_buyerItemImage!), fit: BoxFit.cover)
              : null,
        ),
        child: _buyerItemImage != null
            ? Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: GestureDetector(
                    onTap: () => setState(() => _buyerItemImage = null),
                    child: CircleAvatar(
                      radius: 14.r,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, size: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo_outlined,
                      color: EscrowTheme.primary, size: 24.sp),
                  SizedBox(height: 8.h),
                  Text('Add a photo of what you want',
                      style: GoogleFonts.inter(
                          color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
                ],
              ),
      ),
    );
  }

  Widget _buildNavButtons() {
    final isLast = _currentPage == _totalPages - 1;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: EscrowTheme.bg,
        border: Border(top: BorderSide(color: EscrowTheme.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: _submitting ? null : _goToPreviousPage,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: EscrowTheme.border),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: Text(_currentPage == 0 ? 'Cancel' : 'Back',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600)),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: _submitting ? null : _goToNextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: EscrowTheme.primary,
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r)),
              ),
              child: _submitting
                  ? SizedBox(
                      height: 20.h,
                      width: 20.h,
                      child: const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2))
                  : Text(isLast ? 'Fund & create deal' : 'Continue',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
      );

  // Optional deadline selector — sets _deadlineDays (0 = no deadline). After
  // this window the deal can auto-expire/refund. Styled chips matching the
  // escrow accent.
  Widget _deadlinePicker() => Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: _deadlineOptions.map((opt) {
          final selected = _deadlineDays == opt.$1;
          return GestureDetector(
            onTap: () => setState(() => _deadlineDays = opt.$1),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
              decoration: BoxDecoration(
                color: selected ? EscrowTheme.primary.withValues(alpha: 0.18) : EscrowTheme.card,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: selected ? EscrowTheme.primary : EscrowTheme.border),
              ),
              child: Text(
                opt.$2,
                style: GoogleFonts.inter(
                  color: selected ? EscrowTheme.primary : EscrowTheme.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      );

  Widget _field(TextEditingController c,
      {String? hint,
      int maxLines = 1,
      TextInputType? keyboardType,
      String? Function(String?)? validator,
      void Function(String)? onChanged}) {
    return TextFormField(
      controller: c,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 13.sp),
        filled: true,
        fillColor: EscrowTheme.card,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.primary)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.error)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: EscrowTheme.error)),
      ),
    );
  }

  Widget _accountPicker() {
    return BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
      builder: (context, state) {
        if (state is! AccountCardsSummaryLoaded) {
          return Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
                color: EscrowTheme.card, borderRadius: BorderRadius.circular(12.r)),
            child: Text('Loading accounts…',
                style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 13.sp)),
          );
        }
        final accounts =
            state.accountSummaries.where((a) => a.currency.toUpperCase() == 'NGN').toList();
        if (accounts.isEmpty) {
          return Text('No NGN account found',
              style: GoogleFonts.inter(color: EscrowTheme.error, fontSize: 13.sp));
        }
        _selectedAccountId ??= accounts.first.id.toString();
        return Container(
          decoration: BoxDecoration(
              color: EscrowTheme.card, borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: EscrowTheme.border)),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedAccountId,
              isExpanded: true,
              dropdownColor: EscrowTheme.card,
              icon: const Icon(Icons.keyboard_arrow_down, color: EscrowTheme.textSecondary),
              items: accounts
                  .map((a) => DropdownMenuItem(
                        value: a.id.toString(),
                        child: Text(
                            '${a.accountType.toUpperCase()} · ${a.currency} ${a.availableBalance.toStringAsFixed(2)}',
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _selectedAccountId = v),
            ),
          ),
        );
      },
    );
  }

  Widget _feeBreakdown(EscrowFeeQuote q) {
    Widget row(String l, String v, {bool bold = false}) => Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l, style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 12.5.sp)),
              Text(v,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 12.5.sp,
                      fontWeight: bold ? FontWeight.w700 : FontWeight.w500)),
            ],
          ),
        );
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: EscrowTheme.card,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: EscrowTheme.border),
      ),
      child: Column(
        children: [
          row('Deal amount', 'NGN ${q.amount.toStringAsFixed(2)}'),
          row('Escrow fee (${q.feePayer}-paid)', 'NGN ${q.fee.toStringAsFixed(2)}'),
          Divider(color: EscrowTheme.border, height: 16.h),
          row('You pay', 'NGN ${q.buyerTotal.toStringAsFixed(2)}', bold: true),
          row('Seller receives', 'NGN ${q.sellerNet.toStringAsFixed(2)}'),
        ],
      ),
    );
  }


  Widget _disclaimer() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lock_outline, size: 14.sp, color: EscrowTheme.textSecondary),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
                'Your funds are held securely in escrow and only released to the seller after you confirm delivery.',
                style: GoogleFonts.inter(color: EscrowTheme.textSecondary, fontSize: 11.sp)),
          ),
        ],
      );
}
