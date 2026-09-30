import 'package:equatable/equatable.dart';

/// Supported account types for virtual accounts
enum VirtualAccountType {
  personal('Personal'),
  savings('Savings'),
  investment('Investment'),
  family('Family & Friends'),
  main('Main'),
  business('Business'),
  usd('USD Wallet'),
  gbp('GBP Wallet'),
  eur('EUR Wallet');

  final String displayName;
  const VirtualAccountType(this.displayName);

  /// Create from string account type
  static VirtualAccountType fromString(String type) {
    switch (type.toLowerCase()) {
      case 'personal':
        return VirtualAccountType.personal;
      case 'savings':
        return VirtualAccountType.savings;
      case 'investment':
        return VirtualAccountType.investment;
      case 'family':
      case 'family & friends':
        return VirtualAccountType.family;
      case 'main':
        return VirtualAccountType.main;
      case 'business':
        return VirtualAccountType.business;
      case 'usd':
      case 'usd wallet':
        return VirtualAccountType.usd;
      case 'gbp':
      case 'gbp wallet':
        return VirtualAccountType.gbp;
      case 'eur':
      case 'eur wallet':
        return VirtualAccountType.eur;
      default:
        return VirtualAccountType.personal;
    }
  }
}

class AccountSummaryEntity extends Equatable {
  final String id; // Unique identifier for the account
  final String accountType;
  final String currency;
  final double balance;
  final double
      availableBalance; // Available for spending (balance - reserved - clearing)
  final double reservedBalance; // Funds in holds or clearing
  final String accountNumberLast4; // e.g., "7890"
  final String? accountNumber; // Full NUBAN account number for deposits
  final String? bankName; // Bank name (e.g., "Wema Bank", "VFD MFB")
  final String? accountName; // The USER'S label for the wallet (e.g. "Smith Family")
  /// Holder name as the CURRENTLY ACTIVE rail issued it — "LAZERVAULT/Praiz
  /// Onah" on Nomba, "Praiz Onah FLW" on Flutterwave. Separate from
  /// [accountName], which is the user's own label and must survive a provider
  /// switch; conflating them left a Nomba number under a Nombank heading still
  /// showing Flutterwave's holder name.
  final String? virtualAccountHolderName;
  final double trendPercentage; // e.g., 2.4 or -0.8
  final bool isUp; // Derived from trendPercentage > 0
  final bool isPrimary; // Whether this is the user's primary account
  final String? accountLabel; // Custom label for the account
  final String
      status; // active | frozen | suspended | closed (from accounts-service)

  // Family account specific fields
  final bool isFamilyAccount;
  final double? familyTotalBalance; // Total family pool balance
  final double? memberAllocatedBalance; // Member's allocated balance
  final double? memberRemainingBalance; // Member's remaining balance
  final int? memberCount; // Total member count
  final bool? allowMemberContributions; // Can members contribute
  final String? familyAccountId; // Family account ID (for setup navigation)
  final String?
      virtualAccountId; // Family VIRTUAL account id (real-money pool) — spend FROM this
  final String?
      familyStatus; // Family account status (active, pending_setup, frozen, closed)
  final String?
      fundDistributionMode; // Fund distribution mode (shared_pool, equal_split, custom_allocation)

  /// The account id money is actually spent FROM. For a family account this is
  /// the family virtual account (the real-money pool) so the payments path can
  /// detect the family + enforce member limits; for everything else it's [id].
  String get spendingAccountId =>
      (isFamilyAccount && (virtualAccountId?.isNotEmpty ?? false))
          ? virtualAccountId!
          : id;

  /// True when this is a family account whose real-money pool virtual account
  /// hasn't been provisioned yet (still processing). In that state
  /// [spendingAccountId] falls back to the non-spendable group [id], so a debit
  /// would fail server-side — callers must block spending until it clears.
  bool get isFamilyWalletProvisioning =>
      isFamilyAccount && !(virtualAccountId?.isNotEmpty ?? false);

  /// The signed-in member's own remaining spend allowance, or null when this
  /// account does not cap members individually.
  ///
  /// Only meaningful when the family account distributes funds PER MEMBER
  /// (`equal_split` / `custom_allocation`). On a `shared_pool` account every
  /// member spends the whole pool, so there is no personal ceiling: this
  /// returns null and the spending UIs render nothing, rather than showing a
  /// figure that reads like a limit where none exists.
  ///
  /// Falls back to [memberAllocatedBalance] when the remaining figure hasn't
  /// been computed yet — an allocation with no spend recorded against it is
  /// entirely still available, so the allocated amount IS the remainder.
  double? get memberSpendAllowance {
    if (!isFamilyAccount) return null;
    final mode = fundDistributionMode;
    if (mode == null || mode.isEmpty || mode == 'shared_pool') return null;
    return memberRemainingBalance ?? memberAllocatedBalance;
  }

  /// Estimated clearing time for pending deposits (e.g., "Available in 2h").
  /// Null when no clearing estimate is available from the backend.
  /// Will be populated when backend adds per-deposit clearing time fields.
  final String? clearingEstimate;

  const AccountSummaryEntity({
    required this.id,
    required this.accountType,
    required this.currency,
    required this.balance,
    this.availableBalance = 0,
    this.reservedBalance = 0,
    required this.accountNumberLast4,
    this.accountNumber,
    this.bankName,
    this.accountName,
    this.virtualAccountHolderName,
    required this.trendPercentage,
    this.isPrimary = false,
    this.accountLabel,
    this.status = 'active',
    this.isFamilyAccount = false,
    this.familyTotalBalance,
    this.memberAllocatedBalance,
    this.memberRemainingBalance,
    this.memberCount,
    this.allowMemberContributions,
    this.familyAccountId,
    this.virtualAccountId,
    this.familyStatus,
    this.fundDistributionMode,
    this.clearingEstimate,
  }) : isUp = trendPercentage > 0; // Calculate isUp here

  /// Serialize for the local dashboard cache (shown instantly on login before
  /// the live revalidation lands — see AccountCardsSummaryCubit). Only plain
  /// fields; `isUp`/`displayName` are derived and reconstructed.
  Map<String, dynamic> toJson() => {
        'id': id,
        'accountType': accountType,
        'currency': currency,
        'balance': balance,
        'availableBalance': availableBalance,
        'reservedBalance': reservedBalance,
        'accountNumberLast4': accountNumberLast4,
        'accountNumber': accountNumber,
        'bankName': bankName,
        'accountName': accountName,
        'trendPercentage': trendPercentage,
        'isPrimary': isPrimary,
        'accountLabel': accountLabel,
        'status': status,
        'isFamilyAccount': isFamilyAccount,
        'familyTotalBalance': familyTotalBalance,
        'memberAllocatedBalance': memberAllocatedBalance,
        'memberRemainingBalance': memberRemainingBalance,
        'memberCount': memberCount,
        'allowMemberContributions': allowMemberContributions,
        'familyAccountId': familyAccountId,
        'virtualAccountId': virtualAccountId,
        'familyStatus': familyStatus,
        'fundDistributionMode': fundDistributionMode,
        'clearingEstimate': clearingEstimate,
      };

  factory AccountSummaryEntity.fromJson(Map<String, dynamic> j) =>
      AccountSummaryEntity(
        id: j['id'] as String? ?? '',
        accountType: j['accountType'] as String? ?? '',
        currency: j['currency'] as String? ?? 'NGN',
        balance: (j['balance'] as num?)?.toDouble() ?? 0,
        availableBalance: (j['availableBalance'] as num?)?.toDouble() ?? 0,
        reservedBalance: (j['reservedBalance'] as num?)?.toDouble() ?? 0,
        accountNumberLast4: j['accountNumberLast4'] as String? ?? '',
        accountNumber: j['accountNumber'] as String?,
        bankName: j['bankName'] as String?,
        accountName: j['accountName'] as String?,
        trendPercentage: (j['trendPercentage'] as num?)?.toDouble() ?? 0,
        isPrimary: j['isPrimary'] as bool? ?? false,
        accountLabel: j['accountLabel'] as String?,
        status: j['status'] as String? ?? 'active',
        isFamilyAccount: j['isFamilyAccount'] as bool? ?? false,
        familyTotalBalance: (j['familyTotalBalance'] as num?)?.toDouble(),
        memberAllocatedBalance:
            (j['memberAllocatedBalance'] as num?)?.toDouble(),
        memberRemainingBalance:
            (j['memberRemainingBalance'] as num?)?.toDouble(),
        memberCount: j['memberCount'] as int?,
        allowMemberContributions: j['allowMemberContributions'] as bool?,
        familyAccountId: j['familyAccountId'] as String?,
        virtualAccountId: j['virtualAccountId'] as String?,
        familyStatus: j['familyStatus'] as String?,
        fundDistributionMode: j['fundDistributionMode'] as String?,
        clearingEstimate: j['clearingEstimate'] as String?,
      );

  /// Pending balance (funds in clearing or holds, not yet available)
  double get pendingBalance =>
      (balance - availableBalance).clamp(0.0, double.infinity);

  /// Whether there are pending funds
  bool get hasPendingBalance => pendingBalance > 0.01;

  /// Whether this account is frozen/suspended and therefore CANNOT be used as a
  /// transfer source. Mirrors the accounts-service enforcement (which rejects
  /// debits/holds/transfers on `frozen`/`suspended` accounts), so the UI can
  /// reflect the block before the user reaches the PIN step.
  bool get isFrozen {
    final s = status.toLowerCase();
    if (s == 'frozen' || s == 'suspended') return true;
    // Family cards carry their freeze state on familyStatus (the pool VA).
    final fs = (familyStatus ?? '').toLowerCase();
    return fs == 'frozen' || fs == 'suspended';
  }

  /// Get the display name for the account type — this is the account TYPE
  /// ("Personal", "Investment", "Savings", "Family & Friends", …), used to
  /// DIFFERENTIATE accounts in every picker/dropdown (Beam, batch, move-money,
  /// crowdfund). It deliberately does NOT fall back to [accountLabel], because
  /// the backend fills that with the account-HOLDER name (e.g. "Nnaemeka Chris"),
  /// which made every account render as the same person's name. The holder name
  /// / custom label is still available via [accountName]/[accountLabel] for the
  /// carousel and deposit surfaces that want it.
  String get displayName => accountType;

  /// Get the account type enum
  VirtualAccountType get accountTypeEnum =>
      VirtualAccountType.fromString(accountType);

  /// Check if this is a personal account
  bool get isPersonalAccount => accountTypeEnum == VirtualAccountType.personal;

  /// Check if this is a savings account
  bool get isSavingsAccount => accountTypeEnum == VirtualAccountType.savings;

  /// Check if this is an investment account
  bool get isInvestmentAccount =>
      accountTypeEnum == VirtualAccountType.investment;

  @override
  List<Object?> get props => [
        id,
        accountType,
        currency,
        balance,
        availableBalance,
        reservedBalance,
        accountNumberLast4,
        accountNumber,
        bankName,
        accountName,
        trendPercentage,
        isUp,
        isPrimary,
        accountLabel,
        status,
        isFamilyAccount,
        familyTotalBalance,
        memberAllocatedBalance,
        memberRemainingBalance,
        memberCount,
        allowMemberContributions,
        familyAccountId,
        familyStatus,
        fundDistributionMode,
        clearingEstimate,
      ];

  // Factory constructor for family accounts
  /// Whether this family account needs setup (pending_setup status)
  bool get isFamilyPendingSetup => familyStatus == 'pending_setup';

  /// Whether the family pool's virtual account is still being provisioned (a real
  /// NUBAN is being minted). While "processing" the account is NOT yet spendable —
  /// the card shows a "Setting up" state instead of balances/actions.
  bool get isFamilyProcessing =>
      isFamilyAccount && status.toLowerCase() == 'processing';

  factory AccountSummaryEntity.familyAccount({
    required String id,
    required String currency,
    required double totalBalance,
    // NULLABLE on purpose: in shared_pool no member has an allocation, and a
    // 0 there would render as "you have nothing to spend" when in fact they
    // spend the pool. Absent means "not applicable", not "zero".
    double? memberAllocatedBalance,
    double? memberRemainingBalance,
    // The family's UNALLOCATED pool. In shared_pool this is what everyone
    // spends from; in an allocation mode it is what has not been handed out
    // yet, and is NOT the member's to spend.
    double poolBalance = 0,
    required int memberCount,
    required bool allowMemberContributions,
    required double trendPercentage,
    String?
        name, // the family account's actual name (shown as the card subtitle)
    String? accountNumberLast4,
    String? familyAccountId,
    String? virtualAccountId,
    String? familyStatus,
    String? fundDistributionMode,
  }) {
    // What "Family Balance" means depends on the distribution mode:
    //   • shared_pool   → everyone draws from the shared pool, so the spendable
    //                     figure is the pool balance (memberRemainingBalance,
    //                     which carries total_pool_balance from the backend).
    //   • equal_split / custom_allocation → funds are carved into per-member
    //                     allocations, so the allocated balance is the right
    //                     headline figure.
    // Showing the allocated portion for a shared pool understated what a member
    // could actually spend (e.g. pool ₦1,550 but card read ₦500).
    // The headline is what THIS member can actually spend right now.
    //
    //   shared_pool      → the pool. Nobody has an allocation, so the pool IS
    //                      the spendable figure.
    //   allocation modes → their own REMAINING allocation (allocated minus
    //                      spent today), because that is the number the
    //                      backend's spend gate enforces. The gross allocation
    //                      would promise money a later spend the same day is
    //                      refused.
    //
    // Falls back to the pool when the caller has no member row (an admin view,
    // a stale cache) rather than rendering a blank card.
    final double displayBalance = (fundDistributionMode == 'shared_pool')
        ? poolBalance
        : (memberRemainingBalance ?? memberAllocatedBalance ?? poolBalance);
    return AccountSummaryEntity(
      id: id,
      accountType: 'Family & Friends',
      currency: currency,
      balance: displayBalance, // mode-aware spendable headline
      availableBalance: displayBalance, // Match balance to avoid false pending
      accountNumberLast4: accountNumberLast4 ?? '••••',
      trendPercentage: trendPercentage,
      // The account's real name — surfaced as the card subtitle. Null/blank
      // falls back to the generic "Family Balance" label in the UI.
      accountLabel:
          (name != null && name.trim().isNotEmpty) ? name.trim() : null,
      isFamilyAccount: true,
      familyTotalBalance: totalBalance,
      memberAllocatedBalance: memberAllocatedBalance,
      memberRemainingBalance: memberRemainingBalance,
      memberCount: memberCount,
      allowMemberContributions: allowMemberContributions,
      familyAccountId: familyAccountId,
      virtualAccountId: virtualAccountId,
      familyStatus: familyStatus,
      fundDistributionMode: fundDistributionMode,
    );
  }

  AccountSummaryEntity copyWith({
    String? id,
    String? accountType,
    String? currency,
    double? balance,
    double? availableBalance,
    double? reservedBalance,
    String? accountNumberLast4,
    String? accountNumber,
    String? bankName,
    String? accountName,
    String? virtualAccountHolderName,
    double? trendPercentage,
    bool? isPrimary,
    String? accountLabel,
    String? status,
    bool? isFamilyAccount,
    double? familyTotalBalance,
    double? memberAllocatedBalance,
    double? memberRemainingBalance,
    int? memberCount,
    bool? allowMemberContributions,
    String? familyAccountId,
    String? virtualAccountId,
    String? familyStatus,
    String? fundDistributionMode,
    String? clearingEstimate,
  }) {
    return AccountSummaryEntity(
      id: id ?? this.id,
      accountType: accountType ?? this.accountType,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      availableBalance: availableBalance ?? this.availableBalance,
      reservedBalance: reservedBalance ?? this.reservedBalance,
      accountNumberLast4: accountNumberLast4 ?? this.accountNumberLast4,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      virtualAccountHolderName:
          virtualAccountHolderName ?? this.virtualAccountHolderName,
      trendPercentage: trendPercentage ?? this.trendPercentage,
      isPrimary: isPrimary ?? this.isPrimary,
      accountLabel: accountLabel ?? this.accountLabel,
      status: status ?? this.status,
      isFamilyAccount: isFamilyAccount ?? this.isFamilyAccount,
      familyTotalBalance: familyTotalBalance ?? this.familyTotalBalance,
      memberAllocatedBalance:
          memberAllocatedBalance ?? this.memberAllocatedBalance,
      memberRemainingBalance:
          memberRemainingBalance ?? this.memberRemainingBalance,
      memberCount: memberCount ?? this.memberCount,
      allowMemberContributions:
          allowMemberContributions ?? this.allowMemberContributions,
      familyAccountId: familyAccountId ?? this.familyAccountId,
      virtualAccountId: virtualAccountId ?? this.virtualAccountId,
      familyStatus: familyStatus ?? this.familyStatus,
      fundDistributionMode: fundDistributionMode ?? this.fundDistributionMode,
      clearingEstimate: clearingEstimate ?? this.clearingEstimate,
    );
  }

  /// Factory constructor for signup accounts (Personal, Savings, Investment)
  factory AccountSummaryEntity.signupAccount({
    required String id,
    required VirtualAccountType type,
    required String currency,
    required double balance,
    required String accountNumberLast4,
    required String bankName,
    bool isPrimary = false,
    String? accountLabel,
    double trendPercentage = 0.0,
  }) {
    return AccountSummaryEntity(
      id: id,
      accountType: type.displayName,
      currency: currency,
      balance: balance,
      availableBalance: balance, // Match balance to avoid false pending
      accountNumberLast4: accountNumberLast4,
      trendPercentage: trendPercentage,
      isPrimary: isPrimary,
      accountLabel: accountLabel,
    );
  }
}
