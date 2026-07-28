import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/autosave/domain/entities/autosave_rule_entity.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_cubit.dart';
import 'package:lazervault/src/features/autosave/presentation/cubit/autosave_state.dart';
import 'package:lazervault/src/features/autosave/presentation/widgets/autosave_progress_indicator.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';

class AutoSaveDashboardScreen extends StatefulWidget {
  const AutoSaveDashboardScreen({super.key});

  @override
  State<AutoSaveDashboardScreen> createState() =>
      _AutoSaveDashboardScreenState();
}

class _AutoSaveDashboardScreenState extends State<AutoSaveDashboardScreen> {
  AutoSaveStatisticsEntity? _statistics;
  List<AutoSaveRuleEntity> _rules = [];
  bool _isLoadingStatistics = true;
  bool _isLoadingRules = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboardData();
    });
  }

  Future<void> _loadDashboardData() async {
    setState(() {
      _isLoadingStatistics = true;
      _isLoadingRules = true;
    });

    context.read<AutoSaveCubit>().loadDashboard();
  }

  /// Hardware-back / Get.back from the autosave dashboard used to
  /// stall because the navigation stack accumulated several pushes
  /// (create flow, list, transactions, edit, etc.). We now collapse
  /// the autosave sub-stack on exit and land the user on the main
  /// app dashboard's active-services carousel — the screen they
  /// originally launched the autosave service from.
  void _exitToDashboard() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      // popUntil with a name predicate scrubs every autosave route.
      navigator.popUntil((r) =>
          r.isFirst ||
          r.settings.name == AppRoutes.dashboard ||
          r.settings.name == AppRoutes.home);
    }
    // Defensive — if the predicate above didn't find a match (e.g.
    // the user deep-linked into autosave from a notification), reset
    // the stack to the main dashboard outright.
    if (Get.currentRoute != AppRoutes.dashboard &&
        Get.currentRoute != AppRoutes.home) {
      Get.offAllNamed(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Intercept hardware back too. canPop=false stops the default
      // single-route pop (which is what got stuck before); the
      // callback runs our explicit stack-flush.
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _exitToDashboard();
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocListener<AutoSaveCubit, AutoSaveState>(
          listener: (context, state) {
            if (state is AutoSaveDashboardLoaded) {
              setState(() {
                _statistics = state.statistics;
                _rules = state.rules;
                _isLoadingStatistics = false;
                _isLoadingRules = false;
              });
            } else if (state is AutoSaveStatisticsLoaded) {
              setState(() {
                _statistics = state.statistics;
                _isLoadingStatistics = false;
              });
            } else if (state is AutoSaveRulesLoaded) {
              setState(() {
                _rules = state.rules;
                _isLoadingRules = false;
              });
            } else if (state is AutoSaveError) {
              setState(() {
                _isLoadingStatistics = false;
                _isLoadingRules = false;
              });
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
            } else if (state is AutoSaveRuleDeleted) {
              Get.snackbar(
                'Success',
                'Rule deleted successfully',
                backgroundColor: const Color(0xFF10B981),
                colorText: Colors.white,
                snackPosition: SnackPosition.TOP,
              );
              _loadDashboardData();
            }
          },
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: ServiceEntranceAnimation(
                  child: RefreshIndicator(
                  onRefresh: _loadDashboardData,
                  color: const Color(0xFF4E03D0),
                  backgroundColor: const Color(0xFF1F1F1F),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildMetricsCard(),
                        SizedBox(height: 24.h),
                        _buildActionButtons(),
                        SizedBox(height: 32.h),
                        _buildActiveRulesSection(),
                      ],
                    ),
                  ),
                ),
                ),
              ),
            ],
          ),
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
          GestureDetector(
            // Always exit the entire autosave sub-stack — see
            // _exitToDashboard for why a plain Get.back was getting
            // stuck after several pushes inside the feature.
            onTap: _exitToDashboard,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey[900],
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
                  'Auto-Save',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Automate your savings goals',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ),
          ServiceVoiceButton(
            serviceName: 'autosave',
            iconColor: _brand,
            backgroundColor: _brand,
          ),
          SizedBox(width: 8.w),
          MicroserviceChatIcon(
            serviceName: 'Auto-Save',
            sourceContext: 'financial_products',
            icon: Icons.chat_bubble_outline,
            iconColor: _brand,
          ),
        ],
      ),
    );
  }

  // Brand purple — matches the Joint Funds / contribution surfaces so the
  // savings hero reads as part of the same product family.
  static const Color _brand = Color(0xFF4E03D0);

  /// Shared shell for the hero card: brand-purple gradient + glow, the
  /// "Savings Overview" header row, and a body the caller supplies (the
  /// stat row, a spinner, or the empty-state copy).
  Widget _heroShell({required Widget body}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _brand,
            _brand.withValues(alpha: 0.82),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: _brand.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.savings_rounded,
                    size: 20.sp, color: Colors.white),
              ),
              SizedBox(width: 10.w),
              Text(
                'Savings Overview',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          body,
        ],
      ),
    );
  }

  Widget _buildMetricsCard() {
    if (_isLoadingStatistics) {
      return _heroShell(
        body: SizedBox(
          height: 56.h,
          child: const Center(
            child: LazerVaultLoader.small(),
          ),
        ),
      );
    }

    if (_statistics == null) {
      return _heroShell(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Start saving',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'Create your first rule to save automatically.',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.85),
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      );
    }

    return StreamBuilder<String>(
      stream: CurrencySymbols.currencySymbolStream,
      builder: (context, snapshot) {
        return _heroShell(
          body: Row(
            children: [
              Expanded(
                child: _buildMetricItem(
                  label: 'Active Rules',
                  value: _statistics!.activeRulesCount.toString(),
                ),
              ),
              _heroDivider(),
              Expanded(
                child: _buildMetricItem(
                  label: 'Total Saved',
                  value: _statistics!.formattedTotalSavedAllTime,
                ),
              ),
              _heroDivider(),
              Expanded(
                child: _buildMetricItem(
                  label: 'This Month',
                  value: _statistics!.formattedTotalSavedThisMonth,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _heroDivider() => Container(
        width: 1,
        height: 38.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        color: Colors.white.withValues(alpha: 0.2),
      );

  Widget _buildMetricItem({required String label, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FittedBox so long currency figures (e.g. ₦1,250,000.00) shrink
        // to fit their column instead of wrapping or overflowing — the
        // alignment bug the old spaceAround row had.
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            maxLines: 1,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    // Three lanes — Create, All Rules, Transactions — sit side-by-
    // side. Rules and transactions are distinct surfaces: a rule
    // is the config that fires; each fire (manual or scheduled)
    // becomes a transaction. The Transactions screen lists those
    // fires with filters / search / detail sheet.
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            icon: Icons.add_circle_outline,
            label: 'Create Rule',
            color: const Color(0xFF4E03D0),
            onTap: () => Get.toNamed(AppRoutes.createAutoSaveRule),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.list_alt_outlined,
            label: 'All Rules',
            color: const Color(0xFF10B981),
            onTap: () => Get.toNamed(AppRoutes.autoSaveRulesList),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildActionButton(
            icon: Icons.receipt_long_outlined,
            label: 'Transactions',
            color: const Color(0xFF3B82F6),
            onTap: () => Get.toNamed(AppRoutes.autoSaveTransactions),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, size: 22.sp, color: color),
            ),
            SizedBox(height: 10.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 12.5.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveRulesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Rules',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (_rules.isNotEmpty)
              TextButton(
                onPressed: () => Get.toNamed(AppRoutes.autoSaveRulesList),
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF4E03D0),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 16.h),
        if (_isLoadingRules)
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.h),
              child: LazerVaultLoader.small(),
            ),
          )
        else if (_rules.isEmpty)
          _buildEmptyRulesState()
        else
          Column(
            children:
                _rules.take(5).map((rule) => _buildRuleCard(rule)).toList(),
          ),
      ],
    );
  }

  Widget _buildEmptyRulesState() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(32.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 48.sp,
              color: const Color(0xFF6B7280),
            ),
            SizedBox(height: 16.h),
            Text(
              'No Active Rules',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Create your first rule to start\nsaving automatically',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleCard(AutoSaveRuleEntity rule) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.autoSaveDetails,
        arguments: rule,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Leading trigger badge — tints the card by trigger type so
                // the list scans at a glance (matches the contribution-card
                // leading-icon pattern on the Joint Funds surface).
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: _triggerColor(rule.triggerType)
                        .withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(
                    _triggerIcon(rule.triggerType),
                    color: _triggerColor(rule.triggerType),
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    rule.name,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(rule.status).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    _getStatusText(rule.status),
                    style: TextStyle(
                      color: _getStatusColor(rule.status),
                      fontSize: 9.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${rule.triggerDescription} • ${rule.amountDescription}',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (rule.targetAmount != null) ...[
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    rule.formattedProgress,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF4E03D0),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '${rule.progressPercentage.toStringAsFixed(0)}%',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              AutoSaveProgressIndicator(
                progressPercentage: rule.progressPercentage,
                height: 6,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Per-trigger accent + icon for the rule-card leading badge. Mirrors the
  // create-rule wizard's trigger tints so the colour means the same thing
  // everywhere in the feature.
  Color _triggerColor(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return const Color(0xFF3B82F6);
      case TriggerType.scheduled:
        return const Color(0xFF10B981);
      case TriggerType.roundUp:
        return const Color(0xFFF59E0B);
      case TriggerType.externalInflow:
        return const Color(0xFFFB923C);
      case TriggerType.scheduledExternal:
        return const Color(0xFF14B8A6);
      default:
        return _brand;
    }
  }

  IconData _triggerIcon(TriggerType t) {
    switch (t) {
      case TriggerType.onDeposit:
        return Icons.south_rounded;
      case TriggerType.scheduled:
        return Icons.schedule_rounded;
      case TriggerType.roundUp:
        return Icons.trending_up_rounded;
      case TriggerType.externalInflow:
        return Icons.account_balance_rounded;
      case TriggerType.scheduledExternal:
        return Icons.account_balance_wallet_rounded;
      default:
        return Icons.savings_rounded;
    }
  }

  Color _getStatusColor(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return const Color(0xFF10B981);
      case AutoSaveStatus.paused:
        return const Color(0xFFF59E0B);
      case AutoSaveStatus.completed:
        return const Color(0xFF3B82F6);
      case AutoSaveStatus.cancelled:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  String _getStatusText(AutoSaveStatus status) {
    switch (status) {
      case AutoSaveStatus.active:
        return 'ACTIVE';
      case AutoSaveStatus.paused:
        return 'PAUSED';
      case AutoSaveStatus.completed:
        return 'COMPLETED';
      case AutoSaveStatus.cancelled:
        return 'CANCELLED';
      default:
        return 'UNKNOWN';
    }
  }
}
