import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import '../../../../../core/services/injection_container.dart';
import '../../../../../core/types/app_routes.dart';
import 'package:lazervault/src/features/presentation/views/dashboard/dashboard_screen.dart';
import '../cubit/tag_pay_cubit.dart';
import '../cubit/tag_pay_state.dart';
import '../../../profile/cubit/profile_cubit.dart';
import '../../../profile/cubit/profile_state.dart';
import '../../domain/entities/user_tag_entity.dart';
import '../widgets/tag_item_card.dart';
import '../widgets/tag_pay_stats_row.dart';
import '../widgets/tag_pay_shimmer.dart';
import '../widgets/tag_pay_pagination_bar.dart';
import '../widgets/tag_details_bottom_sheet.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'tag_pay_home_screen_widgets.dart';

class _TagPayHomeViewState extends State<_TagPayHomeView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  // Declined and Expired are distinct terminal states from Cancelled — a tag
  // the payee refused, and one that lapsed — so without their own chips those
  // tags are reachable only under "All".
  static const _filters = [
    'All',
    'Pending',
    'Paid',
    'Declined',
    'Expired',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    setState(() => _selectedFilter = 'All');
    if (_tabController.index == 0) {
      context.read<TagPayCubit>().loadIncomingTagsPage(page: 1, status: null);
    } else {
      context.read<TagPayCubit>().loadOutgoingTagsPage(page: 1, status: null);
    }
  }

  String? get _statusParam {
    switch (_selectedFilter) {
      case 'Paid':
        return 'paid';
      case 'Cancelled':
        return 'cancelled';
      case 'Declined':
        return 'declined';
      case 'Expired':
        return 'expired';
      case 'Pending':
        return 'pending';
      default:
        return null;
    }
  }

  void _onFilterSelected(String filter) {
    setState(() => _selectedFilter = filter);
    if (_tabController.index == 0) {
      context
          .read<TagPayCubit>()
          .loadIncomingTagsPage(page: 1, status: _statusParam);
    } else {
      context
          .read<TagPayCubit>()
          .loadOutgoingTagsPage(page: 1, status: _statusParam);
    }
  }

  Future<void> _onRefresh() async {
    if (_tabController.index == 0) {
      await context
          .read<TagPayCubit>()
          .loadIncomingTagsPage(page: 1, status: _statusParam);
    } else {
      await context
          .read<TagPayCubit>()
          .loadOutgoingTagsPage(page: 1, status: _statusParam);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Get.toNamed(AppRoutes.createTag);
          if (context.mounted) {
            context.read<TagPayCubit>().loadHomeData();
          }
        },
        backgroundColor: const Color(0xFF4E03D0),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Request Funds',
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
            // Header stays static; everything below rises + fades in on load.
            _buildHeader(context),
            Expanded(
              child: ServiceEntranceAnimation(
                child: Column(
                  children: [
                    _buildTagPayBadge(context),
                    SizedBox(height: 12.h),
                    _buildStatsSection(context),
                    SizedBox(height: 16.h),
                    _buildTabBar(),
                    _buildFilterChips(),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildReceivedTab(),
                          _buildCreatedTab(),
                        ],
                      ),
                    ),
                    _buildPaginationBar(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.offAll(() => const DashboardScreen()),
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
              'Tag Pay',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'tagpay',
            iconColor: const Color(0xFF10B981),
            backgroundColor: const Color(0xFF10B981),
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Tag Pay',
            sourceContext: 'tagpay',
            isDirect: true,
            icon: Icons.chat_bubble_outline,
            iconColor: const Color(0xFF10B981),
          ),
        ],
      ),
    );
  }

  Widget _buildTagPayBadge(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, profileState) {
        if (profileState is ProfileLoading) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              height: 56.h,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: const Center(
                child: LazerVaultLoader.tiny(),
              ),
            ),
          );
        }

        if (profileState is ProfileLoaded) {
          final user = profileState.user;
          if (user.username != null && user.username!.isNotEmpty) {
            final displayName = '${user.firstName} ${user.lastName}'.trim();
            final initial = displayName.isNotEmpty
                ? displayName[0].toUpperCase()
                : user.username![0].toUpperCase();
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF4E03D0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                      backgroundImage: user.profilePicture != null &&
                              user.profilePicture!.isNotEmpty
                          ? NetworkImage(user.profilePicture!)
                          : null,
                      child: user.profilePicture == null ||
                              user.profilePicture!.isEmpty
                          ? Text(
                              initial,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          : null,
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            displayName.isNotEmpty
                                ? displayName
                                : user.username!,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '@${user.username}',
                            style: GoogleFonts.inter(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        'Lazertag',
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
            );
          }
        }

        // No username set - show setup prompt with edit icon
        return _buildUsernameSetupBadge(context);
      },
    );
  }

  Widget _buildUsernameSetupBadge(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: () => _showSetUsernameModal(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(22.r),
                ),
                child: Icon(
                  Icons.person_outline_rounded,
                  color: const Color(0xFF4E03D0),
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 14.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Set Your Username',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Required to send & receive tags',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36.w,
                height: 36.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Icon(
                  Icons.edit_rounded,
                  color: const Color(0xFF4E03D0),
                  size: 18.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSetUsernameModal(BuildContext outerContext) {
    final profileCubit = outerContext.read<ProfileCubit>();

    showModalBottomSheet(
      context: outerContext,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: profileCubit,
        child: const _SetUsernameSheet(),
      ),
    ).then((_) {
      // Refresh profile after sheet closes (same pattern as settings edit dialog)
      profileCubit.getUserProfile();
    });
  }

  Widget _buildStatsSection(BuildContext context) {
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        if (state is TagPayLoading) {
          return const TagPayStatsShimmer();
        }

        if (state is TagPayHomeLoaded) {
          final isReceivedTab = _tabController.index == 0;
          final tags = isReceivedTab ? state.incomingTags : state.outgoingTags;
          final total =
              isReceivedTab ? state.incomingTotal : state.outgoingTotal;
          final pending =
              tags.where((t) => t.status == TagStatus.pending).length;
          final paid = tags.where((t) => t.status == TagStatus.paid).length;

          return TagPayStatsRow(
            totalCount: total,
            pendingCount: pending,
            paidCount: paid,
          );
        }

        return TagPayStatsRow(totalCount: 0, pendingCount: 0, paidCount: 0);
      },
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
          color: const Color(0xFF4E03D0),
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
          Tab(text: 'Received'),
          Tab(text: 'Created'),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filters.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = filter == _selectedFilter;
          return GestureDetector(
            onTap: () => _onFilterSelected(filter),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF4E03D0).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                filter,
                style: GoogleFonts.inter(
                  color: isSelected
                      ? const Color(0xFF4E03D0)
                      : const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildReceivedTab() {
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        if (state is TagPayLoading) {
          return const TagPayListShimmer();
        }

        if (state is TagPayHomeLoaded) {
          final tags = state.incomingTags;
          if (tags.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF4E03D0),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 60.h),
                  _buildEmptyState(
                    icon: Icons.sell_outlined,
                    title: _getEmptyTitle(isReceived: true),
                    subtitle: _getEmptySubtitle(isReceived: true),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return TagItemCard(
                  tag: tags[index],
                  isIncoming: true,
                  onTap: () => _showTagDetails(tags[index], isIncoming: true),
                );
              },
            ),
          );
        }

        if (state is TagPayError) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 40.h),
                _buildErrorState(state.message),
              ],
            ),
          );
        }

        return const TagPayListShimmer();
      },
    );
  }

  Widget _buildCreatedTab() {
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        if (state is TagPayLoading) {
          return const TagPayListShimmer();
        }

        if (state is TagPayHomeLoaded) {
          final tags = state.outgoingTags;
          if (tags.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              color: const Color(0xFF4E03D0),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 60.h),
                  _buildCreatedEmptyState(),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: tags.length,
              itemBuilder: (context, index) {
                return TagItemCard(
                  tag: tags[index],
                  isIncoming: false,
                  onTap: () => _showTagDetails(tags[index], isIncoming: false),
                );
              },
            ),
          );
        }

        if (state is TagPayError) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            color: const Color(0xFF4E03D0),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(height: 40.h),
                _buildErrorState(state.message),
              ],
            ),
          );
        }

        return const TagPayListShimmer();
      },
    );
  }

  Widget _buildPaginationBar() {
    return BlocBuilder<TagPayCubit, TagPayState>(
      builder: (context, state) {
        if (state is TagPayHomeLoaded) {
          final isReceivedTab = _tabController.index == 0;
          final currentPage =
              isReceivedTab ? state.incomingPage : state.outgoingPage;
          final totalPages = isReceivedTab
              ? state.incomingTotalPages
              : state.outgoingTotalPages;

          return TagPayPaginationBar(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChanged: (page) {
              if (isReceivedTab) {
                context
                    .read<TagPayCubit>()
                    .loadIncomingTagsPage(page: page, status: _statusParam);
              } else {
                context
                    .read<TagPayCubit>()
                    .loadOutgoingTagsPage(page: page, status: _statusParam);
              }
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void _showTagDetails(UserTagEntity tag, {required bool isIncoming}) {
    // isPayable, not `== pending`: a tag mid-transfer or already closed must
    // never be shoved straight onto the payment screen.
    if (isIncoming && tag.isPayable) {
      Get.toNamed(
        AppRoutes.tagPaymentConfirmation,
        arguments: tag,
      );
    } else {
      // Own cubit instance so a cancel/decline inside the sheet does not blank
      // the list behind it; the sheet pops with `true` when the tag changed.
      showModalBottomSheet<bool>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => BlocProvider(
          create: (_) => serviceLocator<TagPayCubit>(),
          child: TagDetailsBottomSheet(tag: tag, isOutgoing: !isIncoming),
        ),
      ).then((changed) {
        if (changed == true && mounted) _onRefresh();
      });
    }
  }

  String _getEmptyTitle({required bool isReceived}) {
    switch (_selectedFilter) {
      case 'Pending':
        return isReceived ? 'No Pending Tags' : 'No Pending Tags';
      case 'Paid':
        return isReceived ? 'No Paid Tags' : 'No Paid Tags';
      case 'Cancelled':
        return isReceived ? 'No Cancelled Tags' : 'No Cancelled Tags';
      case 'Declined':
        return 'No Declined Tags';
      case 'Expired':
        return 'No Expired Tags';
      default:
        return isReceived ? 'No Received Tags' : 'No Created Tags';
    }
  }

  String _getEmptySubtitle({required bool isReceived}) {
    switch (_selectedFilter) {
      case 'Pending':
        return isReceived
            ? 'You have no pending tags to pay'
            : 'You have no pending tags awaiting payment';
      case 'Paid':
        return isReceived
            ? 'No tags have been paid yet'
            : 'No tags have been paid by others yet';
      case 'Cancelled':
        return isReceived
            ? 'No tags have been cancelled'
            : 'No tags have been cancelled';
      case 'Declined':
        return isReceived
            ? 'You have not declined any tags'
            : 'Nobody has declined a tag you raised';
      case 'Expired':
        return isReceived
            ? 'No tags have lapsed unpaid'
            : 'None of your tags have lapsed unpaid';
      default:
        return isReceived
            ? 'Tags from other users will appear here'
            : 'Tags you create will appear here';
    }
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
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
                icon,
                size: 32.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
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
    );
  }

  Widget _buildCreatedEmptyState() {
    final title = _getEmptyTitle(isReceived: false);
    final subtitle = _selectedFilter == 'All'
        ? 'Tag a user to receive payment from them'
        : _getEmptySubtitle(isReceived: false);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
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
                Icons.sell_outlined,
                size: 32.sp,
                color: const Color(0xFF6B7280),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              title,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 1.4,
              ),
            ),
            if (_selectedFilter == 'All') ...[
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: () async {
                  await Get.toNamed(AppRoutes.createTag);
                  if (context.mounted) {
                    context.read<TagPayCubit>().loadOutgoingTagsPage(page: 1);
                  }
                },
                icon: Icon(Icons.add, size: 20.sp, color: Colors.white),
                label: Text(
                  'Request Funds',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4E03D0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
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
              error,
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
                backgroundColor: const Color(0xFF4E03D0),
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
}
