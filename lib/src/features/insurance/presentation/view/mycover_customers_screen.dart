import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../cubit/insurance_cubit.dart';
import '../cubit/insurance_state.dart';
import '../../domain/entities/mycover_management_entities.dart';
import 'mycover_customer_detail_screen.dart';

class MyCoverCustomersScreen extends StatefulWidget {
  const MyCoverCustomersScreen({super.key});

  @override
  State<MyCoverCustomersScreen> createState() => _MyCoverCustomersScreenState();
}

class _MyCoverCustomersScreenState extends State<MyCoverCustomersScreen> {
  final _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    context.read<InsuranceCubit>().loadMyCoverCustomers();
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
      if (state is MyCoverCustomersLoaded && state.hasMore) {
        _isLoadingMore = true;
        context.read<InsuranceCubit>().loadMyCoverCustomers(page: state.currentPage + 1).then((_) {
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
        title: const Text('Insurance Customers', style: TextStyle(color: Colors.white)),
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
                    onPressed: () => context.read<InsuranceCubit>().loadMyCoverCustomers(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          if (state is MyCoverCustomersLoaded) {
            return RefreshIndicator(
              onRefresh: () => context.read<InsuranceCubit>().loadMyCoverCustomers(),
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: state.customers.isEmpty
                  ? ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 200),
                        Center(child: Text('No customers found', style: TextStyle(color: Color(0xFF9CA3AF)))),
                      ],
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: state.customers.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index >= state.customers.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator(color: Color(0xFF3B82F6), strokeWidth: 2)),
                          );
                        }
                        return _buildCustomerCard(state.customers[index]);
                      },
                    ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCustomerCard(MyCoverCustomer customer) {
    return Card(
      color: const Color(0xFF1F1F1F),
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.2),
          child: Text(
            customer.firstName.isNotEmpty ? customer.firstName[0].toUpperCase() : '?',
            style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          customer.fullName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (customer.email.isNotEmpty)
              Text(customer.email, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
            if (customer.phoneNumber.isNotEmpty)
              Text(customer.phoneNumber, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          ],
        ),
        trailing: const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
        onTap: () => Get.to(() => BlocProvider(
              create: (_) => serviceLocator<InsuranceCubit>(),
              child: MyCoverCustomerDetailScreen(
                customerId: customer.id,
                customerName: customer.fullName,
              ),
            )),
      ),
    );
  }
}
