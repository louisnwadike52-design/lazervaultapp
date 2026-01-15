import 'package:grpc/grpc.dart';
import '../../../../generated/portfolio.pb.dart' as pb;
import '../../../../generated/portfolio.pbgrpc.dart';
import '../../../../../core/services/grpc_call_options_helper.dart';

/// Portfolio gRPC Data Source
class PortfolioGrpcDataSource {
  final PortfolioServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  const PortfolioGrpcDataSource(this._client, this._callOptionsHelper);

  /// Get complete user portfolio
  Future<pb.GetCompletePortfolioResponse> getCompletePortfolio() async {
    try {
      final request = pb.GetCompletePortfolioRequest();

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getCompletePortfolio(
        request,
        options: callOptions,
      );

      return response;
    } on GrpcError catch (e) {
      throw Exception('Failed to get complete portfolio: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get complete portfolio: $e');
    }
  }

  /// Get portfolio filtered by asset type
  Future<pb.GetPortfolioByAssetTypeResponse> getPortfolioByAssetType(
    String assetType,
  ) async {
    try {
      final request = pb.GetPortfolioByAssetTypeRequest()
        ..assetType = assetType;

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getPortfolioByAssetType(
        request,
        options: callOptions,
      );

      return response;
    } on GrpcError catch (e) {
      throw Exception('Failed to get portfolio by asset type: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get portfolio by asset type: $e');
    }
  }

  /// Get portfolio summary only
  Future<pb.GetPortfolioSummaryResponse> getPortfolioSummary() async {
    try {
      final request = pb.GetPortfolioSummaryRequest();

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getPortfolioSummary(
        request,
        options: callOptions,
      );

      return response;
    } on GrpcError catch (e) {
      throw Exception('Failed to get portfolio summary: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get portfolio summary: $e');
    }
  }

  /// Get portfolio value history
  Future<pb.GetPortfolioHistoryResponse> getPortfolioHistory(
    String period,
  ) async {
    try {
      final request = pb.GetPortfolioHistoryRequest()
        ..period = period;

      final callOptions = await _callOptionsHelper.withAuth();

      final response = await _client.getPortfolioHistory(
        request,
        options: callOptions,
      );

      return response;
    } on GrpcError catch (e) {
      throw Exception('Failed to get portfolio history: ${e.message}');
    } catch (e) {
      throw Exception('Failed to get portfolio history: $e');
    }
  }
}
