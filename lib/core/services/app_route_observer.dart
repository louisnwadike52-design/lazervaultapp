import 'package:flutter/widgets.dart';

/// App-wide [RouteObserver] so a screen can know when it becomes visible again.
///
/// WHY THIS EXISTS
///
/// `initState` runs once, when a screen's State is created. Pushing a sub-route
/// on top does NOT dispose the screen underneath, so popping back runs no
/// lifecycle callback at all — the screen simply reappears showing whatever it
/// last built. For a page whose whole purpose is a balance, that means a user
/// can buy crypto, come back, and read a figure from before their own purchase.
///
/// `didChangeAppLifecycleState` does not cover it either: the app never left
/// the foreground, so nothing fires.
///
/// Register it on the app's `navigatorObservers`, then mix [RouteAware] into
/// any State that needs to refresh on re-entry and implement `didPopNext`.
final RouteObserver<ModalRoute<void>> appRouteObserver =
    RouteObserver<ModalRoute<void>>();
