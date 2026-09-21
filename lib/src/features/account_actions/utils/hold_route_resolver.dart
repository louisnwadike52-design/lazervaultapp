/// Where a "money on hold" row goes when you tap it.
///
/// The held-funds sheet listed each hold with a title, a subtitle and an
/// amount, and nothing happened when you touched one. A user who sees money
/// they cannot spend has exactly one question — *what is holding it?* — and the
/// sheet named the answer without being able to take them to it.
///
/// This reuses the notification deep-link contract rather than inventing a
/// second one: `NotificationRouteResolver` already turns an opaque
/// `(type, data)` pair into a [NotificationTarget], and the two problems are
/// the same problem. Sharing the type also means a hold row and the push
/// notification about the same event land in the SAME place, which they
/// previously could not be relied upon to do.
///
/// ## Precision
///
/// `MyAccountHold` carries `id, amount, currency, reason, service_name,
/// created_at, expires_at, kind, lock_type` — and no `reference`. The id is the
/// RESERVE's id, not the id of the escrow deal or bill purchase that caused it,
/// so nothing on the wire can open the exact record for a service hold. Those
/// resolve to [TargetPrecision.serviceLanding]: the owning service's own
/// screen, where the item sits at the top of the list. That is recorded on the
/// target rather than hidden, so the gap is visible and closes the day
/// `reference` is added to the message.
///
/// PiggyVault locks are the exception and land [TargetPrecision.record]-close,
/// because a lock IS the thing the user is looking for.
library;

import '../../../../core/notifications/notification_target.dart';
import '../../../../core/types/app_routes.dart';

class HoldRouteResolver {
  const HoldRouteResolver._();

  /// Resolve a hold to a destination.
  ///
  /// [kind] is `lock` for a PiggyVault-style lock, otherwise a reservation.
  /// [serviceName] is the service that placed the hold, as stored on the
  /// reserve. Returns null when we genuinely cannot say — the caller then
  /// leaves the row non-tappable rather than sending the user somewhere
  /// arbitrary, because a tap that lands on the dashboard teaches people the
  /// row is broken.
  static NotificationTarget? resolve({
    required String kind,
    required String serviceName,
    String? lockType,
  }) {
    // A lock is its own answer: the money is in a savings plan the user named.
    if (kind.trim().toLowerCase() == 'lock') {
      return const NotificationTarget(
        route: AppRoutes.lockFunds,
        precision: TargetPrecision.record,
      );
    }

    final svc = serviceName.trim().toLowerCase();
    final route = _routeForService(svc);
    if (route == null) return null;

    return NotificationTarget(
      route: route,
      // Landing, not record: see the library doc — the reserve id is not the
      // id of the thing that caused the hold.
      precision: TargetPrecision.serviceLanding,
    );
  }

  /// Service name -> the screen that explains a hold from that service.
  ///
  /// The keys are the values services actually write when reserving (verified
  /// against the reserve call sites), NOT a guessed list. An unknown service
  /// returns null and the row stays non-tappable — deliberately, because
  /// guessing a destination is how a hold row ends up on the dashboard telling
  /// the user nothing.
  static String? _routeForService(String svc) {
    switch (svc) {
      // Savings / PiggyVault plans.
      case 'financial-products-service':
        return AppRoutes.lockFunds;

      // Deposits, withdrawals, card funding.
      case 'banking-service':
        return AppRoutes.transactionHistory;

      // A crypto buy reserves the naira before the order settles.
      case 'crypto-service':
        return AppRoutes.crypto;

      // Airtime, data, electricity, cable — the hold is the purchase.
      case 'utility-payments-service':
      case 'bill_payment':
        return AppRoutes.billsHub;

      case 'giftcards-service':
        return AppRoutes.giftCards;

      case 'exchange-service':
        return AppRoutes.exchangeHome;

      case 'invoice-service':
        return AppRoutes.invoiceList;

      case 'split-bill-service':
        return AppRoutes.splitBills;

      case 'group-accounts-service':
        return AppRoutes.groupAccount;

      case 'payroll-service':
        return AppRoutes.payroll;

      // NOTE: no sprayme route exists in AppRoutes, so a LazerSpray hold
      // stays non-tappable rather than being pointed somewhere plausible.

      // An outbound transfer that has been debited but not yet settled.
      case 'core-payments-service':
      case 'core-payments-batch-transfer':
      case 'core-payments-admin':
      case 'transfer':
      case 'accounts-service':
        return AppRoutes.transactionHistory;

      default:
        return null;
    }
  }
}
