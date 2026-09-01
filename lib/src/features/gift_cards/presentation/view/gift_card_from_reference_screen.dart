import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_cubit.dart';
import 'package:lazervault/src/features/gift_cards/cubit/gift_card_state.dart';
import 'package:lazervault/src/features/gift_cards/domain/entities/gift_card_entity.dart';

/// Bridges a TRANSACTION row to the real gift card.
///
/// Gift-card ledger rows carry no card id — only "Gift card purchase - GC-…"
/// in their description. Tapping one used to open the generic transfer receipt,
/// which cannot show the redemption code/PIN and shares the wrong PDF. This
/// screen resolves the card from that reference and replaces itself with the
/// card's own details screen, where the code, PIN and the gift-card receipt
/// PDF (download + share) already live.
class GiftCardFromReferenceScreen extends StatefulWidget {
  final String reference;

  const GiftCardFromReferenceScreen({super.key, required this.reference});

  @override
  State<GiftCardFromReferenceScreen> createState() =>
      _GiftCardFromReferenceScreenState();
}

class _GiftCardFromReferenceScreenState
    extends State<GiftCardFromReferenceScreen> {
  bool _resolved = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GiftCardCubit>().loadMyGiftCards();
    });
  }

  void _open(GiftCard card) {
    if (_resolved) return;
    _resolved = true;
    Get.offNamed(AppRoutes.giftCardDetails, arguments: card);
  }

  /// Not found (older card, different account, or a purchase still settling):
  /// land on My Gift Cards rather than a dead end.
  void _fallback() {
    if (_resolved) return;
    _resolved = true;
    Get.offNamed(AppRoutes.myGiftCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: BlocListener<GiftCardCubit, GiftCardState>(
        listener: (context, state) {
          if (state is MyGiftCardsLoaded) {
            final match = state.giftCards.where((c) =>
                c.reference == widget.reference ||
                c.id == widget.reference ||
                c.providerTransactionId == widget.reference);
            if (match.isNotEmpty) {
              _open(match.first);
            } else {
              _fallback();
            }
          } else if (state is GiftCardError ||
              state is GiftCardNetworkError ||
              state is GiftCardNotFound) {
            _fallback();
          }
        },
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LazerVaultLoader(),
                const SizedBox(height: 16),
                Text(
                  'Opening your gift card…',
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
