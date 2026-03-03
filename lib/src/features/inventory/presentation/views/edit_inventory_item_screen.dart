import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import '../cubit/inventory_cubit.dart';
import '../cubit/inventory_state.dart';

class EditInventoryItemScreen extends StatefulWidget {
  final InventoryItemEntity item;

  const EditInventoryItemScreen({super.key, required this.item});

  @override
  State<EditInventoryItemScreen> createState() =>
      _EditInventoryItemScreenState();
}

class _EditInventoryItemScreenState extends State<EditInventoryItemScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _skuController;
  late final TextEditingController _unitPriceController;
  late final TextEditingController _unitController;
  late final TextEditingController _locationController;
  late final TextEditingController _minimumStockController;
  late final TextEditingController _notesController;

  late String _selectedCategory;
  late InventoryItemStatus _selectedStatus;

  static const _categories = [
    'Electronics',
    'Supplies',
    'Food',
    'Other',
  ];

  static const _statuses = [
    InventoryItemStatus.active,
    InventoryItemStatus.inactive,
    InventoryItemStatus.discontinued,
  ];

  @override
  void initState() {
    super.initState();
    final item = widget.item;
    _nameController = TextEditingController(text: item.name);
    _descriptionController = TextEditingController(text: item.description);
    _skuController = TextEditingController(text: item.sku);
    _unitPriceController = TextEditingController(
      text: item.unitPrice.toStringAsFixed(2),
    );
    _unitController = TextEditingController(text: item.unit);
    _locationController = TextEditingController(text: item.location);
    _minimumStockController = TextEditingController(
      text: item.minimumStockLevel.toString(),
    );
    _notesController = TextEditingController(text: item.notes);
    _selectedCategory = _categories.contains(item.category)
        ? item.category
        : 'Other';
    _selectedStatus = item.status;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _skuController.dispose();
    _unitPriceController.dispose();
    _unitController.dispose();
    _locationController.dispose();
    _minimumStockController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (!_formKey.currentState!.validate()) return;

    final unitPriceNaira =
        double.tryParse(_unitPriceController.text.replaceAll(',', '')) ?? 0.0;
    final unitPriceKobo = (unitPriceNaira * 100).toInt();
    final minimumStock =
        int.tryParse(_minimumStockController.text.trim()) ?? 0;

    context.read<InventoryCubit>().updateItem(
          itemId: widget.item.id,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          category: _selectedCategory,
          sku: _skuController.text.trim(),
          unitPrice: unitPriceKobo,
          unit: _unitController.text.trim(),
          location: _locationController.text.trim(),
          minimumStockLevel: minimumStock,
          status: _selectedStatus,
          notes: _notesController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InventoryCubit, InventoryState>(
      listener: (context, state) {
        if (state is ItemUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Item updated successfully',
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
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: Text(
              'Edit Item',
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
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // --- Basic Info ---
                          _buildSectionTitle('Basic Information'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _nameController,
                            label: 'Item Name *',
                            hint: 'e.g. USB-C Cable',
                            icon: Icons.inventory_2_outlined,
                            validator: (v) => v == null || v.trim().isEmpty
                                ? 'Name is required'
                                : null,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _descriptionController,
                            label: 'Description',
                            hint: 'Brief description',
                            icon: Icons.description_outlined,
                            maxLines: 3,
                          ),
                          SizedBox(height: 14.h),

                          // Category
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

                          // --- Stock Details ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Stock Details'),
                          SizedBox(height: 16.h),
                          _buildTextField(
                            controller: _unitPriceController,
                            label: 'Unit Price (Naira)',
                            hint: 'e.g. 2500.00',
                            icon: Icons.payments_outlined,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[\d,.]')),
                            ],
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Unit price is required';
                              }
                              final amount =
                                  double.tryParse(v.replaceAll(',', ''));
                              if (amount == null || amount < 0) {
                                return 'Enter a valid amount';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _unitController,
                            label: 'Unit',
                            hint: 'e.g. pcs, kg, liters',
                            icon: Icons.straighten_outlined,
                          ),
                          SizedBox(height: 14.h),
                          _buildTextField(
                            controller: _minimumStockController,
                            label: 'Minimum Stock Level',
                            hint: 'e.g. 10',
                            icon: Icons.warning_amber_outlined,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),

                          // --- Location & Notes ---
                          SizedBox(height: 28.h),
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

                          // --- Status ---
                          SizedBox(height: 28.h),
                          _buildSectionTitle('Status'),
                          SizedBox(height: 12.h),
                          Row(
                            children: _statuses.map((statusValue) {
                              final isSelected = statusValue == _selectedStatus;
                              String label;
                              Color color;
                              switch (statusValue) {
                                case InventoryItemStatus.active:
                                  label = 'Active';
                                  color = const Color(0xFF10B981);
                                  break;
                                case InventoryItemStatus.inactive:
                                  label = 'Inactive';
                                  color = const Color(0xFFFB923C);
                                  break;
                                case InventoryItemStatus.discontinued:
                                  label = 'Discontinued';
                                  color = const Color(0xFFEF4444);
                                  break;
                              }

                              return Expanded(
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => _selectedStatus = statusValue),
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      right: statusValue !=
                                              InventoryItemStatus.discontinued
                                          ? 8.w
                                          : 0,
                                    ),
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? color.withValues(alpha: 0.15)
                                          : const Color(0xFF1F1F1F),
                                      borderRadius:
                                          BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: isSelected
                                            ? color
                                            : const Color(0xFF2D2D2D),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        label,
                                        style: GoogleFonts.inter(
                                          color: isSelected
                                              ? color
                                              : const Color(0xFF9CA3AF),
                                          fontSize: 13.sp,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),

                          SizedBox(height: 24.h),
                        ],
                      ),
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
    String? Function(String?)? validator,
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
          validator: validator,
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
          onPressed: isLoading ? null : _saveChanges,
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
                  'Save Changes',
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
