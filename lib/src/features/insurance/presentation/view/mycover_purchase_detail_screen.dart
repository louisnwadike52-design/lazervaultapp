import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';

class MyCoverPurchaseDetailScreen extends StatelessWidget {
  final MyCoverPurchase purchase;

  const MyCoverPurchaseDetailScreen({super.key, required this.purchase});

  @override
  Widget build(BuildContext context) {
    final p = purchase;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          p.productName.isNotEmpty ? p.productName : 'Purchase Details',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocListener<InsuranceCubit, InsuranceState>(
        listener: (context, state) {
          if (state is InsuranceRefundRequested) {
            Get.snackbar(
              'Refund Requested',
              'Refund for policy ${p.policyNumber} has been initiated. Status: ${state.refund.status}',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
              duration: const Duration(seconds: 4),
            );
          } else if (state is InsuranceError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.TOP,
            );
          }
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Status header
            Card(
              color: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        color: (p.policyIsActive
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444))
                            .withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        p.policyIsActive
                            ? Icons.verified
                            : Icons.cancel_outlined,
                        color: p.policyIsActive
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      p.policyIsActive ? 'Active Policy' : 'Inactive Policy',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\u20A6${p.amount}',
                      style: const TextStyle(
                          color: Color(0xFF3B82F6),
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    if (p.isRenewal) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFB923C)
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Renewal',
                            style: TextStyle(
                                color: Color(0xFFFB923C),
                                fontSize: 12,
                                fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Product info
            _buildSection('Product Information', [
              if (p.productName.isNotEmpty)
                _buildRow('Product', p.productName),
              if (p.productCategoryName.isNotEmpty)
                _buildRow('Category', p.productCategoryName),
              if (p.providerName.isNotEmpty)
                _buildRow('Provider', p.providerName),
              if (p.appMode.isNotEmpty) _buildRow('Mode', p.appMode),
            ]),
            const SizedBox(height: 16),
            // Policy info
            _buildSection('Policy Details', [
              if (p.policyNumber.isNotEmpty)
                _buildRow('Policy Number', p.policyNumber),
              if (p.policyAmount.isNotEmpty && p.policyAmount != '0')
                _buildRow('Policy Amount', '\u20A6${p.policyAmount}'),
              _buildRow('Status', p.policyIsActive ? 'Active' : 'Inactive'),
            ]),
            const SizedBox(height: 16),
            // Customer info
            if (p.customerName.isNotEmpty || p.customerEmail.isNotEmpty)
              _buildSection('Customer', [
                if (p.customerName.isNotEmpty)
                  _buildRow('Name', p.customerName),
                if (p.customerEmail.isNotEmpty)
                  _buildRow('Email', p.customerEmail),
                if (p.customerPhone.isNotEmpty)
                  _buildRow('Phone', p.customerPhone),
              ]),
            if (p.customerName.isNotEmpty || p.customerEmail.isNotEmpty)
              const SizedBox(height: 16),
            // Payment info
            _buildSection('Payment', [
              _buildRow('Amount', '\u20A6${p.amount}'),
              if (p.paymentChannel.isNotEmpty)
                _buildRow('Channel', p.paymentChannel),
              if (p.paymentOption.isNotEmpty)
                _buildRow('Option', p.paymentOption),
            ]),
            const SizedBox(height: 16),
            // Dates
            _buildSection('Dates', [
              if (p.createdAt.isNotEmpty)
                _buildRow('Created', _formatDate(p.createdAt)),
              if (p.updatedAt.isNotEmpty)
                _buildRow('Updated', _formatDate(p.updatedAt)),
            ]),
            // File claim button (for active policies)
            if (p.policyIsActive) ...[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(
                    AppRoutes.insuranceCreditLifeClaim,
                    arguments: {
                      'policyId': p.id,
                      'policyNumber': p.policyNumber,
                    },
                  ),
                  icon: const Icon(Icons.assignment_outlined, size: 18),
                  label: const Text('File a Claim',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFB923C),
                    side: const BorderSide(color: Color(0xFFFB923C)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
            // Cancel & Refund button (for active policies)
            if (p.policyIsActive && p.policyNumber.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<InsuranceCubit, InsuranceState>(
                  builder: (context, state) {
                    final isLoading = state is InsuranceLoading;
                    return OutlinedButton.icon(
                      onPressed: isLoading ? null : () => _showCancelRefundDialog(context, p),
                      icon: isLoading
                          ? const SizedBox(
                              width: 18, height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFEF4444)),
                            )
                          : const Icon(Icons.cancel_outlined, size: 18),
                      label: Text(
                        isLoading ? 'Processing...' : 'Cancel & Request Refund',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFFEF4444),
                        side: const BorderSide(color: Color(0xFFEF4444)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                ),
              ),
            ],
            // Check refund status (for inactive policies that might have a pending refund)
            if (!p.policyIsActive && p.policyNumber.isNotEmpty) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showRefundStatus(context, p.policyNumber),
                  icon: const Icon(Icons.info_outline, size: 18),
                  label: const Text('Check Refund Status',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF3B82F6),
                    side: const BorderSide(color: Color(0xFF3B82F6)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
            // Certificate download
            if (p.certificateUrl.isNotEmpty) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openCertificate(context, p.certificateUrl),
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text('Download Certificate',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _showCancelRefundDialog(BuildContext context, MyCoverPurchase purchase) {
    final reasonController = TextEditingController();
    bool isSubmitting = false;
    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Cancel Policy & Request Refund',
            style: TextStyle(color: Colors.white, fontSize: 16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'This will cancel policy ${purchase.policyNumber} and request a refund. This action cannot be undone.',
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              maxLines: 3,
              enabled: !isSubmitting,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Reason for cancellation (required)',
                hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                filled: true,
                fillColor: const Color(0xFF0A0A0A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF3B82F6)),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: isSubmitting ? null : () => Navigator.pop(dialogContext),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: isSubmitting ? null : () {
              final reason = reasonController.text.trim();
              if (reason.isEmpty) {
                Get.snackbar('Error', 'Please provide a reason for cancellation',
                    backgroundColor: const Color(0xFFEF4444), colorText: Colors.white);
                return;
              }
              setDialogState(() => isSubmitting = true);
              Navigator.pop(dialogContext);
              context.read<InsuranceCubit>().cancelPolicyAndRefund(
                policyReference: purchase.policyNumber,
                reason: reason,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: isSubmitting
                ? const SizedBox(
                    width: 16, height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Text('Confirm Cancel', style: TextStyle(color: Colors.white)),
          ),
        ],
        ),
      ),
    );
  }

  void _showRefundStatus(BuildContext context, String policyNumber) {
    final cubit = context.read<InsuranceCubit>();
    cubit.getInsuranceRefundStatus(policyNumber);
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<InsuranceCubit, InsuranceState>(
        builder: (context, state) {
          if (state is InsuranceRefundStatusLoaded) {
            final r = state.refund;
            Color statusColor;
            switch (r.status.toLowerCase()) {
              case 'completed':
                statusColor = const Color(0xFF10B981);
                break;
              case 'failed':
                statusColor = const Color(0xFFEF4444);
                break;
              case 'processing':
              case 'initiated':
                statusColor = const Color(0xFFFB923C);
                break;
              default:
                statusColor = const Color(0xFF9CA3AF);
            }
            return AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Refund Status', style: TextStyle(color: Colors.white, fontSize: 16)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      r.status.toUpperCase(),
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (r.amount > 0)
                    _buildStatusRow('Amount', '\u20A6${r.amount.toStringAsFixed(2)}'),
                  if (r.reason.isNotEmpty)
                    _buildStatusRow('Reason', r.reason),
                  _buildStatusRow('Provider Refunded', r.providerRefunded ? 'Yes' : 'No'),
                  _buildStatusRow('Wallet Credited', r.walletCredited ? 'Yes' : 'No'),
                  if (r.failureReason.isNotEmpty)
                    _buildStatusRow('Failure', r.failureReason),
                  if (r.initiatedAt.isNotEmpty)
                    _buildStatusRow('Initiated', _formatDate(r.initiatedAt)),
                  if (r.completedAt.isNotEmpty)
                    _buildStatusRow('Completed', _formatDate(r.completedAt)),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close', style: TextStyle(color: Color(0xFF3B82F6))),
                ),
              ],
            );
          }
          if (state is InsuranceError) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1F1F1F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: const Text('Refund Status', style: TextStyle(color: Colors.white, fontSize: 16)),
              content: Text(
                'No refund found for this policy, or an error occurred.',
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Close', style: TextStyle(color: Color(0xFF3B82F6))),
                ),
              ],
            );
          }
          return AlertDialog(
            backgroundColor: const Color(0xFF1F1F1F),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            content: const SizedBox(
              height: 60,
              child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6))),
            ),
          );
        },
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          const SizedBox(width: 12),
          Flexible(
            child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.end),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Color(0xFF3B82F6),
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF9CA3AF), fontSize: 13)),
          Flexible(
              child: Text(value,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 13),
                  textAlign: TextAlign.end)),
        ],
      ),
    );
  }

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year}';
    } catch (_) {
      return dateStr;
    }
  }

  Future<void> _openCertificate(BuildContext context, String url) async {
    try {
      final uri = Uri.tryParse(url);
      if (uri == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid certificate URL'), backgroundColor: Color(0xFFEF4444)),
          );
        }
        return;
      }
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open certificate'), backgroundColor: Color(0xFFEF4444)),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open certificate: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    }
  }
}
