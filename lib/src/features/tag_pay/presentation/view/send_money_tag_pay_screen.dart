import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/services/injection_container.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

class SendMoneyTagPayScreen extends StatelessWidget {
  const SendMoneyTagPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TagPayCubit>(),
      child: const _SendMoneyTagPayView(),
    );
  }
}

class _SendMoneyTagPayView extends StatefulWidget {
  const _SendMoneyTagPayView();

  @override
  State<_SendMoneyTagPayView> createState() => _SendMoneyTagPayViewState();
}

class _SendMoneyTagPayViewState extends State<_SendMoneyTagPayView> {
  final _tagPayController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedAccountId;
  bool _isSearching = false;

  @override
  void dispose() {
    _tagPayController.dispose();
    _amountController.dispose();
    _descriptionController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _searchTagPay(String query) {
    if (query.isEmpty) {
      setState(() => _isSearching = false);
      return;
    }

    final cleanTag = query.replaceAll('@', '').replaceAll('\$', '');
    if (cleanTag.length < 3) {
      setState(() => _isSearching = false);
      return;
    }

    setState(() => _isSearching = true);
    context.read<TagPayCubit>().getTagPay(cleanTag);
  }

  void _sendMoney() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedAccountId == null) {
      Get.snackbar(
        'Error',
        'Please select a source account',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
      );
      return;
    }

    final cleanTag = _tagPayController.text.replaceAll('@', '').replaceAll('\$', '');
    context.read<TagPayCubit>().sendMoney(
      receiverTagPay: cleanTag,
      amount: double.parse(_amountController.text),
      currency: 'USD',
      description: _descriptionController.text.isEmpty ? null : _descriptionController.text,
      sourceAccountId: _selectedAccountId!,
      transactionPin: _pinController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is TagPayLoaded) {
            setState(() => _isSearching = false);
            Get.snackbar(
              'Found',
              'Found tag pay: ${state.tagPay.displayName}',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
          } else if (state is MoneyTransferSuccess) {
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
            Get.back(result: state.transaction);
          } else if (state is TagPayError) {
            setState(() => _isSearching = false);
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is TagPayLoading;

          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _buildTagPayInput(),
                          if (state is TagPayLoaded) ...[
                            SizedBox(height: 16.h),
                            _buildRecipientCard(state),
                          ],
                          SizedBox(height: 24.h),
                          _buildAmountInput(),
                          SizedBox(height: 24.h),
                          _buildDescriptionInput(),
                          SizedBox(height: 24.h),
                          _buildAccountSelector(),
                          SizedBox(height: 24.h),
                          _buildPinInput(),
                          SizedBox(height: 32.h),
                          _buildSendButton(isLoading),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
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
            child: Text(
              'Send Money',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagPayInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Tag Pay',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _tagPayController,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'username',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '\$',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: _isSearching
                ? Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  )
                : IconButton(
                    icon: Icon(Icons.search, color: const Color(0xFF3B82F6)),
                    onPressed: () => _searchTagPay(_tagPayController.text),
                  ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
            ),
          ),
          onFieldSubmitted: _searchTagPay,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a tag pay';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildRecipientCard(TagPayLoaded state) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1E3A8A),
            Color(0xFF3B82F6),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: Text(
              state.tagPay.displayName.isNotEmpty
                  ? state.tagPay.displayName[0].toUpperCase()
                  : '\$',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.tagPay.displayName,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  state.tagPay.formattedTagPay,
                  style: GoogleFonts.inter(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF10B981),
            size: 24.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildAmountInput() {
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
        SizedBox(height: 8.h),
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                '\$',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF10B981), width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an amount';
            }
            final amount = double.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
            return null;
          },
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
        SizedBox(height: 8.h),
        TextFormField(
          controller: _descriptionController,
          maxLines: 3,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: 'What\'s this for?',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Source Account',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
          builder: (context, state) {
            if (state is AccountCardsSummaryLoaded) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: const Color(0xFF2D2D2D)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedAccountId,
                    hint: Text(
                      'Select an account',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                    isExpanded: true,
                    dropdownColor: const Color(0xFF1F1F1F),
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                    ),
                    items: state.accountSummaries.map((account) {
                      return DropdownMenuItem<String>(
                        value: account.id,
                        child: Text(
                          '${account.accountType} (\$${account.balance.toStringAsFixed(2)})',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _selectedAccountId = value);
                    },
                  ),
                ),
              );
            }
            return Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Text(
                'Loading accounts...',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildPinInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Transaction PIN',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 4,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
          ),
          decoration: InputDecoration(
            hintText: '••••',
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
            ),
            counterText: '',
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your PIN';
            }
            if (value.length != 4) {
              return 'PIN must be 4 digits';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSendButton(bool isLoading) {
    return ElevatedButton(
      onPressed: isLoading ? null : _sendMoney,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF10B981),
        disabledBackgroundColor: const Color(0xFF374151),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: isLoading
          ? SizedBox(
              width: 20.w,
              height: 20.w,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              'Send Money',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
