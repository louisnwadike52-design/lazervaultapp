part of 'payment_history_screen.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      )..getMyContactlessPayments(),
      child: const _PaymentHistoryView(),
    );
  }
}

class _PaymentHistoryView extends StatefulWidget {
  const _PaymentHistoryView();

  @override
  State<_PaymentHistoryView> createState() => _PaymentHistoryViewState();
}

class _PaymentHistoryViewState extends State<_PaymentHistoryView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
    final cubit = context.read<ContactlessPaymentCubit>();
    if (_tabController.index == 0) {
      cubit.getMyContactlessPayments();
    } else {
      cubit.getMyPaymentSessions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27), Color(0xFF0F0F23)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      'Payment History',
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              // Tab bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
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
                    tabs: const [
                      Tab(text: 'Transactions'),
                      Tab(text: 'Sessions'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              // Tab content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _TransactionsTab(),
                    _SessionsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TransactionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactlessPaymentCubit, ContactlessPaymentState>(
      builder: (context, state) {
        if (state is ContactlessPaymentLoading) {
          return _buildShimmerLoading();
        }

        if (state is ContactlessPaymentsLoaded) {
          if (state.transactions.isEmpty) {
            return _EmptyState(
              icon: Icons.receipt_long_rounded,
              title: 'No Transactions Yet',
              subtitle:
                  'Your contactless payment transactions will appear here',
            );
          }

          return RefreshIndicator(
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF2A2A3E),
            onRefresh: () async {
              context
                  .read<ContactlessPaymentCubit>()
                  .getMyContactlessPayments();
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: state.transactions.length,
              itemBuilder: (context, index) {
                final transaction = state.transactions[index];
                return _TransactionCard(
                  transaction: transaction,
                  index: index,
                );
              },
            ),
          );
        }

        if (state is ContactlessPaymentError) {
          return _ErrorState(
            message: state.message,
            onRetry: () {
              context
                  .read<ContactlessPaymentCubit>()
                  .getMyContactlessPayments();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          height: 80.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16.r),
          ),
        );
      },
    );
  }
}

class _SessionsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactlessPaymentCubit, ContactlessPaymentState>(
      builder: (context, state) {
        if (state is ContactlessPaymentLoading) {
          return _buildShimmerLoading();
        }

        if (state is PaymentSessionsLoaded) {
          if (state.sessions.isEmpty) {
            return _EmptyState(
              icon: Icons.contactless_rounded,
              title: 'No Sessions Yet',
              subtitle: 'Payment sessions you create will appear here',
            );
          }

          return RefreshIndicator(
            color: const Color(0xFF6366F1),
            backgroundColor: const Color(0xFF2A2A3E),
            onRefresh: () async {
              context
                  .read<ContactlessPaymentCubit>()
                  .getMyPaymentSessions();
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: state.sessions.length,
              itemBuilder: (context, index) {
                final session = state.sessions[index];
                return _SessionCard(session: session, index: index);
              },
            ),
          );
        }

        if (state is ContactlessPaymentError) {
          return _ErrorState(
            message: state.message,
            onRetry: () {
              context
                  .read<ContactlessPaymentCubit>()
                  .getMyPaymentSessions();
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          height: 90.h,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(16.r),
          ),
        );
      },
    );
  }
}

class _SessionCard extends StatelessWidget {
  final PaymentSessionEntity session;
  final int index;

  const _SessionCard({required this.session, required this.index});

  Color _getStatusColor(PaymentSessionStatus status) {
    switch (status) {
      case PaymentSessionStatus.pending:
        return const Color(0xFFF59E0B);
      case PaymentSessionStatus.read:
        return const Color(0xFF3B82F6);
      case PaymentSessionStatus.processing:
        return const Color.fromARGB(255, 78, 3, 208);
      case PaymentSessionStatus.completed:
        return const Color(0xFF10B981);
      case PaymentSessionStatus.cancelled:
        return const Color(0xFFEF4444);
      case PaymentSessionStatus.expired:
        return const Color(0xFF6B7280);
    }
  }

  String _getStatusText(PaymentSessionStatus status) {
    switch (status) {
      case PaymentSessionStatus.pending:
        return 'PENDING';
      case PaymentSessionStatus.read:
        return 'READ';
      case PaymentSessionStatus.processing:
        return 'PROCESSING';
      case PaymentSessionStatus.completed:
        return 'COMPLETED';
      case PaymentSessionStatus.cancelled:
        return 'CANCELLED';
      case PaymentSessionStatus.expired:
        return 'EXPIRED';
    }
  }

  IconData _getStatusIcon(PaymentSessionStatus status) {
    switch (status) {
      case PaymentSessionStatus.pending:
        return Icons.schedule_rounded;
      case PaymentSessionStatus.read:
        return Icons.visibility_rounded;
      case PaymentSessionStatus.processing:
        return Icons.sync_rounded;
      case PaymentSessionStatus.completed:
        return Icons.check_circle_rounded;
      case PaymentSessionStatus.cancelled:
        return Icons.cancel_rounded;
      case PaymentSessionStatus.expired:
        return Icons.timer_off_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy • h:mm a');
    final statusColor = _getStatusColor(session.status);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 20 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
          ),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: statusColor.withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Status icon
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    _getStatusIcon(session.status),
                    size: 22.sp,
                    color: statusColor,
                  ),
                ),
                SizedBox(width: 14.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            session.formattedAmount,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              _getStatusText(session.status),
                              style: GoogleFonts.inter(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w700,
                                color: statusColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        dateFormat.format(session.createdAt),
                        style: GoogleFonts.inter(
                          fontSize: 11.sp,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),

                Icon(
                  Icons.chevron_right_rounded,
                  size: 20.sp,
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                ),
              ],
            ),

            // Payer info if available
            if (session.payerName != null) ...[
              SizedBox(height: 12.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_rounded,
                      size: 16.sp,
                      color: const Color(0xFF10B981),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Paid by ${session.payerName}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Description if available
            if (session.description != null &&
                session.description!.isNotEmpty) ...[
              SizedBox(height: 8.h),
              Text(
                session.description!,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.7),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _EmptyState({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 36.sp,
                color: const Color(0xFF6366F1).withValues(alpha: 0.5),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(48.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 36.sp,
                color: const Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Something went wrong',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: GoogleFonts.inter(
                fontSize: 13.sp,
                color: const Color(0xFF9CA3AF),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 44.h,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: Icon(Icons.refresh_rounded, size: 18.sp),
                  label: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
