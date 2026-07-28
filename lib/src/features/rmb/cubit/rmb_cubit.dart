import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/generated/rmb.pb.dart';
import 'package:lazervault/src/features/rmb/data/rmb_grpc_client.dart';
import 'package:lazervault/src/features/rmb/rmb_error.dart';

part 'rmb_state.dart';

/// Drives the RMB landing + send flow. The landing uses states; the send-flow
/// screens call the typed methods directly (quote/initiate) for a linear UX.
class RmbCubit extends Cubit<RmbState> {
  final RmbGrpcClient _client;
  RmbCubit(this._client) : super(const RmbInitial());

  ProviderConfigResponse? _config;
  ProviderConfigResponse? get config => _config;

  /// Ensures provider config is loaded (used by the send flow when opened
  /// directly, without going through the landing screen first).
  Future<ProviderConfigResponse> ensureConfig() async {
    final cached = _config;
    if (cached != null) return cached;
    final cfg = await _client.getProviderConfig();
    _config = cfg;
    return cfg;
  }

  Future<void> load() async {
    emit(const RmbLoading());
    try {
      final cfg = await _client.getProviderConfig();
      _config = cfg;
      emit(RmbLoaded(config: cfg, transfersLoading: true));
      _loadTransfers();
    } catch (e) {
      emit(RmbError(rmbFriendlyError(e)));
    }
  }

  Future<void> _loadTransfers() async {
    try {
      final resp = await _client.listTransfers(page: 1, pageSize: 20);
      final s = state;
      if (s is RmbLoaded) {
        emit(s.copyWith(
            transfers: resp.transfers,
            transfersLoading: false,
            transfersError: false));
      }
    } catch (_) {
      final s = state;
      if (s is RmbLoaded) {
        emit(s.copyWith(transfersLoading: false, transfersError: true));
      }
    }
  }

  /// Refresh after a payout / pull-to-refresh. When we're already loaded this
  /// reloads only the recent-transfers list IN PLACE — it does NOT emit
  /// RmbLoading (which would blank the whole landing to a spinner) or re-fetch
  /// the rarely-changing provider config. Falls back to a full [load] pre-load.
  Future<void> refresh() async {
    if (state is RmbLoaded) {
      return _loadTransfers();
    }
    return load();
  }

  Future<List<Beneficiary>> beneficiaries(RmbRail rail) async {
    final resp = await _client.listBeneficiaries(rail: rail);
    return resp.beneficiaries;
  }

  Future<List<Bank>> banks(RmbRail rail) async {
    final resp = await _client.resolveBanks(rail);
    return resp.banks;
  }

  Future<QuoteResponse> quote(RmbRail rail, int cnyAmountMinor) =>
      _client.getQuote(rail, cnyAmountMinor);

  Future<ComplianceProfile> complianceProfile() async {
    final resp = await _client.getComplianceProfile();
    return resp.profile;
  }

  Future<ComplianceProfile> saveCompliance(ComplianceProfile p) async {
    final resp = await _client.upsertComplianceProfile(p);
    return resp.profile;
  }

  Future<Beneficiary> saveBeneficiary(Beneficiary b) async {
    final resp = await _client.saveBeneficiary(b);
    return resp.beneficiary;
  }

  Future<InitiateTransferResponse> initiate(InitiateTransferRequest req) =>
      _client.initiateTransfer(req);

  Future<Transfer> transfer(String id) async {
    final resp = await _client.getTransfer(id);
    return resp.transfer;
  }
}
