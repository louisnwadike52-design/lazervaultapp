part of 'move_transfer_flow_screen.dart';

// =============================================================================
// Account picker bottom sheet (search + list + "Link New Account")
// =============================================================================

class _AccountPickerSheet extends StatefulWidget {
  final List<LinkedBankAccount> accounts;
  final String? selectedId;
  final String? excludeId;
  final String title;
  final ValueChanged<LinkedBankAccount> onSelected;
  final VoidCallback onAddAccount;

  const _AccountPickerSheet({
    required this.accounts,
    this.selectedId,
    this.excludeId,
    required this.title,
    required this.onSelected,
    required this.onAddAccount,
  });

  @override
  State<_AccountPickerSheet> createState() => _AccountPickerSheetState();
}

class _AccountPickerSheetState extends State<_AccountPickerSheet> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<LinkedBankAccount> get _filtered {
    var list = widget.accounts;
    if (_query.isNotEmpty) {
      final q = _query.toLowerCase();
      list = list
          .where((a) =>
              a.bankName.toLowerCase().contains(q) ||
              a.accountName.toLowerCase().contains(q) ||
              a.accountNumber.contains(q))
          .toList();
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      expand: false,
      builder: (context, scrollController) {
        return Column(
          children: [
            // Header + search
            Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
              child: Column(
                children: [
                  Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7280),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    widget.title,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  TextField(
                    controller: _searchController,
                    onChanged: (v) => setState(() => _query = v),
                    style: GoogleFonts.inter(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Search bank or account...',
                      hintStyle: GoogleFonts.inter(
                          color: const Color(0xFF6B7280)),
                      prefixIcon: const Icon(Icons.search,
                          color: Color(0xFF6B7280)),
                      filled: true,
                      fillColor: const Color(0xFF0A0A0A),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12.h),
                    ),
                  ),
                ],
              ),
            ),

            // Account list + "Link New Account"
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: _filtered.length + 1,
                itemBuilder: (context, index) {
                  // "Link New Account" pinned at the top
                  if (index == 0) {
                    return ListTile(
                      onTap: widget.onAddAccount,
                      leading: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B82F6)
                              .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(Icons.add,
                            color: const Color(0xFF3B82F6),
                            size: 22.sp),
                      ),
                      title: Text(
                        'Link New Account',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF3B82F6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        'Connect a bank account via Mono',
                        style: GoogleFonts.inter(
                          color: const Color(0xFF6B7280),
                          fontSize: 12.sp,
                        ),
                      ),
                    );
                  }

                  final account = _filtered[index - 1];
                  final isSelected = account.id == widget.selectedId;
                  final isExcluded = account.id == widget.excludeId;

                  final needsReauth = account.needsReauthorization;

                  return ListTile(
                    enabled: !isExcluded && account.isActive && !needsReauth,
                    onTap: (isExcluded || !account.isActive || needsReauth)
                        ? null
                        : () => widget.onSelected(account),
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF10B981)
                                .withValues(alpha: 0.15)
                            : const Color(0xFF3B82F6)
                                .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.account_balance,
                        color: isSelected
                            ? const Color(0xFF10B981)
                            : const Color(0xFF60A5FA),
                        size: 20.sp,
                      ),
                    ),
                    title: Text(
                      account.bankName,
                      style: GoogleFonts.inter(
                        color: isExcluded
                            ? const Color(0xFF6B7280)
                            : Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${account.accountName}  ${account.displayAccountNumber}',
                      style: GoogleFonts.inter(
                        color: isExcluded
                            ? const Color(0xFF4B5563)
                            : const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check_circle,
                            color: const Color(0xFF10B981), size: 20.sp)
                        : needsReauth
                            ? Text('Re-link',
                                style: GoogleFonts.inter(
                                    color: const Color(0xFFFB923C),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600))
                            : isExcluded
                                ? Text('In use',
                                    style: GoogleFonts.inter(
                                        color: const Color(0xFF6B7280),
                                        fontSize: 12.sp))
                                : null,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
