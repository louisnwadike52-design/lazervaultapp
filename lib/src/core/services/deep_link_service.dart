import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:app_links/app_links.dart';

/// Deep Link Event Types
enum DeepLinkType {
  depositCallback,
  paymentCallback,
  quickAction,
  familyInvite,
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

  const DeepLinkData({
    required this.type,
    required this.rawUri,
    required this.queryParams,
    this.path,
    this.familyInviteToken,
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
  String toString() => 'DeepLinkData(type: $type, path: $path, params: $queryParams)';
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
    final isFamilyInvite =
        (uri.host == 'family' && segments.length >= 2 && segments[0] == 'invite') ||
        (segments.length >= 3 && segments[0] == 'family' && segments[1] == 'invite');

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
