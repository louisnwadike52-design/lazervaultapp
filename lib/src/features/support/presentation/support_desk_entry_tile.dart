import 'package:flutter/material.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';

import '../data/support_desk_api.dart';
import '../data/support_desk_models.dart';

/// The support desk's entry point, which renders NOTHING for almost everyone.
///
/// ## Why a self-gating widget rather than a flag on the settings screen
///
/// The answer comes from the server (`/support/desk-access`, resolved from the
/// role claim), so it is asynchronous, and it is needed in more than one place
/// — Settings today, plausibly the account sheet later. Putting the await in
/// each host screen means each host screen gets its own chance to leak the
/// tile; keeping it here means a host just drops the widget in and an ordinary
/// customer renders a zero-height box.
///
/// ## It is not a security control
///
/// Hiding a tile hides a tile. The desk's authority is support-service
/// re-checking the admin claim on every request it serves, so a customer who
/// navigated to the route by hand gets an empty, refusing screen. This exists
/// so the other 99% of people are not shown a door they cannot open.
class SupportDeskEntryTile extends StatefulWidget {
  /// Renders the tile for a confirmed agent. Given the resolved access, so the
  /// host decides the look and this widget decides only whether to show it.
  final Widget Function(BuildContext context, DeskAccess access) builder;

  const SupportDeskEntryTile({super.key, required this.builder});

  @override
  State<SupportDeskEntryTile> createState() => _SupportDeskEntryTileState();
}

class _SupportDeskEntryTileState extends State<SupportDeskEntryTile> {
  DeskAccess? _access;

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  Future<void> _resolve() async {
    // access() never throws and answers "no" on any failure, so a support
    // outage renders no tile rather than an error on a settings screen.
    final a =
        await SupportDeskApi(serviceLocator<SecureStorageService>()).access();
    if (!mounted) return;
    setState(() => _access = a);
  }

  @override
  Widget build(BuildContext context) {
    final a = _access;
    // While unknown, and for everyone without access: nothing at all. Not a
    // placeholder and not a spinner — a settings list that flashes a loading
    // row for an admin-only item tells every customer the item exists.
    if (a == null || !a.canUse) return const SizedBox.shrink();
    return widget.builder(context, a);
  }
}
