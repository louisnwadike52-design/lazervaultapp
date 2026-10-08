import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'package:lazervault/core/services/grpc_call_options_helper.dart'
    as grpc_helper;
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';

/// Chat icon button for recipient list items.
/// Shown for all recipients. Internal recipients open P2P chat;
/// external recipients see an informational dialog.
class P2PChatIcon extends StatefulWidget {
  final String? otherUserId;
  final String otherUserName;
  final bool isInternal;
  final String? accountNumber;

  const P2PChatIcon({
    super.key,
    this.otherUserId,
    required this.otherUserName,
    required this.isInternal,
    this.accountNumber,
  });

  @override
  State<P2PChatIcon> createState() => _P2PChatIconState();
}

class _P2PChatIconState extends State<P2PChatIcon> {
  bool _tapped = false;
  bool _resolving = false;

  Future<void> _onTap() async {
    debugPrint(
        '[P2PChatIcon] _onTap called. tapped=$_tapped resolving=$_resolving isInternal=${widget.isInternal} otherUserId=${widget.otherUserId} accountNumber=${widget.accountNumber}');
    if (_tapped || _resolving) return;

    _tapped = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) _tapped = false;
    });

    if (widget.isInternal) {
      String? userId = widget.otherUserId;

      // Self-chat guard
      final authState = context.read<AuthenticationCubit>().state;
      final currentUserId = switch (authState) {
        AuthenticationAuthenticated s => s.profile.userId,
        AuthenticationSuccess s => s.profile.userId,
        _ => '',
      };
      debugPrint(
          '[P2PChatIcon] internal path. userId=$userId currentUserId=$currentUserId');
      if (userId != null && userId == currentUserId) {
        debugPrint('[P2PChatIcon] Self-chat guard triggered, returning');
        return;
      }

      // Resolve userId from account number if missing
      if (userId == null && widget.accountNumber != null) {
        debugPrint(
            '[P2PChatIcon] Resolving userId from account ${widget.accountNumber}');
        setState(() => _resolving = true);
        userId = await _resolveUserIdFromAccount(widget.accountNumber!);
        if (mounted) setState(() => _resolving = false);
        debugPrint('[P2PChatIcon] Resolved userId=$userId');
      }

      if (userId == null || !mounted) {
        debugPrint(
            '[P2PChatIcon] userId null or not mounted, cannot open chat');
        return;
      }

      if (userId == currentUserId) {
        debugPrint(
            '[P2PChatIcon] Resolved userId equals currentUserId, returning');
        return;
      }

      debugPrint('[P2PChatIcon] Opening P2P chat page for userId=$userId');
      if (mounted) {
        Get.toNamed(
          AppRoutes.p2pChat,
          arguments: {
            'otherUserId': userId,
            'otherUserName': widget.otherUserName,
            'isSavedRecipient': true,
          },
        );
      }
    } else {
      debugPrint('[P2PChatIcon] External recipient, showing dialog');
      _showExternalRecipientDialog();
    }
  }

  Future<String?> _resolveUserIdFromAccount(String accountNumber) async {
    try {
      final client = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final helper = serviceLocator<grpc_helper.GrpcCallOptionsHelper>();
      final callOptions = await helper.withAuth();
      final response = await client.getAccountByNumber(
        accounts_pb.GetAccountByNumberRequest(accountNumber: accountNumber),
        options: callOptions,
      );
      if (response.hasAccount() && response.account.userId.isNotEmpty) {
        return response.account.userId;
      }
    } catch (_) {
      // Resolve failed — will fall through to error state
    }
    return null;
  }

  /// Tell the user why chat is off for THIS contact, and what they can still do.
  ///
  /// This was a flat dark AlertDialog with a muted grey body and a bare "OK" —
  /// it read as an error on a flow that is working perfectly well. Nothing was
  /// wrong: the recipient is simply a bank account rather than a person on the
  /// platform, and the useful next step is to invite them.
  void _showExternalRecipientDialog() {
    const brand = Color(0xFF4834D4);
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Container(
          padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 18.h),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF2A2342), Color(0xFF1A1526)],
            ),
            borderRadius: BorderRadius.circular(22.r),
            border: Border.all(color: brand.withValues(alpha: 0.35)),
            boxShadow: [
              BoxShadow(
                color: brand.withValues(alpha: 0.22),
                blurRadius: 26,
                spreadRadius: 1,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      brand.withValues(alpha: 0.35),
                      const Color(0xFF7C5CFF).withValues(alpha: 0.25),
                    ],
                  ),
                  border: Border.all(color: brand.withValues(alpha: 0.5)),
                ),
                child: Icon(Icons.account_balance_rounded,
                    color: const Color(0xFFB9A8FF), size: 26.w),
              ),
              SizedBox(height: 16.h),
              Text(
                'Chat is for Lazervault users',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                // Names the person and says what they ARE, rather than leading
                // with what the app cannot do.
                '${widget.otherUserName} is saved as a bank account, so there '
                'is no Lazervault profile to message. You can still send money '
                'to them exactly as before.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFFCfC7E6),
                  fontSize: 13.5.sp,
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brand,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r)),
                  ),
                  child: Text(
                    'Got it',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: _onTap,
        child: Padding(
          padding: EdgeInsets.all(6.w),
          child: _resolving
              ? LazerVaultLoader.small()
              : Icon(
                  Icons.chat_outlined,
                  color: const Color(0xFF3B82F6),
                  size: 20.w,
                ),
        ),
      ),
    );
  }
}
