import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lazervault/src/features/identity/cubit/identity_cubit.dart';
import 'package:lazervault/src/features/identity/cubit/identity_state.dart';
import 'package:lazervault/src/features/identity/domain/entities/device_permission.dart';

class DevicePermissionsScreen extends StatefulWidget {
  const DevicePermissionsScreen({super.key});

  @override
  State<DevicePermissionsScreen> createState() =>
      _DevicePermissionsScreenState();
}

class _DevicePermissionsScreenState extends State<DevicePermissionsScreen> {
  final Map<PermissionType, bool> _permissions = {};

  @override
  void initState() {
    super.initState();
    _loadPermissions();
  }

  Future<void> _loadPermissions() async {
    context.read<IdentityCubit>().getPermissions();
  }

  Future<void> _requestPermission(PermissionType permissionType) async {
    Permission permission;

    switch (permissionType) {
      case PermissionType.camera:
        permission = Permission.camera;
        break;
      case PermissionType.location:
        permission = Permission.location;
        break;
      case PermissionType.microphone:
        permission = Permission.microphone;
        break;
      case PermissionType.storage:
        permission = Permission.storage;
        break;
      case PermissionType.contacts:
        permission = Permission.contacts;
        break;
      case PermissionType.biometric:
        permission = Permission.sensors;
        break;
    }

    final status = await permission.request();
    final isGranted = status.isGranted;

    setState(() {
      _permissions[permissionType] = isGranted;
    });

    // Update on server
    final permissionList = PermissionType.values
        .map((type) => DevicePermission(
              permissionType: type,
              isGranted: _permissions[type] ?? false,
              grantedAt: _permissions[type] == true ? DateTime.now() : null,
            ))
        .toList();

    if (mounted) {
      context.read<IdentityCubit>().updatePermissions(
            permissions: permissionList,
          );
    }
  }

  Future<void> _togglePermission(PermissionType permissionType) async {
    final currentStatus = _permissions[permissionType] ?? false;

    if (currentStatus) {
      // Permission is currently granted - show dialog to direct user to settings
      _showSettingsDialog(permissionType);
    } else {
      // Request the permission
      await _requestPermission(permissionType);
    }
  }

  void _showSettingsDialog(PermissionType permissionType) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Permission Settings'),
        content: Text(
          'To revoke ${_getPermissionName(permissionType)} permission, please go to app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              openAppSettings();
              Navigator.pop(context);
            },
            child: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  String _getPermissionName(PermissionType type) {
    switch (type) {
      case PermissionType.camera:
        return 'Camera';
      case PermissionType.location:
        return 'Location';
      case PermissionType.microphone:
        return 'Microphone';
      case PermissionType.storage:
        return 'Storage';
      case PermissionType.contacts:
        return 'Contacts';
      case PermissionType.biometric:
        return 'Biometric';
    }
  }

  String _getPermissionDescription(PermissionType type) {
    switch (type) {
      case PermissionType.camera:
        return 'Access camera for facial recognition and document scanning';
      case PermissionType.location:
        return 'Access location for enhanced security verification';
      case PermissionType.microphone:
        return 'Access microphone for voice verification';
      case PermissionType.storage:
        return 'Access storage to save documents and images';
      case PermissionType.contacts:
        return 'Access contacts for peer-to-peer transactions';
      case PermissionType.biometric:
        return 'Access biometric authentication (fingerprint/face)';
    }
  }

  IconData _getPermissionIcon(PermissionType type) {
    switch (type) {
      case PermissionType.camera:
        return Icons.camera_alt;
      case PermissionType.location:
        return Icons.location_on;
      case PermissionType.microphone:
        return Icons.mic;
      case PermissionType.storage:
        return Icons.folder;
      case PermissionType.contacts:
        return Icons.contacts;
      case PermissionType.biometric:
        return Icons.fingerprint;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Permissions'),
        backgroundColor: Colors.purple.shade700,
      ),
      body: BlocConsumer<IdentityCubit, IdentityState>(
        listener: (context, state) {
          if (state is PermissionsUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is PermissionsLoaded) {
            // Update local state with loaded permissions
            setState(() {
              for (var perm in state.permissions) {
                _permissions[perm.permissionType] = perm.isGranted;
              }
            });
          } else if (state is IdentityError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is IdentityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Manage App Permissions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Control what data the app can access on your device',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 24),

              // Permission tiles
              ...PermissionType.values.map((type) {
                return _buildPermissionTile(
                  type: type,
                  isGranted: _permissions[type] ?? false,
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPermissionTile({
    required PermissionType type,
    required bool isGranted,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isGranted
                ? Colors.purple.shade100
                : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            _getPermissionIcon(type),
            color: isGranted ? Colors.purple.shade700 : Colors.grey,
          ),
        ),
        title: Text(
          _getPermissionName(type),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(_getPermissionDescription(type)),
        trailing: Switch(
          value: isGranted,
          activeColor: Colors.purple.shade700,
          onChanged: (_) => _togglePermission(type),
        ),
      ),
    );
  }
}
