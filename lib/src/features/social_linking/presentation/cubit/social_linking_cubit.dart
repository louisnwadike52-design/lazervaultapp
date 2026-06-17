import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../data/datasources/social_linking_grpc_datasource.dart';
import '../../domain/entities/social_account_entity.dart';
import 'social_linking_state.dart';

/// Cubit for managing social account linking operations
class SocialLinkingCubit extends Cubit<SocialLinkingState> {
  final SocialLinkingGrpcDataSource _dataSource;

  // Google Sign-In scopes for authorization
  static const List<String> _googleScopes = ['email', 'profile'];

  // Track if Google Sign-In has been initialized
  bool _googleSignInInitialized = false;

  // Cached data
  List<LinkedSocialAccountEntity> _linkedAccounts = [];
  LinkedSocialAccountEntity? _primaryAccount;

  SocialLinkingCubit(this._dataSource) : super(SocialLinkingInitial());

  /// Initialize Google Sign-In if not already initialized
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_googleSignInInitialized) {
      await GoogleSignIn.instance.initialize();
      _googleSignInInitialized = true;
    }
  }

  /// Get cached linked accounts
  List<LinkedSocialAccountEntity> get linkedAccounts => _linkedAccounts;

  /// Get cached primary account
  LinkedSocialAccountEntity? get primaryAccount => _primaryAccount;

  /// Get computed stats from current accounts
  SocialAccountStats get stats => SocialAccountStats.fromAccounts(_linkedAccounts);

  /// Load linked social accounts
  Future<void> loadLinkedAccounts() async {
    if (isClosed) return;
    emit(const SocialLinkingLoading(operation: 'Loading accounts'));

    try {
      _linkedAccounts = await _dataSource.getLinkedAccounts();
      _primaryAccount = _linkedAccounts.where((a) => a.isPrimary).firstOrNull;

      if (isClosed) return;
      emit(LinkedSocialAccountsLoaded(
        accounts: _linkedAccounts,
        primaryAccount: _primaryAccount,
        stats: stats,
      ));
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'loadLinkedAccounts');
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to load accounts: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
      ));
    }
  }

  /// Initiate linking a Google account
  Future<void> linkGoogleAccount({bool setAsPrimary = false}) async {
    if (isClosed) return;
    emit(const AccountLinkingInProgress(provider: SocialProvider.google));

    try {
      // Ensure Google Sign-In is initialized
      await _ensureGoogleSignInInitialized();

      // Authenticate with Google (includes scope hint for combined auth+authz flow)
      final GoogleSignInAccount googleUser;
      try {
        googleUser = await GoogleSignIn.instance.authenticate(
          scopeHint: _googleScopes,
        );
      } on GoogleSignInException catch (e) {
        if (isClosed) return;
        if (e.code == GoogleSignInExceptionCode.canceled) {
          emit(const SocialLinkingError(
            message: 'Google sign-in was cancelled',
            errorType: SocialLinkingErrorType.cancelled,
            provider: SocialProvider.google,
          ));
        } else {
          emit(SocialLinkingError(
            message: 'Google sign-in failed: ${e.description ?? e.code.name}',
            errorType: SocialLinkingErrorType.oauthFailed,
            provider: SocialProvider.google,
          ));
        }
        return;
      }

      // Get authorization tokens for the scopes we need
      final authorization = await googleUser.authorizationClient.authorizeScopes(
        _googleScopes,
      );
      final accessToken = authorization.accessToken;

      // Link account via backend
      final account = await _dataSource.linkSocialAccount(
        provider: 'google',
        providerToken: accessToken,
        providerUserId: googleUser.id,
        providerEmail: googleUser.email,
        displayName: googleUser.displayName,
        profilePictureUrl: googleUser.photoUrl,
        setAsPrimary: setAsPrimary,
      );

      // Update cache
      _addOrUpdateAccount(account);

      if (isClosed) return;
      emit(SocialAccountLinked(account: account, isNewAccount: true));
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'linkGoogleAccount', provider: SocialProvider.google);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to link Google account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: SocialProvider.google,
      ));
    }
  }

  /// Initiate linking an Apple account
  Future<void> linkAppleAccount({bool setAsPrimary = false}) async {
    if (isClosed) return;
    emit(const AccountLinkingInProgress(provider: SocialProvider.apple));

    try {
      // Sign in with Apple
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final identityToken = credential.identityToken;
      if (identityToken == null) {
        if (isClosed) return;
        emit(const SocialLinkingError(
          message: 'Failed to get Apple identity token',
          errorType: SocialLinkingErrorType.oauthFailed,
          provider: SocialProvider.apple,
        ));
        return;
      }

      // Build display name
      String? displayName;
      if (credential.givenName != null || credential.familyName != null) {
        displayName =
            '${credential.givenName ?? ''} ${credential.familyName ?? ''}'.trim();
      }

      // Link account via backend
      final account = await _dataSource.linkSocialAccount(
        provider: 'apple',
        providerToken: identityToken,
        providerUserId: credential.userIdentifier ?? '',
        providerEmail: credential.email,
        displayName: displayName,
        setAsPrimary: setAsPrimary,
      );

      // Update cache
      _addOrUpdateAccount(account);

      if (isClosed) return;
      emit(SocialAccountLinked(account: account, isNewAccount: true));
    } on SignInWithAppleAuthorizationException catch (e) {
      if (isClosed) return;
      if (e.code == AuthorizationErrorCode.canceled) {
        emit(const SocialLinkingError(
          message: 'Apple sign-in was cancelled',
          errorType: SocialLinkingErrorType.cancelled,
          provider: SocialProvider.apple,
        ));
      } else {
        emit(SocialLinkingError(
          message: 'Apple sign-in failed: ${e.message}',
          errorType: SocialLinkingErrorType.oauthFailed,
          provider: SocialProvider.apple,
        ));
      }
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'linkAppleAccount', provider: SocialProvider.apple);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to link Apple account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: SocialProvider.apple,
      ));
    }
  }

  /// Link a social account by provider
  Future<void> linkAccount(SocialProvider provider, {bool setAsPrimary = false}) async {
    switch (provider) {
      case SocialProvider.google:
        await linkGoogleAccount(setAsPrimary: setAsPrimary);
        break;
      case SocialProvider.apple:
        await linkAppleAccount(setAsPrimary: setAsPrimary);
        break;
      case SocialProvider.facebook:
      case SocialProvider.x:
      case SocialProvider.linkedin:
      case SocialProvider.instagram:
        emit(SocialLinkingError(
          message: '${provider.displayName} linking is not yet supported',
          errorType: SocialLinkingErrorType.general,
          provider: provider,
        ));
        break;
    }
  }

  /// Unlink a social account
  Future<void> unlinkAccount(String accountId) async {
    final account = _linkedAccounts.where((a) => a.id == accountId).firstOrNull;
    if (account == null) return;

    if (isClosed) return;
    emit(const SocialLinkingLoading(operation: 'Unlinking account'));

    try {
      await _dataSource.unlinkSocialAccount(accountId: accountId);

      // Update cache
      _linkedAccounts.removeWhere((a) => a.id == accountId);
      if (_primaryAccount?.id == accountId) {
        _primaryAccount = null;
      }

      if (isClosed) return;
      emit(SocialAccountUnlinked(
        accountId: accountId,
        provider: account.provider,
      ));
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'unlinkAccount', provider: account.provider);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to unlink account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: account.provider,
      ));
    }
  }

  /// Set a social account as primary
  Future<void> setPrimaryAccount(String accountId) async {
    final account = _linkedAccounts.where((a) => a.id == accountId).firstOrNull;
    if (account == null) return;

    if (isClosed) return;
    emit(const SocialLinkingLoading(operation: 'Setting primary account'));

    try {
      final updatedAccount = await _dataSource.setPrimaryAccount(
        accountId: accountId,
      );

      // Update cache - mark all as non-primary, then set the new primary
      _linkedAccounts = _linkedAccounts.map((a) {
        if (a.id == accountId) {
          return updatedAccount;
        }
        return a.copyWith(isPrimary: false);
      }).toList();
      _primaryAccount = updatedAccount;

      if (isClosed) return;
      emit(PrimarySocialAccountSet(account: updatedAccount));
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'setPrimaryAccount', provider: account.provider);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to set primary account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: account.provider,
      ));
    }
  }

  /// Reauthorize a social account
  Future<void> reauthorizeAccount(String accountId) async {
    final account = _linkedAccounts.where((a) => a.id == accountId).firstOrNull;
    if (account == null) return;

    // Initiate OAuth flow based on provider
    switch (account.provider) {
      case SocialProvider.google:
        await _reauthorizeGoogleAccount(accountId);
        break;
      case SocialProvider.apple:
        await _reauthorizeAppleAccount(accountId);
        break;
      default:
        emit(SocialLinkingError(
          message: '${account.provider.displayName} reauthorization is not yet supported',
          errorType: SocialLinkingErrorType.general,
          provider: account.provider,
        ));
    }
  }

  Future<void> _reauthorizeGoogleAccount(String accountId) async {
    if (isClosed) return;
    emit(const AccountLinkingInProgress(provider: SocialProvider.google));

    try {
      // Ensure Google Sign-In is initialized
      await _ensureGoogleSignInInitialized();

      // Sign out first to force fresh authentication
      await GoogleSignIn.instance.signOut();

      // Authenticate with Google
      final GoogleSignInAccount googleUser;
      try {
        googleUser = await GoogleSignIn.instance.authenticate(
          scopeHint: _googleScopes,
        );
      } on GoogleSignInException catch (e) {
        if (isClosed) return;
        if (e.code == GoogleSignInExceptionCode.canceled) {
          emit(const SocialLinkingError(
            message: 'Google sign-in was cancelled',
            errorType: SocialLinkingErrorType.cancelled,
            provider: SocialProvider.google,
          ));
        } else {
          emit(SocialLinkingError(
            message: 'Google sign-in failed: ${e.description ?? e.code.name}',
            errorType: SocialLinkingErrorType.oauthFailed,
            provider: SocialProvider.google,
          ));
        }
        return;
      }

      // Get authorization tokens
      final authorization = await googleUser.authorizationClient.authorizeScopes(
        _googleScopes,
      );
      final accessToken = authorization.accessToken;

      final updatedAccount = await _dataSource.reauthorizeAccount(
        accountId: accountId,
        providerToken: accessToken,
      );

      _addOrUpdateAccount(updatedAccount);

      if (isClosed) return;
      emit(SocialAccountReauthorized(account: updatedAccount));
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'reauthorizeGoogleAccount', provider: SocialProvider.google);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to reauthorize Google account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: SocialProvider.google,
      ));
    }
  }

  Future<void> _reauthorizeAppleAccount(String accountId) async {
    if (isClosed) return;
    emit(const AccountLinkingInProgress(provider: SocialProvider.apple));

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final identityToken = credential.identityToken;
      if (identityToken == null) {
        if (isClosed) return;
        emit(const SocialLinkingError(
          message: 'Failed to get Apple identity token',
          errorType: SocialLinkingErrorType.oauthFailed,
          provider: SocialProvider.apple,
        ));
        return;
      }

      final updatedAccount = await _dataSource.reauthorizeAccount(
        accountId: accountId,
        providerToken: identityToken,
      );

      _addOrUpdateAccount(updatedAccount);

      if (isClosed) return;
      emit(SocialAccountReauthorized(account: updatedAccount));
    } on SignInWithAppleAuthorizationException catch (e) {
      if (isClosed) return;
      if (e.code == AuthorizationErrorCode.canceled) {
        emit(const SocialLinkingError(
          message: 'Apple sign-in was cancelled',
          errorType: SocialLinkingErrorType.cancelled,
          provider: SocialProvider.apple,
        ));
      } else {
        emit(SocialLinkingError(
          message: 'Apple sign-in failed: ${e.message}',
          errorType: SocialLinkingErrorType.oauthFailed,
          provider: SocialProvider.apple,
        ));
      }
    } on SocialLinkingException catch (e) {
      if (isClosed) return;
      _emitError(e, operation: 'reauthorizeAppleAccount', provider: SocialProvider.apple);
    } catch (e) {
      if (isClosed) return;
      emit(SocialLinkingError(
        message: 'Failed to reauthorize Apple account: ${e.toString()}',
        errorType: SocialLinkingErrorType.general,
        provider: SocialProvider.apple,
      ));
    }
  }

  /// Get stats for AI chat agent integration
  Future<SocialAccountStats> getStatsForAI() async {
    if (_linkedAccounts.isEmpty) {
      await loadLinkedAccounts();
    }
    return stats;
  }

  /// Get AI-friendly summary for chat agents
  String getAISummary() {
    return stats.toAISummary();
  }

  /// Helper to add or update account in cache
  void _addOrUpdateAccount(LinkedSocialAccountEntity account) {
    final existingIndex = _linkedAccounts.indexWhere((a) => a.id == account.id);
    if (existingIndex >= 0) {
      _linkedAccounts[existingIndex] = account;
    } else {
      _linkedAccounts.add(account);
    }

    if (account.isPrimary) {
      // Clear primary flag from other accounts
      _linkedAccounts = _linkedAccounts.map((a) {
        if (a.id != account.id && a.isPrimary) {
          return a.copyWith(isPrimary: false);
        }
        return a;
      }).toList();
      _primaryAccount = account;
    }
  }

  /// Emit error state based on exception
  void _emitError(
    SocialLinkingException error, {
    String? operation,
    SocialProvider? provider,
  }) {
    SocialLinkingErrorType errorType;

    switch (error.code) {
      case 'SERVICE_UNAVAILABLE':
        errorType = SocialLinkingErrorType.serviceUnavailable;
        break;
      case 'UNAUTHORIZED':
        errorType = SocialLinkingErrorType.unauthorized;
        break;
      case 'ACCOUNT_ALREADY_LINKED':
        errorType = SocialLinkingErrorType.accountAlreadyLinked;
        break;
      case 'CANNOT_UNLINK_PRIMARY':
        errorType = SocialLinkingErrorType.cannotUnlinkPrimary;
        break;
      case 'TIMEOUT':
        errorType = SocialLinkingErrorType.network;
        break;
      default:
        errorType = SocialLinkingErrorType.general;
    }

    emit(SocialLinkingError(
      message: error.message,
      errorCode: error.code,
      errorType: errorType,
      isRetryable: error.isRetryable,
      operation: operation,
      provider: provider,
    ));
  }
}
