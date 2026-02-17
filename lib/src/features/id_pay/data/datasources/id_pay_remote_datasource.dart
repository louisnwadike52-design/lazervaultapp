import '../../../../generated/id_pay.pbgrpc.dart' as pb;
import '../../../../core/network/grpc_client.dart';
import '../../domain/entities/id_pay_entity.dart';
import '../../domain/entities/id_pay_organization_entity.dart';
import '../models/id_pay_model.dart';
import '../models/id_pay_organization_model.dart';
import '../models/id_pay_transaction_model.dart';

abstract class IDPayRemoteDataSource {
  Future<IDPayModel> createIDPay({
    required IDPayType type,
    required IDPayAmountMode amountMode,
    required double amount,
    required String currency,
    double? minAmount,
    double? maxAmount,
    String? description,
    required int validityMinutes,
    bool neverExpires = false,
    String? organizationId,
  });

  Future<IDPayModel> lookupIDPay({
    required String payId,
  });

  Future<(IDPayTransactionModel, double)> payIDPay({
    required String payId,
    required double amount,
    required String transactionPin,
    required String sourceAccountId,
    String? idempotencyKey,
  });

  Future<List<IDPayModel>> getMyIDPays({
    int? limit,
    int? offset,
    IDPayStatus? statusFilter,
  });

  Future<List<IDPayTransactionModel>> getIDPayTransactions({
    required String payId,
    int? limit,
    int? offset,
  });

  Future<void> cancelIDPay({
    required String id,
  });

  Future<IDPayModel> getIDPayDetails({
    required String id,
  });

  Future<IDPayOrganizationModel> createOrganization({
    required String name,
    required String description,
    String? logoUrl,
    required String accountId,
  });

  Future<(List<IDPayOrganizationModel>, int)> getMyOrganizations({
    required String accountId,
    int? limit,
    int? offset,
  });

  Future<IDPayOrganizationModel> updateOrganization({
    required String id,
    String? name,
    String? description,
    String? logoUrl,
  });

  Future<void> deleteOrganization({
    required String id,
  });

  Future<(IDPayOrganizationModel, List<IDPayModel>, double)>
      getOrganizationDetails({
    required String id,
  });

  Future<(IDPayModel, IDPayOrganizationModel?)> lookupIDPayWithOrg({
    required String payId,
  });
}

class IDPayRemoteDataSourceImpl implements IDPayRemoteDataSource {
  final GrpcClient grpcClient;

  IDPayRemoteDataSourceImpl({required this.grpcClient});

  @override
  Future<IDPayModel> createIDPay({
    required IDPayType type,
    required IDPayAmountMode amountMode,
    required double amount,
    required String currency,
    double? minAmount,
    double? maxAmount,
    String? description,
    required int validityMinutes,
    bool neverExpires = false,
    String? organizationId,
  }) async {
    final request = pb.CreateIDPayRequest()
      ..type = type == IDPayType.recurring
          ? pb.IDPayType.ID_PAY_RECURRING
          : pb.IDPayType.ID_PAY_ONE_TIME
      ..amountMode = amountMode == IDPayAmountMode.flexible
          ? pb.IDPayAmountMode.ID_PAY_FLEXIBLE
          : pb.IDPayAmountMode.ID_PAY_FIXED
      ..amount = amount
      ..currency = currency
      ..description = description ?? ''
      ..validityMinutes = validityMinutes
      ..neverExpires = neverExpires;

    if (minAmount != null) request.minAmount = minAmount;
    if (maxAmount != null) request.maxAmount = maxAmount;
    if (organizationId != null) request.organizationId = organizationId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.createIDPay(
      request,
      options: options,
    );

    return IDPayModel.fromProto(response.idPay);
  }

  @override
  Future<IDPayModel> lookupIDPay({
    required String payId,
  }) async {
    final request = pb.LookupIDPayRequest()..payId = payId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.lookupIDPay(
      request,
      options: options,
    );
    return IDPayModel.fromProto(response.idPay);
  }

  @override
  Future<(IDPayTransactionModel, double)> payIDPay({
    required String payId,
    required double amount,
    required String transactionPin,
    required String sourceAccountId,
    String? idempotencyKey,
  }) async {
    final request = pb.PayIDPayRequest()
      ..payId = payId
      ..amount = amount
      ..transactionPin = transactionPin
      ..sourceAccountId = sourceAccountId;

    if (idempotencyKey != null) {
      request.idempotencyKey = idempotencyKey;
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.payIDPay(
      request,
      options: options,
    );

    return (
      IDPayTransactionModel.fromProto(response.transaction),
      response.newBalance,
    );
  }

  @override
  Future<List<IDPayModel>> getMyIDPays({
    int? limit,
    int? offset,
    IDPayStatus? statusFilter,
  }) async {
    final request = pb.GetMyIDPaysRequest()
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    if (statusFilter != null) {
      request.statusFilter = _statusToProto(statusFilter);
    }

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.getMyIDPays(
      request,
      options: options,
    );
    return response.idPays
        .map((ip) => IDPayModel.fromProto(ip))
        .toList();
  }

  @override
  Future<List<IDPayTransactionModel>> getIDPayTransactions({
    required String payId,
    int? limit,
    int? offset,
  }) async {
    final request = pb.GetIDPayTransactionsRequest()
      ..payId = payId
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.getIDPayTransactions(
      request,
      options: options,
    );
    return response.transactions
        .map((txn) => IDPayTransactionModel.fromProto(txn))
        .toList();
  }

  @override
  Future<void> cancelIDPay({
    required String id,
  }) async {
    final request = pb.CancelIDPayRequest()..id = id;

    final options = await grpcClient.callOptions;
    await grpcClient.idPayClient.cancelIDPay(
      request,
      options: options,
    );
  }

  @override
  Future<IDPayModel> getIDPayDetails({
    required String id,
  }) async {
    final request = pb.GetIDPayDetailsRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.getIDPayDetails(
      request,
      options: options,
    );
    return IDPayModel.fromProto(response.idPay);
  }

  @override
  Future<IDPayOrganizationModel> createOrganization({
    required String name,
    required String description,
    String? logoUrl,
    required String accountId,
  }) async {
    final request = pb.CreateOrganizationRequest()
      ..name = name
      ..description = description
      ..accountId = accountId;

    if (logoUrl != null) request.logoUrl = logoUrl;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.createOrganization(
      request,
      options: options,
    );

    return IDPayOrganizationModel.fromProto(response.organization);
  }

  @override
  Future<(List<IDPayOrganizationModel>, int)> getMyOrganizations({
    required String accountId,
    int? limit,
    int? offset,
  }) async {
    final request = pb.GetMyOrganizationsRequest()
      ..accountId = accountId
      ..limit = limit ?? 50
      ..offset = offset ?? 0;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.getMyOrganizations(
      request,
      options: options,
    );

    final orgs = response.organizations
        .map((o) => IDPayOrganizationModel.fromProto(o))
        .toList();
    return (orgs, response.total);
  }

  @override
  Future<IDPayOrganizationModel> updateOrganization({
    required String id,
    String? name,
    String? description,
    String? logoUrl,
  }) async {
    final request = pb.UpdateOrganizationRequest()..id = id;

    if (name != null) request.name = name;
    if (description != null) request.description = description;
    if (logoUrl != null) request.logoUrl = logoUrl;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.updateOrganization(
      request,
      options: options,
    );

    return IDPayOrganizationModel.fromProto(response.organization);
  }

  @override
  Future<void> deleteOrganization({
    required String id,
  }) async {
    final request = pb.DeleteOrganizationRequest()..id = id;

    final options = await grpcClient.callOptions;
    await grpcClient.idPayClient.deleteOrganization(
      request,
      options: options,
    );
  }

  @override
  Future<(IDPayOrganizationModel, List<IDPayModel>, double)>
      getOrganizationDetails({
    required String id,
  }) async {
    final request = pb.GetOrganizationDetailsRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.getOrganizationDetails(
      request,
      options: options,
    );

    final org = IDPayOrganizationModel.fromProto(response.organization);
    final idPays =
        response.idPays.map((ip) => IDPayModel.fromProto(ip)).toList();
    return (org, idPays, response.totalPaidOut);
  }

  @override
  Future<(IDPayModel, IDPayOrganizationModel?)> lookupIDPayWithOrg({
    required String payId,
  }) async {
    final request = pb.LookupIDPayRequest()..payId = payId;

    final options = await grpcClient.callOptions;
    final response = await grpcClient.idPayClient.lookupIDPay(
      request,
      options: options,
    );

    final idPay = IDPayModel.fromProto(response.idPay);
    final org = response.hasOrganization()
        ? IDPayOrganizationModel.fromProto(response.organization)
        : null;
    return (idPay, org);
  }

  pb.IDPayStatus _statusToProto(IDPayStatus status) {
    switch (status) {
      case IDPayStatus.active:
        return pb.IDPayStatus.ID_PAY_ACTIVE;
      case IDPayStatus.paid:
        return pb.IDPayStatus.ID_PAY_PAID;
      case IDPayStatus.expired:
        return pb.IDPayStatus.ID_PAY_EXPIRED;
      case IDPayStatus.cancelled:
        return pb.IDPayStatus.ID_PAY_CANCELLED;
    }
  }
}
