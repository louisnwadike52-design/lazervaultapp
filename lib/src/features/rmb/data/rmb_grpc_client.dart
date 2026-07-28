import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/rmb.pbgrpc.dart';

/// Thin gRPC wrapper for the RMB cross-border payout service. Talks to
/// financial-gateway (port 50071), which proxies to rmb-service. Every call
/// carries the JWT via [GrpcCallOptionsHelper.withAuth].
class RmbGrpcClient {
  final ClientChannel _channel;
  final GrpcCallOptionsHelper _auth;
  late final RmbServiceClient _client;

  RmbGrpcClient({
    required ClientChannel channel,
    required GrpcCallOptionsHelper callOptionsHelper,
  })  : _channel = channel,
        _auth = callOptionsHelper {
    _client = RmbServiceClient(_channel);
  }

  Future<ProviderConfigResponse> getProviderConfig() async {
    return _client.getProviderConfig(GetProviderConfigRequest(),
        options: await _auth.withAuth());
  }

  Future<ResolveBanksResponse> resolveBanks(RmbRail rail) async {
    return _client.resolveBanks(ResolveBanksRequest(rail: rail),
        options: await _auth.withAuth());
  }

  Future<QuoteResponse> getQuote(RmbRail rail, int cnyAmountMinor) async {
    return _client.getQuote(
      GetQuoteRequest(rail: rail, cnyAmountMinor: Int64(cnyAmountMinor)),
      options: await _auth.withAuth(),
    );
  }

  Future<ListBeneficiariesResponse> listBeneficiaries({RmbRail? rail}) async {
    final req = ListBeneficiariesRequest();
    if (rail != null) req.rail = rail;
    return _client.listBeneficiaries(req, options: await _auth.withAuth());
  }

  Future<SaveBeneficiaryResponse> saveBeneficiary(Beneficiary b) async {
    return _client.saveBeneficiary(SaveBeneficiaryRequest(beneficiary: b),
        options: await _auth.withAuth());
  }

  Future<DeleteBeneficiaryResponse> deleteBeneficiary(String id) async {
    return _client.deleteBeneficiary(DeleteBeneficiaryRequest(id: id),
        options: await _auth.withAuth());
  }

  Future<FavouriteBeneficiaryResponse> favouriteBeneficiary(
      String id, bool favourite) async {
    return _client.favouriteBeneficiary(
      FavouriteBeneficiaryRequest(id: id, favourite: favourite),
      options: await _auth.withAuth(),
    );
  }

  Future<GetComplianceProfileResponse> getComplianceProfile() async {
    return _client.getComplianceProfile(GetComplianceProfileRequest(),
        options: await _auth.withAuth());
  }

  Future<UpsertComplianceProfileResponse> upsertComplianceProfile(
      ComplianceProfile profile) async {
    return _client.upsertComplianceProfile(
      UpsertComplianceProfileRequest(profile: profile),
      options: await _auth.withAuth(),
    );
  }

  Future<InitiateTransferResponse> initiateTransfer(
      InitiateTransferRequest req) async {
    return _client.initiateTransfer(req, options: await _auth.withAuth());
  }

  Future<GetTransferResponse> getTransfer(String id) async {
    return _client.getTransfer(GetTransferRequest(id: id),
        options: await _auth.withAuth());
  }

  Future<ListTransfersResponse> listTransfers(
      {int page = 1, int pageSize = 20}) async {
    return _client.listTransfers(
      ListTransfersRequest(page: page, pageSize: pageSize),
      options: await _auth.withAuth(),
    );
  }
}
