import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';

class MyCoverNotificationPrefsScreen extends StatefulWidget {
  const MyCoverNotificationPrefsScreen({super.key});

  @override
  State<MyCoverNotificationPrefsScreen> createState() => _MyCoverNotificationPrefsScreenState();
}

class _MyCoverNotificationPrefsScreenState extends State<MyCoverNotificationPrefsScreen> {
  List<MyCoverNotificationPref> _preferences = [];
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverNotificationPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Notification Preferences', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          if (_hasChanges)
            TextButton(
              onPressed: _savePreferences,
              child: const Text('Save', style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
            ),
        ],
      ),
      body: BlocConsumer<InsuranceCubit, InsuranceState>(
        listener: (context, state) {
          if (state is MyCoverNotificationPrefsLoaded) {
            setState(() => _preferences = List.from(state.preferences));
          }
          if (state is MyCoverNotificationPrefsUpdated) {
            setState(() => _hasChanges = false);
            Get.snackbar(
              'Saved',
              'Notification preferences updated',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
          if (state is InsuranceError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        builder: (context, state) {
          if (state is InsuranceLoading && _preferences.isEmpty) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
          }
          if (_preferences.isEmpty && state is InsuranceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: const TextStyle(color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<InsuranceCubit>().loadMyCoverNotificationPreferences(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final emailPrefs = _preferences.where((p) => p.category == 'email').toList();
          final smsPrefs = _preferences.where((p) => p.category == 'sms').toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Manage how MyCover communicates with your customers about insurance activities.',
                style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
              ),
              const SizedBox(height: 24),
              // Master toggle
              _buildMasterToggle(),
              const SizedBox(height: 24),
              // Email section
              if (emailPrefs.isNotEmpty) ...[
                _buildSectionHeader(Icons.email_outlined, 'Email Notifications', const Color(0xFF3B82F6)),
                const SizedBox(height: 12),
                ...emailPrefs.map(_buildPreferenceToggle),
                const SizedBox(height: 24),
              ],
              // SMS section
              if (smsPrefs.isNotEmpty) ...[
                _buildSectionHeader(Icons.sms_outlined, 'SMS Notifications', const Color(0xFF10B981)),
                const SizedBox(height: 12),
                ...smsPrefs.map(_buildPreferenceToggle),
              ],
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMasterToggle() {
    final allEnabled = _preferences.every((p) => p.enabled);
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.notifications_outlined, color: Color(0xFF3B82F6), size: 22),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('All Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                  SizedBox(height: 2),
                  Text('Toggle all notifications on or off', style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                ],
              ),
            ),
            Switch(
              value: allEnabled,
              onChanged: (enabled) {
                setState(() {
                  _preferences = _preferences.map((p) => p.copyWith(enabled: enabled)).toList();
                  _hasChanges = true;
                });
              },
              activeTrackColor: const Color(0xFF3B82F6),
              inactiveTrackColor: const Color(0xFF2D2D2D),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(IconData icon, String title, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildPreferenceToggle(MyCoverNotificationPref pref) {
    return Card(
      color: const Color(0xFF1F1F1F),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(pref.label, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                  if (pref.description.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(pref.description, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            Switch(
              value: pref.enabled,
              onChanged: (enabled) {
                setState(() {
                  final idx = _preferences.indexWhere((p) => p.key == pref.key);
                  if (idx >= 0) {
                    _preferences[idx] = _preferences[idx].copyWith(enabled: enabled);
                    _hasChanges = true;
                  }
                });
              },
              activeTrackColor: const Color(0xFF3B82F6),
              inactiveTrackColor: const Color(0xFF2D2D2D),
            ),
          ],
        ),
      ),
    );
  }

  void _savePreferences() {
    context.read<InsuranceCubit>().updateMyCoverNotificationPreferences(_preferences);
  }
}
