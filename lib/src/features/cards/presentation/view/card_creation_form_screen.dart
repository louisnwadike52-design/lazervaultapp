import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';

class CardCreationFormScreen extends StatefulWidget {
  const CardCreationFormScreen({super.key});

  @override
  State<CardCreationFormScreen> createState() => _CardCreationFormScreenState();
}

class _CardCreationFormScreenState extends State<CardCreationFormScreen> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _spendingLimitController = TextEditingController();

  String spendingLimitAmount = ''; // Stores amount in minor units
  CardType _cardType = CardType.virtual;
  int _selectedExpiryHours = 24;
  int? _maxUsageCount;
  bool _isLoading = false;
  String cardHolderName = '';

  final List<int> quickLimits = [50, 100, 200, 500]; // Quick spending limits

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    // Get card type from route arguments
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['cardType'] != null) {
      _cardType = args['cardType'] as CardType;
    }

    // Pre-fill card holder name from user profile
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      final profile = authState.profile;
      cardHolderName = '${profile.user.firstName} ${profile.user.lastName}';
    }
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _spendingLimitController.dispose();
    super.dispose();
  }

  // Number pad input handling
  void _onNumberPress(String value) {
    if (_cardType == CardType.virtual) return; // Only for disposable cards

    setState(() {
      if (value == '<') {
        if (spendingLimitAmount.isNotEmpty) {
          spendingLimitAmount = spendingLimitAmount.substring(0, spendingLimitAmount.length - 1);
        }
      } else {
        if (spendingLimitAmount.length < 8) {
          spendingLimitAmount += value;
        }
      }
      _spendingLimitController.text = _formatAmount();
    });
  }

  void _setQuickLimit(int value) {
    setState(() {
      spendingLimitAmount = '${value}00';
      _spendingLimitController.text = _formatAmount();
    });
  }

  String _formatAmount() {
    if (spendingLimitAmount.isEmpty) return '£0.00';
    try {
      double value = double.parse(spendingLimitAmount) / 100.0;
      return NumberFormat.currency(symbol: '£', decimalDigits: 2).format(value);
    } catch (e) {
      return '£0.00';
    }
  }

  void _showConfirmationDialog() {
    // Validation
    if (_cardType == CardType.disposable && spendingLimitAmount.isEmpty) {
      Get.snackbar(
        'Missing Spending Limit',
        'Please enter a spending limit for your disposable card',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
      return;
    }

    final double? limit = spendingLimitAmount.isNotEmpty
        ? double.parse(spendingLimitAmount) / 100.0
        : null;

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      builder: (dialogContext) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.95),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 24,
                spreadRadius: 3,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    Container(
                      width: 64.w,
                      height: 64.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.05),
                          ],
                        ),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                      ),
                      child: Icon(
                        _cardType == CardType.virtual
                            ? Icons.credit_card_rounded
                            : Icons.receipt_long_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Create ${_cardType.name.capitalize} Card?',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      _buildConfirmationRow('Card Holder', cardHolderName, ''),
                      if (_nicknameController.text.isNotEmpty)
                        _buildConfirmationRow('Nickname', _nicknameController.text, ''),
                      if (_cardType == CardType.disposable && limit != null) ...[
                        _buildConfirmationRow(
                          'Spending Limit',
                          '',
                          NumberFormat.currency(symbol: '£', decimalDigits: 2).format(limit),
                        ),
                        if (_maxUsageCount != null)
                          _buildConfirmationRow('Max Uses', '', '$_maxUsageCount times'),
                        _buildConfirmationRow(
                          'Expires In',
                          '',
                          _selectedExpiryHours < 168
                              ? '$_selectedExpiryHours hours'
                              : '1 week',
                          isLast: true,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading
                            ? null
                            : () {
                                Navigator.pop(dialogContext);
                                _createCard();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2962FF).withValues(alpha: 0.9),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          disabledBackgroundColor: Colors.grey.withValues(alpha: 0.5),
                          elevation: 8,
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : const Text(
                                'Create Card',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextButton(
                      onPressed: _isLoading ? null : () => Navigator.pop(dialogContext),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: _isLoading ? Colors.grey : Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfirmationRow(String label, String name, String detail, {bool isLast = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (name.isNotEmpty)
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (detail.isNotEmpty)
              Text(
                detail,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        if (!isLast)
          Divider(
            color: Colors.white.withValues(alpha: 0.1),
            height: 24,
            thickness: 1,
          ),
      ],
    );
  }

  void _createCard() {
    setState(() => _isLoading = true);

    final cardCubit = context.read<CardCubit>();
    const int accountId = 1;
    final String? nickname = _nicknameController.text.trim().isNotEmpty
        ? _nicknameController.text.trim()
        : null;
    const String currency = 'GBP';

    if (_cardType == CardType.virtual) {
      cardCubit.createVirtualCard(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        currency: currency,
      );
    } else {
      final double? spendingLimit = spendingLimitAmount.isNotEmpty
          ? double.parse(spendingLimitAmount) / 100.0
          : null;

      cardCubit.createDisposableCard(
        accountId: accountId,
        cardHolderName: cardHolderName,
        nickname: nickname,
        spendingLimit: spendingLimit,
        maxUsageCount: _maxUsageCount,
        expiresInHours: _selectedExpiryHours,
        currency: currency,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: BlocListener<CardCubit, CardState>(
        listener: (context, state) {
          if (state is CardCreating) {
            setState(() => _isLoading = true);
          } else if (state is CardCreated) {
            setState(() => _isLoading = false);
            Get.toNamed(
              AppRoutes.cardCreationReceipt,
              arguments: {'card': state.card},
            );
          } else if (state is CardError) {
            setState(() => _isLoading = false);
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: Colors.red.withValues(alpha: 0.7),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: AbsorbPointer(
              absorbing: _isLoading,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // Top Row
                      Row(
                        children: [
                          const BackNavigator(),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Create ${_cardType.name.capitalize} Card',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    cardHolderName,
                                    style: TextStyle(
                                      color: Colors.white.withValues(alpha: 0.7),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 40.w,
                            height: 40.h,
                            padding: const EdgeInsets.all(2.0),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey[700],
                              child: Icon(
                                _cardType == CardType.virtual
                                    ? Icons.credit_card_rounded
                                    : Icons.receipt_long_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Card Details Section
                      if (_cardType == CardType.disposable) ...[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Spending Limit:',
                                style: TextStyle(color: Colors.white70),
                              ),
                              SizedBox(height: 4.h),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Text(
                                      'GBP',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: TextField(
                                      controller: _spendingLimitController,
                                      readOnly: true,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '£0.00',
                                        hintStyle: TextStyle(
                                          color: Colors.white.withValues(alpha: 0.5),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),

                              // Nickname field
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.05),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.label_outline,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: TextField(
                                        controller: _nicknameController,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Card nickname (optional)',
                                          hintStyle: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(vertical: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Quick limits
                        SizedBox(
                          height: 40.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: quickLimits
                                .map((limitValue) => GestureDetector(
                                      onTap: () => _setQuickLimit(limitValue),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(alpha: 0.05),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          '£$limitValue',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 16.h),

                        // Expiry selection
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Card Expiry',
                              style: TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Expanded(child: _buildExpiryChip('24hrs', 24)),
                                SizedBox(width: 8.w),
                                Expanded(child: _buildExpiryChip('48hrs', 48)),
                                SizedBox(width: 8.w),
                                Expanded(child: _buildExpiryChip('72hrs', 72)),
                                SizedBox(width: 8.w),
                                Expanded(child: _buildExpiryChip('1wk', 168)),
                              ],
                            ),
                          ],
                        ),
                      ] else ...[
                        // Virtual card - just nickname
                        Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.label_outline,
                                color: Colors.white70,
                                size: 20,
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: TextField(
                                  controller: _nicknameController,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Card nickname (optional)',
                                    hintStyle: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 16.h),

                      // Create button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _showConfirmationDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2962FF).withValues(alpha: 0.8),
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            disabledBackgroundColor: Colors.grey.withValues(alpha: 0.3),
                          ),
                          child: const Text(
                            'Create Card',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Number pad (only for disposable cards)
                      if (_cardType == CardType.disposable)
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 3,
                            mainAxisSpacing: 16.h,
                            crossAxisSpacing: 16.w,
                            childAspectRatio: 2.5,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              for (var i = 1; i <= 9; i++)
                                _buildNumberButton(i.toString()),
                              Container(),
                              _buildNumberButton('0'),
                              _buildNumberButton('<'),
                            ],
                          ),
                        ),
                    ],
                  ),
                  if (_isLoading)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.5),
                        child: const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () => _onNumberPress(number),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white.withValues(alpha: 0.1),
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.zero,
      ),
      child: Center(
        child: Text(
          number == '<' ? '⌫' : number,
          style: TextStyle(
            color: Colors.white,
            fontSize: number == '<' ? 20 : 24,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildExpiryChip(String label, int hours) {
    final isSelected = _selectedExpiryHours == hours;
    return GestureDetector(
      onTap: () => setState(() => _selectedExpiryHours = hours),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2962FF).withValues(alpha: 0.8)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
