import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/core/services/help_config_service.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';

/// Help & Support Tab - Get help with this account
class HelpTab extends StatefulWidget {
  const HelpTab({super.key});

  @override
  State<HelpTab> createState() => _HelpTabState();
}

class _HelpTabState extends State<HelpTab> {
  // Admin-configured support contact, sourced from system_settings (help_* keys)
  // via HelpConfigService. Starts at the cached/fallback value and refreshes.
  HelpConfig _help = HelpConfigService.instance.config;

  @override
  void initState() {
    super.initState();
    HelpConfigService.instance.ensure().then((cfg) {
      if (mounted) setState(() => _help = cfg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Support options
          Text(
            'Support',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildHelpOption(
            context,
            icon: Icons.support_agent_outlined,
            title: 'Get help with this account',
            subtitle: 'Chat with our team or report a problem',
            trailing: 'Chat →',
            onTap: () => _onGetHelp(context),
          ),
          SizedBox(height: 12.h),

          _buildHelpOption(
            context,
            icon: Icons.inbox_outlined,
            title: 'Your support tickets',
            subtitle: 'View replies and past conversations',
            trailing: 'View →',
            // Push on top of the account sheet (don't close it) so the
            // system back returns the user to the sheet they came from.
            onTap: () => Get.to(() => const SupportTicketsScreen()),
          ),
          SizedBox(height: 24.h),

          // FAQ Section
          Text(
            'Frequently Asked Questions',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),

          _buildFAQItem(
            'How do I freeze this account?',
            'Open the "Controls" tab and turn on "Freeze account". While frozen, no money can leave the account — incoming money still arrives. Turn it off anytime to resume sending.',
          ),
          SizedBox(height: 12.h),

          _buildFAQItem(
            'How do spending limits work?',
            'Set daily, monthly and per-transaction limits in the "Limits" tab. They apply to money you send from this account, and take effect immediately.',
          ),
          SizedBox(height: 12.h),

          _buildFAQItem(
            'Why can\'t I send money abroad?',
            'International transfers may be turned off for this account. Open the "Controls" tab and turn on "Allow international transfers" to send money abroad.',
          ),
          SizedBox(height: 32.h),

          // Contact info — all values sourced from the admin dashboard
          // (system_settings help_* keys). Each row renders only when its value
          // is set; the whole card is hidden when there's no contact channel.
          if (_help.hasAnyContact) _buildContactCard(),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.headset_mic_outlined,
                  color: const Color(0xFF3B82F6), size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                _help.supportHours.isNotEmpty ? _help.supportHours : 'Support',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (_help.contactPhone.isNotEmpty) ...[
            SizedBox(height: 10.h),
            _contactRow(
              icon: Icons.call_outlined,
              label: 'Call ${_help.contactPhone}',
              onTap: () => _launch('tel:${_help.contactPhone}'),
            ),
          ],
          if (_help.contactWhatsapp.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _contactRow(
              icon: Icons.chat_outlined,
              label: 'WhatsApp ${_help.contactWhatsapp}',
              onTap: () => _launch(
                  'https://wa.me/${_help.contactWhatsapp.replaceAll(RegExp(r'[^0-9]'), '')}'),
            ),
          ],
          if (_help.contactEmail.isNotEmpty) ...[
            SizedBox(height: 8.h),
            _contactRow(
              icon: Icons.mail_outline,
              label: _help.contactEmail,
              onTap: () => _launch('mailto:${_help.contactEmail}'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _contactRow({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launch(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildHelpOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required String trailing,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  icon,
                  color: const Color(0xFF3B82F6),
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                trailing,
                style: TextStyle(
                  color: const Color(0xFF3B82F6),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    'Q',
                    style: TextStyle(
                      color: const Color(0xFF3B82F6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Text(
              answer,
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onGetHelp(BuildContext context) {
    // Land on the ticket hub — the single entry point for creating a new ticket
    // (with its own ticket ID) or opening an existing conversation. Pushed over
    // the account sheet so back returns to it.
    Get.to(() => const SupportTicketsScreen());
  }
}
