import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../../services/split_bill_pdf_service.dart';
import '../widgets/participant_row.dart';
import '../widgets/split_bill_progress_bar.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/shared_widgets/app_snackbar.dart';
import 'package:lazervault/core/shared_widgets/app_error_view.dart';
import 'package:lazervault/core/utils/friendly_error.dart';

class SplitBillDetailScreen extends StatelessWidget {
  const SplitBillDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final splitBillId = args['splitBillId'] as String? ?? '';

    if (splitBillId.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: const Center(
          child: Text(
            'Invalid split bill',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>()..loadBillDetail(splitBillId),
      child: _SplitBillDetailView(splitBillId: splitBillId),
    );
  }
}

class _SplitBillDetailView extends StatelessWidget {
  final String splitBillId;

  const _SplitBillDetailView({required this.splitBillId});

  String? _getCurrentUserId(BuildContext context) =>
      context.read<AuthenticationCubit>().userId;

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
        title: const Text(
          'Split Bill Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<SplitBillCubit, SplitBillState>(
        listener: (context, state) {
          if (state is SplitBillCancelled) {
            showAppSnackbar(
              'Cancelled',
              state.message,
              type: AppSnackbarType.success,
            );
            Get.back();
          } else if (state is SplitBillShareDeclined) {
            showAppSnackbar(
              'Declined',
              state.message,
              type: AppSnackbarType.info,
            );
            Get.back();
          } else if (state is SplitBillReminderSent) {
            showAppSnackbar(
              'Reminder Sent',
              state.message,
              type: AppSnackbarType.success,
            );
            // Reload detail to refresh state
            context.read<SplitBillCubit>().loadBillDetail(splitBillId);
          } else if (state is SplitBillError) {
            showAppSnackbar(
              'Error',
              state.message,
              type: AppSnackbarType.error,
            );
          }
        },
        builder: (context, state) {
          if (state is SplitBillLoading ||
              state is SplitBillDetailLoading ||
              state is SplitBillPaymentProcessing) {
            return const Center(
              child: LazerVaultLoader.small(),
            );
          }

          if (state is SplitBillDetailLoaded) {
            return _buildDetailContent(context, state.bill);
          }

          if (state is SplitBillError) {
            return _buildErrorContent(context, state.message);
          }

          return const Center(
            child: LazerVaultLoader.small(),
          );
        },
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, SplitBillEntity bill) {
    final currentUserId = _getCurrentUserId(context);
    final isCreator = currentUserId != null && bill.creatorId == currentUserId;
    final myParticipant =
        currentUserId != null ? bill.participantForUser(currentUserId) : null;
    final isParticipantPending =
        myParticipant != null && myParticipant.isPending;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<SplitBillCubit>().loadBillDetail(splitBillId),
              color: const Color(0xFF4834D4),
              backgroundColor: const Color(0xFF1F1F1F),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(bill),
                    const SizedBox(height: 20),
                    _buildProgressSection(context, bill),
                    const SizedBox(height: 20),
                    _buildParticipantsList(bill),
                    const SizedBox(height: 24),
                    // Organizer-only: share/download a full bill summary. Co-payers
                    // keep their own receipt path (see Pay My Share) untouched.
                    if (isCreator) ...[
                      _buildCreatorSummaryActions(context, bill),
                      const SizedBox(height: 24),
                    ],
                  ],
                ),
              ),
            ),
          ),
          if (bill.isActive)
            _buildActionBar(
                context, bill, isCreator, isParticipantPending, myParticipant),
        ],
      ),
    );
  }

  Widget _buildHeaderCard(SplitBillEntity bill) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        children: [
          // Title is the headline for the whole bill.
          Text(
            bill.displayTitle,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            bill.formattedTotal,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          if (bill.description.isNotEmpty)
            Text(
              bill.description,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2D2D2D), thickness: 1),
          const SizedBox(height: 16),
          _buildInfoRow(
              'Created by',
              bill.creatorName.isNotEmpty
                  ? bill.creatorName
                  : '@${bill.creatorUsername}'),
          const SizedBox(height: 10),
          _buildReceiverRow(bill),
          const SizedBox(height: 10),
          _buildInfoRow('Reference', bill.reference),
          const SizedBox(height: 10),
          _buildInfoRow('Split method', _splitMethodLabel(bill.splitMethod)),
          const SizedBox(height: 10),
          _buildInfoRow('Date', _formatDate(bill.createdAt)),
          const SizedBox(height: 10),
          _buildInfoRow('Status', _statusLabel(bill.status)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  /// "Paying to" row: shows WHO the receiver is with type-appropriate detail —
  /// the creator (self-collect), an internal Lazervault user, or an external
  /// bank account — plus a settlement-status chip for external receivers.
  Widget _buildReceiverRow(SplitBillEntity bill) {
    final IconData icon;
    final String primary;
    final String secondary;
    final String typeLabel;

    if (bill.hasExternalReceiver) {
      icon = Icons.account_balance_rounded;
      primary =
          bill.receiverName.isNotEmpty ? bill.receiverName : 'Bank account';
      // "Access Bank · •••• 1234" — the bank is what identifies WHERE the
      // money went; the last four digits alone do not. Falls back to just the
      // account for bills created before the bank name was captured.
      secondary = bill.receiverBankName.trim().isNotEmpty
          ? '${bill.receiverBankName.trim()} · ${bill.receiverAccountMasked}'
          : bill.receiverAccountMasked;
      typeLabel = 'External bank';
    } else if (bill.hasInternalReceiver) {
      icon = Icons.person_rounded;
      primary =
          bill.receiverName.isNotEmpty ? bill.receiverName : 'Lazervault user';
      // Backend masks the internal receiver as the display name; avoid repeating it —
      // the "Lazervault user" chip below already conveys the type.
      final masked = bill.receiverAccountMasked;
      secondary = (masked.isNotEmpty && masked != primary) ? masked : '';
      typeLabel = 'Lazervault user';
    } else {
      // Legacy / self-collect: the creator collects each share directly.
      icon = Icons.person_rounded;
      primary = bill.creatorName.isNotEmpty
          ? bill.creatorName
          : '@${bill.creatorUsername}';
      secondary = 'Collects directly';
      typeLabel = 'Organizer';
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Paying to',
          style: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 16),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 15, color: const Color(0xFF4834D4)),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      primary,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (secondary.isNotEmpty) ...[
                const SizedBox(height: 2),
                Text(
                  secondary,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF4834D4).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  typeLabel,
                  style: const TextStyle(
                    color: Color(0xFF8B7FE8),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (bill.hasExternalReceiver) ...[
                const SizedBox(height: 6),
                _buildSettlementChip(bill.settlementStatus),
              ],
            ],
          ),
        ),
      ],
    );
  }

  /// Maps the raw settlement status to a labelled, colour-coded chip.
  /// Returns an empty widget for not_applicable (no payout pipeline).
  Widget _buildSettlementChip(String status) {
    final (label, color) = switch (status) {
      'pending' => ('Collecting', const Color(0xFFFB923C)),
      'settling' => ('Paying out', const Color(0xFF4834D4)),
      'settled' => ('Settled', const Color(0xFF10B981)),
      'failed' => ('Refund failed', const Color(0xFFEF4444)),
      _ => ('', const Color(0xFF9CA3AF)),
    };
    if (label.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildProgressSection(BuildContext context, SplitBillEntity bill) {
    final participantTotal = bill.totalAmount - bill.creatorShare;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showWhoPaidSheet(context, bill),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF2D2D2D)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Payment Progress',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Tap to see who\'s paid',
                        style: TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.chevron_right,
                        color: Color(0xFF9CA3AF),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SplitBillProgressBar(
                paidCount: bill.paidCount,
                totalParticipants: bill.totalParticipants,
                paidAmount: bill.paidAmount,
                totalAmount: participantTotal,
                currency: bill.currency,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Collected: ${bill.formattedPaidAmount}',
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'Total: ${bill.formattedTotal}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// "Who's paid" modal: lists co-payers with their payment status, amount,
  /// and contextual tags ("(You)" for the current user, "Organizer" for the
  /// bill creator).
  void _showWhoPaidSheet(BuildContext context, SplitBillEntity bill) {
    final currentUserId = _getCurrentUserId(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (sheetContext) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(sheetContext).size.height * 0.75,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A1A),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Who\'s paid',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                bill.progressLabel,
                style: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Color(0xFF2D2D2D), height: 1),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  children: bill.participants
                      .map((p) => _buildWhoPaidRow(p, bill, currentUserId))
                      .toList(),
                ),
              ),
              SizedBox(height: MediaQuery.of(sheetContext).padding.bottom + 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWhoPaidRow(
    SplitBillParticipantEntity p,
    SplitBillEntity bill,
    String? currentUserId,
  ) {
    final (icon, statusColor, statusLabel) = switch (p.status) {
      SplitBillParticipantStatus.paid => (
          Icons.check_circle,
          const Color(0xFF10B981),
          p.paidAt != null ? 'Paid ${_formatDate(p.paidAt!)}' : 'Paid',
        ),
      SplitBillParticipantStatus.inProgress => (
          Icons.sync,
          const Color(0xFF4834D4),
          // A share can still be settling AFTER the bill itself closed
          // (external bank payouts confirm asynchronously) — say so instead of
          // a bare "in progress" on a completed/cancelled bill.
          bill.status == SplitBillStatus.active
              ? 'Payment in progress'
              : 'Payment settling — completes automatically',
        ),
      SplitBillParticipantStatus.pending => (
          Icons.schedule,
          const Color(0xFFFB923C),
          'Pending',
        ),
      SplitBillParticipantStatus.declined => (
          Icons.cancel,
          const Color(0xFFEF4444),
          'Declined',
        ),
    };
    final isYou = currentUserId != null && p.userId == currentUserId;

    final name = p.displayName.isNotEmpty ? p.displayName : '@${p.username}';

    // A paid payer's row opens their authoritative, bill-derived receipt.
    final canViewReceipt = p.isPaid;

    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: statusColor.withValues(alpha: 0.18),
            child: Icon(icon, size: 18, color: statusColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (isYou) _buildTag('You', const Color(0xFF4834D4)),
                    if (p.isCreator)
                      _buildTag('Organizer', const Color(0xFF9CA3AF)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  statusLabel,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            p.formattedAmount(bill.currency),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (canViewReceipt) ...[
            const SizedBox(width: 6),
            const Icon(Icons.receipt_long_outlined,
                size: 16, color: Color(0xFF6B7280)),
          ],
        ],
      ),
    );

    if (!canViewReceipt) return row;
    return InkWell(
      onTap: () => _openPayerReceipt(bill, p),
      borderRadius: BorderRadius.circular(8),
      child: row,
    );
  }

  /// Opens the bill-authoritative receipt for a specific payer, reading their
  /// real paidAt / reference / status / amount from the participant record.
  void _openPayerReceipt(SplitBillEntity bill, SplitBillParticipantEntity p) {
    Get.toNamed(
      AppRoutes.splitBillReceipt,
      arguments: {
        'bill': bill,
        'payerUserId': p.userId,
        // Viewing an existing payer's receipt — Done/back should return here,
        // NOT wipe the nav stack to the bills list (that's the post-payment flow).
        'viewOnly': true,
      },
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildParticipantsList(SplitBillEntity bill) {
    // If the creator included themselves as a co-payer, they have a participant
    // row (isCreator). Use it to show their real SHARE + payment status in the
    // Organizer row, and exclude it from the list below to avoid a duplicate.
    SplitBillParticipantEntity? creatorP;
    for (final p in bill.participants) {
      if (p.isCreator) {
        creatorP = p;
        break;
      }
    }
    final organizerAmount = creatorP != null
        ? creatorP.formattedAmount(bill.currency)
        : bill.formattedTotal;
    final organizerPaid = creatorP?.isPaid ?? false;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Co-payers (${bill.totalParticipants})',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          // Creator row
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor:
                      const Color(0xFF4834D4).withValues(alpha: 0.2),
                  child: Text(
                    bill.creatorName.isNotEmpty
                        ? bill.creatorName[0].toUpperCase()
                        : '@',
                    style: const TextStyle(
                      color: Color(0xFF4834D4),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bill.creatorName.isNotEmpty
                            ? bill.creatorName
                            : '@${bill.creatorUsername}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Organizer',
                            style: TextStyle(
                              color: Color(0xFF4834D4),
                              fontSize: 12,
                            ),
                          ),
                          if (creatorP != null) ...[
                            const Text(' · ',
                                style: TextStyle(color: Color(0xFF6B7280))),
                            Text(
                              organizerPaid ? 'Paid' : 'Pending',
                              style: TextStyle(
                                color: organizerPaid
                                    ? const Color(0xFF10B981)
                                    : const Color(0xFFFB923C),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
                Text(
                  organizerAmount,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          ...bill.participants.where((p) => !p.isCreator).map(
                (p) => Column(
                  children: [
                    ParticipantRow(participant: p, currency: bill.currency),
                    if (p.isPaid && p.transactionReference != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 52, bottom: 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ref: ${p.transactionReference}',
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  /// Organizer-only "Share summary" surface: generates a shareable PDF overview
  /// of the whole bill (receiver, total, per-participant breakdown, collection
  /// progress). Mirrors the co-payer receipt's Share/Download actions, but is a
  /// summary of the bill rather than a payment receipt.
  Widget _buildCreatorSummaryActions(
      BuildContext context, SplitBillEntity bill) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Share summary',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Send everyone an overview of who has paid and what is still owed.',
            style: TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _shareSummary(context, bill),
                  icon: const Icon(Icons.share, size: 18),
                  label: const Text(
                    'Share',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF4834D4)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _downloadSummary(bill),
                  icon: const Icon(Icons.download, size: 18),
                  label: const Text(
                    'Download',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Color(0xFF4834D4)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _shareSummary(BuildContext context, SplitBillEntity bill) async {
    try {
      final box = context.findRenderObject() as RenderBox?;
      final origin =
          box != null ? box.localToGlobal(Offset.zero) & box.size : null;
      await SplitBillPdfService.shareSummary(bill, sharePositionOrigin: origin);
    } catch (e) {
      showAppSnackbar(
        'Share Failed',
        friendlyError(e, context: 'share this summary'),
        type: AppSnackbarType.error,
      );
    }
  }

  Future<void> _downloadSummary(SplitBillEntity bill) async {
    try {
      final path = await SplitBillPdfService.downloadSummary(bill);
      showAppSnackbar(
        'Download Complete',
        'Summary saved to: ${path.split('/').last}',
        type: AppSnackbarType.success,
      );
    } catch (e) {
      showAppSnackbar(
        'Download Failed',
        friendlyError(e, context: 'download this summary'),
        type: AppSnackbarType.error,
      );
    }
  }

  Widget _buildActionBar(
    BuildContext context,
    SplitBillEntity bill,
    bool isCreator,
    bool isParticipantPending,
    SplitBillParticipantEntity? myParticipant,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF1F1F1F),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pay My Share — shown whenever the logged-in user is a PENDING
            // co-payer, INCLUDING when they are also the creator (self-included
            // as a co-payer). A creator has no "Decline" (they own the bill);
            // non-creator participants keep Decline + Pay.
            if (isParticipantPending && myParticipant != null) ...[
              Row(
                children: [
                  if (!isCreator) ...[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showDeclineConfirmation(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFFEF4444),
                          side: const BorderSide(color: Color(0xFFEF4444)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Decline',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    flex: isCreator ? 1 : 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(
                          AppRoutes.paySplitBill,
                          arguments: {
                            'splitBillId': bill.id,
                            'amount': myParticipant.amount,
                            'currency': bill.currency,
                            'creatorName': bill.creatorName.isNotEmpty
                                ? bill.creatorName
                                : '@${bill.creatorUsername}',
                            'receiverName':
                                bill.hasReceiver ? bill.receiverDisplay : '',
                            // The masked destination account travels with the
                            // name. Without it the receipt can only say "Paid
                            // to <name>", and for a bank payout the account is
                            // what the payer checks the money against.
                            'receiverAccountMasked': bill.hasExternalReceiver
                                ? bill.receiverAccountMasked
                                : '',
                            'receiverBankName': bill.hasExternalReceiver
                                ? bill.receiverBankName
                                : '',
                            'description': bill.description,
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Pay My Share (${myParticipant.formattedAmount(bill.currency)})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (isCreator) const SizedBox(height: 12),
            ],
            // Creator management actions (reminder + cancel) — shown for the
            // creator regardless of whether they're also a co-payer.
            if (isCreator) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showReminderSheet(context, bill),
                      icon: const Icon(Icons.notifications_active, size: 18),
                      label: const Text(
                        'Send Reminder',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF4834D4),
                        side: const BorderSide(color: Color(0xFF4834D4)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showCancelConfirmation(context),
                      icon: const Icon(Icons.cancel_outlined, size: 18),
                      label: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFEF4444),
                        side: const BorderSide(color: Color(0xFFEF4444)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Reminder flow: show the unpaid (pending) co-payers, all pre-selected, let the
  /// creator toggle who to remind, then send reminders only to the chosen subset.
  void _showReminderSheet(BuildContext context, SplitBillEntity bill) {
    final cubit = context.read<SplitBillCubit>();
    // Only strictly-pending co-payers are remindable (in_progress payments are
    // already on their way; paid/declined don't need a nudge).
    final remindable = bill.pendingParticipants;
    if (remindable.isEmpty) {
      // Distinguish "all done" from "the only unpaid shares are already being paid".
      final hasInProgress = bill.participants.any((p) => p.isInProgress);
      showAppSnackbar(
        hasInProgress ? 'Payments in progress' : 'Everyone is settled',
        hasInProgress
            ? 'The remaining shares are already being paid — no reminders needed.'
            : 'There is no one left to remind on this split bill.',
        type: AppSnackbarType.info,
      );
      return;
    }

    final selected = <String>{...remindable.map((p) => p.userId)};

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom +
                    MediaQuery.of(sheetContext).padding.bottom +
                    16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2D2D2D),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Send reminders',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Choose who to remind. Everyone is selected by default.',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: remindable.map((p) {
                          final name = p.displayName.isNotEmpty
                              ? p.displayName
                              : '@${p.username}';
                          final checked = selected.contains(p.userId);
                          return CheckboxListTile(
                            value: checked,
                            onChanged: (v) => setSheetState(() {
                              if (v == true) {
                                selected.add(p.userId);
                              } else {
                                selected.remove(p.userId);
                              }
                            }),
                            contentPadding: EdgeInsets.zero,
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: const Color(0xFF4834D4),
                            checkColor: Colors.white,
                            title: Text(name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                            subtitle: Text(
                              p.formattedAmount(bill.currency),
                              style: const TextStyle(
                                  color: Color(0xFF9CA3AF), fontSize: 12),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: selected.isEmpty
                          ? null
                          : () {
                              Navigator.pop(sheetContext);
                              cubit.sendReminder(
                                splitBillId,
                                participantUserIds: selected.toList(),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4834D4),
                        disabledBackgroundColor: const Color(0xFF2D2D2D),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        selected.isEmpty
                            ? 'Select at least one'
                            : 'Remind ${selected.length} ${selected.length == 1 ? 'person' : 'people'}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Cancel Split Bill?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'This will cancel the split bill for all participants. This action cannot be undone.',
          style: TextStyle(color: Color(0xFF9CA3AF)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'Keep',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<SplitBillCubit>().cancelBill(splitBillId);
            },
            child: const Text(
              'Cancel Bill',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeclineConfirmation(BuildContext context) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Decline Share?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Are you sure you want to decline your share of this split bill?',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLength: 100,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Reason (optional)',
                hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                counterStyle: const TextStyle(color: Color(0xFF6B7280)),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              reasonController.dispose();
              Navigator.pop(dialogContext);
            },
            child: const Text(
              'Go Back',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          TextButton(
            onPressed: () {
              final reason = reasonController.text.trim();
              reasonController.dispose();
              Navigator.pop(dialogContext);
              context.read<SplitBillCubit>().declineShare(
                    splitBillId,
                    reason: reason.isNotEmpty ? reason : null,
                  );
            },
            child: const Text(
              'Decline',
              style: TextStyle(color: Color(0xFFEF4444)),
            ),
          ),
        ],
      ),
    );
  }

  String _splitMethodLabel(SplitMethodType method) {
    return switch (method) {
      SplitMethodType.equal => 'Equal Split',
      SplitMethodType.custom => 'Custom Amounts',
      SplitMethodType.percentage => 'By Percentage',
    };
  }

  String _statusLabel(SplitBillStatus status) {
    return switch (status) {
      SplitBillStatus.active => 'Active',
      SplitBillStatus.completed => 'Completed',
      SplitBillStatus.cancelled => 'Cancelled',
      SplitBillStatus.expired => 'Expired',
    };
  }

  String _formatDate(DateTime dt) {
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    final hour = dt.hour.toString().padLeft(2, '0');
    final minute = dt.minute.toString().padLeft(2, '0');
    return '$day/$month/$year at $hour:$minute';
  }

  Widget _buildErrorContent(BuildContext context, String message) {
    return AppErrorView(
      error: message,
      context: 'load this split bill',
      onRetry: () => context.read<SplitBillCubit>().loadBillDetail(splitBillId),
    );
  }
}
