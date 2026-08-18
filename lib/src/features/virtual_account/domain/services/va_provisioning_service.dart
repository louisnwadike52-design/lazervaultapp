import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/kyc/data/services/prove_kyc_http_service.dart';
import 'package:lazervault/src/features/virtual_account/domain/repositories/i_virtual_account_repository.dart';
import 'package:lazervault/src/features/virtual_account/domain/usecases/create_virtual_account_usecase.dart';

/// Proactively provisions the user's personal virtual account (NUBAN) so a
/// verified user simply LANDS on the dashboard and sees their deposit account —
/// no manual "activate" step. The backend already mints the VA on KYC
/// verification (async), but for the brief mint window, and for users who
/// verified before that path existed, this fills the gap on the client.
///
/// Design (per product ask): provision the ACTIVE-LOCALE personal account FIRST
/// (awaited, fast) so it shows immediately, then background the other locales.
/// Fully non-blocking + guarded — every path is best-effort and never throws, so
/// it can be fired from a screen's load hook without risk. Idempotent server-side
/// (the backend upgrades the existing local account rather than duplicating), and
/// guarded here per-key so a re-render never double-provisions.
class VaProvisioningService {
  VaProvisioningService(this._createVA, this._storage, this._prove);

  final CreateVirtualAccountUseCase _createVA;
  final SecureStorageService _storage;
  final ProveKycHttpService _prove;

  final Set<String> _inFlight = <String>{};
  bool? _verifiedCache;
  DateTime? _verifiedCheckedAt;

  /// True once the user has a Tier-2+ (BVN-verified) Prove standing, so we only
  /// ever provision for users who can actually have a NUBAN. Cached 5 min to
  /// avoid a status round-trip on every dashboard load. Fails CLOSED (no
  /// provisioning) on error — provisioning is an enhancement, never forced.
  Future<bool> isVerified() async {
    final cachedAt = _verifiedCheckedAt;
    if (_verifiedCache == true &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < const Duration(minutes: 5)) {
      return true;
    }
    try {
      final st = await _prove.status().timeout(const Duration(seconds: 8));
      _verifiedCache = st.tier >= 2;
      _verifiedCheckedAt = DateTime.now();
      return _verifiedCache ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Provision the personal VA for [currency]/[locale] if the user is verified
  /// and holds a BVN. Returns the minted account, or null when skipped (already
  /// in-flight / not verified / no BVN) or on failure. Never throws.
  Future<VirtualAccountEntity?> ensurePersonalVA({
    required String currency,
    required String locale,
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    bool isPrimary = false,
  }) async {
    final key = '$locale:$currency';
    if (_inFlight.contains(key)) return null;
    if (!await isVerified()) return null;

    final bvn = (await _storage.getBvn())?.trim() ?? '';
    if (bvn.length < 10) return null; // no verified BVN on file → can't mint a NG NUBAN

    var fName = firstName.trim();
    var lName = lastName.trim();
    if (fName.isEmpty && lName.isEmpty) {
      // Fall back to the stored full name (split) when the profile fields are empty.
      final full = (await _storage.getUserFullName())?.trim() ?? '';
      if (full.isNotEmpty) {
        final parts = full.split(RegExp(r'\s+'));
        fName = parts.first;
        lName = parts.length > 1 ? parts.sublist(1).join(' ') : '';
      }
    }
    final mail = email.trim().isNotEmpty
        ? email.trim()
        : ((await _storage.getUserEmail())?.trim() ?? '');
    final accountName = '$fName $lName'.trim();

    _inFlight.add(key);
    try {
      final result = await _createVA(
        accountName: accountName,
        accountType: 'personal',
        currency: currency,
        locale: locale,
        email: mail,
        firstName: fName,
        lastName: lName,
        phoneNumber: phoneNumber.trim(),
        bvn: bvn,
        isPrimary: isPrimary,
      );
      return result.fold((_) => null, (va) => va);
    } catch (_) {
      return null;
    } finally {
      _inFlight.remove(key);
    }
  }
}
