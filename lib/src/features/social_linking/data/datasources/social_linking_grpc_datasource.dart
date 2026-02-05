import 'package:grpc/grpc.dart';

import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/src/generated/auth.pbgrpc.dart' as auth;
import 'package:lazervault/src/generated/auth.pb.dart' as auth_pb;
import '../../domain/entities/social_account_entity.dart';

/// gRPC data source for social account linking operations
class SocialLinkingGrpcDataSource {
  final auth.AuthServiceClient _client;
  final GrpcCallOptionsHelper _callOptionsHelper;

  SocialLinkingGrpcDataSource(
    this._client,
    this._callOptionsHelper,
  );

  /// Get all linked social accounts for the current user
  Future<List<LinkedSocialAccountEntity>> getLinkedAccounts() async {
    try {
      final request = auth_pb.GetLinkedSocialAccountsRequest();

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.getLinkedSocialAccounts(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw SocialLinkingException(
          code: 'FETCH_FAILED',
          message: 'Failed to fetch linked accounts',
        );
      }

      return response.accounts.map(_mapProtoToEntity).toList();
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'getLinkedAccounts');
    }
  }

  /// Link a new social account
  Future<LinkedSocialAccountEntity> linkSocialAccount({
    required String provider,
    required String providerToken,
    required String providerUserId,
    String? providerEmail,
    String? displayName,
    String? profilePictureUrl,
    String? profileUrl,
    bool setAsPrimary = false,
  }) async {
    try {
      final request = auth_pb.LinkSocialAccountRequest(
        provider: provider,
        providerToken: providerToken,
        providerUserId: providerUserId,
        providerEmail: providerEmail ?? '',
        displayName: displayName ?? '',
        profilePictureUrl: profilePictureUrl ?? '',
        profileUrl: profileUrl ?? '',
        setAsPrimary: setAsPrimary,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.linkSocialAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 30)),
          ),
        );
      });

      if (!response.success) {
        throw SocialLinkingException(
          code: 'LINK_FAILED',
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to link account',
        );
      }

      return _mapProtoToEntity(response.account);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'linkSocialAccount');
    }
  }

  /// Unlink a social account
  Future<void> unlinkSocialAccount({
    required String accountId,
  }) async {
    try {
      final request = auth_pb.UnlinkSocialAccountRequest(
        accountId: accountId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.unlinkSocialAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw SocialLinkingException(
          code: 'UNLINK_FAILED',
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to unlink account',
        );
      }
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'unlinkSocialAccount');
    }
  }

  /// Set a social account as primary for login
  Future<LinkedSocialAccountEntity> setPrimaryAccount({
    required String accountId,
  }) async {
    try {
      final request = auth_pb.SetPrimarySocialAccountRequest(
        accountId: accountId,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.setPrimarySocialAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 15)),
          ),
        );
      });

      if (!response.success) {
        throw SocialLinkingException(
          code: 'SET_PRIMARY_FAILED',
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to set primary account',
        );
      }

      return _mapProtoToEntity(response.account);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'setPrimaryAccount');
    }
  }

  /// Reauthorize a social account (refresh tokens)
  Future<LinkedSocialAccountEntity> reauthorizeAccount({
    required String accountId,
    required String providerToken,
  }) async {
    try {
      final request = auth_pb.ReauthorizeSocialAccountRequest(
        accountId: accountId,
        providerToken: providerToken,
      );

      final response = await _callOptionsHelper.executeWithTokenRotation(() async {
        final callOptions = await _callOptionsHelper.withAuth();
        return await _client.reauthorizeSocialAccount(
          request,
          options: callOptions.mergedWith(
            CallOptions(timeout: const Duration(seconds: 30)),
          ),
        );
      });

      if (!response.success) {
        throw SocialLinkingException(
          code: 'REAUTH_FAILED',
          message: response.message.isNotEmpty
              ? response.message
              : 'Failed to reauthorize account',
        );
      }

      return _mapProtoToEntity(response.account);
    } on GrpcError catch (e) {
      throw _mapGrpcError(e, 'reauthorizeAccount');
    }
  }

  /// Map proto LinkedSocialAccount to domain entity
  LinkedSocialAccountEntity _mapProtoToEntity(auth_pb.LinkedSocialAccount proto) {
    return LinkedSocialAccountEntity(
      id: proto.id,
      userId: proto.userId,
      provider: SocialProvider.fromString(proto.provider),
      providerUserId: proto.providerUserId,
      providerEmail: proto.providerEmail.isNotEmpty ? proto.providerEmail : null,
      displayName: proto.displayName.isNotEmpty ? proto.displayName : null,
      profilePictureUrl:
          proto.profilePictureUrl.isNotEmpty ? proto.profilePictureUrl : null,
      profileUrl: proto.profileUrl.isNotEmpty ? proto.profileUrl : null,
      status: SocialAccountStatus.fromString(proto.status),
      isPrimary: proto.isPrimary,
      linkedAt: proto.linkedAt.isNotEmpty
          ? DateTime.tryParse(proto.linkedAt) ?? DateTime.now()
          : DateTime.now(),
      lastUsedAt: proto.lastUsedAt.isNotEmpty
          ? DateTime.tryParse(proto.lastUsedAt)
          : null,
    );
  }

  /// Map gRPC error to SocialLinkingException
  SocialLinkingException _mapGrpcError(GrpcError error, String operation) {
    switch (error.code) {
      case StatusCode.unavailable:
        return SocialLinkingException(
          code: 'SERVICE_UNAVAILABLE',
          message: 'Service unavailable. Please try again later.',
          isRetryable: true,
        );
      case StatusCode.deadlineExceeded:
        return SocialLinkingException(
          code: 'TIMEOUT',
          message: 'Request timed out. Please try again.',
          isRetryable: true,
        );
      case StatusCode.unauthenticated:
        return SocialLinkingException(
          code: 'UNAUTHORIZED',
          message: 'Session expired. Please login again.',
          isRetryable: false,
        );
      case StatusCode.permissionDenied:
        return SocialLinkingException(
          code: 'PERMISSION_DENIED',
          message: 'You do not have permission to perform this action.',
          isRetryable: false,
        );
      case StatusCode.alreadyExists:
        return SocialLinkingException(
          code: 'ACCOUNT_ALREADY_LINKED',
          message: 'This social account is already linked.',
          isRetryable: false,
        );
      case StatusCode.failedPrecondition:
        return SocialLinkingException(
          code: 'CANNOT_UNLINK_PRIMARY',
          message: error.message ?? 'Cannot unlink primary account.',
          isRetryable: false,
        );
      case StatusCode.invalidArgument:
        return SocialLinkingException(
          code: 'INVALID_ARGUMENT',
          message: error.message ?? 'Invalid input. Please check your details.',
          isRetryable: false,
        );
      default:
        return SocialLinkingException(
          code: 'GRPC_ERROR_${error.code}',
          message: '$operation failed: ${error.message ?? 'Unknown error'}',
          isRetryable: false,
        );
    }
  }
}

/// Exception class for social linking errors
class SocialLinkingException implements Exception {
  final String code;
  final String message;
  final bool isRetryable;
  final Map<String, dynamic>? details;

  SocialLinkingException({
    required this.code,
    required this.message,
    this.isRetryable = false,
    this.details,
  });

  @override
  String toString() => 'SocialLinkingException[$code]: $message';
}
