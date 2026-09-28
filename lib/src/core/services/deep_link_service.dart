import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:app_links/app_links.dart';

/// Deep Link Event Types
enum DeepLinkType {
  depositCallback,
  paymentCallback,
  quickAction,
  familyInvite,
  escrowOffer,
  crowdfundCampaign,
  lazerSprayJoin,
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

  const DeepLinkData({
    required this.type,
    required this.rawUri,
    required this.queryParams,
    this.path,
    this.familyInviteToken,
    this.escrowOfferToken,
    this.crowdfundCampaignId,
    this.lazerSprayCode,
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
  /// Exposed for tests only. Link routing is the kind of logic that is normally
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

    DeepLinkType type;
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
