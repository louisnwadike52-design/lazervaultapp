part of 'notification_channels_screen.dart';

/// Screen for managing crowdfund notification channels
class NotificationChannelsScreen extends StatefulWidget {
  final String crowdfundId;
  final String crowdfundTitle;

  const NotificationChannelsScreen({
    super.key,
    required this.crowdfundId,
    required this.crowdfundTitle,
  });

  @override
  State<NotificationChannelsScreen> createState() =>
      _NotificationChannelsScreenState();
}

class _NotificationChannelsScreenState
    extends State<NotificationChannelsScreen> {
  List<NotificationChannel> _channels = [];

  @override
  void initState() {
    super.initState();
    context.read<CrowdfundCubit>().loadNotificationChannels(widget.crowdfundId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Column(
          children: [
            const Text(
              'Notification Channels',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              widget.crowdfundTitle,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 12,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _showAddChannelSheet,
            icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
            tooltip: 'Add Channel',
          ),
        ],
      ),
      body: BlocConsumer<CrowdfundCubit, CrowdfundState>(
        listener: (context, state) {
          if (state is NotificationChannelsLoaded) {
            setState(() {
              _channels = List.from(state.channels);
            });
          } else if (state is NotificationChannelConnected) {
            setState(() {
              _channels.add(state.channel);
            });
            Get.snackbar(
              'Success',
              '${state.channel.channelType.displayName} channel connected',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          } else if (state is NotificationChannelDisconnected) {
            setState(() {
              _channels.removeWhere((ch) => ch.id == state.channelId);
            });
            Get.snackbar(
              'Disconnected',
              'Channel has been disconnected',
              backgroundColor: const Color(0xFF6B7280),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          } else if (state is NotificationChannelTested) {
            Get.snackbar(
              state.success ? 'Test Sent' : 'Test Failed',
              state.success
                  ? 'Test notification sent successfully'
                  : 'Failed to send test notification',
              backgroundColor:
                  state.success ? const Color(0xFF3B82F6) : const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          } else if (state is NotificationChannelUpdated) {
            setState(() {
              final index = _channels.indexWhere((ch) => ch.id == state.channel.id);
              if (index >= 0) _channels[index] = state.channel;
            });
          } else if (state is CrowdfundError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        buildWhen: (previous, current) =>
            current is NotificationChannelsLoaded ||
            current is CrowdfundLoading ||
            current is CrowdfundError,
        builder: (context, state) {
          if (state is CrowdfundLoading) {
            return const Center(
              child: LazerVaultLoader.small(),
            );
          }

          if (state is CrowdfundError && _channels.isEmpty) {
            return _buildErrorState(state.message);
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<CrowdfundCubit>().loadNotificationChannels(widget.crowdfundId);
            },
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: _channels.isEmpty ? _buildEmptyState() : _buildChannelsList(),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 60),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_none,
                  color: Color(0xFF3B82F6),
                  size: 40,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'No Notification Channels',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect your social channels to automatically share donation updates with your community',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _showAddChannelSheet,
                icon: const Icon(Icons.add),
                label: const Text('Connect Channel'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        _buildChannelOptions(),
      ],
    );
  }

  Widget _buildChannelOptions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available Platforms',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        _buildChannelOption(
          NotificationChannelType.telegram,
          'Connect your Telegram group to share updates automatically',
          true,
        ),
        const SizedBox(height: 8),
        _buildChannelOption(
          NotificationChannelType.whatsappBusiness,
          'Personal alerts or group notifications on WhatsApp',
          true,
        ),
      ],
    );
  }

  Widget _buildChannelOption(
    NotificationChannelType type,
    String description,
    bool available,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: available
            ? null
            : Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Color(type.brandColor).withValues(alpha: available ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIconForType(type),
              color: available
                  ? Color(type.brandColor)
                  : const Color(0xFF6B7280),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      type.displayName,
                      style: TextStyle(
                        color: available ? Colors.white : const Color(0xFF6B7280),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (!available) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2D2D2D),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'Coming Soon',
                          style: TextStyle(
                            color: Color(0xFF9CA3AF),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (available)
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF6B7280),
            ),
        ],
      ),
    );
  }

  Widget _buildChannelsList() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: _channels.length + 1,
      itemBuilder: (context, index) {
        if (index == _channels.length) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextButton.icon(
              onPressed: _showAddChannelSheet,
              icon: const Icon(Icons.add, color: Color(0xFF3B82F6)),
              label: const Text(
                'Add Another Channel',
                style: TextStyle(color: Color(0xFF3B82F6)),
              ),
            ),
          );
        }

        final channel = _channels[index];
        return _buildChannelCard(channel);
      },
    );
  }

  Widget _buildChannelCard(NotificationChannel channel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(channel.channelType.brandColor)
                      .withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getIconForType(channel.channelType),
                  color: Color(channel.channelType.brandColor),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      channel.channelName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (channel.channelUsername != null)
                      Text(
                        channel.channelUsername!,
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
              ),
              _buildStatusBadge(channel.status),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${channel.notificationCount} notifications sent',
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => _testChannel(channel),
                    icon: const Icon(Icons.send, size: 20),
                    color: const Color(0xFF9CA3AF),
                    tooltip: 'Send Test',
                  ),
                  IconButton(
                    onPressed: () => _disconnectChannel(channel),
                    icon: const Icon(Icons.link_off, size: 20),
                    color: const Color(0xFFEF4444),
                    tooltip: 'Disconnect',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(NotificationChannelStatus status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Color(status.statusColor).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.displayName,
        style: TextStyle(
          color: Color(status.statusColor),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Color(0xFFEF4444),
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<CrowdfundCubit>().loadNotificationChannels(widget.crowdfundId);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  void _showAddChannelSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (sheetContext) => BlocProvider.value(
        value: context.read<CrowdfundCubit>(),
        child: _AddChannelBottomSheet(
          crowdfundId: widget.crowdfundId,
        ),
      ),
    );
  }

  void _testChannel(NotificationChannel channel) {
    context.read<CrowdfundCubit>().testNotificationChannel(channel.id);
  }

  void _disconnectChannel(NotificationChannel channel) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Disconnect Channel?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to disconnect ${channel.channelName}? Notifications will no longer be sent to this channel.',
          style: const TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<CrowdfundCubit>().disconnectNotificationChannel(channel.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
            ),
            child: const Text('Disconnect'),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(NotificationChannelType type) {
    switch (type) {
      case NotificationChannelType.telegram:
        return Icons.telegram;
      case NotificationChannelType.discord:
        return Icons.discord;
      case NotificationChannelType.whatsappBusiness:
        return Icons.chat;
      case NotificationChannelType.slack:
        return Icons.tag;
      default:
        return Icons.notifications;
    }
  }
}

/// Bottom sheet for adding a new notification channel
class _AddChannelBottomSheet extends StatefulWidget {
  final String crowdfundId;

  const _AddChannelBottomSheet({
    required this.crowdfundId,
  });

  @override
  State<_AddChannelBottomSheet> createState() => _AddChannelBottomSheetState();
}
