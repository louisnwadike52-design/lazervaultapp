import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/services/account_manager.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../../account_cards_summary/domain/entities/account_summary_entity.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../cubit/id_pay_cubit.dart';
import '../cubit/id_pay_state.dart';
import '../widgets/id_pay_details_bottom_sheet.dart';
import '../widgets/id_pay_status_badge.dart';

class IDPayHomeScreen extends StatefulWidget {
  const IDPayHomeScreen({super.key});

  @override
  State<IDPayHomeScreen> createState() => _IDPayHomeScreenState();
}

class _IDPayHomeScreenState extends State<IDPayHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<IDPayCubit>().getMyIDPays();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context.read<IDPayCubit>().getMyIDPays();
  }

  void _onSearchSubmitted(String payId) {
    final trimmed = payId.trim();
    if (trimmed.isEmpty) return;
    Get.toNamed('/id-pay/lookup', arguments: {'payId': trimmed});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed('/id-pay/create');
        },
        backgroundColor: const Color(0xFF3B82F6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Create IDPay',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 16.h),
            _buildTabBar(),
            SizedBox(height: 8.h),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildMyPayIDsTab(),
                  _buildPayTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAllNamed(AppRoutes.dashboard),
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(22.r),
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
              'IDPay',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          if (_isBusinessAccount()) ...[
            GestureDetector(
              onTap: () {
                final accountId =
                    GetIt.I<AccountManager>().activeAccountId ?? '';
                Get.toNamed(AppRoutes.idPayOrganizations,
                    arguments: {'accountId': accountId});
              },
              child: Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.business_outlined,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
              ),
            ),
          ],
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
          borderRadius: BorderRadius.circular(10.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: const Color(0xFF9CA3AF),
        labelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'My PayIDs'),
          Tab(text: 'Pay'),
        ],
      ),
    );
  }

  Widget _buildMyPayIDsTab() {
    return BlocConsumer<IDPayCubit, IDPayState>(
      listener: (context, state) {
        if (state is IDPayError) {
          Get.snackbar(
            'Error',
            state.message,
            backgroundColor: const Color(0xFFEF4444),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(16.w),
          );
        }
      },
      builder: (context, state) {
        if (state is IDPayLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          );
        }

        if (state is MyIDPaysLoaded) {
          final idPays = state.idPays;
          if (idPays.isEmpty) {
            return _buildEmptyState();
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: idPays.length,
              itemBuilder: (context, index) {
                return _buildIDPayCard(idPays[index]);
              },
            ),
          );
        }

        if (state is IDPayError) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 60.h),
                _buildErrorState(state.message),
              ],
            ),
          );
        }

        return _buildEmptyState();
      },
    );
  }

  void _showDetailsBottomSheet(IDPayEntity idPay) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => IDPayDetailsBottomSheet(idPay: idPay),
    );
  }

  Widget _buildIDPayCard(IDPayEntity idPay) {
    return GestureDetector(
      onTap: () => _showDetailsBottomSheet(idPay),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.qr_code_2,
                color: const Color(0xFF3B82F6),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          idPay.displayPayId,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      IDPayStatusBadge(status: idPay.status),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Text(
                        idPay.isFixed
                            ? '${_currencySymbol(idPay.currency)}${idPay.amount.toStringAsFixed(2)}'
                            : 'Flexible',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4B5563),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        idPay.type.displayName,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (idPay.description.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    Text(
                      idPay.description,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: const Color(0xFF6B7280),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: const Color(0xFF6B7280),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayTab() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter a PayID code to make a payment',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: _searchController,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
            ),
            textCapitalization: TextCapitalization.characters,
            decoration: InputDecoration(
              hintText: 'e.g. A3K9X2',
              hintStyle: GoogleFonts.inter(
                color: const Color(0xFF6B7280),
                fontSize: 16.sp,
              ),
              prefixText: 'PAY-',
              prefixStyle: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              suffixIcon: GestureDetector(
                onTap: () => _onSearchSubmitted(_searchController.text),
                child: Container(
                  margin: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
              ),
              filled: true,
              fillColor: const Color(0xFF1F1F1F),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
            onSubmitted: _onSearchSubmitted,
          ),
          SizedBox(height: 32.h),
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                    child: Icon(
                      Icons.qr_code_scanner,
                      size: 36.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Search for a PayID',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Enter a PayID code above to find\nand pay someone instantly',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(height: 60.h),
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(36.r),
                    ),
                    child: Icon(
                      Icons.qr_code_2,
                      size: 32.sp,
                      color: const Color(0xFF6B7280),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No PayIDs Yet',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Create a PayID to receive payments\nfrom anyone, anywhere',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed('/id-pay/create');
                    },
                    icon: Icon(Icons.add, size: 20.sp, color: Colors.white),
                    label: Text(
                      'Create IDPay',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 14.h, horizontal: 24.w),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48.sp,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Failed to Load',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _onRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Retry',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isBusinessAccount() {
    final activeId = GetIt.I<AccountManager>().activeAccountId;
    if (activeId == null) return false;
    try {
      final cubitState = context.read<AccountCardsSummaryCubit>().state;
      if (cubitState is AccountCardsSummaryLoaded) {
        final activeAccount = cubitState.accountSummaries.firstWhere(
          (a) => a.id == activeId,
          orElse: () => cubitState.accountSummaries.first,
        );
        return activeAccount.accountTypeEnum == VirtualAccountType.business;
      }
    } catch (_) {}
    return false;
  }

  String _currencySymbol(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return '\u20A6';
      case 'USD':
        return '\$';
      case 'GBP':
        return '\u00A3';
      case 'EUR':
        return '\u20AC';
      default:
        return '$currency ';
    }
  }
}
