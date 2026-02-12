import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../data/services/crowdfund_report_service.dart';
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
  final CrowdfundReportService? reportService;
  final SWRCacheManager? _cacheManager;

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
    this.reportService,
    SWRCacheManager? cacheManager,
  })  : _cacheManager = cacheManager,
        super(const CrowdfundInitial());

  /// Load all crowdfunds with optional filters (SWR cached)
  Future<void> loadCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
  }) async {
    try {
      if (isClosed) return;

      final cacheKey =
          'crowdfunds:${statusFilter ?? ''}:${categoryFilter ?? ''}:$myCrowdfundsOnly:$page';

      if (_cacheManager != null) {
        emit(const CrowdfundLoading(message: 'Loading crowdfunds...'));

        await for (final result in _cacheManager!.get<List<Crowdfund>>(
          key: cacheKey,
          fetcher: () => listCrowdfundsUseCase(
            page: page,
            pageSize: pageSize,
            statusFilter: statusFilter,
            categoryFilter: categoryFilter,
            myCrowdfundsOnly: myCrowdfundsOnly,
          ),
          config: CacheConfig.crowdfunds,
          serializer: (crowdfunds) =>
              jsonEncode(crowdfunds.map((c) => c.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => Crowdfund.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(CrowdfundLoaded(
              crowdfunds: result.data!,
              totalCount: result.data!.length,
              currentPage: page,
              isStale: result.isStale,
            ));
          } else if (result.hasError) {
            emit(CrowdfundError(message: result.error.toString()));
          }
        }
      } else {
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
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: e.toString()));
    }
  }

  /// Search crowdfunds by query (SWR cached)
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

      final cacheKey = 'crowdfund_search:$query';

      if (_cacheManager != null) {
        emit(const CrowdfundLoading(message: 'Searching...'));

        await for (final result in _cacheManager!.get<List<Crowdfund>>(
          key: cacheKey,
          fetcher: () => searchCrowdfundsUseCase(
            query: query,
            limit: limit,
          ),
          config: CacheConfig.search,
          serializer: (crowdfunds) =>
              jsonEncode(crowdfunds.map((c) => c.toJson()).toList()),
          deserializer: (json) => (jsonDecode(json) as List)
              .map((j) => Crowdfund.fromJson(j as Map<String, dynamic>))
              .toList(),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            emit(CrowdfundLoaded(
              crowdfunds: result.data!,
              totalCount: result.data!.length,
              currentPage: 1,
              isStale: result.isStale,
            ));
          } else if (result.hasError) {
            emit(CrowdfundError(
                message: 'Search failed: ${result.error.toString()}'));
          }
        }
      } else {
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
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: 'Search failed: ${e.toString()}'));
    }
  }

  /// Load single crowdfund details with donations and statistics (SWR cached)
  Future<void> loadCrowdfundDetails(String crowdfundId) async {
    try {
      if (isClosed) return;

      final cacheKey = 'crowdfund_detail:$crowdfundId';

      if (_cacheManager != null) {
        emit(const CrowdfundLoading(message: 'Loading details...'));

        // SWR cache the crowdfund object; donations/stats fetched fresh each time
        await for (final result in _cacheManager!.get<Crowdfund>(
          key: cacheKey,
          fetcher: () => getCrowdfundUseCase(crowdfundId),
          config: CacheConfig.crowdfundDetails,
          serializer: (crowdfund) => jsonEncode(crowdfund.toJson()),
          deserializer: (json) =>
              Crowdfund.fromJson(jsonDecode(json) as Map<String, dynamic>),
        )) {
          if (isClosed) return;
          if (result.hasData) {
            final crowdfund = result.data!;

            if (result.isStale) {
              // Emit cached crowdfund immediately with empty donations
              emit(CrowdfundDetailsLoaded(
                crowdfund: crowdfund,
                donations: const [],
                isStale: true,
              ));
            } else {
              // Fresh data: also fetch donations and statistics
              final donations = await getCrowdfundDonationsUseCase(
                crowdfundId: crowdfundId,
                page: 1,
                pageSize: 50,
              );

              CrowdfundStatistics? statistics;
              try {
                statistics =
                    await getCrowdfundStatisticsUseCase(crowdfundId);
              } catch (_) {
                // Statistics optional
              }

              if (isClosed) return;
              emit(CrowdfundDetailsLoaded(
                crowdfund: crowdfund,
                donations: donations,
                statistics: statistics,
              ));
            }
          } else if (result.hasError) {
            emit(CrowdfundError(message: result.error.toString()));
          }
        }
      } else {
        emit(const CrowdfundLoading(message: 'Loading details...'));

        final crowdfund = await getCrowdfundUseCase(crowdfundId);
        final donations = await getCrowdfundDonationsUseCase(
          crowdfundId: crowdfundId,
          page: 1,
          pageSize: 50,
        );

        CrowdfundStatistics? statistics;
        try {
          statistics = await getCrowdfundStatisticsUseCase(crowdfundId);
        } catch (_) {
          // Statistics optional
        }

        if (isClosed) return;
        emit(CrowdfundDetailsLoaded(
          crowdfund: crowdfund,
          donations: donations,
          statistics: statistics,
        ));
      }
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

      await _cacheManager?.invalidatePattern('crowdfunds:');

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

      await _cacheManager?.invalidatePattern('crowdfund');

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

      await _cacheManager?.invalidatePattern('crowdfund');

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

      // Invalidate detail and search caches after donation
      await _cacheManager?.invalidatePattern('crowdfund_detail:');
      await _cacheManager?.invalidatePattern('crowdfund_search:');

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

  // ============================================================================
  // REPORT METHODS
  // ============================================================================

  /// Generate AI-powered campaign report
  Future<void> generateReport({
    required Crowdfund crowdfund,
    CrowdfundStatistics? statistics,
    List<CrowdfundDonation>? donations,
    String reportType = 'progress',
    String? campaignUrl,
  }) async {
    if (reportService == null) {
      if (isClosed) return;
      emit(const CrowdfundError(
        message: 'Report service not available',
        errorCode: 'SERVICE_UNAVAILABLE',
      ));
      return;
    }

    try {
      if (isClosed) return;
      emit(const CrowdfundReportLoading(
        message: 'Generating AI report...',
      ));

      // If statistics not provided, try to fetch them
      final stats = statistics ??
          await getCrowdfundStatisticsUseCase(crowdfund.id);

      // If donations not provided, fetch recent ones
      final recentDonations = donations ??
          await getCrowdfundDonationsUseCase(
            crowdfundId: crowdfund.id,
            page: 1,
            pageSize: 10,
          );

      final report = await reportService!.generateReport(
        crowdfund: crowdfund,
        statistics: stats,
        contributions: recentDonations,
        reportType: reportType,
      );

      if (isClosed) return;
      emit(CrowdfundReportGenerated(
        report: report,
        crowdfund: crowdfund,
        campaignUrl: campaignUrl,
      ));
    } on ReportGenerationException catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(
        message: e.message,
        errorCode: 'REPORT_GENERATION_FAILED',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(
        message: 'Failed to generate report: ${e.toString()}',
        errorCode: 'REPORT_GENERATION_ERROR',
      ));
    }
  }

  /// Share report to WhatsApp
  Future<void> shareReportToWhatsApp(
    CrowdfundReport report,
    String? campaignUrl,
  ) async {
    if (reportService == null) return;

    try {
      await reportService!.shareToWhatsApp(report, campaignUrl);
      if (isClosed) return;
      emit(const CrowdfundReportShared(
        platform: 'WhatsApp',
        message: 'Report shared to WhatsApp',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundReportShareError(
        message: 'Failed to share to WhatsApp: $e',
        platform: 'WhatsApp',
      ));
    }
  }

  /// Share report to Facebook
  Future<void> shareReportToFacebook(
    CrowdfundReport report,
    String? campaignUrl,
  ) async {
    if (reportService == null) return;

    try {
      await reportService!.shareToFacebook(report, campaignUrl);
      if (isClosed) return;
      emit(const CrowdfundReportShared(
        platform: 'Facebook',
        message: 'Report shared to Facebook',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundReportShareError(
        message: 'Failed to share to Facebook: $e',
        platform: 'Facebook',
      ));
    }
  }

  /// Share report to Telegram
  Future<void> shareReportToTelegram(
    CrowdfundReport report,
    String? campaignUrl,
  ) async {
    if (reportService == null) return;

    try {
      await reportService!.shareToTelegram(report, campaignUrl);
      if (isClosed) return;
      emit(const CrowdfundReportShared(
        platform: 'Telegram',
        message: 'Report shared to Telegram',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundReportShareError(
        message: 'Failed to share to Telegram: $e',
        platform: 'Telegram',
      ));
    }
  }

  /// Share report to Twitter/X
  Future<void> shareReportToTwitter(
    CrowdfundReport report,
    String? campaignUrl,
  ) async {
    if (reportService == null) return;

    try {
      await reportService!.shareToTwitter(report, campaignUrl);
      if (isClosed) return;
      emit(const CrowdfundReportShared(
        platform: 'Twitter',
        message: 'Report shared to Twitter',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundReportShareError(
        message: 'Failed to share to Twitter: $e',
        platform: 'Twitter',
      ));
    }
  }

  /// Share report using system share sheet
  Future<void> shareReportGeneral(
    CrowdfundReport report,
    String? campaignUrl,
  ) async {
    if (reportService == null) return;

    try {
      await reportService!.shareGeneral(report, campaignUrl);
      if (isClosed) return;
      emit(const CrowdfundReportShared(
        platform: 'General',
        message: 'Report shared successfully',
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundReportShareError(
        message: 'Failed to share report: $e',
        platform: 'General',
      ));
    }
  }

  /// Get shareable text for copying
  String? getShareableText(CrowdfundReport report, String? campaignUrl) {
    if (reportService == null) return null;
    return reportService!.getShareableText(report, campaignUrl);
  }
}
