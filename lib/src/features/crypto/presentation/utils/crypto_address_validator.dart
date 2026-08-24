/// Client-side blockchain-address validation for external crypto sends.
///
/// This MIRRORS the server's authoritative check
/// (`microservices/crypto-service/internal/quidax/networks.go`
/// `ValidateAddressForNetwork`) so the two never disagree — a value the client
/// accepts is one the server accepts, and vice versa. Keep the regexes and the
/// fail-open behaviour in lock-step with that file when either changes.
///
/// It is intentionally NARROW: passing does not guarantee Quidax accepts the
/// address, only that it is structurally plausible for the named chain. The one
/// catastrophic failure it catches is pasting an address from one chain while
/// the wrong network is selected — an irreversible loss. Checksums are NOT
/// verified (that needs per-chain SDKs); Quidax does its own validation too.
///
/// Behaviour contract (matches the server):
///   * empty network OR empty address  -> null (no error; the caller gates on
///     non-empty separately).
///   * unknown network                 -> null (FAIL OPEN, so a new-network
///     rollout is never blocked by a missing entry here).
library;

// Regexes copied verbatim from networks.go so the client and server agree.
final RegExp _evmHexAddress = RegExp(r'^0x[a-fA-F0-9]{40}$');
final RegExp _tronAddress = RegExp(r'^T[1-9A-HJ-NP-Za-km-z]{33}$');
final RegExp _btcAddress =
    RegExp(r'^(bc1[a-z0-9]{8,87}|[13][1-9A-HJ-NP-Za-km-z]{25,34})$');
final RegExp _solanaAddress = RegExp(r'^[1-9A-HJ-NP-Za-km-z]{32,44}$');
final RegExp _xrpAddress = RegExp(r'^r[1-9A-HJ-NP-Za-km-z]{24,34}$');
final RegExp _cardanoAddress =
    RegExp(r'^(addr1[0-9a-z]{53,}|Ae2[0-9a-zA-Z]{50,}|DdzFF[0-9a-zA-Z]{40,})$');
final RegExp _stellarAddress = RegExp(r'^G[A-Z2-7]{55}$');
final RegExp _dogeAddress = RegExp(r'^D[1-9A-HJ-NP-Za-km-z]{33}$');
final RegExp _ltcAddress =
    RegExp(r'^(ltc1[a-z0-9]{8,87}|[LM][1-9A-HJ-NP-Za-km-z]{25,34})$');
final RegExp _dashAddress = RegExp(r'^[X7][1-9A-HJ-NP-Za-km-z]{33}$');
final RegExp _bchAddress = RegExp(r'^(bitcoincash:)?[qp][a-z0-9]{38,90}$');
final RegExp _tonAddress = RegExp(r'^[A-Za-z0-9_-]{48}$');

/// A hard upper bound on what we let a user type into the address field. Every
/// supported chain's address is well under this; it just stops absurd pastes.
const int kMaxCryptoAddressLength = 128;

/// Crypto payment-URI schemes we unwrap when a scanned QR encodes an address as
/// `scheme:address[?query][@chainId]` (BIP-21 `bitcoin:`, EIP-681 `ethereum:`,
/// and the common chain-name schemes). NOTE: `bitcoincash:` is deliberately
/// EXCLUDED — for Bitcoin Cash CashAddr the `bitcoincash:` prefix is part of the
/// address itself (the validator accepts it), so it must NOT be stripped.
const Set<String> _cryptoUriSchemes = {
  'bitcoin',
  'ethereum',
  'litecoin',
  'dogecoin',
  'dash',
  'tron',
  'ripple',
  'xrp',
  'solana',
  'cardano',
  'stellar',
  'xlm',
  'ton',
  'celo',
  'polygon',
  'arbitrum',
  'optimism',
  'base',
  'binance',
  'bsc',
};

/// Extract the bare on-chain address from a scanned QR value. Handles a plain
/// address, a payment URI (`bitcoin:bc1…?amount=…`, `ethereum:0x…@1?value=…`),
/// and leaves Bitcoin Cash CashAddr (`bitcoincash:q…`) intact. Best-effort — the
/// result is still run through [validateCryptoAddress] against the selected
/// network before use.
String parseScannedCryptoAddress(String raw) {
  var s = raw.trim();
  if (s.isEmpty) return s;

  // Bitcoin Cash CashAddr keeps its scheme as part of the address — don't strip.
  if (!s.toLowerCase().startsWith('bitcoincash:')) {
    final m = RegExp(r'^([a-zA-Z]+):(.+)$').firstMatch(s);
    if (m != null && _cryptoUriSchemes.contains(m.group(1)!.toLowerCase())) {
      s = m.group(2)!.trim();
    }
  }

  // EIP-681 TOKEN-TRANSFER URIs (`ethereum:0xTOKEN@1/transfer?address=0xRECIPIENT
  // &uint256=…`): the path segment is the TOKEN CONTRACT, not the recipient.
  // Naively truncating at `@`/`?` returned the contract address — a scanned
  // wallet USDT QR would have sent funds to the USDT contract (unrecoverable).
  // The recipient lives in the `address=` query parameter; prefer it.
  final addrParam =
      RegExp(r'[?&]address=([^&]+)').firstMatch(s)?.group(1)?.trim();
  if (addrParam != null && addrParam.isNotEmpty) {
    return Uri.decodeComponent(addrParam).trim();
  }

  // Strip an EIP-681 chain suffix (`@chainId`), any `/transfer`-style function
  // path, and any query string.
  final at = s.indexOf('@');
  if (at > 0) s = s.substring(0, at);
  final slash = s.indexOf('/');
  if (slash > 0) s = s.substring(0, slash);
  final q = s.indexOf('?');
  if (q > 0) s = s.substring(0, q);
  return s.trim();
}

/// Returns a user-facing error string when [address] does not look like a valid
/// address for [network], or null when it is plausible (or cannot be judged).
String? validateCryptoAddress({
  required String network,
  required String address,
}) {
  final net = network.trim().toLowerCase();
  final addr = address.trim();
  if (net.isEmpty || addr.isEmpty) return null;

  if (addr.length > kMaxCryptoAddressLength) {
    return 'That address is too long to be valid';
  }

  // EVM family — Ethereum-style 0x-prefixed 20-byte hex.
  const evmNetworks = {
    'erc20',
    'bep20',
    'polygon',
    'arbitrum',
    'optimism',
    'base',
    'lisk',
    'celo',
  };
  if (evmNetworks.contains(net)) {
    return _evmHexAddress.hasMatch(addr)
        ? null
        : 'Enter a valid ${net.toUpperCase()} address (0x… followed by 40 hex characters)';
  }

  switch (net) {
    case 'trc20':
      return _tronAddress.hasMatch(addr)
          ? null
          : 'Enter a valid TRON address (starts with T, 34 characters)';
    case 'btc':
    case 'bitcoin':
      return _btcAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Bitcoin address (bc1…, or one starting with 1 or 3)';
    case 'solana':
      return _solanaAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Solana address (base58, 32–44 characters)';
    case 'xrp':
    case 'ripple':
      return _xrpAddress.hasMatch(addr)
          ? null
          : 'Enter a valid XRP address (starts with r)';
    case 'ada':
    case 'cardano':
      return _cardanoAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Cardano address (starts with addr1)';
    case 'stellar':
    case 'xlm':
      return _stellarAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Stellar address (starts with G, 56 characters)';
    case 'doge':
    case 'dogecoin':
      return _dogeAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Dogecoin address (starts with D)';
    case 'ltc':
    case 'litecoin':
      return _ltcAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Litecoin address (ltc1…, or starting with L or M)';
    case 'dash':
      return _dashAddress.hasMatch(addr)
          ? null
          : 'Enter a valid Dash address (starts with X or 7)';
    case 'bch':
      // Bitcoin Cash accepts CashAddr (bitcoincash:q…) OR legacy (BTC-style).
      return (_bchAddress.hasMatch(addr) || _btcAddress.hasMatch(addr))
          ? null
          : 'Enter a valid Bitcoin Cash address';
    case 'ton':
      return _tonAddress.hasMatch(addr)
          ? null
          : 'Enter a valid TON address (48 characters)';
    default:
      // Unknown network — fail open, exactly like the server. The send is
      // still gated on a non-empty address by the caller.
      return null;
  }
}
