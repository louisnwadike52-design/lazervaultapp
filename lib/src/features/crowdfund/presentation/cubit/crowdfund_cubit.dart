import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/usecases/crowdfund_usecases.dart';
import 'crowdfund_state.dart';

class CrowdfundCubit extends Cubit<CrowdfundState> {
  final CreateCrowdfundUseCase createCrowdfundUseCase;
  final GetCrowdfundUseCase getCrowdfundUseCase;
  final ListCrowdfundsUseCase listCrowdfundsUseCase;
  final SearchCrowdfundsUseCase searchCrowdfundsUseCase;
  final UpdateCrowdfundUseCase updateCrowdfundUseCase;
  final DeleteCrowdfundUseCase deleteCrowdfundUseCase;
  final MakeDonationUseCase makeDonationUseCase;
  final GetCrowdfundDonationsUseCase getCrowdfundDonationsUseCase;
  final GetUserDonationsUseCase getUserDonationsUseCase;
  final GenerateDonationReceiptUseCase generateDonationReceiptUseCase;
  final GetUserReceiptsUseCase getUserReceiptsUseCase;
  final GetCrowdfundStatisticsUseCase getCrowdfundStatisticsUseCase;

  CrowdfundCubit({
    required this.createCrowdfundUseCase,
    required this.getCrowdfundUseCase,
    required this.listCrowdfundsUseCase,
    required this.searchCrowdfundsUseCase,
    required this.updateCrowdfundUseCase,
    required this.deleteCrowdfundUseCase,
    required this.makeDonationUseCase,
    required this.getCrowdfundDonationsUseCase,
    required this.getUserDonationsUseCase,
    required this.generateDonationReceiptUseCase,
    required this.getUserReceiptsUseCase,
    required this.getCrowdfundStatisticsUseCase,
  }) : super(const CrowdfundInitial());

  /// Load all crowdfunds with optional filters
  Future<void> loadCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading crowdfunds...'));

      final crowdfunds = await listCrowdfundsUseCase(
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
        categoryFilter: categoryFilter,
        myCrowdfundsOnly: myCrowdfundsOnly,
      );

      if (isClosed) return;
      emit(CrowdfundLoaded(
        crowdfunds: crowdfunds,
        totalCount: crowdfunds.length,
        currentPage: page,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: e.toString()));
    }
  }

  /// Search crowdfunds by query (username or crowdfund code)
  Future<void> searchCrowdfunds({
    required String query,
    int limit = 10,
  }) async {
    try {
      if (query.trim().isEmpty) {
        await loadCrowdfunds();
        return;
      }

      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Searching...'));

      final crowdfunds = await searchCrowdfundsUseCase(
        query: query,
        limit: limit,
      );

      if (isClosed) return;
      emit(CrowdfundLoaded(
        crowdfunds: crowdfunds,
        totalCount: crowdfunds.length,
        currentPage: 1,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Search failed: ${e.toString()}'));
    }
  }

  /// Load single crowdfund details with donations and statistics
  Future<void> loadCrowdfundDetails(String crowdfundId) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading details...'));

      // Load crowdfund details
      final crowdfund = await getCrowdfundUseCase(crowdfundId);

      // Load donations
      final donations = await getCrowdfundDonationsUseCase(
        crowdfundId: crowdfundId,
        page: 1,
        pageSize: 50,
      );

      // Load statistics
      CrowdfundStatistics? statistics;
      try {
        statistics = await getCrowdfundStatisticsUseCase(crowdfundId);
      } catch (e) {
        // Statistics optional, continue without them
      }

      if (isClosed) return;
      emit(CrowdfundDetailsLoaded(
        crowdfund: crowdfund,
        donations: donations,
        statistics: statistics,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: e.toString()));
    }
  }

  /// Create a new crowdfund (verified users only)
  Future<void> createCrowdfund({
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
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Creating crowdfund...'));

      final crowdfund = await createCrowdfundUseCase(
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

      if (isClosed) return;
      emit(CrowdfundCreated(crowdfund));
    } catch (e) {
      // Check if error is about verification
      if (e.toString().contains('verified') ||
          e.toString().contains('PermissionDenied')) {
        if (isClosed) return;
        emit(const CrowdfundError(
          message:
              'Only verified users can create crowdfunds. Please verify your account first.',
          errorCode: 'VERIFICATION_REQUIRED',
        ));
      } else {
        if (isClosed) return;
        emit(CrowdfundError(message: 'Failed to create crowdfund: $e'));
      }
    }
  }

  /// Update an existing crowdfund
  Future<void> updateCrowdfund({
    required String crowdfundId,
    String? title,
    String? description,
    String? story,
    DateTime? deadline,
    CrowdfundStatus? status,
    String? imageUrl,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Updating crowdfund...'));

      final crowdfund = await updateCrowdfundUseCase(
        crowdfundId: crowdfundId,
        title: title,
        description: description,
        story: story,
        deadline: deadline,
        status: status,
        imageUrl: imageUrl,
        metadata: metadata,
      );

      if (isClosed) return;
      emit(CrowdfundUpdated(crowdfund));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to update crowdfund: $e'));
    }
  }

  /// Delete a crowdfund
  Future<void> deleteCrowdfund(String crowdfundId) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Deleting crowdfund...'));

      await deleteCrowdfundUseCase(crowdfundId);

      // Reload crowdfunds after deletion
      await loadCrowdfunds();
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to delete crowdfund: $e'));
    }
  }

  /// Make a donation with processing steps
  Future<void> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    int? sourceAccountId,
  }) async {
    try {
      // Step 1: Verifying donation
      if (isClosed) return;
      emit(const DonationProcessing(
        step: 'Verifying donation',
        currentStepIndex: 1,
        totalSteps: 4,
      ));
      await Future.delayed(const Duration(milliseconds: 500));

      // Step 2: Processing payment
      if (isClosed) return;
      emit(const DonationProcessing(
        step: 'Processing payment',
        currentStepIndex: 2,
        totalSteps: 4,
      ));

      final donation = await makeDonationUseCase(
        crowdfundId: crowdfundId,
        amount: amount,
        message: message,
        isAnonymous: isAnonymous,
        sourceAccountId: sourceAccountId,
      );

      // Step 3: Updating crowdfund
      if (isClosed) return;
      emit(const DonationProcessing(
        step: 'Updating crowdfund',
        currentStepIndex: 3,
        totalSteps: 4,
      ));
      await Future.delayed(const Duration(milliseconds: 500));

      // Step 4: Generating receipt
      if (isClosed) return;
      emit(const DonationProcessing(
        step: 'Generating receipt',
        currentStepIndex: 4,
        totalSteps: 4,
      ));

      CrowdfundReceipt? receipt;
      try {
        receipt = await generateDonationReceiptUseCase(donation.id);
      } catch (e) {
        // Receipt generation optional
      }

      if (isClosed) return;
      emit(DonationCompleted(
        donation: donation,
        receipt: receipt,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Donation failed: ${e.toString()}'));
    }
  }

  /// Load crowdfund donations with pagination
  Future<void> loadCrowdfundDonations({
    required String crowdfundId,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading donations...'));

      final donations = await getCrowdfundDonationsUseCase(
        crowdfundId: crowdfundId,
        page: page,
        pageSize: pageSize,
      );

      // If we're already in details view, update it
      if (state is CrowdfundDetailsLoaded) {
        final currentState = state as CrowdfundDetailsLoaded;
        if (isClosed) return;
        emit(CrowdfundDetailsLoaded(
          crowdfund: currentState.crowdfund,
          donations: donations,
          statistics: currentState.statistics,
        ));
      } else {
        if (isClosed) return;
        emit(const CrowdfundError(
            message: 'Cannot load donations without crowdfund details'));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to load donations: $e'));
    }
  }

  /// Load user's donations
  Future<void> loadUserDonations({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading your donations...'));

      final donations = await getUserDonationsUseCase(
        page: page,
        pageSize: pageSize,
      );

      if (isClosed) return;
      emit(UserDonationsLoaded(
        donations: donations,
        totalCount: donations.length,
        currentPage: page,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to load donations: $e'));
    }
  }

  /// Generate receipt for a donation
  Future<void> generateReceipt(String donationId) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Generating receipt...'));

      final receipt = await generateDonationReceiptUseCase(donationId);

      if (isClosed) return;
      emit(ReceiptGenerated(receipt));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to generate receipt: $e'));
    }
  }

  /// Load user's receipts
  Future<void> loadUserReceipts({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading receipts...'));

      final receipts = await getUserReceiptsUseCase(
        page: page,
        pageSize: pageSize,
      );

      if (isClosed) return;
      emit(UserReceiptsLoaded(
        receipts: receipts,
        totalCount: receipts.length,
        currentPage: page,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to load receipts: $e'));
    }
  }

  /// Load statistics for a crowdfund
  Future<void> loadStatistics(String crowdfundId) async {
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading statistics...'));

      final statistics = await getCrowdfundStatisticsUseCase(crowdfundId);

      if (isClosed) return;
      emit(StatisticsLoaded(statistics));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Failed to load statistics: $e'));
    }
  }

  /// Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(const CrowdfundInitial());
  }
}
