part of 'batch_transfer_form.dart';

class BatchRecipientItem {
  final RecipientModel recipient;
  final TextEditingController amountController;
  final TextEditingController referenceController;
  bool isExpanded;
  final String? bankCode;
  final String? bankName;
  final String? beneficiaryName;

  BatchRecipientItem({
    required this.recipient,
    String? initialAmount,
    String? initialReference,
    this.isExpanded = false,
    this.bankCode,
    this.bankName,
    this.beneficiaryName,
  }) : amountController = TextEditingController(text: initialAmount ?? ''),
       referenceController = TextEditingController(text: initialReference ?? '');

  void dispose() {
    amountController.dispose();
    referenceController.dispose();
  }

  double get amount => double.tryParse(amountController.text) ?? 0.0;
  bool get isValid => amount >= 1.0;
  bool get isExternal => bankCode != null && bankCode!.isNotEmpty;
}

// --- Enhanced Multi-Select Recipient Bottom Sheet with User Search ---
class MultiSelectRecipientBottomSheet extends StatefulWidget {
  final Function(List<RecipientModel>) onRecipientsSelected;
  final List<String> alreadySelectedIds;

  const MultiSelectRecipientBottomSheet({
    super.key,
    required this.onRecipientsSelected,
    required this.alreadySelectedIds,
  });

  @override
  State<MultiSelectRecipientBottomSheet> createState() => _MultiSelectRecipientBottomSheetState();
}
