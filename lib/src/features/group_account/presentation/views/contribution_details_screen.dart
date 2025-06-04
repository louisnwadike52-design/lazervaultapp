import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/group_entities.dart';
import '../../data/datasources/contribution_payment_local_data_source.dart';
import '../../data/services/contribution_payment_service.dart';
import '../../data/repositories/contribution_payment_repository_impl.dart';
import '../cubit/group_account_cubit.dart';
import '../cubit/group_account_state.dart';
import '../widgets/payment_history_card.dart';
import '../widgets/add_members_to_contribution_dialog.dart';
import 'contribution_payment_confirmation_screen.dart';

class ContributionDetailsScreen extends StatefulWidget {
  final String contributionId;
  final Contribution? contribution;

  const ContributionDetailsScreen({
    super.key,
    required this.contributionId,
    this.contribution,
  });

  @override
  State<ContributionDetailsScreen> createState() => _ContributionDetailsScreenState();
}

class _ContributionDetailsScreenState extends State<ContributionDetailsScreen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late TabController _tabController;
  Contribution? _currentContribution;
  List<ContributionPayment> _localPayments = [];
  bool _isLoadingPayments = false;
  late ContributionPaymentRepositoryImpl _paymentRepository;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _tabController = TabController(length: 3, vsync: this);
    _currentContribution = widget.contribution;
    _loadContributionDetails();
    _initializeAndLoadPayments();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Refresh payments when app resumes (e.g., returning from payment screen)
      _refreshPayments();
    }
  }

  Future<void> _initializeAndLoadPayments() async {
    await _initializePaymentRepository();
    _loadLocalPayments();
  }

  Future<void> _initializePaymentRepository() async {
    final localDataSource = ContributionPaymentLocalDataSourceImpl();
    final paymentService = ContributionPaymentServiceImpl(localDataSource: localDataSource);
    _paymentRepository = ContributionPaymentRepositoryImpl(paymentService: paymentService);
    
    // Initialize the local data source and wait for it to complete
    await localDataSource.init();
  }

  Future<void> _loadLocalPayments() async {
    setState(() {
      _isLoadingPayments = true;
    });

    try {
      final payments = await _paymentRepository.getPaymentsByContribution(widget.contributionId);
      if (mounted) {
        setState(() {
          _localPayments = payments;
          _isLoadingPayments = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingPayments = false;
        });
      }
      print('Error loading local payments: $e');
    }
  }

  void _loadContributionDetails() {
    // Load contribution details if not provided
    if (_currentContribution == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<GroupAccountCubit>().loadContributionDetails(widget.contributionId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<GroupAccountCubit, GroupAccountState>(
          listener: (context, state) {
            if (state is GroupAccountError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: const Color(0xFFEF4444),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          builder: (context, state) {
            if (_currentContribution == null && state is GroupAccountLoading) {
              return _buildLoadingView();
            } else if (_currentContribution != null) {
              return _buildContributionDetailsView(_currentContribution!);
            } else if (state is GroupAccountError) {
              return _buildErrorView(state.message);
            }

            return _buildLoadingView();
          },
        ),
      ),
      floatingActionButton: _currentContribution != null && !_currentContribution!.isCompleted
          ? FloatingActionButton.extended(
              onPressed: () => _navigateToMakePayment(_currentContribution!),
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              icon: Icon(Icons.payment, size: 20.sp),
              label: Text(
                'Contribute',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF6C5CE7),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading contribution details...',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to load contribution',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C5CE7),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContributionDetailsView(Contribution contribution) {
    return Column(
      children: [
        _buildHeader(contribution),
        _buildContributionSummary(contribution),
        _buildTabBar(),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildOverviewTab(contribution),
              _buildPaymentsTab(contribution),
              _buildMembersTab(contribution),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(Contribution contribution) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        border: Border(
          bottom: BorderSide(color: const Color(0xFF2D2D2D), width: 1),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
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
                  contribution.title,
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Contribution Details',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 24.sp,
            ),
            color: const Color(0xFF1F1F1F),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Share',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Edit',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'transcript',
                child: Row(
                  children: [
                    Icon(Icons.receipt_long, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Text(
                      'Get Transcript',
                      style: GoogleFonts.inter(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) => _handleMenuAction(value, contribution),
          ),
        ],
      ),
    );
  }

  Widget _buildContributionSummary(Contribution contribution) {
    final progressPercentage = contribution.progressPercentage;
    final isCompleted = contribution.isCompleted;
    final isOverdue = contribution.isOverdue;

    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6C5CE7),
            const Color(0xFF6C5CE7).withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C5CE7).withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  contribution.description,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFF10B981).withOpacity(0.2)
                      : isOverdue
                          ? const Color(0xFFEF4444).withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isOverdue
                            ? const Color(0xFFEF4444)
                            : Colors.white,
                    width: 1,
                  ),
                ),
                child: Text(
                  isCompleted
                      ? 'Completed'
                      : isOverdue
                          ? 'Overdue'
                          : 'Active',
                  style: GoogleFonts.inter(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isOverdue
                            ? const Color(0xFFEF4444)
                            : Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Raised',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.currentAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Target',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '${contribution.currency} ${contribution.targetAmount.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    '${progressPercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: progressPercentage / 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Deadline: ${DateFormat('MMM dd, yyyy').format(contribution.deadline)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              Text(
                '${contribution.payments.length} payment${contribution.payments.length == 1 ? '' : 's'}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6C5CE7),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
        labelStyle: GoogleFonts.inter(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          Tab(text: 'Overview'),
          Tab(text: 'Payments'),
          Tab(text: 'Members'),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(Contribution contribution) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatCard(
            title: 'Remaining Amount',
            value: '${contribution.currency} ${(contribution.targetAmount - contribution.currentAmount).toStringAsFixed(2)}',
            icon: Icons.account_balance_wallet,
            color: const Color(0xFF3B82F6),
          ),
          SizedBox(height: 16.h),
          _buildStatCard(
            title: 'Days Remaining',
            value: _calculateDaysRemaining(contribution.deadline),
            icon: Icons.schedule,
            color: contribution.isOverdue
                ? const Color(0xFFEF4444)
                : const Color(0xFF10B981),
          ),
          SizedBox(height: 16.h),
          _buildStatCard(
            title: 'Average Payment',
            value: contribution.payments.isNotEmpty
                ? '${contribution.currency} ${(contribution.currentAmount / contribution.payments.length).toStringAsFixed(2)}'
                : '${contribution.currency} 0.00',
            icon: Icons.trending_up,
            color: const Color(0xFFF59E0B),
          ),
          SizedBox(height: 24.h),
          Text(
            'Description',
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Text(
              contribution.description,
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                color: Colors.grey[300],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentsTab(Contribution contribution) {
    // Combine local payments with static contribution payments
    final allPayments = <ContributionPayment>[];
    
    // Add local payments first (these are newer)
    allPayments.addAll(_localPayments);
    
    // Add static payments, but avoid duplicates
    for (final staticPayment in contribution.payments) {
      final isDuplicate = allPayments.any((localPayment) => 
        localPayment.id == staticPayment.id ||
        (localPayment.transactionId != null && 
         staticPayment.transactionId != null &&
         localPayment.transactionId == staticPayment.transactionId)
      );
      
      if (!isDuplicate) {
        allPayments.add(staticPayment);
      }
    }
    
    // Sort by payment date, newest first
    allPayments.sort((a, b) => b.paymentDate.compareTo(a.paymentDate));

    if (allPayments.isEmpty) {
      return _buildEmptyPayments();
    }

    return RefreshIndicator(
      onRefresh: _refreshPayments,
      backgroundColor: const Color(0xFF1F1F1F),
      color: const Color(0xFF6C5CE7),
      child: ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: allPayments.length,
        itemBuilder: (context, index) {
          final payment = allPayments[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: PaymentHistoryCard(
              payment: payment,
              onTap: () => _showPaymentDetails(payment),
            ),
          );
        },
      ),
    );
  }

  Future<void> _refreshPayments() async {
    await _loadLocalPayments();
  }

  Widget _buildMembersTab(Contribution contribution) {
    // Group payments by user
    final userPayments = <String, List<ContributionPayment>>{};
    
    // Combine local and static payments for member grouping
    final allPayments = <ContributionPayment>[];
    allPayments.addAll(_localPayments);
    for (final staticPayment in contribution.payments) {
      final isDuplicate = allPayments.any((localPayment) => 
        localPayment.id == staticPayment.id ||
        (localPayment.transactionId != null && 
         staticPayment.transactionId != null &&
         localPayment.transactionId == staticPayment.transactionId)
      );
      if (!isDuplicate) {
        allPayments.add(staticPayment);
      }
    }
    
    for (final payment in allPayments) {
      userPayments.putIfAbsent(payment.userId, () => []).add(payment);
    }

    return Column(
      children: [
        // Add Members button
        Container(
          width: double.infinity,
          margin: EdgeInsets.all(20.w),
          child: ElevatedButton.icon(
            onPressed: () => _showAddMembersDialog(contribution),
            icon: Icon(Icons.person_add, size: 20.sp),
            label: Text(
              'Add Members to Contribution',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        
        // Members list
        Expanded(
          child: userPayments.isEmpty 
            ? _buildEmptyMembers()
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: userPayments.length,
                itemBuilder: (context, index) {
                  final userId = userPayments.keys.elementAt(index);
                  final payments = userPayments[userId]!;
                  final totalAmount = payments.fold<double>(0, (sum, p) => sum + p.amount);

                  return Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFF2D2D2D)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: const Color(0xFF6C5CE7),
                          child: Text(
                            payments.first.userName.isNotEmpty
                                ? payments.first.userName[0].toUpperCase()
                                : 'U',
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                payments.first.userName,
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                '${payments.length} payment${payments.length == 1 ? '' : 's'}',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${contribution.currency} ${totalAmount.toStringAsFixed(2)}',
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              '${((totalAmount / contribution.targetAmount) * 100).toStringAsFixed(1)}%',
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: const Color(0xFF6C5CE7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPayments() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.payment_outlined,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No Payments Yet',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Be the first to contribute to this goal',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyMembers() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64.sp,
            color: Colors.grey[600],
          ),
          SizedBox(height: 16.h),
          Text(
            'No Contributors Yet',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Waiting for members to make payments',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  String _calculateDaysRemaining(DateTime deadline) {
    final now = DateTime.now();
    final difference = deadline.difference(now);

    if (difference.inDays < 0) {
      return 'Overdue by ${(-difference.inDays)} days';
    } else if (difference.inDays == 0) {
      return 'Due today';
    } else {
      return '${difference.inDays} days';
    }
  }

  void _handleMenuAction(String action, Contribution contribution) {
    switch (action) {
      case 'share':
        // Implement share functionality
        break;
      case 'edit':
        // Navigate to edit contribution screen
        break;
      case 'transcript':
        context.read<GroupAccountCubit>().generateTranscriptForContribution(contribution.id);
        break;
    }
  }

  void _navigateToMakePayment(Contribution contribution) {
    Get.toNamed(
      AppRoutes.makePayment,
      arguments: {
        'contributionId': contribution.id,
        'contribution': contribution,
      },
    );
  }

  void _showPaymentDetails(ContributionPayment payment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2A2A3E).withOpacity(0.95),
              const Color(0xFF1F1F35).withOpacity(0.98),
            ],
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, -8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPaymentHeader(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentTransactionDetails(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentMethodInfo(payment),
              SizedBox(height: 24.h),
              _buildPaymentDivider(),
              SizedBox(height: 24.h),
              _buildPaymentAmountBreakdown(payment),
              SizedBox(height: 32.h),
              _buildPaymentActions(payment),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentHeader(ContributionPayment payment) {
    return Column(
      children: [
        // Close button and status
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'PAYMENT DETAILS',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getPaymentStatusColor(payment.status).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: _getPaymentStatusColor(payment.status).withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    payment.status.displayName.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w700,
                      color: _getPaymentStatusColor(payment.status),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
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
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        
        // Amount display
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF6C5CE7),
                const Color(0xFF8B5CF6),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C5CE7).withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Payment Amount',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '${payment.currency} ${payment.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Paid by ${payment.userName}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentDivider() {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            Colors.white.withOpacity(0.2),
            Colors.transparent,
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentTransactionDetails(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              color: const Color(0xFF6366F1),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Transaction Details',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        _buildEnhancedPaymentDetailRow(
          'Transaction ID',
          payment.transactionId ?? 'N/A',
          icon: Icons.fingerprint,
          copyable: payment.transactionId != null,
        ),
        _buildEnhancedPaymentDetailRow(
          'Date & Time',
          DateFormat('MMM dd, yyyy • HH:mm').format(payment.paymentDate),
          icon: Icons.schedule,
        ),
        _buildEnhancedPaymentDetailRow(
          'Payment Method',
          _getPaymentMethodName(payment),
          icon: _getPaymentMethodIcon(payment),
        ),
        if (payment.notes != null && payment.notes!.isNotEmpty)
          _buildEnhancedPaymentDetailRow(
            'Notes',
            payment.notes!,
            icon: Icons.note_alt,
            isMultiline: true,
          ),
      ],
    );
  }

  Widget _buildPaymentMethodInfo(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.payment,
              color: const Color(0xFF10B981),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Payment Information',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF10B981).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      _getPaymentMethodIcon(payment),
                      color: const Color(0xFF10B981),
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getPaymentMethodName(payment),
                          style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          _getPaymentMethodDescription(payment),
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.verified,
                    color: const Color(0xFF10B981),
                    size: 16.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentAmountBreakdown(ContributionPayment payment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.account_balance_wallet,
              color: const Color(0xFFF59E0B),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              'Amount Breakdown',
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: [
              _buildAmountRow('Contribution Amount', '${payment.currency} ${payment.amount.toStringAsFixed(2)}'),
              SizedBox(height: 8.h),
              _buildAmountRow('Processing Fee', '${payment.currency} 0.00', isSubtle: true),
              SizedBox(height: 12.h),
              Container(
                height: 1.h,
                color: Colors.white.withOpacity(0.1),
              ),
              SizedBox(height: 12.h),
              _buildAmountRow(
                'Total Paid',
                '${payment.currency} ${payment.amount.toStringAsFixed(2)}',
                isTotal: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentActions(ContributionPayment payment) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _generateReceipt(payment),
            icon: Icon(Icons.receipt, size: 20.sp),
            label: Text(
              'Generate Receipt',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _sharePaymentDetails(payment),
            icon: Icon(Icons.share, size: 20.sp),
            label: Text(
              'Share Details',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              side: BorderSide(color: Colors.white.withOpacity(0.3)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _generateReceipt(ContributionPayment payment) async {
    try {
      // Close the bottom sheet first
      Navigator.pop(context);
      
      // Show loading dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: const Color(0xFF6C5CE7),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Generating Receipt...',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Simulate receipt generation delay
      await Future.delayed(const Duration(milliseconds: 1500));
      
      // Close loading dialog
      if (mounted) Navigator.pop(context);
      
      // Navigate to receipt screen
      if (mounted && _currentContribution != null) {
        Get.to(
          () => ContributionPaymentConfirmationScreen(
            contribution: _currentContribution!,
            payment: payment,
            paymentMethod: _getPaymentMethodName(payment),
          ),
        );
      }
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Receipt generated successfully!'),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if still open
      if (mounted) Navigator.pop(context);
      
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Failed to generate receipt'),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _sharePaymentDetails(ContributionPayment payment) async {
    try {
      // Generate shareable text
      final shareText = _generateShareText(payment);
      
      // Use HapticFeedback for better UX
      HapticFeedback.lightImpact();
      
      // Close the bottom sheet first
      Navigator.pop(context);
      
      // Share the payment details
      await Share.share(
        shareText,
        subject: 'Payment Receipt - ${_currentContribution?.title ?? 'Contribution'}',
      );
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.share, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Payment details shared successfully!'),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 20.sp),
                SizedBox(width: 12.w),
                Text('Failed to share payment details'),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _generateShareText(ContributionPayment payment) {
    final contribution = _currentContribution;
    final paymentMethod = _getPaymentMethodName(payment);
    
    return '''
🎉 PAYMENT RECEIPT 🎉

💰 Amount: ${payment.currency} ${payment.amount.toStringAsFixed(2)}
📋 Contribution: ${contribution?.title ?? 'N/A'}
👤 Paid by: ${payment.userName}
📅 Date: ${DateFormat('MMM dd, yyyy • HH:mm').format(payment.paymentDate)}
💳 Method: $paymentMethod
🆔 Transaction ID: ${payment.transactionId ?? 'N/A'}
✅ Status: ${payment.status.displayName}

${payment.notes?.isNotEmpty == true ? '📝 Notes: ${payment.notes}\n' : ''}
${contribution != null ? '''
📊 Contribution Progress:
• Target: ${contribution.currency} ${contribution.targetAmount.toStringAsFixed(2)}
• Raised: ${contribution.currency} ${(contribution.currentAmount + payment.amount).toStringAsFixed(2)}
• Progress: ${((contribution.currentAmount + payment.amount) / contribution.targetAmount * 100).clamp(0.0, 100.0).toStringAsFixed(1)}%
''' : ''}
Thank you for your contribution! 🙏

Powered by LazerVault 🚀
''';
  }

  Widget _buildEnhancedPaymentDetailRow(
    String label,
    String value, {
    IconData? icon,
    bool copyable = false,
    bool isMultiline = false,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
        ),
      ),
      child: Row(
        crossAxisAlignment: isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16.sp,
              color: Colors.grey[400],
            ),
            SizedBox(width: 12.w),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (copyable) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: () => _copyToClipboard(value),
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.copy,
                  size: 16.sp,
                  color: const Color(0xFF6C5CE7),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isSubtle = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 16.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isSubtle ? Colors.grey[500] : Colors.white,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.inter(
            fontSize: isTotal ? 18.sp : 14.sp,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? const Color(0xFF10B981) : (isSubtle ? Colors.grey[500] : Colors.white),
          ),
        ),
      ],
    );
  }

  Color _getPaymentStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return const Color(0xFFF59E0B);
      case PaymentStatus.processing:
        return const Color(0xFF3B82F6);
      case PaymentStatus.completed:
        return const Color(0xFF10B981);
      case PaymentStatus.failed:
        return const Color(0xFFEF4444);
      case PaymentStatus.cancelled:
        return const Color(0xFF6B7280);
      case PaymentStatus.refunded:
        return const Color(0xFF8B5CF6);
    }
  }

  String _getPaymentMethodName(ContributionPayment payment) {
    // Extract from metadata or default
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return 'Bank Transfer';
        case 'card':
          return 'Credit/Debit Card';
        case 'mobile_money':
          return 'Mobile Money';
        case 'crypto':
          return 'Cryptocurrency';
        default:
          return 'Unknown Method';
      }
    }
    return 'Payment';
  }

  String _getPaymentMethodDescription(ContributionPayment payment) {
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return 'Direct bank transfer';
        case 'card':
          return 'Visa, Mastercard, etc.';
        case 'mobile_money':
          return 'MTN, Vodafone, AirtelTigo';
        case 'crypto':
          return 'Bitcoin, Ethereum, USDT';
        default:
          return 'Electronic payment';
      }
    }
    return 'Electronic payment';
  }

  IconData _getPaymentMethodIcon(ContributionPayment payment) {
    final metadata = payment.metadata;
    if (metadata != null && metadata['paymentMethod'] != null) {
      final method = metadata['paymentMethod'] as String;
      switch (method.toLowerCase()) {
        case 'bank_transfer':
          return Icons.account_balance;
        case 'card':
          return Icons.credit_card;
        case 'mobile_money':
          return Icons.phone_android;
        case 'crypto':
          return Icons.currency_bitcoin;
        default:
          return Icons.payment;
      }
    }
    return Icons.payment;
  }

  void _showAddMembersDialog(Contribution contribution) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<GroupAccountCubit>(),
        child: AddMembersToContributionDialog(
          contribution: contribution,
          onMembersAdded: () {
            // Refresh the contribution data or show success message
            _refreshPayments();
          },
        ),
      ),
    );
  }

  void _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      HapticFeedback.lightImpact();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 16.sp),
                SizedBox(width: 8.w),
                Text(
                  'Copied to clipboard',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.error, color: Colors.white, size: 16.sp),
                SizedBox(width: 8.w),
                Text(
                  'Failed to copy',
                  style: GoogleFonts.inter(fontSize: 14.sp),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 1),
          ),
        );
      }
    }
  }
} 