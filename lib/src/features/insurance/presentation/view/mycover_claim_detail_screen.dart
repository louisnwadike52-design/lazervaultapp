import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/mycover_management_entities.dart';

class MyCoverClaimDetailScreen extends StatelessWidget {
  final MyCoverProviderClaim claim;

  const MyCoverClaimDetailScreen({super.key, required this.claim});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          claim.claimNumber.isNotEmpty
              ? claim.claimNumber
              : 'Claim Details',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Status header
          _buildStatusHeader(),
          const SizedBox(height: 16),
          // Claim details
          _buildSection('Claim Information', [
            if (claim.claimNumber.isNotEmpty)
              _buildRow('Claim Number', claim.claimNumber),
            if (claim.type.isNotEmpty) _buildRow('Type', claim.type),
            _buildRow(
                'Amount', '\u20A6${claim.amount.toStringAsFixed(2)}'),
            if (claim.approvedAmount > 0)
              _buildRow('Approved Amount',
                  '\u20A6${claim.approvedAmount.toStringAsFixed(2)}'),
          ]),
          const SizedBox(height: 16),
          // Description
          if (claim.description.isNotEmpty)
            _buildSection('Description', [
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(claim.description,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14)),
              ),
            ]),
          if (claim.description.isNotEmpty) const SizedBox(height: 16),
          // Rejection reason
          if (claim.rejectionReason.isNotEmpty) ...[
            Card(
              color:
                  const Color(0xFFEF4444).withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.warning_amber,
                            color: Color(0xFFEF4444), size: 18),
                        SizedBox(width: 8),
                        Text('Rejection Reason',
                            style: TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 13,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(claim.rejectionReason,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
          // Documents
          if (claim.documents.isNotEmpty) ...[
            _buildSection('Documents (${claim.documents.length})', [
              ...claim.documents.map((doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: InkWell(
                      onTap: () => _openDocument(context, doc),
                      child: Row(
                        children: [
                          const Icon(Icons.attachment,
                              color: Color(0xFF3B82F6), size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              doc,
                              style: const TextStyle(
                                  color: Color(0xFF3B82F6),
                                  fontSize: 13,
                                  decoration:
                                      TextDecoration.underline),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ]),
            const SizedBox(height: 16),
          ],
          // Dates
          _buildSection('Timeline', [
            if (claim.createdAt.isNotEmpty)
              _buildRow('Filed', _formatDate(claim.createdAt)),
            if (claim.updatedAt.isNotEmpty)
              _buildRow(
                  'Last Updated', _formatDate(claim.updatedAt)),
          ]),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatusHeader() {
    Color statusColor;
    IconData statusIcon;
    switch (claim.status.toLowerCase()) {
      case 'approved':
        statusColor = const Color(0xFF10B981);
        statusIcon = Icons.check_circle;
        break;
      case 'settled':
        statusColor = const Color(0xFF10B981);
        statusIcon = Icons.payments;
        break;
      case 'rejected':
        statusColor = const Color(0xFFEF4444);
        statusIcon = Icons.cancel;
        break;
      case 'pending':
        statusColor = const Color(0xFFFB923C);
        statusIcon = Icons.pending;
        break;
      default:
        statusColor = const Color(0xFF9CA3AF);
        statusIcon = Icons.info_outline;
    }

    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(statusIcon, color: statusColor, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              claim.status.toUpperCase(),
              style: TextStyle(
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              '\u20A6${claim.amount.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24),
            ),
          ],
        ),
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

  Future<void> _openDocument(BuildContext context, String docUrl) async {
    try {
      final uri = Uri.tryParse(docUrl);
      if (uri == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid document URL'), backgroundColor: Color(0xFFEF4444)),
          );
        }
        return;
      }
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Could not open document'), backgroundColor: Color(0xFFEF4444)),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to open document: $e'), backgroundColor: const Color(0xFFEF4444)),
        );
      }
    }
  }
}
