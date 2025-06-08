import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fixnum/fixnum.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/funds/domain/entities/batch_transfer_entity.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/enhanced_recipient_selection_bottom_sheet.dart';

// Mock model classes for multi-selection
class LazertagUser {
  final String id;
  final String username;
  final String name;
  final String email;
  final String? avatar;
  final bool isOnline;
  final bool isVerified;

  LazertagUser({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    this.avatar,
    this.isOnline = false,
    this.isVerified = false,
  });
}

class DeviceContact {
  final String id;
  final String name;
  final String? phoneNumber;
  final String? email;
  final String initials;

  DeviceContact({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    required this.initials,
  });
}


class BatchRecipientItem {
  final RecipientModel recipient;
  final TextEditingController amountController;
  final TextEditingController referenceController;
  bool isExpanded;

  BatchRecipientItem({
    required this.recipient,
    String? initialAmount,
    String? initialReference,
    this.isExpanded = false,
  }) : amountController = TextEditingController(text: initialAmount ?? ''),
       referenceController = TextEditingController(text: initialReference ?? '');

  void dispose() {
    amountController.dispose();
    referenceController.dispose();
  }

  double get amount => double.tryParse(amountController.text) ?? 0.0;
  bool get isValid => amount > 0;
}

class MultiSelectRecipientBottomSheet extends StatefulWidget {
  final Function(List<RecipientModel>) onRecipientsSelected;
  final List<String> alreadySelectedIds;

  const MultiSelectRecipientBottomSheet({
    super.key,
    required this.onRecipientsSelected,
    required this.alreadySelectedIds,
  });

  @override
  State<MultiSelectRecipientBottomSheet> createState() => _MultiSelectRecipientBottomSheetState();
}

class _MultiSelectRecipientBottomSheetState extends State<MultiSelectRecipientBottomSheet> with TickerProviderStateMixin {
  late TabController _tabController;
  final List<RecipientModel> _tempSelectedRecipients = [];
  final List<LazertagUser> _lazertagResults = [];
  final List<DeviceContact> _deviceContacts = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoadingLazertag = false;
  bool _isLoadingContacts = false;
  String _searchQuery = '';
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _searchController.addListener(_onSearchChanged);
    _loadDeviceContacts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });

    if (_searchQuery.startsWith('@')) {
      _tabController.animateTo(1); // Switch to LazerTag tab
      _searchLazertagUsers(_searchQuery);
    }
  }

  Future<void> _searchLazertagUsers(String query) async {
    if (query.length < 2) {
      setState(() => _lazertagResults.clear());
      return;
    }

    setState(() => _isLoadingLazertag = true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      
      final mockResults = [
        LazertagUser(
          id: 'lz1',
          username: '@louis',
          name: 'Louis Lawrence',
          email: 'louis@example.com',
          isOnline: true,
          isVerified: true,
        ),
        LazertagUser(
          id: 'lz2',
          username: '@sarah',
          name: 'Sarah Johnson',
          email: 'sarah@example.com',
          isOnline: false,
          isVerified: true,
        ),
        LazertagUser(
          id: 'lz3',
          username: '@mike',
          name: 'Mike Davis',
          email: 'mike@example.com',
          isOnline: true,
          isVerified: false,
        ),
      ];

      final filteredResults = mockResults.where((user) =>
        user.username.toLowerCase().contains(query.toLowerCase().replaceAll('@', '')) ||
        user.name.toLowerCase().contains(query.toLowerCase())
      ).toList();

      setState(() {
        _lazertagResults.clear();
        _lazertagResults.addAll(filteredResults);
        _isLoadingLazertag = false;
      });
    } catch (e) {
      setState(() => _isLoadingLazertag = false);
    }
  }

  Future<void> _loadDeviceContacts() async {
    setState(() => _isLoadingContacts = true);

    try {
      await Future.delayed(const Duration(milliseconds: 800));
      
      final mockContacts = [
        DeviceContact(
          id: 'c1',
          name: 'Alice Cooper',
          phoneNumber: '+44 7700 900123',
          email: 'alice@example.com',
          initials: 'AC',
        ),
        DeviceContact(
          id: 'c2',
          name: 'Bob Smith',
          phoneNumber: '+44 7700 900456',
          email: 'bob@example.com',
          initials: 'BS',
        ),
        DeviceContact(
          id: 'c3',
          name: 'Charlie Brown',
          phoneNumber: '+44 7700 900789',
          email: 'charlie@example.com',
          initials: 'CB',
        ),
      ];

      setState(() {
        _deviceContacts.clear();
        _deviceContacts.addAll(mockContacts);
        _isLoadingContacts = false;
      });
    } catch (e) {
      setState(() => _isLoadingContacts = false);
    }
  }

  void _toggleRecipientSelection(RecipientModel recipient) {
    setState(() {
      if (_tempSelectedRecipients.any((r) => r.id == recipient.id)) {
        _tempSelectedRecipients.removeWhere((r) => r.id == recipient.id);
      } else {
        _tempSelectedRecipients.add(recipient);
      }
    });
  }

  void _handleLazertagUserSelection(LazertagUser user) {
    final recipient = RecipientModel(
      id: user.id,
      name: user.name,
      accountNumber: user.username,
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
    );
    _toggleRecipientSelection(recipient);
  }

  void _handleContactSelection(DeviceContact contact) {
    // Show dialog to convert contact to recipient
    _showAddContactAsRecipientDialog(contact);
  }

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    final nameController = TextEditingController(text: contact.name);
    final accountController = TextEditingController();
    final bankController = TextEditingController();
    final sortCodeController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A3E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          'Add Contact as Recipient',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: accountController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Account Number',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: sortCodeController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Sort Code',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: bankController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Bank Name',
                labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(color: Colors.grey[400]),
            ),
          ),
          TextButton(
            onPressed: () {
              if (accountController.text.isNotEmpty && 
                  sortCodeController.text.isNotEmpty &&
                  bankController.text.isNotEmpty) {
                final recipient = RecipientModel(
                  id: contact.id,
                  name: nameController.text,
                  accountNumber: accountController.text,
                  bankName: bankController.text,
                  sortCode: sortCodeController.text,
                  isFavorite: false,
                );
                Navigator.pop(dialogContext);
                _toggleRecipientSelection(recipient);
              }
            },
            child: Text(
              'Add',
              style: GoogleFonts.inter(color: Colors.blue[400]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A3E),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          
          // Header
          Container(
            padding: EdgeInsets.all(24.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.blue[600]!.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.group_add,
                    color: Colors.blue[400],
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Recipients",
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "Choose from saved, @username or contacts",
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_tempSelectedRecipients.isNotEmpty)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      '${_tempSelectedRecipients.length}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Search Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search recipients or @username...',
                hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
          ),

          SizedBox(height: 16.h),

                     // Tab Bar
           Container(
             margin: EdgeInsets.symmetric(horizontal: 24.w),
             decoration: BoxDecoration(
               color: Colors.white.withOpacity(0.05),
               borderRadius: BorderRadius.circular(12.r),
             ),
             child: TabBar(
               controller: _tabController,
               indicator: BoxDecoration(
                 color: Colors.blue[600],
                 borderRadius: BorderRadius.circular(10.r),
               ),
               indicatorPadding: EdgeInsets.all(2.w),
               labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
               dividerHeight: 0,
               labelColor: Colors.white,
               unselectedLabelColor: Colors.grey[400],
               labelStyle: GoogleFonts.inter(
                 fontSize: 12.sp,
                 fontWeight: FontWeight.w600,
               ),
               tabs: [
                 Tab(
                   height: 40.h,
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.people_outline, size: 14.sp),
                         SizedBox(width: 4.w),
                         Text('Saved'),
                       ],
                     ),
                   ),
                 ),
                 Tab(
                   height: 40.h,
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.alternate_email, size: 14.sp),
                         SizedBox(width: 4.w),
                         Text('username'),
                       ],
                     ),
                   ),
                 ),
                 Tab(
                   height: 40.h,
                   child: Container(
                     padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                     child: Row(
                       mainAxisSize: MainAxisSize.min,
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.contacts_outlined, size: 14.sp),
                         SizedBox(width: 4.w),
                         Text('Contacts'),
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),

          SizedBox(height: 16.h),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSavedRecipientsTab(),
                _buildLazertagTab(),
                _buildContactsTab(),
              ],
            ),
          ),

          // Bottom Actions
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A3E),
              border: Border(
                top: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[400],
                      side: BorderSide(color: Colors.grey[600]!),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _tempSelectedRecipients.isEmpty ? null : () {
                      widget.onRecipientsSelected(_tempSelectedRecipients);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _tempSelectedRecipients.isEmpty ? Colors.grey[700] : Colors.blue[600],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      _tempSelectedRecipients.isEmpty 
                        ? 'Select Recipients'
                        : 'Add ${_tempSelectedRecipients.length} Recipients',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }

  Widget _buildSavedRecipientsTab() {
    return BlocBuilder<RecipientCubit, RecipientState>(
      builder: (context, state) {
        if (state is RecipientLoading) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue[400]),
          );
        } else if (state is RecipientLoaded) {
          final filteredRecipients = _searchQuery.isEmpty 
            ? state.recipients
            : state.recipients.where((r) => 
                r.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                r.accountNumber.contains(_searchQuery)
              ).toList();

          if (filteredRecipients.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, color: Colors.grey[400], size: 48.sp),
                  SizedBox(height: 16.h),
                  Text(
                    _searchQuery.isEmpty ? 'No saved recipients' : 'No recipients found',
                    style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            itemCount: filteredRecipients.length,
            itemBuilder: (context, index) {
              final recipient = filteredRecipients[index];
              final isSelected = _tempSelectedRecipients.any((r) => r.id == recipient.id);
              final isAlreadyAdded = widget.alreadySelectedIds.contains(recipient.id);
              
              return _buildRecipientItem(
                recipient: recipient,
                isSelected: isSelected,
                isAlreadyAdded: isAlreadyAdded,
                onTap: isAlreadyAdded ? null : () => _toggleRecipientSelection(recipient),
              );
            },
          );
        }
        return Center(
          child: Text(
            'No recipients available',
            style: GoogleFonts.inter(color: Colors.grey[400]),
          ),
        );
      },
    );
  }

  Widget _buildLazertagTab() {
    if (_isLoadingLazertag) {
      return Center(
        child: CircularProgressIndicator(color: Colors.blue[400]),
      );
    }

    if (_searchQuery.isEmpty || !_searchQuery.startsWith('@')) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.alternate_email, color: Colors.grey[400], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'Search LazerTag Users',
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              'Type @username to find LazerVault users',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Wrap(
              spacing: 8.w,
              children: ['@louis', '@sarah', '@mike'].map((username) {
                return GestureDetector(
                  onTap: () => _searchController.text = username,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.blue[600]!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      username,
                      style: GoogleFonts.inter(color: Colors.blue[400], fontSize: 12.sp),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    }

    if (_lazertagResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, color: Colors.grey[400], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              'No users found',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: _lazertagResults.length,
      itemBuilder: (context, index) {
        final user = _lazertagResults[index];
        final recipient = RecipientModel(
          id: user.id,
          name: user.name,
          accountNumber: user.username,
          bankName: 'LazerVault',
          sortCode: '',
          isFavorite: false,
        );
        final isSelected = _tempSelectedRecipients.any((r) => r.id == user.id);
        final isAlreadyAdded = widget.alreadySelectedIds.contains(user.id);
        
        return _buildLazertagUserItem(
          user: user,
          isSelected: isSelected,
          isAlreadyAdded: isAlreadyAdded,
          onTap: isAlreadyAdded ? null : () => _handleLazertagUserSelection(user),
        );
      },
    );
  }

  Widget _buildContactsTab() {
    if (_isLoadingContacts) {
      return Center(
        child: CircularProgressIndicator(color: Colors.blue[400]),
      );
    }

    final filteredContacts = _searchQuery.isEmpty 
      ? _deviceContacts
      : _deviceContacts.where((c) => 
          c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (c.phoneNumber?.contains(_searchQuery) ?? false)
        ).toList();

    if (filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contacts_outlined, color: Colors.grey[400], size: 48.sp),
            SizedBox(height: 16.h),
            Text(
              _searchQuery.isEmpty ? 'No contacts available' : 'No contacts found',
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        
        return _buildContactItem(
          contact: contact,
          onTap: () => _handleContactSelection(contact),
        );
      },
    );
  }

  Widget _buildRecipientItem({
    required RecipientModel recipient,
    required bool isSelected,
    required bool isAlreadyAdded,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected 
                ? Colors.blue[600]!.withOpacity(0.15)
                : isAlreadyAdded
                  ? Colors.grey[800]!.withOpacity(0.3)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected 
                  ? Colors.blue[400]!
                  : isAlreadyAdded
                    ? Colors.grey[600]!
                    : Colors.white.withOpacity(0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isAlreadyAdded 
                        ? [Colors.grey[700]!, Colors.grey[600]!]
                        : [Colors.blue[600]!, Colors.blue[400]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      recipient.name.isNotEmpty 
                        ? recipient.name.substring(0, 1).toUpperCase()
                        : '?',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.name,
                        style: GoogleFonts.inter(
                          color: isAlreadyAdded ? Colors.grey[500] : Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            recipient.bankName,
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[600] : Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            ' • ',
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[600] : Colors.grey[500],
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            recipient.accountNumber.length > 4
                              ? '••• ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}'
                              : recipient.accountNumber,
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[600] : Colors.grey[400],
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Selection Indicator
                if (isAlreadyAdded)
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  )
                else if (isSelected)
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[600]!.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  )
                else
                  Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500]!,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLazertagUserItem({
    required LazertagUser user,
    required bool isSelected,
    required bool isAlreadyAdded,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isSelected 
                ? Colors.blue[600]!.withOpacity(0.15)
                : isAlreadyAdded
                  ? Colors.grey[800]!.withOpacity(0.3)
                  : Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected 
                  ? Colors.blue[400]!
                  : isAlreadyAdded
                    ? Colors.grey[600]!
                    : Colors.white.withOpacity(0.1),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isAlreadyAdded 
                        ? [Colors.grey[700]!, Colors.grey[600]!]
                        : [Colors.purple[600]!, Colors.purple[400]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      user.name.isNotEmpty 
                        ? user.name.substring(0, 1).toUpperCase()
                        : '@',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.name,
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[500] : Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (user.isVerified) ...[
                            SizedBox(width: 6.w),
                            Icon(
                              Icons.verified,
                              color: Colors.blue[400],
                              size: 16.sp,
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            user.username,
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[600] : Colors.purple[400],
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 6.w,
                            height: 6.h,
                            decoration: BoxDecoration(
                              color: user.isOnline ? Colors.green[400] : Colors.grey[600],
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            user.isOnline ? 'Online' : 'Offline',
                            style: GoogleFonts.inter(
                              color: isAlreadyAdded ? Colors.grey[600] : Colors.grey[400],
                              fontSize: 11.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Selection Indicator
                if (isAlreadyAdded)
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  )
                else if (isSelected)
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[600]!.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  )
                else
                  Container(
                    width: 28.w,
                    height: 28.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[500]!,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required DeviceContact contact,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[600]!, Colors.green[400]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      contact.initials,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (contact.phoneNumber != null) ...[
                        SizedBox(height: 4.h),
                        Text(
                          contact.phoneNumber!,
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                // Add Icon
                Icon(
                  Icons.person_add_outlined,
                  color: Colors.green[400],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BatchTransferForm extends StatefulWidget {
  final List<dynamic>? preSelectedRecipients;
  final bool isRepeatTransaction;
  final String? batchReference;

  const BatchTransferForm({
    super.key,
    this.preSelectedRecipients,
    this.isRepeatTransaction = false,
    this.batchReference,
  });

  @override
  State<BatchTransferForm> createState() => _BatchTransferFormState();
}

class _BatchTransferFormState extends State<BatchTransferForm> with TickerProviderStateMixin {
  final List<BatchRecipientItem> _selectedRecipients = [];
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _batchReferenceController = TextEditingController();
  final TextEditingController _bulkAmountController = TextEditingController();
  final TextEditingController _bulkReferenceController = TextEditingController();
  
  double _totalAmount = 0.0;
  final bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadRecipients();
    
    // Set batch reference if provided
    if (widget.batchReference != null) {
      _batchReferenceController.text = widget.batchReference!;
    }
    
    // Populate pre-selected recipients after a short delay to ensure widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populatePreSelectedRecipients();
    });
  }

  @override
  void dispose() {
    for (var recipient in _selectedRecipients) {
      recipient.dispose();
    }
    _categoryController.dispose();
    _batchReferenceController.dispose();
    _bulkAmountController.dispose();
    _bulkReferenceController.dispose();
    super.dispose();
  }

  void _loadRecipients() {
    final authState = context.read<AuthenticationCubit>().state;
    if (authState is AuthenticationSuccess) {
      context.read<RecipientCubit>().getRecipients(accessToken: authState.profile.session.accessToken);
    }
  }

  void _populatePreSelectedRecipients() {
    if (widget.preSelectedRecipients != null && widget.preSelectedRecipients!.isNotEmpty) {
      setState(() {
        // Clear any existing recipients first
        _selectedRecipients.clear();
        
        for (var recipientData in widget.preSelectedRecipients!) {
          final recipient = RecipientModel(
            id: recipientData['id'] ?? '1',
            name: recipientData['name'] ?? 'Unknown',
            accountNumber: recipientData['accountNumber'] ?? '',
            bankName: recipientData['bankName'] ?? 'Bank',
            sortCode: recipientData['sortCode'] ?? '',
            isFavorite: recipientData['isFavorite'] ?? false,
          );

          final recipientItem = BatchRecipientItem(
            recipient: recipient,
            initialAmount: recipientData['amount']?.toString() ?? '',
            initialReference: recipientData['reference'] ?? '',
          );

          _selectedRecipients.add(recipientItem);
        }
        
        // Calculate total after adding recipients
        _calculateTotal();
      });
      
      // Force a rebuild after a frame to ensure UI updates
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {});
        }
      });

      // Show confirmation message
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.white),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'Loaded ${widget.preSelectedRecipients!.length} recipients from previous transaction',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.green[600],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              duration: Duration(seconds: 3),
            ),
          );
        }
      });
    }
  }

  void _calculateTotal() {
    double total = 0.0;
    for (var recipient in _selectedRecipients) {
      total += recipient.amount;
    }
    setState(() {
      _totalAmount = total;
    });
  }

  void _showMultipleRecipientSelection() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: context.read<RecipientCubit>(),
        child: MultiSelectRecipientBottomSheet(
          onRecipientsSelected: (recipients) {
            setState(() {
              for (var recipient in recipients) {
                _selectedRecipients.add(BatchRecipientItem(recipient: recipient));
              }
              _calculateTotal();
            });
            
            // Show bulk amount dialog if multiple recipients were added
            if (recipients.length > 1) {
              _showBulkAmountDialog(recipients.length);
            }
          },
          alreadySelectedIds: _selectedRecipients.map((r) => r.recipient.id).toList(),
        ),
      ),
    );
  }

  void _showBulkAmountDialog(int recipientCount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1A1A3E),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          contentPadding: EdgeInsets.all(24.w),
          title: Container(
            padding: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                  width: 1,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue[600]!.withValues(alpha: 0.2),
                    Colors.blue[400]!.withValues(alpha: 0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: Colors.blue[400]!.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[600]!, Colors.blue[500]!],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue[600]!.withValues(alpha: 0.4),
                          blurRadius: 12,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.payments,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bulk Amount Setup',
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Apply same amount & reference to $recipientCount recipients',
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              
              // Enhanced Amount Input
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _bulkAmountController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  onChanged: (value) => setDialogState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Amount per recipient',
                    labelStyle: GoogleFonts.inter(
                      color: Colors.grey[300],
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: '0.00',
                    hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                    prefixText: '£ ',
                    prefixStyle: GoogleFonts.inter(
                      color: Colors.green[400],
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: Colors.orange[400]!,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16.h),
              
              // Enhanced Reference Input
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _bulkReferenceController,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Reference (Optional)',
                    labelStyle: GoogleFonts.inter(
                      color: Colors.grey[300],
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: 'e.g., Monthly allowance',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey[500],
                      fontSize: 14.sp,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.08),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: Colors.white.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide(
                        color: Colors.orange[400]!,
                        width: 2,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 18.h,
                    ),
                  ),
                ),
              ),
              
              // Enhanced Total Preview
              if (_bulkAmountController.text.isNotEmpty && 
                  double.tryParse(_bulkAmountController.text) != null)
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.green[600]!.withOpacity(0.2),
                          Colors.green[400]!.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: Colors.green[400]!.withOpacity(0.4),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Per recipient:',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              '£${double.parse(_bulkAmountController.text).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: Colors.green[300],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Container(
                          height: 1,
                          color: Colors.white.withOpacity(0.2),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total for $recipientCount recipients:',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '£${(double.parse(_bulkAmountController.text) * recipientCount).toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                color: Colors.green[300],
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _bulkAmountController.clear();
                      _bulkReferenceController.clear();
                      Navigator.pop(dialogContext);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey[400],
                      side: BorderSide(color: Colors.grey[600]!),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: _bulkAmountController.text.isNotEmpty &&
                        double.tryParse(_bulkAmountController.text) != null &&
                        double.parse(_bulkAmountController.text) > 0
                      ? () {
                          // Apply amount and reference to all recipients
                          for (int i = 0; i < _selectedRecipients.length; i++) {
                            _selectedRecipients[i].amountController.text = _bulkAmountController.text;
                            if (_bulkReferenceController.text.isNotEmpty) {
                              _selectedRecipients[i].referenceController.text = _bulkReferenceController.text;
                            }
                          }
                          
                          setState(() {
                            _calculateTotal();
                          });
                          
                          _bulkAmountController.clear();
                          _bulkReferenceController.clear();
                          Navigator.pop(dialogContext);
                          
                          // Show success feedback
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Applied £${double.parse(_bulkAmountController.text).toStringAsFixed(2)} to all $recipientCount recipients',
                                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                              ),
                              backgroundColor: Colors.green[600],
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                          );
                        }
                      : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _bulkAmountController.text.isNotEmpty &&
                          double.tryParse(_bulkAmountController.text) != null &&
                          double.parse(_bulkAmountController.text) > 0
                        ? Colors.orange[600]
                        : Colors.grey[700],
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Apply to All',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _removeRecipient(int index) {
    setState(() {
      _selectedRecipients[index].dispose();
      _selectedRecipients.removeAt(index);
      _calculateTotal();
    });
  }

  void _toggleRecipientExpansion(int index) {
    setState(() {
      _selectedRecipients[index].isExpanded = !_selectedRecipients[index].isExpanded;
    });
  }

  bool get _canProceed {
    return _selectedRecipients.isNotEmpty && _selectedRecipients.every((r) => r.isValid);
  }

  void _proceedToBatchTransfer() {
    if (!_canProceed) return;

    final recipients = _selectedRecipients.map((item) {
      return BatchTransferRecipient(
        recipientId: Int64.parseInt(item.recipient.id),
        amount: Int64((item.amount * 100).round()),
        reference: item.referenceController.text.isNotEmpty ? item.referenceController.text : null,
        category: _categoryController.text.isNotEmpty ? _categoryController.text : null,
      );
    }).toList();

    Get.toNamed(AppRoutes.batchTransferProcessing, arguments: {
      'recipients': recipients,
      'recipientItems': _selectedRecipients,
      'totalAmount': _totalAmount,
      'category': _categoryController.text,
      'batchReference': _batchReferenceController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Batch Details Section
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batch Details',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _batchReferenceController,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Batch Reference (Optional)',
                    labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                    hintText: 'e.g., Monthly Allowances',
                    hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.blue[400]!),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                TextFormField(
                  controller: _categoryController,
                  style: GoogleFonts.inter(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Category (Optional)',
                    labelStyle: GoogleFonts.inter(color: Colors.grey[400]),
                    hintText: 'e.g., Salary, Commission',
                    hintStyle: GoogleFonts.inter(color: Colors.grey[600]),
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.05),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide(color: Colors.blue[400]!),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(height: 24.h),
          
          // Recipients Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recipients (${_selectedRecipients.length})',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _showMultipleRecipientSelection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                ),
                icon: Icon(Icons.group_add, size: 18.sp),
                label: Text(
                  'Add Recipients',
                  style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),

          // Bulk Amount Button (only show if there are recipients)
          if (_selectedRecipients.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue[600]!.withValues(alpha: 0.15),
                      Colors.blue[400]!.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: Colors.blue[400]!.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showBulkAmountDialog(_selectedRecipients.length),
                    borderRadius: BorderRadius.circular(16.r),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue[600]!, Colors.blue[500]!],
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue[600]!.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.attach_money,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Set Amount for All',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'Apply same amount to ${_selectedRecipients.length} recipients',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey[400],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.blue[400],
                            size: 16.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          
          SizedBox(height: 16.h),
          
          // Recipients List or Empty State
          if (_selectedRecipients.isEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(32.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.blue[600]!.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.group_add,
                      color: Colors.blue[400],
                      size: 32.sp,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No recipients selected',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Add multiple recipients to start your batch transfer',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _selectedRecipients.length,
              itemBuilder: (context, index) => _buildRecipientCard(index),
            ),
          
          SizedBox(height: 24.h),
          
          // Total Amount Section
          if (_selectedRecipients.isNotEmpty)
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[600]!.withValues(alpha: 0.2), Colors.blue[400]!.withValues(alpha: 0.1)],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.blue[400]!.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Amount',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${_selectedRecipients.length} recipients',
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '£${_totalAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          
          SizedBox(height: 32.h),
          
          // Proceed Button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: _canProceed ? _proceedToBatchTransfer : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: _canProceed ? Colors.blue[600] : Colors.grey[700],
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: _isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    _selectedRecipients.isEmpty 
                      ? 'Add Recipients to Continue'
                      : 'Continue to Review (${_selectedRecipients.length} recipients)',
                    style: GoogleFonts.inter(
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

  Widget _buildRecipientCard(int index) {
    final recipientItem = _selectedRecipients[index];
    final recipient = recipientItem.recipient;
    final isLazerTag = recipient.bankName == 'LazerVault';
    
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2A2A5A).withOpacity(0.9),
            const Color(0xFF1E1E4A).withOpacity(0.95),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: recipientItem.isValid 
            ? Colors.green.withOpacity(0.5) 
            : recipientItem.amount == 0 
              ? Colors.orange.withOpacity(0.5)
              : Colors.red.withOpacity(0.5),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
          BoxShadow(
            color: (recipientItem.isValid ? Colors.green : Colors.orange).withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Enhanced Main Card Content
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _toggleRecipientExpansion(index),
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    // Header Row with Remove Button
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Enhanced Avatar with dynamic styling
                        Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: isLazerTag
                                ? [Colors.purple[600]!, Colors.purple[400]!]
                                : [Colors.blue[600]!, Colors.blue[400]!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (isLazerTag ? Colors.purple[600]! : Colors.blue[600]!).withOpacity(0.4),
                                blurRadius: 12,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Center(
                            child: isLazerTag
                              ? Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                  size: 26.sp,
                                )
                              : Text(
                                  recipient.name.isNotEmpty 
                                    ? recipient.name.substring(0, 1).toUpperCase()
                                    : '?',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        
                        // Enhanced Details Section
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Name Row with LazerTag badge
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      recipient.name,
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  if (isLazerTag) ...[
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.purple[600]!, Colors.purple[400]!],
                                        ),
                                        borderRadius: BorderRadius.circular(12.r),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple[600]!.withOpacity(0.3),
                                            blurRadius: 4,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'LazerTag',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              SizedBox(height: 8.h),
                              
                              // Bank info row
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                    decoration: BoxDecoration(
                                      color: isLazerTag 
                                        ? Colors.purple[600]!.withOpacity(0.3)
                                        : Colors.blue[600]!.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                        color: isLazerTag 
                                          ? Colors.purple[400]!.withOpacity(0.6)
                                          : Colors.blue[400]!.withOpacity(0.6),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      recipient.bankName,
                                      style: GoogleFonts.inter(
                                        color: isLazerTag ? Colors.purple[200] : Colors.blue[200],
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.w),
                                  Expanded(
                                    child: Text(
                                      isLazerTag
                                        ? recipient.accountNumber
                                        : recipient.accountNumber.length > 4
                                            ? '••• ${recipient.accountNumber.substring(recipient.accountNumber.length - 4)}'
                                            : recipient.accountNumber,
                                      style: GoogleFonts.inter(
                                        color: Colors.grey[300],
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        
                        // Small Remove Button in Top Right Corner
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _removeRecipient(index),
                            borderRadius: BorderRadius.circular(8.r),
                            child: Container(
                              padding: EdgeInsets.all(6.w),
                              decoration: BoxDecoration(
                                color: Colors.red[600]!.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: Colors.red[400]!.withOpacity(0.4),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.red[300],
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 16.h),
                    
                    // Bottom Row with Amount and Expand Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Enhanced Amount Display with Status
                        if (recipientItem.amount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.green[600]!, Colors.green[400]!],
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green[600]!.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  '£${recipientItem.amount.toStringAsFixed(2)}',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange[600]!, Colors.orange[400]!],
                              ),
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.orange[600]!.withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  color: Colors.white,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'Set amount',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        
                        // Enhanced Expand Button
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _toggleRecipientExpansion(index),
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.25),
                                  width: 1,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                recipientItem.isExpanded ? Icons.done_rounded : Icons.edit_rounded,
                                color: Colors.white,
                                size: 16.sp,
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
          
          // Enhanced Expanded Content with Improved Animation
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            height: recipientItem.isExpanded ? null : 0,
            child: recipientItem.isExpanded
              ? Container(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.2),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      
                      // Enhanced Amount Input
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: recipientItem.amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          onChanged: (value) => _calculateTotal(),
                          decoration: InputDecoration(
                            labelText: 'Amount',
                            labelStyle: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: '0.00',
                            hintStyle: GoogleFonts.inter(color: Colors.grey[500]),
                            prefixText: '£ ',
                            prefixStyle: GoogleFonts.inter(
                              color: Colors.green[400],
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                            ),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: Colors.blue[400]!,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 18.h,
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(height: 16.h),
                      
                      // Enhanced Reference Input
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: recipientItem.referenceController,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Reference (Optional)',
                            labelStyle: GoogleFonts.inter(
                              color: Colors.grey[300],
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            hintText: 'e.g., Payment for services',
                            hintStyle: GoogleFonts.inter(
                              color: Colors.grey[500],
                              fontSize: 14.sp,
                            ),
                            filled: true,
                            fillColor: Colors.white.withValues(alpha: 0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.3),
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.r),
                              borderSide: BorderSide(
                                color: Colors.blue[400]!,
                                width: 2,
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 18.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
} 