import 'package:lazervault/core/cache/session_page_store.dart';

import '../../domain/entities/user_tag_entity.dart';

/// PAGE ONE OF EACH TAG LIST, KEPT ACROSS OPENS.
///
/// `TagPayCubit` is a factory registration, so every open of the tag pay home
/// painted a shimmer over rows the user had been looking at seconds earlier,
/// and then asked the network for exactly the same page. On the uplink this
/// backend sits behind that is a visible wait on a screen people open to
/// check one number.
///
/// Mirrors Escrow Pay, which already did this. In memory only: these entities
/// have no JSON codec, and a cold start can afford one shimmer — what cannot
/// be afforded is a shimmer on every tab switch within a session.
///
/// SCOPED BY STATUS FILTER. The two tabs keep separate stores, and within a
/// tab the filter is part of the scope — a page one stored under "pending"
/// must never be painted when the user reopens on "all".
final SessionPageStore<UserTagEntity> incomingTagsPageStore =
    SessionPageStore<UserTagEntity>('tagpay_incoming_page1');

final SessionPageStore<UserTagEntity> outgoingTagsPageStore =
    SessionPageStore<UserTagEntity>('tagpay_outgoing_page1');

/// Scope key for the stores above — the same filter the prefetch keys on, so
/// the cache and the prefetch can never disagree about which list they hold.
String tagsScope(String? status) => status ?? '';
