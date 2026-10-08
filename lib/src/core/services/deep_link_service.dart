import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:app_links/app_links.dart';
import 'package:lazervault/core/utilities/invite_link.dart';
import 'package:lazervault/core/utilities/pending_referral.dart';

/// Deep Link Event Types
enum DeepLinkType {
  depositCallback,
  paymentCallback,
  quickAction,
  familyInvite,
  escrowOffer,
  crowdfundCampaign,
  lazerSprayJoin,
  groupAccount,
  /// A link that identifies a COMPLETED payment, not something to open and pay
  /// — currently the donation receipt's `crowdfund/donation/<txn>`.
  paymentReceipt,

  /// An INVITE: `https://lazervault.app/download?ref=CODE`.
  ///
  /// Reaches an app that is already installed, which means the person tapping
  /// it is usually NOT the new user — so this never navigates anywhere. It
  /// only records the code, so that if this device does reach a signup the
  /// field is already filled. See PendingReferral.
  referralInvite,
  unknown,
}

/// Parsed Deep Link
class DeepLinkData {
  final DeepLinkType type;
  final String rawUri;
  final Map<String, String> queryParams;
  final String? path;

  /// For [DeepLinkType.familyInvite], the invitation token extracted
  /// from the URL path (`lazervault://family/invite/<token>`). Null for
  /// other types.
  final String? familyInviteToken;

  /// For [DeepLinkType.escrowOffer], the share token from
  /// `https://lazervault.app/escrow/offer/<token>` (or the
  /// `lazervault://escrow/offer/<token>` custom-scheme form). Null otherwise.
  final String? escrowOfferToken;

  /// For [DeepLinkType.crowdfundCampaign], the campaign id from
  /// `https://lazervault.app/crowdfund/<id>` (or the custom-scheme
  /// `lazervault://crowdfund/<id>` form). Null otherwise.
  final String? crowdfundCampaignId;

  /// For [DeepLinkType.lazerSprayJoin], the 6-character session code from
  /// `https://lazervault.app/lazerspray/join?code=<CODE>` (or the
  /// `lazervault://lazerspray/join?code=<CODE>` form). Null otherwise.
  ///
  /// Carried in the QUERY string, not the path — that is how the room screen
  /// builds the share link, and changing the shape would break links already
  /// sent. Uppercased here because codes are displayed and compared in upper
  /// case but a URL travels through anything.
  final String? lazerSprayCode;

  /// For [DeepLinkType.groupAccount], the group id from
  /// `https://lazervault.app/groups/<id>` (or the `lazervault://groups/<id>`
  /// custom-scheme form). Null otherwise.
  final String? groupAccountId;

  /// For [DeepLinkType.paymentReceipt], the transaction reference the link
  /// identifies. Null otherwise.
  final String? receiptReference;

  const DeepLinkData({
    required this.type,
    required this.rawUri,
    required this.queryParams,
    this.path,
    this.familyInviteToken,
    this.escrowOfferToken,
    this.crowdfundCampaignId,
    this.lazerSprayCode,
    this.groupAccountId,
    this.receiptReference,
  });

  /// Get a query parameter value
  String? param(String key) => queryParams[key];

  /// Check if a parameter exists
  bool hasParam(String key) => queryParams.containsKey(key);

  /// Check if this is a success callback
  bool get isSuccess =>
      param('status') == 'successful' ||
      param('success') == 'true' ||
      !hasParam('error');

  /// Get error message if present
  String? get errorMessage => param('error') ?? param('message');

  @override
  String toString() =>
      'DeepLinkData(type: $type, path: $path, params: $queryParams)';
}

/// Deep Link Service - Handles incoming deep links for the app
///
/// Supports:
/// - lazervault://deposit/callback - DirectPay authorization callback
/// - lazervault://payment/callback - Generic payment callback
/// - lazervault://family/invite/{token} - Family-account invitation
///   (link minted by accounts-service in AddFamilyMember; opens the
///    invitations screen so the invitee can accept or decline)
/// - https://lazervault.app/... - Universal links
///
/// Usage:
/// ```dart
/// final deepLinkService = DeepLinkService();
/// await deepLinkService.initialize();
///
/// // Listen to deep links
/// deepLinkService.linkStream.listen((data) {
///   if (data.type == DeepLinkType.depositCallback) {
///     // Handle deposit callback
///   }
/// });
///
/// // Check for initial link (app opened via deep link)
/// final initialLink = await deepLinkService.getInitialLink();
/// ```
class DeepLinkService {
  static DeepLinkService? _instance;
  static DeepLinkService get instance => _instance ??= DeepLinkService._();

  DeepLinkService._();
  factory DeepLinkService() => instance;

  late final AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  final _linkController = StreamController<DeepLinkData>.broadcast();

  /// Stream of parsed deep links
  Stream<DeepLinkData> get linkStream => _linkController.stream;

  /// Whether the service has been initialized
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  /// Initialize the deep link service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _appLinks = AppLinks();

    // Listen for incoming links while app is running
    _linkSubscription = _appLinks.uriLinkStream.listen(
      _handleUri,
      onError: (error) {
        debugPrint('[DeepLink] Error: $error');
      },
    );

    _isInitialized = true;
    debugPrint('[DeepLink] Service initialized');
  }

  /// Get the initial link that opened the app (if any)
  Future<DeepLinkData?> getInitialLink() async {
    try {
      final uri = await _appLinks.getInitialLink();
      if (uri != null) {
        debugPrint('[DeepLink] Initial link: $uri');
        return _parseUri(uri);
      }
    } catch (e) {
      debugPrint('[DeepLink] Error getting initial link: $e');
    }
    return null;
  }

  void _handleUri(Uri uri) {
    debugPrint('[DeepLink] Received: $uri');
    final data = _parseUri(uri);
    _linkController.add(data);
  }

  /// Parse a URI exactly as an incoming link would be parsed.
  ///
  /// Public because links no longer arrive only from the OS: a LazerVault link
  /// can also be READ OFF A QR CODE, and the scanner must reach the same parser
  /// rather than grow a second understanding of our own URL shapes.
  DeepLinkData parse(Uri uri) => _parseUri(uri);

  /// Feed a link the app discovered ITSELF — a scanned QR, say — into the same
  /// stream an OS link arrives on.
  ///
  /// This is the whole point: routing already exists, in one place, and it knows
  /// what every link type should open. A scanner that navigated on its own would
  /// be a second router to keep in step, and the first one to fall behind.
  ///
  /// Returns what it parsed, so the caller can tell an unrecognised link from a
  /// handled one without listening to the stream.
  DeepLinkData handleExternalLink(Uri uri) {
    final data = _parseUri(uri);
    if (data.type != DeepLinkType.unknown) {
      _linkController.add(data);
    }
    return data;
  }

  /// Exposed for tests. Link routing is the kind of logic that is normally
  /// verified by hand on a device — which is why `/crowdfund/` reached
  /// production claimed by no platform at all — so it is worth asserting
  /// directly rather than through a stream that needs platform channels.
  @visibleForTesting
  static DeepLinkData parseUriForTest(Uri uri) => instance._parseUri(uri);

  DeepLinkData _parseUri(Uri uri) {
    // For custom-scheme URIs like `lazervault://family/invite/<token>`
    // app_links sets `uri.host = 'family'` and `uri.path = '/invite/<token>'`.
    // For universal-link URIs like `https://lazervault.app/family/invite/<token>`
    // it's `uri.host = 'lazervault.app'` and `uri.path = '/family/invite/<token>'`.
    // We normalize by inspecting the path-segment list, which works for both.
    final segments = uri.pathSegments;
    final path = uri.path.isEmpty ? uri.host : uri.path;
    final queryParams = uri.queryParameters;

    // Family invite: host=='family' + first-segment=='invite' + second-segment is the token.
    // (Or, on universal link, segments == [family, invite, <token>])
    final isFamilyInvite = (uri.host == 'family' &&
            segments.length >= 2 &&
            segments[0] == 'invite') ||
        (segments.length >= 3 &&
            segments[0] == 'family' &&
            segments[1] == 'invite');

    if (isFamilyInvite) {
      // Token is the last meaningful path segment. We don't validate UUID
      // shape here — the backend's AcceptFamilyInvitation does that with
      // uuid.Parse and returns InvalidArgument if malformed.
      final token = uri.host == 'family' ? segments[1] : segments[2];
      return DeepLinkData(
        type: DeepLinkType.familyInvite,
        rawUri: uri.toString(),
        queryParams: queryParams,
        path: path,
        familyInviteToken: token,
      );
    }

    // Escrow offer share link: custom scheme puts host=='escrow' with
    // segments [offer, <token>]; universal link yields [escrow, offer, <token>].
    final isEscrowOffer = (uri.host == 'escrow' &&
            segments.length >= 2 &&
            segments[0] == 'offer') ||
        (segments.length >= 3 &&
            segments[0] == 'escrow' &&
            segments[1] == 'offer');
    if (isEscrowOffer) {
      final token = uri.host == 'escrow' ? segments[1] : segments[2];
      return DeepLinkData(
        type: DeepLinkType.escrowOffer,
        rawUri: uri.toString(),
        queryParams: queryParams,
        path: path,
        escrowOfferToken: token,
      );
    }

    // Crowdfund campaign share link.
    //
    // CrowdfundShareService builds https://lazervault.app/crowdfund/{id}, which
    // was the ONLY link in the product that no platform claimed: it was absent
    // from the Android intent filters AND from the iOS association file, so a
    // funding link always opened a browser instead of the campaign. Someone
    // sharing their campaign was sending supporters to a web page rather than
    // into the app, which is where the donation actually happens.
    //
    // Both URI shapes, like the two above: the custom scheme
    // (lazervault://crowdfund/<id>) puts the id in the host's first segment,
    // while the universal link carries [crowdfund, <id>].
    // The donation RECEIPT link, which must be read before the campaign branch
    // below. donation_receipt_screen encodes
    // `lazervault://crowdfund/donation/<txn>`, and app_links turns that into
    // host='crowdfund' with segments ['donation', '<txn>'] — so the campaign
    // branch took segments[0] and opened a campaign whose id was literally
    // "donation". The link went to a dead screen, and it would do the same for
    // any future `crowdfund/<verb>/…` shape.
    final isDonationReceipt = (uri.host == 'crowdfund' &&
            segments.length >= 2 &&
            segments[0] == 'donation') ||
        (segments.length >= 3 &&
            segments[0] == 'crowdfund' &&
            segments[1] == 'donation');
    if (isDonationReceipt) {
      return DeepLinkData(
        type: DeepLinkType.paymentReceipt,
        rawUri: uri.toString(),
        queryParams: queryParams,
        path: path,
        receiptReference: segments.last,
      );
    }

    final isCrowdfund = (uri.host == 'crowdfund' && segments.isNotEmpty) ||
        (segments.length >= 2 && segments[0] == 'crowdfund');
    if (isCrowdfund) {
      final id = uri.host == 'crowdfund' ? segments[0] : segments[1];
      // An empty id would route to the campaign screen with nothing to load and
      // show a permanent spinner, so it falls through to `unknown` instead and
      // the caller lands on the dashboard.
      if (id.trim().isNotEmpty) {
        return DeepLinkData(
          type: DeepLinkType.crowdfundCampaign,
          rawUri: uri.toString(),
          queryParams: queryParams,
          path: path,
          crowdfundCampaignId: id,
        );
      }
    }

    // LazerSpray session join link.
    //
    // The room screen shares https://lazervault.app/lazerspray/join?code=XXXXXX
    // and nothing claimed it: no website route (the link 404'd), no AASA path,
    // and no branch here. A host sharing their room was sending guests to a
    // dead page — the one link whose entire purpose is to get someone INTO a
    // live session.
    //
    // Unlike the links above, the payload is a query parameter, so both URI
    // shapes converge once the path is matched: custom scheme gives
    // host=='lazerspray' + segments [join]; the universal link gives
    // segments [lazerspray, join].
    final isSprayJoin = (uri.host == 'lazerspray' &&
            segments.isNotEmpty &&
            segments[0] == 'join') ||
        (segments.length >= 2 &&
            segments[0] == 'lazerspray' &&
            segments[1] == 'join');
    if (isSprayJoin) {
      final code =
          (queryParams['code'] ?? '').trim().toUpperCase();
      // An empty or malformed code would open the join screen with nothing to
      // submit. Better to fall through to the manual-entry screen (below,
      // via `unknown` -> dashboard) than to auto-submit garbage and show the
      // user a server error they did not cause.
      if (code.isNotEmpty) {
        return DeepLinkData(
          type: DeepLinkType.lazerSprayJoin,
          rawUri: uri.toString(),
          queryParams: queryParams,
          path: path,
          lazerSprayCode: code,
        );
      }
    }

    // Group / joint-funds share link.
    //
    // group_details_screen shares https://lazervault.app/groups/<id> from the
    // report screen, and nothing claimed it: no website route, no AASA path,
    // no intent filter, and no branch here. Someone sharing their group's
    // report was sending contributors to a "page not found".
    //
    // Both URI shapes, as with the links above: the custom scheme gives
    // host=='groups' + segments [<id>]; the universal link gives
    // segments [groups, <id>].
    final isGroup = (uri.host == 'groups' && segments.isNotEmpty) ||
        (segments.length >= 2 && segments[0] == 'groups');
    if (isGroup) {
      final gid = uri.host == 'groups' ? segments[0] : segments[1];
      // A bare /groups with no id would open the details screen with nothing
      // to load and spin forever, so it falls through to the dashboard
      // instead. (The contribution share sheet used to emit exactly that.)
      if (gid.trim().isNotEmpty) {
        return DeepLinkData(
          type: DeepLinkType.groupAccount,
          rawUri: uri.toString(),
          queryParams: queryParams,
          path: path,
          groupAccountId: gid.trim(),
        );
      }
    }

    DeepLinkType type;
    // INVITE. Checked before the generic contains() chain below, because
    // "/download" would otherwise fall through to `unknown` and the code would
    // be dropped on the floor.
    //
    // Keyed on the CODE being present rather than on the path alone: a bare
    // /download link (someone sharing the page, not an invite) carries nothing
    // worth recording, and treating it as a referral would store an empty
    // attribution.
    final inviteCode = InviteLink.codeFrom(uri);
    if (inviteCode != null && path.contains('download')) {
      // Recorded, never navigated. Whoever tapped this already HAS the app, so
      // they are usually the referrer or an existing user — sending them to a
      // signup screen would be wrong. The code simply waits for a signup that
      // may never come on this device, which costs nothing.
      PendingReferral.instance.remember(inviteCode);
      return DeepLinkData(
        type: DeepLinkType.referralInvite,
        rawUri: uri.toString(),
        queryParams: queryParams,
        path: path,
      );
    }

    if (path.contains('quick-action')) {
      type = DeepLinkType.quickAction;
    } else if (path.contains('deposit') || path.contains('deposit/callback')) {
      type = DeepLinkType.depositCallback;
    } else if (path.contains('payment') || path.contains('payment/callback')) {
      type = DeepLinkType.paymentCallback;
    } else {
      type = DeepLinkType.unknown;
    }

    return DeepLinkData(
      type: type,
      rawUri: uri.toString(),
      queryParams: queryParams,
      path: path,
    );
  }

  /// Dispose of resources
  void dispose() {
    _linkSubscription?.cancel();
    _linkController.close();
    _isInitialized = false;
  }
}

/// Mixin for widgets that need to handle deep links
mixin DeepLinkHandler<T extends StatefulWidget> on State<T> {
  StreamSubscription<DeepLinkData>? _deepLinkSubscription;

  @override
  void initState() {
    super.initState();
    _initDeepLinks();
  }

  void _initDeepLinks() {
    final service = DeepLinkService.instance;
    if (!service.isInitialized) return;

    _deepLinkSubscription = service.linkStream.listen(_onDeepLink);

    // Check for initial link
    service.getInitialLink().then((data) {
      if (data != null && mounted) {
        _onDeepLink(data);
      }
    });
  }

  /// Override this to handle deep links
  void _onDeepLink(DeepLinkData data) {
    onDeepLink(data);
  }

  /// Handle incoming deep link - override in your widget
  void onDeepLink(DeepLinkData data);

  @override
  void dispose() {
    _deepLinkSubscription?.cancel();
    super.dispose();
  }
}
