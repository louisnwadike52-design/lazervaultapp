import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../core/types/app_routes.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../../domain/entities/network_provider.dart';
import '../../domain/entities/country.dart';
import '../widgets/airtime_step_indicator.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipientInputScreen extends StatefulWidget {
  const RecipientInputScreen({super.key});

  @override
  State<RecipientInputScreen> createState() => _RecipientInputScreenState();
}

class _RecipientInputScreenState extends State<RecipientInputScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  NetworkProvider? selectedProvider;
  Country? selectedCountry;
  bool isPhoneValid = false;
  bool _isBuyForSelf = false;
  /// True while a detection RPC is in flight for the current phone.
  bool _isDetectingNetwork = false;
  /// True after the detection RPC has resolved (success or null) for the
  /// current phone. Lets the Continue button distinguish between
  /// "still detecting" (spinner-state, can't proceed) and "couldn't
  /// detect — pick a network manually" (actionable).
  bool _detectionAttempted = false;
  /// Monotonic id for in-flight detection. The async listener compares
  /// this against the value at fire-time and discards stale results so a
  /// fast typist doesn't see a late detection callback overwrite the
  /// network they're now seeing for a different prefix.
  int _detectionRequestId = 0;
  /// Cached providers list for the active country, fetched lazily so the
  /// "Couldn't detect — pick a network" bottom sheet can render without
  /// re-fetching every time the user opens it.
  List<NetworkProvider> _availableProviders = const [];
  /// True when the logged-in user has a phone number on their profile.
  /// Drives (a) whether the phone field is read-only and (b) whether we
  /// auto-skip this screen entirely for buy-for-self flows.
  bool _hasProfilePhone = false;
  /// When true, the recipient screen validates the pre-filled phone in
  /// `initState` and route-replaces with the amount selection — users
  /// with a profile phone never have to see this page.
  bool _autoAdvance = false;
  CountryLocale _selectedDialCountry = CountryLocales.all.first; // Nigeria default

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _phoneController.addListener(_onPhoneChanged);
    // Buy-for-self shortcut: if the user has a registered phone, validate
    // it in the background and route-replace to amount selection without
    // ever rendering the recipient form. On failure we drop the flag and
    // fall back to the standard UI.
    if (_autoAdvance) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _validateAndProceed();
      });
    }
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      selectedProvider = args['networkProvider'] as NetworkProvider?;
      selectedCountry = args['country'] as Country?;
      _isBuyForSelf = args['isBuyForSelf'] as bool? ?? false;

      // Sync dial country with airtime country selection
      if (selectedCountry != null) {
        final match = CountryLocales.all.where(
          (c) => c.countryCode == selectedCountry!.code,
        ).firstOrNull;
        if (match != null) _selectedDialCountry = match;
      }

      if (_isBuyForSelf) {
        // Auto-fill logged-in user's phone number (read-only)
        final authState = context.read<AuthenticationCubit>().state;
        String? userPhone;
        if (authState is AuthenticationAuthenticated) {
          userPhone = authState.profile.user.phoneNumber;
        }
        // Also try from the cubit's convenience getter
        userPhone ??= context.read<AuthenticationCubit>().state is SignUpInProgress
            ? (context.read<AuthenticationCubit>().state as SignUpInProgress).phoneNumber
            : null;
        if (userPhone != null && userPhone.isNotEmpty) {
          // Ensure local format (e.g., 08012345678)
          if (userPhone.startsWith('+234')) {
            userPhone = '0${userPhone.substring(4)}';
          } else if (userPhone.startsWith('234') && userPhone.length > 10) {
            userPhone = '0${userPhone.substring(3)}';
          }
          _phoneController.text = userPhone;
          isPhoneValid = userPhone.length >= 10;
          _nameController.text = 'Self';
          _hasProfilePhone = true;
          _autoAdvance = true;
        } else {
          // No profile phone on file — keep buy-for-self intent (header
          // copy + default 'Self' name) but leave the field editable so
          // the user can type one, with a visible CTA to set it on their
          // profile for next time.
          _hasProfilePhone = false;
          _nameController.text = 'Self';
        }
      } else if (args['prefillPhone'] != null ||
          args['phoneNumber'] != null) {
        // Saved-contact and repeat-purchase paths often hand us the phone
        // in E.164 (`+234801XXXXXXX`) — the input field expects the
        // local format (`0801XXXXXXX`) so detection can match against
        // the prefix table. Strip the country dial code consistently
        // here so a user repeating an old purchase doesn't see their
        // network silently fail to detect.
        final raw = (args['prefillPhone'] ?? args['phoneNumber']) as String;
        _phoneController.text = _normalizePrefilledPhone(raw);
        isPhoneValid = _phoneController.text.length >= 10;
      }

      if (!_isBuyForSelf && args['prefillName'] != null) {
        _nameController.text = args['prefillName'] as String;
      }

      // Saved-contact handler also passes networkCode + networkName as
      // strings (no full NetworkProvider). Construct a placeholder that
      // _onPhoneChanged's "preserve on null" logic will keep so the
      // Continue gate goes active immediately. Live detection from the
      // prefix table will replace this with a richer object on first
      // keystroke if the prefix matches a known provider.
      if (selectedProvider == null &&
          args['networkCode'] != null &&
          args['networkName'] != null) {
        try {
          final code = (args['networkCode'] as String).toUpperCase();
          final type = NetworkProviderType.values.firstWhere(
            (t) => t.name.toUpperCase() == code ||
                t.shortName.toUpperCase() == code,
            orElse: () => NetworkProviderType.values.first,
          );
          selectedProvider = NetworkProvider(
            id: code.toLowerCase(),
            type: type,
            name: args['networkName'] as String,
            shortName: type.shortName,
            logo: type.logo,
            primaryColor: type.primaryColor,
            prefixes: type.prefixes,
            countryCode: 'NG',
          );
        } catch (_) {
          // Best-effort — leave selectedProvider null and let detection
          // resolve, or the user pick from the manual sheet.
        }
      }

      if (args['isRepeatTransaction'] == true) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.repeat, color: Colors.white, size: 20.sp),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Transaction details pre-filled for repeat purchase',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                backgroundColor: const Color(0xFF10B981),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(16.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                duration: const Duration(seconds: 3),
              ),
            );
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nameController.dispose();
    _phoneFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  /// Convert an inbound prefilled phone (could be E.164 `+234XXX`,
  /// `234XXX`, or local `0XXX`) into the local form the input expects
  /// (`0XXX`). Strips spaces / dashes / parens too so detection sees a
  /// clean digit prefix on the very first listener tick.
  String _normalizePrefilledPhone(String raw) {
    var digits = raw.replaceAll(RegExp(r'[^\d+]'), '');
    if (digits.startsWith('+')) digits = digits.substring(1);
    // Common NG envelope: 234XXXXXXXXXX → 0XXXXXXXXXX. We only swap when
    // the result has the right local length so a paste of a non-NG
    // number passes through unchanged.
    if (digits.startsWith('234') && digits.length == 13) {
      return '0${digits.substring(3)}';
    }
    return digits;
  }

  /// Phone-input reactor. Re-runs detection on every keystroke so the
  /// Detected Network card updates as the user types, and clears state
  /// when the input drops below the minimum prefix length (or to empty)
  /// so users don't see a stale detected network from an earlier prefix.
  ///
  /// Edge cases handled:
  ///   * empty input         → clear network + flags
  ///   * < 4 digits          → clear network + flags (no detection yet)
  ///   * prefix change       → re-detect, replace network if different
  ///   * unknown prefix      → clear network, mark detectionAttempted so
  ///                           the Continue button switches to a tappable
  ///                           "Pick a network" prompt
  ///   * stale callback      → discarded via _detectionRequestId guard
  ///                           so a fast backspace doesn't get clobbered
  ///                           by a previous prefix's late response
  Future<void> _onPhoneChanged() async {
    if (!mounted) return;
    final phoneNumber =
        _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    final stripped =
        phoneNumber.startsWith('0') ? phoneNumber.substring(1) : phoneNumber;
    final newIsValid = stripped.length >= 7;

    // Clear state on short / empty input. Without this, deleting back
    // from "08036..." would leave the green Detected Network card
    // showing MTN even though the field is now empty.
    if (phoneNumber.length < 4) {
      if (!mounted) return;
      setState(() {
        isPhoneValid = newIsValid;
        if (selectedProvider != null ||
            _detectionAttempted ||
            _isDetectingNetwork) {
          selectedProvider = null;
          _detectionAttempted = false;
          _isDetectingNetwork = false;
        }
      });
      return;
    }

    // Bump the request id so any in-flight detection becomes stale.
    final requestId = ++_detectionRequestId;
    if (newIsValid != isPhoneValid || !_isDetectingNetwork) {
      setState(() {
        isPhoneValid = newIsValid;
        _isDetectingNetwork = true;
      });
    }

    NetworkProvider? detected;
    try {
      final cubit = context.read<AirtimeCubit>();
      final countryCode = selectedCountry?.code ?? 'NG';
      detected = await cubit.detectNetworkFromPhoneNumber(
          phoneNumber, countryCode);
    } catch (_) {
      // Detection is best-effort. A failure leaves `detected` null so the
      // user falls into the "Pick a network" path.
      detected = null;
    }

    if (!mounted) return;
    // Drop stale callbacks — if the user typed more characters while we
    // were awaiting, a newer request is in flight and this one's result
    // shouldn't overwrite it.
    if (requestId != _detectionRequestId) return;

    final previousProvider = selectedProvider;
    setState(() {
      // Only override the existing provider when detection found one.
      // Keeping the previous value on a null detection result lets the
      // repeat-purchase prefill flow (and any other path that hands us
      // a known networkProvider via args) survive a prefix-table miss.
      // Empty / cleared input is handled in the early-return branch
      // above, so this won't preserve a stale provider after backspace.
      selectedProvider = detected ?? selectedProvider;
      _isDetectingNetwork = false;
      _detectionAttempted = true;
    });
    // Only show the "Network Updated" interrupt when the user had a
    // confirmed network and we're actively replacing it with a different
    // one — not on the initial detection (previous = null) and not when
    // we've cleared to null because the prefix is unknown.
    if (detected != null &&
        previousProvider != null &&
        detected != previousProvider &&
        mounted) {
      _showNetworkUpdatedDialog(previousProvider, detected);
    }
  }

  void _showNetworkUpdatedDialog(NetworkProvider oldProvider, NetworkProvider newProvider) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.swap_horiz,
                color: const Color(0xFFFB923C),
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Network Updated',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'The phone number you entered belongs to ${newProvider.name}, not ${oldProvider.name}. The network has been automatically updated.',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF9CA3AF),
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: newProvider.type.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: newProvider.type.color.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: newProvider.type.color,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        newProvider.name.isNotEmpty ? newProvider.name[0] : '?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Now using ${newProvider.name}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Got it',
              style: TextStyle(
                color: const Color(0xFF4E03D0),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build full E.164 phone number with country dial code.
  String _buildFullPhone() {
    final local = _phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');
    final stripped = local.startsWith('0') ? local.substring(1) : local;
    return '${_selectedDialCountry.dialCode}$stripped';
  }

  void _validateAndProceed() {
    final localDigits = _phoneController.text.trim().replaceAll(RegExp(r'[^\d]'), '');

    if (localDigits.isEmpty) {
      _showError('Please enter a phone number');
      return;
    }

    // Strip leading 0 for length check (local format)
    final stripped = localDigits.startsWith('0') ? localDigits.substring(1) : localDigits;
    if (stripped.length < 7) {
      _showError('Please enter a valid phone number');
      return;
    }

    final fullPhone = _buildFullPhone();
    final countryCode = selectedCountry?.code ?? 'NG';
    context.read<AirtimeCubit>().validatePhoneNumber(fullPhone, countryCode);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }

  void _showContactsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _ContactSelectionBottomSheet(
        onContactSelected: (contact) {
          setState(() {
            _phoneController.text = contact['phone'] ?? '';
            // Buy-for-self uses 'Self' as the recipient label and keeps
            // the name controller hidden — don't overwrite it with the
            // contact's name even when the user picks one for the
            // convenience of not typing the digits.
            if (!_isBuyForSelf) {
              _nameController.text = contact['name'] ?? '';
            }
          });
          _onPhoneChanged();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: BlocConsumer<AirtimeCubit, AirtimeState>(
          listener: (context, state) {
            if (state is AirtimePhoneNumberValidated) {
              final args = Get.arguments as Map<String, dynamic>?;
              final prefillAmount = args?['prefillAmount'] as double?;

              final payload = {
                'phoneNumber': state.formattedNumber,
                'recipientName': _nameController.text.trim(),
                'networkProvider': state.detectedProvider ?? selectedProvider,
                'country': selectedCountry,
                if (prefillAmount != null) 'prefillAmount': prefillAmount,
              };
              // On auto-advance, replace this route so Back from amount
              // selection goes past the recipient screen directly to the
              // airtime landing (otherwise the loader shows again and
              // re-triggers the shortcut — infinite loop).
              if (_autoAdvance) {
                Get.offNamed(AppRoutes.airtimeAmountSelection,
                    arguments: payload);
              } else {
                Get.toNamed(AppRoutes.airtimeAmountSelection,
                    arguments: payload);
              }
            } else if (state is AirtimeError) {
              if (_autoAdvance) {
                // Fall back to the editable form so the user can correct
                // whatever the validator rejected.
                setState(() => _autoAdvance = false);
              }
              _showError(state.message);
            }
          },
          builder: (context, state) {
            if (state is AirtimePhoneNumberValidated) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    selectedProvider =
                        state.detectedProvider ?? selectedProvider;
                    isPhoneValid = true;
                  });
                }
              });
            }

            // Auto-advance loader — the BlocListener above route-replaces
            // onto amount selection as soon as validation succeeds, so this
            // is what the user sees for the ~100ms round trip.
            if (_autoAdvance) {
              return Column(
                children: [
                  _buildHeader(),
                  const Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4E03D0),
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                _buildHeader(),
                const AirtimeStepIndicator(currentStep: 0),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        if (selectedProvider != null)
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: _buildSelectedNetworkCard(),
                          ),
                        SizedBox(height: 24.h),
                        _buildPhoneNumberInput(),
                        if (!_isBuyForSelf) ...[
                          SizedBox(height: 20.h),
                          _buildRecipientNameInput(),
                        ],
                        // Quick Contacts is shown whenever the phone field
                        // is editable. For buy-for-self with a profile
                        // phone the field is read-only, so contact picking
                        // would be meaningless; everywhere else (send-to-
                        // others OR buy-for-self with no profile phone)
                        // the user benefits from picking a contact instead
                        // of typing.
                        if (!_isBuyForSelf || !_hasProfilePhone) ...[
                          SizedBox(height: 24.h),
                          _buildQuickContacts(),
                        ],
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                ),
                _buildContinueButton(state),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isBuyForSelf ? 'Buy for Self' : 'Send Airtime',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _isBuyForSelf
                      ? 'Buying airtime for your registered number'
                      : 'Who would you like to send airtime to?',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Get.until((route) => route.settings.name == AppRoutes.airtime || route.isFirst),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.close,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedNetworkCard() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: selectedProvider!.type.color,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Text(
                selectedProvider!.name.isNotEmpty ? selectedProvider!.name[0] : '?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Detected Network',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
                Text(
                  selectedProvider!.name,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.check_circle,
            color: const Color(0xFF10B981),
            size: 20.sp,
          ),
        ],
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: const Color(0xFF2D2D2D),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Country code prefix (display only — country is set earlier in flow)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Color(0xFF2D2D2D),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedDialCountry.flag,
                      style: TextStyle(fontSize: 20.sp),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      _selectedDialCountry.dialCode,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              // Phone number input. Locked only when buy-for-self AND the
              // user has a phone on their profile — otherwise it stays
              // editable so users without a profile phone can still pay.
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  readOnly: _isBuyForSelf && _hasProfilePhone,
                  enabled: !(_isBuyForSelf && _hasProfilePhone),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: (_isBuyForSelf && _hasProfilePhone)
                        ? const Color(0xFF9CA3AF)
                        : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    hintText: '8012345678',
                    hintStyle: TextStyle(
                      color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                      fontSize: 16.sp,
                    ),
                    suffixIcon: (_isBuyForSelf && _hasProfilePhone)
                        ? Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Icon(
                              Icons.lock_outline,
                              color: const Color(0xFF9CA3AF),
                              size: 18.sp,
                            ),
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 16.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_isBuyForSelf && !_hasProfilePhone) ...[
          SizedBox(height: 10.h),
          _buildProfilePhoneCta(),
        ],
      ],
    );
  }

  /// Warning pill shown under the phone field when the user tapped
  /// "Buy Airtime" (self-purchase intent) but has no phone on their
  /// profile yet. Links them to the My Account screen so the next
  /// buy-for-self tap can use the shortcut.
  Widget _buildProfilePhoneCta() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline,
              color: const Color(0xFFFB923C), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              "You haven't set a phone number on your profile.",
              style: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 12.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.myAccount),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                'Set it',
                style: TextStyle(
                  color: const Color(0xFFFB923C),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipientNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recipient Name (Optional)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _nameController,
            focusNode: _nameFocusNode,
            textCapitalization: TextCapitalization.words,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: 'Enter recipient name',
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Icon(
                Icons.person_outline,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickContacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Contacts',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        GestureDetector(
          onTap: _showContactsBottomSheet,
          child: Container(
            padding: EdgeInsets.all(14.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contacts,
                  color: const Color(0xFF4E03D0),
                  size: 22.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Select from contacts',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: const Color(0xFF4E03D0),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Manual network override sheet — shown when auto-detection has run
  /// and returned null. Lets users pick a network for unrecognised
  /// prefixes (e.g. older / sub-allocated MNO ranges) so they can still
  /// proceed instead of being stuck. Loads providers lazily and caches
  /// them in [_availableProviders] so reopens are instant.
  Future<void> _showNetworkPicker() async {
    final cubit = context.read<AirtimeCubit>();
    final countryCode = selectedCountry?.code ?? 'NG';

    if (_availableProviders.isEmpty) {
      try {
        final providers = await cubit.repository.getNetworkProviders(countryCode);
        if (!mounted) return;
        setState(() => _availableProviders = providers);
      } catch (_) {
        // Surface the failure rather than opening an empty sheet.
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Could not load networks. Try again.'),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.w),
            ),
          );
        }
        return;
      }
    }

    if (!mounted) return;
    final picked = await showModalBottomSheet<NetworkProvider>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4B5563),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pick a network',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "We couldn't auto-detect this number's network. Pick the operator manually to continue.",
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              ..._availableProviders.map(
                (p) => ListTile(
                  leading: Container(
                    width: 36.w,
                    height: 36.w,
                    decoration: BoxDecoration(
                      color: p.type.color,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        p.name.isNotEmpty ? p.name[0] : '?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    p.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => Navigator.of(ctx).pop(p),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (picked != null && mounted) {
      setState(() {
        selectedProvider = picked;
        // Mark detection as attempted so the "Pick a network" label
        // doesn't reappear after the user has chosen manually.
        _detectionAttempted = true;
      });
    }
  }

  Widget _buildContinueButton(AirtimeState state) {
    final isLoading = state is AirtimeLoading;
    // Require BOTH a valid phone AND a known network. Without the network
    // gate the user could advance to amount selection with networkProvider
    // still null, which then blew up there with a generic "missing required
    // information" snackbar. Forcing the gate here means the failure
    // surfaces at the screen the user can act on.
    final hasNetwork = selectedProvider != null;
    final canProceed = isPhoneValid && hasNetwork && !isLoading;

    // Surface a different label depending on what's blocking. The
    // "Pick a network" label is tappable — it opens the manual picker
    // sheet so users with an unrecognised prefix (e.g. a number whose
    // operator isn't in our local prefix table) can still proceed.
    final String blockedLabel;
    final VoidCallback? blockedAction;
    if (!isPhoneValid) {
      blockedLabel = 'Enter recipient phone';
      blockedAction = null;
    } else if (_isDetectingNetwork) {
      blockedLabel = 'Detecting network…';
      blockedAction = null;
    } else if (!hasNetwork && _detectionAttempted) {
      blockedLabel = 'Pick a network';
      blockedAction = _showNetworkPicker;
    } else if (!hasNetwork) {
      blockedLabel = 'Detecting network…';
      blockedAction = null;
    } else {
      blockedLabel = 'Continue';
      blockedAction = null;
    }

    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: canProceed
              ? _validateAndProceed
              : (blockedAction),
          style: ElevatedButton.styleFrom(
            backgroundColor: canProceed
                ? const Color(0xFF4E03D0)
                : (blockedAction != null
                    ? const Color(0xFFFB923C).withValues(alpha: 0.18)
                    : const Color(0xFF1F1F1F)),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: isLoading
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Validating...',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Text(
                  canProceed ? 'Continue' : blockedLabel,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: canProceed
                        ? Colors.white
                        : (blockedAction != null
                            ? const Color(0xFFFB923C)
                            : const Color(0xFF9CA3AF)),
                  ),
                ),
        ),
      ),
    );
  }

}

class _ContactSelectionBottomSheet extends StatefulWidget {
  final Function(Map<String, dynamic>) onContactSelected;

  const _ContactSelectionBottomSheet({required this.onContactSelected});

  @override
  State<_ContactSelectionBottomSheet> createState() =>
      _ContactSelectionBottomSheetState();
}

class _ContactSelectionBottomSheetState
    extends State<_ContactSelectionBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _contacts = [];
  List<Map<String, dynamic>> _filteredContacts = [];
  bool _loadingContacts = false;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadContacts();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filteredContacts = _contacts.where((contact) {
        final name = contact['name'].toString().toLowerCase();
        final phone = contact['phone'].toString().toLowerCase();
        return name.contains(_searchQuery) || phone.contains(_searchQuery);
      }).toList();
    });
  }

  Future<void> _loadContacts() async {
    setState(() {
      _loadingContacts = true;
    });

    try {
      final permission = await Permission.contacts.request();

      if (permission.isGranted) {
        // TODO: Integrate real device contacts via contacts_service package
        setState(() {
          _contacts = [];
          _filteredContacts = [];
        });
      } else {
        setState(() {
          _contacts = [];
          _filteredContacts = [];
        });
      }
    } catch (e) {
      setState(() {
        _contacts = [];
        _filteredContacts = [];
      });
    } finally {
      setState(() {
        _loadingContacts = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          _buildHeader(),
          _buildSearchBar(),
          Expanded(
            child:
                _loadingContacts ? _buildLoadingState() : _buildContactsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4E03D0).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.contacts,
                  color: const Color(0xFF4E03D0),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select Contact',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Choose a contact to send airtime to',
                      style: TextStyle(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.close,
                    color: const Color(0xFF9CA3AF),
                    size: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: const Color(0xFF4E03D0),
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: TextStyle(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 16.sp,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (_searchQuery.isNotEmpty)
            GestureDetector(
              onTap: () => _searchController.clear(),
              child: Icon(
                Icons.clear,
                color: const Color(0xFF9CA3AF),
                size: 20.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4E03D0)),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading contacts...',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactsList() {
    if (_filteredContacts.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = _filteredContacts[index];
        return _buildContactTile(contact);
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _searchQuery.isNotEmpty ? Icons.search_off : Icons.contacts_outlined,
            size: 48.sp,
            color: const Color(0xFF9CA3AF),
          ),
          SizedBox(height: 16.h),
          Text(
            _searchQuery.isNotEmpty ? 'No contacts found' : 'No contacts available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            _searchQuery.isNotEmpty
                ? 'Try searching with different keywords'
                : 'Grant permission to access your contacts',
            style: TextStyle(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactTile(Map<String, dynamic> contact) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        widget.onContactSelected(contact);
        Navigator.pop(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4E03D0), Color.fromARGB(255, 78, 3, 208)],
                ),
                borderRadius: BorderRadius.circular(22.r),
              ),
              child: Center(
                child: Text(
                  contact['avatar'] ??
                      (contact['name']?.toString().isNotEmpty == true ? contact['name']!.toString()[0].toUpperCase() : null) ??
                      '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact['name'] ?? 'Unknown',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    contact['phone'] ?? '',
                    style: TextStyle(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: const Color(0xFF4E03D0),
              size: 14.sp,
            ),
          ],
        ),
      ),
    );
  }
}
