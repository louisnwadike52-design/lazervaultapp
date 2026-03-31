import 'package:get/get.dart';

/// Keeps `investCollection` (ETF, T-Bill hub, etc.) on GetX routes so UI matches the active asset class.
abstract final class InvestRouteArgs {
  /// Route `arguments` map with optional `investCollection` (omit when generic Stocks).
  static Map<String, dynamic> hub(String? investCollectionId) {
    if (investCollectionId == null || investCollectionId.isEmpty) {
      return <String, dynamic>{};
    }
    return <String, dynamic>{'investCollection': investCollectionId};
  }

  /// Read hub id from [Get.arguments] or any map (e.g. payment / trade maps).
  static String? parseHub(dynamic raw) {
    if (raw is! Map) return null;
    final id = raw['investCollection'];
    if (id is String && id.isNotEmpty) return id;
    return null;
  }

  /// Merge hub into an existing arguments map (does not strip other keys).
  static Map<String, dynamic> mergeHub(
    Map<String, dynamic> base,
    String? investCollectionId,
  ) {
    final m = Map<String, dynamic>.from(base);
    if (investCollectionId != null && investCollectionId.isNotEmpty) {
      m['investCollection'] = investCollectionId;
    }
    return m;
  }
}
