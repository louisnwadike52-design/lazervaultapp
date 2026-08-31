import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../cubit/create_invoice_cubit.dart';
import '../../utils/phone_validator.dart';
import '../../../domain/entities/invoice_entity.dart';
import '../../../../recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

/// Screen 3: Payer Details
///
/// Collects payer address, contact information, and optional logo/image
class PayerDetailsScreen extends StatefulWidget {
  final bool showPhone;
  final bool showAddress;

  const PayerDetailsScreen({
    super.key,
    this.showPhone = false,
    this.showAddress = false,
  });

  @override
  State<PayerDetailsScreen> createState() => _PayerDetailsScreenState();
}

class _PayerDetailsScreenState extends State<PayerDetailsScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  final ImagePicker _imagePicker = ImagePicker();

  late TextEditingController _companyController;
  late TextEditingController _contactController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _cityController;
  late TextEditingController _stateController;
  late TextEditingController _postcodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _fadeController.forward();

    // Initialize controllers with current cubit values
    final cubit = context.read<CreateInvoiceCubit>();
    _companyController = TextEditingController(text: cubit.payerCompany);
    _contactController = TextEditingController(text: cubit.payerContact);
    _emailController = TextEditingController(text: cubit.payerEmail);
    _phoneController = TextEditingController(text: cubit.payerPhone);
    _address1Controller = TextEditingController(text: cubit.payerAddress1);
    _address2Controller = TextEditingController(text: cubit.payerAddress2);
    _cityController = TextEditingController(text: cubit.payerCity);
    _stateController = TextEditingController(text: cubit.payerState);
    _postcodeController = TextEditingController(text: cubit.payerPostcode);
    _countryController = TextEditingController(text: cubit.payerCountry);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _companyController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  bool _isPickingImage = false;

  Future<void> _pickImage() async {
    if (_isPickingImage) return;
    _isPickingImage = true;
    try {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (image != null && mounted) {
      final cubit = context.read<CreateInvoiceCubit>();
      cubit.updatePayerImage(File(image.path));
    }
    } finally {
      _isPickingImage = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: BlocBuilder<CreateInvoiceCubit, dynamic>(
        builder: (context, _) {
          final cubit = context.read<CreateInvoiceCubit>();
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 20.h),
                _buildSplitToggle(cubit),
                SizedBox(height: 20.h),
                if (cubit.splitMode)
                  _buildSplitSection(cubit)
                else ...[
                  _buildLogoSection(),
                  SizedBox(height: 32.h),
                  _buildFormFields(),
                ],
                SizedBox(height: 24.h),
              ],
            ),
          );
        },
      ),
    );
  }

  // ── Split payment UI ────────────────────────────────────────────────────────

  static const _accent = Color(0xFF6366F1);

  Widget _buildSplitToggle(CreateInvoiceCubit cubit) {
    // Whole row is the tap target. The bare Switch has a small hit box and,
    // inside a scroll view, its taps sometimes lost the gesture arena to the
    // scrollable — which is why it "needed multiple clicks". Tapping anywhere
    // on the row now flips it, and the Switch still works directly.
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => cubit.toggleSplitMode(!cubit.splitMode),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            Icon(Icons.groups_rounded, color: _accent, size: 22.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Split among multiple people',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                  Text('Each person pays their share',
                      style: GoogleFonts.inter(
                          color: Colors.grey[500], fontSize: 12.sp)),
                ],
              ),
            ),
            Switch(
              value: cubit.splitMode,
              activeColor: _accent,
              onChanged: cubit.toggleSplitMode,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSplitSection(CreateInvoiceCubit cubit) {
    final symbol = CurrencySymbols.getSymbol(
        cubit.invoiceCurrency.isNotEmpty ? cubit.invoiceCurrency : 'NGN');
    final payers = cubit.splitPayers;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Payers (${payers.length})',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ),
            if (payers.length > 1)
              TextButton.icon(
                onPressed: cubit.splitEqually,
                icon: Icon(Icons.balance_rounded, size: 16.sp, color: _accent),
                label: Text('Split equally',
                    style: GoogleFonts.inter(
                        color: _accent,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600)),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        if (payers.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              children: [
                Icon(Icons.person_add_alt_1_rounded,
                    color: Colors.grey[600], size: 28.sp),
                SizedBox(height: 8.h),
                Text('Add the people to split this invoice with',
                    style: GoogleFonts.inter(
                        color: Colors.grey[500], fontSize: 13.sp)),
              ],
            ),
          )
        else
          ...payers.map((p) => _buildPayerRow(cubit, p, symbol)),
        SizedBox(height: 12.h),
        OutlinedButton.icon(
          onPressed: () => _addPayer(cubit),
          icon: Icon(Icons.add, size: 18.sp, color: _accent),
          label: Text('Add person',
              style: GoogleFonts.inter(
                  color: _accent, fontSize: 14.sp, fontWeight: FontWeight.w600)),
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: _accent.withValues(alpha: 0.5)),
            padding: EdgeInsets.symmetric(vertical: 12.h),
            minimumSize: Size(double.infinity, 0),
          ),
        ),
        if (payers.isNotEmpty) ...[
          SizedBox(height: 16.h),
          if (cubit.total <= 0)
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 14.sp, color: Colors.grey[500]),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      'Add items next — shares split equally and update automatically.',
                      style: GoogleFonts.inter(
                          color: Colors.grey[500], fontSize: 12.sp),
                    ),
                  ),
                ],
              ),
            ),
          _buildSplitSummary(cubit, symbol),
        ],
      ],
    );
  }

  Widget _buildPayerRow(
      CreateInvoiceCubit cubit, TaggedUserInfo p, String symbol) {
    final name = p.displayName;
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: _accent.withValues(alpha: 0.15),
            backgroundImage: (p.profilePicture != null &&
                    p.profilePicture!.isNotEmpty)
                ? NetworkImage(p.profilePicture!)
                : null,
            child: (p.profilePicture == null || p.profilePicture!.isEmpty)
                ? Text(
                    name.isNotEmpty ? name[0].toUpperCase() : '?',
                    style: GoogleFonts.inter(
                        color: _accent, fontWeight: FontWeight.w700),
                  )
                : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600)),
                if (p.username.isNotEmpty)
                  Text('@${p.username}',
                      style: GoogleFonts.inter(
                          color: Colors.grey[500], fontSize: 11.sp)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => _editAmount(cubit, p, symbol),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Text('$symbol${p.shareAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600)),
                  SizedBox(width: 4.w),
                  Icon(Icons.edit, size: 13.sp, color: Colors.grey[500]),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () => cubit.removeSplitPayer(p.userId),
            icon: Icon(Icons.close, size: 18.sp, color: Colors.grey[500]),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  Widget _buildSplitSummary(CreateInvoiceCubit cubit, String symbol) {
    final assigned = cubit.splitAssigned;
    final total = cubit.total;
    final remaining = cubit.splitRemaining;
    final balanced = remaining.abs() < 0.01;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: (balanced ? const Color(0xFF10B981) : const Color(0xFFFB923C))
            .withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
            color: (balanced
                    ? const Color(0xFF10B981)
                    : const Color(0xFFFB923C))
                .withValues(alpha: 0.35)),
      ),
      child: Column(
        children: [
          _summaryRow('Assigned',
              '$symbol${assigned.toStringAsFixed(2)}', Colors.white),
          SizedBox(height: 4.h),
          _summaryRow('Invoice total',
              '$symbol${total.toStringAsFixed(2)}', Colors.grey[400]!),
          if (!balanced) ...[
            SizedBox(height: 6.h),
            _summaryRow(
              remaining > 0 ? 'Unassigned' : 'Over by',
              '$symbol${remaining.abs().toStringAsFixed(2)}',
              const Color(0xFFFB923C),
            ),
          ] else if (cubit.splitCustom) ...[
            SizedBox(height: 6.h),
            Row(children: [
              Icon(Icons.check_circle, size: 14.sp, color: const Color(0xFF10B981)),
              SizedBox(width: 6.w),
              Text('Amounts add up to the total',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF10B981), fontSize: 12.sp)),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13.sp)),
        Text(value,
            style: GoogleFonts.inter(
                color: valueColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w700)),
      ],
    );
  }

  Future<void> _addPayer(CreateInvoiceCubit cubit) async {
    final user = await UsernameSearchBottomSheet.show(context);
    if (user == null) return;
    cubit.addSplitPayer(TaggedUserInfo(
      userId: user.userId,
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      profilePicture: user.profilePicture.isNotEmpty ? user.profilePicture : null,
    ));
  }

  Future<void> _editAmount(
      CreateInvoiceCubit cubit, TaggedUserInfo p, String symbol) async {
    final controller =
        TextEditingController(text: p.shareAmount.toStringAsFixed(2));
    // Own the focus explicitly. The previous version used `autofocus: true`,
    // which in a dialog tears the EditableText's focus subtree down WHILE it
    // still has dependents when the route pops — tripping
    // InheritedElement.debugDeactivated's `_dependents.isEmpty` assert and
    // red-screening the app the moment "Save" was tapped. Requesting focus
    // after the first frame and RELEASING it before we pop avoids that race.
    final focusNode = FocusNode();

    // Pop helper that unfocuses first, so the focus/IME subtree is released
    // cleanly before the dialog's elements deactivate.
    void closeWith(BuildContext ctx, double? value) {
      focusNode.unfocus();
      Navigator.of(ctx).pop(value);
    }

    final result = await showDialog<double>(
      context: context,
      builder: (ctx) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (focusNode.canRequestFocus) focusNode.requestFocus();
        });
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          title: Text("${p.displayName}'s share",
              style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp)),
          content: TextField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            style: const TextStyle(color: Colors.white),
            onSubmitted: (v) =>
                closeWith(ctx, double.tryParse(v.trim()) ?? 0),
            decoration: InputDecoration(
              prefixText: symbol,
              prefixStyle: const TextStyle(color: Colors.white),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF2D2D2D))),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: _accent)),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => closeWith(ctx, null),
              child: Text('Cancel', style: TextStyle(color: Colors.grey[400])),
            ),
            TextButton(
              onPressed: () =>
                  closeWith(ctx, double.tryParse(controller.text.trim()) ?? 0),
              child: const Text('Save', style: TextStyle(color: _accent)),
            ),
          ],
        );
      },
    );
    // Dispose AFTER the route is fully gone (await has returned), and after a
    // frame so nothing mid-teardown still references them.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.dispose();
      focusNode.dispose();
    });
    if (result != null) cubit.setSplitPayerAmount(p.userId, result);
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payer Details',
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Details of the person or company who will pay this invoice',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoSection() {
    return BlocBuilder<CreateInvoiceCubit, dynamic>(
      builder: (context, state) {
        final cubit = context.read<CreateInvoiceCubit>();
        final payerImage = cubit.payerImage;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Logo/Image (Optional)',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 140.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: payerImage != null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.file(
                              payerImage,
                              width: double.infinity,
                              height: 140.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8.h,
                            right: 8.w,
                            child: GestureDetector(
                              onTap: () => cubit.updatePayerImage(null),
                              child: Container(
                                padding: EdgeInsets.all(6.w),
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.6),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate,
                              size: 48.sp,
                              color: Colors.white.withValues(alpha: 0.4),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Tap to add logo or image',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[500],
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFormFields() {
    final cubit = context.read<CreateInvoiceCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          controller: _companyController,
          label: 'Company Name (Optional)',
          hint: "Payer's business name",
          icon: Icons.business,
          onChanged: (value) => cubit.updatePayerCompany(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _contactController,
          label: 'Contact Person *',
          hint: "Payer's full name",
          icon: Icons.person,
          onChanged: (value) => cubit.updatePayerContact(value),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _emailController,
          label: 'Email Address (Optional)',
          hint: 'payer@email.com',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => cubit.updatePayerEmail(value),
        ),
        SizedBox(height: 6.h),
        Text(
          'If provided, an email with the invoice will be automatically sent to the payer',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[500],
          ),
        ),
        if (widget.showPhone) ...[
          SizedBox(height: 16.h),
          _buildPhoneField(cubit),
        ],
        if (widget.showAddress) ...[
          SizedBox(height: 24.h),
          Text(
            'Address (Optional)',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _address1Controller,
            label: 'Street Address',
            hint: "Payer's street address",
            icon: Icons.location_on,
            onChanged: (value) => cubit.updatePayerAddress1(value),
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _address2Controller,
            label: 'Address Line 2',
            hint: 'Suite, Unit (optional)',
            icon: Icons.location_city,
            onChanged: (value) => cubit.updatePayerAddress2(value),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'San Francisco',
                  icon: Icons.location_city,
                  onChanged: (value) => cubit.updatePayerCity(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _stateController,
                  label: 'State/Province',
                  hint: 'CA',
                  icon: Icons.map,
                  onChanged: (value) => cubit.updatePayerState(value),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _postcodeController,
                  label: 'Postcode/ZIP',
                  hint: '94102',
                  icon: Icons.pin_drop,
                  onChanged: (value) => cubit.updatePayerPostcode(value),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildTextField(
                  controller: _countryController,
                  label: 'Country',
                  hint: 'USA',
                  icon: Icons.public,
                  onChanged: (value) => cubit.updatePayerCountry(value),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildPhoneField(CreateInvoiceCubit cubit) {
    final country = cubit.invoiceCountry;
    final hint = PhoneValidator.getHintText(country);
    final phone = cubit.payerPhone;
    // Optional field, any country: don't enforce a per-country max length.
    // Only flag an implausibly short entry once something is typed.
    final digits = phone.replaceAll(RegExp(r'[^0-9]'), '');
    final error = digits.isNotEmpty && digits.length < 4
        ? 'Enter a valid phone number'
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number (Optional)',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            // Allow international numbers: digits, leading +, and spaces.
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+ ]')),
            LengthLimitingTextInputFormatter(20),
          ],
          onChanged: (value) => cubit.updatePayerPhone(value),
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            prefixIcon: Icon(
              Icons.phone,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            errorText: error,
            errorStyle: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.red.shade400,
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          style: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[600],
            ),
            prefixIcon: Icon(
              icon,
              size: 20.sp,
              color: Colors.white.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.08),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(
                color: Color(0xFF3B82F6),
                width: 1.5,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
          ),
        ),
      ],
    );
  }
}
