import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:lazervault/core/types/app_routes.dart';

class InternationalTransferRecipientScreen extends StatefulWidget {
  const InternationalTransferRecipientScreen({super.key});

  @override
  State<InternationalTransferRecipientScreen> createState() =>
      _InternationalTransferRecipientScreenState();
}

class _InternationalTransferRecipientScreenState extends State<InternationalTransferRecipientScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _swiftController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  String _fromCurrency = '';
  String _toCurrency = '';
  Map<String, dynamic> _fromCurrencyData = {};
  Map<String, dynamic> _toCurrencyData = {};
  double _amount = 0.0;
  double _convertedAmount = 0.0;
  double _exchangeRate = 0.0;
  double _fees = 0.0;
  
  Map<String, dynamic>? _selectedRecipient;
  bool _isAddingNew = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    final args = Get.arguments as Map<String, dynamic>;
    _fromCurrency = args['fromCurrency'] ?? 'GBP';
    _toCurrency = args['toCurrency'] ?? 'USD';
    _fromCurrencyData = args['fromCurrencyData'] ?? {};
    _toCurrencyData = args['toCurrencyData'] ?? {};
    _amount = args['amount'] ?? 0.0;
    _convertedAmount = args['convertedAmount'] ?? 0.0;
    _exchangeRate = args['exchangeRate'] ?? 0.0;
    _fees = args['fees'] ?? 0.0;
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _accountController.dispose();
    _bankController.dispose();
    _swiftController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _selectRecipient(Map<String, dynamic> recipient) {
    setState(() {
      _selectedRecipient = recipient;
      _isAddingNew = false;
    });
  }

  void _showAddNewRecipient() {
    setState(() {
      _isAddingNew = true;
      _selectedRecipient = null;
    });
  }

  void _cancelAddNew() {
    setState(() {
      _isAddingNew = false;
    });
    _clearForm();
  }

  void _clearForm() {
    _nameController.clear();
    _accountController.clear();
    _bankController.clear();
    _swiftController.clear();
  }

  bool get _isFormValid {
    return _nameController.text.isNotEmpty &&
           _accountController.text.isNotEmpty &&
           _bankController.text.isNotEmpty &&
           _swiftController.text.isNotEmpty;
  }

  void _addNewRecipient() {
    if (!_isFormValid) return;
    
    final newRecipient = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': _nameController.text,
      'email': '${_nameController.text.toLowerCase().replaceAll(' ', '.')}@email.com',
      'account': '****${_accountController.text.substring(_accountController.text.length - 4)}',
      'fullAccount': _accountController.text,
      'bank': _bankController.text,
      'swift': _swiftController.text,
      'country': _toCurrencyData['country'] ?? 'Unknown',
      'currency': _toCurrency,
      'isFrequent': false,
      'lastUsed': DateTime.now(),
      'avatar': 'https://i.pravatar.cc/150?img=1',
    };

    setState(() {
      _selectedRecipient = newRecipient;
      _isAddingNew = false;
    });
    
    _clearForm();
  }

  void _proceedToReview() {
    if (_selectedRecipient == null) return;
    
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final totalSteps = args['totalSteps'] ?? 4;
    
    Get.toNamed(
      AppRoutes.internationalTransferReview,
      arguments: {
        'fromCurrency': _fromCurrency,
        'toCurrency': _toCurrency,
        'fromCurrencyData': _fromCurrencyData,
        'toCurrencyData': _toCurrencyData,
        'amount': _amount,
        'convertedAmount': _convertedAmount,
        'exchangeRate': _exchangeRate,
        'fees': _fees,
        'recipient': _selectedRecipient,
        'currentStep': totalSteps,
        'totalSteps': totalSteps,
        'stepTitle': 'Review & Confirm',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, _slideAnimation.value),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: _isAddingNew ? _buildAddNewRecipientForm() : _buildRecipientSelection(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final currentStep = args['currentStep'] ?? 3;
    final totalSteps = args['totalSteps'] ?? 4;
    final stepTitle = args['stepTitle'] ?? 'Select Recipient';
    
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: IconButton(
              onPressed: () => _isAddingNew ? _cancelAddNew() : Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isAddingNew ? 'Add Recipient' : stepTitle,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Step $currentStep of $totalSteps - Who are you sending to?',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '$currentStep/$totalSteps',
              style: GoogleFonts.inter(
                color: Colors.blue,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientSelection() {
    return Column(
      children: [
        _buildTransferSummary(),
        SizedBox(height: 24.h),
        _buildSearchBar(),
        SizedBox(height: 16.h),
        _buildAddNewButton(),
        SizedBox(height: 16.h),
        Expanded(child: _buildRecipientsList()),
        if (_selectedRecipient != null) _buildContinueButton(),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildTransferSummary() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withValues(alpha: 0.15),
            Colors.purple.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You\'re sending',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${_fromCurrencyData['symbol']}${_amount.toStringAsFixed(2)} $_fromCurrency',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward, color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'They\'ll receive',
                  style: GoogleFonts.inter(
                    color: Colors.white.withValues(alpha: 0.7),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '${_toCurrencyData['symbol']}${_convertedAmount.toStringAsFixed(2)} $_toCurrency',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.white.withValues(alpha: 0.5), size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search recipients...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 16.sp,
                ),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddNewButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _showAddNewRecipient,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.blue.withValues(alpha: 0.3), width: 2),
            ),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.blue, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Recipient',
                        style: GoogleFonts.inter(
                          color: Colors.blue,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Send money to someone new',
                        style: GoogleFonts.inter(
                          color: Colors.blue.withValues(alpha: 0.7),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientsList() {
    final recipients = <Map<String, dynamic>>[];
    
    if (recipients.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: Colors.grey[400], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'No recipients found',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: recipients.length,
      itemBuilder: (context, index) {
        final recipient = recipients[index];
        final isSelected = _selectedRecipient != null && _selectedRecipient!['id'] == recipient['id'];
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.only(bottom: 12.h),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _selectRecipient(recipient),
              borderRadius: BorderRadius.circular(16.r),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? Colors.green.withValues(alpha: 0.15)
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? Colors.green.withValues(alpha: 0.5)
                        : recipient['isFrequent']
                            ? Colors.orange.withValues(alpha: 0.3)
                            : Colors.white.withValues(alpha: 0.1),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isSelected ? Border.all(color: Colors.green, width: 2) : null,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: recipient['avatar'],
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[300],
                                child: Icon(Icons.person, color: Colors.grey[600]),
                              ),
                              errorWidget: (context, url, error) => Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.blue[700]!, Colors.blue[500]!],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    recipient['name'][0].toUpperCase(),
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 18.w,
                              height: 18.h,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: Icon(Icons.check, color: Colors.white, size: 10.sp),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  recipient['name'],
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              if (recipient['isFrequent'])
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    'FREQUENT',
                                    style: GoogleFonts.inter(
                                      color: Colors.orange,
                                      fontSize: 8.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '${recipient['bank']} • ${recipient['account']}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              _buildCurrencyFlag(recipient['currency'], size: 16),
                              SizedBox(width: 4.w),
                              Text(
                                recipient['country'],
                                style: GoogleFonts.inter(
                                  color: Colors.grey[500],
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      Icon(Icons.check_circle, color: Colors.green, size: 24.sp)
                    else
                      Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16.sp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddNewRecipientForm() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 24.h),
          _buildFormField('Full Name', _nameController, TextInputType.name),
          SizedBox(height: 16.h),
          _buildFormField('Account Number', _accountController, TextInputType.number),
          SizedBox(height: 16.h),
          _buildFormField('Bank Name', _bankController, TextInputType.text),
          SizedBox(height: 16.h),
          _buildFormField('SWIFT/BIC Code', _swiftController, TextInputType.text),
          SizedBox(height: 32.h),
          _buildAddRecipientButton(),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, TextEditingController controller, TextInputType keyboardType) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
            ),
            child: TextField(
              controller: controller,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: keyboardType,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter $label',
                hintStyle: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
                  fontSize: 16.sp,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddRecipientButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: _isFormValid
              ? LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!])
              : null,
          color: _isFormValid ? null : Colors.grey[800],
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isFormValid ? _addNewRecipient : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Text(
              'Add Recipient',
              style: GoogleFonts.inter(
                color: _isFormValid ? Colors.white : Colors.grey[500],
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue[700]!, Colors.blue[500]!]),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _proceedToReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 18.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Continue to Review',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrencyFlag(String currencyCode, {double size = 24}) {
    // Mock flag URLs for currencies
    final flagUrls = {
      'USD': 'https://flagcdn.com/w320/us.png',
      'EUR': 'https://flagcdn.com/w320/eu.png',
      'GBP': 'https://flagcdn.com/w320/gb.png',
      'JPY': 'https://flagcdn.com/w320/jp.png',
      'CAD': 'https://flagcdn.com/w320/ca.png',
    };
    
    return Container(
      width: size,
      height: size * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.r),
        child: CachedNetworkImage(
          imageUrl: flagUrls[currencyCode] ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.flag, size: size * 0.5, color: Colors.grey[600]),
          ),
        ),
      ),
    );
  }
} 