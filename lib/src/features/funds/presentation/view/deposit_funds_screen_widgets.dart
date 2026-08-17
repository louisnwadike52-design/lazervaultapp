part of 'deposit_funds_screen.dart';

/// Bottom sheet widget with bank search functionality
class _BankSearchBottomSheet extends StatefulWidget {
  final List<Map<String, dynamic>> banks;
  final String selectedBank;
  final Function(String) onBankSelected;

  const _BankSearchBottomSheet({
    required this.banks,
    required this.selectedBank,
    required this.onBankSelected,
  });

  @override
  State<_BankSearchBottomSheet> createState() => _BankSearchBottomSheetState();
}

class _BankSearchBottomSheetState extends State<_BankSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredBanks = [];

  @override
  void initState() {
    super.initState();
    _filteredBanks = widget.banks;
    _searchController.addListener(_filterBanks);
  }

  void _filterBanks() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredBanks = widget.banks;
      } else {
        _filteredBanks = widget.banks.where((bank) {
          final bankName = (bank['name'] as String? ?? '').toLowerCase();
          return bankName.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterBanks);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Bank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          // Search field
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search banks...',
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 16.sp,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white.withValues(alpha: 0.5),
                  size: 22.sp,
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.white.withValues(alpha: 0.5),
                          size: 20.sp,
                        ),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
              ),
              autofocus: true,
            ),
          ),
          SizedBox(height: 16.h),
          // Results count
          if (_searchController.text.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Text(
                '${_filteredBanks.length} bank${_filteredBanks.length == 1 ? '' : 's'} found',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 13.sp,
                ),
              ),
            ),
          // Bank list
          Expanded(
            child: _filteredBanks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          color: Colors.white.withValues(alpha: 0.3),
                          size: 48.sp,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'No banks found',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.5),
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Try a different search term',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.3),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredBanks.length,
                    itemBuilder: (context, index) {
                      final bank = _filteredBanks[index];
                      final isSelected = widget.selectedBank == bank['name'];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => widget.onBankSelected(bank['name']),
                          borderRadius: BorderRadius.circular(16.r),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? bank['color'].withValues(alpha: 0.1)
                                  : Colors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(16.r),
                              border: isSelected
                                  ? Border.all(color: bank['color'], width: 2)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: bank['color'].withValues(alpha: 0.1),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    bank['icon'],
                                    color: bank['color'],
                                    size: 24.sp,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    bank['name'],
                                    style: TextStyle(
                                      color: isSelected
                                          ? bank['color']
                                          : Colors.white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    padding: EdgeInsets.all(4.w),
                                    decoration: BoxDecoration(
                                      color: bank['color'],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

/// Friendly, classified deposit-failure copy + whether an identical retry
/// could plausibly succeed.
class _DepositFailureInfo {
  final String title;
  final String message;
  final bool retryable;
  // Overrides the recovery button label (default "Try Again"). Used when the
  // recovery action isn't a plain retry — e.g. "Re-link bank" for unverified
  // bank details, where the button actually re-runs Mono Connect.
  final String? retryLabel;

  const _DepositFailureInfo(this.title, this.message,
      {required this.retryable, this.retryLabel});
}

/// The deposit methods the picker can offer. The set shown depends on the
/// wallet currency + platform (see `_availableMethods`).
enum _DepositMethod { linkAccount, applePay, bankTransfer, card }

extension _DepositMethodMeta on _DepositMethod {
  String get label {
    switch (this) {
      case _DepositMethod.linkAccount:
        return 'Link Bank';
      case _DepositMethod.applePay:
        return 'Apple Pay';
      case _DepositMethod.bankTransfer:
        return 'Bank Transfer';
      case _DepositMethod.card:
        return 'Card';
    }
  }

  String get subtitle {
    switch (this) {
      case _DepositMethod.linkAccount:
        return 'Deposit straight from your bank via Mono';
      case _DepositMethod.applePay:
        return 'Fast, secure checkout with Apple Pay';
      case _DepositMethod.bankTransfer:
        return 'Transfer to your account number';
      case _DepositMethod.card:
        return 'Pay with a debit or credit card';
    }
  }

  IconData get icon {
    switch (this) {
      case _DepositMethod.linkAccount:
        return Icons.account_balance;
      case _DepositMethod.applePay:
        return Icons.apple;
      case _DepositMethod.bankTransfer:
        return Icons.swap_horiz;
      case _DepositMethod.card:
        return Icons.credit_card;
    }
  }
}
