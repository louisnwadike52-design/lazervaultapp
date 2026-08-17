part of 'recipient_input_screen.dart';

class _ContactSelectionBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onContactSelected;

  const _ContactSelectionBottomSheet({required this.onContactSelected});

  @override
  State<_ContactSelectionBottomSheet> createState() =>
      _ContactSelectionBottomSheetState();
}

class _ContactSelectionBottomSheetState
    extends State<_ContactSelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  bool _loadingContacts = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filteredContacts = _contacts.where((contact) {
        final name = contact['name'].toString().toLowerCase();
        final phone = contact['phone'].toString().toLowerCase();
        return name.contains(_searchQuery) || phone.contains(_searchQuery);
      }).toList();
    });
  }

  Future<void> _loadContacts() async {
    setState(() {
      _loadingContacts = true;
    });

    try {
      final permission = await Permission.contacts.request();

      if (permission.isGranted) {
        // TODO: Integrate real device contacts via contacts_service package
        setState(() {
          _contacts = [];
          _filteredContacts = [];
        });
      } else {
        setState(() {
          _contacts = [];
          _filteredContacts = [];
        });
      }
    } catch (e) {
      setState(() {
        _contacts = [];
        _filteredContacts = [];
      });
    } finally {
      setState(() {
        _loadingContacts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child:
                _loadingContacts ? _buildLoadingState() : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.contacts,
                  color: const Color(0xFF4E03D0),
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
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Choose a contact to send airtime to',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
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
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF4E03D0),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () => _searchController.clear(),
              child: Icon(
                Icons.clear,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LazerVaultLoader.small(),
          SizedBox(height: 16.h),
          Text(
            'Loading contacts...',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    if (_filteredContacts.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = _filteredContacts[index];
        return _buildContactTile(contact);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.contacts_outlined,
            size: 48.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            _searchQuery.isNotEmpty ? 'No contacts found' : 'No contacts available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try searching with different keywords'
                : 'Grant permission to access your contacts',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onContactSelected(contact);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color.fromARGB(255, 78, 3, 208)],
                ),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Center(
                child: Text(
                  contact['avatar'] ??
                      (contact['name']?.toString().isNotEmpty == true ? contact['name']!.toString()[0].toUpperCase() : null) ??
                      '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'] ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    contact['phone'] ?? '',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF4E03D0),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
