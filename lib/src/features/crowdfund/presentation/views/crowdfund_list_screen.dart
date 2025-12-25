import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import '../widgets/crowdfund_card.dart';
import 'crowdfund_details_screen.dart';

class CrowdfundListScreen extends StatefulWidget {
  const CrowdfundListScreen({super.key});

  @override
  State<CrowdfundListScreen> createState() => _CrowdfundListScreenState();
}

class _CrowdfundListScreenState extends State<CrowdfundListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedStatus;
  bool _myCrowdfundsOnly = false;

  @override
  void initState() {
    super.initState();
    _loadCrowdfunds();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadCrowdfunds() {
    context.read<CrowdfundCubit>().loadCrowdfunds(
          statusFilter: _selectedStatus,
          categoryFilter: _selectedCategory,
          myCrowdfundsOnly: _myCrowdfundsOnly,
        );
  }

  void _onSearchChanged(String query) {
    if (query.trim().length >= 2) {
      context.read<CrowdfundCubit>().searchCrowdfunds(query: query.trim());
    } else if (query.trim().isEmpty) {
      _loadCrowdfunds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: Text(
          'Crowdfunding',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _myCrowdfundsOnly ? Icons.person : Icons.people,
              color: _myCrowdfundsOnly
                  ? const Color(0xFF4E03D0)
                  : Colors.grey[400],
            ),
            onPressed: () {
              setState(() {
                _myCrowdfundsOnly = !_myCrowdfundsOnly;
              });
              _loadCrowdfunds();
            },
            tooltip: _myCrowdfundsOnly
                ? 'Show all crowdfunds'
                : 'Show my crowdfunds',
          ),
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: Colors.grey[400],
            ),
            onPressed: _showFilterBottomSheet,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: EdgeInsets.all(16.w),
            color: const Color(0xFF1F1F1F),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search by username or crowdfund code...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[500],
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.grey[500],
                        ),
                        onPressed: () {
                          _searchController.clear();
                          _loadCrowdfunds();
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFF0A0A0A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: const BorderSide(
                    color: Color(0xFF4E03D0),
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          // Filter chips
          if (_selectedCategory != null || _selectedStatus != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Wrap(
                spacing: 8.w,
                children: [
                  if (_selectedCategory != null)
                    _buildFilterChip(
                      label: _selectedCategory!,
                      onDeleted: () {
                        setState(() {
                          _selectedCategory = null;
                        });
                        _loadCrowdfunds();
                      },
                    ),
                  if (_selectedStatus != null)
                    _buildFilterChip(
                      label: _selectedStatus!,
                      onDeleted: () {
                        setState(() {
                          _selectedStatus = null;
                        });
                        _loadCrowdfunds();
                      },
                    ),
                ],
              ),
            ),
          // Content
          Expanded(
            child: BlocConsumer<CrowdfundCubit, CrowdfundState>(
              listener: (context, state) {
                if (state is CrowdfundError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: const Color(0xFFEF4444),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is CrowdfundLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: Color(0xFF4E03D0),
                        ),
                        if (state.message != null) ...[
                          SizedBox(height: 16.h),
                          Text(
                            state.message!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                }

                if (state is CrowdfundLoaded) {
                  if (state.crowdfunds.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.volunteer_activism,
                            color: Colors.grey[600],
                            size: 64.sp,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'No crowdfunds found'
                                : 'No crowdfunds available',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            _searchController.text.isNotEmpty
                                ? 'Try a different search term'
                                : 'Check back later for campaigns to support',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      _loadCrowdfunds();
                    },
                    color: const Color(0xFF4E03D0),
                    child: ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: state.crowdfunds.length,
                      itemBuilder: (context, index) {
                        final crowdfund = state.crowdfunds[index];
                        return CrowdfundCard(
                          crowdfund: crowdfund,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CrowdfundDetailsScreen(
                                  crowdfundId: crowdfund.id,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
      // No create button - this screen is only for funding existing crowdfunds
      // Users create crowdfunds from the home screen
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onDeleted,
  }) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF4E03D0),
          fontSize: 12.sp,
        ),
      ),
      deleteIcon: const Icon(
        Icons.close,
        color: Color(0xFF4E03D0),
        size: 16,
      ),
      onDeleted: onDeleted,
      backgroundColor: const Color(0xFF4E03D0).withOpacity(0.1),
      side: const BorderSide(
        color: Color(0xFF4E03D0),
        width: 1,
      ),
    );
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter Crowdfunds',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Category',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  'Medical',
                  'Education',
                  'Emergency',
                  'Community',
                  'Creative',
                  'Business',
                ].map((category) {
                  final isSelected = _selectedCategory == category;
                  return FilterChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setModalState(() {
                        _selectedCategory = selected ? category : null;
                      });
                    },
                    selectedColor: const Color(0xFF4E03D0).withOpacity(0.3),
                    checkmarkColor: const Color(0xFF4E03D0),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF4E03D0)
                          : Colors.grey[400],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
              Text(
                'Status',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: ['active', 'completed', 'paused'].map((status) {
                  final isSelected = _selectedStatus == status;
                  return FilterChip(
                    label: Text(status[0].toUpperCase() + status.substring(1)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setModalState(() {
                        _selectedStatus = selected ? status : null;
                      });
                    },
                    selectedColor: const Color(0xFF4E03D0).withOpacity(0.3),
                    checkmarkColor: const Color(0xFF4E03D0),
                    labelStyle: TextStyle(
                      color: isSelected
                          ? const Color(0xFF4E03D0)
                          : Colors.grey[400],
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setModalState(() {
                          _selectedCategory = null;
                          _selectedStatus = null;
                        });
                        setState(() {
                          _selectedCategory = null;
                          _selectedStatus = null;
                        });
                        _loadCrowdfunds();
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFF2D2D2D)),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Clear',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                        _loadCrowdfunds();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                      ),
                      child: Text(
                        'Apply',
                        style: TextStyle(
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
}
