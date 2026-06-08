import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';

/// Add Customer — a 3-step wizard (Basics → Contact → Business) with per-step
/// validation, a searchable country-code picker on the phone field (and a
/// searchable country picker for the address country), all backed by
/// CustomerCubit.createCustomer.
class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF1F1F1F);
  static const _border = Color(0xFF2D2D2D);
  static const _blue = Color(0xFF3B82F6);
  static const _label = Color(0xFF9CA3AF);
  static const _hint = Color(0xFF6B7280);
  static const _red = Color(0xFFEF4444);

  final PageController _pageController = PageController();
  int _step = 0;
  static const _stepTitles = ['Basics', 'Contact', 'Business'];

  // One form key per step so "Next" only validates the visible step.
  final _formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  final _nameController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _tinController = TextEditingController();
  final _bankAccountNumberController = TextEditingController();
  final _bankCodeController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _tagsController = TextEditingController();
  final _notesController = TextEditingController();

  PhoneNumber? _phone;
  String _selectedSegment = 'None';
  static const _segments = ['None', 'VIP', 'Retail', 'Wholesale', 'Government'];

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    _businessNameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _tinController.dispose();
    _bankAccountNumberController.dispose();
    _bankCodeController.dispose();
    _bankNameController.dispose();
    _tagsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  int _segmentToInt(String segment) {
    switch (segment) {
      case 'VIP':
        return 1;
      case 'Retail':
        return 2;
      case 'Wholesale':
        return 3;
      case 'Government':
        return 4;
      default:
        return 0;
    }
  }

  List<String> _parseTags(String input) {
    if (input.trim().isEmpty) return [];
    return input
        .split(',')
        .map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();
  }

  // --- Navigation ---
  void _next() {
    final form = _formKeys[_step].currentState;
    if (form != null && !form.validate()) return;
    FocusScope.of(context).unfocus();
    if (_step < 2) {
      setState(() => _step++);
      _pageController.animateToPage(
        _step,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeInOut,
      );
    } else {
      _submitForm();
    }
  }

  void _back() {
    if (_step == 0) {
      Get.back();
      return;
    }
    FocusScope.of(context).unfocus();
    setState(() => _step--);
    _pageController.animateToPage(
      _step,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOut,
    );
  }

  void _submitForm() {
    // Validate every step before sending (guards against jumping via the bar).
    for (final k in _formKeys) {
      if (k.currentState != null && !k.currentState!.validate()) return;
    }
    context.read<CustomerCubit>().createCustomer(
          name: _nameController.text.trim(),
          businessName: _businessNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phone?.completeNumber ?? '',
          address: _addressController.text.trim(),
          city: _cityController.text.trim(),
          state: _stateController.text.trim(),
          country: _countryController.text.trim(),
          tin: _tinController.text.trim(),
          bankAccountNumber: _bankAccountNumberController.text.trim(),
          bankCode: _bankCodeController.text.trim(),
          bankName: _bankNameController.text.trim(),
          segment: _segmentToInt(_selectedSegment),
          tags: _parseTags(_tagsController.text),
          notes: _notesController.text.trim(),
        );
  }

  // --- Validators ---
  String? _required(String? v, String field) =>
      (v == null || v.trim().isEmpty) ? '$field is required' : null;

  String? _emailValidator(String? v) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return null; // optional
    final re = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');
    return re.hasMatch(s) ? null : 'Enter a valid email address';
  }

  String? _phoneValidator(PhoneNumber? phone) {
    final num = phone?.number.trim() ?? '';
    if (num.isEmpty) return null; // phone is optional
    // Validate length against the selected country's min/max.
    Country? c;
    for (final country in countries) {
      if (country.code == phone!.countryISOCode) {
        c = country;
        break;
      }
    }
    if (c != null && (num.length < c.minLength || num.length > c.maxLength)) {
      return 'Enter a valid ${c.name} number';
    }
    return null;
  }

  String? _digitsValidator(String? v, {required String field, int? exactLen}) {
    final s = v?.trim() ?? '';
    if (s.isEmpty) return null; // optional
    if (!RegExp(r'^\d+$').hasMatch(s)) return '$field must be digits only';
    if (exactLen != null && s.length != exactLen) {
      return '$field must be $exactLen digits';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Customer "${state.customer.name}" created successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is CustomerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: _red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CustomerLoading;
        return Scaffold(
          backgroundColor: _bg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: _back,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Add Customer',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                _buildStepper(),
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildBasicsStep(),
                      _buildContactStep(),
                      _buildBusinessStep(),
                    ],
                  ),
                ),
                _buildBottomActions(isLoading),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Progress stepper ---
  Widget _buildStepper() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 4.h, 20.w, 14.h),
      child: Row(
        children: List.generate(3, (i) {
          final active = i <= _step;
          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (i > 0)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: i <= _step ? _blue : _border,
                        ),
                      ),
                    Container(
                      width: 26.w,
                      height: 26.w,
                      decoration: BoxDecoration(
                        color: active ? _blue : _card,
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: active ? _blue : _border, width: 1.5),
                      ),
                      alignment: Alignment.center,
                      child: i < _step
                          ? Icon(Icons.check, color: Colors.white, size: 15.sp)
                          : Text('${i + 1}',
                              style: GoogleFonts.inter(
                                  color: active ? Colors.white : _label,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700)),
                    ),
                    if (i < 2)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: i < _step ? _blue : _border,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  _stepTitles[i],
                  style: GoogleFonts.inter(
                    color: active ? Colors.white : _label,
                    fontSize: 11.sp,
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- Step 1: Basics ---
  Widget _buildBasicsStep() {
    return Form(
      key: _formKeys[0],
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Who is this customer?'),
            SizedBox(height: 16.h),
            _textField(
              controller: _nameController,
              label: 'Customer Name *',
              hint: 'e.g. John Doe',
              icon: Icons.person_outline,
              validator: (v) => _required(v, 'Name'),
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(height: 14.h),
            _textField(
              controller: _businessNameController,
              label: 'Business Name',
              hint: 'e.g. Doe Enterprises Ltd',
              icon: Icons.business_outlined,
              textCapitalization: TextCapitalization.words,
            ),
            SizedBox(height: 14.h),
            _segmentField(),
            SizedBox(height: 14.h),
            _textField(
              controller: _tagsController,
              label: 'Tags',
              hint: 'Comma-separated, e.g. priority, wholesale',
              icon: Icons.label_outline,
            ),
          ],
        ),
      ),
    );
  }

  // --- Step 2: Contact ---
  Widget _buildContactStep() {
    return Form(
      key: _formKeys[1],
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('How do we reach them?'),
            SizedBox(height: 16.h),
            _textField(
              controller: _emailController,
              label: 'Email',
              hint: 'e.g. john@example.com',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: _emailValidator,
            ),
            SizedBox(height: 14.h),
            _phoneField(),
            SizedBox(height: 14.h),
            _textField(
              controller: _addressController,
              label: 'Address',
              hint: 'Street address',
              icon: Icons.location_on_outlined,
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: _textField(
                    controller: _cityController,
                    label: 'City',
                    hint: 'e.g. Lagos',
                    icon: Icons.location_city_outlined,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _textField(
                    controller: _stateController,
                    label: 'State',
                    hint: 'e.g. Lagos',
                    icon: Icons.map_outlined,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            _countryField(),
          ],
        ),
      ),
    );
  }

  // --- Step 3: Business ---
  Widget _buildBusinessStep() {
    return Form(
      key: _formKeys[2],
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Business & banking'),
            SizedBox(height: 16.h),
            _textField(
              controller: _tinController,
              label: 'TIN',
              hint: 'Tax Identification Number',
              icon: Icons.receipt_long_outlined,
            ),
            SizedBox(height: 14.h),
            _textField(
              controller: _bankNameController,
              label: 'Bank Name',
              hint: 'e.g. First Bank',
              icon: Icons.account_balance_outlined,
            ),
            SizedBox(height: 14.h),
            _textField(
              controller: _bankAccountNumberController,
              label: 'Bank Account Number',
              hint: 'e.g. 0123456789',
              icon: Icons.credit_card_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => _digitsValidator(v,
                  field: 'Account number', exactLen: 10),
            ),
            SizedBox(height: 14.h),
            _textField(
              controller: _bankCodeController,
              label: 'Bank Code',
              hint: 'e.g. 011',
              icon: Icons.pin_outlined,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) => _digitsValidator(v, field: 'Bank code'),
            ),
            SizedBox(height: 14.h),
            _textField(
              controller: _notesController,
              label: 'Notes',
              hint: 'Any additional notes about this customer',
              icon: Icons.notes_outlined,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared widgets
  // ---------------------------------------------------------------------------
  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _fieldLabel(String label) => Padding(
        padding: EdgeInsets.only(bottom: 6.h),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: _label,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel(label),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          maxLines: maxLines,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          decoration: _decoration(hint, icon),
        ),
      ],
    );
  }

  InputDecoration _decoration(String hint, IconData? icon) => InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: _hint, fontSize: 15.sp),
        prefixIcon: icon != null ? Icon(icon, color: _label, size: 20.sp) : null,
        filled: true,
        fillColor: _card,
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
          borderSide: const BorderSide(color: _blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: _red),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      );

  Widget _phoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Phone'),
        IntlPhoneField(
          initialCountryCode: 'NG',
          disableLengthCheck: true, // our validator handles optional + length
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          dropdownTextStyle:
              GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
          dropdownIcon: const Icon(Icons.arrow_drop_down, color: _label),
          flagsButtonPadding: EdgeInsets.only(left: 8.w),
          decoration: _decoration('801 234 5678', null),
          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: const Color(0xFF1A1A1A),
            countryNameStyle: GoogleFonts.inter(color: Colors.white),
            countryCodeStyle:
                GoogleFonts.inter(color: _label, fontWeight: FontWeight.w600),
            searchFieldInputDecoration: InputDecoration(
              hintText: 'Search country',
              hintStyle: GoogleFonts.inter(color: _hint),
              prefixIcon: const Icon(Icons.search, color: _label),
            ),
          ),
          validator: _phoneValidator,
          onChanged: (phone) => _phone = phone,
        ),
      ],
    );
  }

  Widget _countryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Country'),
        GestureDetector(
          onTap: _showCountryPicker,
          child: AbsorbPointer(
            child: TextFormField(
              controller: _countryController,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
              decoration: _decoration('Select country', Icons.flag_outlined)
                  .copyWith(
                suffixIcon: const Icon(Icons.keyboard_arrow_down, color: _label),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showCountryPicker() {
    final search = TextEditingController();
    List<Country> filtered = List.of(countries);
    Get.bottomSheet(
      StatefulBuilder(
        builder: (context, setSheet) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: _border,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 8.h),
                  child: Text('Select Country',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: TextField(
                    controller: search,
                    autofocus: true,
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                    onChanged: (q) {
                      final query = q.toLowerCase();
                      setSheet(() {
                        filtered = countries
                            .where((c) =>
                                c.name.toLowerCase().contains(query) ||
                                c.dialCode.contains(query))
                            .toList();
                      });
                    },
                    decoration: _decoration('Search country', Icons.search),
                  ),
                ),
                SizedBox(height: 8.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final c = filtered[i];
                      return ListTile(
                        leading:
                            Text(c.flag, style: TextStyle(fontSize: 22.sp)),
                        title: Text(c.name,
                            style: GoogleFonts.inter(
                                color: Colors.white, fontSize: 14.sp)),
                        trailing: Text('+${c.dialCode}',
                            style: GoogleFonts.inter(
                                color: _label, fontSize: 13.sp)),
                        onTap: () {
                          setState(() => _countryController.text = c.name);
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  Widget _segmentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _fieldLabel('Segment'),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: _card,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSegment,
              isExpanded: true,
              dropdownColor: _card,
              icon: Icon(Icons.keyboard_arrow_down, color: _label, size: 20.sp),
              style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
              items: _segments
                  .map((seg) =>
                      DropdownMenuItem(value: seg, child: Text(seg)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _selectedSegment = value);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: _bg,
        border: Border(top: BorderSide(color: _border)),
      ),
      child: Row(
        children: [
          if (_step > 0) ...[
            Expanded(
              child: SizedBox(
                height: 52.h,
                child: OutlinedButton(
                  onPressed: isLoading ? null : _back,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: _border),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text('Back',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 52.h,
              child: ElevatedButton(
                onPressed: isLoading ? null : _next,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blue,
                  disabledBackgroundColor: _blue.withValues(alpha: 0.5),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r)),
                  elevation: 0,
                ),
                child: isLoading
                    ? SizedBox(
                        height: 22.h,
                        width: 22.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Text(
                        _step < 2 ? 'Continue' : 'Add Customer',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
