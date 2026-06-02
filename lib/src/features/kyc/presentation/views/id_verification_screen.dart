import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/kyc/domain/entities/kyc_tier_entity.dart';
import 'package:lazervault/src/features/kyc/presentation/cubits/kyc_cubit.dart';
import 'package:lazervault/src/features/kyc/presentation/views/kyc_provider_webview_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/views/mono_identity_screen.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_header.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_info_card.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_light_scaffold.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_primary_button.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_skip_button.dart';
import 'package:lazervault/src/features/kyc/presentation/widgets/light_theme/kyc_terms_checkbox.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

/// BVN verification screen for Tier-2 KYC.
///
/// The previous version was a multi-ID-type selector (BVN/NIN/Driver's
/// License/SSN/etc.) with name + DOB collection. The flow in production
/// only ever uses BVN for NG tier-2 today, and the user's name + DOB are
/// already collected during signup. The screen has been simplified to
/// BVN-only and switched to the light/signup theme.
///
/// Multi-ID flows for non-NG tiers should be a separate screen (deferred).
class IdVerificationScreen extends StatefulWidget {
  final KYCTier targetTier;
  final VoidCallback? onSkipPressed;

  const IdVerificationScreen({
    super.key,
    this.targetTier = KYCTier.tier2,
    this.onSkipPressed,
  });

  static const String route = '/kyc/verify-id';

  @override
  State<IdVerificationScreen> createState() => _IdVerificationScreenState();
}

class _IdVerificationScreenState extends State<IdVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bvnController = TextEditingController();

  bool _acceptTerms = false;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _bvnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KycLightScaffold(
      title: 'Verify your BVN',
      child: BlocListener<KYCCubit, KYCState>(
        listener: (context, state) {
          if (!mounted) return;
          if (state is VerificationSessionCreated) {
            _isSubmitting = false;
            _handleSessionCreated(context, state.session);
          } else if (state is IDVerificationSuccess) {
            _isSubmitting = false;
            _handleVerificationSuccess(context, state.response);
          } else if (state is KYCError) {
            _isSubmitting = false;
            _showError(context, state);
          }
        },
        child: BlocBuilder<KYCCubit, KYCState>(
          builder: (context, state) {
            final isLoading = state is KYCLoading;
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const KycHeader(
                    title: 'Verify Your Identity',
                    subtitle: 'Enter your BVN to complete Tier 2 verification',
                  ),
                  const KycInfoCard(
                    icon: Icons.security,
                    text:
                        'We verify your BVN securely with our partner. Your information is encrypted and only used for CBN compliance.',
                  ),
                  const SizedBox(height: 24),
                  BuildFormField(
                    name: 'bvn',
                    placeholder: 'Enter your 11-digit BVN',
                    keyboardType: TextInputType.number,
                    prefixIcon:
                        const Icon(Icons.badge, color: Colors.black45),
                    controller: _bvnController,
                    maxLength: 11,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'BVN is required';
                      }
                      if (value.length != 11) {
                        return 'BVN must be 11 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  KycTermsCheckbox(
                    value: _acceptTerms,
                    onChanged: (v) => setState(() => _acceptTerms = v),
                  ),
                  const SizedBox(height: 32),
                  KycPrimaryButton(
                    text: 'Verify BVN',
                    onPressed: isLoading ? null : _submit,
                    isLoading: isLoading || _isSubmitting,
                  ),
                  const SizedBox(height: 16),
                  KycSkipButton(onPressed: _handleSkip),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _handleSkip() {
    if (widget.onSkipPressed != null) {
      widget.onSkipPressed!();
      return;
    }
    try {
      final cubit = context.read<KYCCubit>();
      final authCubit = context.read<AuthenticationCubit>();
      final userId = authCubit.userId ?? '';
      if (userId.isNotEmpty) {
        cubit.skipKYCUpgrade(
          userId: userId,
          skipTier2: widget.targetTier != KYCTier.tier1,
        );
      }
    } catch (_) {
      // No cubit in scope (deep-link / standalone) — fall through to navigation.
    }
    Get.offAllNamed(AppRoutes.dashboard);
  }

  void _submit() {
    if (_isSubmitting || !mounted) return;
    if (!_formKey.currentState!.validate()) return;
    if (!_acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the terms to continue'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final cubit = context.read<KYCCubit>();
    final authCubit = context.read<AuthenticationCubit>();
    final userId = authCubit.userId ?? '';

    // Pull name + DOB from signup state (collected at signup); fall back to
    // the loaded profile when this screen is reached post-login.
    String firstName = '';
    String lastName = '';
    String dateOfBirth = '';
    String? phoneNumber;

    final authState = authCubit.state;
    if (authState is SignUpInProgress) {
      firstName = authState.firstName;
      lastName = authState.lastName;
      dateOfBirth = authState.selectedDate?.toIso8601String().split('T').first ?? '';
      phoneNumber = authState.phoneNumber;
    } else if (authCubit.currentProfile != null) {
      firstName = authCubit.currentProfile!.user.firstName;
      lastName = authCubit.currentProfile!.user.lastName;
      phoneNumber = authCubit.currentProfile!.user.phoneNumber;
    }

    _isSubmitting = true;

    // Strip any non-digit characters the user may have pasted in (BVNs are
    // 11 digits exactly). The validator already ran, but a paste of
    // "12345-67890-1" passes maxLength then fails server-side.
    final cleanBvn =
        _bvnController.text.trim().replaceAll(RegExp(r'[^0-9]'), '');

    cubit.createVerificationSession(
      userId: userId,
      targetTier: widget.targetTier,
      countryCode: 'NG',
      idType: IDType.bvn,
      idNumber: cleanBvn,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      phoneNumber: phoneNumber,
    );
  }

  void _handleSessionCreated(BuildContext context, VerificationSession session) {
    if (!mounted) return;
    final authCubit = context.read<AuthenticationCubit>();
    final cubit = context.read<KYCCubit>();

    switch (session.provider) {
      case 'mono':
        if (session.sessionToken == null || session.sessionToken!.isEmpty) {
          // No session token means Mono didn't give us a launch credential.
          // Reset the submit flag so the user can retry without a forced rebuild.
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Session not available. Please try again.')),
          );
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MonoIdentityScreen(
              sessionToken: session.sessionToken!,
              verificationId: session.verificationId,
              userName:
                  '${authCubit.currentProfile?.user.firstName ?? ''} ${authCubit.currentProfile?.user.lastName ?? ''}'
                      .trim(),
              userEmail: authCubit.currentProfile?.user.email ?? '',
              onSuccess: (authCode) {
                cubit.confirmVerification(
                  verificationId: session.verificationId,
                  provider: session.provider,
                  providerAuthCode: authCode,
                );
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              onClose: () => Navigator.of(context).pop(),
            ),
          ),
        );
        break;
      case 'smile_id':
      case 'persona':
      case 'onfido':
        if (session.sessionUrl == null || session.sessionUrl!.isEmpty) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Verification URL not available.')),
          );
          return;
        }
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => KYCProviderWebViewScreen(
              sessionUrl: session.sessionUrl!,
              provider: session.provider,
              verificationId: session.verificationId,
              onComplete: (success) {
                Navigator.of(context).popUntil((route) => route.isFirst);
                if (success) {
                  cubit.confirmVerification(
                    verificationId: session.verificationId,
                    provider: session.provider,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Verification was not completed. Please try again.'),
                      backgroundColor: Colors.orange,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
            ),
          ),
        );
        break;
      default:
        Navigator.of(context).popUntil((route) => route.isFirst);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Verification in progress. We\'ll notify you when it\'s complete.'),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  void _handleVerificationSuccess(
    BuildContext context,
    VerifyIDResponse response,
  ) {
    if (response.sessionUrl != null && response.sessionUrl!.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => _VerificationWebViewScreen(
            sessionUrl: response.sessionUrl!,
            verificationId: response.verificationId,
          ),
        ),
      );
      return;
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Verification submitted successfully! We\'ll notify you once approved.',
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showError(BuildContext context, KYCError state) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.userMessage ?? state.failure.message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Retry',
          textColor: Colors.white,
          onPressed: _submit,
        ),
      ),
    );
  }
}

/// Fallback external-browser verification step used when the backend returns
/// a session URL (Onfido / Persona). Visual chrome inherits the parent
/// theme so it now renders against the light palette automatically.
class _VerificationWebViewScreen extends StatefulWidget {
  final String sessionUrl;
  final String? verificationId;

  const _VerificationWebViewScreen({
    required this.sessionUrl,
    this.verificationId,
  });

  @override
  State<_VerificationWebViewScreen> createState() =>
      _VerificationWebViewScreenState();
}

class _VerificationWebViewScreenState extends State<_VerificationWebViewScreen> {
  bool _launched = false;
  bool _launching = false;

  Future<void> _launchVerificationUrl() async {
    if (_launching) return;
    setState(() => _launching = true);

    final uri = Uri.tryParse(widget.sessionUrl);
    if (uri == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Invalid verification URL'),
              backgroundColor: Colors.red),
        );
        setState(() => _launching = false);
      }
      return;
    }

    try {
      final launched =
          await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (mounted) {
        setState(() {
          _launched = launched;
          _launching = false;
        });
        if (!launched) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Could not open verification page'),
                backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _launching = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Failed to open: $e'),
              backgroundColor: Colors.red),
        );
      }
    }
  }

  void _showPendingAndPop(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
            'Verification in progress. We\'ll notify you once it completes.'),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Verify Identity'),
        actions: [
          TextButton(
            onPressed: () => _showPendingAndPop(context),
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.blue.withValues(alpha: 0.1),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 18, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _launched
                        ? 'Complete verification in your browser, then tap Done.'
                        : 'You will be redirected to our verification partner.',
                    style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _launched ? Icons.open_in_browser : Icons.verified_user,
                    size: 64,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _launched ? 'Verification Opened' : 'Identity Verification',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Text(
                      _launched
                          ? 'Complete the steps in your browser. When you\'re done, come back here and tap "Done".'
                          : 'Tap below to open the verification page in your browser.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (!_launched)
                    FilledButton.icon(
                      onPressed: _launching ? null : _launchVerificationUrl,
                      icon: _launching
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : const Icon(Icons.open_in_new),
                      label: Text(_launching ? 'Opening...' : 'Start Verification'),
                    )
                  else ...[
                    FilledButton.icon(
                      onPressed: _launchVerificationUrl,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reopen Verification'),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => _showPendingAndPop(context),
                      icon: const Icon(Icons.check),
                      label: const Text('I\'m Done'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
