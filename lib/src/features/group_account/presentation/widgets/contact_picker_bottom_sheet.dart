import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactPickerBottomSheet extends StatefulWidget {
  final Function(String name, String identifier, ContactIdentifierType type)
      onContactSelected;

  /// Optional: Map of identifiers (email/phone) to indicate platform users
  /// Key is normalized identifier, value is user info (userId, userName)
  final Map<String, PlatformUserInfo>? platformUsers;

  const ContactPickerBottomSheet({
    super.key,
    required this.onContactSelected,
    this.platformUsers,
  });

  @override
  State<ContactPickerBottomSheet> createState() =>
      _ContactPickerBottomSheetState();
}

enum ContactIdentifierType { email, phone }

/// Info about a platform user matched from contacts
class PlatformUserInfo {
  final String userId;
  final String userName;
  final String? profileImage;

  const PlatformUserInfo({
    required this.userId,
    required this.userName,
    this.profileImage,
  });
}

class _ContactPickerBottomSheetState extends State<ContactPickerBottomSheet> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  bool _isLoading = true;
  bool _permissionDenied = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadContacts() async {
    setState(() {
      _isLoading = true;
      _permissionDenied = false;
    });

    // Request permission
    final permissionStatus = await Permission.contacts.request();

    if (permissionStatus.isGranted) {
      try {
        final contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: false,
        );

        setState(() {
          _contacts = contacts;
          _filteredContacts = contacts;
          _isLoading = false;
        });
      } catch (e) {
        print('Error loading contacts: $e');
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      setState(() {
        _permissionDenied = true;
        _isLoading = false;
      });
    }
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        final name = contact.displayName.toLowerCase();
        final hasMatchingEmail = contact.emails.any(
          (email) => email.address.toLowerCase().contains(query),
        );
        final hasMatchingPhone = contact.phones.any(
          (phone) => phone.number.toLowerCase().contains(query),
        );
        return name.contains(query) || hasMatchingEmail || hasMatchingPhone;
      }).toList();
    });
  }

  /// Check if any of the contact's identifiers match a platform user
  bool _isContactOnPlatform(Contact contact) {
    if (widget.platformUsers == null) return false;

    // Check emails
    for (final email in contact.emails) {
      final normalizedEmail = email.address.toLowerCase().trim();
      if (widget.platformUsers!.containsKey(normalizedEmail)) {
        return true;
      }
    }

    // Check phones
    for (final phone in contact.phones) {
      final normalizedPhone = _normalizePhone(phone.number);
      if (widget.platformUsers!.containsKey(normalizedPhone)) {
        return true;
      }
    }

    return false;
  }

  String _normalizePhone(String phone) {
    return phone.replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          if (_isLoading)
            Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: const Color.fromARGB(255, 78, 3, 208),
                ),
              ),
            )
          else if (_permissionDenied)
            Expanded(child: _buildPermissionDeniedView())
          else ...[
            _buildSearchBar(),
            Expanded(child: _buildContactList()),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 78, 3, 208),
            const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.contacts,
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
                  'Select Contact',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Choose from your contacts',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: TextField(
        controller: _searchController,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          hintText: 'Search contacts...',
          hintStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            color: Colors.grey[500],
          ),
          filled: true,
          fillColor: const Color(0xFF0A0A0A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 78, 3, 208),
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey[500],
            size: 20.sp,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey[500]),
                  onPressed: () => _searchController.clear(),
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildContactList() {
    if (_filteredContacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_off,
              size: 64.sp,
              color: Colors.grey[600],
            ),
            SizedBox(height: 16.h),
            Text(
              _searchController.text.isEmpty
                  ? 'No contacts found'
                  : 'No matching contacts',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    // Sort contacts: platform users first, then alphabetically
    final sortedContacts = List<Contact>.from(_filteredContacts);
    if (widget.platformUsers != null && widget.platformUsers!.isNotEmpty) {
      sortedContacts.sort((a, b) {
        final aOnPlatform = _isContactOnPlatform(a);
        final bOnPlatform = _isContactOnPlatform(b);

        if (aOnPlatform && !bOnPlatform) return -1;
        if (!aOnPlatform && bOnPlatform) return 1;
        return a.displayName.compareTo(b.displayName);
      });
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: sortedContacts.length,
      itemBuilder: (context, index) {
        final contact = sortedContacts[index];
        return _buildContactCard(contact);
      },
    );
  }

  Widget _buildContactCard(Contact contact) {
    final isOnPlatform = _isContactOnPlatform(contact);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isOnPlatform
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => _showContactDetailsDialog(contact),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color.fromARGB(255, 78, 3, 208),
                        const Color.fromARGB(255, 78, 3, 208)
                            .withValues(alpha: 0.7),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Center(
                    child: Text(
                      contact.displayName.isNotEmpty
                          ? contact.displayName[0].toUpperCase()
                          : '?',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              contact.displayName,
                              style: GoogleFonts.inter(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (isOnPlatform) ...[
                            SizedBox(width: 8.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 2.h),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFF10B981).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              child: Text(
                                'On LazerVault',
                                style: GoogleFonts.inter(
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: 4.h),
                      if (contact.emails.isNotEmpty)
                        Text(
                          contact.emails.first.address,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      else if (contact.phones.isNotEmpty)
                        Text(
                          contact.phones.first.number,
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.grey[400],
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContactDetailsDialog(Contact contact) {
    final isOnPlatform = _isContactOnPlatform(contact);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Select Contact Info',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            if (isOnPlatform) ...[
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: const Color(0xFF10B981),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'On LazerVault',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contact.displayName,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            if (contact.emails.isNotEmpty) ...[
              Text(
                'Email Addresses',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 8.h),
              ...contact.emails.map((email) => _buildSelectionTile(
                    icon: Icons.email,
                    label: email.address,
                    isOnPlatform: widget.platformUsers
                            ?.containsKey(email.address.toLowerCase().trim()) ??
                        false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.onContactSelected(
                        contact.displayName,
                        email.address,
                        ContactIdentifierType.email,
                      );
                    },
                  )),
              SizedBox(height: 12.h),
            ],
            if (contact.phones.isNotEmpty) ...[
              Text(
                'Phone Numbers',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 8.h),
              ...contact.phones.map((phone) => _buildSelectionTile(
                    icon: Icons.phone,
                    label: phone.number,
                    isOnPlatform: widget.platformUsers
                            ?.containsKey(_normalizePhone(phone.number)) ??
                        false,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      widget.onContactSelected(
                        contact.displayName,
                        phone.number,
                        ContactIdentifierType.phone,
                      );
                    },
                  )),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isOnPlatform = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isOnPlatform
              ? const Color(0xFF10B981).withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.r),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 78, 3, 208),
                  size: 18.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                      if (isOnPlatform) ...[
                        SizedBox(height: 2.h),
                        Text(
                          'LazerVault user',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (isOnPlatform)
                  Icon(
                    Icons.check_circle,
                    color: const Color(0xFF10B981),
                    size: 16.sp,
                  )
                else
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[600],
                    size: 14.sp,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionDeniedView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.block,
              size: 64.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 24.h),
            Text(
              'Permission Denied',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'LazerVault needs access to your contacts to help you quickly add members to your group.',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () async {
                await openAppSettings();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 78, 3, 208),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Open Settings',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
