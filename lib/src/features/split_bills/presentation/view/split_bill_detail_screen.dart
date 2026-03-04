import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../cubit/split_bill_cubit.dart';
import '../cubit/split_bill_state.dart';
import '../../domain/entities/split_bill_entity.dart';
import '../widgets/participant_row.dart';
import '../widgets/split_bill_progress_bar.dart';

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
      create: (_) =>
          GetIt.I<SplitBillCubit>()..loadBillDetail(splitBillId),
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
            Get.snackbar(
              'Cancelled',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.back();
          } else if (state is SplitBillShareDeclined) {
            Get.snackbar(
              'Declined',
              state.message,
              backgroundColor: const Color(0xFFFB923C),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            Get.back();
          } else if (state is SplitBillReminderSent) {
            Get.snackbar(
              'Reminder Sent',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
            // Reload detail to refresh state
            context.read<SplitBillCubit>().loadBillDetail(splitBillId);
          } else if (state is SplitBillError) {
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
          if (state is SplitBillLoading || state is SplitBillDetailLoading || state is SplitBillPaymentProcessing) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
              ),
            );
          }

          if (state is SplitBillDetailLoaded) {
            return _buildDetailContent(context, state.bill);
          }

          if (state is SplitBillError) {
            return _buildErrorContent(context, state.message);
          }

          return const Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailContent(BuildContext context, SplitBillEntity bill) {
    final currentUserId = _getCurrentUserId(context);
    final isCreator = currentUserId != null && bill.creatorId == currentUserId;
    final myParticipant = currentUserId != null
        ? bill.participantForUser(currentUserId)
        : null;
    final isParticipantPending = myParticipant != null && myParticipant.isPending;

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: () =>
                  context.read<SplitBillCubit>().loadBillDetail(splitBillId),
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderCard(bill),
                    const SizedBox(height: 20),
                    _buildProgressSection(bill),
                    const SizedBox(height: 20),
                    _buildParticipantsList(bill),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          if (bill.isActive)
            _buildActionBar(context, bill, isCreator, isParticipantPending,
                myParticipant),
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
          Text(
            bill.formattedTotal,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
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
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFF2D2D2D), thickness: 1),
          const SizedBox(height: 16),
          _buildInfoRow('Created by', bill.creatorName.isNotEmpty
              ? bill.creatorName
              : '@${bill.creatorUsername}'),
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

  Widget _buildProgressSection(SplitBillEntity bill) {
    final participantTotal = bill.totalAmount - bill.creatorShare;

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
          const Text(
            'Payment Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
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
    );
  }

  Widget _buildParticipantsList(SplitBillEntity bill) {
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
            'Participants (${bill.totalParticipants})',
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
                  backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  child: Text(
                    bill.creatorName.isNotEmpty
                        ? bill.creatorName[0].toUpperCase()
                        : '@',
                    style: const TextStyle(
                      color: Color(0xFF3B82F6),
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
                      const Text(
                        'Creator',
                        style: TextStyle(
                          color: Color(0xFF3B82F6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  bill.formattedTotal,
                  style: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Color(0xFF2D2D2D), height: 1),
          ...bill.participants.map(
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
            if (isCreator) ...[
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<SplitBillCubit>().sendReminder(splitBillId);
                      },
                      icon: const Icon(Icons.notifications_active, size: 18),
                      label: const Text(
                        'Send Reminder',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF3B82F6),
                        side: const BorderSide(color: Color(0xFF3B82F6)),
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
            ] else if (isParticipantPending && myParticipant != null) ...[
              Row(
                children: [
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
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
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
            ],
          ],
        ),
      ),
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
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 10),
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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: 48,
              color: Color(0xFFEF4444),
            ),
            const SizedBox(height: 16),
            const Text(
              'Failed to Load',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  context.read<SplitBillCubit>().loadBillDetail(splitBillId),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Retry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
