import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lazervault/src/features/plan_my_day/presentation/google_connect_error.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/plan_my_day/services/calendar_sync_service.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

final getIt = GetIt.instance;

class CalendarSettingsScreen extends StatefulWidget {
  const CalendarSettingsScreen({super.key});

  @override
  State<CalendarSettingsScreen> createState() => _CalendarSettingsScreenState();
}

class _CalendarSettingsScreenState extends State<CalendarSettingsScreen> {
  final CalendarSyncService _calendarSyncService = getIt<CalendarSyncService>();

  bool _googleConnected = false;
  String? _googleLastSync;
  bool _syncing = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSyncStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F1F1F),
        elevation: 0,
        title: const Text(
          'Calendar Sync',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loading
          ? const Center(
              child: LazerVaultLoader.small(),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info Card
                  _buildInfoCard(),
                  SizedBox(height: 24.h),

                  // Google Calendar Section
                  _buildCalendarSection(
                    title: 'Google Calendar',
                    icon: Icons.calendar_today,
                    iconColor: const Color(0xFF4285F4),
                    isConnected: _googleConnected,
                    lastSync: _googleLastSync,
                    onConnect: () => _connectGoogleCalendar(),
                    onDisconnect: () => _disconnectGoogleCalendar(),
                    onSync: () => _syncGoogleCalendar(),
                    isSyncing: _syncing,
                  ),

                  // Outlook Calendar and the "Sync Settings" switch card used to
                  // sit here. Both were removed rather than hidden because
                  // neither was ever wired to anything:
                  //
                  //   * Outlook's connect/sync handlers only showed a "coming
                  //     soon" snackbar, and the server's GetCalendarSyncStatus
                  //     hardcodes OutlookConnected: false — there is no Outlook
                  //     OAuth client, token store, or sync path to turn on.
                  //   * The three switches (Auto-sync, Sync past events, Create
                  //     events in calendar) passed `(value) {}`. They animated,
                  //     persisted nothing, and no sync code ever read them, so
                  //     reopening the screen silently reverted every choice.
                  //
                  // A control that cannot do what it says is worse than an
                  // absent one: it spends the user's trust on a no-op. Restore
                  // either only alongside the backend that honours it.
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: const Color(0xFF3B82F6),
            size: 20,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'Connect Google Calendar to sync events between Lazervault and your calendar.',
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required bool isConnected,
    required String? lastSync,
    required VoidCallback onConnect,
    required VoidCallback onDisconnect,
    required VoidCallback onSync,
    required bool isSyncing,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (isConnected && lastSync != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Last synced: ${_formatSyncTime(lastSync)}',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (isConnected)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.h,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Connected',
                        style: TextStyle(
                          color: const Color(0xFF10B981),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              if (!isConnected) ...[
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConnect,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      minimumSize: Size(double.infinity, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Connect',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: OutlinedButton(
                    onPressed: isSyncing ? null : onSync,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF3B82F6),
                      side: BorderSide(color: const Color(0xFF3B82F6)),
                      minimumSize: Size(double.infinity, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: isSyncing
                        ? LazerVaultLoader.tiny()
                        : Text(
                            'Sync Now',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onDisconnect,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFFEF4444),
                      side: BorderSide(color: const Color(0xFFEF4444)),
                      minimumSize: Size(double.infinity, 44.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Disconnect',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _loadSyncStatus() async {
    setState(() {
      _loading = true;
    });

    try {
      final status = await _calendarSyncService.getSyncStatus();
      if (mounted) {
        setState(() {
          _googleConnected = status.googleConnected;
          _googleLastSync = status.googleLastSync;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to load sync status: $e'),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      }
    }
  }

  // Google Calendar scopes.
  //
  // Narrow on purpose: `calendar.events` covers reading and writing the events we sync,
  // and `calendar.readonly` is what lets us enumerate which calendars exist. Neither
  // grants the full `auth/calendar` scope, which would also allow deleting calendars —
  // permission we never exercise and should not ask a user to hand over.
  static const List<String> _calendarScopes = [
    'https://www.googleapis.com/auth/calendar.events',
    'https://www.googleapis.com/auth/calendar.readonly',
  ];

  bool _googleInitialized = false;

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) return;
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.env['GMAIL_WEB_CLIENT_ID'] ?? '',
    );
    _googleInitialized = true;
  }

  /// Connect Google Calendar through the SAME Google Sign-In the app already uses.
  ///
  /// WHAT THIS REPLACED
  /// ------------------
  /// A dialog that told the user to open Google Calendar, find a calendar ID and paste
  /// it into a text field — a field with no controller, so whatever they typed was
  /// discarded. It then ran `await Future.delayed(1s)` under a `// Simulate connection`
  /// comment and called the service with no auth code at all.
  ///
  /// So the screen asked a user to do clerical work, threw the result away, and showed a
  /// result that did not come from anything they did. The service has always accepted an
  /// `authCode`; nothing was ever passing one.
  ///
  /// This is the flow EmailCubit.connect already uses for Gmail, with calendar scopes:
  /// authenticate, obtain a one-time server auth code, hand that to the backend, which
  /// exchanges it for a refresh token. No client IDs or calendar IDs are ever typed by a
  /// user.
  Future<void> _connectGoogleCalendar() async {
    setState(() => _syncing = true);
    try {
      await _ensureGoogleInitialized();

      final GoogleSignInAccount user;
      try {
        user = await GoogleSignIn.instance.authenticate(scopeHint: _calendarScopes);
      } on GoogleSignInException catch (e) {
        if (!mounted) return;
        setState(() => _syncing = false);
        // Cancelling is a decision, not a failure — say so neutrally rather than
        // showing a red error for something the user chose.
        // A cancellation is a decision, and an unverified-app refusal is a Cloud
        // Console state — neither is a red error the user can retry into working.
        final cancelled = GoogleConnectError.isCancelled(e);
        final notApproved = GoogleConnectError.isNotApprovedForThisAccount(e);
        _toast(
          GoogleConnectError.message(e, feature: 'Google Calendar'),
          cancelled || notApproved
              ? const Color(0xFF3B82F6)
              : const Color(0xFFEF4444),
        );
        return;
      }

      // The one-time server auth code is what the backend exchanges for a refresh
      // token. Without it there is nothing to connect WITH, so stop here rather than
      // calling the service and reporting a success that never happened — which is
      // exactly what the old flow did.
      final serverAuth =
          await user.authorizationClient.authorizeServer(_calendarScopes);
      final serverAuthCode = serverAuth?.serverAuthCode;
      if (serverAuthCode == null || serverAuthCode.isEmpty) {
        if (!mounted) return;
        setState(() => _syncing = false);
        _toast(
          "Couldn't get calendar permission. Please try connecting again.",
          const Color(0xFFEF4444),
        );
        return;
      }

      final result = await _calendarSyncService.connectGoogleCalendar(
        authCode: serverAuthCode,
      );
      if (!mounted) return;
      setState(() {
        _googleConnected = result.success;
        _syncing = false;
      });

      if (result.success) {
        _toast('Google Calendar connected', const Color(0xFF10B981));
      } else if (result.notConfigured) {
        // The server has no Google OAuth credentials yet (the planning-service
        // handler is still a stub). Not the user's problem and not a failure they
        // can act on, so it reads as a calm coming-soon rather than a red error.
        _toast(
          result.message?.isNotEmpty == true
              ? result.message!
              : 'Calendar sync is coming soon',
          const Color(0xFF3B82F6),
        );
      } else {
        _toast('Failed to connect Google Calendar', const Color(0xFFEF4444));
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => _syncing = false);
      _toast('Failed to connect: $e', const Color(0xFFEF4444));
    }
  }

  void _toast(String text, Color background) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text), backgroundColor: background),
    );
  }

  Future<void> _disconnectGoogleCalendar() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Disconnect Google Calendar',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to disconnect your Google Calendar? Events synced from Google will not be deleted.',
          style: TextStyle(color: Colors.grey[300]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Disconnect', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _calendarSyncService.disconnectGoogleCalendar();
        if (mounted) {
          setState(() {
            _googleConnected = false;
            _googleLastSync = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Google Calendar disconnected')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to disconnect: $e'),
              backgroundColor: const Color(0xFFEF4444),
            ),
          );
        }
      }
    }
  }

  Future<void> _syncGoogleCalendar() async {
    setState(() {
      _syncing = true;
    });

    try {
      final result = await _calendarSyncService.syncGoogleCalendar(fullSync: true);

      if (mounted) {
        setState(() {
          _syncing = false;
          _googleLastSync = DateTime.now().toIso8601String();
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Sync complete! ${result.eventsAdded} events added, ${result.eventsUpdated} updated',
            ),
            backgroundColor: const Color(0xFF10B981),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _syncing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sync failed: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  String _formatSyncTime(String? isoTime) {
    if (isoTime == null) return 'Never';
    try {
      final time = DateTime.parse(isoTime);
      final now = DateTime.now();
      final diff = now.difference(time);

      if (diff.inMinutes < 1) return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24) return '${diff.inHours}h ago';
      return '${diff.inDays}d ago';
    } catch (e) {
      return 'Unknown';
    }
  }
}
