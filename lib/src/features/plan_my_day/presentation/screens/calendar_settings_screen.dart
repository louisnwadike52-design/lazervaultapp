import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/src/features/plan_my_day/services/calendar_sync_service.dart';

final getIt = GetIt.instance;

class CalendarSettingsScreen extends StatefulWidget {
  const CalendarSettingsScreen({super.key});

  @override
  State<CalendarSettingsScreen> createState() => _CalendarSettingsScreenState();
}

class _CalendarSettingsScreenState extends State<CalendarSettingsScreen> {
  final CalendarSyncService _calendarSyncService = getIt<CalendarSyncService>();

  bool _googleConnected = false;
  bool _outlookConnected = false;
  String? _googleLastSync;
  String? _outlookLastSync;
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
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
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
                  SizedBox(height: 20.h),

                  // Outlook Calendar Section
                  _buildCalendarSection(
                    title: 'Outlook Calendar',
                    icon: Icons.event,
                    iconColor: const Color(0xFF0078D4),
                    isConnected: _outlookConnected,
                    lastSync: _outlookLastSync,
                    onConnect: () => _connectOutlookCalendar(),
                    onDisconnect: () => _disconnectOutlookCalendar(),
                    onSync: () => _syncOutlookCalendar(),
                    isSyncing: _syncing,
                  ),

                  SizedBox(height: 24.h),

                  // Sync Settings
                  _buildSyncSettings(),
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
              'Connect your calendar to sync events between LazerVault and your external calendars.',
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
                        ? SizedBox(
                            width: 16.w,
                            height: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                            ),
                          )
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

  Widget _buildSyncSettings() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sync Settings',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          _buildSettingItem(
            'Auto-sync',
            'Automatically sync changes every hour',
            true,
            (value) {},
          ),
          SizedBox(height: 12.h),
          _buildSettingItem(
            'Sync past events',
            'Include events from the past 30 days',
            false,
            (value) {},
          ),
          SizedBox(height: 12.h),
          _buildSettingItem(
            'Create events in calendar',
            'New LazerVault events are added to connected calendars',
            true,
            (value) {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(
    String title,
    String description,
    bool value,
    Function(bool) onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: const Color(0xFF3B82F6),
        ),
      ],
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
          _outlookConnected = status.outlookConnected;
          _outlookLastSync = status.outlookLastSync;
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

  Future<void> _connectGoogleCalendar() async {
    // Show Google Sign-In flow
    // In real implementation, use google_sign_in package
    // For now, we'll show a dialog explaining how to connect
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: const Text(
          'Connect Google Calendar',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'To connect your Google Calendar:',
              style: TextStyle(color: Colors.grey[300]),
            ),
            const SizedBox(height: 12),
            Text(
              '1. Open Google Calendar on your device\n'
              '2. Go to Settings → Share with specific people\n'
              '3. Add your calendar email or use calendar ID\n'
              '4. Copy the calendar URL/ID\n'
              '5. Enter it below',
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Calendar ID (optional)',
                labelStyle: TextStyle(color: Colors.grey[400]),
                hintText: 'e.g., abc123@group.calendar.google.com',
                hintStyle: TextStyle(color: Colors.grey[600]),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[800]!),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() {
                _syncing = true;
              });

              try {
                // Simulate connection - in production, use google_sign_in
                await Future.delayed(const Duration(seconds: 1));

                final result = await _calendarSyncService.connectGoogleCalendar();

                if (mounted) {
                  setState(() {
                    _googleConnected = result.success;
                    _syncing = false;
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(result.success
                          ? 'Google Calendar connected successfully'
                          : 'Failed to connect Google Calendar'),
                      backgroundColor: result.success
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
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
                      content: Text('Failed to connect: $e'),
                      backgroundColor: const Color(0xFFEF4444),
                    ),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
            ),
            child: const Text('Connect', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
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

  Future<void> _connectOutlookCalendar() async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Outlook Calendar integration coming soon'),
      ),
    );
  }

  Future<void> _disconnectOutlookCalendar() async {
    setState(() {
      _outlookConnected = false;
      _outlookLastSync = null;
    });
  }

  Future<void> _syncOutlookCalendar() async {
    // Not implemented yet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Outlook Calendar sync coming soon'),
      ),
    );
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
