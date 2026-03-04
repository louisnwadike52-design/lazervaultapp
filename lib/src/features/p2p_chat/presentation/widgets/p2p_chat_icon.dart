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
import 'package:lazervault/core/services/grpc_call_options_helper.dart' as grpc_helper;

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
    debugPrint('[P2PChatIcon] _onTap called. tapped=$_tapped resolving=$_resolving isInternal=${widget.isInternal} otherUserId=${widget.otherUserId} accountNumber=${widget.accountNumber}');
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
      debugPrint('[P2PChatIcon] internal path. userId=$userId currentUserId=$currentUserId');
      if (userId != null && userId == currentUserId) {
        debugPrint('[P2PChatIcon] Self-chat guard triggered, returning');
        return;
      }

      // Resolve userId from account number if missing
      if (userId == null && widget.accountNumber != null) {
        debugPrint('[P2PChatIcon] Resolving userId from account ${widget.accountNumber}');
        setState(() => _resolving = true);
        userId = await _resolveUserIdFromAccount(widget.accountNumber!);
        if (mounted) setState(() => _resolving = false);
        debugPrint('[P2PChatIcon] Resolved userId=$userId');
      }

      if (userId == null || !mounted) {
        debugPrint('[P2PChatIcon] userId null or not mounted, cannot open chat');
        return;
      }

      if (userId == currentUserId) {
        debugPrint('[P2PChatIcon] Resolved userId equals currentUserId, returning');
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

  void _showExternalRecipientDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.chat_outlined,
              color: const Color(0xFF3B82F6),
              size: 24.w,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                'P2P Chat Unavailable',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          'P2P messaging is only available between LazerVault users. '
          'Since ${widget.otherUserName} is an external recipient, '
          'direct chat is not supported for this contact.',
          style: TextStyle(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF3B82F6),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            ),
            child: Text(
              'OK',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
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
              ? SizedBox(
                  width: 20.w,
                  height: 20.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFF3B82F6),
                  ),
                )
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
