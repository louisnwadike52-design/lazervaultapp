import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/src/features/support/data/support_api.dart';
import 'package:lazervault/src/features/support/data/support_models.dart';
import 'package:lazervault/src/features/support/presentation/support_tickets_screen.dart';

/// Opens support from anywhere a customer can get stuck, and brings them back
/// to the thread they already have.
///
/// ## Why this is a shared helper and not a button on each screen
///
/// The identity flow can refuse in half a dozen places — an already-registered
/// BVN, a date of birth nobody can edit, a provider outage, a bank with no
/// contact details, a name the registry will not accept. Each of those screens
/// grew its own "Contact support" affordance, and they disagreed: some opened
/// a blank composer, some opened the ticket list, one opened Settings. The
/// customer's situation is identical in all of them.
///
/// ## Resume the thread, do not duplicate it
///
/// THE CASE THIS IS BUILT AROUND: someone blocked at KYC raises a ticket, is
/// told to wait, closes the app, signs back in days later, and meets the same
/// wall. If "Contact support" opens a fresh composer they file a second ticket
/// about the first one, support sees two threads from one person, and the
/// reply they are waiting for sits unread in the thread they were never shown.
///
/// So the destination depends on what they already have:
///   * an OPEN ticket  -> the tickets list, where it carries its unread badge
///                        and one tap opens the reply
///   * none            -> the composer, pre-filled with the refusal we already
///                        classified, so they do not have to describe it
///
/// Tickets key off the user id server-side and are reachable while Tier 1 and
/// un-minted (verified against production 2026-11-10: `GET /support/tickets`
/// answers 200 mid-onboarding), so this works at every resumption state —
/// before, during and after onboarding — and the same threads are there on the
/// dashboard afterwards.
class SupportContact {
  const SupportContact._();

  /// Open support for a refusal the customer cannot clear themselves.
  ///
  /// [subject]/[body] pre-fill a NEW ticket only; an existing open ticket is
  /// never overwritten with them.
  static Future<void> open({
    required String subject,
    required String body,
  }) async {
    List<SupportTicket> open = const [];
    try {
      final api = SupportApi(serviceLocator<SecureStorageService>());
      final all = await api.listTickets();
      open = all.where((t) => !t.isClosed).toList();
    } catch (_) {
      // Unreachable support API: fall through to the composer. Being unable to
      // LIST tickets must never stop someone RAISING one — that is the
      // failure mode this whole affordance exists to prevent.
    }
    await Get.to(() => SupportTicketsScreen(
          // Only seed the composer when there is nothing to come back to.
          composeSubject: open.isEmpty ? subject : null,
          composeMessage: open.isEmpty ? body : null,
        ));
  }

  /// Hand the customer off to email, for the address the operator published.
  ///
  /// Returns false when the device has no mail client, so the caller can say
  /// so instead of appearing to do nothing.
  static Future<bool> email(String address, {String? subject}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: address,
      query: (subject == null || subject.isEmpty)
          ? null
          // encodeComponent, not encodeFull: a subject legitimately contains
          // spaces and punctuation, and a raw '&' would otherwise start a new
          // query parameter.
          : 'subject=${Uri.encodeComponent(subject)}',
    );
    try {
      return await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      return false;
    }
  }
}

/// The "or email us at …" line, rendered only when an address is configured.
///
/// NOTHING IS HARDCODED HERE. [address] comes from support-service's
/// `support_contact_email` setting (see SupportApi.supportSettings), and a null
/// or empty value renders NOTHING — deliberately, because an address the
/// operator has not set is an address nobody has promised to read, and printing
/// one on a failure screen sends a stuck customer somewhere silent.
class SupportEmailLine extends StatelessWidget {
  const SupportEmailLine({
    super.key,
    required this.address,
    this.subject,
    this.color,
    this.linkColor,
  });

  final String? address;
  final String? subject;
  final Color? color;
  final Color? linkColor;

  @override
  Widget build(BuildContext context) {
    final addr = address?.trim() ?? '';
    if (addr.isEmpty) return const SizedBox.shrink();
    final base = color ?? Colors.black54;
    final link = linkColor ?? Theme.of(context).colorScheme.primary;
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'or email us at ',
            style: TextStyle(fontSize: 12.sp, color: base, height: 1.4),
          ),
          GestureDetector(
            onTap: () async {
              final ok = await SupportContact.email(addr, subject: subject);
              if (!ok) {
                // The address is still useful without a mail client — show it
                // rather than failing silently.
                Get.snackbar('Email us at', addr,
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
            child: Text(
              addr,
              style: TextStyle(
                fontSize: 12.sp,
                height: 1.4,
                color: link,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: link,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
