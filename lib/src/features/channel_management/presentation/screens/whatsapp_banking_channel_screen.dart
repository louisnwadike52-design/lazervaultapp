import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/channel_management/cubit/channel_management_cubit.dart';
import 'package:lazervault/src/features/channel_management/cubit/channel_management_state.dart';
import 'package:lazervault/src/features/channel_management/domain/entities/channel_registration.dart';
import 'package:lazervault/src/features/channel_management/presentation/widgets/channel_screen_scaffold.dart';

import 'channel_activation_screen.dart';
import 'channel_pin_setup_screen.dart';

/// WhatsApp Banking — its own Quick Service, its own screen.
///
/// WHY THIS IS SEPARATE FROM PHONE BANKING
/// ---------------------------------------
/// These were one screen taking a `channelType` argument, which made them look
/// like one feature with a switch. They are not:
///
///   * The NUMBER rule is opposite. WhatsApp may be on a different line than
///     your profile — people routinely run WhatsApp on a second SIM — so the
///     number is editable here and the OTP is what makes it trustworthy. Phone
///     banking is pinned to the profile number and the server refuses anything
///     else (auth-service forces `user.Phone` on telephony registration).
///   * The SETTINGS differ. Voice recognition belongs to a voice call, not to
///     a text thread; message-level controls belong to WhatsApp.
///   * A second, separate LINK step exists only for WhatsApp — auth-service
///     does channel registration (OTP + channel PIN) while whatsapp-service
///     does account linking. Phone banking has no equivalent.
///
/// One screen could only serve both by hiding half of each.
class WhatsAppBankingChannelScreen extends StatefulWidget {
  const WhatsAppBankingChannelScreen({super.key});

  @override
  State<WhatsAppBankingChannelScreen> createState() =>
      _WhatsAppBankingChannelScreenState();
}

class _WhatsAppBankingChannelScreenState
    extends State<WhatsAppBankingChannelScreen> {
  static const _channel = 'whatsapp';
  static const _whatsappGreen = Color(0xFF25D366);

  bool _toggleBusy = false;

  @override
  void initState() {
    super.initState();
    context.read<ChannelManagementCubit>().loadChannels();
  }

  /// The number on the user's profile — the sensible default for a WhatsApp
  /// line, pre-filled so the common case is one tap rather than typing a
  /// number the app already knows.
  String get _profilePhone {
    final auth = serviceLocator<AuthenticationCubit>().state;
    if (auth is AuthenticationSuccess) {
      return auth.profile.user.phoneNumber ?? '';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ChannelScreenTheme.pageBg,
      body: BlocConsumer<ChannelManagementCubit, ChannelManagementState>(
        listener: (context, state) {
          if (state is ChannelDeactivated && state.channelType == _channel) {
            setState(() => _toggleBusy = false);
            _snack('WhatsApp banking switched off.',
                ChannelScreenTheme.textMuted);
            context.read<ChannelManagementCubit>().loadChannels();
          }
          if (state is ChannelManagementError) {
            setState(() => _toggleBusy = false);
            _snack(state.message, ChannelScreenTheme.danger);
          }
        },
        builder: (context, state) {
          final reg = state is ChannelManagementLoaded
              ? state.getRegistration(_channel)
              : null;
          return Column(
            children: [
              ChannelHeader(
                title: 'WhatsApp Banking',
                subtitle: 'Bank by chatting with LazerVault on WhatsApp',
                icon: Icons.chat_bubble_rounded,
                accent: _whatsappGreen,
              ),
              Expanded(
                child: state is ChannelManagementLoading
                    ? const Center(child: CircularProgressIndicator())
                    : RefreshIndicator(
                        onRefresh: () async => context
                            .read<ChannelManagementCubit>()
                            .loadChannels(),
                        child: ListView(
                          padding: const EdgeInsets.fromLTRB(16, 18, 16, 40),
                          children: [
                            if (state is ChannelManagementError)
                              _errorCard(state.message)
                            else ...[
                              _statusSection(reg),
                              _numberSection(reg),
                              _securitySection(reg),
                              _linkSection(reg),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------- sections

  Widget _statusSection(ChannelRegistration? reg) {
    final active = reg?.status == 'active';
    return ChannelSection(
      title: 'WhatsApp banking',
      caption: active
          ? 'Messages from your linked number are answered by LazerVault.'
          : 'Turn this on to bank from WhatsApp. We verify the number with a '
              'one-time code first.',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
            child: Row(
              children: [
                Text('Status',
                    style: GoogleFonts.inter(
                        color: ChannelScreenTheme.textMuted, fontSize: 12.5)),
                const Spacer(),
                ChannelStatusPill(status: reg?.status ?? 'none'),
              ],
            ),
          ),
          ChannelToggleTile(
            title: active ? 'Switched on' : 'Switch on WhatsApp banking',
            subtitle: active
                // This is now literally true — whatsapp-service checks the
                // channel registration on every inbound message.
                ? 'Switching this off stops WhatsApp from banking for you, '
                    'immediately.'
                : 'We send a one-time code to confirm the number is yours.',
            value: active,
            busy: _toggleBusy,
            onChanged: (on) => on ? _startActivation() : _confirmOff(),
          ),
        ],
      ),
    );
  }

  Widget _numberSection(ChannelRegistration? reg) {
    final linked = (reg?.phoneNumber ?? '').isNotEmpty;
    return ChannelSection(
      title: 'WhatsApp number',
      caption:
          'This can differ from your profile number — many people run WhatsApp '
          'on a second line. Only messages from this number are answered.',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
            child: Row(
              children: [
                const Icon(Icons.smartphone_rounded,
                    color: _whatsappGreen, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    linked
                        ? reg!.phoneNumber
                        : (_profilePhone.isEmpty
                            ? 'No number yet'
                            : '$_profilePhone (from your profile)'),
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: ChannelScreenTheme.border),
          _actionRow(
            icon: Icons.edit_outlined,
            label: linked ? 'Change WhatsApp number' : 'Set WhatsApp number',
            onTap: _startActivation,
          ),
        ],
      ),
    );
  }

  Widget _securitySection(ChannelRegistration? reg) {
    final hasPin = reg?.hasPin ?? false;
    return ChannelSection(
      title: 'Security',
      caption:
          'A channel PIN authorises money movements started from WhatsApp. It '
          'is separate from your app PIN.',
      child: Column(
        children: [
          _actionRow(
            icon: hasPin ? Icons.password_rounded : Icons.add_moderator_outlined,
            label: hasPin ? 'Change WhatsApp PIN' : 'Create WhatsApp PIN',
            trailing: hasPin
                ? const Icon(Icons.check_circle,
                    color: ChannelScreenTheme.success, size: 16)
                : null,
            onTap: () => Get.to(() => ChannelPinSetupScreen(
                  channelType: _channel,
                  isChange: hasPin,
                )),
          ),
        ],
      ),
    );
  }

  Widget _linkSection(ChannelRegistration? reg) {
    return ChannelSection(
      title: 'Account link',
      caption:
          'Registration proves the number is yours. Linking connects it to '
          'your LazerVault account so WhatsApp knows who is writing.',
      child: _actionRow(
        icon: Icons.link_rounded,
        label: 'Manage WhatsApp account link',
        onTap: () => Get.toNamed(AppRoutes.whatsappBanking),
      ),
    );
  }

  // ----------------------------------------------------------------- pieces

  Widget _actionRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Row(
          children: [
            Icon(icon, color: _whatsappGreen, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(label,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600)),
            ),
            if (trailing != null) ...[trailing, const SizedBox(width: 8)],
            const Icon(Icons.chevron_right_rounded,
                color: ChannelScreenTheme.textMuted, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _errorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChannelScreenTheme.danger.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(14),
        border:
            Border.all(color: ChannelScreenTheme.danger.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.error_outline,
                color: ChannelScreenTheme.danger, size: 18),
            const SizedBox(width: 8),
            Text("Couldn't load WhatsApp banking",
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600)),
          ]),
          const SizedBox(height: 6),
          Text(message,
              style: GoogleFonts.inter(
                  color: ChannelScreenTheme.textMuted, fontSize: 12)),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () =>
                context.read<ChannelManagementCubit>().loadChannels(),
            child: const Text('Try again'),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- actions

  Future<void> _startActivation() async {
    // The activation screen owns the OTP round-trip. It seeds the field from
    // the profile number and, for WhatsApp, leaves it editable.
    await Get.to(() => const ChannelActivationScreen(channelType: _channel));
    if (!mounted) return;
    context.read<ChannelManagementCubit>().loadChannels();
  }

  void _confirmOff() {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: ChannelScreenTheme.card,
        title: Text('Switch off WhatsApp banking?',
            style: GoogleFonts.inter(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
        content: Text(
          'LazerVault will stop answering messages from your WhatsApp number. '
          'Your account and money are unaffected, and you can switch it back '
          'on at any time.',
          style: GoogleFonts.inter(
              color: ChannelScreenTheme.textMuted, fontSize: 13, height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Keep it on'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              setState(() => _toggleBusy = true);
              context
                  .read<ChannelManagementCubit>()
                  .deactivateChannel(channelType: _channel);
            },
            child: const Text('Switch off',
                style: TextStyle(color: ChannelScreenTheme.danger)),
          ),
        ],
      ),
    );
  }

  void _snack(String message, Color colour) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: colour,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
