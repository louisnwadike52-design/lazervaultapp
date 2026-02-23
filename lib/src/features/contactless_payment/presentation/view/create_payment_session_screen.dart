import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../domain/repositories/contactless_payment_repository.dart';
import '../cubit/contactless_payment_cubit.dart';
import '../cubit/contactless_payment_state.dart';
import 'nfc_broadcast_screen.dart';

class CreatePaymentSessionScreen extends StatelessWidget {
  const CreatePaymentSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _CreatePaymentSessionView(),
    );
  }
}

class _CreatePaymentSessionView extends StatefulWidget {
  const _CreatePaymentSessionView();

  @override
  State<_CreatePaymentSessionView> createState() =>
      _CreatePaymentSessionViewState();
}

class _CreatePaymentSessionViewState extends State<_CreatePaymentSessionView>
    with SingleTickerProviderStateMixin {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _customCategoryController = TextEditingController();
  final _amountFocusNode = FocusNode();
  String _selectedCurrency = 'NGN';
  String? _selectedCategory;
  int _validityMinutes = 2;
  bool _isCreating = false;

  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  static const _categories = [
    ('Food', Icons.restaurant_rounded, Color(0xFFEF4444)),
    ('Transport', Icons.directions_car_rounded, Color(0xFF3B82F6)),
    ('Shopping', Icons.shopping_bag_rounded, Color(0xFFF59E0B)),
    ('Services', Icons.build_rounded, Color(0xFF8B5CF6)),
    ('Bills', Icons.receipt_rounded, Color(0xFF10B981)),
    ('Other', Icons.more_horiz_rounded, Color(0xFF6B7280)),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _autoSelectCurrency();
    });
  }

  void _autoSelectCurrency() {
    try {
      final accountState = context.read<AccountCardsSummaryCubit>().state;
      if (accountState is AccountCardsSummaryLoaded &&
          accountState.accountSummaries.isNotEmpty) {
        setState(() {
          _selectedCurrency = accountState.accountSummaries.first.currency;
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    _customCategoryController.dispose();
    _amountFocusNode.dispose();
    _animController.dispose();
    super.dispose();
  }

  double? get _parsedAmount {
    if (_amountController.text.isEmpty) return null;
    final cleaned = _amountController.text.replaceAll(',', '');
    return double.tryParse(cleaned);
  }

  bool get _isValid {
    final amount = _parsedAmount;
    return amount != null && amount > 0 && amount <= 10000000;
  }

  void _createSession() {
    if (!_isValid) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount between 1 and 10,000,000',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    setState(() => _isCreating = true);

    final category = _selectedCategory == 'other' &&
            _customCategoryController.text.trim().isNotEmpty
        ? _customCategoryController.text.trim().toLowerCase()
        : _selectedCategory;

    context.read<ContactlessPaymentCubit>().createPaymentSession(
          amount: _parsedAmount!,
          currency: _selectedCurrency,
          category: category,
          description: _descriptionController.text.isNotEmpty
              ? _descriptionController.text.trim()
              : null,
          validitySeconds: _validityMinutes * 60,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1A1A3E),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: BlocListener<ContactlessPaymentCubit, ContactlessPaymentState>(
          listener: (context, state) {
            if (state is PaymentSessionCreated) {
              setState(() => _isCreating = false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NfcBroadcastScreen(
                    session: state.session,
                    nfcPayload: state.nfcPayload,
                  ),
                ),
              );
            } else if (state is ContactlessPaymentError) {
              setState(() => _isCreating = false);
              Get.snackbar(
                'Failed to Create Session',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
                duration: const Duration(seconds: 4),
              );
            }
          },
          child: SafeArea(
            child: Column(
              children: [
                _buildHeader(),
                Expanded(
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            _buildAmountSection(),
                            SizedBox(height: 28.h),
                            _buildCategorySelector(),
                            SizedBox(height: 28.h),
                            _buildDescriptionInput(),
                            SizedBox(height: 28.h),
                            _buildValiditySelector(),
                            SizedBox(height: 40.h),
                            _buildCreateButton(),
                            SizedBox(height: 100.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Receive Payment',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Set the amount you want to receive',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSection() {
    return Container(
      padding: EdgeInsets.all(28.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A3E).withValues(alpha: 0.8),
            const Color(0xFF1F1F35).withValues(alpha: 0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Enter Amount',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _selectedCurrency,
                style: GoogleFonts.inter(
                  color: const Color(0xFF6366F1),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  focusNode: _amountFocusNode,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 40.sp,
                    fontWeight: FontWeight.w800,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                      fontSize: 40.sp,
                      fontWeight: FontWeight.w800,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          if (_parsedAmount != null && _parsedAmount! > 10000000) ...[
            SizedBox(height: 8.h),
            Text(
              'Maximum amount is 10,000,000',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category (Optional)',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: _categories.map((cat) {
            final (name, icon, color) = cat;
            final isSelected = _selectedCategory == name.toLowerCase();
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategory =
                      isSelected ? null : name.toLowerCase();
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color.withValues(alpha: 0.2)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isSelected
                        ? color.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon,
                        color:
                            isSelected ? color : const Color(0xFF9CA3AF),
                        size: 18.sp),
                    SizedBox(width: 6.w),
                    Text(
                      name,
                      style: GoogleFonts.inter(
                        color:
                            isSelected ? color : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        if (_selectedCategory == 'other') ...[
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF6B7280).withValues(alpha: 0.3),
              ),
            ),
            child: TextField(
              controller: _customCategoryController,
              maxLength: 30,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Enter category name...',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  fontSize: 14.sp,
                ),
                border: InputBorder.none,
                counterStyle: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDescriptionInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description (Optional)',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLength: 100,
            maxLines: 2,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: 'e.g., Coffee, Lunch, Subscription...',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 14.sp,
              ),
              border: InputBorder.none,
              counterStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildValiditySelector() {
    final options = [
      (1, '1 min'),
      (2, '2 min'),
      (5, '5 min'),
      (10, '10 min'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session Validity',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'How long this payment request stays active',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 12.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: options.map((opt) {
            final (minutes, label) = opt;
            final isSelected = _validityMinutes == minutes;
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _validityMinutes = minutes),
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                          )
                        : null,
                    color: isSelected
                        ? null
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: GoogleFonts.inter(
                        color: isSelected
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onTap: (_isCreating || !_isValid) ? null : _createSession,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          decoration: BoxDecoration(
            gradient: _isValid
                ? const LinearGradient(
                    colors: [Color(0xFF10B981), Color(0xFF059669)],
                  )
                : null,
            color: _isValid ? null : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: _isValid
                ? [
                    BoxShadow(
                      color:
                          const Color(0xFF10B981).withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: _isCreating
                ? SizedBox(
                    height: 22.h,
                    width: 22.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.contactless_rounded,
                        color: _isValid
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        size: 22.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Generate Payment Request',
                        style: GoogleFonts.inter(
                          color: _isValid
                              ? Colors.white
                              : const Color(0xFF9CA3AF),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
