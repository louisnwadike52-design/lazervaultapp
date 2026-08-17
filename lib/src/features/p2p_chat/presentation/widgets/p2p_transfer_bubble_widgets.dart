part of 'p2p_transfer_bubble.dart';

/// Stateful button that async-resolves the recipient before navigating.
/// First tries saved recipients, then falls back to resolving account via gRPC.
class _SendAgainButton extends StatefulWidget {
  final String otherUserId;
  final String otherUserName;
  final int? transferAmount;
  final String? transferCurrency;
  final VoidCallback onDismiss;

  const _SendAgainButton({
    required this.otherUserId,
    required this.otherUserName,
    required this.transferAmount,
    this.transferCurrency,
    required this.onDismiss,
  });

  @override
  State<_SendAgainButton> createState() => _SendAgainButtonState();
}

class _SendAgainButtonState extends State<_SendAgainButton> {
  bool _isLoading = false;

  Future<void> _onTap() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    try {
      // Try saved recipient first, then resolve account directly
      final recipient = await _lookupSavedRecipient() ?? await _resolveRecipientFromAccount();

      if (!mounted) return;
      try {
        widget.onDismiss();
      } catch (_) {
        // Bottom sheet may already be dismissed by user swipe
      }

      if (recipient != null) {
        final amount =
            (widget.transferAmount != null && widget.transferAmount! > 0)
                ? widget.transferAmount
                : null;
        // Single entry point: honours the user's short/long flow preference AND
        // unwinds any stale send-flow route so the two flows never coexist (the
        // long-amount-page-flash bug). Repeating a transfer must not force the
        // long flow when the user is pinned to short — SendFundsLauncher reads
        // FeatureFlags.sendFlowShortForSession (pinned at login).
        SendFundsLauncher.open(
          recipient: recipient,
          autoContinue: true,
          prefillAmountMinor: amount,
          prefillCurrency: widget.transferCurrency,
        );
      } else {
        Get.snackbar(
          'Error',
          'Could not resolve recipient account. Try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFEF4444).withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      debugPrint('[P2P] Send Again lookup failed: $e');
      if (!mounted) return;
      try {
        widget.onDismiss();
      } catch (_) {}
      Get.snackbar(
        'Error',
        'Could not load recipient details. Try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFFEF4444).withOpacity(0.9),
        colorText: Colors.white,
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  /// Look up the saved recipient by internalUserId from the backend.
  Future<RecipientModel?> _lookupSavedRecipient() async {
    String? accessToken;
    try {
      final authCubit = serviceLocator<AuthenticationCubit>();
      accessToken = switch (authCubit.state) {
        AuthenticationSuccess s => s.profile.session.accessToken,
        AuthenticationAuthenticated s => s.profile.session.accessToken,
        _ => null,
      };
    } catch (_) {
      return null;
    }

    if (accessToken == null) return null;

    try {
      final getRecipientsUseCase = serviceLocator<GetRecipientsUseCase>();
      final result = await getRecipientsUseCase(accessToken: accessToken);

      return result.fold(
        (failure) => null,
        (recipients) {
          for (final r in recipients) {
            if (r.internalUserId == widget.otherUserId &&
                r.accountNumber.isNotEmpty) {
              return r;
            }
          }
          for (final r in recipients) {
            if (r.bankName == 'LazerVault' &&
                r.name.toLowerCase() == widget.otherUserName.toLowerCase() &&
                r.accountNumber.isNotEmpty) {
              return r;
            }
          }
          return null;
        },
      );
    } catch (_) {
      return null;
    }
  }

  /// Resolve the user's account via gRPC and construct a RecipientModel directly.
  Future<RecipientModel?> _resolveRecipientFromAccount() async {
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final helper = serviceLocator<grpc_helper.GrpcCallOptionsHelper>();
      final callOptions = await helper.withAuth();
      final response = await client.getUserAccounts(
        accounts_pb.GetUserAccountsRequest(targetUserId: widget.otherUserId),
        options: callOptions,
      );
      if (response.accounts.isNotEmpty) {
        final account = response.accounts.first;
        return RecipientModel(
          id: '',
          name: widget.otherUserName,
          accountNumber: account.accountNumber,
          bankName: 'LazerVault',
          sortCode: '',
          isFavorite: false,
          isSaved: false,
          type: 'internal',
          internalUserId: widget.otherUserId,
          currency: account.currency.isNotEmpty ? account.currency : null,
        );
      }
    } catch (e) {
      debugPrint('[P2P] Account resolution failed: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _onTap,
        icon: _isLoading
            ? LazerVaultLoader.tiny()
            : Icon(Icons.send_rounded, size: 18.w),
        label: Text(
          _isLoading ? 'Loading...' : 'Send Again',
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF3B82F6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14.r),
          ),
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          disabledBackgroundColor: const Color(0xFF3B82F6).withOpacity(0.6),
        ),
      ),
    );
  }
}
