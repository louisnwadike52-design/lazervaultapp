// GENERATED — bundled bank-logo asset manifest.
//
// Lists the bank codes that have an optimized logo bundled under
// `assets/images/banks/<code>.webp`. Used by [BankLogo] to decide
// synchronously whether to render the bundled asset or fall back to the
// gradient-initials avatar. Logos sourced from nigerianbanks.xyz, optimized
// to WebP (~120px, ~2KB each).
//
// To refresh: re-run the logo download/optimize step, then regenerate this
// set from `ls assets/images/banks/*.webp`.

/// Bank codes (NIP/NUBAN) that have a bundled logo asset.
const Set<String> kBundledBankLogoCodes = {
  '00103', // Globus Bank
  '011', // First Bank of Nigeria
  '023', // Citibank Nigeria
  '030', // Heritage Bank
  '032', // Union Bank of Nigeria
  '033', // UBA
  '035', // Wema Bank / ALAT
  '044', // Access Bank
  '050', // Ecobank Nigeria
  '057', // Zenith Bank
  '058', // GTBank
  '063', // Access Bank (Diamond)
  '068', // Standard Chartered Bank
  '070', // Fidelity Bank
  '076', // Polaris Bank
  '082', // Keystone Bank
  '100', // SunTrust Bank
  '101', // Providus Bank
  '102', // Titan Trust Bank
  '125', // Rubies Bank
  '214', // FCMB
  '215', // Unity Bank
  '221', // Stanbic IBTC Bank
  '232', // Sterling Bank
  '301', // Jaiz Bank
  '302', // TAJ Bank
  '303', // Lotus Bank
  '50211', // Kuda Bank
  '50383', // Hasal MFB
  '50515', // Moniepoint MFB
  '50931', // Bowen MFB
  '51211', // TCF MFB
  '51310', // Sparkle Microfinance Bank
  '526', // Parallex Bank
  '565', // Carbon
  '566', // VFD Microfinance Bank
  '999991', // PalmPay
  '999992', // OPay
};

/// Maps a payout-provider (Flutterwave) bank code to the bundled-logo code when
/// they differ. The bank list is sourced from Flutterwave `/v3/banks/NG`, whose
/// codes match transfer `account_bank` — but logos were downloaded keyed by
/// NIP/NUBAN codes. Major banks share the same code in both systems; these
/// fintechs/MFBs differ, so alias the Flutterwave code → the bundled logo.
const Map<String, String> kBankLogoCodeAliases = {
  '100004': '999992', // Opay
  '100033': '999991', // PalmPay
  '090267': '50211', // Kuda
  '090405': '50515', // Moniepoint
  '090110': '566', // VFD Microfinance Bank
  '090121': '50383', // Hasal MFB
  '090148': '50931', // Bowen MFB
  '090115': '51211', // TCF MFB
  '90115': '51211', // TCF MFB (no leading zero variant)
  '090325': '51310', // Sparkle
  '000025': '102', // Titan Trust Bank
  '103': '00103', // Globus Bank
};

/// Asset path for a bundled bank logo, or `null` if no logo is bundled for
/// [bankCode]. Resolves the code directly, then via the Flutterwave→logo alias
/// map. Returns `null` for empty/unknown codes so callers fall back to the
/// gradient avatar.
String? bundledBankLogoAsset(String? bankCode) {
  if (bankCode == null || bankCode.isEmpty) return null;
  final code = bankCode.trim();
  if (kBundledBankLogoCodes.contains(code)) {
    return 'assets/images/banks/$code.webp';
  }
  final alias = kBankLogoCodeAliases[code];
  if (alias != null) return 'assets/images/banks/$alias.webp';
  return null;
}
