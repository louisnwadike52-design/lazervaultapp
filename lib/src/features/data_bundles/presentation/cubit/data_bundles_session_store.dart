import 'package:lazervault/core/cache/session_page_store.dart';
import '../../domain/entities/data_plan_entity.dart';
import '../../domain/entities/data_purchase_entity.dart';

/// What the data-bundles screens already know, kept across opens.
///
/// `DataBundlesCubit` is a factory registration: the landing "Recent
/// Purchases" strip and the plan grid each showed a loader on every open over
/// rows the user had just seen. Both lists live here now so a cubit can paint
/// them at once and refresh behind. In memory only (no JSON codecs on the
/// entities); the first open after a cold start still shows a loader.

/// Page one of the user's data-purchase history (default page, offset 0).
final SessionPageStore<DataPurchaseEntity> dataPurchasesStore =
    SessionPageStore<DataPurchaseEntity>('data_purchases');

/// The plan catalogue, scoped by network. A catalogue changes rarely, so it
/// is still shown well after [SessionPageStore.staleAfter]; that flag only
/// tells the cubit to refresh — which it does on every open anyway.
final SessionPageStore<DataPlanEntity> dataPlansStore =
    SessionPageStore<DataPlanEntity>(
  'data_plans',
  staleAfter: const Duration(minutes: 30),
);
