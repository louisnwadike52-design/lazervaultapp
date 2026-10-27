import 'package:lazervault/core/cache/session_page_store.dart';

import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import 'insurance_state.dart';

/// Page one of the insurance hub, remembered across opens.
///
/// WHY: `InsuranceCubit` is a FACTORY, so every open of the hub started from
/// `InsuranceInitial`, emitted `InsuranceLoading` and sat on a full-screen
/// loader while page one (plus the three companion RPCs) came back — over
/// policies the user had looked at moments ago. The hub now paints this page
/// at once and refreshes it behind.
///
/// The companions (recent / overdue payments, the stat row's totals) are kept
/// WITH the policies: painting page one with zeros in the stat row would be
/// its own kind of blink.
///
/// In memory only — `Insurance` carries no JSON codec, so a cold start still
/// pays one loader. Per user (stamped) and cleared with every other
/// SessionPageStore on a user switch.
class InsuranceHubPage {
  const InsuranceHubPage({
    required this.insurances,
    required this.recentPayments,
    required this.overduePayments,
    required this.statistics,
    required this.hasMore,
  });

  final List<Insurance> insurances;
  final List<InsurancePayment> recentPayments;
  final List<InsurancePayment> overduePayments;
  final Map<String, dynamic> statistics;
  final bool hasMore;

  factory InsuranceHubPage.fromState(InsurancesLoaded s) => InsuranceHubPage(
        insurances: s.insurances,
        recentPayments: s.recentPayments,
        overduePayments: s.overduePayments,
        statistics: s.statistics,
        hasMore: s.hasMore,
      );

  /// The state the hub paints from, exactly as a fresh page-one load emits it.
  InsurancesLoaded toState() => InsurancesLoaded(
        insurances: insurances,
        recentPayments: recentPayments,
        overduePayments: overduePayments,
        statistics: statistics,
        hasMore: hasMore,
        currentPage: 1,
        isLoadingMore: false,
      );
}

class InsuranceHubPageStore {
  InsuranceHubPageStore._();

  /// One entry: the whole first page with its companions.
  static final SessionPageStore<InsuranceHubPage> page1 =
      SessionPageStore<InsuranceHubPage>('insurance_hub_page1');

  /// The remembered page as a paintable state, or null when there is none
  /// for this user.
  static InsurancesLoaded? peek(String userId) {
    if (userId.isEmpty) return null;
    final rows = page1.peek(userId: userId);
    if (rows == null || rows.isEmpty) return null;
    return rows.first.toState();
  }

  /// Remember a freshly loaded page one. Only page one: a scroll-loaded
  /// second page belongs to the cubit that appended it.
  static void remember(InsurancesLoaded loaded, {required String userId}) {
    if (userId.isEmpty) return;
    page1.put([InsuranceHubPage.fromState(loaded)], userId: userId);
  }
}
