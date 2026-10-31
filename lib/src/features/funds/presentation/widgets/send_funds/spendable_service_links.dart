import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lazervault/core/config/feature_flags.dart';
import 'package:lazervault/core/shared_widgets/server_refusal_sheet.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/types/services.dart';
import 'package:lazervault/src/features/widgets/app_service_builder.dart';

/// "You can't send this out — but here is everything you CAN do with it."
///
/// WHY A REFUSAL NEEDS THESE. The retained balance is not frozen: it buys
/// airtime, data, bills, gift cards and crypto. Saying so in a sentence is
/// weaker than showing it, because the sentence asks the customer to go and
/// find those screens themselves, from a dead end. A refusal that offers
/// somewhere to go reads as help; the same refusal with only "Got it" reads
/// as a wall, and generates the support ticket.
///
/// THIS LIST MIRRORS THE SERVER'S ALLOWLIST. `grantDepletingServices` in
/// accounts-service decides what actually spends a restricted balance; this
/// decides what we OFFER. If they disagree the customer is sent to a screen
/// that then refuses them, which is worse than not offering it — so the
/// mapping below is written against that Go map, service for service:
///
///   utility-payments-service  -> airtime, data, payBills, betting, rechargeCard
///   giftcards-service         -> giftCards
///   crypto-service            -> crypto
///   insurance-service         -> insurance
///   bulk-sms-service          -> bulkSms
///
/// If you add a service to the Go allowlist, add it here.
const List<AppServiceName> kGrantSpendableServices = <AppServiceName>[
  AppServiceName.airtime,
  AppServiceName.data,
  AppServiceName.payBills,
  AppServiceName.giftCards,
  AppServiceName.crypto,
  AppServiceName.betting,
  AppServiceName.rechargeCard,
  AppServiceName.bulkSms,
  AppServiceName.insurance,
];

/// Icons per service. Kept here rather than read from the tile artwork
/// because these render small and monochrome on a dark sheet, where the
/// full-colour service images are unreadable.
const Map<AppServiceName, IconData> _icons = <AppServiceName, IconData>{
  AppServiceName.airtime: Icons.phone_android,
  AppServiceName.data: Icons.wifi,
  AppServiceName.payBills: Icons.receipt_long,
  AppServiceName.giftCards: Icons.card_giftcard,
  AppServiceName.crypto: Icons.currency_bitcoin,
  AppServiceName.betting: Icons.sports_soccer,
  AppServiceName.rechargeCard: Icons.confirmation_number_outlined,
  AppServiceName.bulkSms: Icons.sms_outlined,
  AppServiceName.insurance: Icons.shield_outlined,
};

/// Builds the tappable service list for a refusal sheet.
///
/// [limit] caps how many are shown. A refusal sheet with nine links is a menu,
/// not an explanation — the point is to show that the money is usable, which
/// three or four examples make as well as nine, and the full grid is one tap
/// away on the dashboard.
///
/// ONLY OFFERS WHAT CAN ACTUALLY BE OPENED. Each candidate is put through the
/// SAME admin gate the service tiles use, so a service an operator has
/// switched off is never suggested. Without this the sheet would cheerfully
/// point someone at a screen that immediately tells them it is unavailable,
/// which is a worse experience than the refusal they were already reading.
List<RefusalLink> buildSpendableServiceLinks(
  BuildContext context, {
  int limit = 4,
}) {
  final links = <RefusalLink>[];
  for (final service in kGrantSpendableServices) {
    if (links.length >= limit) break;
    final key = service.name;
    if (!FeatureFlags.quickServiceVisible(key)) continue;
    if (FeatureFlags.quickServiceEntryBlocked(key)) continue;
    links.add(
      RefusalLink(
        label: service.displayName,
        icon: _icons[service] ?? Icons.apps,
        // openAppService, NOT a Get.toNamed of our own. It is the single
        // dispatcher that also applies the frozen-account guard, the admin
        // availability gate and usage recording. A private route table here
        // would skip all three and is exactly the duplication that lets a
        // suggestion and the screen behind it drift apart.
        onTap: () => openAppService(context, service),
      ),
    );
  }
  return links;
}

/// "Add money" — the other way out of a payout refusal.
///
/// Topping up raises what can be sent, because the floor is on what REMAINS:
/// every naira deposited is a naira that can leave. That is the one action
/// that actually changes the outcome the customer just hit, so it belongs
/// in the sheet rather than being something they have to work out.
RefusalLink depositLink() => RefusalLink(
      label: 'Add money to send more',
      icon: Icons.add_circle_outline,
      onTap: () => Get.toNamed(AppRoutes.depositMethodSelection),
    );
