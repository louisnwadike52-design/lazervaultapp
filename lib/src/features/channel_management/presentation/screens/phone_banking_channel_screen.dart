import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/channel_management/cubit/channel_management_cubit.dart';
import 'package:lazervault/src/features/channel_management/cubit/channel_management_state.dart';
import 'package:lazervault/src/features/channel_management/domain/entities/channel_registration.dart';
import 'package:lazervault/src/features/channel_management/presentation/widgets/channel_screen_scaffold.dart';

import 'channel_activation_screen.dart';
import 'channel_pin_setup_screen.dart';

/// Phone Banking — call LazerVault and bank by voice. Its own Quick Service.
///
/// WHY THIS IS SEPARATE FROM WHATSAPP BANKING
/// ------------------------------------------
/// The number rule is the opposite one. Telephony is **pinned to the profile
/// number**: auth-service ignores whatever the client sends and forces
/// `user.Phone`, failing closed if it cannot read the profile. That is
/// deliberate — the caller ID IS the identity on a phone call, so the line that
/// can bank must be the line on the account. The field is therefore shown
/// read-only with the route to change it (edit your profile), not an editable
/// box that the server would reject.
///
/// Voice-recognition settings live here and only here: they describe how a
/// SPOKEN caller is verified, which has no meaning in a WhatsApp thread.
class PhoneBankingChannelScreen extends StatefulWidget {
  const PhoneBankingChannelScreen({super.key});

  @override
  State<PhoneBankingChannelScreen> createState() =>
      _PhoneBankingChannelScreenState();
}

class _PhoneBankingChannelScreenState extends State<PhoneBankingChannelScreen> {
  static const _channel = 'telephony';
  static const _accent = Color(0xFF4834D4);

  bool _toggleBusy = false;

  @override
  void initState() {
    super.initState();
    context.read<ChannelManagementCubit>().loadChannels();
  }

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
            _snack('Phone banking switched off.', ChannelScreenTheme.textMuted);
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
              const ChannelHeader(
                title: 'Phone Banking',
                subtitle: 'Call LazerVault and bank by voice',
                icon: Icons.phone_in_talk_rounded,
                accent: _accent,
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
                              _voiceSection(reg),
                              _securitySection(reg),
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
    final noProfileNumber = _profilePhone.isEmpty;
    return ChannelSection(
      title: 'Phone banking',
      caption: active
          ? 'Calls from your profile number reach the LazerVault voice agent.'
          : 'Turn this on to bank by calling us. We verify the line with a '
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
            title: active ? 'Switched on' : 'Switch on phone banking',
            subtitle: active
                ? 'Switching this off stops calls from banking for you.'
                : 'We send a one-time code to the number on your profile.',
            value: active,
            busy: _toggleBusy,
            // Without a profile number there is nothing to pin the channel to,
            // and the server would refuse the registration. Say that here
            // rather than letting them tap into a failure.
            enabled: !noProfileNumber || active,
            disabledReason:
                'Add a phone number to your profile first — phone banking '
                'always uses the number on your account.',
            onChanged: (on) => on ? _startActivation() : _confirmOff(),
          ),
        ],
      ),
    );
  }

  Widget _numberSection(ChannelRegistration? reg) {
    final shown = (reg?.phoneNumber ?? '').isNotEmpty
        ? reg!.phoneNumber
        : (_profilePhone.isEmpty ? 'No number on your profile' : _profilePhone);
    return ChannelSection(
      title: 'Your phone number',
      caption:
          'Phone banking always uses the number on your profile — on a call, '
          'the line you are calling from is the identity. To change it, update '
          'your profile.',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
        child: Row(
          children: [
            const Icon(Icons.lock_outline_rounded,
                color: ChannelScreenTheme.textMuted, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(shown,
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600)),
            ),
            Text('Pinned',
                style: GoogleFonts.inter(
                    color: ChannelScreenTheme.textMuted,
                    fontSize: 11,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _voiceSection(ChannelRegistration? reg) {
    final active = reg?.status == 'active';
    return ChannelSection(
      title: 'Voice recognition',
      caption:
          'How we confirm it is you on the call. These apply to phone banking '
          'only — they have no meaning in a WhatsApp thread.',
      child: Column(
        children: [
          _infoRow(
            icon: Icons.record_voice_over_outlined,
            title: 'Voice verification on calls',
            body: active
                ? 'Your enrolled voiceprint is checked during the call before '
                    'any money moves.'
                : 'Available once phone banking is switched on.',
          ),
          const Divider(height: 1, color: ChannelScreenTheme.border),
          _infoRow(
            icon: Icons.tune_rounded,
            title: 'Verification strictness',
            body:
                'Set by LazerVault and tuned centrally, so a stolen recording '
                'cannot pass by lowering your own threshold.',
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
          'A channel PIN authorises money movements started on a call. It is '
          'separate from your app PIN.',
      child: InkWell(
        onTap: () => Get.to(() => ChannelPinSetupScreen(
              channelType: _channel,
              isChange: hasPin,
            )),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Icon(
                  hasPin
                      ? Icons.password_rounded
                      : Icons.add_moderator_outlined,
                  color: _accent,
                  size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(hasPin ? 'Change phone PIN' : 'Create phone PIN',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600)),
              ),
              if (hasPin)
                const Icon(Icons.check_circle,
                    color: ChannelScreenTheme.success, size: 16),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right_rounded,
                  color: ChannelScreenTheme.textMuted, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- pieces

  Widget _infoRow(
      {required IconData icon, required String title, required String body}) {
    return Padding(
      padding: const EdgeInsets.all(14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: _accent, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 3),
                Text(body,
                    style: GoogleFonts.inter(
                        color: ChannelScreenTheme.textMuted,
                        fontSize: 11.5,
                        height: 1.35)),
              ],
            ),
          ),
        ],
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
            Text("Couldn't load phone banking",
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
    await Get.to(() => const ChannelActivationScreen(channelType: _channel));
    if (!mounted) return;
    context.read<ChannelManagementCubit>().loadChannels();
  }

  void _confirmOff() {
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        backgroundColor: ChannelScreenTheme.card,
        title: Text('Switch off phone banking?',
            style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700)),
        content: Text(
          'Calls from your number will no longer reach the LazerVault voice '
          'agent. Your account and money are unaffected, and you can switch it '
          'back on at any time.',
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
