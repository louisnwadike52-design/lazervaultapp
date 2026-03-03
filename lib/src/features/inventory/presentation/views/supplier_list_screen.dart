import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/debouncer.dart';

import '../../domain/entities/supplier_entity.dart';
import '../cubit/inventory_enhanced_cubit.dart';
import '../cubit/inventory_enhanced_state.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  final _searchController = TextEditingController();
  final _debouncer = Debouncer.search();

  @override
  void initState() {
    super.initState();
    _loadSuppliers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  void _loadSuppliers() {
    context.read<InventoryEnhancedCubit>().listSuppliers(
          search: _searchController.text.isEmpty
              ? null
              : _searchController.text,
        );
  }

  void _onSearchChanged(String query) {
    setState(() {}); // Update suffixIcon visibility
    _debouncer.run(() {
      if (!mounted) return;
      _loadSuppliers();
    });
  }

  // ---------------------------------------------------------------------------
  // Add Supplier Dialog
  // ---------------------------------------------------------------------------

  void _showAddSupplierDialog() {
    final nameController = TextEditingController();
    final contactNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final addressController = TextEditingController();
    final notesController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Supplier',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20.h),
              _buildDialogField(
                controller: nameController,
                label: 'Company Name *',
                hint: 'Enter supplier name',
              ),
              SizedBox(height: 14.h),
              _buildDialogField(
                controller: contactNameController,
                label: 'Contact Person',
                hint: 'Enter contact name',
              ),
              SizedBox(height: 14.h),
              _buildDialogField(
                controller: emailController,
                label: 'Email',
                hint: 'supplier@email.com',
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 14.h),
              _buildDialogField(
                controller: phoneController,
                label: 'Phone',
                hint: '+234...',
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 14.h),
              _buildDialogField(
                controller: addressController,
                label: 'Address',
                hint: 'Enter address',
                maxLines: 2,
              ),
              SizedBox(height: 14.h),
              _buildDialogField(
                controller: notesController,
                label: 'Notes',
                hint: 'Additional notes...',
                maxLines: 3,
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
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
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          ScaffoldMessenger.of(dialogContext).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Supplier name is required',
                                style: GoogleFonts.inter(color: Colors.white),
                              ),
                              backgroundColor: const Color(0xFFEF4444),
                            ),
                          );
                          return;
                        }
                        Navigator.pop(dialogContext);
                        context
                            .read<InventoryEnhancedCubit>()
                            .createSupplier(
                              name: name,
                              contactName:
                                  contactNameController.text.trim(),
                              email: emailController.text.trim(),
                              phone: phoneController.text.trim(),
                              address: addressController.text.trim(),
                              notes: notesController.text.trim(),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3B82F6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Add',
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
    );
  }

  Widget _buildDialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
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
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
          decoration: InputDecoration(
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
              vertical: 12.h,
            ),
          ),
        ),
      ],
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
          'Suppliers',
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
            _buildSearchBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSupplierDialog,
        backgroundColor: const Color(0xFF3B82F6),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Bar
  // ---------------------------------------------------------------------------

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged,
        style: GoogleFonts.inter(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
          hintText: 'Search suppliers...',
          hintStyle: GoogleFonts.inter(
            color: const Color(0xFF6B7280),
            fontSize: 15.sp,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: const Color(0xFF9CA3AF),
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: const Color(0xFF9CA3AF),
                    size: 18.sp,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    _loadSuppliers();
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F1F1F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        ),
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
        if (state is SupplierCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Supplier "${state.supplier.name}" created',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadSuppliers();
        }
        if (state is SupplierDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Supplier deleted',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadSuppliers();
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

        if (state is SuppliersLoaded) {
          if (state.suppliers.isEmpty) {
            return _buildEmptyState();
          }

          return RefreshIndicator(
            onRefresh: () async => _loadSuppliers(),
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              itemCount: state.suppliers.length,
              itemBuilder: (context, index) =>
                  _buildSupplierCard(state.suppliers[index]),
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Supplier Card
  // ---------------------------------------------------------------------------

  Widget _buildSupplierCard(SupplierEntity supplier) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          // Avatar with initials
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Center(
              child: Text(
                supplier.initials,
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        supplier.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _buildStatusBadge(supplier),
                  ],
                ),
                SizedBox(height: 4.h),
                if (supplier.contactName.isNotEmpty)
                  Text(
                    supplier.contactName,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                if (supplier.email.isNotEmpty) ...[
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        color: const Color(0xFF6B7280),
                        size: 13.sp,
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          supplier.email,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF6B7280),
                            fontSize: 12.sp,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(SupplierEntity supplier) {
    final isActive = supplier.status == SupplierStatus.active;
    final color =
        isActive ? const Color(0xFF10B981) : const Color(0xFF9CA3AF);

    return Container(
      margin: EdgeInsets.only(left: 8.w),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        supplier.statusDisplay,
        style: GoogleFonts.inter(
          color: color,
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
      onRefresh: () async => _loadSuppliers(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 120.h),
          Icon(
            Icons.people_outline,
            color: const Color(0xFF2D2D2D),
            size: 64.sp,
          ),
          SizedBox(height: 16.h),
          Text(
            'No suppliers yet',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tap + to add your first supplier',
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
