import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';
import 'mycover_claim_detail_screen.dart';

class MyCoverProviderClaimsScreen extends StatefulWidget {
  const MyCoverProviderClaimsScreen({super.key});

  @override
  State<MyCoverProviderClaimsScreen> createState() => _MyCoverProviderClaimsScreenState();
}

class _MyCoverProviderClaimsScreenState extends State<MyCoverProviderClaimsScreen> {
  String? _selectedStatus;
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverProviderClaims();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      final state = context.read<InsuranceCubit>().state;
      if (state is MyCoverProviderClaimsLoaded && state.hasMore) {
        _isLoadingMore = true;
        context.read<InsuranceCubit>().loadMyCoverProviderClaims(
          status: _selectedStatus,
          page: state.currentPage + 1,
        ).then((_) {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Provider Claims', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          _buildStatusFilter(),
          Expanded(
            child: BlocBuilder<InsuranceCubit, InsuranceState>(
              builder: (context, state) {
                if (state is InsuranceLoading) {
                  return const Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6)));
                }
                if (state is InsuranceError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.message, style: const TextStyle(color: Color(0xFF9CA3AF))),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () => context.read<InsuranceCubit>().loadMyCoverProviderClaims(status: _selectedStatus),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }
                if (state is MyCoverProviderClaimsLoaded) {
                  return RefreshIndicator(
                    onRefresh: () => context.read<InsuranceCubit>().loadMyCoverProviderClaims(status: _selectedStatus),
                    color: const Color(0xFF3B82F6),
                    backgroundColor: const Color(0xFF1F1F1F),
                    child: state.claims.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 200),
                              Center(child: Text('No claims found', style: TextStyle(color: Color(0xFF9CA3AF)))),
                            ],
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: state.claims.length + (state.hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= state.claims.length) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6), strokeWidth: 2)),
                                );
                              }
                              return _buildClaimCard(state.claims[index]);
                            },
                          ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    final statuses = ['All', 'pending', 'approved', 'rejected', 'settled'];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: statuses.map((status) {
            final isSelected = (status == 'All' && _selectedStatus == null) ||
                status == _selectedStatus;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(status[0].toUpperCase() + status.substring(1)),
                selected: isSelected,
                onSelected: (_) {
                  setState(() {
                    _selectedStatus = status == 'All' ? null : status;
                  });
                  context.read<InsuranceCubit>().loadMyCoverProviderClaims(status: _selectedStatus);
                },
                backgroundColor: const Color(0xFF1F1F1F),
                selectedColor: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                labelStyle: TextStyle(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF),
                  fontSize: 12,
                ),
                side: BorderSide(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildClaimCard(MyCoverProviderClaim claim) {
    Color statusColor;
    final statusLower = claim.status.toLowerCase();
    switch (statusLower) {
      case 'approved':
      case 'settled':
        statusColor = const Color(0xFF10B981);
        break;
      case 'rejected':
        statusColor = const Color(0xFFEF4444);
        break;
      case 'pending':
        statusColor = const Color(0xFFFB923C);
        break;
      default:
        statusColor = const Color(0xFF9CA3AF);
    }

    return GestureDetector(
      onTap: () => Get.to(() => MyCoverClaimDetailScreen(claim: claim)),
      child: Card(
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
                  Text(
                    claim.claimNumber.isNotEmpty ? claim.claimNumber : 'Claim',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      claim.status.toUpperCase(),
                      style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (claim.type.isNotEmpty)
                _buildInfoRow('Type', claim.type),
              _buildInfoRow('Amount', '\u20A6${claim.amount.toStringAsFixed(2)}'),
              if (claim.approvedAmount > 0)
                _buildInfoRow('Approved', '\u20A6${claim.approvedAmount.toStringAsFixed(2)}'),
              if (claim.description.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    claim.description,
                    style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              if (claim.rejectionReason.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Rejection: ${claim.rejectionReason}',
                    style: const TextStyle(color: Color(0xFFEF4444), fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
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
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
