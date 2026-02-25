import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:get/get.dart';

/// Development utility to reset onboarding state
/// Call this function to simulate a fresh install
Future<void> resetOnboardingForDevelopment() async {
  final storage = serviceLocator<FlutterSecureStorage>();
  await storage.write(key: 'force_onboarding', value: 'true');
  print('✅ Onboarding will be reset on next app launch');
}

/// Debug Settings Screen - For Development Only
/// Allows resetting the app state to test onboarding flow
class DebugSettingsScreen extends StatefulWidget {
  const DebugSettingsScreen({super.key});

  @override
  State<DebugSettingsScreen> createState() => _DebugSettingsScreenState();
}

class _DebugSettingsScreenState extends State<DebugSettingsScreen> {
  final FlutterSecureStorage storage = serviceLocator<FlutterSecureStorage>();
  bool _isLoading = false;
  Map<String, String> _storageData = {};

  @override
  void initState() {
    super.initState();
    _loadStorageData();
  }

  Future<void> _loadStorageData() async {
    setState(() => _isLoading = true);
    try {
      // Read specific keys we care about
      final keys = [
        'has_seen_onboarding',
        'force_onboarding',
        'user_id',
        'stored_email',
        'login_method',
        'has_incomplete_signup',
        'current_signup_step',
      ];

      final data = <String, String>{};
      for (final key in keys) {
        final value = await storage.read(key: key);
        if (value != null) {
          data[key] = value;
        }
      }

      if (mounted) {
        setState(() {
          _storageData = data;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _resetOnboarding() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Reset Onboarding?'),
        content: const Text(
          'This will clear all stored data and show the onboarding screens on the next app launch. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Reset'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await resetOnboardingForDevelopment();
      Get.snackbar(
        'Onboarding Reset',
        'Close and restart the app to see onboarding screens',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      _loadStorageData();
    }
  }

  Future<void> _clearAllData() async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will completely wipe all app data including login credentials. You will need to sign up again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await storage.deleteAll();
      Get.snackbar(
        'Data Cleared',
        'All app data has been wiped',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      _loadStorageData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Settings'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: EdgeInsets.all(20.w),
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'This screen is for development only. Remove it before production.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),

                // Current State Section
                Text(
                  'Current App State',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),

                // State Cards
                _buildStateCard(
                  'Onboarding Status',
                  _storageData.containsKey('has_seen_onboarding')
                      ? '✅ Completed'
                      : '❌ Not Started',
                  Icons.slideshow_outlined,
                  _storageData.containsKey('has_seen_onboarding')
                      ? Colors.green
                      : Colors.orange,
                ),
                SizedBox(height: 12.h),

                _buildStateCard(
                  'Login Status',
                  _storageData.containsKey('user_id') ? 'Logged In' : 'Not Logged In',
                  Icons.login,
                  _storageData.containsKey('user_id') ? Colors.blue : Colors.grey,
                ),
                SizedBox(height: 12.h),

                _buildStateCard(
                  'Login Method',
                  _storageData['login_method']?.toUpperCase() ?? 'NONE',
                  Icons.lock_outline,
                  Colors.purple,
                ),
                SizedBox(height: 24.h),

                // Actions Section
                Text(
                  'Debug Actions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),

                // Reset Onboarding Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: _resetOnboarding,
                    icon: const Icon(Icons.refresh),
                    label: Text(
                      'Reset Onboarding Flow',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // Clear All Data Button
                SizedBox(
                  width: double.infinity,
                  height: 56.h,
                  child: ElevatedButton.icon(
                    onPressed: _clearAllData,
                    icon: const Icon(Icons.delete_forever),
                    label: Text(
                      'Clear All App Data',
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Storage Details
                Text(
                  'Stored Data',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16.h),

                if (_storageData.isEmpty)
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: Text(
                        'No stored data found',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ),
                  )
                else
                  ..._storageData.entries.map((entry) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 8.h),
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            flex: 3,
                            child: Text(
                              entry.value,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey.shade700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                SizedBox(height: 32.h),

                // Back to Dashboard
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: OutlinedButton.icon(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.purple,
                      side: BorderSide(color: Colors.purple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStateCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: Colors.white, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
