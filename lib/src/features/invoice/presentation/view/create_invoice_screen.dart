import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_flags/country_flags.dart';
import 'dart:io';

import '../../domain/entities/invoice_entity.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../../../../../core/types/app_routes.dart';

class CreateInvoiceScreen extends StatefulWidget {
  final Invoice? editingInvoice;

  const CreateInvoiceScreen({
    super.key,
    this.editingInvoice,
  });

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _toNameController = TextEditingController();
  final _toEmailController = TextEditingController();
  final _notesController = TextEditingController();
  final _taxController = TextEditingController();
  final _discountController = TextEditingController();
  
  // Recipient address controllers - removing non-standard fields
  final _recipientCompanyController = TextEditingController();
  final _recipientContactController = TextEditingController();
  final _recipientEmailController = TextEditingController();
  final _recipientPhoneController = TextEditingController();
  final _recipientAddress1Controller = TextEditingController();
  final _recipientAddress2Controller = TextEditingController();
  final _recipientCityController = TextEditingController();
  final _recipientStateController = TextEditingController();
  final _recipientPostcodeController = TextEditingController();
  final _recipientCountryController = TextEditingController();
  
  // Payer address controllers - removing non-standard fields
  final _payerCompanyController = TextEditingController();
  final _payerContactController = TextEditingController();
  final _payerEmailController = TextEditingController();
  final _payerPhoneController = TextEditingController();
  final _payerAddress1Controller = TextEditingController();
  final _payerAddress2Controller = TextEditingController();
  final _payerCityController = TextEditingController();
  final _payerStateController = TextEditingController();
  final _payerPostcodeController = TextEditingController();
  final _payerCountryController = TextEditingController();
  
  // Image controllers
  File? _payerImage;
  final ImagePicker _imagePicker = ImagePicker();
  
  InvoiceType _selectedType = InvoiceType.invoice;
  DateTime? _selectedDueDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  void _initializeForm() {
    if (widget.editingInvoice != null) {
      final invoice = widget.editingInvoice!;
      _titleController.text = invoice.title;
      _descriptionController.text = invoice.description;
      _toNameController.text = invoice.toName ?? '';
      _toEmailController.text = invoice.toEmail ?? '';
      _notesController.text = invoice.notes ?? '';
      _taxController.text = invoice.taxAmount?.toString() ?? '';
      _discountController.text = invoice.discountAmount?.toString() ?? '';
      _selectedType = invoice.type;
      _selectedDueDate = invoice.dueDate;
      
      // Initialize recipient address details
      if (invoice.recipientDetails != null) {
        final recipient = invoice.recipientDetails!;
        _recipientCompanyController.text = recipient.companyName ?? '';
        _recipientContactController.text = recipient.contactName ?? '';
        _recipientEmailController.text = recipient.email ?? '';
        _recipientPhoneController.text = recipient.phone ?? '';
        _recipientAddress1Controller.text = recipient.addressLine1 ?? '';
        _recipientAddress2Controller.text = recipient.addressLine2 ?? '';
        _recipientCityController.text = recipient.city ?? '';
        _recipientStateController.text = recipient.state ?? '';
        _recipientPostcodeController.text = recipient.postcode ?? '';
        _recipientCountryController.text = recipient.country ?? '';
      }
      
      // Initialize payer address details
      if (invoice.payerDetails != null) {
        final payer = invoice.payerDetails!;
        _payerCompanyController.text = payer.companyName ?? '';
        _payerContactController.text = payer.contactName ?? '';
        _payerEmailController.text = payer.email ?? '';
        _payerPhoneController.text = payer.phone ?? '';
        _payerAddress1Controller.text = payer.addressLine1 ?? '';
        _payerAddress2Controller.text = payer.addressLine2 ?? '';
        _payerCityController.text = payer.city ?? '';
        _payerStateController.text = payer.state ?? '';
        _payerPostcodeController.text = payer.postcode ?? '';
        _payerCountryController.text = payer.country ?? '';
      }
      
      // Initialize form state with existing invoice
      context.read<InvoiceCubit>().initializeForm(editingInvoice: invoice);
    } else {
      // Initialize empty form
      context.read<InvoiceCubit>().initializeForm();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _toNameController.dispose();
    _toEmailController.dispose();
    _notesController.dispose();
    _taxController.dispose();
    _discountController.dispose();
    _recipientCompanyController.dispose();
    _recipientContactController.dispose();
    _recipientEmailController.dispose();
    _recipientPhoneController.dispose();
    _recipientAddress1Controller.dispose();
    _recipientAddress2Controller.dispose();
    _recipientCityController.dispose();
    _recipientStateController.dispose();
    _recipientPostcodeController.dispose();
    _recipientCountryController.dispose();
    _payerCompanyController.dispose();
    _payerContactController.dispose();
    _payerEmailController.dispose();
    _payerPhoneController.dispose();
    _payerAddress1Controller.dispose();
    _payerAddress2Controller.dispose();
    _payerCityController.dispose();
    _payerStateController.dispose();
    _payerPostcodeController.dispose();
    _payerCountryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: BlocConsumer<InvoiceCubit, InvoiceState>(
                listener: (context, state) {
                  if (state is InvoiceOperationSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFF10B981),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    // Navigate to payment screen if we have a created invoice, otherwise go back
                    if (state.invoice != null && widget.editingInvoice == null) {
                      Get.toNamed(AppRoutes.invoicePayment, arguments: state.invoice);
                    } else {
                      Get.back();
                    }
                  }
                  
                  if (state is InvoiceError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: const Color(0xFFEF4444),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    setState(() => _isLoading = false);
                  }
                  
                  if (state is InvoiceLoading) {
                    setState(() => _isLoading = true);
                  } else {
                    setState(() => _isLoading = false);
                  }
                },
                builder: (context, state) {
                  return _buildForm();
                },
              ),
            ),
          ],
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.editingInvoice != null ? 'Edit Invoice' : 'Create Invoice',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  widget.editingInvoice != null 
                      ? 'Update invoice details' 
                      : 'Create a new invoice with items and details',
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBasicInfo(),
            SizedBox(height: 20.h),
            _buildAddressDetailsSection(),
            SizedBox(height: 20.h),
            _buildItemsSection(),
            SizedBox(height: 20.h),
            _buildAmountSection(),
            SizedBox(height: 20.h),
            _buildNotesSection(),
            SizedBox(height: 32.h),
            _buildActions(),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfo() {
    return _buildSection(
      title: 'Basic Information',
      icon: Icons.info_outline,
      child: Column(
        children: [
          _buildTextField(
            controller: _titleController,
            label: 'Invoice Title',
            hint: 'Enter a descriptive title',
            isRequired: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Invoice title is required';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          _buildTextField(
            controller: _descriptionController,
            label: 'Description',
            hint: 'Add invoice description or notes',
            maxLines: 3,
          ),
          SizedBox(height: 16.h),
          Column(
            children: [
              _buildDropdown<InvoiceType>(
                label: 'Invoice Type',
                value: _selectedType,
                items: InvoiceType.values,
                itemBuilder: (type) => _getTypeDisplayName(type),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _selectedType = value);
                  }
                },
              ),
              SizedBox(height: 16.h),
              _buildDatePicker(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAddressDetailsSection() {
    return Column(
      children: [
        _buildRecipientAddressSection(),
        SizedBox(height: 20.h),
        _buildPayerAddressSection(),
      ],
    );
  }

  Widget _buildRecipientAddressSection() {
    return _buildSection(
      title: 'Recipient Details',
      icon: Icons.person_outline,
      action: _buildAddRecipientAddressButton(),
      child: _hasRecipientAddress() ? _buildRecipientAddressCard() : _buildEmptyRecipientAddress(),
    );
  }

  Widget _buildPayerAddressSection() {
    return _buildSection(
      title: 'Payer Details',
      icon: Icons.business_outlined,
      action: _buildAddPayerAddressButton(),
      child: _hasPayerAddress() ? _buildPayerAddressCard() : _buildEmptyPayerAddress(),
    );
  }

  bool _hasRecipientAddress() {
    return _recipientCompanyController.text.isNotEmpty ||
           _recipientContactController.text.isNotEmpty ||
           _recipientEmailController.text.isNotEmpty ||
           _recipientPhoneController.text.isNotEmpty ||
           _recipientAddress1Controller.text.isNotEmpty ||
           _recipientCityController.text.isNotEmpty ||
           _recipientPostcodeController.text.isNotEmpty ||
           _recipientCountryController.text.isNotEmpty ||
           _toNameController.text.isNotEmpty ||
           _toEmailController.text.isNotEmpty;
  }

  bool _hasPayerAddress() {
    return _payerCompanyController.text.isNotEmpty ||
           _payerContactController.text.isNotEmpty ||
           _payerEmailController.text.isNotEmpty ||
           _payerPhoneController.text.isNotEmpty ||
           _payerAddress1Controller.text.isNotEmpty ||
           _payerCityController.text.isNotEmpty ||
           _payerPostcodeController.text.isNotEmpty ||
           _payerCountryController.text.isNotEmpty ||
           _payerImage != null;
  }

  Widget _buildAddRecipientAddressButton() {
    if (_hasRecipientAddress()) return Container();
    
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton.icon(
        onPressed: _showAddRecipientAddressDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 16.sp,
        ),
        label: Text(
          'Add',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAddPayerAddressButton() {
    if (_hasPayerAddress()) return Container();
    
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton.icon(
        onPressed: _showAddPayerAddressDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 16.sp,
        ),
        label: Text(
          'Add',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyRecipientAddress() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.person_outline,
              size: 48.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'No recipient details added',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add recipient contact and address information',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPayerAddress() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.business_outlined,
              size: 48.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'No payer details added',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add your business contact and address information',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientAddressCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.person_outline,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recipient Details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getRecipientDisplayName(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _showAddRecipientAddressDialog,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: const Color(0xFF3B82F6),
                        size: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _clearRecipientAddress,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: const Color(0xFFEF4444),
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_recipientAddress1Controller.text.isNotEmpty ||
              _recipientCityController.text.isNotEmpty ||
              _toEmailController.text.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildAddressInfo(_getRecipientAddressInfo()),
          ],
        ],
      ),
    );
  }

  Widget _buildPayerAddressCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Display image if available
              if (_payerImage != null) ...[
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: const Color(0xFF2D2D2D)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      _payerImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
              ] else ...[
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.business_outlined,
                    color: const Color(0xFF6366F1),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payer Details',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      _getPayerDisplayName(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: _showAddPayerAddressDialog,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.edit_outlined,
                        color: const Color(0xFF3B82F6),
                        size: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: _clearPayerAddress,
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        color: const Color(0xFFEF4444),
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (_payerAddress1Controller.text.isNotEmpty ||
              _payerCityController.text.isNotEmpty ||
              _payerEmailController.text.isNotEmpty) ...[
            SizedBox(height: 16.h),
            _buildAddressInfo(_getPayerAddressInfo()),
          ],
        ],
      ),
    );
  }

  Widget _buildAddressInfo(List<String> info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: info.map((line) => Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: Text(
          line,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      )).toList(),
    );
  }

  String _getRecipientDisplayName() {
    if (_toNameController.text.isNotEmpty) {
      return _toNameController.text;
    }
    if (_recipientCompanyController.text.isNotEmpty) {
      return _recipientCompanyController.text;
    }
    if (_recipientContactController.text.isNotEmpty) {
      return _recipientContactController.text;
    }
    if (_toEmailController.text.isNotEmpty) {
      return _toEmailController.text;
    }
    return 'Recipient Details';
  }

  String _getPayerDisplayName() {
    if (_payerCompanyController.text.isNotEmpty) {
      return _payerCompanyController.text;
    }
    if (_payerContactController.text.isNotEmpty) {
      return _payerContactController.text;
    }
    return 'Payer Details';
  }

  List<String> _getRecipientAddressInfo() {
    final info = <String>[];
    if (_toNameController.text.isNotEmpty) {
      info.add(_toNameController.text);
    }
    if (_toEmailController.text.isNotEmpty) {
      info.add(_toEmailController.text);
    }
    if (_recipientContactController.text.isNotEmpty) {
      info.add(_recipientContactController.text);
    }
    if (_recipientPhoneController.text.isNotEmpty) {
      info.add(_recipientPhoneController.text);
    }
    if (_recipientAddress1Controller.text.isNotEmpty) {
      info.add(_recipientAddress1Controller.text);
    }
    final cityStatePostcode = [
      _recipientCityController.text,
      _recipientStateController.text,
      _recipientPostcodeController.text,
    ].where((s) => s.isNotEmpty).join(', ');
    if (cityStatePostcode.isNotEmpty) {
      info.add(cityStatePostcode);
    }
    if (_recipientCountryController.text.isNotEmpty) {
      info.add(_recipientCountryController.text);
    }
    return info;
  }

  List<String> _getPayerAddressInfo() {
    final info = <String>[];
    if (_payerContactController.text.isNotEmpty) {
      info.add(_payerContactController.text);
    }
    if (_payerEmailController.text.isNotEmpty) {
      info.add(_payerEmailController.text);
    }
    if (_payerPhoneController.text.isNotEmpty) {
      info.add(_payerPhoneController.text);
    }
    if (_payerAddress1Controller.text.isNotEmpty) {
      info.add(_payerAddress1Controller.text);
    }
    final cityStatePostcode = [
      _payerCityController.text,
      _payerStateController.text,
      _payerPostcodeController.text,
    ].where((s) => s.isNotEmpty).join(', ');
    if (cityStatePostcode.isNotEmpty) {
      info.add(cityStatePostcode);
    }
    if (_payerCountryController.text.isNotEmpty) {
      info.add(_payerCountryController.text);
    }
    return info;
  }

  void _showAddRecipientAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          Map<String, bool> fieldErrors = {};
          
          void _validateAndSave() {
            fieldErrors.clear();
            List<String> missingFields = [];
            
            // Check required fields
            if (_toNameController.text.trim().isEmpty) {
              fieldErrors['recipientName'] = true;
              missingFields.add('Recipient Name');
            }
            if (_toEmailController.text.trim().isEmpty) {
              fieldErrors['recipientEmail'] = true;
              missingFields.add('Email Address');
            }
            
            if (missingFields.isNotEmpty) {
              setDialogState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please fill in the following required fields:',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...missingFields.map((field) => Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 2.h),
                        child: Text(
                          '• $field',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                    ],
                  ),
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 4),
                ),
              );
              return;
            }
            
            // If validation passes, save and close
            setState(() {});
            Navigator.pop(context);
          }
          
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title section
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.person_outline,
                            color: const Color(0xFF6366F1),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Recipient Details',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Content section
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildDialogTextField(
                              _toNameController, 
                              'Recipient Name', 
                              isRequired: true,
                              hasError: fieldErrors['recipientName'] ?? false,
                            ),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(
                              _toEmailController, 
                              'Email Address', 
                              keyboardType: TextInputType.emailAddress, 
                              isRequired: true,
                              hasError: fieldErrors['recipientEmail'] ?? false,
                            ),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientCompanyController, 'Company Name'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientContactController, 'Contact Person'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientPhoneController, 'Phone Number', keyboardType: TextInputType.phone),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientAddress1Controller, 'Street Address'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientAddress2Controller, 'Address Line 2'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientCityController, 'City'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientStateController, 'State/Province'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_recipientPostcodeController, 'Postcode/ZIP'),
                            SizedBox(height: 16.h),
                            _buildCountryField(_recipientCountryController, 'Country'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Actions section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: ElevatedButton(
                            onPressed: _validateAndSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAddPayerAddressDialog() {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          Map<String, bool> fieldErrors = {};
          
          void _validateAndSave() {
            fieldErrors.clear();
            List<String> missingFields = [];
            
            // Check required fields
            if (_payerCompanyController.text.trim().isEmpty) {
              fieldErrors['payerCompany'] = true;
              missingFields.add('Company Name');
            }
            
            if (missingFields.isNotEmpty) {
              setDialogState(() {});
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please fill in the following required fields:',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ...missingFields.map((field) => Padding(
                        padding: EdgeInsets.only(left: 8.w, bottom: 2.h),
                        child: Text(
                          '• $field',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                    ],
                  ),
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 4),
                ),
              );
              return;
            }
            
            // If validation passes, save and close
            setState(() {});
            Navigator.pop(context);
          }
          
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title section
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.business_outlined,
                            color: const Color(0xFF6366F1),
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Payer Details',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    // Content section
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            // Image picker section
                            GestureDetector(
                              onTap: _pickPayerImage,
                              child: Container(
                                width: 120.w,
                                height: 120.w,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF111111),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: const Color(0xFF2D2D2D)),
                                ),
                                child: _payerImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12.r),
                                        child: Image.file(
                                          _payerImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_photo_alternate_outlined,
                                            color: const Color(0xFF6366F1),
                                            size: 32.sp,
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            'Company Logo',
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF9CA3AF),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            '(Optional)',
                                            style: GoogleFonts.inter(
                                              color: const Color(0xFF6B7280),
                                              fontSize: 10.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            _buildDialogTextField(
                              _payerCompanyController, 
                              'Company Name', 
                              isRequired: true,
                              hasError: fieldErrors['payerCompany'] ?? false,
                            ),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerContactController, 'Contact Person'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerEmailController, 'Email Address', keyboardType: TextInputType.emailAddress),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerPhoneController, 'Phone Number', keyboardType: TextInputType.phone),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerAddress1Controller, 'Street Address'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerAddress2Controller, 'Address Line 2'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerCityController, 'City'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerStateController, 'State/Province'),
                            SizedBox(height: 16.h),
                            _buildDialogTextField(_payerPostcodeController, 'Postcode/ZIP'),
                            SizedBox(height: 16.h),
                            _buildCountryField(_payerCountryController, 'Country'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Actions section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: ElevatedButton(
                            onPressed: _validateAndSave,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCountryField(TextEditingController controller, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            Text(
              '(Optional)',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () => _showCountrySelectionSheet(controller),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                if (controller.text.isNotEmpty) ...[
                  CountryFlag.fromCountryCode(
                    _getCountryCode(controller.text),
                    height: 20.h,
                    width: 28.w,
                  ),
                  SizedBox(width: 12.w),
                ],
                Expanded(
                  child: Text(
                    controller.text.isEmpty ? 'Select country' : controller.text,
                    style: GoogleFonts.inter(
                      color: controller.text.isEmpty ? const Color(0xFF6B7280) : Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.expand_more,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCountrySelectionSheet(TextEditingController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _CountrySelectionSheet(
        onCountrySelected: (String countryName, String countryCode) {
          setState(() {
            controller.text = countryName;
          });
        },
        currentSelection: controller.text,
      ),
    );
  }

  String _getCountryCode(String countryName) {
    final Map<String, String> countryMap = {
      'United States': 'US',
      'United Kingdom': 'GB',
      'Canada': 'CA',
      'Australia': 'AU',
      'Germany': 'DE',
      'France': 'FR',
      'Italy': 'IT',
      'Spain': 'ES',
      'Netherlands': 'NL',
      'Belgium': 'BE',
      'Switzerland': 'CH',
      'Austria': 'AT',
      'Sweden': 'SE',
      'Norway': 'NO',
      'Denmark': 'DK',
      'Finland': 'FI',
      'Japan': 'JP',
      'South Korea': 'KR',
      'China': 'CN',
      'India': 'IN',
      'Brazil': 'BR',
      'Mexico': 'MX',
      'Argentina': 'AR',
      'South Africa': 'ZA',
      'Nigeria': 'NG',
      'Egypt': 'EG',
      'Turkey': 'TR',
      'Russia': 'RU',
      'Poland': 'PL',
      'Czech Republic': 'CZ',
      'Hungary': 'HU',
      'Romania': 'RO',
      'Bulgaria': 'BG',
      'Croatia': 'HR',
      'Slovenia': 'SI',
      'Slovakia': 'SK',
      'Estonia': 'EE',
      'Latvia': 'LV',
      'Lithuania': 'LT',
      'Ireland': 'IE',
      'Portugal': 'PT',
      'Greece': 'GR',
      'Cyprus': 'CY',
      'Malta': 'MT',
      'Luxembourg': 'LU',
      'Iceland': 'IS',
      'Israel': 'IL',
      'United Arab Emirates': 'AE',
      'Saudi Arabia': 'SA',
      'Qatar': 'QA',
      'Kuwait': 'KW',
      'Bahrain': 'BH',
      'Oman': 'OM',
      'Singapore': 'SG',
      'Malaysia': 'MY',
      'Thailand': 'TH',
      'Vietnam': 'VN',
      'Philippines': 'PH',
      'Indonesia': 'ID',
      'New Zealand': 'NZ',
    };
    return countryMap[countryName] ?? 'US';
  }

  void _clearRecipientAddress() {
    setState(() {
      _recipientCompanyController.clear();
      _recipientContactController.clear();
      _recipientEmailController.clear();
      _recipientPhoneController.clear();
      _recipientAddress1Controller.clear();
      _recipientAddress2Controller.clear();
      _recipientCityController.clear();
      _recipientStateController.clear();
      _recipientPostcodeController.clear();
      _recipientCountryController.clear();
      _toNameController.clear();
      _toEmailController.clear();
    });
  }

  void _clearPayerAddress() {
    setState(() {
      _payerCompanyController.clear();
      _payerContactController.clear();
      _payerEmailController.clear();
      _payerPhoneController.clear();
      _payerAddress1Controller.clear();
      _payerAddress2Controller.clear();
      _payerCityController.clear();
      _payerStateController.clear();
      _payerPostcodeController.clear();
      _payerCountryController.clear();
      _payerImage = null;
    });
  }

  Widget _buildItemsSection() {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceFormState) {
          return _buildSection(
            title: 'Invoice Items',
            icon: Icons.shopping_cart_outlined,
            action: _buildAddItemButton(),
            child: state.items.isEmpty
                ? _buildEmptyItems()
                : Column(
                    children: state.items
                        .asMap()
                        .entries
                        .map((entry) => _buildItemCard(entry.value, entry.key))
                        .toList(),
                  ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildAmountSection() {
    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceFormState) {
          final subtotal = state.items.fold<double>(0, (sum, item) => sum + item.totalPrice);
          final tax = double.tryParse(_taxController.text) ?? 0;
          final discount = double.tryParse(_discountController.text) ?? 0;
          final total = subtotal + tax - discount;

          return _buildSection(
            title: 'Amount Calculation',
            icon: Icons.calculate_outlined,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _taxController,
                        label: 'Tax Amount',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        prefixText: '\$ ',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: _buildTextField(
                        controller: _discountController,
                        label: 'Discount Amount',
                        hint: '0.00',
                        keyboardType: TextInputType.number,
                        prefixText: '\$ ',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                _buildAmountSummary(subtotal, tax, discount, total),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildNotesSection() {
    return _buildSection(
      title: 'Additional Notes',
      icon: Icons.note_alt_outlined,
      child: _buildTextField(
        controller: _notesController,
        label: 'Notes',
        hint: 'Add payment terms, conditions, or special instructions',
        maxLines: 4,
      ),
    );
  }

  Widget _buildActions() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6366F1).withOpacity(0.3),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: _isLoading ? null : () => _saveInvoice(sendImmediately: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: _isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    widget.editingInvoice != null ? 'Update & Send Invoice' : 'Create & Send Invoice',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          height: 52.h,
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFF6366F1), width: 1.5),
          ),
          child: ElevatedButton(
            onPressed: _isLoading ? null : () => _saveInvoice(sendImmediately: false),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              widget.editingInvoice != null ? 'Update Draft' : 'Save as Draft',
              style: GoogleFonts.inter(
                color: const Color(0xFF6366F1),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required Widget child,
    IconData? icon,
    Widget? action,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF6366F1),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
              ],
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (action != null) action,
            ],
          ),
          SizedBox(height: 20.h),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    String? prefixText,
    bool isRequired = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (isRequired) ...[
              SizedBox(width: 4.w),
              Text(
                '*',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixText: prefixText,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixStyle: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFF111111),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown<T>({
    required String label,
    required T value,
    required List<T> items,
    required String Function(T) itemBuilder,
    required void Function(T?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<T>(
          value: value,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          dropdownColor: const Color(0xFF1F1F1F),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF111111),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
            ),
          ),
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemBuilder(item),
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Due Date',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: _selectDueDate,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF111111),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDueDate != null
                        ? '${_selectedDueDate!.day}/${_selectedDueDate!.month}/${_selectedDueDate!.year}'
                        : 'Select due date',
                    style: GoogleFonts.inter(
                      color: _selectedDueDate != null ? Colors.white : const Color(0xFF6B7280),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Icon(
                  Icons.calendar_month_outlined,
                  color: const Color(0xFF6366F1),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddItemButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: ElevatedButton.icon(
        onPressed: _showAddItemDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 18.sp,
        ),
        label: Text(
          'Add Item',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyItems() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              Icons.receipt_long_outlined,
              size: 48.sp,
              color: const Color(0xFF6366F1),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'No items added yet',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add items to calculate the invoice total',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(InvoiceItem item, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.inventory_2_outlined,
              color: const Color(0xFF6366F1),
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.description != null) ...[
                  SizedBox(height: 4.h),
                  Text(
                    item.description!,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        'Qty: ${item.quantity.toStringAsFixed(item.quantity == item.quantity.roundToDouble() ? 0 : 1)}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '\$${item.unitPrice.toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${item.totalPrice.toStringAsFixed(2)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => _editItem(item, index),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(
                          Icons.edit_outlined,
                          color: const Color(0xFF3B82F6),
                          size: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => _removeItem(item.id),
                      child: Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(
                          Icons.delete_outline,
                          color: const Color(0xFFEF4444),
                          size: 16.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAmountSummary(double subtotal, double tax, double discount, double total) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          _buildAmountRow('Subtotal', subtotal),
          if (tax > 0) _buildAmountRow('Tax', tax),
          if (discount > 0) _buildAmountRow('Discount', -discount),
          if (tax > 0 || discount > 0) ...[
            SizedBox(height: 12.h),
            Container(
              height: 1.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF2D2D2D).withOpacity(0.1),
                    const Color(0xFF2D2D2D),
                    const Color(0xFF2D2D2D).withOpacity(0.1),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
          _buildAmountRow('Total', total, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, double amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: isTotal ? Colors.white : const Color(0xFF9CA3AF),
              fontSize: isTotal ? 18.sp : 16.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
          Text(
            '\$${amount.abs().toStringAsFixed(2)}',
            style: GoogleFonts.inter(
              color: isTotal 
                  ? Colors.white 
                  : amount < 0 
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF9CA3AF),
              fontSize: isTotal ? 18.sp : 16.sp,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDueDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.white,
              surface: Color(0xFF1F1F1F),
              onSurface: Colors.white,
              background: Color(0xFF0A0A0A),
              onBackground: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1F1F1F),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      setState(() => _selectedDueDate = date);
    }
  }

  void _showAddItemDialog() {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    final quantityController = TextEditingController(text: '1');
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.add_shopping_cart_outlined,
                color: const Color(0xFF6366F1),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Add New Item',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(nameController, 'Item Name *'),
            SizedBox(height: 16.h),
            _buildDialogTextField(descriptionController, 'Description (Optional)'),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _buildDialogTextField(
                    quantityController,
                    'Quantity',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildDialogTextField(
                    priceController,
                    'Unit Price',
                    keyboardType: TextInputType.number,
                    prefixText: '\$ ',
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: ElevatedButton(
              onPressed: () {
                if (nameController.text.isNotEmpty && 
                    quantityController.text.isNotEmpty && 
                    priceController.text.isNotEmpty) {
                  _addItem(
                    nameController.text,
                    descriptionController.text.isEmpty ? null : descriptionController.text,
                    double.tryParse(quantityController.text) ?? 1,
                    double.tryParse(priceController.text) ?? 0,
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Add Item',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDialogTextField(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    String? prefixText,
    bool isRequired = false,
    bool hasError = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 4.w),
            if (isRequired)
              Text(
                '*',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              )
            else
              Text(
                '(Optional)',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
          ),
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: 'Enter ${label.toLowerCase()}',
            prefixText: prefixText,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            prefixStyle: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
            filled: true,
            fillColor: const Color(0xFF111111),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFEF4444) : const Color(0xFF6366F1), 
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444), width: 2),
            ),
          ),
        ),
        if (hasError && isRequired) ...[
          SizedBox(height: 6.h),
          Text(
            'This field is required',
            style: GoogleFonts.inter(
              color: const Color(0xFFEF4444),
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  void _addItem(String name, String? description, double quantity, double unitPrice) {
    final item = InvoiceItem(
      id: context.read<InvoiceCubit>().generateItemId(),
      name: name,
      description: description,
      quantity: quantity,
      unitPrice: unitPrice,
      totalPrice: quantity * unitPrice,
    );

    context.read<InvoiceCubit>().addItem(item);
  }

  void _editItem(InvoiceItem item, int index) {
    final nameController = TextEditingController(text: item.name);
    final descriptionController = TextEditingController(text: item.description ?? '');
    final quantityController = TextEditingController(text: item.quantity.toString());
    final priceController = TextEditingController(text: item.unitPrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Edit Item',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDialogTextField(nameController, 'Item Name *'),
            SizedBox(height: 12.h),
            _buildDialogTextField(descriptionController, 'Description'),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: _buildDialogTextField(
                    quantityController,
                    'Quantity',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: _buildDialogTextField(
                    priceController,
                    'Unit Price',
                    keyboardType: TextInputType.number,
                    prefixText: '\$ ',
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty && 
                  quantityController.text.isNotEmpty && 
                  priceController.text.isNotEmpty) {
                final updatedItem = item.copyWith(
                  name: nameController.text,
                  description: descriptionController.text.isEmpty ? null : descriptionController.text,
                  quantity: double.tryParse(quantityController.text) ?? item.quantity,
                  unitPrice: double.tryParse(priceController.text) ?? item.unitPrice,
                  totalPrice: (double.tryParse(quantityController.text) ?? item.quantity) * 
                             (double.tryParse(priceController.text) ?? item.unitPrice),
                );
                context.read<InvoiceCubit>().updateItem(updatedItem);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6366F1),
              foregroundColor: Colors.white,
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _removeItem(String itemId) {
    context.read<InvoiceCubit>().removeItem(itemId);
  }

  void _saveInvoice({required bool sendImmediately}) {
    if (!_formKey.currentState!.validate()) return;

    final state = context.read<InvoiceCubit>().state;
    if (state is! InvoiceFormState) return;

    if (state.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one item'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final recipientDetails = _createRecipientDetails();
    final payerDetails = _createPayerDetails();

    if (widget.editingInvoice != null) {
      // Update existing invoice
      final updatedInvoice = widget.editingInvoice!.copyWith(
        title: _titleController.text,
        description: _descriptionController.text,
        type: _selectedType,
        dueDate: _selectedDueDate,
        toName: _toNameController.text.isEmpty ? null : _toNameController.text,
        toEmail: _toEmailController.text.isEmpty ? null : _toEmailController.text,
        items: state.items,
        taxAmount: double.tryParse(_taxController.text),
        discountAmount: double.tryParse(_discountController.text),
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        totalAmount: _calculateTotal(state.items),
        status: sendImmediately ? InvoiceStatus.pending : widget.editingInvoice!.status,
        recipientDetails: recipientDetails.isEmpty ? null : recipientDetails,
        payerDetails: payerDetails.isEmpty ? null : payerDetails,
      );

      context.read<InvoiceCubit>().updateInvoice(updatedInvoice);
    } else {
      // Create new invoice
      context.read<InvoiceCubit>().createInvoice(
        title: _titleController.text,
        description: _descriptionController.text,
        items: state.items,
        type: _selectedType,
        toEmail: _toEmailController.text.isEmpty ? null : _toEmailController.text,
        toName: _toNameController.text.isEmpty ? null : _toNameController.text,
        dueDate: _selectedDueDate,
        taxAmount: double.tryParse(_taxController.text),
        discountAmount: double.tryParse(_discountController.text),
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        sendImmediately: sendImmediately,
        recipientDetails: recipientDetails.isEmpty ? null : recipientDetails,
        payerDetails: payerDetails.isEmpty ? null : payerDetails,
      );
    }
  }

  AddressDetails _createRecipientDetails() {
    return AddressDetails(
      companyName: _recipientCompanyController.text.isEmpty ? null : _recipientCompanyController.text,
      contactName: _recipientContactController.text.isEmpty ? null : _recipientContactController.text,
      email: _recipientEmailController.text.isEmpty ? null : _recipientEmailController.text,
      phone: _recipientPhoneController.text.isEmpty ? null : _recipientPhoneController.text,
      addressLine1: _recipientAddress1Controller.text.isEmpty ? null : _recipientAddress1Controller.text,
      addressLine2: _recipientAddress2Controller.text.isEmpty ? null : _recipientAddress2Controller.text,
      city: _recipientCityController.text.isEmpty ? null : _recipientCityController.text,
      state: _recipientStateController.text.isEmpty ? null : _recipientStateController.text,
      postcode: _recipientPostcodeController.text.isEmpty ? null : _recipientPostcodeController.text,
      country: _recipientCountryController.text.isEmpty ? null : _recipientCountryController.text,
    );
  }

  AddressDetails _createPayerDetails() {
    return AddressDetails(
      companyName: _payerCompanyController.text.isEmpty ? null : _payerCompanyController.text,
      contactName: _payerContactController.text.isEmpty ? null : _payerContactController.text,
      email: _payerEmailController.text.isEmpty ? null : _payerEmailController.text,
      phone: _payerPhoneController.text.isEmpty ? null : _payerPhoneController.text,
      addressLine1: _payerAddress1Controller.text.isEmpty ? null : _payerAddress1Controller.text,
      addressLine2: _payerAddress2Controller.text.isEmpty ? null : _payerAddress2Controller.text,
      city: _payerCityController.text.isEmpty ? null : _payerCityController.text,
      state: _payerStateController.text.isEmpty ? null : _payerStateController.text,
      postcode: _payerPostcodeController.text.isEmpty ? null : _payerPostcodeController.text,
      country: _payerCountryController.text.isEmpty ? null : _payerCountryController.text,
    );
  }

  double _calculateTotal(List<InvoiceItem> items) {
    final subtotal = items.fold<double>(0, (sum, item) => sum + item.totalPrice);
    final tax = double.tryParse(_taxController.text) ?? 0;
    final discount = double.tryParse(_discountController.text) ?? 0;
    return subtotal + tax - discount;
  }

  String _getTypeDisplayName(InvoiceType type) {
    switch (type) {
      case InvoiceType.request:
        return 'Payment Request';
      case InvoiceType.invoice:
        return 'Invoice';
      case InvoiceType.quote:
        return 'Quote';
    }
  }

  Future<void> _pickPayerImage() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );
      
      if (image != null) {
        setState(() {
          _payerImage = File(image.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to pick image: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _CountrySelectionSheet extends StatefulWidget {
  final Function(String countryName, String countryCode) onCountrySelected;
  final String currentSelection;

  const _CountrySelectionSheet({
    required this.onCountrySelected,
    required this.currentSelection,
  });

  @override
  State<_CountrySelectionSheet> createState() => _CountrySelectionSheetState();
}

class _CountrySelectionSheetState extends State<_CountrySelectionSheet> {
  late TextEditingController _searchController;
  late List<Map<String, String>> _filteredCountries;
  
  final List<Map<String, String>> _countries = [
    {'name': 'United States', 'code': 'US'},
    {'name': 'United Kingdom', 'code': 'GB'},
    {'name': 'Canada', 'code': 'CA'},
    {'name': 'Australia', 'code': 'AU'},
    {'name': 'Germany', 'code': 'DE'},
    {'name': 'France', 'code': 'FR'},
    {'name': 'Italy', 'code': 'IT'},
    {'name': 'Spain', 'code': 'ES'},
    {'name': 'Netherlands', 'code': 'NL'},
    {'name': 'Belgium', 'code': 'BE'},
    {'name': 'Switzerland', 'code': 'CH'},
    {'name': 'Austria', 'code': 'AT'},
    {'name': 'Sweden', 'code': 'SE'},
    {'name': 'Norway', 'code': 'NO'},
    {'name': 'Denmark', 'code': 'DK'},
    {'name': 'Finland', 'code': 'FI'},
    {'name': 'Japan', 'code': 'JP'},
    {'name': 'South Korea', 'code': 'KR'},
    {'name': 'China', 'code': 'CN'},
    {'name': 'India', 'code': 'IN'},
    {'name': 'Brazil', 'code': 'BR'},
    {'name': 'Mexico', 'code': 'MX'},
    {'name': 'Argentina', 'code': 'AR'},
    {'name': 'South Africa', 'code': 'ZA'},
    {'name': 'Nigeria', 'code': 'NG'},
    {'name': 'Egypt', 'code': 'EG'},
    {'name': 'Turkey', 'code': 'TR'},
    {'name': 'Russia', 'code': 'RU'},
    {'name': 'Poland', 'code': 'PL'},
    {'name': 'Czech Republic', 'code': 'CZ'},
    {'name': 'Hungary', 'code': 'HU'},
    {'name': 'Romania', 'code': 'RO'},
    {'name': 'Bulgaria', 'code': 'BG'},
    {'name': 'Croatia', 'code': 'HR'},
    {'name': 'Slovenia', 'code': 'SI'},
    {'name': 'Slovakia', 'code': 'SK'},
    {'name': 'Estonia', 'code': 'EE'},
    {'name': 'Latvia', 'code': 'LV'},
    {'name': 'Lithuania', 'code': 'LT'},
    {'name': 'Ireland', 'code': 'IE'},
    {'name': 'Portugal', 'code': 'PT'},
    {'name': 'Greece', 'code': 'GR'},
    {'name': 'Cyprus', 'code': 'CY'},
    {'name': 'Malta', 'code': 'MT'},
    {'name': 'Luxembourg', 'code': 'LU'},
    {'name': 'Iceland', 'code': 'IS'},
    {'name': 'Israel', 'code': 'IL'},
    {'name': 'United Arab Emirates', 'code': 'AE'},
    {'name': 'Saudi Arabia', 'code': 'SA'},
    {'name': 'Qatar', 'code': 'QA'},
    {'name': 'Kuwait', 'code': 'KW'},
    {'name': 'Bahrain', 'code': 'BH'},
    {'name': 'Oman', 'code': 'OM'},
    {'name': 'Singapore', 'code': 'SG'},
    {'name': 'Malaysia', 'code': 'MY'},
    {'name': 'Thailand', 'code': 'TH'},
    {'name': 'Vietnam', 'code': 'VN'},
    {'name': 'Philippines', 'code': 'PH'},
    {'name': 'Indonesia', 'code': 'ID'},
    {'name': 'New Zealand', 'code': 'NZ'},
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredCountries = List.from(_countries);
    _searchController.addListener(_filterCountries);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _countries.where((country) {
        return country['name']!.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          // Header
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.public,
                        color: const Color(0xFF6366F1),
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Select Country',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                
                // Search field
                TextField(
                  controller: _searchController,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search countries...',
                    hintStyle: GoogleFonts.inter(
                      color: const Color(0xFF6B7280),
                      fontSize: 16.sp,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: const Color(0xFF6366F1),
                      size: 20.sp,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF111111),
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Countries list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              itemCount: _filteredCountries.length,
              itemBuilder: (context, index) {
                final country = _filteredCountries[index];
                final isSelected = country['name'] == widget.currentSelection;
                
                return GestureDetector(
                  onTap: () {
                    widget.onCountrySelected(country['name']!, country['code']!);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: isSelected 
                          ? const Color(0xFF6366F1).withOpacity(0.1)
                          : const Color(0xFF111111),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: isSelected 
                            ? const Color(0xFF6366F1)
                            : const Color(0xFF2D2D2D),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          country['code']!,
                          height: 24.h,
                          width: 32.w,
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Text(
                            country['name']!,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (isSelected)
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}