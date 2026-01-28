import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';

class PendingRequestsScreen extends StatelessWidget {
  const PendingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<TagPayCubit>()..getPendingRequests(),
      child: const _PendingRequestsView(),
    );
  }
}

class _PendingRequestsView extends StatefulWidget {
  const _PendingRequestsView();

  @override
  State<_PendingRequestsView> createState() => _PendingRequestsViewState();
}

class _PendingRequestsViewState extends State<_PendingRequestsView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _pinController = TextEditingController();
  String? _selectedAccountId;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        final isIncoming = _tabController.index == 0;
        context.read<TagPayCubit>().getPendingRequests(incoming: isIncoming);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _showAcceptDialog(dynamic request) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20.w,
          right: 20.w,
          top: 20.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Accept Request',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 24.h),
            BlocBuilder<AccountCardsSummaryCubit, AccountCardsSummaryState>(
              builder: (context, state) {
                if (state is AccountCardsSummaryLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Account',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A0A0A),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: const Color(0xFF2D2D2D)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedAccountId,
                            hint: Text(
                              'Choose account',
                              style: GoogleFonts.inter(
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            isExpanded: true,
                            dropdownColor: const Color(0xFF1F1F1F),
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                            items: state.accountSummaries.map((account) {
                              return DropdownMenuItem<String>(
                                value: account.id,
                                child: Text(
                                  '${account.accountType} (\$${account.balance.toStringAsFixed(2)})',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() => _selectedAccountId = value);
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox.shrink();
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Transaction PIN',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            TextField(
              controller: _pinController,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: '••••',
                hintStyle: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                ),
                counterText: '',
                filled: true,
                fillColor: const Color(0xFF0A0A0A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: const Color(0xFF2D2D2D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: const Color(0xFF3B82F6), width: 2),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                if (_selectedAccountId == null) {
                  Get.snackbar(
                    'Error',
                    'Please select an account',
                    backgroundColor: const Color(0xFFEF4444),
                    colorText: Colors.white,
                  );
                  return;
                }
                if (_pinController.text.length != 4) {
                  Get.snackbar(
                    'Error',
                    'Please enter a 4-digit PIN',
                    backgroundColor: const Color(0xFFEF4444),
                    colorText: Colors.white,
                  );
                  return;
                }
                Get.back();
                context.read<TagPayCubit>().acceptMoneyRequest(
                  requestId: request.id,
                  sourceAccountId: _selectedAccountId!,
                  transactionPin: _pinController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Accept & Pay \$${request.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void _showDeclineDialog(dynamic request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Decline Request',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Text(
          'Are you sure you want to decline this money request?',
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              context.read<TagPayCubit>().declineMoneyRequest(requestId: request.id);
            },
            child: Text(
              'Decline',
              style: GoogleFonts.inter(
                color: const Color(0xFFEF4444),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocConsumer<TagPayCubit, TagPayState>(
        listener: (context, state) {
          if (state is MoneyTransferSuccess) {
            Get.snackbar(
              'Success',
              'Request accepted successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
            );
            context.read<TagPayCubit>().getPendingRequests();
          } else if (state is TagPayError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                _buildHeader(context),
                _buildTabBar(),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildRequestsList(state, true),
                      _buildRequestsList(state, false),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Money Requests',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
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
          color: const Color(0xFF3B82F6),
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        tabs: const [
          Tab(text: 'Incoming'),
          Tab(text: 'Sent'),
        ],
      ),
    );
  }

  Widget _buildRequestsList(TagPayState state, bool isIncoming) {
    if (state is TagPayLoading) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(const Color(0xFF3B82F6)),
        ),
      );
    }

    if (state is MoneyRequestsLoaded) {
      if (state.requests.isEmpty) {
        return _buildEmptyState(isIncoming);
      }
      return ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: state.requests.length,
        itemBuilder: (context, index) {
          final request = state.requests[index];
          return _buildRequestCard(request, isIncoming);
        },
      );
    }

    return _buildEmptyState(isIncoming);
  }

  Widget _buildEmptyState(bool isIncoming) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80.sp,
            color: const Color(0xFF374151),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Requests',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            isIncoming
                ? 'You don\'t have any incoming requests'
                : 'You haven\'t sent any requests',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestCard(dynamic request, bool isIncoming) {
    final dateFormat = DateFormat('MMM dd, yyyy');

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24.r,
                backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                child: Icon(
                  Icons.request_page,
                  color: const Color(0xFF3B82F6),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isIncoming
                          ? 'From ${request.requesterTagPay}'
                          : 'To ${request.requesteeTagPay}',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      dateFormat.format(request.createdAt),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '\$${request.amount.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: const Color(0xFFF59E0B),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          if (request.description != null && request.description.isNotEmpty) ...[
            SizedBox(height: 12.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                request.description,
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
          if (isIncoming) ...[
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showAcceptDialog(request),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Accept',
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
                    onPressed: () => _showDeclineDialog(request),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: const Color(0xFFEF4444)),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Decline',
                      style: GoogleFonts.inter(
                        color: const Color(0xFFEF4444),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
