import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/shared_widgets/service_entrance_animation.dart';
import 'package:lazervault/src/features/uplift/presentation/cubit/uplift_cubit.dart';
import 'package:lazervault/src/features/uplift/presentation/views/apply_uplift_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/create_uplift_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_detail_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/views/uplift_receipt_screen.dart';
import 'package:lazervault/src/features/uplift/presentation/widgets/uplift_widgets.dart';
import 'package:lazervault/src/generated/uplift.pbgrpc.dart' as up;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/microservice_chat/presentation/widgets/microservice_chat_icon.dart';
import 'package:lazervault/src/features/widgets/service_voice_button.dart';

/// Entry point for Uplift ("fund a business"). Three tabs cover both journeys:
/// Discover (apply to funds) · My Funds (funder) · My Applications (applicant).
class UpliftHomeScreen extends StatefulWidget {
  const UpliftHomeScreen({super.key});

  @override
  State<UpliftHomeScreen> createState() => _UpliftHomeScreenState();
}

const _kUpliftCategories = ['All', 'Agri-tech', 'Retail', 'Technology', 'Health', 'Education', 'Creative', 'Services'];

class _UpliftHomeScreenState extends State<UpliftHomeScreen> {
  late final UpliftCubit _cubit;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<UpliftCubit>()..loadAll();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: kUpBg,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            title: Text('Lazerfunds', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            actions: [
              ServiceVoiceButton(
                serviceName: 'uplift',
                iconColor: kUpPrimary,
                backgroundColor: kUpPrimary,
                buttonSize: 34.w,
                iconSize: 17.sp,
              ),
              SizedBox(width: 8.w),
              MicroserviceChatIcon(
                serviceName: 'Lazerfunds',
                sourceContext: 'uplift',
                iconColor: kUpPrimary,
                size: 34,
                iconSize: 17,
              ),
              SizedBox(width: 12.w),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: kUpPrimary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text('Open a fund', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
            onPressed: () async {
              await Get.to(() => const CreateUpliftScreen());
              _cubit.refreshMine();
            },
          ),
          // Uniform pure-black surface (matches the transparent app bar) — no
          // page gradient here, so there's no seam between the app bar/tabs and
          // the content below.
          // AppBar (the "Lazerfunds" title) stays static; the content below —
          // segmented tabs + tab views — rises + fades in on load.
          body: DefaultTextStyle.merge(
            style: GoogleFonts.inter(color: Colors.white),
            child: ServiceEntranceAnimation(
              child: Column(
                children: [
                  const UpSegmentedTabs(tabs: [
                    Tab(child: _TabLabel(icon: Icons.explore_outlined, text: 'Discover')),
                    Tab(child: _TabLabel(icon: Icons.volunteer_activism_outlined, text: 'My Funds')),
                    Tab(child: _TabLabel(icon: Icons.inbox_outlined, text: 'My Applications')),
                  ]),
                  Expanded(
                    child: BlocBuilder<UpliftCubit, UpliftState>(
                      builder: (context, state) {
                        return TabBarView(
                          children: [
                            _discoverTab(state),
                            _myFundsTab(state),
                            _myApplicationsTab(state),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _discoverTab(UpliftState state) {
    return Column(
      children: [
        _discoverHeader(state),
        Expanded(child: _discoverBody(state)),
      ],
    );
  }

  Widget _discoverHeader(UpliftState state) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _searchCtrl,
            textInputAction: TextInputAction.search,
            style: const TextStyle(color: Colors.white),
            onChanged: (_) => setState(() {}),
            onSubmitted: (v) => _cubit.searchDiscover(query: v.trim()),
            decoration: InputDecoration(
              hintText: 'Search funds',
              hintStyle: const TextStyle(color: kUpTextSecondary),
              prefixIcon: const Icon(Icons.search, color: kUpTextSecondary),
              suffixIcon: _searchCtrl.text.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.close, color: kUpTextSecondary),
                      onPressed: () {
                        _searchCtrl.clear();
                        _cubit.searchDiscover(query: '');
                      },
                    ),
              filled: true,
              fillColor: kUpCard,
              isDense: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 34,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kUpliftCategories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) {
                final c = _kUpliftCategories[i];
                final value = c == 'All' ? '' : c;
                final selected = state.category == value;
                return ChoiceChip(
                  label: Text(c),
                  selected: selected,
                  onSelected: (_) => _cubit.searchDiscover(category: value),
                  labelStyle: TextStyle(color: selected ? Colors.white : kUpTextSecondary, fontSize: 12),
                  backgroundColor: kUpCard,
                  selectedColor: kUpPrimary,
                  side: BorderSide.none,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _discoverBody(UpliftState state) {
    if (state.loading && state.discover.isEmpty && state.recentReceipts.isEmpty) return const UpLoading();
    if (state.error != null && state.discover.isEmpty) return UpErrorState(message: state.error!, onRetry: _cubit.loadAll);
    // Single scroll: fund cards → load-more → "Recent activity" section pinned at
    // the bottom of the landing (crypto pattern; replaces the app-bar icon).
    return RefreshIndicator(
      onRefresh: _cubit.refreshDiscover,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        children: [
          if (state.discover.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 28),
              child: Center(child: Text('No open funds match your search.', style: TextStyle(color: kUpTextSecondary))),
            )
          else
            for (final f in state.discover)
              UpliftFundCard(
                fund: f,
                onTap: () async {
                  await Get.to(() => UpliftDetailScreen(fundId: f.id));
                  _cubit.loadAll();
                },
                trailing: TextButton(
                  onPressed: () async {
                    await Get.to(() => ApplyUpliftScreen(fund: f));
                    _cubit.refreshMine();
                  },
                  child: const Text('Apply', style: TextStyle(color: kUpPrimarySoft, fontWeight: FontWeight.w600)),
                ),
              ),
          if (state.discoverHasMore)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: state.discoverLoadingMore
                    ? const CircularProgressIndicator(color: kUpPrimary)
                    : OutlinedButton(
                        onPressed: _cubit.loadMoreDiscover,
                        style: OutlinedButton.styleFrom(foregroundColor: kUpPrimary, side: const BorderSide(color: kUpDivider)),
                        child: const Text('Load more'),
                      ),
              ),
            ),
          const SizedBox(height: 8),
          UpRecentActivitySection(
            receipts: state.recentReceipts,
            onViewAll: () => Get.to(() => const UpliftReceiptsListScreen()),
            onTap: (r) => Get.to(() => UpliftReceiptScreen(receipt: r)),
          ),
        ],
      ),
    );
  }

  Widget _myFundsTab(UpliftState state) {
    if (state.loading && state.myFunds.isEmpty) return const UpLoading();
    if (state.error != null && state.myFunds.isEmpty) return UpErrorState(message: state.error!, onRetry: _cubit.loadAll);
    if (state.myFunds.isEmpty) {
      return UpEmptyState(
        icon: Icons.volunteer_activism_outlined,
        title: 'No funds yet',
        subtitle: 'Open a fund to back businesses you believe in.',
        action: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: kUpPrimary, foregroundColor: Colors.white),
          onPressed: () async {
            await Get.to(() => const CreateUpliftScreen());
            _cubit.refreshMine();
          },
          icon: const Icon(Icons.add),
          label: const Text('Open a fund'),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _cubit.refreshMine,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.myFunds.length,
        itemBuilder: (_, i) {
          final f = state.myFunds[i];
          return UpliftFundCard(
            fund: f,
            onTap: () async {
              await Get.to(() => UpliftDetailScreen(fundId: f.id));
              _cubit.refreshMine();
            },
          );
        },
      ),
    );
  }

  Widget _myApplicationsTab(UpliftState state) {
    if (state.loading && state.myApplications.isEmpty) return const UpLoading();
    if (state.error != null && state.myApplications.isEmpty) return UpErrorState(message: state.error!, onRetry: _cubit.loadAll);
    if (state.myApplications.isEmpty) {
      return const UpEmptyState(
        icon: Icons.inbox_outlined,
        title: 'No applications yet',
        subtitle: 'Apply to a fund from the Discover tab to get started.',
      );
    }
    return RefreshIndicator(
      onRefresh: _cubit.refreshMine,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.myApplications.length,
        itemBuilder: (_, i) {
          final a = state.myApplications[i];
          return UpliftApplicationCard(
            application: a,
            onTap: () async {
              await Get.to(() => UpliftDetailScreen(fundId: a.fundId, applicationId: a.id));
              _cubit.refreshMine();
            },
          );
        },
      ),
    );
  }
}

/// Icon + text label used inside the segmented tabs.
class _TabLabel extends StatelessWidget {
  const _TabLabel({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(text),
        ],
      );
}

// Re-export helper so callers can build cards without a direct proto import.
typedef UpFund = up.UpliftFundMessage;
