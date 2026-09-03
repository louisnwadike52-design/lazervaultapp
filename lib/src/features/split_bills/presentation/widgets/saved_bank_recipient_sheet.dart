import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';

/// Picks a saved EXTERNAL bank recipient for a split bill's receiver.
///
/// Replaces a unified-search sheet that only queried on two or more typed
/// characters, so it opened blank: the button said "Choose from saved
/// recipients" and then showed nothing until you typed the name of a recipient
/// you were opening the sheet to be reminded of.
///
/// This loads the saved list on open and filters it locally as you type. Local
/// filtering is deliberate — the list is already in memory, so matching is
/// instant and works with no connection, and there is no debounce to fight.
///
/// Only bank recipients are offered. A saved LazerVault user belongs to the
/// "Lazervault user" receiver mode, and showing one here would let someone
/// pick a recipient the split-bill receiver cannot actually be.
class SavedBankRecipientSheet extends StatefulWidget {
  const SavedBankRecipientSheet({super.key});

  static Future<RecipientModel?> show(BuildContext context) {
    return showModalBottomSheet<RecipientModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const SavedBankRecipientSheet(),
    );
  }

  @override
  State<SavedBankRecipientSheet> createState() =>
      _SavedBankRecipientSheetState();
}

class _SavedBankRecipientSheetState extends State<SavedBankRecipientSheet> {
  late final RecipientCubit _cubit;
  final TextEditingController _search = TextEditingController();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _cubit = serviceLocator<RecipientCubit>();
    // Load immediately: the whole point of this sheet is to show what is
    // already saved without being asked twice.
    //
    // The token is read here rather than passed in, so no call site can supply
    // a stale one. Post-frame because the sheet's own context is not usable
    // for a read() until it is mounted.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final auth = context.read<AuthenticationCubit>().state;
      final token = switch (auth) {
        AuthenticationSuccess s => s.profile.session.accessToken,
        AuthenticationAuthenticated s => s.profile.session.accessToken,
        _ => null,
      };
      if (token == null || token.isEmpty) {
        // Signed out mid-flow. Leave the list empty rather than firing an
        // unauthenticated call; the account-number path still works.
        return;
      }
      final locale = serviceLocator<LocaleManager>();
      _cubit.getRecipients(
        accessToken: token,
        countryCode: locale.currentCountry,
        currency: locale.currentCurrency,
      );
    });
  }

  @override
  void dispose() {
    _search.dispose();
    _cubit.close();
    super.dispose();
  }

  /// A recipient usable as a split-bill receiver: an external bank account with
  /// a 10-digit NUBAN. Anything else would fail verification downstream, so it
  /// is filtered here rather than offered and then rejected.
  bool _isBankRecipient(RecipientModel r) {
    final acct = r.accountNumber.trim();
    return acct.length == 10 && int.tryParse(acct) != null;
  }

  bool _matches(RecipientModel r) {
    if (_query.isEmpty) return true;
    final q = _query.toLowerCase();
    return r.name.toLowerCase().contains(q) ||
        r.accountNumber.contains(q) ||
        r.displayBankName.toLowerCase().contains(q) ||
        (r.alias ?? '').toLowerCase().contains(q);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RecipientCubit>.value(
      value: _cubit,
      // The white surface reaches the physical edge with the inset inside it;
      // a SafeArea wrapped outside leaves a band of scrim under the sheet.
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF141414),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2D2D),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Saved bank recipients',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: TextField(
                  controller: _search,
                  onChanged: (v) => setState(() => _query = v.trim()),
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search name, bank or account number',
                    hintStyle: const TextStyle(color: Color(0xFF6B7280)),
                    prefixIcon:
                        const Icon(Icons.search, color: Color(0xFF6B7280)),
                    filled: true,
                    fillColor: const Color(0xFF1F1F1F),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFF4834D4)),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: BlocBuilder<RecipientCubit, RecipientState>(
                  builder: (context, state) {
                    if (state is RecipientLoading ||
                        state is RecipientInitial) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40),
                        child: Center(child: LazerVaultLoader(size: 24)),
                      );
                    }
                    if (state is RecipientError) {
                      return _message(
                        'Could not load your saved recipients.',
                        // Failing here must not dead-end the flow: the account
                        // number path below still works without this list.
                        'Enter the account number instead, or try again.',
                      );
                    }
                    final all = state is RecipientLoaded
                        ? state.recipients.where(_isBankRecipient).toList()
                        : <RecipientModel>[];
                    if (all.isEmpty) {
                      return _message(
                        'No saved bank recipients yet.',
                        'Enter the account number below and it will be saved for next time.',
                      );
                    }
                    final shown = all.where(_matches).toList();
                    if (shown.isEmpty) {
                      return _message(
                        'No match for "$_query".',
                        'Try a name, bank or account number.',
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                      itemCount: shown.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (_, i) => _row(shown[i]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _message(String title, String hint) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 40),
        child: Column(
          children: [
            Text(title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 14)),
            const SizedBox(height: 6),
            Text(hint,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12)),
          ],
        ),
      );

  Widget _row(RecipientModel r) {
    final alias = (r.alias ?? '').trim();
    return InkWell(
      onTap: () => Navigator.pop(context, r),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            const Icon(Icons.account_balance,
                color: Color(0xFF4834D4), size: 18),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    alias.isNotEmpty ? alias : r.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${r.displayBankName} · ${r.accountNumber}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        const TextStyle(color: Color(0xFF9CA3AF), fontSize: 12),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF6B7280), size: 18),
          ],
        ),
      ),
    );
  }
}
