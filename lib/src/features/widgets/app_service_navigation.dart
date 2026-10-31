part of 'app_service_builder.dart';

/// THE SINGLE ENTRY POINT INTO A SERVICE.
///
/// Extracted from `_AppServiceBuilderState._handleGotoService` so that every
/// surface which offers a way into a service goes through the same four
/// steps, in the same order:
///
///   1. the FROZEN-ACCOUNT guard,
///   2. the admin AVAILABILITY gate (including the tester whitelist),
///   3. adaptive-ordering USAGE recording,
///   4. the route itself.
///
/// WHY IT HAD TO BE SHARED. The minimum-balance refusal sheet now lists the
/// services a restricted balance can still be spent on, as tappable CTAs. Had
/// that sheet carried its own `Get.toNamed` table it would have skipped all
/// three guards — so a frozen account, or a service an operator had switched
/// off, would have been offered as a suggestion and then opened into a screen
/// that refuses. Routing both through here means a service that cannot be
/// entered cannot be suggested either.
///
/// Kept as a `part` of app_service_builder.dart rather than a new library on
/// purpose: `_frozenBlockedServices` is private to that file, and a `part`
/// shares its privates, which makes this a pure move with no behaviour change.
void openAppService(BuildContext context, AppServiceName service) {
  // FROZEN GUARD: if the active account is frozen, don't walk the user into a
  // money-moving flow the backend will reject — point them at Details to
  // unfreeze. Non-money (view/admin/receive) services stay usable.
  if (_frozenBlockedServices.contains(service) &&
      serviceLocator<AccountManager>().isActiveAccountFrozen) {
    _showFrozenServiceBlocked(service);
    return;
  }
  // ADMIN UNAVAILABILITY GATE. Checked here, at the single tap dispatcher,
  // so EVERY way into a service honours it — the grid, the swipe-down
  // all-services search, and anything else that renders a tile.
  //
  // Before the usage recorder on purpose: a tap that cannot open the service
  // is not usage, and counting it would promote a dead service up the
  // adaptive ordering.
  //
  // Note this gate is separate from hiding. An admin can HIDE a service from
  // an account type (it never appears), or mark it UNAVAILABLE (it appears
  // and explains itself). Those are different messages: a hidden service is
  // "not for this wallet", an unavailable one is "not right now" — and a
  // service silently missing during an outage looks like a bug, which is why
  // unavailable is shown rather than hidden.
  final serviceKey = service.name;
  // Whitelisted testers are exactly who should still get in while a service
  // is switched off for everyone else, so the same override applies here.
  // One shared question for both entry points (this tile and a notification
  // deep link), so the two cannot drift apart. It already folds in the
  // whitelist override.
  if (FeatureFlags.quickServiceEntryBlocked(serviceKey)) {
    showServiceUnavailableModal(
      context,
      serviceName: service.displayName,
      message: FeatureFlags.quickServiceMessage(serviceKey),
    );
    return;
  }
  // Record usage for adaptive quick-services ordering (no-op unless the user
  // turned it on). Fire-and-forget — never blocks navigation.
  serviceLocator<ServiceUsageService>().record(service);
  switch (service) {
    case AppServiceName.splitBills:
      Get.toNamed(AppRoutes.splitBills);
      break;
    case AppServiceName.invoice:
      Get.toNamed(AppRoutes.invoice);
      break;
    case AppServiceName.payInvoice:
      // Both invoice services now go to the consolidated screen
      Get.toNamed(AppRoutes.invoice);
      break;
    case AppServiceName.payBills:
      Get.toNamed(AppRoutes.billsHub);
      break;
    case AppServiceName.crypto:
      Get.toNamed(AppRoutes.crypto);
      break;
    case AppServiceName.rmb:
      Get.toNamed(AppRoutes.rmb);
      break;
    case AppServiceName.invest:
      Get.toNamed(AppRoutes.investments);
      break;
    case AppServiceName.stocks:
      Get.toNamed(AppRoutes.stocks);
      break;
    case AppServiceName.exchange:
      Get.toNamed(AppRoutes.currencyExchange);
      break;
    case AppServiceName.giftCards:
      Get.toNamed(AppRoutes.giftCards);
      break;
    case AppServiceName.aiScanToPay:
      Get.toNamed(AppRoutes.aiScanToPay);
      break;
    case AppServiceName.qrPay:
      Get.toNamed(AppRoutes.qrPayHome);
      break;
    case AppServiceName.contactlessPay:
      Get.toNamed(AppRoutes.contactlessPay);
      break;
    case AppServiceName.cardAcceptance:
      Get.toNamed(AppRoutes.cardAcceptance);
      break;
    case AppServiceName.groupAccount:
      Get.toNamed(AppRoutes.groupAccount);
      break;
    case AppServiceName.insurance:
      Get.toNamed(AppRoutes.insurance);
      break;
    case AppServiceName.airtime:
      Get.toNamed(AppRoutes.airtime);
      break;
    case AppServiceName.data:
      Get.toNamed(AppRoutes.dataBundlesHome);
      break;
    case AppServiceName.autoSave:
      Get.toNamed(AppRoutes.autoSave);
      break;
    case AppServiceName.batchTransfer:
      // Same screen renders short vs long; admin-gated via cached FeatureFlags.
      Get.toNamed(
        AppRoutes.batchTransfer,
        arguments: {'shortFlow': FeatureFlags.batchTransferShortFlow},
      );
      break;
    case AppServiceName.tagPay:
      Get.toNamed(AppRoutes.tagPay);
      break;
    case AppServiceName.escrow:
      Get.toNamed(AppRoutes.escrow);
      break;
    case AppServiceName.crowdfund:
      Get.toNamed(AppRoutes.crowdfund);
      break;
    case AppServiceName.uplift:
      Get.to(() => const UpliftHomeScreen());
      break;
    case AppServiceName.lockFunds:
      Get.toNamed(AppRoutes.lockFunds);
      break;
    // WhatsApp and phone banking are INDEPENDENT services that happen to
    // share one registration backend. These tiles used to overlap: WhatsApp
    // opened whatsapp_banking while "Phone Banking" opened the combined
    // channel screen, which ALSO rendered a WhatsApp card — so WhatsApp
    // appeared under both tiles. Each now opens its own channel, scoped.
    // Two Quick Services, two screens. They were one screen taking a
    // `channelType` argument, which is not a separation: the number rules are
    // opposite (WhatsApp editable, telephony pinned to the profile), the
    // settings differ (voice recognition means nothing in a text thread), and
    // only WhatsApp has a second account-link step. One screen could serve
    // both only by hiding half of each.
    case AppServiceName.whatsappIntegration:
      Get.to(() => BlocProvider(
            create: (_) => serviceLocator<ChannelManagementCubit>(),
            child: const WhatsAppBankingChannelScreen(),
          ));
      break;
    case AppServiceName.phoneBanking:
      Get.to(() => BlocProvider(
            create: (_) => serviceLocator<ChannelManagementCubit>(),
            child: const PhoneBankingChannelScreen(),
          ));
      break;
    case AppServiceName.idPay:
      Get.toNamed(AppRoutes.idPayHome);
      break;
    case AppServiceName.sendFunds:
      // Both modes use the SAME select-recipients screen; short flow renders
      // the add-recipient inline + runs amount→PIN→receipt on that screen.
      // The user's transfer-style choice (classic/standard) wins over the
      // admin platform default — see FeatureFlags.useShortSendFlow.
      Get.toNamed(
        AppRoutes.selectRecipient,
        arguments: {'shortFlow': FeatureFlags.sendFlowShortForSession},
      );
      break;
    case AppServiceName.payroll:
      Get.toNamed(AppRoutes.payroll);
      break;
    case AppServiceName.businessDashboard:
      Get.toNamed(AppRoutes.businessDashboard);
      break;
    case AppServiceName.businessAnalytics:
      Get.toNamed(AppRoutes.businessAnalytics);
      break;
    case AppServiceName.customers:
      Get.toNamed(AppRoutes.customers);
      break;
    case AppServiceName.inventory:
      Get.toNamed(AppRoutes.inventory);
      break;
    case AppServiceName.tax:
      Get.toNamed(AppRoutes.taxDashboard);
      break;
    case AppServiceName.expenses:
      Get.toNamed(AppRoutes.expenses);
      break;
    case AppServiceName.sales:
      Get.toNamed(AppRoutes.sales);
      break;
    case AppServiceName.rechargeCard:
      Get.toNamed(AppRoutes.epinHome);
      break;
    case AppServiceName.betting:
      Get.toNamed(AppRoutes.bettingHome);
      break;
    case AppServiceName.bulkSms:
      Get.toNamed(AppRoutes.bulkSms);
      break;
  }
}

/// Tells the user why a frozen account cannot open a money-moving service.
/// Top-level (was a state method) so [openAppService] can reach it from any
/// caller; it only ever needed the service's display name.
void _showFrozenServiceBlocked(AppServiceName service) {
  Get.snackbar(
    'Account frozen',
    'Unfreeze this account from your card Details before using ${service.displayName}.',
    backgroundColor: const Color(0xFF1E3A5F).withValues(alpha: 0.95),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.all(12.w),
    icon: const Icon(Icons.ac_unit_rounded, color: Colors.white),
    duration: const Duration(seconds: 4),
  );
}
