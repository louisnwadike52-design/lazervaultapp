import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';

import 'package:lazervault/src/features/inventory/domain/entities/inventory_item_entity.dart';
import 'package:lazervault/src/features/inventory/domain/entities/supplier_entity.dart';
import 'package:lazervault/src/features/inventory/presentation/cubit/inventory_cubit.dart';
import 'package:lazervault/src/features/inventory/presentation/cubit/inventory_enhanced_cubit.dart';
import 'package:lazervault/src/features/inventory/presentation/cubit/inventory_enhanced_state.dart';
import 'package:lazervault/src/features/inventory/presentation/views/add_inventory_item_screen.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/presentation/cubit/customer_cubit.dart';
import 'package:lazervault/src/features/customers/presentation/views/add_customer_screen.dart';
import 'package:lazervault/src/features/payroll/domain/entities/employee_entity.dart';
import 'package:lazervault/src/features/payroll/presentation/cubit/payroll_cubit.dart';
import 'package:lazervault/src/features/payroll/presentation/views/add_employee_screen.dart';

/// Reusable "create a record inline, then hand it back selected" bottom sheets.
///
/// Every business interlink picker (Sell item/customer, Pay-run employee,
/// Purchase-order supplier/item, Expense supplier) is select-don't-type. When the
/// record the user needs isn't in the list yet, these helpers run the SAME create
/// flow the standalone Add screens use — hosted in a ~95%-height modal bottom
/// sheet — and resolve with the freshly created entity (or `null` if dismissed)
/// so the caller can auto-select it without leaving the flow.
///
/// The Add screens (`AddInventoryItemScreen`, `AddCustomerScreen`,
/// `AddEmployeeScreen`) already `Get.back(result: entity)` on success; hosted in a
/// sheet route that pops the sheet and completes the future here.

const Color _kBg = Color(0xFF0A0A0A);
const Color _kCard = Color(0xFF1F1F1F);
const Color _kBorder = Color(0xFF2D2D2D);
const Color _kLabel = Color(0xFF9CA3AF);
const Color _kHint = Color(0xFF6B7280);
const Color _kPrimary = Color(0xFF3B82F6);
const Color _kSuccess = Color(0xFF10B981);
const Color _kError = Color(0xFFEF4444);

/// Hosts [child] in a tall, rounded-top modal bottom sheet and returns whatever
/// the child pops with (its own `Get.back(result:)` / `Navigator.pop(value)`).
Future<T?> _hostSheet<T>(BuildContext context, Widget child) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => FractionallySizedBox(
      heightFactor: 0.95,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        child: child,
      ),
    ),
  );
}

/// Create an inventory item; resolves with the created [InventoryItemEntity].
Future<InventoryItemEntity?> showCreateInventoryItemSheet(BuildContext context) {
  return _hostSheet<InventoryItemEntity>(
    context,
    BlocProvider(
      create: (_) => serviceLocator<InventoryCubit>(),
      child: const AddInventoryItemScreen(),
    ),
  );
}

/// Create a customer; resolves with the created [CustomerEntity].
Future<CustomerEntity?> showCreateCustomerSheet(BuildContext context) {
  return _hostSheet<CustomerEntity>(
    context,
    BlocProvider(
      create: (_) => serviceLocator<CustomerCubit>(),
      child: const AddCustomerScreen(),
    ),
  );
}

/// Create an employee; resolves with the created [EmployeeEntity].
Future<EmployeeEntity?> showCreateEmployeeSheet(BuildContext context) {
  return _hostSheet<EmployeeEntity>(
    context,
    BlocProvider(
      create: (_) => serviceLocator<PayrollCubit>(),
      child: const AddEmployeeScreen(),
    ),
  );
}

/// Create a supplier; resolves with the created [SupplierEntity].
///
/// The standalone add-supplier UI is an inline dialog inside
/// `supplier_list_screen.dart` (not a reusable screen), so this sheet ships its
/// own compact form over the same `InventoryEnhancedCubit.createSupplier`.
Future<SupplierEntity?> showCreateSupplierSheet(BuildContext context) {
  return _hostSheet<SupplierEntity>(
    context,
    BlocProvider(
      create: (_) => serviceLocator<InventoryEnhancedCubit>(),
      child: const _CreateSupplierSheet(),
    ),
  );
}

class _CreateSupplierSheet extends StatefulWidget {
  const _CreateSupplierSheet();

  @override
  State<_CreateSupplierSheet> createState() => _CreateSupplierSheetState();
}

class _CreateSupplierSheetState extends State<_CreateSupplierSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _contact = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _notes = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _contact.dispose();
    _email.dispose();
    _phone.dispose();
    _address.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    context.read<InventoryEnhancedCubit>().createSupplier(
          name: _name.text.trim(),
          contactName: _contact.text.trim(),
          email: _email.text.trim(),
          phone: _phone.text.trim(),
          address: _address.text.trim(),
          notes: _notes.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InventoryEnhancedCubit, InventoryEnhancedState>(
      listener: (context, state) {
        if (state is SupplierCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Supplier "${state.supplier.name}" created'),
              backgroundColor: _kSuccess,
            ),
          );
          Navigator.of(context).pop(state.supplier);
        } else if (state is InventoryEnhancedError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: _kError),
          );
        }
      },
      child: BlocBuilder<InventoryEnhancedCubit, InventoryEnhancedState>(
        builder: (context, state) {
          final busy = state is InventoryEnhancedLoading;
          return Scaffold(
            backgroundColor: _kBg,
            appBar: AppBar(
              backgroundColor: _kBg,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close_rounded, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text('New supplier',
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700)),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                children: [
                  _field(_name, 'Supplier name', required: true),
                  _field(_contact, 'Contact person'),
                  _field(_email, 'Email',
                      keyboardType: TextInputType.emailAddress),
                  _field(_phone, 'Phone', keyboardType: TextInputType.phone),
                  _field(_address, 'Address'),
                  _field(_notes, 'Notes', maxLines: 3),
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.fromLTRB(16.w, 0, 16.w, 12.h),
              child: SizedBox(
                height: 52.h,
                child: ElevatedButton(
                  onPressed: busy ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _kPrimary,
                    disabledBackgroundColor: _kPrimary.withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: busy
                      ? SizedBox(
                          width: 20.w,
                          height: 20.w,
                          child: const CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text('Create supplier',
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _field(
    TextEditingController ctrl,
    String label, {
    bool required = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(required ? '$label *' : label,
              style: GoogleFonts.inter(color: _kLabel, fontSize: 12.sp)),
          SizedBox(height: 6.h),
          TextFormField(
            controller: ctrl,
            keyboardType: keyboardType,
            maxLines: maxLines,
            style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
            validator: required
                ? (v) => (v == null || v.trim().isEmpty)
                    ? '$label is required'
                    : null
                : null,
            decoration: InputDecoration(
              hintText: 'Enter $label'.toLowerCase(),
              hintStyle: GoogleFonts.inter(color: _kHint, fontSize: 13.sp),
              filled: true,
              fillColor: _kCard,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _kBorder),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _kPrimary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _kError),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: const BorderSide(color: _kError),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
