part of 'add_recipient_sheet.dart';

/// Bottom sheet that lets the user add ONE recipient to the saved batch
/// via three add-methods:
///   1. Saved beneficiaries (existing RecipientCubit)
///   2. Tag / phone / email Lazervault user (manual entry, recipient_type=tagpay)
///   3. External bank NUBAN (uses AccountVerificationCubit + Paystack resolve)
///
/// Device contacts is scoped as a follow-up — the platform's existing
/// `contact_picker_bottom_sheet` lives under group_account/ and the
/// shape isn't a 1:1 match. Returning null from this sheet cancels.
class AddRecipientSheet {
  static Future<SavedBatchItemInputEntity?> show({
    required BuildContext context,
    required String currency,
  }) {
    return showModalBottomSheet<SavedBatchItemInputEntity>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => BlocProvider<RecipientCubit>(
        create: (_) {
          final cubit = serviceLocator<RecipientCubit>();
          // Best-effort load — fire-and-forget so the sheet doesn't block
          // on token retrieval; the saved tab handles the loading state.
          () async {
            try {
              final token = await serviceLocator<SecureStorageService>()
                  .getAccessToken();
              if (token != null && token.isNotEmpty) {
                await cubit.getRecipients(accessToken: token);
              }
            } catch (_) {
              // Swallow — the tab renders an empty/error state gracefully.
            }
          }();
          return cubit;
        },
        child: _AddRecipientSheetBody(currency: currency),
      ),
    );
  }
}

class _AddRecipientSheetBody extends StatefulWidget {
  final String currency;
  const _AddRecipientSheetBody({required this.currency});

  @override
  State<_AddRecipientSheetBody> createState() => _AddRecipientSheetBodyState();
}
