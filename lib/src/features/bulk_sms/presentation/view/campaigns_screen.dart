import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/bulk_sms_cubit.dart';
import '../cubit/bulk_sms_state.dart';
import '../widgets/bulk_sms_shared_widgets.dart';
import 'bulk_sms_theme.dart';

/// Full list of the user's bulk SMS campaigns (getSmsHistory).
class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<BulkSmsCubit>().loadHistory(pageSize: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BulkSmsTheme.bg,
      body: SafeArea(
        child: Column(
          children: [
            BulkSmsHeader(
              title: 'Campaigns',
              subtitle: 'Your bulk SMS history',
              onBack: () => Get.back(),
            ),
            Expanded(
              child: RefreshIndicator(
                color: BulkSmsTheme.primary,
                onRefresh: () =>
                    context.read<BulkSmsCubit>().loadHistory(pageSize: 50),
                child: BlocBuilder<BulkSmsCubit, BulkSmsState>(
                  builder: (context, state) => _body(state),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(BulkSmsState state) {
    if (state.historyStatus == SectionStatus.loading && state.history.isEmpty) {
      return const Center(
          child: CircularProgressIndicator(color: BulkSmsTheme.primary));
    }
    if (state.historyStatus == SectionStatus.error && state.history.isEmpty) {
      return ListView(
        children: [
          SizedBox(height: 60.h),
          BulkSmsEmptyState(
            icon: Icons.error_outline,
            title: 'Couldn\'t load campaigns',
            subtitle: state.errorMessage ?? 'Pull to refresh to retry.',
          ),
        ],
      );
    }
    if (state.history.isEmpty) {
      return ListView(
        children: const [
          SizedBox(height: 60),
          BulkSmsEmptyState(
            icon: Icons.campaign_outlined,
            title: 'No campaigns yet',
            subtitle: 'Send your first bulk SMS to see it here.',
          ),
        ],
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: state.history.length,
      itemBuilder: (context, i) {
        final c = state.history[i];
        return CampaignTile(
          campaign: c,
          onTap: () => Get.toNamed(
            AppRoutes.bulkSmsCampaignDetail,
            arguments: {'campaignId': c.id, 'campaign': c},
          ),
        );
      },
    );
  }
}
