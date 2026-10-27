import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';

/// Page one of the saved-recipients list, remembered across screen opens.
///
/// `RecipientCubit` is a factory registration, so every entry into Send Funds
/// starts from `RecipientInitial` and painted a loader over a list the user
/// saw moments ago. This store lets the cubit paint that page at once and
/// refresh behind it. It is NOT the SWR cache the cubit used to bypass (see
/// the note in `getRecipients`): freshness still comes from the network on
/// every load — this only decides what is on screen while that load runs.
///
/// Scoped by the same key the list is keyed on (country, currency,
/// favourites) so a page from one account/locale view is never painted for
/// another; stamped by user so two people on one phone never share it.
final SessionPageStore<RecipientModel> recipientsPageStore =
    SessionPageStore<RecipientModel>(
  'recipients',
  toJson: (r) => r.toJson(),
  fromJson: RecipientModel.fromJson,
);

/// Scope key for [recipientsPageStore]: mirrors the parameters of
/// `RecipientCubit.getRecipients` that change which rows come back.
String recipientsPageScope({
  String? countryCode,
  String? currency,
  bool? favoritesOnly,
}) =>
    '${countryCode ?? ''}|${currency ?? ''}|${favoritesOnly == true ? 'fav' : 'all'}';
