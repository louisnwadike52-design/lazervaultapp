import 'package:lazervault/core/cache/session_page_store.dart';
import 'package:lazervault/src/features/authentication/domain/repositories/i_auth_repository.dart';

/// The Security Center lists (login activity's first page, trusted devices),
/// remembered per user and mirrored to disk, so each screen paints its last
/// answer on open and refreshes behind it instead of showing a spinner.
class SecurityCenterPageStore {
  SecurityCenterPageStore._();

  static final SessionPageStore<LoginActivity> loginActivity =
      SessionPageStore<LoginActivity>(
    'security_login_activity',
    toJson: encodeActivity,
    fromJson: decodeActivity,
  );

  static final SessionPageStore<TrustedDevice> trustedDevices =
      SessionPageStore<TrustedDevice>(
    'security_trusted_devices',
    toJson: encodeDevice,
    fromJson: decodeDevice,
  );

  static Map<String, dynamic> encodeActivity(LoginActivity a) => {
        'success': a.success,
        'ip_address': a.ipAddress,
        'device_name': a.deviceName,
        'user_agent': a.userAgent,
        'fail_reason': a.failReason,
        'at': a.at?.toIso8601String(),
      };

  static LoginActivity decodeActivity(Map<String, dynamic> j) => LoginActivity(
        success: j['success'] == true,
        ipAddress: j['ip_address'] as String? ?? '',
        deviceName: j['device_name'] as String? ?? '',
        userAgent: j['user_agent'] as String? ?? '',
        failReason: j['fail_reason'] as String? ?? '',
        at: _date(j['at']),
      );

  static Map<String, dynamic> encodeDevice(TrustedDevice d) => {
        'device_uuid': d.deviceUuid,
        'platform': d.platform,
        'model': d.model,
        'os_version': d.osVersion,
        'app_version': d.appVersion,
        'trust_status': d.trustStatus,
        'last_ip': d.lastIp,
        'last_location': d.lastLocation,
        'first_seen_at': d.firstSeenAt?.toIso8601String(),
        'last_login_at': d.lastLoginAt?.toIso8601String(),
        'is_current': d.isCurrent,
      };

  static TrustedDevice decodeDevice(Map<String, dynamic> j) => TrustedDevice(
        deviceUuid: j['device_uuid'] as String? ?? '',
        platform: j['platform'] as String? ?? '',
        model: j['model'] as String? ?? '',
        osVersion: j['os_version'] as String? ?? '',
        appVersion: j['app_version'] as String? ?? '',
        trustStatus: j['trust_status'] as String? ?? '',
        lastIp: j['last_ip'] as String? ?? '',
        lastLocation: j['last_location'] as String? ?? '',
        firstSeenAt: _date(j['first_seen_at']),
        lastLoginAt: _date(j['last_login_at']),
        isCurrent: j['is_current'] == true,
      );

  static DateTime? _date(Object? v) =>
      v is String ? DateTime.tryParse(v) : null;
}
