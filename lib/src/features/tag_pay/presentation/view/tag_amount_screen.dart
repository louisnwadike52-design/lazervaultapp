import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/services/locale_manager.dart';
import '../../domain/entities/user_search_result_entity.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

class TagAmountScreen extends StatefulWidget {
  const TagAmountScreen({super.key});

  @override
  State<TagAmountScreen> createState() => _TagAmountScreenState();
}

class _TagAmountScreenState extends State<TagAmountScreen> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  late List<UserSearchResultEntity> _selectedUsers;
  late String _currency;
  StreamSubscription<String>? _currencySubscription;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _selectedUsers =
        List<UserSearchResultEntity>.from(args['selectedUsers'] as List);

    final localeManager = serviceLocator<LocaleManager>();

    // Check for pre-filled data (from repeat tag feature)
    final prefillCurrency = args['prefillCurrency'] as String?;
    final prefillAmount = args['prefillAmount'] as double?;
    final prefillDescription = args['prefillDescription'] as String?;

    // Use pre-filled currency if available, otherwise use locale default
    _currency = prefillCurrency ?? localeManager.currentCurrency;

    // Pre-fill amount if available
    if (prefillAmount != null && prefillAmount > 0) {
      _amountController.text = prefillAmount.toStringAsFixed(
        prefillAmount == prefillAmount.roundToDouble() ? 0 : 2,
      );
    }

    // Pre-fill description if available
    if (prefillDescription != null && prefillDescription.isNotEmpty) {
      _descriptionController.text = prefillDescription;
    }

    // Only listen to currency changes if not using a pre-filled currency
    if (prefillCurrency == null) {
      _currencySubscription =
          localeManager.currencyStream.listen((newCurrency) {
        if (mounted && newCurrency != _currency) {
          setState(() {
            _currency = newCurrency;
            _amountController.clear();
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _currencySubscription?.cancel();
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String _currencySymbol() {
    switch (_currency) {
      case 'NGN':
        return '\u20A6';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      case 'USD':
        return '\$';
      case 'ZAR':
        return 'R';
      default:
        return _currency;
    }
  }

  List<double> _quickAmounts() {
    switch (_currency) {
      case 'NGN':
        return [500, 1000, 2000, 5000, 10000];
      case 'GBP':
      case 'EUR':
      case 'USD':
        return [5, 10, 25, 50, 100];
      case 'ZAR':
        return [50, 100, 200, 500, 1000];
      default:
        return [10, 25, 50, 100, 500];
    }
  }

  void _createTag() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      Get.snackbar(
        'Invalid Amount',
        'Please enter a valid amount',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    final isBatch = _selectedUsers.length > 1;
    final recipientNames = _selectedUsers.map((u) => u.fullName).toList();
    final recipientTags = _selectedUsers.map((u) => u.username).toList();

    Get.toNamed(
      AppRoutes.tagCreationProcessing,
      arguments: {
        'recipientName': recipientNames.first,
        'recipientTag': recipientTags.first,
        'recipientNames': recipientNames,
        'recipientTags': recipientTags,
        'amount': amount,
        'currency': _currency,
        'description': _descriptionController.text.trim(),
        'isBatch': isBatch,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 24.h),
              _buildSelectedUserPills(),
              SizedBox(height: 24.h),
              _buildAmountInput(),
              SizedBox(height: 24.h),
              _buildDescriptionInput(),
              SizedBox(height: 16.h),
              _buildSummary(),
              SizedBox(height: 24.h),
              _buildCreateButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(22.r),
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
                'Set Amount',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Enter tag amount and details',
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
    );
  }

  Widget _buildSelectedUserPills() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _selectedUsers.map((user) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: const Color(0xFF2D2D2D), width: 1),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                child: Text(
                  user.initials,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4E03D0),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '@${user.username}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAmountInput() {
    final symbol = _currencySymbol();
    final quickAmounts = _quickAmounts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        // A plain Wrap sized every chip to its own label, so "₦500 ₦1000
        // ₦2000" and "₦5000 ₦10000" ended up as two rows of different widths
        // with nothing lining up between them. Laying them on a fixed
        // three-column grid puts the second row's chips directly under the
        // first row's, whatever the currency's amounts happen to be.
        LayoutBuilder(
          builder: (context, constraints) {
            const columns = 3;
            final gutter = 12.w;
            final cellWidth =
                (constraints.maxWidth - gutter * (columns - 1)) / columns;
            return Wrap(
              spacing: gutter,
              runSpacing: gutter,
              children: quickAmounts.map((amount) {
                final amountStr = amount.toStringAsFixed(0);
                final isSelected = _amountController.text == amountStr;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _amountController.text = amountStr;
                    });
                  },
                  child: Container(
                    width: cellWidth,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                          : const Color(0xFF1F1F1F),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF4E03D0)
                            : const Color(0xFF2D2D2D),
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        '$symbol$amountStr',
                        style: GoogleFonts.inter(
                          color: isSelected
                              ? const Color(0xFF4E03D0)
                              : Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            // Matches the description box and the summary card, so the three
            // stacked cards read as one family instead of one borderless odd
            // one out.
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Row(
            // The currency code and the amount are different sizes; centring
            // them left "NGN" visibly low against the digits. Sitting them on
            // a shared baseline is what makes them read as one figure.
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _currency,
                style: GoogleFonts.inter(
                  color: const Color(0xFF4E03D0),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    border: InputBorder.none,
                    // Without this the field carries Material's default
                    // content padding, which added invisible height on top of
                    // the container's own and pushed the digits off-centre.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
        ),
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
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: 3,
            // The server rejects anything longer, so stop it at the source
            // rather than letting the user type a note that gets refused.
            maxLength: 280,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            decoration: InputDecoration(
              hintText: 'What is this tag for?',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
              ),
              border: InputBorder.none,
              counterText: '',
              // Material's default content padding sat inside the container's
              // own 16, so the hint started further in than every other field
              // on the screen.
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    final symbol = _currencySymbol();
    final count = _selectedUsers.length;
    final total = amount * count;

    if (amount <= 0) return const SizedBox.shrink();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$count user${count > 1 ? 's' : ''} \u00D7 $symbol${amount.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            '$symbol${total.toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton() {
    final count = _selectedUsers.length;
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        final isLoading = state is TagPayLoading;

        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isLoading ? null : _createTag,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4E03D0),
              disabledBackgroundColor:
                  const Color(0xFF4E03D0).withValues(alpha: 0.5),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? LazerVaultLoader.small()
                : Text(
                    count > 1 ? 'Create Tags' : 'Create Tag',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
