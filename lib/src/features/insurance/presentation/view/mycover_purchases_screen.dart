import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';
import 'mycover_purchase_detail_screen.dart';

class MyCoverPurchasesScreen extends StatefulWidget {
  const MyCoverPurchasesScreen({super.key});

  @override
  State<MyCoverPurchasesScreen> createState() => _MyCoverPurchasesScreenState();
}

class _MyCoverPurchasesScreenState extends State<MyCoverPurchasesScreen> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverPurchases();
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
      if (state is MyCoverPurchasesLoaded && state.hasMore) {
        _isLoadingMore = true;
        context.read<InsuranceCubit>().loadMyCoverPurchases(page: state.currentPage + 1).then((_) {
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
        title: const Text('Insurance Purchases', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<InsuranceCubit, InsuranceState>(
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
                    onPressed: () => context.read<InsuranceCubit>().loadMyCoverPurchases(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is MyCoverPurchasesLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<InsuranceCubit>().loadMyCoverPurchases(),
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: state.purchases.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text('No purchases found', style: TextStyle(color: Color(0xFF9CA3AF)))),
                      ],
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: state.purchases.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.purchases.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6), strokeWidth: 2)),
                          );
                        }
                        return _buildPurchaseCard(state.purchases[index]);
                      },
                    ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPurchaseCard(MyCoverPurchase purchase) {
    return GestureDetector(
      onTap: () => Get.to(() => BlocProvider(
            create: (_) => serviceLocator<InsuranceCubit>(),
            child: MyCoverPurchaseDetailScreen(purchase: purchase),
          )),
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
                Expanded(
                  child: Text(
                    purchase.productName.isNotEmpty ? purchase.productName : 'Insurance Purchase',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: purchase.policyIsActive
                        ? const Color(0xFF10B981).withValues(alpha: 0.2)
                        : const Color(0xFFEF4444).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    purchase.policyIsActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: purchase.policyIsActive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (purchase.providerName.isNotEmpty)
              _buildInfoRow('Provider', purchase.providerName),
            if (purchase.customerName.isNotEmpty)
              _buildInfoRow('Customer', purchase.customerName),
            if (purchase.policyNumber.isNotEmpty)
              _buildInfoRow('Policy #', purchase.policyNumber),
            _buildInfoRow('Amount', '\u20A6${purchase.amount}'),
            if (purchase.productCategoryName.isNotEmpty)
              _buildInfoRow('Category', purchase.productCategoryName),
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
