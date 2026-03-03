import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/purchase_order_entity.dart';
import '../../domain/entities/supplier_entity.dart';
import '../cubit/inventory_enhanced_cubit.dart';
import '../cubit/inventory_enhanced_state.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen> {
  PurchaseOrderStatus? _selectedStatus;
  List<SupplierEntity> _cachedSuppliers = [];

  static const _statusFilters = <PurchaseOrderStatus?>[
    null, // All
    PurchaseOrderStatus.draft,
    PurchaseOrderStatus.submitted,
    PurchaseOrderStatus.received,
    PurchaseOrderStatus.cancelled,
  ];

  static const _statusLabels = [
    'All',
    'Draft',
    'Submitted',
    'Received',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _loadOrders();
  }

  void _loadOrders() {
    context.read<InventoryEnhancedCubit>().listPurchaseOrders(
          status: _selectedStatus,
        );
  }

  void _onStatusSelected(PurchaseOrderStatus? status) {
    setState(() => _selectedStatus = status);
    _loadOrders();
  }

  // ---------------------------------------------------------------------------
  // Create Purchase Order Dialog
  // ---------------------------------------------------------------------------

  void _showCreatePurchaseOrderDialog() {
    // First load suppliers for the dropdown
    _loadSuppliersForDialog();
  }

  void _loadSuppliersForDialog() async {
    // Load suppliers inline, then show the dialog
    try {
      // We'll read from cached suppliers if available, otherwise show dialog
      // with a note to load suppliers first
      _showPurchaseOrderFormDialog();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Failed to load suppliers',
            style: GoogleFonts.inter(color: Colors.white),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  void _showPurchaseOrderFormDialog() {
    final supplierIdController = TextEditingController();
    final notesController = TextEditingController();
    final expectedDateController = TextEditingController();
    String? selectedSupplierId;
    DateTime? selectedDate;

    // Item entry controllers
    final List<_PurchaseOrderItemInput> itemInputs = [
      _PurchaseOrderItemInput(),
    ];

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => Dialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(dialogContext).size.height * 0.85,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create Purchase Order',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Supplier selection
                  _buildDialogLabel('Supplier *'),
                  SizedBox(height: 6.h),
                  if (_cachedSuppliers.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: const Color(0xFF2D2D2D),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedSupplierId,
                          isExpanded: true,
                          dropdownColor: const Color(0xFF1F1F1F),
                          hint: Text(
                            'Select supplier',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF6B7280),
                              fontSize: 14.sp,
                            ),
                          ),
                          items: _cachedSuppliers.map((s) {
                            return DropdownMenuItem(
                              value: s.id,
                              child: Text(
                                s.name,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setDialogState(() {
                              selectedSupplierId = value;
                            });
                          },
                        ),
                      ),
                    )
                  else
                    TextField(
                      controller: supplierIdController,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      decoration: _dialogInputDecoration(
                        'Enter supplier ID',
                      ),
                    ),

                  SizedBox(height: 14.h),

                  // Expected date
                  _buildDialogLabel('Expected Delivery Date'),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: dialogContext,
                        initialDate:
                            DateTime.now().add(const Duration(days: 7)),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now()
                            .add(const Duration(days: 365)),
                        builder: (context, child) => Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF3B82F6),
                              surface: Color(0xFF1F1F1F),
                            ),
                          ),
                          child: child!,
                        ),
                      );
                      if (date != null) {
                        setDialogState(() {
                          selectedDate = date;
                          expectedDateController.text =
                              DateFormat('dd MMM yyyy').format(date);
                        });
                      }
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: expectedDateController,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                        decoration: _dialogInputDecoration(
                          'Select date',
                        ).copyWith(
                          suffixIcon: Icon(
                            Icons.calendar_today,
                            color: const Color(0xFF9CA3AF),
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 18.h),

                  // Items section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Items',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setDialogState(() {
                            itemInputs.add(_PurchaseOrderItemInput());
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '+ Add Item',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF3B82F6),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),

                  ...itemInputs.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final item = entry.value;
                    return _buildItemInputRow(
                      item,
                      idx,
                      itemInputs.length > 1
                          ? () {
                              setDialogState(() {
                                itemInputs[idx].dispose();
                                itemInputs.removeAt(idx);
                              });
                            }
                          : null,
                    );
                  }),

                  SizedBox(height: 14.h),

                  // Notes
                  _buildDialogLabel('Notes'),
                  SizedBox(height: 6.h),
                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                    ),
                    decoration: _dialogInputDecoration('Additional notes...'),
                  ),

                  SizedBox(height: 24.h),

                  // Actions
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            for (final item in itemInputs) {
                              item.dispose();
                            }
                            Navigator.pop(dialogContext);
                          },
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF9CA3AF),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final supplierId = selectedSupplierId ??
                                supplierIdController.text.trim();
                            if (supplierId.isEmpty) {
                              ScaffoldMessenger.of(dialogContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Supplier is required',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor:
                                      const Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            final items =
                                itemInputs.map((input) {
                              final qty = int.tryParse(
                                      input.quantityController.text) ??
                                  0;
                              final price = double.tryParse(
                                      input.priceController.text) ??
                                  0;
                              return PurchaseOrderItemEntity(
                                itemId: input.itemIdController.text.trim(),
                                itemName:
                                    input.itemNameController.text.trim(),
                                quantityOrdered: qty,
                                quantityReceived: 0,
                                unitPrice: price,
                                totalPrice: qty * price,
                              );
                            }).toList();

                            if (items.isEmpty ||
                                items.first.itemName.isEmpty) {
                              ScaffoldMessenger.of(dialogContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'At least one item is required',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                    ),
                                  ),
                                  backgroundColor:
                                      const Color(0xFFEF4444),
                                ),
                              );
                              return;
                            }

                            for (final item in itemInputs) {
                              item.dispose();
                            }
                            Navigator.pop(dialogContext);

                            context
                                .read<InventoryEnhancedCubit>()
                                .createPurchaseOrder(
                                  supplierId: supplierId,
                                  items: items,
                                  notes: notesController.text.trim(),
                                  expectedDate: selectedDate
                                      ?.toIso8601String(),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3B82F6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            padding:
                                EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          child: Text(
                            'Create',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 14.sp,
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
        ),
      ),
    );
  }

  Widget _buildItemInputRow(
    _PurchaseOrderItemInput item,
    int index,
    VoidCallback? onRemove,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Item ${index + 1}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onRemove != null)
                GestureDetector(
                  onTap: onRemove,
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFFEF4444),
                    size: 18.sp,
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: item.itemNameController,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 13.sp),
            decoration: _dialogInputDecoration('Item name'),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: item.quantityController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                  decoration: _dialogInputDecoration('Qty'),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  controller: item.priceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.sp,
                  ),
                  decoration: _dialogInputDecoration('Unit Price (\u20A6)'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDialogLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        color: const Color(0xFF9CA3AF),
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration _dialogInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
        color: const Color(0xFF6B7280),
        fontSize: 14.sp,
      ),
      filled: true,
      fillColor: const Color(0xFF0A0A0A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: const BorderSide(color: Color(0xFF3B82F6)),
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 10.h,
      ),
      isDense: true,
    );
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
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
          'Purchase Orders',
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
            _buildStatusFilters(),
            SizedBox(height: 4.h),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePurchaseOrderDialog,
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status Filter Chips
  // ---------------------------------------------------------------------------

  Widget _buildStatusFilters() {
    return SizedBox(
      height: 42.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _statusFilters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filterStatus = _statusFilters[index];
          final isSelected = filterStatus == _selectedStatus;

          return GestureDetector(
            onTap: () => _onStatusSelected(filterStatus),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF3B82F6)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Center(
                child: Text(
                  _statusLabels[index],
                  style: GoogleFonts.inter(
                    color: isSelected
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Body
  // ---------------------------------------------------------------------------

  Widget _buildBody() {
    return BlocConsumer<InventoryEnhancedCubit, InventoryEnhancedState>(
      listener: (context, state) {
        if (state is InventoryEnhancedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
        if (state is PurchaseOrderCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Purchase order created: ${state.order.reference}',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadOrders();
        }
        if (state is PurchaseOrderReceived) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Purchase order marked as received',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadOrders();
        }
        // Cache suppliers when they come in (for dropdown)
        if (state is SuppliersLoaded) {
          _cachedSuppliers = state.suppliers;
        }
      },
      builder: (context, state) {
        if (state is InventoryEnhancedLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF3B82F6),
            ),
          );
        }

        if (state is PurchaseOrdersLoaded) {
          if (state.orders.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadOrders(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemCount: state.orders.length,
              itemBuilder: (context, index) =>
                  _buildOrderCard(state.orders[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Purchase Order Card
  // ---------------------------------------------------------------------------

  Widget _buildOrderCard(PurchaseOrderEntity order) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reference + status
          Row(
            children: [
              Expanded(
                child: Text(
                  order.reference,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              _buildOrderStatusBadge(order),
            ],
          ),
          SizedBox(height: 8.h),

          // Supplier
          Row(
            children: [
              Icon(
                Icons.business,
                color: const Color(0xFF9CA3AF),
                size: 14.sp,
              ),
              SizedBox(width: 6.w),
              Text(
                order.supplierName,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // Amount + expected date
          Row(
            children: [
              Text(
                order.formattedTotal,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (order.expectedDate != null) ...[
                Icon(
                  Icons.calendar_today,
                  color: const Color(0xFF6B7280),
                  size: 12.sp,
                ),
                SizedBox(width: 4.w),
                Text(
                  dateFormat.format(order.expectedDate!),
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 4.h),

          // Item count
          Text(
            '${order.items.length} item${order.items.length != 1 ? 's' : ''}',
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStatusBadge(PurchaseOrderEntity order) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: order.statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        order.statusDisplay,
        style: GoogleFonts.inter(
          color: order.statusColor,
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadOrders(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.receipt_long_outlined,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No purchase orders',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to create your first purchase order',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

/// Helper class to hold text controllers for a single PO line item input.
class _PurchaseOrderItemInput {
  final itemIdController = TextEditingController();
  final itemNameController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();

  void dispose() {
    itemIdController.dispose();
    itemNameController.dispose();
    quantityController.dispose();
    priceController.dispose();
  }
}
