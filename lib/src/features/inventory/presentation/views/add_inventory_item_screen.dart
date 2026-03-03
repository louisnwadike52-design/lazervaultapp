import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

class AddInventoryItemScreen extends StatefulWidget {
  const AddInventoryItemScreen({super.key});

  @override
  State<AddInventoryItemScreen> createState() => _AddInventoryItemScreenState();
}

class _AddInventoryItemScreenState extends State<AddInventoryItemScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // Step 1: Basic Info
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _skuController = TextEditingController();
  String _selectedCategory = 'Other';

  // Step 2: Stock Details
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _minimumStockController = TextEditingController();
  String _selectedUnit = 'pcs';

  // Step 3: Location & Notes
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  static const _categories = [
    'Electronics',
    'Supplies',
    'Food',
    'Other',
  ];

  static const _units = ['pcs', 'kg', 'liters', 'boxes', 'units'];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _minimumStockController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < 2) {
      // Validate current step fields before proceeding
      if (_currentStep == 0) {
        if (_nameController.text.trim().isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Item name is required',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
          return;
        }
      }
      if (_currentStep == 1) {
        final quantity = int.tryParse(_quantityController.text.trim());
        final unitPrice =
            double.tryParse(_unitPriceController.text.replaceAll(',', ''));

        if (quantity == null || quantity < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Enter a valid quantity',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
          return;
        }
        if (unitPrice == null || unitPrice < 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Enter a valid unit price',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
          return;
        }
      }
      setState(() => _currentStep++);
    } else {
      _submitForm();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    } else {
      Get.back();
    }
  }

  void _submitForm() {
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    final unitPriceNaira =
        double.tryParse(_unitPriceController.text.replaceAll(',', '')) ?? 0.0;
    final unitPriceKobo = (unitPriceNaira * 100).toInt();
    final minimumStock =
        int.tryParse(_minimumStockController.text.trim()) ?? 0;

    context.read<InventoryCubit>().createItem(
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          sku: _skuController.text.trim(),
          quantity: quantity,
          unitPrice: unitPriceKobo,
          unit: _selectedUnit,
          minimumStockLevel: minimumStock,
          location: _locationController.text.trim(),
          notes: _notesController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is ItemCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Item "${state.item.name}" created successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is InventoryError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is InventoryLoading;

        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: _previousStep,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Add Item',
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
                _buildStepIndicator(),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: _buildCurrentStep(),
                    ),
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

  // ---------------------------------------------------------------------------
  // Step Indicator
  // ---------------------------------------------------------------------------

  Widget _buildStepIndicator() {
    const labels = ['Basic Info', 'Stock', 'Location'];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        children: List.generate(3, (index) {
          final isActive = index <= _currentStep;
          final isCurrent = index == _currentStep;
          return Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    if (index > 0)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: isActive
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF2D2D2D),
                        ),
                      ),
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF3B82F6)
                            : const Color(0xFF2D2D2D),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: GoogleFonts.inter(
                            color: isActive
                                ? Colors.white
                                : const Color(0xFF6B7280),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    if (index < 2)
                      Expanded(
                        child: Container(
                          height: 2.h,
                          color: index < _currentStep
                              ? const Color(0xFF3B82F6)
                              : const Color(0xFF2D2D2D),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  labels[index],
                  style: GoogleFonts.inter(
                    color: isCurrent
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF6B7280),
                    fontSize: 11.sp,
                    fontWeight: isCurrent ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Step Router
  // ---------------------------------------------------------------------------

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildBasicInfoStep();
      case 1:
        return _buildStockDetailsStep();
      case 2:
        return _buildLocationReviewStep();
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------------------------------------------------------------------------
  // Step 1: Basic Info
  // ---------------------------------------------------------------------------

  Widget _buildBasicInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Basic Information'),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _nameController,
          label: 'Item Name *',
          hint: 'e.g. USB-C Cable',
          icon: Icons.inventory_2_outlined,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _descriptionController,
          label: 'Description',
          hint: 'Brief description of the item',
          icon: Icons.description_outlined,
          maxLines: 3,
        ),
        SizedBox(height: 14.h),

        // Category dropdown
        Text(
          'Category',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              dropdownColor: const Color(0xFF1F1F1F),
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
              ),
              items: _categories.map((cat) {
                return DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedCategory = value);
                }
              },
            ),
          ),
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _skuController,
          label: 'SKU',
          hint: 'e.g. USBC-001',
          icon: Icons.qr_code_outlined,
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 2: Stock Details
  // ---------------------------------------------------------------------------

  Widget _buildStockDetailsStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Stock Details'),
        SizedBox(height: 8.h),
        Text(
          'Set quantity, pricing, and stock thresholds',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
          ),
        ),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _quantityController,
          label: 'Quantity *',
          hint: 'e.g. 100',
          icon: Icons.numbers,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _unitPriceController,
          label: 'Unit Price (Naira) *',
          hint: 'e.g. 2500',
          icon: Icons.payments_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[\d,.]')),
          ],
        ),
        SizedBox(height: 14.h),

        // Unit selector
        Text(
          'Unit',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _units.map((unit) {
            final isSelected = unit == _selectedUnit;
            return GestureDetector(
              onTap: () => setState(() => _selectedUnit = unit),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                      : const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF2D2D2D),
                  ),
                ),
                child: Text(
                  unit,
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _minimumStockController,
          label: 'Minimum Stock Level',
          hint: 'e.g. 10 (triggers low-stock alert)',
          icon: Icons.warning_amber_outlined,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Step 3: Location & Review
  // ---------------------------------------------------------------------------

  Widget _buildLocationReviewStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Location & Notes'),
        SizedBox(height: 16.h),
        _buildTextField(
          controller: _locationController,
          label: 'Storage Location',
          hint: 'e.g. Warehouse A, Shelf 3',
          icon: Icons.location_on_outlined,
        ),
        SizedBox(height: 14.h),
        _buildTextField(
          controller: _notesController,
          label: 'Notes',
          hint: 'Any additional notes',
          icon: Icons.notes_outlined,
          maxLines: 3,
        ),

        SizedBox(height: 28.h),
        _buildSectionTitle('Review Summary'),
        SizedBox(height: 16.h),
        _buildReviewCard(),
      ],
    );
  }

  Widget _buildReviewCard() {
    final unitPriceNaira =
        double.tryParse(_unitPriceController.text.replaceAll(',', '')) ?? 0.0;
    final quantity = int.tryParse(_quantityController.text.trim()) ?? 0;
    final totalValue = unitPriceNaira * quantity;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildReviewRow('Name', _nameController.text.trim()),
          _buildReviewRow('Category', _selectedCategory),
          if (_skuController.text.trim().isNotEmpty)
            _buildReviewRow('SKU', _skuController.text.trim()),
          _buildReviewRow('Quantity', '$quantity $_selectedUnit'),
          _buildReviewRow(
            'Unit Price',
            '\u20A6${unitPriceNaira.toStringAsFixed(2)}',
          ),
          _buildReviewRow(
            'Total Value',
            '\u20A6${totalValue.toStringAsFixed(2)}',
          ),
          if (_minimumStockController.text.trim().isNotEmpty)
            _buildReviewRow(
              'Min Stock',
              _minimumStockController.text.trim(),
            ),
          if (_locationController.text.trim().isNotEmpty)
            _buildReviewRow('Location', _locationController.text.trim()),
        ],
      ),
    );
  }

  Widget _buildReviewRow(String label, String value) {
    if (value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 6.h),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          maxLines: maxLines,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15.sp,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 15.sp,
            ),
            prefixIcon:
                Icon(icon, color: const Color(0xFF9CA3AF), size: 20.sp),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFEF4444)),
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActions(bool isLoading) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52.h,
        child: ElevatedButton(
          onPressed: isLoading ? null : _nextStep,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3B82F6),
            disabledBackgroundColor:
                const Color(0xFF3B82F6).withValues(alpha: 0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? SizedBox(
                  height: 22.h,
                  width: 22.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  _currentStep < 2 ? 'Continue' : 'Add Item',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
