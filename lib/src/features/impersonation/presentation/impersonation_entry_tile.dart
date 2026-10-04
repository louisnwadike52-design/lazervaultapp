import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:lazervault/core/types/app_routes.dart';

import '../data/impersonation_service.dart';
import 'impersonation_session.dart';

/// Starts a read-only session and rebuilds the app as the target.
///
/// A free function because two places need it: the settings tile, and the
/// search screen's result. Both must do the SAME thing afterwards — clear the
/// whole stack — because every screen already built was rendered from the
/// admin's own data and would otherwise keep showing it over the target's
/// session.
Future<void> enterImpersonationFrom(
  BuildContext context,
  ImpersonationStartResult started,
) async {
  GetIt.I<ImpersonationSession>().begin(
    sessionId: started.sessionId,
    targetLabel: started.targetLabel,
    expiresAt: started.expiresAt,
  );
  // offAllNamed, not toNamed: nothing from the admin's session may remain
  // reachable by back-navigation while impersonating.
  await Get.offAllNamed(AppRoutes.dashboard);
}

/// Ends the session and returns the admin to their own account.
///
/// Always restores the admin even if the server could not be told — being
/// stranded inside someone else's account because of a network blip is worse,
/// and the token expires on its own regardless. A failure to revoke is
/// surfaced rather than swallowed, because it changes what the admin should do
/// next if they were ending the session out of concern.
Future<void> exitImpersonation(BuildContext context) async {
  final session = GetIt.I<ImpersonationSession>();
  final result = await GetIt.I<ImpersonationService>().exit();
  session.end();

  await Get.offAllNamed(AppRoutes.dashboard);

  final messenger = Get.context != null
      ? ScaffoldMessenger.maybeOf(Get.context!)
      : null;
  if (result.warning != null) {
    messenger?.showSnackBar(SnackBar(
      content: Text(result.warning!),
      backgroundColor: Colors.orange[800],
      duration: const Duration(seconds: 6),
    ));
  } else {
    messenger?.showSnackBar(const SnackBar(
      content: Text('Back in your own account.'),
      duration: Duration(seconds: 2),
    ));
  }
}

/// The settings entry point. Renders NOTHING for a non-admin.
///
/// The role is read from the access token's own claims, which is only a
/// decision about what to draw — both endpoints enforce it server-side and
/// auth-service enforces it again at the mint. A non-admin who reaches the
/// screen another way gets an empty list and a 403, so hiding the tile is
/// courtesy, not security.
class ImpersonationEntryTile extends StatelessWidget {
  const ImpersonationEntryTile({super.key, this.brandColor});

  final Color? brandColor;

  @override
  Widget build(BuildContext context) {
    if (!GetIt.I.isRegistered<ImpersonationService>()) {
      return const SizedBox.shrink();
    }
    return FutureBuilder<bool>(
      future: GetIt.I<ImpersonationService>().currentUserCanImpersonate(),
      builder: (context, snap) {
        // While unknown, draw nothing rather than a placeholder: a tile that
        // appears a moment later in a settings list is less jarring than one
        // that appears and then vanishes for everyone who is not an admin.
        if (snap.data != true) return const SizedBox.shrink();
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Icon(Icons.visibility_outlined,
              color: brandColor ?? const Color(0xFFB45309), size: 22.sp),
          title: Text('View as user',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600)),
          subtitle: Text(
              'Open a customer’s account read-only. Recorded against you.',
              style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 11.sp)),
          trailing: Icon(Icons.chevron_right,
              size: 18.sp, color: Colors.white.withValues(alpha: 0.4)),
          onTap: () async {
            final started = await Get.toNamed(AppRoutes.impersonationSearch);
            if (started is ImpersonationStartResult && context.mounted) {
              await enterImpersonationFrom(context, started);
            }
          },
        );
      },
    );
  }
}
