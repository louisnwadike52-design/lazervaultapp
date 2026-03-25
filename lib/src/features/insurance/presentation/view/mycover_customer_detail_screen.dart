import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';

class MyCoverCustomerDetailScreen extends StatefulWidget {
  final String customerId;
  final String customerName;

  const MyCoverCustomerDetailScreen({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  State<MyCoverCustomerDetailScreen> createState() =>
      _MyCoverCustomerDetailScreenState();
}

class _MyCoverCustomerDetailScreenState
    extends State<MyCoverCustomerDetailScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverCustomerDetail(widget.customerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.customerName,
            style: const TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<InsuranceCubit, InsuranceState>(
        builder: (context, state) {
          if (state is InsuranceLoading) {
            return const Center(
                child:
                    CircularProgressIndicator(color: Color(0xFF3B82F6)));
          }
          if (state is InsuranceError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message,
                      style:
                          const TextStyle(color: Color(0xFF9CA3AF))),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context
                        .read<InsuranceCubit>()
                        .loadMyCoverCustomerDetail(widget.customerId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is MyCoverCustomerDetailLoaded) {
            return RefreshIndicator(
              onRefresh: () => context
                  .read<InsuranceCubit>()
                  .loadMyCoverCustomerDetail(widget.customerId),
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCustomerInfo(state.customer),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                      'Policies (${state.policies.length})'),
                  const SizedBox(height: 12),
                  if (state.policies.isEmpty)
                    _buildEmptyCard('No policies found')
                  else
                    ...state.policies.map(_buildPolicyCard),
                  const SizedBox(height: 24),
                  _buildSectionTitle(
                      'Purchases (${state.purchases.length})'),
                  const SizedBox(height: 12),
                  if (state.purchases.isEmpty)
                    _buildEmptyCard('No purchases found')
                  else
                    ...state.purchases.map(_buildPurchaseCard),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCustomerInfo(MyCoverCustomer customer) {
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      const Color(0xFF3B82F6).withValues(alpha: 0.2),
                  child: Text(
                    customer.firstName.isNotEmpty
                        ? customer.firstName[0].toUpperCase()
                        : '?',
                    style: const TextStyle(
                        color: Color(0xFF3B82F6),
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(customer.fullName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18)),
                      if (customer.gender.isNotEmpty)
                        Text(customer.gender,
                            style: const TextStyle(
                                color: Color(0xFF9CA3AF),
                                fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2D2D2D)),
            const SizedBox(height: 12),
            if (customer.email.isNotEmpty)
              _buildDetailRow(Icons.email_outlined, customer.email),
            if (customer.phoneNumber.isNotEmpty)
              _buildDetailRow(
                  Icons.phone_outlined, customer.phoneNumber),
            if (customer.dateOfBirth.isNotEmpty)
              _buildDetailRow(
                  Icons.cake_outlined, customer.dateOfBirth),
            if (customer.createdAt.isNotEmpty)
              _buildDetailRow(Icons.calendar_today_outlined,
                  'Joined: ${_formatDate(customer.createdAt)}'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF9CA3AF), size: 18),
          const SizedBox(width: 12),
          Expanded(
              child: Text(text,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600));
  }

  Widget _buildEmptyCard(String message) {
    return Card(
      color: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
            child: Text(message,
                style:
                    const TextStyle(color: Color(0xFF9CA3AF)))),
      ),
    );
  }

  Widget _buildPolicyCard(MyCoverPolicyDetail policy) {
    return Card(
      color: const Color(0xFF1F1F1F),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    policy.productName.isNotEmpty
                        ? policy.productName
                        : 'Policy',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: policy.isActive
                        ? const Color(0xFF10B981)
                            .withValues(alpha: 0.2)
                        : const Color(0xFFEF4444)
                            .withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    policy.isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: policy.isActive
                          ? const Color(0xFF10B981)
                          : const Color(0xFFEF4444),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (policy.policyNumber.isNotEmpty)
              _buildInfoRow('Policy #', policy.policyNumber),
            if (policy.providerName.isNotEmpty)
              _buildInfoRow('Provider', policy.providerName),
            if (policy.amount.isNotEmpty && policy.amount != '0')
              _buildInfoRow('Amount', '\u20A6${policy.amount}'),
            if (policy.startDate.isNotEmpty)
              _buildInfoRow(
                  'Start', _formatDate(policy.startDate)),
            if (policy.expirationDate.isNotEmpty)
              _buildInfoRow(
                  'Expires', _formatDate(policy.expirationDate)),
            if (policy.isActive) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => Get.toNamed(
                    AppRoutes.insuranceCreditLifeClaim,
                    arguments: {
                      'policyId': policy.id,
                      'policyNumber': policy.policyNumber,
                    },
                  ),
                  icon: const Icon(Icons.assignment_outlined, size: 16),
                  label: const Text('File Claim', style: TextStyle(fontSize: 12)),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFFFB923C),
                    side: const BorderSide(color: Color(0xFFFB923C)),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseCard(MyCoverPurchase purchase) {
    return Card(
      color: const Color(0xFF1F1F1F),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              purchase.productName.isNotEmpty
                  ? purchase.productName
                  : 'Purchase',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _buildInfoRow('Amount', '\u20A6${purchase.amount}'),
            if (purchase.providerName.isNotEmpty)
              _buildInfoRow('Provider', purchase.providerName),
            if (purchase.productCategoryName.isNotEmpty)
              _buildInfoRow(
                  'Category', purchase.productCategoryName),
            if (purchase.createdAt.isNotEmpty)
              _buildInfoRow(
                  'Date', _formatDate(purchase.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Color(0xFF9CA3AF), fontSize: 12)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white, fontSize: 12)),
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
}
