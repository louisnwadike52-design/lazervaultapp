import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/services/locale_manager.dart';

import '../../domain/entities/notification_channel_entities.dart';
import '../cubit/crowdfund_cubit.dart';
import '../cubit/crowdfund_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'notification_channels_screen_widgets.dart';


class _AddChannelBottomSheetState extends State<_AddChannelBottomSheet> {
  NotificationChannelType? _selectedType;
  bool _isConnecting = false;
  String? _error;

  final _nameController = TextEditingController();
  final _webhookController = TextEditingController();
  final _chatIdController = TextEditingController();
  final _whatsappPhoneController = TextEditingController();
  final _whatsappGroupIdController = TextEditingController();
  bool _whatsappGroupMode = false;

  late String _dialCode;
  late String _countryFlag;
  StreamSubscription<String>? _countrySub;

  @override
  void initState() {
    super.initState();
    final lm = GetIt.I<LocaleManager>();
    _updateDialCode(lm.currentCountry);
    _countrySub = lm.countryStream.listen(_updateDialCode);
  }

  void _updateDialCode(String countryCode) {
    final locale = CountryLocales.findByCountryCode(countryCode);
    if (mounted) {
      setState(() {
        _dialCode = locale?.dialCode ?? '+234';
        _countryFlag = locale?.flag ?? '🇳🇬';
      });
    }
  }

  @override
  void dispose() {
    _countrySub?.cancel();
    _nameController.dispose();
    _webhookController.dispose();
    _chatIdController.dispose();
    _whatsappPhoneController.dispose();
    _whatsappGroupIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrowdfundCubit, CrowdfundState>(
      listener: (context, state) {
        if (state is NotificationChannelConnected) {
          if (mounted) Navigator.pop(context);
        } else if (state is CrowdfundError) {
          setState(() {
            _error = state.message;
            _isConnecting = false;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedType == null
                        ? 'Connect Channel'
                        : 'Connect ${_selectedType!.displayName}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xFFEF4444),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (_selectedType == null) ...[
                const Text(
                  'Choose a platform to connect',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 24),
                _buildChannelTypeButton(
                  NotificationChannelType.telegram,
                  'Best for community groups',
                ),
                const SizedBox(height: 12),
                _buildChannelTypeButton(
                  NotificationChannelType.whatsappBusiness,
                  'Personal alerts or group notifications',
                ),
              ] else ...[
                _buildConnectionForm(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChannelTypeButton(
    NotificationChannelType type,
    String subtitle,
  ) {
    return InkWell(
      onTap: () => setState(() => _selectedType = type),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Color(type.brandColor).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForType(type),
                color: Color(type.brandColor),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF6B7280),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionForm() {
    switch (_selectedType!) {
      case NotificationChannelType.telegram:
        return _buildTelegramForm();
      case NotificationChannelType.discord:
        return _buildDiscordForm();
      case NotificationChannelType.slack:
        return _buildSlackForm();
      case NotificationChannelType.whatsappBusiness:
        return _buildWhatsAppForm();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTelegramForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To connect Telegram:\n'
          '1. Add @LazerVaultBot to your group\n'
          '2. Make it an admin\n'
          '3. Send /start in the group\n'
          '4. Enter the chat ID below',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildTextField(_nameController, 'Channel Name', 'e.g., Campaign Updates Group'),
        const SizedBox(height: 16),
        _buildTextField(_chatIdController, 'Chat ID', 'e.g., -1001234567890'),
        const SizedBox(height: 24),
        _buildConnectButton(),
      ],
    );
  }

  Widget _buildDiscordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To connect Discord:\n'
          '1. Go to your Discord server settings\n'
          '2. Navigate to Integrations > Webhooks\n'
          '3. Create a new webhook\n'
          '4. Copy and paste the URL below',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildTextField(_nameController, 'Channel Name', 'e.g., #donations-updates'),
        const SizedBox(height: 16),
        _buildTextField(_webhookController, 'Webhook URL', 'https://discord.com/api/webhooks/...'),
        const SizedBox(height: 24),
        _buildConnectButton(),
      ],
    );
  }

  Widget _buildSlackForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'To connect Slack:\n'
          '1. Go to your Slack workspace settings\n'
          '2. Navigate to Apps > Incoming Webhooks\n'
          '3. Create a new webhook for a channel\n'
          '4. Copy and paste the URL below',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        _buildTextField(_nameController, 'Channel Name', 'e.g., #campaign-updates'),
        const SizedBox(height: 16),
        _buildTextField(_webhookController, 'Webhook URL', 'https://hooks.slack.com/services/...'),
        const SizedBox(height: 24),
        _buildConnectButton(),
      ],
    );
  }

  Widget _buildWhatsAppForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Toggle between Personal Alerts and Group Notifications
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _whatsappGroupMode = false),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: !_whatsappGroupMode
                          ? const Color(0xFF25D366)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Personal Alerts',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: !_whatsappGroupMode
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _whatsappGroupMode = true),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: _whatsappGroupMode
                          ? const Color(0xFF25D366)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Group Notifications',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _whatsappGroupMode
                            ? Colors.white
                            : const Color(0xFF9CA3AF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (!_whatsappGroupMode) ...[
          const Text(
            'Get donation alerts on your WhatsApp:\n\n'
            '1. Enter your WhatsApp phone number\n'
            '2. You\'ll receive personal alerts for new donations,\n'
            '   milestones, and campaign updates',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF25D366).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF25D366).withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.check_circle, color: Color(0xFF25D366), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Notifications are sent from our verified Lazervault WhatsApp Business account.',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(_nameController, 'Channel Name', 'e.g., My Campaign Alerts'),
          const SizedBox(height: 16),
          _buildWhatsAppPhoneField(),
        ] else ...[
          const Text(
            'Send donation updates to a WhatsApp group:\n\n'
            '1. Create a WhatsApp group for your campaign\n'
            '2. Add our Lazervault number to your WhatsApp group\n'
            '3. Enter the group name below',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF3B82F6), size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Group JID format: 120363XXXXX@g.us\n'
                    'You can find the group JID from the groups list endpoint.',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildTextField(_nameController, 'Channel Name', 'e.g., Campaign Group Updates'),
          const SizedBox(height: 16),
          _buildTextField(
            _whatsappGroupIdController,
            'Group JID',
            'e.g., 120363045559@g.us',
          ),
        ],
        const SizedBox(height: 24),
        _buildConnectButton(),
      ],
    );
  }

  Widget _buildWhatsAppPhoneField() {
    return TextField(
      controller: _whatsappPhoneController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'WhatsApp Phone Number',
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        hintText: 'e.g., 8012345678',
        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_countryFlag, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 6),
              Text(
                _dialCode,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              Container(width: 1, height: 20, color: const Color(0xFF6B7280)),
            ],
          ),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }

  /// Builds the full international phone number from dial code + local number
  String _buildFullPhoneNumber() {
    final local = _whatsappPhoneController.text.trim();
    // Strip leading zero if user entered it (e.g., 0801... → 801...)
    final cleaned = local.startsWith('0') ? local.substring(1) : local;
    // Strip + prefix from dial code (e.g., +234 → 234)
    final code = _dialCode.replaceAll('+', '');
    return '$code$cleaned';
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF6B7280)),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildConnectButton() {
    return Row(
      children: [
        TextButton(
          onPressed: () => setState(() => _selectedType = null),
          child: const Text('Back'),
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: _isConnecting ? null : _connectChannel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(_selectedType!.brandColor),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: _isConnecting
              ? LazerVaultLoader.small()
              : const Text('Connect'),
        ),
      ],
    );
  }

  Future<void> _connectChannel() async {
    if (_nameController.text.isEmpty) {
      setState(() => _error = 'Please enter a channel name');
      return;
    }

    if (_selectedType == NotificationChannelType.telegram) {
      if (_chatIdController.text.isEmpty) {
        setState(() => _error = 'Please enter the chat ID');
        return;
      }
    } else if (_selectedType == NotificationChannelType.whatsappBusiness) {
      if (_whatsappGroupMode) {
        if (_whatsappGroupIdController.text.isEmpty) {
          setState(() => _error = 'Please enter the WhatsApp group JID');
          return;
        }
      } else {
        if (_whatsappPhoneController.text.isEmpty) {
          setState(() => _error = 'Please enter your WhatsApp phone number');
          return;
        }
      }
    } else {
      if (_webhookController.text.isEmpty) {
        setState(() => _error = 'Please enter the webhook URL');
        return;
      }
    }

    setState(() {
      _isConnecting = true;
      _error = null;
    });

    final cubit = context.read<CrowdfundCubit>();

    cubit.connectNotificationChannel(
      crowdfundId: widget.crowdfundId,
      channelType: _selectedType!,
      channelName: _nameController.text,
      telegramChatId: _selectedType == NotificationChannelType.telegram
          ? _chatIdController.text
          : null,
      discordWebhookUrl: _selectedType == NotificationChannelType.discord
          ? _webhookController.text
          : null,
      discordChannelName: _selectedType == NotificationChannelType.discord
          ? _nameController.text
          : null,
      slackWebhookUrl: _selectedType == NotificationChannelType.slack
          ? _webhookController.text
          : null,
      slackChannelName: _selectedType == NotificationChannelType.slack
          ? _nameController.text
          : null,
      whatsappRecipientId: _selectedType == NotificationChannelType.whatsappBusiness
          ? (_whatsappGroupMode
              ? 'group:${_whatsappGroupIdController.text.trim()}'
              : _buildFullPhoneNumber())
          : null,
      enabledEvents: [
        NotificationEventType.newDonation,
        NotificationEventType.milestoneReached,
        NotificationEventType.goalReached,
      ],
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
