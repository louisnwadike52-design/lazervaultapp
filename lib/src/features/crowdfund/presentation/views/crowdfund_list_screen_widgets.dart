part of 'crowdfund_list_screen.dart';

/// Cached campaign metadata used by the My Funded tab to resolve
/// real campaign titles + render the correct status badge without
/// hitting the network on every render.
class _CampaignMeta {
  final String title;
  final String status;
  const _CampaignMeta({required this.title, required this.status});

  @override
  bool operator ==(Object other) =>
      other is _CampaignMeta && other.title == title && other.status == status;

  @override
  int get hashCode => Object.hash(title, status);
}
