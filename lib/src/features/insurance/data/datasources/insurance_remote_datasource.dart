import '../../../../generated/insurance.pbgrpc.dart' as pb;
import '../../../../core/network/grpc_client.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_payment_entity.dart';
import '../../domain/entities/insurance_claim_entity.dart';

abstract class InsuranceRemoteDataSource {
  Future<List<Insurance>> getUserInsurances({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<Insurance> getInsuranceById({
    required String id,
    required String accessToken,
  });

  Future<Insurance> createInsurance({
    required Insurance insurance,
    required String accessToken,
  });

  Future<Insurance> updateInsurance({
    required Insurance insurance,
    required String accessToken,
  });

  Future<void> deleteInsurance({
    required String id,
    required String accessToken,
  });

  Future<List<Insurance>> searchInsurances({
    required String query,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsurancePayment>> getInsurancePayments({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsurancePayment>> getUserPayments({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<InsurancePayment> getPaymentById({
    required String id,
    required String accessToken,
  });

  Future<InsurancePayment> createPayment({
    required InsurancePayment payment,
    required String accessToken,
  });

  Future<List<InsurancePayment>> getOverduePayments({
    required String accessToken,
  });

  Future<List<InsuranceClaim>> getInsuranceClaims({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<List<InsuranceClaim>> getUserClaims({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<InsuranceClaim> getClaimById({
    required String id,
    required String accessToken,
  });

  Future<InsuranceClaim> createClaim({
    required InsuranceClaim claim,
    required String accessToken,
  });

  Future<InsuranceClaim> updateClaim({
    required InsuranceClaim claim,
    required String accessToken,
  });

  Future<String> generatePaymentReceipt({
    required String paymentId,
    required String accessToken,
  });

  Future<List<String>> getUserReceipts({
    required String accessToken,
    int page = 1,
    int limit = 10,
  });

  Future<Map<String, dynamic>> getInsuranceStatistics({
    required String accessToken,
  });

  Future<Map<String, dynamic>> getPaymentStatistics({
    required String accessToken,
    DateTime? startDate,
    DateTime? endDate,
  });
}

class InsuranceRemoteDataSourceImpl implements InsuranceRemoteDataSource {
  final GrpcClient grpcClient;

  InsuranceRemoteDataSourceImpl({required this.grpcClient});

  pb.InsuranceServiceClient get _client => grpcClient.insuranceClient;

  @override
  Future<List<Insurance>> getUserInsurances({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserInsurancesRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserInsurances(request, options: options);

    return response.insurances.map((proto) => _insuranceFromProto(proto)).toList();
  }

  @override
  Future<Insurance> getInsuranceById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetInsuranceByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceById(request, options: options);

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<Insurance> createInsurance({
    required Insurance insurance,
    required String accessToken,
  }) async {
    final request = pb.CreateInsuranceRequest()
      ..insurance = _insuranceToProto(insurance);

    final options = await grpcClient.callOptions;
    final response = await _client.createInsurance(request, options: options);

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<Insurance> updateInsurance({
    required Insurance insurance,
    required String accessToken,
  }) async {
    final request = pb.UpdateInsuranceRequest()
      ..insurance = _insuranceToProto(insurance);

    final options = await grpcClient.callOptions;
    final response = await _client.updateInsurance(request, options: options);

    return _insuranceFromProto(response.insurance);
  }

  @override
  Future<void> deleteInsurance({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.DeleteInsuranceRequest()..id = id;

    final options = await grpcClient.callOptions;
    await _client.deleteInsurance(request, options: options);
  }

  @override
  Future<List<Insurance>> searchInsurances({
    required String query,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.SearchInsurancesRequest()
      ..query = query
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.searchInsurances(request, options: options);

    return response.insurances.map((proto) => _insuranceFromProto(proto)).toList();
  }

  @override
  Future<List<InsurancePayment>> getInsurancePayments({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetInsurancePaymentsRequest()
      ..insuranceId = insuranceId
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsurancePayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<List<InsurancePayment>> getUserPayments({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserPaymentsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserPayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<InsurancePayment> getPaymentById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetPaymentByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await _client.getPaymentById(request, options: options);

    return _paymentFromProto(response.payment);
  }

  @override
  Future<InsurancePayment> createPayment({
    required InsurancePayment payment,
    required String accessToken,
  }) async {
    final request = pb.CreatePaymentRequest()
      ..payment = _paymentToProto(payment);

    final options = await grpcClient.callOptions;
    final response = await _client.createPayment(request, options: options);

    return _paymentFromProto(response.payment);
  }

  @override
  Future<List<InsurancePayment>> getOverduePayments({
    required String accessToken,
  }) async {
    final request = pb.GetOverduePaymentsRequest();

    final options = await grpcClient.callOptions;
    final response = await _client.getOverduePayments(request, options: options);

    return response.payments.map((proto) => _paymentFromProto(proto)).toList();
  }

  @override
  Future<List<InsuranceClaim>> getInsuranceClaims({
    required String insuranceId,
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetInsuranceClaimsRequest()
      ..insuranceId = insuranceId
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceClaims(request, options: options);

    return response.claims.map((proto) => _claimFromProto(proto)).toList();
  }

  @override
  Future<List<InsuranceClaim>> getUserClaims({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserClaimsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserClaims(request, options: options);

    return response.claims.map((proto) => _claimFromProto(proto)).toList();
  }

  @override
  Future<InsuranceClaim> getClaimById({
    required String id,
    required String accessToken,
  }) async {
    final request = pb.GetClaimByIdRequest()..id = id;

    final options = await grpcClient.callOptions;
    final response = await _client.getClaimById(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<InsuranceClaim> createClaim({
    required InsuranceClaim claim,
    required String accessToken,
  }) async {
    final request = pb.CreateClaimRequest()..claim = _claimToProto(claim);

    final options = await grpcClient.callOptions;
    final response = await _client.createClaim(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<InsuranceClaim> updateClaim({
    required InsuranceClaim claim,
    required String accessToken,
  }) async {
    final request = pb.UpdateClaimRequest()..claim = _claimToProto(claim);

    final options = await grpcClient.callOptions;
    final response = await _client.updateClaim(request, options: options);

    return _claimFromProto(response.claim);
  }

  @override
  Future<String> generatePaymentReceipt({
    required String paymentId,
    required String accessToken,
  }) async {
    final request = pb.GeneratePaymentReceiptRequest()..paymentId = paymentId;

    final options = await grpcClient.callOptions;
    final response = await _client.generatePaymentReceipt(request, options: options);

    return response.receiptUrl;
  }

  @override
  Future<List<String>> getUserReceipts({
    required String accessToken,
    int page = 1,
    int limit = 10,
  }) async {
    final request = pb.GetUserReceiptsRequest()
      ..page = page
      ..limit = limit;

    final options = await grpcClient.callOptions;
    final response = await _client.getUserReceipts(request, options: options);

    return response.receiptUrls;
  }

  @override
  Future<Map<String, dynamic>> getInsuranceStatistics({
    required String accessToken,
  }) async {
    final request = pb.GetInsuranceStatisticsRequest();

    final options = await grpcClient.callOptions;
    final response = await _client.getInsuranceStatistics(request, options: options);

    return {
      'total_policies': response.totalPolicies,
      'active_policies': response.activePolicies,
      'expired_policies': response.expiredPolicies,
      'total_coverage_amount': response.totalCoverageAmount,
      'total_premium_amount': response.totalPremiumAmount,
      'policies_by_type': response.policiesByType,
    };
  }

  @override
  Future<Map<String, dynamic>> getPaymentStatistics({
    required String accessToken,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final request = pb.GetPaymentStatisticsRequest()
      ..startDate = startDate?.toIso8601String() ?? ''
      ..endDate = endDate?.toIso8601String() ?? '';

    final options = await grpcClient.callOptions;
    final response = await _client.getPaymentStatistics(request, options: options);

    return {
      'total_payments': response.totalPayments,
      'completed_payments': response.completedPayments,
      'pending_payments': response.pendingPayments,
      'failed_payments': response.failedPayments,
      'total_amount': response.totalAmount,
      'completed_amount': response.completedAmount,
      'payments_by_method': response.paymentsByMethod,
    };
  }

  // Conversion Helpers

  Insurance _insuranceFromProto(pb.Insurance proto) {
    return Insurance(
      id: proto.id,
      policyNumber: proto.policyNumber,
      policyHolderName: proto.policyHolderName,
      policyHolderEmail: proto.policyHolderEmail,
      policyHolderPhone: proto.policyHolderPhone,
      type: _parseInsuranceType(proto.type),
      provider: proto.provider,
      providerLogo: proto.providerLogo,
      premiumAmount: proto.premiumAmount,
      coverageAmount: proto.coverageAmount,
      currency: proto.currency,
      startDate: DateTime.parse(proto.startDate),
      endDate: DateTime.parse(proto.endDate),
      nextPaymentDate: DateTime.parse(proto.nextPaymentDate),
      status: _parseInsuranceStatus(proto.status),
      beneficiaries: proto.beneficiaries.toList(),
      coverageDetails: Map<String, dynamic>.from(proto.coverageDetails),
      description: proto.description.isEmpty ? null : proto.description,
      userId: proto.userId,
      createdAt: DateTime.parse(proto.createdAt),
      updatedAt: DateTime.parse(proto.updatedAt),
    );
  }

  pb.Insurance _insuranceToProto(Insurance insurance) {
    return pb.Insurance()
      ..id = insurance.id
      ..policyNumber = insurance.policyNumber
      ..policyHolderName = insurance.policyHolderName
      ..policyHolderEmail = insurance.policyHolderEmail
      ..policyHolderPhone = insurance.policyHolderPhone
      ..type = insurance.type.name
      ..provider = insurance.provider
      ..providerLogo = insurance.providerLogo
      ..premiumAmount = insurance.premiumAmount
      ..coverageAmount = insurance.coverageAmount
      ..currency = insurance.currency
      ..startDate = insurance.startDate.toIso8601String()
      ..endDate = insurance.endDate.toIso8601String()
      ..nextPaymentDate = insurance.nextPaymentDate.toIso8601String()
      ..status = insurance.status.name
      ..beneficiaries.addAll(insurance.beneficiaries)
      ..coverageDetails.addAll(insurance.coverageDetails.map((k, v) => MapEntry(k, v.toString())))
      ..description = insurance.description ?? ''
      ..userId = insurance.userId
      ..createdAt = insurance.createdAt.toIso8601String()
      ..updatedAt = insurance.updatedAt.toIso8601String();
  }

  InsurancePayment _paymentFromProto(pb.InsurancePayment proto) {
    return InsurancePayment(
      id: proto.id,
      insuranceId: proto.insuranceId,
      policyNumber: proto.policyNumber,
      amount: proto.amount,
      currency: proto.currency,
      paymentMethod: _parsePaymentMethod(proto.paymentMethod),
      status: _parsePaymentStatus(proto.status),
      transactionId: proto.transactionId.isEmpty ? null : proto.transactionId,
      referenceNumber: proto.referenceNumber.isEmpty ? null : proto.referenceNumber,
      paymentDate: proto.paymentDate.isEmpty ? DateTime.now() : DateTime.parse(proto.paymentDate),
      dueDate: DateTime.parse(proto.dueDate),
      processedAt: proto.processedAt.isEmpty ? null : DateTime.parse(proto.processedAt),
      paymentDetails: proto.paymentDetails.isEmpty ? {} : Map<String, dynamic>.from(proto.paymentDetails),
      failureReason: proto.failureReason.isEmpty ? null : proto.failureReason,
      receiptUrl: proto.receiptUrl.isEmpty ? null : proto.receiptUrl,
      userId: proto.userId,
      createdAt: DateTime.parse(proto.createdAt),
      updatedAt: DateTime.parse(proto.updatedAt),
    );
  }

  pb.InsurancePayment _paymentToProto(InsurancePayment payment) {
    return pb.InsurancePayment()
      ..id = payment.id
      ..insuranceId = payment.insuranceId
      ..policyNumber = payment.policyNumber
      ..amount = payment.amount
      ..currency = payment.currency
      ..paymentMethod = payment.paymentMethod.name
      ..status = payment.status.name
      ..transactionId = payment.transactionId ?? ''
      ..referenceNumber = payment.referenceNumber ?? ''
      ..paymentDate = payment.paymentDate.toIso8601String()
      ..dueDate = payment.dueDate.toIso8601String()
      ..processedAt = payment.processedAt?.toIso8601String() ?? ''
      ..paymentDetails.addAll((payment.paymentDetails ?? {}).map((k, v) => MapEntry(k, v.toString())))
      ..failureReason = payment.failureReason ?? ''
      ..receiptUrl = payment.receiptUrl ?? ''
      ..userId = payment.userId
      ..createdAt = payment.createdAt.toIso8601String()
      ..updatedAt = payment.updatedAt.toIso8601String();
  }

  InsuranceClaim _claimFromProto(pb.InsuranceClaim proto) {
    return InsuranceClaim(
      id: proto.id,
      claimNumber: proto.claimNumber,
      insuranceId: proto.insuranceId,
      policyNumber: proto.policyNumber,
      type: _parseClaimType(proto.type),
      status: _parseClaimStatus(proto.status),
      title: proto.title,
      description: proto.description,
      claimAmount: proto.claimAmount,
      approvedAmount: proto.approvedAmount == 0 ? null : proto.approvedAmount,
      currency: proto.currency,
      incidentDate: DateTime.parse(proto.incidentDate),
      incidentLocation: proto.incidentLocation,
      attachments: proto.attachments.toList(),
      documents: proto.documents.toList(),
      additionalInfo: Map<String, dynamic>.from(proto.additionalInfo),
      rejectionReason: proto.rejectionReason.isEmpty ? null : proto.rejectionReason,
      settlementDate: proto.settlementDate.isEmpty ? null : DateTime.parse(proto.settlementDate),
      settlementDetails: proto.settlementDetails.isEmpty ? null : proto.settlementDetails,
      userId: proto.userId,
      createdAt: DateTime.parse(proto.createdAt),
      updatedAt: DateTime.parse(proto.updatedAt),
    );
  }

  pb.InsuranceClaim _claimToProto(InsuranceClaim claim) {
    return pb.InsuranceClaim()
      ..id = claim.id
      ..claimNumber = claim.claimNumber
      ..insuranceId = claim.insuranceId
      ..policyNumber = claim.policyNumber
      ..type = claim.type.name
      ..status = claim.status.name
      ..title = claim.title
      ..description = claim.description
      ..claimAmount = claim.claimAmount
      ..approvedAmount = claim.approvedAmount ?? 0.0
      ..currency = claim.currency
      ..incidentDate = claim.incidentDate.toIso8601String()
      ..incidentLocation = claim.incidentLocation
      ..attachments.addAll(claim.attachments)
      ..documents.addAll(claim.documents)
      ..additionalInfo.addAll(claim.additionalInfo.map((k, v) => MapEntry(k, v.toString())))
      ..rejectionReason = claim.rejectionReason ?? ''
      ..settlementDate = claim.settlementDate?.toIso8601String() ?? ''
      ..settlementDetails = claim.settlementDetails ?? ''
      ..userId = claim.userId
      ..createdAt = claim.createdAt.toIso8601String()
      ..updatedAt = claim.updatedAt.toIso8601String();
  }

  InsuranceType _parseInsuranceType(String type) {
    try {
      return InsuranceType.values.firstWhere((e) => e.name == type.toLowerCase());
    } catch (e) {
      return InsuranceType.health; // Default fallback
    }
  }

  InsuranceStatus _parseInsuranceStatus(String status) {
    try {
      return InsuranceStatus.values.firstWhere((e) => e.name == status.toLowerCase());
    } catch (e) {
      return InsuranceStatus.pending; // Default fallback
    }
  }

  PaymentMethod _parsePaymentMethod(String method) {
    try {
      return PaymentMethod.values.firstWhere((e) => e.name == method.toLowerCase());
    } catch (e) {
      return PaymentMethod.wallet; // Default fallback
    }
  }

  PaymentStatus _parsePaymentStatus(String status) {
    try {
      return PaymentStatus.values.firstWhere((e) => e.name == status.toLowerCase());
    } catch (e) {
      return PaymentStatus.pending; // Default fallback
    }
  }

  ClaimType _parseClaimType(String type) {
    try {
      return ClaimType.values.firstWhere((e) => e.name == type.toLowerCase());
    } catch (e) {
      return ClaimType.other; // Default fallback
    }
  }

  ClaimStatus _parseClaimStatus(String status) {
    try {
      return ClaimStatus.values.firstWhere((e) => e.name == status.toLowerCase());
    } catch (e) {
      return ClaimStatus.submitted; // Default fallback
    }
  }
}
