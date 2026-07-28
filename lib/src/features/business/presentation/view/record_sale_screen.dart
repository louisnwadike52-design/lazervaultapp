import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:lazervault/core/types/unified_transaction.dart';
import 'package:lazervault/src/features/business/presentation/receipts/business_receipt.dart';
import 'package:lazervault/core/services/endpoint_registry.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:lazervault/core/widgets/entity_create_sheet.dart';
import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:lazervault/src/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/domain/repositories/customer_repository.dart';
import '../../data/services/sales_service.dart';

/// Record a sale — the revenue engine's entry point. A PAID sale credits the
/// business account; an unpaid sale is booked as a customer receivable.
///
/// Sales are LINKED to inventory: pick an item from stock and the sale decrements
/// that item's quantity (backend `RecordSale` guards stock + decrements), so the
/// item sold is a real inventory item — not free text. A "custom item" escape
/// hatch stays for one-off sales of things not tracked in inventory.
class RecordSaleScreen extends StatefulWidget {
  const RecordSaleScreen({super.key});

  @override
  State<RecordSaleScreen> createState() => _RecordSaleScreenState();
}

class _RecordSaleScreenState extends State<RecordSaleScreen> {
  static const _bg = InvoiceThemeColors.primaryBackground;
  static const _card = InvoiceThemeColors.secondaryBackground;
  static const _border = InvoiceThemeColors.borderColor;
  static const _accent = InvoiceThemeColors.primaryPurple;
  static const _accentText = InvoiceThemeColors.primaryPurpleLight;
  static const _muted = Color(0xFF9CA3AF);
  static const _danger = Color(0xFFEF4444);

  final _amountCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  String _paymentMethod = 'cash';
  bool _paid = true;
  bool _submitting = false;

  // Inventory linkage — a sale MUST pick an item from inventory (item + quantity
  // come from the picker, never typed). `_customMode` is an explicit, secondary
  // escape hatch for a one-off/service sale (chosen from the picker), and only
  // THEN are amount + description entered. Default = nothing chosen → prompt.
  List<InventoryItemEntity> _items = const [];
  bool _loadingItems = true;
  InventoryItemEntity? _selectedItem;
  bool _customMode = false;
  int _quantity = 1;

  // Customer linkage — attribute the sale to a real customer (an UNPAID sale
  // then becomes that customer's receivable). Optional: null = walk-in.
  List<CustomerEntity> _customers = const [];
  bool _loadingCustomers = true;
  CustomerEntity? _selectedCustomer;

  static const _methods = ['cash', 'transfer', 'card', 'credit'];

  // One idempotency key per screen instance: a retry of THIS sale (e.g. a
  // network timeout then re-tap) reuses it so the backend GetByReference
  // short-circuits instead of booking a duplicate sale + double inventory
  // decrement. A genuinely new sale opens a fresh screen → fresh key.
  late final String _idempotencyKey;

  @override
  void initState() {
    super.initState();
    _idempotencyKey = const Uuid().v4();
    _loadInventory();
    _loadCustomers();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadInventory() async {
    try {
      final result = await serviceLocator<InventoryRepository>().listItems(
        limit: 100,
        status: InventoryItemStatus.active,
      );
      if (!mounted) return;
      setState(() {
        _items = result.items;
        _loadingItems = false;
      });
    } catch (_) {
      // Inventory is best-effort — the custom-item path still works if it fails.
      if (mounted) setState(() => _loadingItems = false);
    }
  }

  Future<void> _loadCustomers() async {
    try {
      final result =
          await serviceLocator<CustomerRepository>().listCustomers(limit: 100);
      if (!mounted) return;
      setState(() {
        _customers = result.items;
        _loadingCustomers = false;
      });
    } catch (_) {
      // Best-effort — a sale can still be recorded as a walk-in.
      if (mounted) setState(() => _loadingCustomers = false);
    }
  }

  bool get _isInventorySale => _selectedItem != null;

  /// Amount in MAJOR units (Naira) for display + submit-time conversion.
  double get _computedAmount {
    if (_isInventorySale) return _selectedItem!.unitPrice * _quantity;
    return double.tryParse(_amountCtrl.text.trim()) ?? 0;
  }

  Future<void> _submit() async {
    if (!_isInventorySale && !_customMode) {
      _snack('Select an item from inventory first', _danger);
      return;
    }
    final amountMajor = _computedAmount;
    if (amountMajor <= 0) {
      _snack('Enter a valid sale amount', _danger);
      return;
    }
    if (_isInventorySale) {
      final item = _selectedItem!;
      if (_quantity < 1) {
        _snack('Quantity must be at least 1', _danger);
        return;
      }
      if (_quantity > item.quantity) {
        _snack('Only ${item.quantity} ${item.unit} of ${item.name} in stock', _danger);
        return;
      }
    } else if (_descCtrl.text.trim().isEmpty) {
      _snack('What did you sell?', _danger);
      return;
    }

    setState(() => _submitting = true);
    try {
      final service = SalesService(endpoints: endpointRegistry);
      await service.recordSale(
        amount: (amountMajor * 100).round(),
        description: _isInventorySale
            ? '$_quantity × ${_selectedItem!.name}'
            : _descCtrl.text.trim(),
        paymentMethod: _paymentMethod,
        paid: _paid,
        quantity: _isInventorySale ? _quantity : 1,
        unitPrice: _isInventorySale ? (_selectedItem!.unitPrice * 100).round() : 0,
        inventoryItemId: _isInventorySale ? _selectedItem!.id : '',
        customerId: _selectedCustomer?.id ?? '',
        idempotencyKey: _idempotencyKey,
      );
      if (!mounted) return;
      HapticFeedback.mediumImpact();

      final tx = buildBusinessReceipt(
        type: TransactionServiceType.sale,
        title: 'Sale recorded',
        amountMajor: amountMajor,
        flow: _paid ? TransactionFlow.incoming : TransactionFlow.neutral,
        status: _paid
            ? UnifiedTransactionStatus.completed
            : UnifiedTransactionStatus.pending,
        counterpartyName: _selectedCustomer?.name,
        description: _isInventorySale
            ? '$_quantity × ${_selectedItem!.name}'
            : _descCtrl.text.trim(),
        metadata: {
          'Type': _paid ? 'Paid sale' : 'Receivable',
          'Payment method': _paymentMethod,
          if (_isInventorySale) 'Quantity': '$_quantity ${_selectedItem!.unit}',
          if (_selectedCustomer != null) 'Customer': _selectedCustomer!.name,
        },
      );
      await showBusinessReceipt(context, tx);
      if (!mounted) return;
      Get.back(result: true);
    } catch (e) {
      if (mounted) _snack(e.toString(), _danger);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _snack(String m, Color c) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m), backgroundColor: c));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Record a sale',
            style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            _label('Item'),
            _itemSelector(),
            SizedBox(height: 16.h),
            if (_isInventorySale) ...[
              _quantityRow(),
              SizedBox(height: 16.h),
              _amountSummary(),
            ] else if (_customMode) ...[
              _label('Amount (NGN)'),
              _field(_amountCtrl,
                  hint: '0.00',
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  onChanged: (_) => setState(() {})),
              SizedBox(height: 16.h),
              _label('What did you sell?'),
              _field(_descCtrl, hint: 'e.g. consulting service', maxLines: 2),
            ] else ...[
              // Nothing chosen yet — REQUIRE an inventory pick (no manual fields).
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: _accent.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: _accent.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.touch_app_rounded, color: _accentText, size: 18.sp),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Tap "Select an item" above to pick from inventory. Quantity is set with the stepper — no manual entry.',
                        style: GoogleFonts.inter(color: _muted, fontSize: 12.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: 16.h),
            _label('Customer (optional)'),
            _customerSelector(),
            SizedBox(height: 16.h),
            _label('Payment method'),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _methods.map((m) {
                final sel = _paymentMethod == m;
                return GestureDetector(
                  onTap: () => setState(() => _paymentMethod = m),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
                    decoration: BoxDecoration(
                      color: sel ? _accent.withValues(alpha: 0.18) : _card,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: sel ? _accent : _border),
                    ),
                    child: Text(m[0].toUpperCase() + m.substring(1),
                        style: GoogleFonts.inter(
                            color: sel ? _accentText : _muted,
                            fontSize: 13.sp,
                            fontWeight: sel ? FontWeight.w600 : FontWeight.w500)),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                  color: _card, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _border)),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeThumbColor: _accent,
                value: _paid,
                onChanged: (v) => setState(() => _paid = v),
                title: Text('Payment received',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp)),
                subtitle: Text(
                    _paid
                        ? 'Counts as realised revenue (does not touch your wallet balance)'
                        : 'Books it as a customer receivable',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accent,
                  disabledBackgroundColor: _accent.withValues(alpha: 0.4),
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: _submitting
                    ? SizedBox(
                        height: 20.h, width: 20.h,
                        child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : Text('Record sale',
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---- Item selector (linked to inventory) ----

  Widget _itemSelector() {
    return GestureDetector(
      onTap: _loadingItems ? null : _openItemPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                  _isInventorySale
                      ? Icons.inventory_2_rounded
                      : _customMode
                          ? Icons.edit_note_rounded
                          : Icons.inventory_2_outlined,
                  color: _accentText,
                  size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _loadingItems
                        ? 'Loading inventory…'
                        : _isInventorySale
                            ? _selectedItem!.name
                            : _customMode
                                ? 'Custom / one-off item'
                                : 'Select an item',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    _isInventorySale
                        ? '₦${_selectedItem!.unitPrice.toStringAsFixed(2)} · ${_selectedItem!.quantity} ${_selectedItem!.unit} in stock'
                        : _customMode
                            ? 'Enter the amount below'
                            : 'Pick from inventory (stock updates on sale)',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.expand_more_rounded, color: _muted, size: 22.sp),
          ],
        ),
      ),
    );
  }

  void _openItemPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
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
                      color: _border, borderRadius: BorderRadius.circular(2.r)),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Text('Select item',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollCtrl,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      // Add a brand-new inventory item inline (runs the full
                      // add-inventory flow in a sheet, then selects the result).
                      _pickerRow(
                        icon: Icons.add_box_rounded,
                        title: 'Add new item',
                        subtitle: 'Create an inventory item and select it',
                        selected: false,
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _createAndSelectItem();
                        },
                      ),
                      // Custom / one-off item escape hatch (services, non-stock)
                      _pickerRow(
                        icon: Icons.edit_note_rounded,
                        title: 'Custom / one-off (not in inventory)',
                        subtitle: 'For a service or non-stock item',
                        selected: _customMode,
                        onTap: () {
                          setState(() {
                            _selectedItem = null;
                            _customMode = true;
                            _quantity = 1;
                          });
                          Navigator.of(ctx).pop();
                        },
                      ),
                      if (_items.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Center(
                            child: Text('No inventory items yet',
                                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
                          ),
                        )
                      else
                        ..._items.map((it) {
                          final out = it.quantity <= 0;
                          return _pickerRow(
                            icon: Icons.inventory_2_rounded,
                            title: it.name,
                            subtitle:
                                '₦${it.unitPrice.toStringAsFixed(2)} · ${it.quantity} ${it.unit}${out ? ' · out of stock' : ''}',
                            selected: _selectedItem?.id == it.id,
                            disabled: out,
                            onTap: out
                                ? null
                                : () {
                                    setState(() {
                                      _selectedItem = it;
                                      _customMode = false;
                                      _quantity = 1;
                                    });
                                    Navigator.of(ctx).pop();
                                  },
                          );
                        }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Run the full add-inventory flow in a bottom sheet; on create, prepend the
  /// new item to the in-memory list and select it for this sale.
  Future<void> _createAndSelectItem() async {
    final created = await showCreateInventoryItemSheet(context);
    if (created == null || !mounted) return;
    setState(() {
      _items = [created, ..._items];
      _selectedItem = created;
      _customMode = false;
      _quantity = 1;
    });
    _snack('${created.name} added and selected', _accent);
  }

  // ---- Customer selector (attributes the sale to a real customer) ----

  Widget _customerSelector() {
    final c = _selectedCustomer;
    return GestureDetector(
      onTap: _loadingCustomers ? null : _openCustomerPicker,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: _card,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: _border),
        ),
        child: Row(
          children: [
            Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(c != null ? Icons.person_rounded : Icons.person_outline_rounded,
                  color: _accentText, size: 20.sp),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _loadingCustomers
                        ? 'Loading customers…'
                        : c != null
                            ? c.name
                            : 'Walk-in customer',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    c != null
                        ? (c.phone.isNotEmpty ? c.phone : (c.businessName.isNotEmpty ? c.businessName : 'Attributed to this customer'))
                        : 'Attribute this sale to a customer (for receivables)',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp),
                  ),
                ],
              ),
            ),
            Icon(Icons.expand_more_rounded, color: _muted, size: 22.sp),
          ],
        ),
      ),
    );
  }

  void _openCustomerPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: _card,
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
                      color: _border, borderRadius: BorderRadius.circular(2.r)),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      Text('Select customer',
                          style: GoogleFonts.inter(
                              color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: scrollCtrl,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    children: [
                      // Add a brand-new customer inline (runs the full
                      // add-customer flow in a sheet, then attributes to it).
                      _pickerRow(
                        icon: Icons.person_add_alt_1_rounded,
                        title: 'Add new customer',
                        subtitle: 'Create a customer and attribute this sale',
                        selected: false,
                        onTap: () {
                          Navigator.of(ctx).pop();
                          _createAndSelectCustomer();
                        },
                      ),
                      // Walk-in (no customer) escape hatch
                      _pickerRow(
                        icon: Icons.person_outline_rounded,
                        title: 'Walk-in customer',
                        subtitle: 'No customer attribution',
                        selected: _selectedCustomer == null,
                        onTap: () {
                          setState(() => _selectedCustomer = null);
                          Navigator.of(ctx).pop();
                        },
                      ),
                      if (_customers.isEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 24.h),
                          child: Center(
                            child: Text('No customers yet',
                                style: GoogleFonts.inter(color: _muted, fontSize: 13.sp)),
                          ),
                        )
                      else
                        ..._customers.map((c) {
                          final sub = c.phone.isNotEmpty
                              ? c.phone
                              : (c.businessName.isNotEmpty ? c.businessName : c.email);
                          return _pickerRow(
                            icon: Icons.person_rounded,
                            title: c.name,
                            subtitle: sub.isNotEmpty ? sub : 'Customer',
                            selected: _selectedCustomer?.id == c.id,
                            onTap: () {
                              setState(() => _selectedCustomer = c);
                              Navigator.of(ctx).pop();
                            },
                          );
                        }),
                      SizedBox(height: 24.h),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  /// Run the full add-customer flow in a bottom sheet; on create, prepend the
  /// new customer to the in-memory list and attribute this sale to them.
  Future<void> _createAndSelectCustomer() async {
    final created = await showCreateCustomerSheet(context);
    if (created == null || !mounted) return;
    setState(() {
      _customers = [created, ..._customers];
      _selectedCustomer = created;
    });
    _snack('${created.name} added and selected', _accent);
  }

  Widget _pickerRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    bool disabled = false,
    VoidCallback? onTap,
  }) {
    return Opacity(
      opacity: disabled ? 0.45 : 1,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(bottom: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: _bg,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: selected ? _accent : _border),
          ),
          child: Row(
            children: [
              Icon(icon, color: _accentText, size: 20.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.inter(
                            color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                    SizedBox(height: 2.h),
                    Text(subtitle,
                        style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
                  ],
                ),
              ),
              if (selected) Icon(Icons.check_circle_rounded, color: _accent, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _quantityRow() {
    final item = _selectedItem!;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
          color: _card, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: _border)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quantity',
                    style: GoogleFonts.inter(
                        color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600)),
                SizedBox(height: 2.h),
                Text('${item.quantity} ${item.unit} available',
                    style: GoogleFonts.inter(color: _muted, fontSize: 11.5.sp)),
              ],
            ),
          ),
          _qtyButton(Icons.remove_rounded, _quantity > 1 ? () => setState(() => _quantity--) : null),
          SizedBox(width: 14.w),
          Text('$_quantity',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700)),
          SizedBox(width: 14.w),
          _qtyButton(Icons.add_rounded, _quantity < item.quantity ? () => setState(() => _quantity++) : null),
        ],
      ),
    );
  }

  Widget _qtyButton(IconData icon, VoidCallback? onTap) {
    final enabled = onTap != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34.w,
        height: 34.w,
        decoration: BoxDecoration(
          color: enabled ? _accent.withValues(alpha: 0.15) : _card,
          borderRadius: BorderRadius.circular(9.r),
          border: Border.all(color: enabled ? _accent : _border),
        ),
        child: Icon(icon, color: enabled ? _accentText : _muted, size: 18.sp),
      ),
    );
  }

  Widget _amountSummary() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _accent.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _accent.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Total',
              style: GoogleFonts.inter(color: _muted, fontSize: 13.sp, fontWeight: FontWeight.w500)),
          Text('₦${_computedAmount.toStringAsFixed(2)}',
              style: GoogleFonts.inter(
                  color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _label(String t) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(t,
            style: GoogleFonts.inter(color: _muted, fontSize: 12.5.sp, fontWeight: FontWeight.w600)),
      );

  Widget _field(TextEditingController c,
      {String? hint, int maxLines = 1, TextInputType? keyboardType, ValueChanged<String>? onChanged}) {
    return TextField(
      controller: c,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: _muted, fontSize: 13.sp),
        filled: true,
        fillColor: _card,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: _border)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: _accent)),
      ),
    );
  }
}
