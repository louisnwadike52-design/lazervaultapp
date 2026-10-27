import 'package:lazervault/core/cache/session_page_store.dart';
import '../../domain/entities/split_bill_entity.dart';

/// The two Split Bills tabs, remembered across opens.
///
/// The home screen keeps a per-tab list in its State (see the field docs in
/// `split_bill_home_screen.dart`) so the shared cubit's loading state never
/// blanks a tab. That cache died with the State, so every open of the
/// screen started on a shimmer. The lists live here as well, per user, so a
/// re-open seeds the State and paints at once; the screen's load-once-per-tab
/// guard still fires its fetch on open, which refreshes the painted list in
/// the background. Page one only — the screen never paginates these lists.
/// In memory only (no JSON codec on the entity).
final SessionPageStore<SplitBillEntity> incomingSplitBillsStore =
    SessionPageStore<SplitBillEntity>('split_bills_incoming');

final SessionPageStore<SplitBillEntity> createdSplitBillsStore =
    SessionPageStore<SplitBillEntity>('split_bills_created');
