import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart'
    as card_entities;
import 'package:lazervault/core/types/app_routes.dart';

typedef CardEntity = card_entities.Card;

class CardsListScreen extends StatefulWidget {
  const CardsListScreen({super.key});

  @override
  State<CardsListScreen> createState() => _CardsListScreenState();
}

class _CardsListScreenState extends State<CardsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CardCubit>().getUserCards();
  }

  Future<void> _onRefresh() async {
    context.read<CardCubit>().getUserCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Cards',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.cardCreationForm),
        backgroundColor: const Color(0xFF3B82F6),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'New Card',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {
          if (state is CardError) {
            Get.snackbar(
              'Error',
              state.message,
              backgroundColor: const Color(0xFFEF4444),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
          }
        },
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF3B82F6),
              ),
            );
          }

          if (state is CardError) {
            return _buildErrorState(state.message);
          }

          if (state is CardsLoaded) {
            if (state.cards.isEmpty) {
              return _buildEmptyState();
            }
            return _buildCardsList(state.cards);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Color(0xFFEF4444),
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _onRefresh,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.credit_card_off,
                    color: Color(0xFF9CA3AF),
                    size: 80,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'No cards yet',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Create a virtual or disposable card\nto start making payments.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.cardCreationForm),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add_card),
                    label: const Text(
                      'Create Your First Card',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsList(List<CardEntity> cards) {
    final activeCount = cards.where((c) => c.isActive).length;
    final virtualCount = cards.where((c) => c.isVirtual).length;
    final disposableCount = cards.where((c) => c.isDisposable).length;

    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
        children: [
          _buildStatisticsRow(
            total: cards.length,
            active: activeCount,
            virtual: virtualCount,
            disposable: disposableCount,
          ),
          const SizedBox(height: 20),
          ...cards.map((card) => _buildCardItem(card)),
        ],
      ),
    );
  }

  Widget _buildStatisticsRow({
    required int total,
    required int active,
    required int virtual,
    required int disposable,
  }) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildStatBadge('Total', total, const Color(0xFF3B82F6)),
          const SizedBox(width: 10),
          _buildStatBadge('Active', active, const Color(0xFF10B981)),
          const SizedBox(width: 10),
          _buildStatBadge('Virtual', virtual, const Color(0xFFFB923C)),
          const SizedBox(width: 10),
          _buildStatBadge('Disposable', disposable, const Color(0xFF8B5CF6)),
        ],
      ),
    );
  }

  Widget _buildStatBadge(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$count',
            style: TextStyle(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color.withValues(alpha: 0.8),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardItem(CardEntity card) {
    final statusColor = _getStatusColor(card.status);
    final brandIcon = _getBrandIcon(card.brand);

    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.cardDetails,
        arguments: card.uuid,
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(
          children: [
            // Brand icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                brandIcon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            // Card info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          card.nickname ?? _formatCardType(card.type),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildCardTypeChip(card.type),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 \u2022\u2022\u2022\u2022 ${card.last4}',
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 14,
                      fontFamily: 'monospace',
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Exp: ${card.cardExpiry}',
                        style: const TextStyle(
                          color: Color(0xFF9CA3AF),
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _formatStatus(card.status),
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.chevron_right,
              color: Color(0xFF9CA3AF),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardTypeChip(card_entities.CardType cardType) {
    final color = cardType == card_entities.CardType.disposable
        ? const Color(0xFF8B5CF6)
        : const Color(0xFFFB923C);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        _formatCardType(cardType),
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getStatusColor(card_entities.CardStatus status) {
    switch (status) {
      case card_entities.CardStatus.active:
        return const Color(0xFF10B981);
      case card_entities.CardStatus.frozen:
        return const Color(0xFFFB923C);
      case card_entities.CardStatus.cancelled:
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  IconData _getBrandIcon(String brand) {
    switch (brand.toUpperCase()) {
      case 'VISA':
        return Icons.credit_card;
      case 'MASTERCARD':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  String _formatCardType(card_entities.CardType cardType) {
    switch (cardType) {
      case card_entities.CardType.virtual:
        return 'Virtual';
      case card_entities.CardType.disposable:
        return 'Disposable';
      case card_entities.CardType.permanent:
        return 'Permanent';
    }
  }

  String _formatStatus(card_entities.CardStatus status) {
    switch (status) {
      case card_entities.CardStatus.active:
        return 'Active';
      case card_entities.CardStatus.frozen:
        return 'Frozen';
      case card_entities.CardStatus.cancelled:
        return 'Cancelled';
      case card_entities.CardStatus.expired:
        return 'Expired';
    }
  }
}
