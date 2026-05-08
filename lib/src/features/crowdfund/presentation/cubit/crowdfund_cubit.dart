import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../../core/utils/user_friendly_error.dart';
import '../../data/services/crowdfund_report_service.dart';
import '../../domain/entities/crowdfund_entities.dart';
import '../../domain/entities/notification_channel_entities.dart';
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
  final GetMyCrowdfundsUseCase? getMyCrowdfundsUseCase;
  final WithdrawFromCrowdfundUseCase? withdrawFromCrowdfundUseCase;
  final GetCampaignWalletBalanceUseCase? getCampaignWalletBalanceUseCase;
  final ConnectNotificationChannelUseCase? connectNotificationChannelUseCase;
  final DisconnectNotificationChannelUseCase? disconnectNotificationChannelUseCase;
  final GetNotificationChannelsUseCase? getNotificationChannelsUseCase;
  final UpdateNotificationChannelUseCase? updateNotificationChannelUseCase;
  final TestNotificationChannelUseCase? testNotificationChannelUseCase;
  final CrowdfundReportService? reportService;
  final SWRCacheManager? _cacheManager;

  // Monotonically increasing token used to invalidate in-flight pagination
  // / detail fetches when a fresh `loadCrowdfunds` / `searchCrowdfunds` /
  // `loadCrowdfundDetails` arrives. Without this, a slow page-2 fetch can
  // append to a list that has since been replaced by a different filter
  // or search result, mixing two queries' rows in the same view.
  int _listGeneration = 0;
  int _detailGeneration = 0;

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
    this.getMyCrowdfundsUseCase,
    this.withdrawFromCrowdfundUseCase,
    this.getCampaignWalletBalanceUseCase,
    this.connectNotificationChannelUseCase,
    this.disconnectNotificationChannelUseCase,
    this.getNotificationChannelsUseCase,
    this.updateNotificationChannelUseCase,
    this.testNotificationChannelUseCase,
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

      // Bump the generation so any in-flight loadMore / search results
      // discover their captured token is stale and drop their emit.
      final gen = ++_listGeneration;

      final cacheKey =
          'crowdfunds:${statusFilter ?? ''}:${categoryFilter ?? ''}:$myCrowdfundsOnly:$page';

      if (_cacheManager != null) {
        // Avoid Loading flicker when we already have a list rendered.
        if (state is! CrowdfundLoaded) {
          emit(const CrowdfundLoading(message: 'Loading crowdfunds...'));
        }

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
          if (isClosed || gen != _listGeneration) return;
          if (result.hasData) {
            emit(CrowdfundLoaded(
              crowdfunds: result.data!,
              totalCount: result.data!.length,
              currentPage: page,
              isStale: result.isStale,
              hasMore: result.data!.length >= pageSize,
            ));
          } else if (result.hasError) {
            emit(CrowdfundError(message: getUserFriendlyErrorMessage(result.error)));
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

        if (isClosed || gen != _listGeneration) return;
        emit(CrowdfundLoaded(
          crowdfunds: crowdfunds,
          totalCount: crowdfunds.length,
          currentPage: page,
          hasMore: crowdfunds.length >= pageSize,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e)));
    }
  }

  /// Load next page of crowdfunds (append to existing list)
  Future<void> loadMoreCrowdfunds({
    int pageSize = 20,
    String? statusFilter,
    String? categoryFilter,
    bool myCrowdfundsOnly = false,
  }) async {
    final currentState = state;
    if (currentState is! CrowdfundLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    // Capture the generation that produced `currentState`. If a fresh
    // load (filter change, pull-to-refresh, search) bumps the generation
    // before our await resolves, drop the result rather than appending
    // page N of an obsolete query to the new list.
    final gen = _listGeneration;

    try {
      if (isClosed) return;
      final nextPage = currentState.currentPage + 1;
      emit(currentState.copyWith(isLoadingMore: true));

      final crowdfunds = await listCrowdfundsUseCase(
        page: nextPage,
        pageSize: pageSize,
        statusFilter: statusFilter,
        categoryFilter: categoryFilter,
        myCrowdfundsOnly: myCrowdfundsOnly,
      );

      if (isClosed || gen != _listGeneration) return;
      emit(CrowdfundLoaded(
        crowdfunds: [...currentState.crowdfunds, ...crowdfunds],
        totalCount: currentState.totalCount + crowdfunds.length,
        currentPage: nextPage,
        hasMore: crowdfunds.length >= pageSize,
      ));
    } catch (e) {
      if (isClosed || gen != _listGeneration) return;
      // On error, revert to previous state without loading indicator
      emit(currentState.copyWith(isLoadingMore: false));
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

      // Bump the generation: a search result replaces any list view, so
      // any pending loadMore must not append page-2-of-old-filter to it.
      final gen = ++_listGeneration;

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
          if (isClosed || gen != _listGeneration) return;
          if (result.hasData) {
            emit(CrowdfundLoaded(
              crowdfunds: result.data!,
              totalCount: result.data!.length,
              currentPage: 1,
              isStale: result.isStale,
              // Search isn't paginated server-side; mark hasMore=false so
              // an infinite-scroll listener doesn't trip loadMoreCrowdfunds
              // and clobber the search list with page-2 of the regular feed.
              hasMore: false,
            ));
          } else if (result.hasError) {
            emit(CrowdfundError(
                message: getUserFriendlyErrorMessage(result.error, fallback: 'Search failed. Please try again.')));
          }
        }
      } else {
        emit(const CrowdfundLoading(message: 'Searching...'));

        final crowdfunds = await searchCrowdfundsUseCase(
          query: query,
          limit: limit,
        );

        if (isClosed || gen != _listGeneration) return;
        emit(CrowdfundLoaded(
          crowdfunds: crowdfunds,
          totalCount: crowdfunds.length,
          currentPage: 1,
          hasMore: false,
        ));
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Search failed. Please try again.')));
    }
  }

  /// Last-known donations cache, keyed by crowdfundId. Survives across
  /// cubit method calls so that switching back to a previously visited
  /// campaign paints donors immediately instead of flashing an empty
  /// list while the cache stream re-emits the cached crowdfund row.
  ///
  /// Bounded to [_donationsCacheCap] entries with LRU eviction so a
  /// long session that browses many campaigns can't grow this map
  /// without limit. Insertion uses Map's insertion-order semantics
  /// (the key is removed and re-inserted on every write/read so the
  /// most-recently-touched entries sit at the tail).
  static const int _donationsCacheCap = 50;
  final Map<String, List<CrowdfundDonation>> _donationsByCrowdfund = {};

  void _setDonationsCache(String crowdfundId, List<CrowdfundDonation> rows) {
    _donationsByCrowdfund.remove(crowdfundId);
    _donationsByCrowdfund[crowdfundId] = rows;
    while (_donationsByCrowdfund.length > _donationsCacheCap) {
      _donationsByCrowdfund.remove(_donationsByCrowdfund.keys.first);
    }
  }

  List<CrowdfundDonation>? _getDonationsCache(String crowdfundId) {
    final rows = _donationsByCrowdfund.remove(crowdfundId);
    if (rows == null) return null;
    _donationsByCrowdfund[crowdfundId] = rows;
    return rows;
  }

  /// Load single crowdfund details with first-page donations.
  ///
  /// Production-grade stale-while-revalidate:
  ///   - Crowdfund row and first donations page are BOTH SWR-cached
  ///     and emit independently. A cached row paints instantly while
  ///     a network revalidation runs in the background.
  ///   - Last-known donations seed the first emit so the donor list
  ///     never blanks during revalidation.
  ///   - Crowdfund + donations refresh in parallel, not sequentially.
  ///   - Statistics are NOT fetched here — only `averageDonation` is
  ///     used by the screen, and that's derived client-side from the
  ///     row. The report screen lazy-fetches statistics on demand.
  Future<void> loadCrowdfundDetails(String crowdfundId) async {
    try {
      if (isClosed) return;

      // Bump the detail generation: if the user navigates from campaign A
      // to campaign B before A's parallel donations fetches resolve,
      // the captured token mismatch lets us drop A's results instead of
      // rendering them on top of B.
      final gen = ++_detailGeneration;

      final crowdfundKey = 'crowdfund_detail:$crowdfundId';
      final donationsKey = 'crowdfund_donations_p1:$crowdfundId';

      // The detail screen only renders 5 donors before requiring a tap to
      // expand, so over-fetching 50 just adds latency to first paint.
      const initialDonationPageSize = 10;

      Crowdfund? freshCrowdfund;
      List<CrowdfundDonation>? freshDonations;
      bool crowdfundIsStale = false;
      bool donationsIsStale = false;

      void emitCurrent() {
        if (isClosed || gen != _detailGeneration) return;
        if (freshCrowdfund == null) return;
        // Use last-known donations as a seed when this emit doesn't
        // (yet) have its own donations payload — prevents the empty
        // donor flash during background revalidation of the row.
        final donations = freshDonations ??
            _getDonationsCache(crowdfundId) ??
            const <CrowdfundDonation>[];
        emit(CrowdfundDetailsLoaded(
          crowdfund: freshCrowdfund!,
          donations: donations,
          donationsPage: 1,
          donationsPageSize: initialDonationPageSize,
          hasMoreDonations:
              donations.length >= initialDonationPageSize,
          // The whole surface is "stale" until both layers have
          // freshened; the screen renders a top progress bar while
          // this is true.
          isStale: crowdfundIsStale || donationsIsStale,
        ));
      }

      if (_cacheManager != null) {
        // Don't show a Loading spinner if we already have last-known
        // data for this campaign — paint from cache, then revalidate.
        final hasSeed = _donationsByCrowdfund.containsKey(crowdfundId);
        if (state is! CrowdfundDetailsLoaded && !hasSeed) {
          emit(const CrowdfundLoading(message: 'Loading details...'));
        }

        // Run BOTH streams in parallel so cached crowdfund + cached
        // donations land at first paint together.
        final crowdfundFuture = () async {
          await for (final result in _cacheManager!.get<Crowdfund>(
            key: crowdfundKey,
            fetcher: () => getCrowdfundUseCase(crowdfundId),
            config: CacheConfig.crowdfundDetails,
            serializer: (c) => jsonEncode(c.toJson()),
            deserializer: (json) =>
                Crowdfund.fromJson(jsonDecode(json) as Map<String, dynamic>),
          )) {
            if (isClosed || gen != _detailGeneration) return;
            if (result.hasData) {
              freshCrowdfund = result.data!;
              crowdfundIsStale = result.isRevalidating;
              emitCurrent();
            } else if (result.hasError && freshCrowdfund == null) {
              emit(CrowdfundError(
                  message: getUserFriendlyErrorMessage(result.error)));
              return;
            }
          }
          crowdfundIsStale = false;
          emitCurrent();
        }();

        final donationsFuture = () async {
          await for (final result
              in _cacheManager!.get<List<CrowdfundDonation>>(
            key: donationsKey,
            fetcher: () => getCrowdfundDonationsUseCase(
              crowdfundId: crowdfundId,
              page: 1,
              pageSize: initialDonationPageSize,
            ),
            config: CacheConfig.crowdfundDonationsFirstPage,
            serializer: (list) =>
                jsonEncode(list.map((d) => d.toJson()).toList()),
            deserializer: (json) {
              final raw = jsonDecode(json) as List<dynamic>;
              return raw
                  .map((e) =>
                      CrowdfundDonation.fromJson(e as Map<String, dynamic>))
                  .toList();
            },
          )) {
            if (isClosed || gen != _detailGeneration) return;
            if (result.hasData) {
              final list = result.data!;
              freshDonations = list;
              _setDonationsCache(crowdfundId, list);
              donationsIsStale = result.isRevalidating;
              emitCurrent();
            }
            // Donation fetch errors are non-fatal — keep the crowdfund
            // row visible; the user can pull-to-refresh.
          }
          donationsIsStale = false;
          emitCurrent();
        }();

        await Future.wait([crowdfundFuture, donationsFuture]);
      } else {
        emit(const CrowdfundLoading(message: 'Loading details...'));

        // No cache manager wired up — fall back to a direct parallel
        // fetch.
        final results = await Future.wait<Object?>([
          getCrowdfundUseCase(crowdfundId),
          getCrowdfundDonationsUseCase(
            crowdfundId: crowdfundId,
            page: 1,
            pageSize: initialDonationPageSize,
          ),
        ]);

        if (isClosed || gen != _detailGeneration) return;
        freshCrowdfund = results[0] as Crowdfund;
        freshDonations = results[1] as List<CrowdfundDonation>;
        _setDonationsCache(crowdfundId, freshDonations);
        emitCurrent();
      }
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e)));
    }
  }

  /// Create a new crowdfund (verified users only).
  ///
  /// Crowdfunds are public by default — there is no visibility selector.
  /// Anyone with the campaign's share link can fund it.
  Future<void> createCrowdfund({
    required String title,
    required String description,
    required String story,
    required double targetAmount,
    required String currency,
    DateTime? deadline,
    required String category,
    String? imageUrl,
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
        metadata: metadata,
      );

      // Invalidate the lists so the new campaign shows up next time the
      // user lands on Browse All / My Campaigns.
      await _cacheManager?.invalidatePattern('crowdfunds:');

      // Pre-populate the detail cache so the destination screen renders the
      // just-created campaign on first frame instead of flashing a loading
      // spinner. The detail screen still kicks off loadCrowdfundDetails on
      // mount, which will revalidate (and lazily fetch the empty donations
      // list + statistics) without blocking the UI.
      await _cacheManager?.set<Crowdfund>(
        key: 'crowdfund_detail:${crowdfund.id}',
        data: crowdfund,
        config: CacheConfig.crowdfundDetails,
        serializer: (c) => jsonEncode(c.toJson()),
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
        emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Failed to create crowdfund. Please try again.')));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Failed to update crowdfund. Please try again.')));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Failed to delete crowdfund. Please try again.')));
    }
  }

  /// Make a donation with processing steps
  Future<void> makeDonation({
    required String crowdfundId,
    required double amount,
    String? message,
    bool isAnonymous = false,
    required String sourceAccountId,
    required String transactionPin,
    required String transactionId,
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
        transactionPin: transactionPin,
        transactionId: transactionId,
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Donation failed. Please try again.')));
    }
  }

  /// Append the next page of donations to the currently loaded
  /// crowdfund detail. Used by the infinite-scroll list on the detail
  /// screen — guards on `hasMoreDonations` and `isLoadingMoreDonations`
  /// so a flurry of scroll events can't double-fire the request.
  Future<void> loadMoreDonations() async {
    final currentState = state;
    if (currentState is! CrowdfundDetailsLoaded ||
        currentState.isLoadingMoreDonations ||
        !currentState.hasMoreDonations) {
      return;
    }

    // Capture detail generation to drop stale appends if the user
    // navigates to a different campaign mid-fetch.
    final gen = _detailGeneration;
    final crowdfundId = currentState.crowdfund.id;
    final pageSize = currentState.donationsPageSize;
    final nextPage = currentState.donationsPage + 1;

    emit(currentState.copyWith(isLoadingMoreDonations: true));

    try {
      final more = await getCrowdfundDonationsUseCase(
        crowdfundId: crowdfundId,
        page: nextPage,
        pageSize: pageSize,
      );

      if (isClosed || gen != _detailGeneration) return;

      final latest = state;
      if (latest is! CrowdfundDetailsLoaded ||
          latest.crowdfund.id != crowdfundId) {
        // Raced with a different details load — drop this result.
        return;
      }

      // Dedup by donation id. A re-emitted contribution (e.g. retry on
      // the producer side, or overlapping page boundaries when new
      // donations arrive between requests) must not paint twice in the
      // list. We preserve the existing order and only append truly new
      // ids.
      final seen = <String>{for (final d in latest.donations) d.id};
      final fresh = <CrowdfundDonation>[];
      for (final d in more) {
        if (seen.add(d.id)) fresh.add(d);
      }

      emit(latest.copyWith(
        donations: [...latest.donations, ...fresh],
        donationsPage: nextPage,
        // hasMore reflects what the *server* returned, not the dedup
        // result — if the server gave us a full page, there are still
        // more pages even if some rows happened to be duplicates.
        hasMoreDonations: more.length >= pageSize,
        isLoadingMoreDonations: false,
      ));
    } catch (e) {
      if (isClosed || gen != _detailGeneration) return;
      final latest = state;
      if (latest is! CrowdfundDetailsLoaded) return;
      // Keep what we have; flip the flag off so the user can retry.
      emit(latest.copyWith(isLoadingMoreDonations: false));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load donations. Please try again.")));
    }
  }

  /// Load user's donations
  Future<void> loadUserDonations({
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      if (isClosed) return;
      // Bump generation: a refresh of the donations list also resets any
      // in-flight loadMoreUserDonations from a prior tab visit so we don't
      // double-emit donations that were just refetched at page 1.
      final gen = ++_listGeneration;
      // Don't flash a spinner if we already have a list visible (e.g. pull
      // to refresh on the My Funded tab). The new list will replace cleanly.
      if (state is! UserDonationsLoaded) {
        emit(const CrowdfundLoading(message: 'Loading your donations...'));
      }

      final donations = await getUserDonationsUseCase(
        page: page,
        pageSize: pageSize,
      );

      if (isClosed || gen != _listGeneration) return;
      emit(UserDonationsLoaded(
        donations: donations,
        totalCount: donations.length,
        currentPage: page,
        hasMore: donations.length >= pageSize,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load your donations. Please try again.")));
    }
  }

  /// Load next page of the user's donations (append to existing list).
  /// Used by the My Funded tab's infinite scroll.
  Future<void> loadMoreUserDonations({int pageSize = 20}) async {
    final currentState = state;
    if (currentState is! UserDonationsLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    final gen = _listGeneration;

    try {
      if (isClosed) return;
      final nextPage = currentState.currentPage + 1;
      emit(currentState.copyWith(isLoadingMore: true));

      final donations = await getUserDonationsUseCase(
        page: nextPage,
        pageSize: pageSize,
      );

      if (isClosed || gen != _listGeneration) return;
      emit(UserDonationsLoaded(
        donations: [...currentState.donations, ...donations],
        totalCount: currentState.totalCount + donations.length,
        currentPage: nextPage,
        hasMore: donations.length >= pageSize,
      ));
    } catch (e) {
      if (isClosed || gen != _listGeneration) return;
      emit(currentState.copyWith(isLoadingMore: false));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't generate receipt. Please try again.")));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load receipts. Please try again.")));
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
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load statistics. Please try again.")));
    }
  }

  /// Reset to initial state
  void reset() {
    if (isClosed) return;
    emit(const CrowdfundInitial());
  }

  // ============================================================================
  // CAMPAIGN WALLET METHODS
  // ============================================================================

  /// Generation token for My Campaigns page-1 refreshes. Bumped on
  /// each `loadMyCrowdfunds` entry; captured by `loadMoreMyCrowdfunds`
  /// so a late page-N response from a previous filter / refresh round
  /// can't append to a freshly-replaced list.
  int _myCrowdfundsGeneration = 0;

  /// Load crowdfunds owned by the current user. Avoids the Loading
  /// flicker on refresh when a list is already on screen so the
  /// dedicated My Campaigns screen doesn't blink to a spinner.
  Future<void> loadMyCrowdfunds({
    int page = 1,
    int pageSize = 20,
    String? statusFilter,
  }) async {
    if (getMyCrowdfundsUseCase == null) return;
    try {
      if (isClosed) return;
      final gen = ++_myCrowdfundsGeneration;
      if (state is! MyCrowdfundsLoaded) {
        emit(const CrowdfundLoading(message: 'Loading your campaigns...'));
      }

      final crowdfunds = await getMyCrowdfundsUseCase!(
        page: page,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );

      if (isClosed || gen != _myCrowdfundsGeneration) return;
      emit(MyCrowdfundsLoaded(
        crowdfunds,
        currentPage: page,
        pageSize: pageSize,
        hasMore: crowdfunds.length >= pageSize,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load your campaigns. Please try again.")));
    }
  }

  /// Append the next page of the current user's campaigns when the
  /// dedicated My Campaigns screen scrolls near the bottom. Guards
  /// on state shape, hasMore, isLoadingMore, AND the generation token
  /// — if a refresh fires mid-paginate we drop the late result rather
  /// than appending page N to a different page-1 list.
  Future<void> loadMoreMyCrowdfunds({
    int pageSize = 20,
    String? statusFilter,
  }) async {
    if (getMyCrowdfundsUseCase == null) return;
    final currentState = state;
    if (currentState is! MyCrowdfundsLoaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }
    final gen = _myCrowdfundsGeneration;
    try {
      if (isClosed) return;
      emit(currentState.copyWith(isLoadingMore: true));

      final nextPage = currentState.currentPage + 1;
      final more = await getMyCrowdfundsUseCase!(
        page: nextPage,
        pageSize: pageSize,
        statusFilter: statusFilter,
      );

      if (isClosed || gen != _myCrowdfundsGeneration) return;
      // Re-read the latest state after the await — a sibling op may
      // have replaced it (e.g., a pull-to-refresh on the same screen
      // that bumped the generation back to the same value but emitted
      // a different page-1 set).
      final latestNow = state;
      if (latestNow is! MyCrowdfundsLoaded) return;
      emit(MyCrowdfundsLoaded(
        [...latestNow.crowdfunds, ...more],
        currentPage: nextPage,
        pageSize: pageSize,
        hasMore: more.length >= pageSize,
        isLoadingMore: false,
      ));
    } catch (e) {
      if (isClosed) return;
      // Soft failure: roll back the loading flag, keep the existing
      // list visible, let the user pull-to-refresh.
      final latest = state;
      if (latest is MyCrowdfundsLoaded) {
        emit(latest.copyWith(isLoadingMore: false));
      }
    }
  }

  /// Withdraw funds from a campaign wallet
  Future<void> withdrawFromCrowdfund({
    required String crowdfundId,
    required double amount,
    required String transactionPin,
    String? destinationAccountId,
    String? destinationAccountType,
  }) async {
    if (withdrawFromCrowdfundUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Processing withdrawal...'));

      final result = await withdrawFromCrowdfundUseCase!(
        crowdfundId: crowdfundId,
        amount: amount,
        transactionPin: transactionPin,
        destinationAccountId: destinationAccountId,
        destinationAccountType: destinationAccountType,
      );

      if (isClosed) return;
      emit(WithdrawalCompleted(result));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: 'Withdrawal failed. Please try again.')));
    }
  }

  /// Load campaign wallet balance
  Future<void> loadCampaignWalletBalance(String crowdfundId) async {
    if (getCampaignWalletBalanceUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading wallet balance...'));

      final balance = await getCampaignWalletBalanceUseCase!(crowdfundId);

      if (isClosed) return;
      emit(CampaignWalletBalanceLoaded(balance));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load wallet balance. Please try again.")));
    }
  }

  // ============================================================================
  // NOTIFICATION CHANNEL METHODS
  // ============================================================================

  /// Load notification channels for a crowdfund
  Future<void> loadNotificationChannels(String crowdfundId) async {
    if (getNotificationChannelsUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Loading notification channels...'));

      final channels = await getNotificationChannelsUseCase!(crowdfundId);

      if (isClosed) return;
      emit(NotificationChannelsLoaded(channels));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't load notification channels. Please try again.")));
    }
  }

  /// Connect a new notification channel
  Future<void> connectNotificationChannel({
    required String crowdfundId,
    required NotificationChannelType channelType,
    required String channelName,
    String? telegramChatId,
    String? discordWebhookUrl,
    String? discordServerName,
    String? discordChannelName,
    String? slackWebhookUrl,
    String? slackWorkspaceName,
    String? slackChannelName,
    String? whatsappRecipientId,
    List<NotificationEventType>? enabledEvents,
  }) async {
    if (connectNotificationChannelUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Connecting channel...'));

      final channel = await connectNotificationChannelUseCase!(
        crowdfundId: crowdfundId,
        channelType: channelType,
        channelName: channelName,
        telegramChatId: telegramChatId,
        discordWebhookUrl: discordWebhookUrl,
        discordServerName: discordServerName,
        discordChannelName: discordChannelName,
        slackWebhookUrl: slackWebhookUrl,
        slackWorkspaceName: slackWorkspaceName,
        slackChannelName: slackChannelName,
        whatsappRecipientId: whatsappRecipientId,
        enabledEvents: enabledEvents,
      );

      if (isClosed) return;
      emit(NotificationChannelConnected(channel));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't connect channel. Please try again.")));
    }
  }

  /// Disconnect a notification channel
  Future<void> disconnectNotificationChannel(String channelId) async {
    if (disconnectNotificationChannelUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Disconnecting channel...'));

      await disconnectNotificationChannelUseCase!(channelId);

      if (isClosed) return;
      emit(NotificationChannelDisconnected(channelId));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't disconnect channel. Please try again.")));
    }
  }

  /// Update a notification channel
  Future<void> updateNotificationChannel({
    required String channelId,
    String? channelName,
    List<NotificationEventType>? enabledEvents,
    NotificationChannelStatus? status,
  }) async {
    if (updateNotificationChannelUseCase == null) return;
    try {
      if (isClosed) return;
      emit(const CrowdfundLoading(message: 'Updating channel...'));

      final channel = await updateNotificationChannelUseCase!(
        channelId: channelId,
        channelName: channelName,
        enabledEvents: enabledEvents,
        status: status,
      );

      if (isClosed) return;
      emit(NotificationChannelUpdated(channel));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't update channel. Please try again.")));
    }
  }

  /// Test a notification channel
  Future<void> testNotificationChannel(String channelId) async {
    if (testNotificationChannelUseCase == null) return;
    try {
      final success = await testNotificationChannelUseCase!(channelId);

      if (isClosed) return;
      emit(NotificationChannelTested(success: success, channelId: channelId));
    } catch (e) {
      if (isClosed) return;
      emit(CrowdfundError(message: getUserFriendlyErrorMessage(e, fallback: "Couldn't test channel. Please try again.")));
    }
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't generate report. Please try again."),
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't share to WhatsApp. Please try again."),
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't share to Facebook. Please try again."),
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't share to Telegram. Please try again."),
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't share to Twitter. Please try again."),
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
        message: getUserFriendlyErrorMessage(e, fallback: "Couldn't share report. Please try again."),
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
