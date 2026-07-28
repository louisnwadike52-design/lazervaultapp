import 'package:flutter/material.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/business/presentation/receipts/business_receipt.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/purchase_order_entity.dart';
import '../../domain/entities/supplier_entity.dart';
import '../../domain/entities/inventory_item_entity.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../domain/repositories/inventory_enhanced_repository.dart';
import '../cubit/inventory_enhanced_cubit.dart';
import '../cubit/inventory_enhanced_state.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/widgets/entity_create_sheet.dart';
import 'package:lazervault/core/widgets/infinite_scroll_mixin.dart';

class PurchaseOrderListScreen extends StatefulWidget {
  const PurchaseOrderListScreen({super.key});

  @override
  State<PurchaseOrderListScreen> createState() =>
      _PurchaseOrderListScreenState();
}

class _PurchaseOrderListScreenState extends State<PurchaseOrderListScreen>
    with InfiniteScrollMixin<PurchaseOrderListScreen> {
  PurchaseOrderStatus? _selectedStatus;
  List<SupplierEntity> _cachedSuppliers = [];
  List<InventoryItemEntity> _cachedItems = [];

  final _repo = serviceLocator<InventoryEnhancedRepository>();

  static const _limit = 20;

  List<PurchaseOrderEntity> _orders = [];
  bool _loading = false;

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
    attachInfiniteScroll();
    _loadFirst();
  }

  @override
  void dispose() {
    detachInfiniteScroll();
    super.dispose();
  }

  Future<void> _loadFirst() async {
    resetPagination();
    setState(() => _loading = true);
    try {
      final res = await _repo.listPurchaseOrders(
        page: 1,
        limit: _limit,
        status: _selectedStatus,
      );
      if (!mounted) return;
      setState(() {
        _orders = res;
        _loading = false;
        hasMore = res.length >= _limit;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
    }
  }

  @override
  Future<void> onLoadMore() => runLoadMore(() async {
        final res = await _repo.listPurchaseOrders(
          page: page + 1,
          limit: _limit,
          status: _selectedStatus,
        );
        if (!mounted) return;
        setState(() {
          _orders.addAll(res);
          page += 1;
          hasMore = res.length >= _limit;
        });
      });

  void _onStatusSelected(PurchaseOrderStatus? status) {
    setState(() => _selectedStatus = status);
    _loadFirst();
  }

  // ---------------------------------------------------------------------------
  // Create Purchase Order Dialog
  // ---------------------------------------------------------------------------

  void _showCreatePurchaseOrderDialog() {
    // First load suppliers for the dropdown
    _loadSuppliersForDialog();
  }

  void _loadSuppliersForDialog() async {
    // Load the supplier list + inventory items so the PO form SELECTS them
    // (supplier dropdown + per-line item picker) instead of typing raw UUIDs.
    try {
      final suppliers =
          await serviceLocator<InventoryEnhancedRepository>().listSuppliers();
      final items = await serviceLocator<InventoryRepository>().listItems(
        limit: 100,
        status: InventoryItemStatus.active,
      );
      if (!mounted) return;
      setState(() {
        _cachedSuppliers = suppliers;
        _cachedItems = items.items;
      });
    } catch (_) {
      // Best-effort — the form still opens; empty lists show helpful notes.
    }
    if (mounted) _showPurchaseOrderFormDialog();
  }

  void _showPurchaseOrderFormDialog() {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDialogLabel('Supplier *'),
                      GestureDetector(
                        onTap: () async {
                          final created = await showCreateSupplierSheet(context);
                          if (created == null || !mounted) return;
                          setState(() =>
                              _cachedSuppliers = [created, ..._cachedSuppliers]);
                          setDialogState(() => selectedSupplierId = created.id);
                        },
                        child: Text(
                          '+ New supplier',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF3B82F6),
                            fontSize: 12.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
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
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0A0A),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: const Color(0xFF2D2D2D)),
                      ),
                      child: Text(
                        'No suppliers yet — add a supplier first (Inventory → Suppliers).',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 12.5.sp,
                        ),
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
                      setDialogState,
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
                            final supplierId = selectedSupplierId ?? '';
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
                            // Reject zero/negative quantity lines — an order for
                            // 0 units is meaningless and receives nothing.
                            if (items.any((it) => it.quantityOrdered <= 0)) {
                              ScaffoldMessenger.of(dialogContext)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Every item needs a quantity greater than 0',
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
    StateSetter setDialogState,
    VoidCallback? onRemove,
  ) {
    final hasItem = item.itemIdController.text.isNotEmpty;
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
          // Select the item from inventory — sets itemId (linkage), name, and
          // pre-fills the unit price. Receiving the PO increments THIS item's stock.
          GestureDetector(
            onTap: () => _openPoItemPicker(item, setDialogState),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Row(
                children: [
                  Icon(Icons.inventory_2_rounded,
                      color: const Color(0xFFA78BFA), size: 18.sp),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      hasItem ? item.itemNameController.text : 'Select item from inventory',
                      style: GoogleFonts.inter(
                        color: hasItem ? Colors.white : const Color(0xFF6B7280),
                        fontSize: 13.sp,
                        fontWeight: hasItem ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(Icons.expand_more_rounded,
                      color: const Color(0xFF9CA3AF), size: 20.sp),
                ],
              ),
            ),
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

  void _openPoItemPicker(
    _PurchaseOrderItemInput item,
    StateSetter setDialogState,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          builder: (ctx, scrollCtrl) {
            return Column(
              children: [
                SizedBox(height: 12.h),
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Select item',
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700)),
                  ),
                ),
                // Add a brand-new inventory item inline, then select it for this line.
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(ctx).pop();
                      final created = await showCreateInventoryItemSheet(context);
                      if (created == null || !mounted) return;
                      setState(() => _cachedItems = [created, ..._cachedItems]);
                      item.itemIdController.text = created.id;
                      item.itemNameController.text = created.name;
                      if (item.priceController.text.trim().isEmpty) {
                        item.priceController.text =
                            created.unitPrice.toStringAsFixed(2);
                      }
                      setDialogState(() {});
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      padding:
                          EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.10),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color:
                                const Color(0xFF3B82F6).withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add_box_rounded,
                              color: const Color(0xFF3B82F6), size: 20.sp),
                          SizedBox(width: 10.w),
                          Text('Add new item',
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF3B82F6),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _cachedItems.isEmpty
                      ? Center(
                          child: Text('No inventory items yet',
                              style: GoogleFonts.inter(
                                  color: const Color(0xFF9CA3AF), fontSize: 13.sp)),
                        )
                      : ListView.builder(
                          controller: scrollCtrl,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: _cachedItems.length,
                          itemBuilder: (ctx, i) {
                            final it = _cachedItems[i];
                            final selected = item.itemIdController.text == it.id;
                            return GestureDetector(
                              onTap: () {
                                item.itemIdController.text = it.id;
                                item.itemNameController.text = it.name;
                                if (item.priceController.text.trim().isEmpty) {
                                  item.priceController.text =
                                      it.unitPrice.toStringAsFixed(2);
                                }
                                setDialogState(() {});
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 10.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 14.w, vertical: 12.h),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0A0A0A),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                      color: selected
                                          ? const Color.fromARGB(255, 78, 3, 208)
                                          : const Color(0xFF2D2D2D)),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.inventory_2_rounded,
                                        color: const Color(0xFFA78BFA),
                                        size: 20.sp),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(it.name,
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(height: 2.h),
                                          Text(
                                              '₦${it.unitPrice.toStringAsFixed(2)} · ${it.quantity} ${it.unit} in stock',
                                              style: GoogleFonts.inter(
                                                  color: const Color(0xFF9CA3AF),
                                                  fontSize: 11.5.sp)),
                                        ],
                                      ),
                                    ),
                                    if (selected)
                                      Icon(Icons.check_circle_rounded,
                                          color:
                                              const Color.fromARGB(255, 78, 3, 208),
                                          size: 20.sp),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        );
      },
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
    return BlocListener<InventoryEnhancedCubit, InventoryEnhancedState>(
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
          _loadFirst();
        }
        if (state is PurchaseOrderReceived) {
          final po = state.order;
          final tx = buildBusinessReceipt(
            type: TransactionServiceType.purchaseOrder,
            title: 'Goods received',
            amountMajor: po.totalAmount,
            flow: TransactionFlow.neutral,
            status: UnifiedTransactionStatus.completed,
            reference: po.reference.isNotEmpty ? po.reference : po.id,
            counterpartyName:
                po.supplierName.isNotEmpty ? po.supplierName : null,
            description: 'Purchase order received into inventory',
            metadata: {
              if (po.supplierName.isNotEmpty) 'Supplier': po.supplierName,
              if (po.reference.isNotEmpty) 'PO reference': po.reference,
              'Status': po.status.name,
            },
          );
          showBusinessReceipt(context, tx);
          _loadFirst();
        }
        // Cache suppliers when they come in (for dropdown)
        if (state is SuppliersLoaded) {
          _cachedSuppliers = state.suppliers;
        }
      },
      child: _buildList(),
    );
  }

  Widget _buildList() {
    if (_loading) {
      return const Center(
        child: LazerVaultLoader.small(),
      );
    }

    if (_orders.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async => _loadFirst(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView.builder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        itemCount: _orders.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= _orders.length) {
            return Padding(
              padding: EdgeInsets.all(16.w),
              child: const Center(child: LazerVaultLoader.small()),
            );
          }
          return _buildOrderCard(_orders[index]);
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Purchase Order Card
  // ---------------------------------------------------------------------------

  Widget _buildOrderCard(PurchaseOrderEntity order) {
    final dateFormat = DateFormat('dd MMM yyyy');
    // A PO can be received while it still has outstanding quantity and isn't
    // cancelled/fully received. Previously this card had no tap target at all,
    // so the whole receive flow (backend + cubit) was unreachable dead code.
    final canReceive = order.status != PurchaseOrderStatus.received &&
        order.status != PurchaseOrderStatus.cancelled &&
        order.items.any((i) => i.quantityReceived < i.quantityOrdered);

    return GestureDetector(
      onTap: canReceive ? () => _openReceivePurchaseOrderSheet(order) : null,
      child: Container(
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

          // Item count + receive affordance
          Row(
            children: [
              Text(
                '${order.items.length} item${order.items.length != 1 ? 's' : ''}',
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
              const Spacer(),
              if (canReceive) ...[
                Icon(Icons.inventory_2_outlined,
                    color: const Color(0xFF10B981), size: 13.sp),
                SizedBox(width: 4.w),
                Text(
                  'Tap to receive',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF10B981),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
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
  // Receive Purchase Order
  // ---------------------------------------------------------------------------

  /// Bottom sheet to receive a PO's outstanding items into stock. Each line
  /// defaults to its outstanding quantity (ordered − already received); the user
  /// can reduce it for a partial delivery. Confirm → InventoryEnhancedCubit
  /// .receivePurchaseOrder, whose PurchaseOrderReceived listener reloads the list
  /// (and the backend atomically credits stock + writes an ADD adjustment).
  void _openReceivePurchaseOrderSheet(PurchaseOrderEntity order) {
    // Per-item controllers, defaulted to the outstanding quantity.
    final controllers = <String, TextEditingController>{};
    for (final it in order.items) {
      final outstanding = (it.quantityOrdered - it.quantityReceived).clamp(0, 1 << 30);
      controllers[it.itemId] = TextEditingController(text: '$outstanding');
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 16.h,
            bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFF2D2D2D),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text('Receive ${order.reference}',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
              SizedBox(height: 4.h),
              Text('Confirm the quantities received into stock.',
                  style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF), fontSize: 12.5.sp)),
              SizedBox(height: 16.h),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: order.items.map((it) {
                      final outstanding =
                          (it.quantityOrdered - it.quantityReceived).clamp(0, 1 << 30);
                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(it.itemName,
                                      style: GoogleFonts.inter(
                                          color: Colors.white, fontSize: 13.5.sp)),
                                  Text(
                                      'Ordered ${it.quantityOrdered} • received ${it.quantityReceived} • outstanding $outstanding',
                                      style: GoogleFonts.inter(
                                          color: const Color(0xFF6B7280),
                                          fontSize: 11.sp)),
                                ],
                              ),
                            ),
                            SizedBox(width: 12.w),
                            SizedBox(
                              width: 64.w,
                              child: TextField(
                                controller: controllers[it.itemId],
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                    color: Colors.white, fontSize: 14.sp),
                                decoration: InputDecoration(
                                  isDense: true,
                                  filled: true,
                                  fillColor: const Color(0xFF0A0A0A),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 8.w),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  onPressed: () {
                    // Build the received list, clamping each entry to its
                    // outstanding quantity (the backend re-clamps too).
                    final received = <PurchaseOrderItemEntity>[];
                    for (final it in order.items) {
                      final outstanding =
                          (it.quantityOrdered - it.quantityReceived).clamp(0, 1 << 30);
                      final entered =
                          int.tryParse(controllers[it.itemId]?.text.trim() ?? '') ?? 0;
                      final qty = entered.clamp(0, outstanding);
                      if (qty > 0) {
                        received.add(PurchaseOrderItemEntity(
                          itemId: it.itemId,
                          itemName: it.itemName,
                          quantityOrdered: it.quantityOrdered,
                          quantityReceived: qty, // delta to receive now
                          unitPrice: it.unitPrice,
                          totalPrice: it.totalPrice,
                        ));
                      }
                    }
                    if (received.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Enter at least one quantity to receive',
                              style: GoogleFonts.inter(color: Colors.white)),
                          backgroundColor: const Color(0xFFEF4444),
                        ),
                      );
                      return;
                    }
                    Navigator.of(sheetCtx).pop();
                    context.read<InventoryEnhancedCubit>().receivePurchaseOrder(
                          purchaseOrderId: order.id,
                          receivedItems: received,
                        );
                  },
                  child: Text('Confirm receipt',
                      style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      for (final c in controllers.values) {
        c.dispose();
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: () async => _loadFirst(),
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
