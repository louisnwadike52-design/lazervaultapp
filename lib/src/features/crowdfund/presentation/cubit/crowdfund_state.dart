import 'package:equatable/equatable.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';
part 'crowdfund_state_widgets.dart';


/// Single crowdfund details loaded with donations.
///
/// Pagination fields (`donationsPage`, `hasMoreDonations`,
/// `isLoadingMoreDonations`) drive the infinite-scroll list of donors on
/// the detail screen. The cubit appends to `donations` as the user
/// scrolls, so the same field is used for both the initial 10-row paint
/// and any later pages — there is no separate "load all" toggle.
class CrowdfundDetailsLoaded extends CrowdfundState {
  final Crowdfund crowdfund;
  final List<CrowdfundDonation> donations;
  final CrowdfundStatistics? statistics;
  final bool isStale;

  final int donationsPage;
  final int donationsPageSize;
  final bool hasMoreDonations;
  final bool isLoadingMoreDonations;

  const CrowdfundDetailsLoaded({
    required this.crowdfund,
    required this.donations,
    this.statistics,
    this.isStale = false,
    this.donationsPage = 1,
    this.donationsPageSize = 10,
    this.hasMoreDonations = false,
    this.isLoadingMoreDonations = false,
  });

  CrowdfundDetailsLoaded copyWith({
    Crowdfund? crowdfund,
    List<CrowdfundDonation>? donations,
    CrowdfundStatistics? statistics,
    bool? isStale,
    int? donationsPage,
    int? donationsPageSize,
    bool? hasMoreDonations,
    bool? isLoadingMoreDonations,
  }) {
    return CrowdfundDetailsLoaded(
      crowdfund: crowdfund ?? this.crowdfund,
      donations: donations ?? this.donations,
      statistics: statistics ?? this.statistics,
      isStale: isStale ?? this.isStale,
      donationsPage: donationsPage ?? this.donationsPage,
      donationsPageSize: donationsPageSize ?? this.donationsPageSize,
      hasMoreDonations: hasMoreDonations ?? this.hasMoreDonations,
      isLoadingMoreDonations:
          isLoadingMoreDonations ?? this.isLoadingMoreDonations,
    );
  }

  @override
  List<Object?> get props => [
        crowdfund,
        donations,
        statistics,
        isStale,
        donationsPage,
        donationsPageSize,
        hasMoreDonations,
        isLoadingMoreDonations,
      ];
}

