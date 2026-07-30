import 'package:lazervault/core/types/services.dart';

/// Maps a quick-service to its bundled brand illustration (a recolored unDraw
/// SVG under `assets/images/services/`), or null when none is bundled — in which
/// case the tile falls back to its themed material icon. This keeps the grid
/// depictive/illustrated without ever rendering a broken asset.
///
/// Only services with a real, on-brand illustration are listed; scan/QR services
/// have no good illustration in the set yet, so they stay on their icon.
String? serviceIllustrationAsset(AppServiceName name) {
  final slug = switch (name) {
    AppServiceName.sendFunds => 'send_funds',
    AppServiceName.batchTransfer => 'batch_transfer',
    AppServiceName.tagPay => 'tag_pay',
    AppServiceName.escrow => 'escrow',
    AppServiceName.invoice => 'invoice',
    AppServiceName.payInvoice => 'invoice',
    AppServiceName.payBills => 'pay_bills',
    AppServiceName.exchange => 'exchange',
    AppServiceName.crypto => 'crypto',
    AppServiceName.rmb => 'rmb',
    AppServiceName.giftCards => 'gift_cards',
    AppServiceName.contactlessPay => 'contactless_pay',
    AppServiceName.groupAccount => 'group_account',
    AppServiceName.insurance => 'insurance',
    AppServiceName.autoSave => 'auto_save',
    AppServiceName.crowdfund => 'crowdfund',
    AppServiceName.uplift => 'uplift',
    AppServiceName.lockFunds => 'lock_funds',
    AppServiceName.whatsappIntegration => 'whatsapp_integration',
    AppServiceName.phoneBanking => 'phone_banking',
    AppServiceName.idPay => 'id_pay',
    _ => null,
  };
  return slug == null ? null : 'assets/images/services/$slug.svg';
}
