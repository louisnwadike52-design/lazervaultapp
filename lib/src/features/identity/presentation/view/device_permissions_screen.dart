import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';

/// Settings → Security → Device Permissions.
///
/// The OS is the SOURCE OF TRUTH for what the app can actually access, so the
/// switches reflect the live `permission_handler` status (queried on load and
/// whenever the app resumes from the system settings page). Toggling a granted
/// permission opens the system settings (the OS doesn't allow apps to revoke
/// silently); toggling a denied one requests it. Each change is also synced to
/// the backend best-effort for cross-device audit — failures never block the UI.
class DevicePermissionsScreen extends StatefulWidget {
  const DevicePermissionsScreen({super.key});

  @override
  State<DevicePermissionsScreen> createState() =>
      _DevicePermissionsScreenState();
}

class _DevicePermissionsScreenState extends State<DevicePermissionsScreen>
    with WidgetsBindingObserver {
  // Dark theme palette (matches the rest of the app).
  static const Color _bg = Color(0xFF0A0A0A);
  static const Color _card = Color(0xFF1F1F1F);
  static const Color _divider = Color(0xFF2D2D2D);
  static const Color _textPrimary = Colors.white;
  static const Color _textSecondary = Color(0xFF9CA3AF);
  static const Color _primary = Color(0xFF3B82F6);
  static const Color _success = Color(0xFF10B981);

  final Map<PermissionType, bool> _permissions = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _syncOsStatus();
    // Best-effort: pull the server's last-known audit (ignored on failure).
    context.read<IdentityCubit>().getPermissions();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-read OS status when returning from the system settings page so a
    // permission the user changed there is reflected immediately.
    if (state == AppLifecycleState.resumed) _syncOsStatus();
  }

  Permission _osPermission(PermissionType t) {
    switch (t) {
      case PermissionType.camera:
        return Permission.camera;
      case PermissionType.location:
        return Permission.location;
      case PermissionType.microphone:
        return Permission.microphone;
      case PermissionType.storage:
        return Permission.storage;
      case PermissionType.contacts:
        return Permission.contacts;
      case PermissionType.biometric:
        return Permission.sensors;
    }
  }

  /// Read the live OS permission status for every type — the source of truth.
  Future<void> _syncOsStatus() async {
    for (final t in PermissionType.values) {
      try {
        final status = await _osPermission(t).status;
        _permissions[t] = status.isGranted;
      } catch (_) {
        _permissions[t] = _permissions[t] ?? false;
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _onToggle(PermissionType type) async {
    final granted = _permissions[type] ?? false;
    if (granted) {
      // OS doesn't let an app silently revoke — send the user to settings.
      _showRevokeDialog(type);
      return;
    }
    final status = await _osPermission(type).request();
    if (!mounted) return;
    setState(() => _permissions[type] = status.isGranted);
    if (status.isPermanentlyDenied) {
      _showRevokeDialog(type, permanentlyDenied: true);
    }
    _syncToServer();
  }

  /// Best-effort backend audit — never surfaces errors to the user.
  void _syncToServer() {
    final list = PermissionType.values
        .map((t) => DevicePermission(
              permissionType: t,
              isGranted: _permissions[t] ?? false,
              grantedAt: (_permissions[t] ?? false) ? DateTime.now() : null,
            ))
        .toList();
    context.read<IdentityCubit>().updatePermissions(permissions: list);
  }

  void _showRevokeDialog(PermissionType type, {bool permanentlyDenied = false}) {
    final name = _entity(type).permissionName;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Text(
          permanentlyDenied ? '$name needs system access' : 'Manage $name',
          style: GoogleFonts.inter(
              color: _textPrimary, fontWeight: FontWeight.w700, fontSize: 16.sp),
        ),
        content: Text(
          permanentlyDenied
              ? '$name is blocked. Open system settings to allow it for Lazervault.'
              : 'To change $name access, open your system settings for Lazervault.',
          style: GoogleFonts.inter(color: _textSecondary, fontSize: 13.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel',
                style: GoogleFonts.inter(color: _textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r)),
            ),
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  DevicePermission _entity(PermissionType t) =>
      DevicePermission(permissionType: t, isGranted: false);

  IconData _icon(PermissionType t) {
    switch (t) {
      case PermissionType.camera:
        return Icons.camera_alt_outlined;
      case PermissionType.location:
        return Icons.location_on_outlined;
      case PermissionType.microphone:
        return Icons.mic_none_outlined;
      case PermissionType.storage:
        return Icons.folder_outlined;
      case PermissionType.contacts:
        return Icons.contacts_outlined;
      case PermissionType.biometric:
        return Icons.fingerprint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _bg,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: _textPrimary),
        title: Text(
          'Device Permissions',
          style: GoogleFonts.inter(
              color: _textPrimary, fontSize: 17.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocListener<IdentityCubit, IdentityState>(
        listener: (context, state) {
          // Server is audit-only; the OS status drives the switches. We don't
          // override OS truth with server data, and we swallow server errors.
        },
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: _primary))
            : ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
                children: [
                  Text(
                    'App permissions',
                    style: GoogleFonts.inter(
                        color: _textPrimary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Control what Lazervault can access on this device. These '
                    'reflect your system settings.',
                    style: GoogleFonts.inter(
                        color: _textSecondary, fontSize: 12.sp, height: 1.4),
                  ),
                  SizedBox(height: 20.h),
                  ...PermissionType.values.map(_tile),
                ],
              ),
      ),
    );
  }

  Widget _tile(PermissionType type) {
    final granted = _permissions[type] ?? false;
    final entity = _entity(type);
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _divider),
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: (granted ? _primary : _textSecondary)
                  .withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(_icon(type),
                color: granted ? _primary : _textSecondary, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(entity.permissionName,
                        style: GoogleFonts.inter(
                            color: _textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                    SizedBox(width: 8.w),
                    Text(
                      granted ? 'Allowed' : 'Not allowed',
                      style: GoogleFonts.inter(
                        color: granted ? _success : _textSecondary,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(entity.permissionDescription,
                    style: GoogleFonts.inter(
                        color: _textSecondary, fontSize: 11.sp, height: 1.35)),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Switch(
            value: granted,
            activeThumbColor: Colors.white,
            activeTrackColor: _primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: _divider,
            onChanged: (_) => _onToggle(type),
          ),
        ],
      ),
    );
  }
}
