import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';

class RecipientInputScreen extends StatefulWidget {
  const RecipientInputScreen({super.key});

  @override
  State<RecipientInputScreen> createState() => _RecipientInputScreenState();
}

class _RecipientInputScreenState extends State<RecipientInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  
  NetworkProvider? selectedProvider;
  Country? selectedCountry;
  bool isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _phoneController.addListener(_onPhoneChanged);
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      selectedProvider = args['networkProvider'] as NetworkProvider?;
      selectedCountry = args['country'] as Country?;
      
      // Handle prefilled data from repeat transactions
      if (args['prefillPhone'] != null) {
        _phoneController.text = args['prefillPhone'] as String;
        isPhoneValid = _phoneController.text.length >= 10;
      }
      
      if (args['prefillName'] != null) {
        _nameController.text = args['prefillName'] as String;
      }
      
      // Show repeat transaction indicator if applicable
      if (args['isRepeatTransaction'] == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.repeat, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Transaction details pre-filled for repeat purchase',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16.w),
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
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _phoneFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _onPhoneChanged() async {
    final phoneNumber = _phoneController.text;
    
    // Update local validation state
    final newIsValid = phoneNumber.length >= 10;
    if (newIsValid != isPhoneValid) {
      setState(() {
        isPhoneValid = newIsValid;
      });
    }
    
    // Detect network provider for phone numbers with sufficient length
    if (phoneNumber.length >= 4) {
      final cubit = context.read<AirtimeCubit>();
      final countryCode = selectedCountry?.code ?? 'NG';
      final detectedProvider = await cubit.detectNetworkFromPhoneNumber(phoneNumber, countryCode);
      
      if (detectedProvider != null && detectedProvider != selectedProvider) {
        setState(() {
          selectedProvider = detectedProvider;
        });
      }
    }
  }

  void _validateAndProceed() {
    final phoneNumber = _phoneController.text.trim();
    
    if (phoneNumber.isEmpty) {
      _showError('Please enter a phone number');
      return;
    }

    if (phoneNumber.length < 10) {
      _showError('Please enter a valid phone number');
      return;
    }
    
    final countryCode = selectedCountry?.code ?? 'NG';
    context.read<AirtimeCubit>().validatePhoneNumber(phoneNumber, countryCode);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _showContactsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ContactSelectionBottomSheet(
        onContactSelected: (contact) {
          setState(() {
            _phoneController.text = contact['phone'] ?? '';
            _nameController.text = contact['name'] ?? '';
          });
          // Trigger phone number change detection
          _onPhoneChanged();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E27),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1F1F1F),
              Color(0xFF0A0E27),
              Color(0xFF0F0F23),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocConsumer<AirtimeCubit, AirtimeState>(
            listener: (context, state) {
              if (state is AirtimePhoneNumberValidated) {
                final args = Get.arguments as Map<String, dynamic>?;
                final prefillAmount = args?['prefillAmount'] as double?;
                
                Get.toNamed(AppRoutes.airtimeAmountSelection, arguments: {
                  'phoneNumber': state.formattedNumber,
                  'recipientName': _nameController.text.trim(),
                  'networkProvider': state.detectedProvider ?? selectedProvider,
                  'country': selectedCountry,
                  if (prefillAmount != null) 'prefillAmount': prefillAmount,
                });
              } else if (state is AirtimeError) {
                _showError(state.message);
              }
            },
            builder: (context, state) {
              // Update UI based on cubit state
              if (state is AirtimePhoneNumberValidated) {
                // Update provider from validated state
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      selectedProvider = state.detectedProvider ?? selectedProvider;
                      isPhoneValid = true;
                    });
                  }
                });
              }

              return Column(
                children: [
                  // Header with state-based UI
                  _buildHeader(),
                  
                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.h),
                          
                          // Selected network display with animation
                          if (selectedProvider != null) 
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: _buildSelectedNetworkCard(),
                            ),
                          
                          SizedBox(height: 24.h),
                          
                          // Phone number input
                          _buildPhoneNumberInput(),
                          
                          SizedBox(height: 20.h),
                          
                          // Recipient name input (optional)
                          _buildRecipientNameInput(),
                          
                          SizedBox(height: 24.h),
                          
                          // Quick contacts
                          _buildQuickContacts(),
                          
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ),
                  
                  // Continue button with state-aware loading
                  _buildContinueButton(state),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          // Back button
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          
          SizedBox(width: 16.w),
          
          // Title and subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Phone Number',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Who would you like to send airtime to?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedNetworkCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: _getProviderColor(selectedProvider!.type),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                selectedProvider!.name.substring(0, 1),
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
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
                Text(
                  'Detected Network',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  selectedProvider!.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          
          Icon(
            Icons.check_circle,
            color: Color(0xFF10B981),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 16.sp,
              ),
              prefixIcon: Container(
                padding: EdgeInsets.all(12.w),
                child: Text(
                  '+234',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.white.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipientNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Name (Optional)',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        SizedBox(height: 8.h),
        
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
          ),
          child: TextField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Enter recipient name',
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: Colors.white.withOpacity(0.4),
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Contacts',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        
        SizedBox(height: 12.h),
        
        GestureDetector(
          onTap: _showContactsBottomSheet,
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contacts,
                  color: Color(0xFF3B82F6),
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Select from contacts',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF3B82F6),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton(AirtimeState state) {
    final isLoading = state is AirtimeLoading;
    final canProceed = isPhoneValid && !isLoading;
    
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canProceed ? _validateAndProceed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: canProceed 
              ? Color(0xFF3B82F6) 
              : Colors.white.withOpacity(0.1),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            elevation: 0,
          ),
          child: isLoading 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Validating...',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Text(
                'Continue',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: canProceed 
                    ? Colors.white 
                    : Colors.white.withOpacity(0.4),
                ),
              ),
        ),
      ),
    );
  }

  Color _getProviderColor(NetworkProviderType type) {
    switch (type) {
      case NetworkProviderType.mtn:
        return Color(0xFFFFCC00);
      case NetworkProviderType.airtel:
        return Color(0xFFFF0000);
      case NetworkProviderType.glo:
        return Color(0xFF00B04F);
      case NetworkProviderType.etisalat:
      case NetworkProviderType.ninemobile:
        return Color(0xFF00AA4F);
      default:
        return Color(0xFF3B82F6); // Default blue color
    }
  }
}

class _ContactSelectionBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onContactSelected;

  const _ContactSelectionBottomSheet({required this.onContactSelected});

  @override
  State<_ContactSelectionBottomSheet> createState() => _ContactSelectionBottomSheetState();
}

class _ContactSelectionBottomSheetState extends State<_ContactSelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  bool _loadingContacts = false;
  String _searchQuery = '';

  // Mock contacts data
  final List<Map<String, dynamic>> _mockContacts = [
    {
      'id': 'contact1',
      'name': 'John Smith',
      'phone': '08012345678',
      'avatar': 'JS',
    },
    {
      'id': 'contact2',
      'name': 'Sarah Johnson',
      'phone': '08087654321',
      'avatar': 'SJ',
    },
    {
      'id': 'contact3',
      'name': 'Mike Davis',
      'phone': '08034567890',
      'avatar': 'MD',
    },
    {
      'id': 'contact4',
      'name': 'Emma Wilson',
      'phone': '08098765432',
      'avatar': 'EW',
    },
    {
      'id': 'contact5',
      'name': 'David Brown',
      'phone': '08076543210',
      'avatar': 'DB',
    },
    {
      'id': 'contact6',
      'name': 'Lisa Anderson',
      'phone': '08023456789',
      'avatar': 'LA',
    },
  ];

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
        // In a real app, you would load actual contacts here
        // For now, we'll use mock data
        await Future.delayed(Duration(seconds: 1));
        
        setState(() {
          _contacts = _mockContacts;
          _filteredContacts = _contacts;
        });
      } else {
        // Use mock data when permission is denied
        setState(() {
          _contacts = _mockContacts;
          _filteredContacts = _contacts;
        });
      }
    } catch (e) {
      setState(() {
        _contacts = _mockContacts;
        _filteredContacts = _contacts;
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F1F1F),
            Color(0xFF0A0E27),
          ],
        ),
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
            child: _loadingContacts 
                ? _buildLoadingState()
                : _buildContactsList(),
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
          // Drag handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                ),
                child: Icon(
                  Icons.contacts,
                  color: Color(0xFF3B82F6),
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
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Choose a contact to send airtime to',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14.sp,
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
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white.withOpacity(0.7),
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
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Color(0xFF3B82F6),
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
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () {
                _searchController.clear();
              },
              child: Icon(
                Icons.clear,
                color: Colors.white.withOpacity(0.5),
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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading contacts...',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
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
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(
              _searchQuery.isNotEmpty ? Icons.search_off : Icons.contacts_outlined,
              size: 48.sp,
              color: Colors.white.withOpacity(0.5),
            ),
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
              color: Colors.white.withOpacity(0.7),
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
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF3B82F6),
                    Color(0xFF8B5CF6),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Center(
                child: Text(
                  contact['avatar'] ?? contact['name']?.substring(0, 1)?.toUpperCase() ?? '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            
            // Contact info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'] ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    contact['phone'] ?? '',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF3B82F6),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
} 