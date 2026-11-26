import 'package:flutter/material.dart';

import 'package:lazervault/src/features/widgets/full_screen_image_viewer.dart';

/// A flyer, full screen.
///
/// NOW A THIN WRAPPER around [FullScreenImageViewer]. This started as its own
/// implementation, and within the same day the support thread needed exactly
/// the same behaviour — Hero flight, drag-to-dismiss, pinch-to-zoom, three
/// ways out. Two copies of a gesture people learn once is how they come to
/// behave differently on different screens, so the implementation moved to
/// features/widgets and this kept the name the ticketing screens call.
///
/// WHY THIS NAME SURVIVES. The event card and the detail screen both open it,
/// and both pass the event-keyed Hero tag — keeping the entry point means the
/// ticketing code says what it is opening rather than naming a generic widget.
class EventFlyerViewer {
  const EventFlyerViewer._();

  /// Opens [url] full screen. [heroTag] defaults to the URL; the ticketing
  /// screens pass `event-flyer-<id>` because two events can legitimately share
  /// a flyer and two Heroes with one tag in a tree throws on flight.
  static Future<void> open(BuildContext context, String url,
          {String? heroTag}) =>
      FullScreenImageViewer.open(context, url, heroTag: heroTag);
}
