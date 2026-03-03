import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../cubit/channel_management_cubit.dart';
import '../../cubit/channel_management_state.dart';
import '../../domain/entities/channel_registration.dart';
import '../../domain/entities/channel_pin_status.dart';
import 'channel_activation_screen.dart';
import 'channel_pin_setup_screen.dart';

class ChannelManagementScreen extends StatelessWidget {
  const ChannelManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          serviceLocator<ChannelManagementCubit>()..loadChannels(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: const Text(
            'Banking Channels',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<ChannelManagementCubit, ChannelManagementState>(
          listener: (context, state) {
            if (state is ChannelDeactivated) {
              Get.snackbar(
                'Channel Deactivated',
                '${state.channelType == "whatsapp" ? "WhatsApp" : "Phone & SMS"} banking has been deactivated.',
                backgroundColor: const Color(0xFF1F1F1F),
                colorText: Colors.white,
              );
              context.read<ChannelManagementCubit>().loadChannels();
            } else if (state is ChannelManagementError) {
              Get.snackbar(
                'Error',
                state.message,
                backgroundColor: const Color(0xFFEF4444),
                colorText: Colors.white,
              );
            }
          },
          builder: (context, state) {
            if (state is ChannelManagementLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
              );
            }

            if (state is ChannelManagementLoaded) {
              return _buildChannelList(context, state);
            }

            if (state is ChannelManagementError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Color(0xFFEF4444), size: 48),
                    const SizedBox(height: 16),
                    Text(state.message,
                        style: const TextStyle(color: Color(0xFF9CA3AF))),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () =>
                          context.read<ChannelManagementCubit>().loadChannels(),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B82F6)),
                      child: const Text('Retry',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildChannelList(
      BuildContext context, ChannelManagementLoaded state) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<ChannelManagementCubit>().loadChannels(),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Manage your banking channels to access LazerVault from WhatsApp, phone calls, and SMS.',
            style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          ),
          const SizedBox(height: 24),
          _buildChannelCard(
            context: context,
            channelType: 'whatsapp',
            title: 'WhatsApp Banking',
            subtitle: 'Bank via WhatsApp messages',
            icon: Icons.chat,
            color: const Color(0xFF25D366),
            registration: state.getRegistration('whatsapp'),
            pinStatus: state.getPinStatus('whatsapp'),
          ),
          const SizedBox(height: 16),
          _buildChannelCard(
            context: context,
            channelType: 'telephony',
            title: 'Phone & SMS Banking',
            subtitle: 'Bank via phone calls and text messages',
            icon: Icons.phone,
            color: const Color(0xFF3B82F6),
            registration: state.getRegistration('telephony'),
            pinStatus: state.getPinStatus('telephony'),
          ),
          const SizedBox(height: 24),
          _buildAppPinSection(state.getPinStatus('app')),
        ],
      ),
    );
  }

  Widget _buildChannelCard({
    required BuildContext context,
    required String channelType,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    ChannelRegistration? registration,
    ChannelPinStatus? pinStatus,
  }) {
    final isActive = registration?.isActive ?? false;
    final isPending = registration?.isPending ?? false;
    final hasPin = pinStatus?.hasPin ?? false;

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isActive
              ? color.withValues(alpha: 0.3)
              : const Color(0xFF2D2D2D),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: const TextStyle(
                            color: Color(0xFF9CA3AF), fontSize: 13)),
                  ],
                ),
              ),
              _buildStatusBadge(isActive, isPending),
            ],
          ),
          if (isActive) ...[
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2D2D2D)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        hasPin ? Icons.lock : Icons.lock_open,
                        color: hasPin
                            ? const Color(0xFF10B981)
                            : const Color(0xFFFB923C),
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        hasPin ? 'PIN set up' : 'PIN not set up',
                        style: TextStyle(
                          color: hasPin
                              ? const Color(0xFF10B981)
                              : const Color(0xFFFB923C),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!hasPin)
                  _buildActionButton(
                    'Set PIN',
                    () => Get.to(() => ChannelPinSetupScreen(
                          channelType: channelType,
                          isChange: false,
                        )),
                  )
                else
                  _buildActionButton(
                    'Change PIN',
                    () => Get.to(() => ChannelPinSetupScreen(
                          channelType: channelType,
                          isChange: true,
                        )),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _confirmDeactivation(context, channelType),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFEF4444)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Deactivate',
                    style: TextStyle(color: Color(0xFFEF4444))),
              ),
            ),
          ] else if (!isActive && !isPending) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => ChannelActivationScreen(
                      channelType: channelType,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Activate',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ] else if (isPending) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => ChannelActivationScreen(
                      channelType: channelType,
                    )),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFB923C),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Complete Activation',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive, bool isPending) {
    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF10B981).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Active',
            style: TextStyle(color: Color(0xFF10B981), fontSize: 12)),
      );
    }
    if (isPending) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFFFB923C).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text('Pending',
            style: TextStyle(color: Color(0xFFFB923C), fontSize: 12)),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF9CA3AF).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text('Inactive',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
    );
  }

  Widget _buildActionButton(String label, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label,
          style: const TextStyle(color: Color(0xFF3B82F6), fontSize: 13)),
    );
  }

  Widget _buildAppPinSection(ChannelPinStatus? appPin) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.smartphone,
                color: Color(0xFF3B82F6), size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('App Transaction PIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text(
                  appPin?.hasPin == true
                      ? 'PIN is active'
                      : 'Set up your app PIN in Transaction PIN settings',
                  style: const TextStyle(
                      color: Color(0xFF9CA3AF), fontSize: 13),
                ),
              ],
            ),
          ),
          Icon(
            appPin?.hasPin == true ? Icons.check_circle : Icons.info_outline,
            color: appPin?.hasPin == true
                ? const Color(0xFF10B981)
                : const Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }

  void _confirmDeactivation(BuildContext context, String channelType) {
    final channelName =
        channelType == 'whatsapp' ? 'WhatsApp' : 'Phone & SMS';
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text('Deactivate $channelName Banking?',
            style: const TextStyle(color: Colors.white)),
        content: Text(
          'You will no longer be able to use $channelName to access your LazerVault account. You can reactivate it later.',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context
                  .read<ChannelManagementCubit>()
                  .deactivateChannel(channelType: channelType);
            },
            child: const Text('Deactivate',
                style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }
}
