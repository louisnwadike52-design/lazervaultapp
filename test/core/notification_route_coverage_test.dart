import 'package:flutter_test/flutter_test.dart';
import 'package:lazervault/core/notifications/notification_route_resolver.dart';
import 'package:lazervault/core/notifications/notification_service_icon.dart';
import 'package:lazervault/core/notifications/notification_target.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/presentation/app_router.dart';

/// Asserts every destination the resolver can name is actually registered.
///
/// The resolver returns route NAMES. A name that no `GetPage` registers does
/// not fail loudly — `Get.toNamed` on an unknown route is a dead tap, and a
/// dead tap on a notification is indistinguishable from the app ignoring you.
/// Nothing else in the build checks that the two lists agree: the resolver
/// references `AppRoutes` constants, which exist whether or not a page is
/// wired to them.
///
/// This sweeps the resolver over every notification type the platform emits,
/// collects the routes it hands back, and checks each against the router.
void main() {
  /// Route names registered by the app, including the parameterised ones.
  late Set<String> registered;
  late List<String> parameterised;

  setUpAll(() {
    registered = AppRouter.routes.map((p) => p.name).toSet();
    // e.g. "/escrow/detail/:reference" — matched by prefix below.
    parameterised = registered.where((n) => n.contains('/:')).toList();
  });

  bool isRegistered(String route) {
    if (registered.contains(route)) return true;
    for (final p in parameterised) {
      final prefix = p.substring(0, p.indexOf('/:') + 1);
      if (route.startsWith(prefix) && route.length > prefix.length) return true;
    }
    return false;
  }

  /// Every type notifications-service emits, plus the payload shapes that
  /// change which branch the resolver takes.
  const cases = <(String, Map<String, dynamic>)>[
    ('transfer.sent', {}),
    ('transfer.received', {}),
    ('transfer.reversed', {}),
    ('transfer.failed', {}),
    ('payment', {}),
    ('payment', {'payment_method': 'card'}),
    ('deposit', {}),
    ('withdrawal', {}),
    ('refund', {}),
    ('fee', {}),
    ('exchange', {}),
    ('rmb', {}),
    ('batch_transfer', {}),
    ('recurring_transfer_success', {}),
    ('recurring_transfer_auto_paused', {'entity_id': 'rt-1'}),
    ('invoice', {}),
    ('invoice', {'entity_id': 'inv-1'}),
    ('invoice.external_tag', {'entity_id': 'inv-2'}),
    ('giftcard', {}),
    ('giftcard', {'reference': 'GC-1'}),
    ('escrow', {}),
    ('escrow', {'deal_id': 'deal-1'}),
    // A reference that would corrupt the path if not encoded.
    ('escrow', {'deal_id': 'a/b?c#d'}),
    ('electricity_payment_completed', {}),
    ('cable', {}),
    ('internet', {}),
    ('water', {}),
    ('education', {}),
    ('betting', {}),
    ('epin', {}),
    ('airtime', {}),
    ('airtime_to_cash', {}),
    ('data', {}),
    ('bill', {}),
    ('bill', {'biller_name': 'Ikeja Electric'}),
    ('bill', {'biller_name': 'DStv'}),
    ('bill', {'biller_name': 'Lagos Water'}),
    ('subscription', {}),
    ('crypto', {}),
    ('crypto.order_filled', {}),
    ('stocks', {}),
    ('investment', {}),
    ('investment', {'entity_type': 'group_account', 'entity_id': 'g-1'}),
    ('investment', {'entity_type': 'group_account'}),
    ('investment', {'entity_type': 'crowdfund'}),
    ('investment', {'entity_type': 'insurance'}),
    ('insurance', {}),
    ('insurance.claim_approved', {}),
    ('autosave', {}),
    ('lock_funds', {}),
    ('goal', {}),
    ('crowdfund', {}),
    ('qr_pay', {}),
    ('id_pay', {}),
    ('contactless', {}),
    ('card', {}),
    ('payroll', {}),
    ('expense', {}),
    ('bulk_sms', {}),
    ('split_bill.created', {}),
    ('split_bill.reminder', {'split_bill_id': 'sb-1'}),
    ('tagpay.request', {}),
    ('tagpay.claimed', {}),
    ('p2p_message', {}),
    ('p2p_message', {'sender_user_id': 'u-1'}),
    ('financial_connection', {}),
    ('family', {}),
    ('family.invitation', {}),
    ('family', {'family_id': 'f-1'}),
    ('group', {}),
    ('group', {'group_id': 'g-1'}),
    ('group.invitation', {}),
    ('referral', {}),
    ('birthday', {}),
    ('security', {}),
    ('security', {'event_type': 'transaction_pin.admin_reset'}),
    ('security', {'event_type': 'passcode_changed'}),
    ('security', {'event_type': 'biometric_enrolled'}),
    ('kyc', {}),
    ('kyc', {'event_type': 'document_required'}),
    ('account', {}),
    ('budget_exceeded', {}),
    ('planning_reminder', {}),
    ('ops_alert', {}),
    ('statement', {}),
    ('plain', {}),
    ('test', {}),

    // ---- Types from the GENERIC notification path --------------------------
    // GenericNotificationEvent carries a producer-supplied type string, so a
    // dozen services can publish anything they like. These are the real values
    // in the tree, and they are the ones most likely to be missed: they do not
    // follow the domain-prefix convention the enum-backed handlers use.
    ('uplift_disbursement', {}),
    ('uplift_disbursement_rollback', {}),
    ('inventory_low_stock', {}),
    ('scheduled_payroll', {}),
    ('planning_email_digest', {}),
    ('autosave_mandate_reauth_required', {}),
    ('autosave.triggered', {}),
    ('connection.birthday', {}),
    ('security.fraud_freeze', {}),
    ('kyc.verified', {}),
    ('group_funds_auto_charge_failed', {}),
    ('group_funds_auto_charge_failed_creator', {}),
    ('escrow_funded', {}),
    ('escrow_released', {}),
  ];

  test('every route the resolver names is registered in the router', () {
    final missing = <String>{};
    for (final (type, data) in cases) {
      final t = NotificationRouteResolver.resolve(type, data);
      if (t == null) continue;
      if (!isRegistered(t.route)) missing.add('$type -> ${t.route}');
    }
    expect(
      missing,
      isEmpty,
      reason: 'these notifications would open a route the app does not '
          'register, which is a dead tap:\n${missing.join('\n')}',
    );
  });

  test('the feed fallback route is registered', () {
    // The navigator falls back here for an unknown type and after a failed
    // navigation. If it were missing, the fallback would itself be a dead tap.
    expect(isRegistered('/notifications'), isTrue);
  });

  test('a path-param target is built as a usable path', () {
    final t =
        NotificationRouteResolver.resolve('escrow', {'deal_id': 'a/b?c#d'});
    // Encoded, so the reference cannot break out of its path segment and send
    // the user somewhere else.
    expect(t!.route, isNot(contains('a/b')));
    expect(t.route.startsWith('/escrow/detail/'), isTrue);
  });

  test('generic-path types reach the right service, not just any page', () {
    // Each of these went somewhere wrong or nowhere before: the generic path's
    // type strings do not follow the domain-prefix convention, so a
    // prefix-only match dropped them to the feed.
    NotificationTarget? r(String t) => NotificationRouteResolver.resolve(t, {});

    // An email digest is about the inbox. It also matches the `planning`
    // prefix, so without an earlier branch it landed on Reminders — a list
    // with nothing to do with what buzzed.
    expect(r('planning_email_digest')!.route, AppRoutes.emailInbox);
    expect(r('planning_reminder')!.route, AppRoutes.planReminders);

    // "scheduled_payroll" does not START with payroll.
    expect(r('scheduled_payroll')!.route, AppRoutes.payRuns);

    expect(r('inventory_low_stock')!.route, AppRoutes.inventory);
    expect(r('group_funds_auto_charge_failed')!.route, AppRoutes.groupAccount);
    expect(r('autosave_mandate_reauth_required')!.route,
        AppRoutes.autoSaveDashboard);
    expect(r('kyc.verified')!.route, AppRoutes.kycProgressive);
    expect(r('security.fraud_freeze')!.route, AppRoutes.myAccount);
    expect(r('connection.birthday')!.route, AppRoutes.financialConnections);
    // escrow_<event> is the shape escrow-service publishes.
    expect(r('escrow_funded')!.route, AppRoutes.escrow);
  });

  test('resolver never returns an empty or relative route', () {
    for (final (type, data) in cases) {
      final t = NotificationRouteResolver.resolve(type, data);
      if (t == null) continue;
      expect(t.route.startsWith('/'), isTrue,
          reason: '$type gave "${t.route}"');
      expect(t.route.trim(), isNotEmpty, reason: '$type gave an empty route');
    }
  });

  test('record targets always carry the arguments their screen needs', () {
    // A record-precision target that passes no arguments cannot be opening a
    // specific record — it would render the destination's empty state and look
    // like a broken link.
    for (final (type, data) in cases) {
      final t = NotificationRouteResolver.resolve(type, data);
      if (t == null || t.precision != TargetPrecision.record) continue;
      // Path-param routes carry the id in the route itself.
      if (t.route.split('/').length > 3 && t.arguments == null) continue;
      // transactionPinSetup is a record target with nothing to pass.
      if (t.route.contains('transaction-pin-setup')) continue;
      expect(t.arguments, isNotNull,
          reason: '$type is record-precision but passes no arguments');
    }
  });
  test('the in-app feed shows a meaningful glyph, not the catch-all', () {
    // _appServiceForType used to be an exact-match switch on 'transfer',
    // 'invoice', 'bill' and a few more. notifications-service emits
    // transfer.sent, split_bill.created, tagpay.request,
    // electricity_payment_completed — none of which matched — so almost every
    // row in the feed fell through to the phone-banking glyph and the list
    // looked undifferentiated regardless of what it was about.
    const catchAll = AppServiceName.phoneBanking;
    const shouldNotBeGeneric = [
      'transfer.sent',
      'transfer.received',
      'transfer.reversed',
      'split_bill.created',
      'split_bill.reminder',
      'tagpay.request',
      'tagpay.claimed',
      'invoice.external_tag',
      'electricity_payment_completed',
      'giftcard',
      'escrow_funded',
      'crypto',
      'exchange',
      'deposit',
      'withdrawal',
      'payment',
      'bill',
      'group_funds_auto_charge_failed',
      'autosave.triggered',
      'uplift_disbursement',
      'scheduled_payroll',
      'inventory_low_stock',
      'airtime',
      'betting',
      'qr_pay',
      'id_pay',
    ];
    for (final t in shouldNotBeGeneric) {
      expect(notificationServiceFor(t).serviceName, isNot(catchAll),
          reason: '$t still falls through to the catch-all glyph');
    }
  });

  test('the glyph mapper resolves overlapping names in the right order', () {
    // Names that contain each other must not shadow: a split bill is not a
    // utility bill, and a gift card is not a bank card.
    expect(notificationServiceFor('split_bill.created').serviceName,
        AppServiceName.splitBills);
    expect(notificationServiceFor('bill').serviceName, AppServiceName.payBills);
    expect(notificationServiceFor('giftcard').serviceName,
        AppServiceName.giftCards);
  });

  test('an unknown type still gets the catch-all rather than throwing', () {
    expect(notificationServiceFor('invented_next_year').serviceName,
        AppServiceName.phoneBanking);
    expect(notificationServiceFor('').serviceName, AppServiceName.phoneBanking);
  });
}
