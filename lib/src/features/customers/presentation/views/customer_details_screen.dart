import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_financial_profile_entity.dart';
import 'package:lazervault/src/features/customers/domain/entities/customer_note_entity.dart';
import '../cubit/customer_cubit.dart';
import '../cubit/customer_state.dart';

class CustomerDetailsScreen extends StatefulWidget {
  final CustomerEntity customer;

  const CustomerDetailsScreen({super.key, required this.customer});

  @override
  State<CustomerDetailsScreen> createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  late CustomerEntity _customer;
  CustomerFinancialProfileEntity? _financialProfile;
  List<CustomerNoteEntity> _notes = [];
  bool _profileLoading = false;
  bool _notesLoading = false;
  bool _didChange = false;

  @override
  void initState() {
    super.initState();
    _customer = widget.customer;
    _loadFinancialProfile();
    _loadNotes();
  }

  void _loadFinancialProfile() {
    setState(() => _profileLoading = true);
    context.read<CustomerCubit>().getFinancialProfile(_customer.id);
  }

  void _loadNotes() {
    setState(() => _notesLoading = true);
    context.read<CustomerCubit>().listNotes(customerId: _customer.id);
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Delete Customer',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            'Are you sure you want to delete "${_customer.name}"? This action cannot be undone.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<CustomerCubit>().deleteCustomer(_customer.id);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.inter(
                  color: const Color(0xFFEF4444),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddNoteDialog() {
    final noteController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F1F1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Add Note',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            controller: noteController,
            maxLines: 4,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
            ),
            decoration: InputDecoration(
              hintText: 'Enter your note...',
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
              contentPadding: EdgeInsets.all(12.w),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                final content = noteController.text.trim();
                if (content.isNotEmpty) {
                  Navigator.of(dialogContext).pop();
                  context.read<CustomerCubit>().addNote(
                        customerId: _customer.id,
                        content: content,
                      );
                }
              },
              child: Text(
                'Add',
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    ).then((_) => noteController.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerCubit, CustomerState>(
      listener: (context, state) {
        if (state is CustomerDeleted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Customer deleted',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          Get.back(result: true);
        } else if (state is FinancialProfileLoaded) {
          setState(() {
            _financialProfile = state.profile;
            _profileLoading = false;
          });
        } else if (state is NotesLoaded) {
          setState(() {
            _notes = state.notes;
            _notesLoading = false;
          });
        } else if (state is NoteAdded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Note added successfully',
                style: GoogleFonts.inter(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF10B981),
            ),
          );
          _loadNotes();
        } else if (state is CustomerError) {
          setState(() {
            _profileLoading = false;
            _notesLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(result: _didChange),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            'Customer Details',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                final result = await Get.toNamed(
                  AppRoutes.editCustomer,
                  arguments: _customer,
                );
                if (result == true && mounted) {
                  setState(() => _didChange = true);
                  context.read<CustomerCubit>().getCustomer(_customer.id);
                }
              },
              icon: Icon(
                Icons.edit_outlined,
                color: const Color(0xFF3B82F6),
                size: 22.sp,
              ),
              tooltip: 'Edit',
            ),
            IconButton(
              onPressed: _showDeleteConfirmation,
              icon: Icon(
                Icons.delete_outline,
                color: const Color(0xFFEF4444),
                size: 22.sp,
              ),
              tooltip: 'Delete',
            ),
          ],
        ),
        body: BlocListener<CustomerCubit, CustomerState>(
          listener: (context, state) {
            if (state is CustomerLoaded) {
              setState(() {
                _customer = state.customer;
                _didChange = true;
              });
              _loadFinancialProfile();
              _loadNotes();
            }
          },
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileHeader(),
                  SizedBox(height: 20.h),
                  _buildContactInfoSection(),
                  SizedBox(height: 16.h),
                  _buildBusinessInfoSection(),
                  SizedBox(height: 16.h),
                  _buildSegmentTagsSection(),
                  SizedBox(height: 16.h),
                  _buildFinancialProfileSection(),
                  SizedBox(height: 16.h),
                  _buildNotesSection(),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Profile Header
  // ---------------------------------------------------------------------------

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 8.h),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                _customer.initials,
                style: GoogleFonts.inter(
                  color: const Color(0xFF3B82F6),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            _customer.name,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          if (_customer.businessName.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(
              _customer.businessName,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          SizedBox(height: 10.h),
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: _customer.statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        _customer.statusDisplay,
        style: GoogleFonts.inter(
          color: _customer.statusColor,
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Contact Info Section
  // ---------------------------------------------------------------------------

  Widget _buildContactInfoSection() {
    final rows = <_DetailRow>[
      _DetailRow('Email', _customer.email),
      _DetailRow('Phone', _customer.phone),
      _DetailRow('Address', _customer.address),
      _DetailRow('City', _customer.city),
      _DetailRow('State', _customer.state),
      _DetailRow('Country', _customer.country),
    ];

    return _buildSectionCard(
      title: 'Contact Information',
      icon: Icons.contact_mail_outlined,
      rows: rows,
    );
  }

  // ---------------------------------------------------------------------------
  // Business Info Section
  // ---------------------------------------------------------------------------

  Widget _buildBusinessInfoSection() {
    final rows = <_DetailRow>[
      _DetailRow('TIN', _customer.tin),
      _DetailRow('Bank Name', _customer.bankName),
      _DetailRow('Bank Account', _customer.bankAccountNumber),
      _DetailRow('Bank Code', _customer.bankCode),
    ];

    return _buildSectionCard(
      title: 'Business Information',
      icon: Icons.business_outlined,
      rows: rows,
    );
  }

  // ---------------------------------------------------------------------------
  // Segment & Tags Section
  // ---------------------------------------------------------------------------

  Widget _buildSegmentTagsSection() {
    final hasSegment = _customer.segment != CustomerSegment.none;
    final hasTags = _customer.tags.isNotEmpty;

    if (!hasSegment && !hasTags) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.label_outlined,
                color: const Color(0xFF3B82F6),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Segment & Tags',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          if (hasSegment) ...[
            _buildDetailRow('Segment', _customer.segmentDisplay),
            if (hasTags) SizedBox(height: 12.h),
          ],
          if (hasTags)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tags',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: _customer.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color:
                            const Color(0xFF3B82F6).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        tag,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Financial Profile Section
  // ---------------------------------------------------------------------------

  Widget _buildFinancialProfileSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: const Color(0xFF3B82F6),
                size: 18.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Financial Profile',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          if (_profileLoading)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF3B82F6),
                  ),
                ),
              ),
            )
          else if (_financialProfile != null) ...[
            _buildDetailRow(
              'Total Invoiced',
              '\u20A6${_financialProfile!.totalInvoiced.toStringAsFixed(2)}',
            ),
            _buildDetailRow(
              'Total Paid',
              '\u20A6${_financialProfile!.totalPaid.toStringAsFixed(2)}',
              valueColor: const Color(0xFF10B981),
            ),
            _buildDetailRow(
              'Outstanding',
              '\u20A6${_financialProfile!.outstanding.toStringAsFixed(2)}',
              valueColor: _financialProfile!.outstanding > 0
                  ? const Color(0xFFFB923C)
                  : Colors.white,
            ),
            _buildDetailRow(
              'Avg Payment Days',
              '${_financialProfile!.avgPaymentDays} days',
              isLast: true,
            ),
          ] else
            Text(
              'Unable to load financial profile',
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 13.sp,
              ),
            ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Notes Section
  // ---------------------------------------------------------------------------

  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notes_outlined,
                  color: const Color(0xFF3B82F6),
                  size: 18.sp,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Notes',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: _showAddNoteDialog,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add,
                      color: const Color(0xFF3B82F6),
                      size: 16.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Add Note',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF3B82F6),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        if (_notesLoading)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: SizedBox(
                height: 20.h,
                width: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF3B82F6),
                ),
              ),
            ),
          )
        else if (_notes.isEmpty)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'No notes yet',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 14.sp,
              ),
            ),
          )
        else
          ...List.generate(_notes.length, (index) {
            return _buildNoteTile(_notes[index]);
          }),
      ],
    );
  }

  Widget _buildNoteTile(CustomerNoteEntity note) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            note.content,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (note.createdBy.isNotEmpty)
                Text(
                  note.createdBy,
                  style: GoogleFonts.inter(
                    color: const Color(0xFF6B7280),
                    fontSize: 11.sp,
                  ),
                ),
              Text(
                _formatDate(note.createdAt),
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Shared Widgets
  // ---------------------------------------------------------------------------

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<_DetailRow> rows,
  }) {
    final visibleRows = rows.where((r) => r.value.isNotEmpty).toList();
    if (visibleRows.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF3B82F6), size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                title,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          ...visibleRows.asMap().entries.map((entry) {
            final isLast = entry.key == visibleRows.length - 1;
            return _buildDetailRow(
              entry.value.label,
              entry.value.value,
              isLast: isLast,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value, {
    bool isLast = false,
    Color valueColor = Colors.white,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(width: 16.w),
          Flexible(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: valueColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime dt) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}

class _DetailRow {
  final String label;
  final String value;

  const _DetailRow(this.label, this.value);
}
