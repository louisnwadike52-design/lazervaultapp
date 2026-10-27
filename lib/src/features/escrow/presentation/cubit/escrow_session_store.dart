import 'package:lazervault/core/cache/session_page_store.dart';
import '../../domain/entities/escrow_offer_entity.dart';
import '../../domain/repositories/escrow_repository.dart';

/// What the Escrow Pay home already knows, kept across opens.
///
/// `EscrowCubit` is a factory registration, so every open of the home screen
/// showed the list shimmer over deals the user had just been looking at, and
/// the offers strip re-fetched from nothing. Page one of each (role, status)
/// list and the active offers live here so the screen paints at once and the
/// fetches it always made run behind. In memory only: the entities have no
/// JSON codec, and a cold start can afford one shimmer.

/// Page one of the deals list, one snapshot per `role|status` scope. The
/// whole page object is kept — the pager needs `page`/`total` as well as
/// the rows.
final SessionPageStore<EscrowDealsPage> escrowDealsPageStore =
    SessionPageStore<EscrowDealsPage>('escrow_deals_page1');

/// Scope key for [escrowDealsPageStore]; the same (role, status) pair the
/// cubit keys its next-page prefetch on.
String escrowDealsScope(String role, String status) => '$role|$status';

/// The OPEN / AWAITING_FUNDING offers surfaced on home (already filtered).
final SessionPageStore<EscrowOfferEntity> escrowActiveOffersStore =
    SessionPageStore<EscrowOfferEntity>('escrow_active_offers');
