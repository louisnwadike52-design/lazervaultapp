import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../currency_exchange/domain/entities/recipient_entity.dart';
import '../../../currency_exchange/domain/entities/currency_entity.dart';
import '../../../currency_exchange/data/currency_data.dart';

class RecipientManagementScreen extends StatefulWidget {
  const RecipientManagementScreen({super.key});

  @override
  State<RecipientManagementScreen> createState() => _RecipientManagementScreenState();
}

class _RecipientManagementScreenState extends State<RecipientManagementScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  final TextEditingController _searchController = TextEditingController();
  List<Recipient> _allRecipients = [];
  List<Recipient> _filteredRecipients = [];
  RecipientType? _selectedFilter;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
    
    _loadMockRecipients();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _loadMockRecipients() {
    _allRecipients = [
      Recipient(
        id: '1',
        name: 'John Smith',
        email: 'john.smith@email.com',
        phone: '+1234567890',
        accountNumber: '1234567890',
        bankName: 'Chase Bank',
        swiftCode: 'CHASUS33',
        countryCode: 'US',
        currency: 'USD',
        address: '123 Main St',
        city: 'New York',
        state: 'NY',
        postalCode: '10001',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        lastUsed: DateTime.now().subtract(const Duration(days: 1)),
        type: RecipientType.frequent,
        isFavorite: true,
      ),
      Recipient(
        id: '2',
        name: 'Emma Johnson',
        email: 'emma.johnson@email.com',
        phone: '+447123456789',
        accountNumber: '12345678',
        bankName: 'Barclays',
        swiftCode: 'BARCGB22',
        countryCode: 'GB',
        currency: 'GBP',
        address: '456 Oxford St',
        city: 'London',
        postalCode: 'W1C 1AP',
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        lastUsed: DateTime.now().subtract(const Duration(days: 3)),
        type: RecipientType.saved,
        isFavorite: false,
      ),
      Recipient(
        id: '3',
        name: 'Marie Dubois',
        email: 'marie.dubois@email.com',
        phone: '+33123456789',
        accountNumber: 'FR1420041010050500013M02606',
        bankName: 'BNP Paribas',
        swiftCode: 'BNPAFRPP',
        countryCode: 'FR',
        currency: 'EUR',
        address: '789 Champs-Élysées',
        city: 'Paris',
        postalCode: '75008',
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        lastUsed: DateTime.now().subtract(const Duration(days: 7)),
        type: RecipientType.contact,
        isFavorite: true,
      ),
      Recipient(
        id: '4',
        name: 'Hiroshi Tanaka',
        email: 'hiroshi.tanaka@email.com',
        phone: '+81312345678',
        accountNumber: '1234567',
        bankName: 'Mitsubishi UFJ Bank',
        swiftCode: 'BOTKJPJT',
        countryCode: 'JP',
        currency: 'JPY',
        address: '1-1-1 Shibuya',
        city: 'Tokyo',
        postalCode: '150-0002',
        createdAt: DateTime.now().subtract(const Duration(days: 20)),
        lastUsed: DateTime.now().subtract(const Duration(days: 10)),
        type: RecipientType.manual,
        isFavorite: false,
      ),
    ];
    
    _filteredRecipients = List.from(_allRecipients);
    setState(() {});
  }

  void _filterRecipients() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipients = _allRecipients.where((recipient) {
        final matchesSearch = query.isEmpty ||
            recipient.name.toLowerCase().contains(query) ||
            recipient.email.toLowerCase().contains(query) ||
            recipient.bankName.toLowerCase().contains(query);
        
        final matchesFilter = _selectedFilter == null || recipient.type == _selectedFilter;
        
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F23),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A3E),
              const Color(0xFF0F0F23),
              const Color(0xFF0A0A1A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSearchAndFilter(),
              _buildFilterChips(),
              Expanded(
                child: _buildRecipientsList(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Row(
          children: [
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recipients',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    '${_filteredRecipients.length} recipients',
                    style: GoogleFonts.inter(
                      color: Colors.grey[400],
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: IconButton(
                icon: Icon(Icons.sort, color: Colors.white, size: 20.sp),
                onPressed: () => _showSortOptions(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search recipients...',
                hintStyle: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 16.sp,
                ),
              ),
              onChanged: (_) => _filterRecipients(),
            ),
          ),
          if (_searchController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
                _filterRecipients();
              },
              child: Icon(Icons.clear, color: Colors.grey[400], size: 20.sp),
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: [
          _buildFilterChip('All', null),
          SizedBox(width: 8.w),
          _buildFilterChip('Favorites', RecipientType.frequent),
          SizedBox(width: 8.w),
          _buildFilterChip('Saved', RecipientType.saved),
          SizedBox(width: 8.w),
          _buildFilterChip('Contacts', RecipientType.contact),
          SizedBox(width: 8.w),
          _buildFilterChip('Manual', RecipientType.manual),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, RecipientType? type) {
    final isSelected = _selectedFilter == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = isSelected ? null : type;
        });
        _filterRecipients();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.grey[900],
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.white.withOpacity(0.1),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildRecipientsList() {
    if (_filteredRecipients.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: _filteredRecipients.length,
      itemBuilder: (context, index) {
        final recipient = _filteredRecipients[index];
        return _buildRecipientCard(recipient, index);
      },
    );
  }

  Widget _buildRecipientCard(Recipient recipient, int index) {
    final currency = CurrencyData.getCurrencyByCode(recipient.currency);
    
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.white.withOpacity(0.1)),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: () => _showRecipientDetails(recipient),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 56.w,
                        height: 56.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.blue[700]!, Colors.blue[500]!],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            recipient.initials,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      if (recipient.isFavorite)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[900]!, width: 2),
                            ),
                            child: Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 10.sp,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                recipient.name,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            if (currency != null) ...[
                              Container(
                                width: 24.w,
                                height: 16.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2.r),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(2.r),
                                  child: CachedNetworkImage(
                                    imageUrl: currency.flagUrl,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.flag, size: 12.sp, color: Colors.grey[600]),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.flag, size: 12.sp, color: Colors.grey[600]),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                recipient.currency,
                                style: GoogleFonts.inter(
                                  color: Colors.grey[400],
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          recipient.bankName,
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          recipient.email,
                          style: GoogleFonts.inter(
                            color: Colors.grey[500],
                            fontSize: 12.sp,
                          ),
                        ),
                        if (recipient.lastUsed != null) ...[
                          SizedBox(height: 4.h),
                          Text(
                            'Last used ${_formatDate(recipient.lastUsed!)}',
                            style: GoogleFonts.inter(
                              color: Colors.grey[600],
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert, color: Colors.grey[400], size: 20.sp),
                    color: Colors.grey[800],
                    onSelected: (value) => _handleRecipientAction(value, recipient),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'send',
                        child: Row(
                          children: [
                            Icon(Icons.send, color: Colors.blue, size: 16.sp),
                            SizedBox(width: 8.w),
                            Text('Send Money', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit, color: Colors.orange, size: 16.sp),
                            SizedBox(width: 8.w),
                            Text('Edit', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: recipient.isFavorite ? 'unfavorite' : 'favorite',
                        child: Row(
                          children: [
                            Icon(
                              recipient.isFavorite ? Icons.star : Icons.star_border,
                              color: Colors.orange,
                              size: 16.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              recipient.isFavorite ? 'Remove from Favorites' : 'Add to Favorites',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red, size: 16.sp),
                            SizedBox(width: 8.w),
                            Text('Delete', style: TextStyle(color: Colors.white)),
                          ],
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Icon(
              Icons.people_outline,
              size: 48.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Recipients Found',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Add recipients to send money worldwide',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.4),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: FloatingActionButton.extended(
        onPressed: () => _showAddRecipientSheet(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.person_add, color: Colors.white, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              'Add Recipient',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;
    
    if (difference == 0) {
      return 'today';
    } else if (difference == 1) {
      return 'yesterday';
    } else if (difference < 7) {
      return '$difference days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _showRecipientDetails(Recipient recipient) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[700]!, Colors.blue[500]!],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      recipient.initials,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipient.name,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        recipient.email,
                        style: GoogleFonts.inter(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            _buildDetailRow('Bank', recipient.bankName),
            _buildDetailRow('Account', recipient.accountNumber),
            if (recipient.swiftCode != null)
              _buildDetailRow('SWIFT/BIC', recipient.swiftCode!),
            _buildDetailRow('Currency', recipient.currency),
            if (recipient.address != null)
              _buildDetailRow('Address', '${recipient.address}, ${recipient.city}'),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      _handleRecipientAction('send', recipient);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Send Money',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Get.back();
                      _handleRecipientAction('edit', recipient);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.white.withOpacity(0.3)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Edit',
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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80.w,
            child: Text(
              label,
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 12.sp,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[700],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Text(
              'Sort Recipients',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSortOption('Name (A-Z)', Icons.sort_by_alpha),
            _buildSortOption('Recently Used', Icons.access_time),
            _buildSortOption('Recently Added', Icons.add_circle_outline),
            _buildSortOption('Favorites First', Icons.star),
          ],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildSortOption(String title, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () {
            Get.back();
            _sortRecipients(title);
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(icon, color: Colors.blue, size: 20.sp),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _sortRecipients(String sortType) {
    setState(() {
      switch (sortType) {
        case 'Name (A-Z)':
          _filteredRecipients.sort((a, b) => a.name.compareTo(b.name));
          break;
        case 'Recently Used':
          _filteredRecipients.sort((a, b) {
            if (a.lastUsed == null && b.lastUsed == null) return 0;
            if (a.lastUsed == null) return 1;
            if (b.lastUsed == null) return -1;
            return b.lastUsed!.compareTo(a.lastUsed!);
          });
          break;
        case 'Recently Added':
          _filteredRecipients.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          break;
        case 'Favorites First':
          _filteredRecipients.sort((a, b) {
            if (a.isFavorite && !b.isFavorite) return -1;
            if (!a.isFavorite && b.isFavorite) return 1;
            return a.name.compareTo(b.name);
          });
          break;
      }
    });
  }

  void _handleRecipientAction(String action, Recipient recipient) {
    switch (action) {
      case 'send':
        Get.snackbar(
          'Send Money',
          'Sending money to ${recipient.name}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blue.withOpacity(0.8),
          colorText: Colors.white,
        );
        break;
      case 'edit':
        _showEditRecipientSheet(recipient);
        break;
      case 'favorite':
      case 'unfavorite':
        setState(() {
          final index = _allRecipients.indexWhere((r) => r.id == recipient.id);
          if (index != -1) {
            _allRecipients[index] = recipient.copyWith(isFavorite: !recipient.isFavorite);
          }
        });
        _filterRecipients();
        break;
      case 'delete':
        _showDeleteConfirmation(recipient);
        break;
    }
  }

  void _showEditRecipientSheet(Recipient recipient) {
    Get.snackbar(
      'Edit Recipient',
      'Edit recipient feature will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.withOpacity(0.8),
      colorText: Colors.white,
    );
  }

  void _showDeleteConfirmation(Recipient recipient) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.grey[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Delete Recipient',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to delete ${recipient.name}? This action cannot be undone.',
          style: GoogleFonts.inter(
            color: Colors.grey[400],
            fontSize: 14.sp,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey[400],
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _allRecipients.removeWhere((r) => r.id == recipient.id);
              });
              _filterRecipients();
              Get.back();
              Get.snackbar(
                'Deleted',
                '${recipient.name} has been deleted',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withOpacity(0.8),
                colorText: Colors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddRecipientSheet() {
    Get.snackbar(
      'Add Recipient',
      'Add recipient feature will be implemented',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
} 