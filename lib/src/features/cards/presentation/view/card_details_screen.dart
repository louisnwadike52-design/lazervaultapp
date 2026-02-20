import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:lazervault/src/features/cards/presentation/cubit/card_cubit.dart';
import 'package:lazervault/src/features/cards/presentation/cubit/card_state.dart';
import 'package:lazervault/src/features/cards/domain/entities/card_entity.dart'
    as card_entities;

typedef CardEntity = card_entities.Card;

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});

  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  late final String cardUuid;
  CardEntity? _revealedCard;

  @override
  void initState() {
    super.initState();
    cardUuid = Get.arguments as String;
    context.read<CardCubit>().getCardDetails(cardUuid: cardUuid);
  }

  void _refresh() {
    context.read<CardCubit>().getCardDetails(cardUuid: cardUuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Card Details',
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
      body: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {
          if (state is CardUpdated) {
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            _refresh();
          } else if (state is CardActionSuccess) {
            Get.snackbar(
              'Success',
              state.message,
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            Get.back();
          } else if (state is CardPINRevealed) {
            _showPINDialog(state.pin);
          } else if (state is CardDetailsRevealed) {
            setState(() {
              _revealedCard = state.card;
            });
          } else if (state is CardFunded) {
            Get.snackbar(
              'Success',
              'Card funded successfully',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            _refresh();
          } else if (state is CardWithdrawn) {
            Get.snackbar(
              'Success',
              'Withdrawal successful',
              backgroundColor: const Color(0xFF10B981),
              colorText: Colors.white,
              snackPosition: SnackPosition.BOTTOM,
            );
            _refresh();
          } else if (state is CardError) {
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

          if (state is CardDetailsLoaded) {
            return _buildDetailsContent(state.card);
          }

          if (state is CardError) {
            return Center(
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
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _refresh,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B82F6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildDetailsContent(CardEntity card) {
    final displayCard = (_revealedCard ?? card);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardVisual(displayCard),
          const SizedBox(height: 24),
          _buildActionButtonsGrid(card),
          const SizedBox(height: 24),
          _buildCardInfoSection(card),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────
  // Card Visual
  // ──────────────────────────────────────────────────

  Widget _buildCardVisual(CardEntity card) {
    final statusColor = _getStatusColor(card.status);
    final isRevealed = _revealedCard != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: brand + card type badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                card.brand.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatCardType(card.type),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Card number
          Center(
            child: Text(
              isRevealed
                  ? _formatFullCardNumber(card.cardNumber ?? '')
                  : '\u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  \u2022\u2022\u2022\u2022  ${card.last4}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
                fontFamily: 'monospace',
                letterSpacing: 3,
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Bottom row: holder, expiry, status
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'HOLDER',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.cardHolderName.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'EXPIRY',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.cardExpiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _formatStatus(card.status),
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          // CVV if revealed
          if (isRevealed && card.cvv != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'CVV  ',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                Text(
                  card.cvv!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────
  // Action Buttons Grid
  // ──────────────────────────────────────────────────

  Widget _buildActionButtonsGrid(CardEntity card) {
    final isFrozen = card.isFrozen;
    final isDisposable = card.isDisposable;
    final isCancelled = card.isCancelled;

    final actions = <_CardAction>[
      _CardAction(
        icon: isFrozen ? Icons.play_arrow : Icons.ac_unit,
        label: isFrozen ? 'Unfreeze' : 'Freeze',
        color: const Color(0xFFFB923C),
        onTap: isCancelled ? null : () => _onFreezeToggle(card),
      ),
      _CardAction(
        icon: Icons.star,
        label: 'Set as Default',
        color: const Color(0xFFFB923C),
        onTap: isCancelled ? null : () => _onSetDefault(card),
      ),
      _CardAction(
        icon: Icons.visibility,
        label: 'Reveal Details',
        color: const Color(0xFF3B82F6),
        onTap: isCancelled ? null : () => _onRevealDetails(card),
      ),
      _CardAction(
        icon: Icons.pin,
        label: 'Reveal PIN',
        color: const Color(0xFF3B82F6),
        onTap: isCancelled ? null : () => _onRevealPIN(card),
      ),
      _CardAction(
        icon: Icons.lock,
        label: 'Set/Change PIN',
        color: const Color(0xFF8B5CF6),
        onTap: isCancelled ? null : () => _showSetPINDialog(card),
      ),
      _CardAction(
        icon: Icons.add_card,
        label: 'Fund Card',
        color: const Color(0xFF10B981),
        onTap: isCancelled ? null : () => _showAmountDialog(card, isFunding: true),
      ),
      _CardAction(
        icon: Icons.money_off,
        label: 'Withdraw',
        color: const Color(0xFFFB923C),
        onTap: isCancelled ? null : () => _showAmountDialog(card, isFunding: false),
      ),
      _CardAction(
        icon: Icons.edit,
        label: 'Edit Nickname',
        color: const Color(0xFF9CA3AF),
        onTap: isCancelled ? null : () => _showEditNicknameDialog(card),
      ),
      if (isDisposable)
        _CardAction(
          icon: Icons.tune,
          label: 'Update Limit',
          color: const Color(0xFF3B82F6),
          onTap: isCancelled ? null : () => _showUpdateLimitDialog(card),
        ),
      _CardAction(
        icon: Icons.delete_forever,
        label: 'Cancel Card',
        color: const Color(0xFFEF4444),
        onTap: isCancelled ? null : () => _showCancelConfirmation(card),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.8,
      ),
      itemCount: actions.length,
      itemBuilder: (context, index) {
        final action = actions[index];
        final isDisabled = action.onTap == null;

        return GestureDetector(
          onTap: action.onTap,
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isDisabled
                    ? const Color(0xFF2D2D2D)
                    : action.color.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  action.icon,
                  color: isDisabled
                      ? const Color(0xFF9CA3AF).withValues(alpha: 0.4)
                      : action.color,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    action.label,
                    style: TextStyle(
                      color: isDisabled
                          ? const Color(0xFF9CA3AF).withValues(alpha: 0.4)
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ──────────────────────────────────────────────────
  // Card Info Section
  // ──────────────────────────────────────────────────

  Widget _buildCardInfoSection(CardEntity card) {
    final isDisposable = card.isDisposable;
    final currencyDisplay = card.currency ?? 'N/A';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Card Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          if (card.nickname != null && card.nickname!.isNotEmpty)
            _buildInfoRow('Nickname', card.nickname!),
          _buildInfoRow('Currency', currencyDisplay),
          _buildInfoRow('Status', _formatStatus(card.status)),
          if (isDisposable && card.spendingLimit != null)
            _buildInfoRow(
              'Spending Limit',
              _formatAmountDouble(card.spendingLimit!, currencyDisplay),
            ),
          if (isDisposable && card.remainingLimit != null)
            _buildInfoRow(
              'Remaining Limit',
              _formatAmountDouble(card.remainingLimit!, currencyDisplay),
            ),
          _buildInfoRow('Created', _formatDate(card.createdAt)),
          if (card.lastUsedAt != null)
            _buildInfoRow('Last Used', _formatDate(card.lastUsedAt!)),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9CA3AF),
              fontSize: 14,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────
  // Actions
  // ──────────────────────────────────────────────────

  void _onFreezeToggle(CardEntity card) {
    final isFrozen = card.isFrozen;
    if (isFrozen) {
      context.read<CardCubit>().unfreezeCard(cardUuid: card.uuid);
    } else {
      context.read<CardCubit>().freezeCard(cardUuid: card.uuid);
    }
  }

  void _onSetDefault(CardEntity card) {
    context.read<CardCubit>().setDefaultCard(cardUuid: card.uuid);
  }

  void _onRevealDetails(CardEntity card) {
    context.read<CardCubit>().revealFullCardDetails(cardUuid: card.uuid);
  }

  void _onRevealPIN(CardEntity card) {
    context.read<CardCubit>().revealCardPIN(cardUuid: card.uuid);
  }

  // ──────────────────────────────────────────────────
  // Dialogs
  // ──────────────────────────────────────────────────

  void _showPINDialog(String pin) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Card PIN',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Your card PIN is:',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2D2D),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                pin,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  letterSpacing: 8,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This PIN will be hidden when you close this dialog.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFFB923C), fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Close',
              style: TextStyle(color: Color(0xFF3B82F6)),
            ),
          ),
        ],
      ),
    );
  }

  void _showCancelConfirmation(CardEntity card) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Cancel Card',
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          'Are you sure you want to cancel this card? This action cannot be undone. '
          'Any remaining balance will be returned to your account.',
          style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Keep Card',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<CardCubit>().cancelCard(cardUuid: card.uuid);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Cancel Card'),
          ),
        ],
      ),
    );
  }

  void _showEditNicknameDialog(CardEntity card) {
    final controller = TextEditingController(text: card.nickname ?? '');

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Edit Nickname',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter card nickname',
            hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
            filled: true,
            fillColor: const Color(0xFF2D2D2D),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
          maxLength: 30,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final nickname = controller.text.trim();
              if (nickname.isNotEmpty) {
                Navigator.of(ctx).pop();
                context.read<CardCubit>().updateCardNickname(
                      cardUuid: card.uuid,
                      nickname: nickname,
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showAmountDialog(CardEntity card, {required bool isFunding}) {
    final controller = TextEditingController();
    final title = isFunding ? 'Fund Card' : 'Withdraw from Card';
    final buttonLabel = isFunding ? 'Fund' : 'Withdraw';
    final buttonColor =
        isFunding ? const Color(0xFF10B981) : const Color(0xFFFB923C);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter the amount in ${card.currency ?? ''}:',
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                ),
                prefixText: '${card.currency ?? ''} ',
                prefixStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final amountText = controller.text.trim();
              final amount = double.tryParse(amountText);
              if (amount != null && amount > 0) {
                Navigator.of(ctx).pop();
                final amountInMinorUnits = (amount * 100).roundToDouble();
                if (isFunding) {
                  context.read<CardCubit>().fundCard(
                        cardUuid: card.uuid,
                        amount: amountInMinorUnits,
                      );
                } else {
                  context.read<CardCubit>().withdrawFromCard(
                        cardUuid: card.uuid,
                        amount: amountInMinorUnits,
                      );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }

  void _showSetPINDialog(CardEntity card) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Set Card PIN',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a 4-digit PIN for your card:',
              style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              maxLength: 4,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(4),
              ],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: 16,
              ),
              decoration: InputDecoration(
                hintText: '\u2022\u2022\u2022\u2022',
                hintStyle: TextStyle(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                  fontSize: 28,
                  letterSpacing: 16,
                ),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final pin = controller.text.trim();
              if (pin.length == 4) {
                Navigator.of(ctx).pop();
                context.read<CardCubit>().setCardPIN(
                      cardUuid: card.uuid,
                      pin: pin,
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Set PIN'),
          ),
        ],
      ),
    );
  }

  void _showUpdateLimitDialog(CardEntity card) {
    final controller = TextEditingController(
      text: card.spendingLimit != null
          ? (card.spendingLimit! / 100).toStringAsFixed(2)
          : '',
    );

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Update Spending Limit',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set the new spending limit in ${card.currency ?? ''}:',
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              decoration: InputDecoration(
                hintText: '0.00',
                hintStyle: TextStyle(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                ),
                prefixText: '${card.currency ?? ''} ',
                prefixStyle: const TextStyle(
                  color: Color(0xFF9CA3AF),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                filled: true,
                fillColor: const Color(0xFF2D2D2D),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF9CA3AF)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final limitText = controller.text.trim();
              final limit = double.tryParse(limitText);
              if (limit != null && limit > 0) {
                Navigator.of(ctx).pop();
                final limitInMinorUnits = (limit * 100).roundToDouble();
                context.read<CardCubit>().updateCardSpendingLimit(
                      cardUuid: card.uuid,
                      newLimit: limitInMinorUnits,
                    );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // ──────────────────────────────────────────────────
  // Helpers
  // ──────────────────────────────────────────────────

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

  String _formatFullCardNumber(String number) {
    final cleaned = number.replaceAll(RegExp(r'\s'), '');
    final buffer = StringBuffer();
    for (var i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write('  ');
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  String _formatAmount(int amountInMinorUnits, String currency) {
    final major = (amountInMinorUnits / 100).toStringAsFixed(2);
    return '$currency $major';
  }

  String _formatAmountDouble(double amount, String currency) {
    return '$currency ${amount.toStringAsFixed(2)}';
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year;
    return '$day/$month/$year';
  }
}

// ──────────────────────────────────────────────────
// Internal model for action buttons
// ──────────────────────────────────────────────────

class _CardAction {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _CardAction({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });
}
