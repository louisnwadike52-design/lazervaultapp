import '../entities/crowdfund_entities.dart';
import '../repositories/crowdfund_repository.dart';

// ============================================================================
// CROWDFUND MANAGEMENT USE CASES
// ============================================================================

class CreateCrowdfundUseCase {
  final CrowdfundRepository repository;

  CreateCrowdfundUseCase(this.repository);

  Future<Crowdfund> call({
    required String title,
    required String description,
    required String story,
    required double targetAmount,
    required String currency,
    DateTime? deadline,
    required String category,
    String? imageUrl,
    required CrowdfundVisibility visibility,
    Map<String, dynamic>? metadata,
  }) {
    return repository.createCrowdfund(
      title: title,
      description: description,
      story: story,
      targetAmount: targetAmount,
      currency: currency,
      deadline: deadline,
      category: category,
      imageUrl: imageUrl,
      visibility: visibility,
      metadata: metadata,
    );
  }
}

class GetCrowdfundUseCase {
  final CrowdfundRepository repository;

  GetCrowdfundUseCase(this.repository);

  Future<Crowdfund> call(String crowdfundId) {
    return repository.getCrowdfund(crowdfundId);
  }
}

class ListCrowdfundsUseCase {
  final CrowdfundRepository repository;

  ListCrowdfundsUseCase(this.repository);

  Future<List<Crowdfund>> call({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
  }) {
    return repository.listCrowdfunds(
      page: page,
      pageSize: pageSize,
      statusFilter: statusFilter,
      categoryFilter: categoryFilter,
      myCrowdfundsOnly: myCrowdfundsOnly,
    );
  }
}

class SearchCrowdfundsUseCase {
  final CrowdfundRepository repository;

  SearchCrowdfundsUseCase(this.repository);

  Future<List<Crowdfund>> call({
    required String query,
    int limit = 10,
  }) {
    return repository.searchCrowdfunds(
      query: query,
      limit: limit,
    );
  }
}

class UpdateCrowdfundUseCase {
  final CrowdfundRepository repository;

  UpdateCrowdfundUseCase(this.repository);

  Future<Crowdfund> call({
    required String crowdfundId,
    String? title,
    String? description,
    String? story,
    DateTime? deadline,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) {
    return repository.updateCrowdfund(
      crowdfundId: crowdfundId,
      title: title,
      description: description,
      story: story,
      deadline: deadline,
      status: status,
      imageUrl: imageUrl,
      metadata: metadata,
    );
  }
}

class DeleteCrowdfundUseCase {
  final CrowdfundRepository repository;

  DeleteCrowdfundUseCase(this.repository);

  Future<void> call(String crowdfundId) {
    return repository.deleteCrowdfund(crowdfundId);
  }
}

// ============================================================================
// DONATION USE CASES
// ============================================================================

class MakeDonationUseCase {
  final CrowdfundRepository repository;

  MakeDonationUseCase(this.repository);

  Future<CrowdfundDonation> call({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    int? sourceAccountId,
  }) {
    return repository.makeDonation(
      crowdfundId: crowdfundId,
      amount: amount,
      message: message,
      isAnonymous: isAnonymous,
      sourceAccountId: sourceAccountId,
    );
  }
}

class GetCrowdfundDonationsUseCase {
  final CrowdfundRepository repository;

  GetCrowdfundDonationsUseCase(this.repository);

  Future<List<CrowdfundDonation>> call({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  }) {
    return repository.getCrowdfundDonations(
      crowdfundId: crowdfundId,
      page: page,
      pageSize: pageSize,
    );
  }
}

class GetUserDonationsUseCase {
  final CrowdfundRepository repository;

  GetUserDonationsUseCase(this.repository);

  Future<List<CrowdfundDonation>> call({
    int page = 1,
    int pageSize = 20,
  }) {
    return repository.getUserDonations(
      page: page,
      pageSize: pageSize,
    );
  }
}

// ============================================================================
// RECEIPT USE CASES
// ============================================================================

class GenerateDonationReceiptUseCase {
  final CrowdfundRepository repository;

  GenerateDonationReceiptUseCase(this.repository);

  Future<CrowdfundReceipt> call(String donationId) {
    return repository.generateDonationReceipt(donationId);
  }
}

class GetUserReceiptsUseCase {
  final CrowdfundRepository repository;

  GetUserReceiptsUseCase(this.repository);

  Future<List<CrowdfundReceipt>> call({
    int page = 1,
    int pageSize = 20,
  }) {
    return repository.getUserReceipts(
      page: page,
      pageSize: pageSize,
    );
  }
}

// ============================================================================
// STATISTICS USE CASES
// ============================================================================

class GetCrowdfundStatisticsUseCase {
  final CrowdfundRepository repository;

  GetCrowdfundStatisticsUseCase(this.repository);

  Future<CrowdfundStatistics> call(String crowdfundId) {
    return repository.getCrowdfundStatistics(crowdfundId);
  }
}
