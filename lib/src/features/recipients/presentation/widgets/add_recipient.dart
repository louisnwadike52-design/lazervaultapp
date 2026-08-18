import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/models/device_contact.dart';
import 'package:lazervault/src/core/services/analytics_service.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/core/widgets/bank_logo.dart';
import 'package:lazervault/core/widgets/bank_picker_sheet.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/recipients/data/repositories/bank_repository.dart';
import 'package:lazervault/core/services/contact_service.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/recipient_state.dart';
import 'package:lazervault/src/features/recipients/data/models/recipient_model.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/common/back_navigator.dart';
import 'package:lazervault/src/features/profile/cubit/profile_cubit.dart';
import 'package:lazervault/src/features/profile/cubit/profile_state.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_cubit.dart';
import 'package:lazervault/src/features/recipients/presentation/cubit/account_verification_state.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_verification_result.dart';
import 'package:lazervault/src/features/recipients/domain/entities/account_suggestion.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/account_confirmation_bottom_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_search_bottom_sheet.dart';
import 'package:lazervault/src/features/recipients/presentation/widgets/username_recipient_confirmation_sheet.dart';
import 'package:lazervault/src/features/tag_pay/domain/entities/user_search_result_entity.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_cubit.dart';
import 'package:lazervault/src/features/contacts/presentation/cubit/contact_sync_state.dart';
import 'package:lazervault/src/features/contacts/data/models/lazervault_user_match_model.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;
import 'package:lazervault/src/generated/accounts.pbgrpc.dart' as accounts_grpc;
import 'package:lazervault/core/services/grpc_call_options_helper.dart';
import 'package:lazervault/core/config/country_config.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/src/features/referral/domain/usecases/get_my_referral_code_usecase.dart';
part 'add_recipient_widgets.dart';


/// Brand purple used across the add-recipient surface (matches SelectRecipients).
const Color _kBrandPurple = Color(0xFF4E03D0);

class AddRecipient extends StatefulWidget {
  /// When true, renders WITHOUT its own Scaffold + purple header so it can be
  /// embedded as a section inside another screen (the short-flow
  /// SelectRecipients). The parent provides the chrome/theme.
  final bool embedded;

  /// When provided, a chosen recipient (bank / Lazervault user / contact) is
  /// handed back via this callback INSTEAD of navigating to initiateSendFunds.
  /// The short flow uses this to continue with amount → PIN → receipt on the
  /// same screen. All add UI + confirmation sheets are reused unchanged.
  final void Function(RecipientModel recipient)? onRecipientSelected;

  /// Fired (embedded only) whenever the active method tab changes, so the host
  /// screen can filter its saved-recipients list to match (Bank vs LazerVault).
  final void Function(AddRecipientMethod method)? onMethodChanged;

  /// When non-null, a scan affordance appears at the RIGHT edge of the
  /// account-number field; tapping it runs the shared bank-scan → send
  /// pipeline (live camera → OCR → verify → route). Null ⇒ no scan button, so
  /// any caller that doesn't wire the pipeline (e.g. batch) is unaffected.
  final VoidCallback? onScanAccount;

  const AddRecipient({
    super.key,
    this.embedded = false,
    this.onRecipientSelected,
    this.onMethodChanged,
    this.onScanAccount,
  });

  @override
  State<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends State<AddRecipient> with WidgetsBindingObserver {
  AddRecipientMethod _selectedMethod = AddRecipientMethod.bankDetails;

  /// When the contact sheet sends the user to system settings (permanently
  /// denied), it registers a callback here so we can re-check permission the
  /// moment the app is resumed and proceed automatically if it was granted.
  VoidCallback? _onResumeContactPermissionCheck;

  // Bank Details Form Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _sortCodeController = TextEditingController();
  final TextEditingController _bankController = TextEditingController(text: "Select Bank");
  final bool _isFavorite = false;

  // Username Form Controller
  final TextEditingController _usernameController = TextEditingController();

  // Selected user from username search
  UserSearchResultEntity? _selectedUser;

  // Account verification state
  AccountVerificationResult? _verificationResult;
  bool _isVerifying = false;
  String? _selectedBankCode;

  // Account-number-first bank suggestions. As the user types a full 10-digit
  // account number, the backend runs a NUBAN check-digit pass + provider
  // name-resolve and returns the matching bank(s) with the holder name already
  // resolved, so tapping a suggestion prefills the bank and skips re-verifying.
  List<AccountSuggestion> _bankSuggestions = [];
  bool _loadingSuggestions = false;
  Timer? _suggestDebounce;

  // Anchored-popup ("tooltip") plumbing for the bank predictions. The overlay
  // floats just below the account-number field (autocomplete-style) instead of
  // pushing the Bank field down, and follows the field on scroll via LayerLink.
  final LayerLink _accountFieldLink = LayerLink();
  final OverlayPortalController _suggestOverlay = OverlayPortalController();

  /// Show/hide the suggestion tooltip to match current state: visible only on
  /// the Bank tab, while resolving or when there are matches, and before a bank
  /// is verified. Off-tab it actively HIDES (rather than no-oping) so it can
  /// never linger over — or re-appear stale on return to — another tab.
  void _syncSuggestOverlay() {
    final shouldShow = _selectedMethod == AddRecipientMethod.bankDetails &&
        _verificationResult == null &&
        (_loadingSuggestions || _bankSuggestions.isNotEmpty);
    if (shouldShow) {
      if (!_suggestOverlay.isShowing) _suggestOverlay.show();
    } else {
      if (_suggestOverlay.isShowing) _suggestOverlay.hide();
    }
  }

  /// Single entry point for switching recipient-method tabs. Re-syncs the
  /// prediction tooltip on the next frame (after the OverlayPortal for the new
  /// tab has attached/detached) so it never leaks across tabs.
  void _selectMethod(AddRecipientMethod method) {
    if (_selectedMethod == method) return;
    setState(() => _selectedMethod = method);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _syncSuggestOverlay();
    });
  }

  // Current country for bank selection (from locale)
  String _currentCountry = 'NG';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCountryAndLoadBanks();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // User may have just toggled the Contacts permission in system settings.
    // Re-check and proceed automatically if the contact sheet is waiting on it.
    if (state == AppLifecycleState.resumed) {
      _onResumeContactPermissionCheck?.call();
    }
  }

  Future<void> _initializeCountryAndLoadBanks() async {
    // Get country from LocaleManager
    try {
      final localeManager = serviceLocator<LocaleManager>();
      _currentCountry = localeManager.currentCountry;
    } catch (e) {
      _currentCountry = 'NG'; // Default to Nigeria
    }
    // Warm the shared bank cache so the BankPickerSheet (used by both the bank
    // and contact-bank pickers) opens instantly with a fresh, transfer-valid
    // (Flutterwave-backed) list. The picker itself handles load/empty/error.
    serviceLocator<BankRepository>().warmUp(_currentCountry);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _onResumeContactPermissionCheck = null;
    _suggestDebounce?.cancel();
    _nameController.dispose();
    _accountController.dispose();
    _sortCodeController.dispose();
    _bankController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, verificationState) {
        setState(() {
          _isVerifying = verificationState is AccountVerificationLoading;
        });

        if (verificationState is AccountVerificationSuccess) {
          // Store verification result with bank name from Paystack
          _verificationResult = AccountVerificationResult(
            accountNumber: verificationState.accountNumber,
            accountName: verificationState.accountName,
            bankName: verificationState.bankName,
            bankCode: verificationState.bankCode,
            verificationStatus: verificationState.verificationStatus,
          );

          _syncSuggestOverlay(); // a verified result hides the prediction tooltip
          // Show confirmation bottomsheet
          _showAccountConfirmationBottomSheet(_verificationResult!);
        } else if (verificationState is AccountVerificationFailure) {
          if (verificationState.isRateLimitError) {
            // Rate limit hit — show manual entry bottom sheet
            _showManualAccountNameBottomSheet();
          } else {
            // Show error snackbar
            Get.snackbar(
              'Verification Failed',
              verificationState.userMessage,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: verificationState.canRetry
                  ? Colors.orange.withValues(alpha: 0.8)
                  : Colors.red.withValues(alpha: 0.8),
              colorText: Colors.white,
              duration: Duration(seconds: 4),
              mainButton: verificationState.canRetry
                  ? TextButton(
                      onPressed: () {
                        Get.back();
                        _handleVerifyAccount();
                      },
                      child: Text('Retry', style: TextStyle(color: Colors.white)),
                    )
                  : null,
            );
          }
        }
      },
      child: BlocConsumer<RecipientCubit, RecipientState>(
        listener: (context, state) {
          if (state is RecipientError) {
            Get.snackbar(
              'Error',
              state.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red.withValues(alpha: 0.8),
              colorText: Colors.white,
            );
          } else if (state is RecipientSuccess && !state.silent) {
            Get.snackbar(
              'Success',
              state.message,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green.withValues(alpha: 0.8),
              colorText: Colors.white,
            );

            // Navigate to initiate send funds screen with the newly created recipient
            if (state.recipient != null) {
              Get.offNamed(
                AppRoutes.initiateSendFunds,
                arguments: state.recipient,
              );
            } else {
              // If no recipient is returned (shouldn't happen), just go back
              Get.back();
            }
          }
        },
        builder: (context, state) {
          // Embedded (short flow): no Scaffold/header — just the method
          // selector + the selected form + the action button, so it drops in
          // as a section inside SelectRecipients' white sheet.
          if (widget.embedded) {
            return _buildEmbeddedBody(state);
          }
          return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              // Top Purple Section with Gradient
              Container(
                height: Get.height * 0.35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color.fromARGB(255, 95, 20, 225),
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                      // Header with Back Button
              Row(
                children: [
                          BackNavigator(),
                          Expanded(
                            child: Text(
                              'Add New Recipient',
                              textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(width: 40.w),
                        ],
                      ),
                      SizedBox(height: 24.h),

                      // Description
                      Text(
                        'Choose how you\'d like to add a recipient',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),

                      // Method Selection Cards
                      Row(
                            children: [
                          Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.bankDetails,
                              icon: Icons.account_balance_rounded,
                              title: 'Bank Details',
                              isSelected: _selectedMethod == AddRecipientMethod.bankDetails,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.lazervaultUser,
                              icon: Icons.person_rounded,
                              title: 'Lazervault user',
                              isSelected: _selectedMethod == AddRecipientMethod.lazervaultUser,
                            ),
                          ),
                          SizedBox(width: 12.w),
                              Expanded(
                            child: _buildMethodCard(
                              method: AddRecipientMethod.contacts,
                              icon: Icons.contacts_rounded,
                              title: 'Contacts',
                              isSelected: _selectedMethod == AddRecipientMethod.contacts,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Main Content Section
              Container(
                margin: EdgeInsets.only(top: Get.height * 0.30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(24.w),
                        child: _swipeableMethodContent(),
                      ),
                    ),
                    
                    // Bottom Action Button
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: Colors.grey[100]!, width: 1),
                        ),
                      ),
                      child: _buildActionButton(state),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
    );
  }

  /// Small illustration-style tile (rounded square, theme-tinted) used as the
  /// leading glyph for the recipient-method tabs AND the bank/account fields,
  /// giving them the same "quick services" colored-illustration language.
  ///
  /// [selected]/[onDark] pick the palette so the tile always contrasts with
  /// whatever surface it sits on:
  ///  - light surface, unselected → soft purple tile + purple glyph
  ///  - light surface, selected   → onDark handles it (white tile + purple glyph)
  ///  - purple surface (onDark)   → selected: white tile + purple glyph;
  ///                                unselected: translucent-white tile + white glyph
  Widget _methodGlyphTile(
    IconData icon, {
    required bool selected,
    bool onDark = false,
    double size = 34,
  }) {
    final Color bg;
    final Color fg;
    if (onDark) {
      bg = selected ? Colors.white : Colors.white.withValues(alpha: 0.18);
      fg = selected ? _kBrandPurple : Colors.white;
    } else {
      bg = selected ? _kBrandPurple : _kBrandPurple.withValues(alpha: 0.10);
      fg = selected ? Colors.white : _kBrandPurple;
    }
    return Container(
      width: size.w,
      height: size.w,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: fg, size: (size * 0.55).sp),
    );
  }

  Widget _buildMethodCard({
    required AddRecipientMethod method,
    required IconData icon,
    required String title,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () => _selectMethod(method),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: isSelected
            ? Colors.white.withValues(alpha: 0.2)
            : Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
              ? Colors.white.withValues(alpha: 0.4)
              : Colors.white.withValues(alpha: 0.2),
            width: isSelected ? 2 : 1,
          ),
        ),
        // Icon beside the label (was stacked above) so the cards are shorter.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _methodGlyphTile(icon, selected: isSelected, onDark: true, size: 28),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedMethodContent() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        return _buildBankDetailsForm();
      case AddRecipientMethod.lazervaultUser:
        return _buildUsernameForm();
      case AddRecipientMethod.contacts:
        return _buildContactsForm();
    }
  }

  /// Methods in on-screen tab order for the current flow — horizontal swipes
  /// over the form area move between them (matching the chips above it).
  List<AddRecipientMethod> get _methodSwipeOrder => widget.embedded
      ? const [
          AddRecipientMethod.bankDetails,
          AddRecipientMethod.lazervaultUser,
        ]
      : const [
          AddRecipientMethod.bankDetails,
          AddRecipientMethod.lazervaultUser,
          AddRecipientMethod.contacts,
        ];

  void _handleMethodSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 200) return; // ignore slow/ambiguous drags
    final order = _methodSwipeOrder;
    final idx = order.indexOf(_selectedMethod);
    if (idx < 0) return;
    final next = velocity < 0 ? idx + 1 : idx - 1; // swipe left → next tab
    if (next < 0 || next >= order.length) return;
    _selectMethod(order[next]);
  }

  /// The selected form, swipeable horizontally between the Bank /
  /// Lazervault-user (/ Contacts) tabs.
  Widget _swipeableMethodContent() => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: _handleMethodSwipe,
        child: _buildSelectedMethodContent(),
      );

  // ── Embedded (short-flow) rendering ───────────────────────────────────────
  // Reuses the exact forms + action button, just without the Scaffold/purple
  // header, and with a white-surface method selector that matches the
  // SelectRecipients sheet it lives inside.
  Widget _buildEmbeddedBody(RecipientState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEmbeddedMethodSelector(),
        SizedBox(height: 16.h),
        _swipeableMethodContent(),
        // Only the Bank method needs an explicit "Verify Recipient" button.
        // The LazerVault-user form's search field already opens the find-user
        // sheet on tap, so a separate action button there is redundant.
        if (_selectedMethod == AddRecipientMethod.bankDetails) ...[
          SizedBox(height: 16.h),
          _buildActionButton(state),
        ],
      ],
    );
  }

  Widget _buildEmbeddedMethodSelector() {
    Widget chip(AddRecipientMethod method, IconData icon, String label) {
      final selected = _selectedMethod == method;
      return Expanded(
        child: GestureDetector(
          onTap: () {
            _selectMethod(method);
            widget.onMethodChanged?.call(method);
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
            decoration: BoxDecoration(
              color: selected ? _kBrandPurple : Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: selected ? _kBrandPurple : Colors.grey[200]!,
              ),
            ),
            // Illustration tile beside the label (was stacked above) so the
            // tab is a single compact row instead of a tall stack.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _methodGlyphTile(icon, selected: selected, onDark: selected, size: 30),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? Colors.white : Colors.grey[800],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Short flow: only Bank or Lazervault user. "Contacts" isn't a top-level
    // method here — it lives as a "Find from contacts" CTA inside the User form
    // (contacts are used to locate a Lazervault user).
    return Row(
      children: [
        chip(AddRecipientMethod.bankDetails, Icons.account_balance_rounded,
            'Bank'),
        SizedBox(width: 8.w),
        chip(AddRecipientMethod.lazervaultUser, Icons.person_rounded,
            'Lazervault user'),
      ],
    );
  }

  Widget _buildBankDetailsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Bank Account Details" heading — long flow only. In the short flow the
        // Bank tab already labels this, so it's dropped to reduce clutter.
        if (!widget.embedded) ...[
          Text(
            'Bank Account Details',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
        ],
        // Keep the helper on a single line — FittedBox scales it down on narrow
        // screens instead of wrapping to two lines.
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            'Enter the account number — we\'ll suggest the bank automatically',
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              // A bit more visible than the old grey[600] caption, but not bold.
              color: Colors.grey[800],
              fontSize: 12.5.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 24.h),

        // Account Number Field FIRST (10 digits for Nigerian accounts). Typing a
        // full account number drives the bank auto-suggestions below.
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account Number',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            // Field + scan button sit side-by-side. The scan affordance is now
            // its OWN button beside the field (not crammed into the field's
            // suffix), so it reads as a distinct action with breathing room.
            // IntrinsicHeight + stretch makes the button match the field height
            // exactly regardless of screen density.
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // The field is the anchor (LayerLink target) for the bank-
                  // prediction tooltip, which floats just below it via
                  // OverlayPortal so it never pushes the Bank field down.
                  Expanded(
                    child: CompositedTransformTarget(
                      link: _accountFieldLink,
                      child: OverlayPortal(
                        controller: _suggestOverlay,
                        overlayChildBuilder: _buildSuggestionOverlay,
                        child: TextField(
                          controller: _accountController,
                          keyboardType: TextInputType.number,
                          // 11 so a wallet phone with a leading zero (OPay/
                          // PalmPay/Moniepoint) fits; a 10-digit NUBAN still works.
                          maxLength: 11,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[50],
                            hintText: 'Account or phone (OPay, PalmPay…)',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            prefixIcon: Icon(
                                Icons.account_balance_wallet_rounded,
                                color: _kBrandPurple),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: Colors.grey[200]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 78, 3, 208),
                                width: 2,
                              ),
                            ),
                            counterText: '',
                            // Only the completion check lives inside the field
                            // now; the scan action moved to its own button.
                            suffixIcon: _isAccountNumberComplete(
                                    _accountController.text)
                                ? Padding(
                                    padding: EdgeInsets.only(right: 8.w),
                                    child: Icon(Icons.check_circle,
                                        color: Colors.green),
                                  )
                                : null,
                            suffixIconConstraints:
                                BoxConstraints(minWidth: 40.w, minHeight: 40.w),
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: _onAccountNumberChanged,
                        ),
                      ),
                    ),
                  ),
                  // Standalone "Scan Account" button beside the field.
                  if (widget.onScanAccount != null) ...[
                    SizedBox(width: 12.w),
                    _buildScanAccountButton(),
                  ],
                ],
              ),
            ),
          ],
        ),

        // Predictions now render as an anchored tooltip overlay (see
        // _buildSuggestionOverlay), so nothing occupies layout here — the Bank
        // field sits directly below with only a small gap.
        SizedBox(height: 10.h),

        // Bank Selection SECOND — pre-filled by tapping a suggestion, or picked
        // manually here as the fallback when nothing auto-suggests.
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bank',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            GestureDetector(
              onTap: _showBankSelectionBottomSheet,
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: _bankController.text == "Select Bank"
                      ? Colors.grey[50]
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _bankController.text == "Select Bank"
                        ? Colors.grey[200]!
                        : Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3),
                    width: _bankController.text == "Select Bank" ? 1 : 2,
                  ),
                  boxShadow: _bankController.text != "Select Bank"
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  children: [
                    // Bank Logo or themed illustration tile (matches the tabs).
                    if (_bankController.text == "Select Bank")
                      _methodGlyphTile(
                        Icons.account_balance_rounded,
                        selected: false,
                        size: 40,
                      )
                    else
                      BankLogo(
                        bankName: _bankController.text,
                        bankCode: _selectedBankCode,
                        country: _currentCountry,
                        size: 44,
                        borderRadius: 10,
                      ),
                    SizedBox(width: 12.w),
                    // Bank Name and Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _bankController.text,
                            style: TextStyle(
                              color: _bankController.text == "Select Bank"
                                  ? Colors.grey[600]
                                  : Colors.black87,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (_bankController.text != "Select Bank") ...[
                            SizedBox(height: 2.h),
                            Text(
                              _getBankDescription(_bankController.text),
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Change/Select indicator
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: _bankController.text == "Select Bank"
                            ? Colors.grey[100]
                            : Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        _bankController.text == "Select Bank" ? 'Select' : 'Change',
                        style: TextStyle(
                          color: _bankController.text == "Select Bank"
                              ? Colors.grey[600]
                              : Color.fromARGB(255, 78, 3, 208),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Show verification result if successful
        if (_verificationResult != null) ...[
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.green, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 24.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Verified',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        _verificationResult!.accountName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildUsernameForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The embedded (short-flow) selector chip already says "User", so skip
        // the redundant heading to keep the screen uncluttered.
        if (!widget.embedded) ...[
          Text(
            'Lazervault user',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
        ],

        // Username search — opens bottom sheet
        GestureDetector(
              onTap: _showUsernameSearchSheet,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _selectedUser != null
                        ? const Color.fromARGB(255, 78, 3, 208)
                        : Colors.grey[200]!,
                    width: _selectedUser != null ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Themed person illustration tile — mirrors the bank field's
                    // leading tile so the User and Bank fields look symmetric.
                    _methodGlyphTile(
                      Icons.person_rounded,
                      selected: _selectedUser != null,
                      size: 40,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _selectedUser != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selectedUser!.fullName,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 2.h),
                                Text(
                                  '@${_selectedUser!.username}',
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 78, 3, 208),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            )
                          : Text(
                              'Search by username, phone or email',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 13.sp,
                              ),
                            ),
                    ),
                    if (_selectedUser != null)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedUser = null;
                            _usernameController.clear();
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: Colors.grey[600],
                          size: 20.sp,
                        ),
                      )
                    else
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey[400],
                        size: 24.sp,
                      ),
                  ],
                ),
              ),
            ),
        // (The "Find from contacts" entry now lives INSIDE the username search
        // bottom sheet — see UsernameSearchBottomSheet — so the inline form
        // stays minimal: tapping the field above opens that sheet.)
        // Info Card — helpful in the full add page; omitted in the compact
        // embedded (short-flow) section to reduce visual load.
        if (!widget.embedded) ...[
          SizedBox(height: 24.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue[600],
                  size: 20.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Internal transfers are verified automatically once you pick the right person.',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  /// Fetch the recipient's personal account number by user ID
  Future<String?> _fetchRecipientAccountNumber(String userId) async {
    try {
      final accountsClient = serviceLocator<accounts_grpc.AccountsServiceClient>();
      final callOptions = await serviceLocator<GrpcCallOptionsHelper>().withAuth();
      final request = accounts_pb.GetUserAccountsRequest()
        ..targetUserId = userId;
      final response = await accountsClient.getUserAccounts(request, options: callOptions);
      // Find the personal account (first account or account_type == 'personal')
      for (final account in response.accounts) {
        if (account.accountType == 'personal' || account.accountType == '') {
          final acctNum = account.accountNumber.isNotEmpty
              ? account.accountNumber
              : account.maskedAccountNumber;
          if (acctNum.isNotEmpty) return acctNum;
        }
      }
      // Fallback: return first account's number
      if (response.accounts.isNotEmpty) {
        final first = response.accounts.first;
        return first.accountNumber.isNotEmpty
            ? first.accountNumber
            : first.maskedAccountNumber;
      }
      return null;
    } catch (e) {
      print('[AddRecipient] Error fetching recipient account: $e');
      return null;
    }
  }

  /// Show the username search bottom sheet, then confirmation sheet
  /// After confirming, proceed directly to the payment/amount screen
  void _showUsernameSearchSheet() async {
    final selectedUser = await UsernameSearchBottomSheet.show(context);
    if (!mounted) return;
    if (selectedUser == null) return;

    // Fetch the recipient's personal account number
    final accountNumber = await _fetchRecipientAccountNumber(selectedUser.userId);

    if (!mounted) return;

    // Show confirmation bottom sheet
    bool confirmed = false;
    bool isSaved = false;
    bool isFavorite = false;
    String? alias;
    final sheetKey = GlobalKey<UsernameRecipientConfirmationSheetState>();

    await Get.bottomSheet(
      PopScope(
        canPop: true,
        child: UsernameRecipientConfirmationSheet(
          key: sheetKey,
          user: selectedUser,
          accountNumber: accountNumber,
          onConfirm: () {
            confirmed = true;
            // Read save/favorite/alias state directly via GlobalKey
            final sheetState = sheetKey.currentState;
            if (sheetState != null) {
              isSaved = sheetState.isSaved;
              isFavorite = sheetState.isFavorite;
              alias = sheetState.alias;
            }
            Get.back();
          },
          onCancel: () {
            Get.back();
          },
        ),
      ),
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
      exitBottomSheetDuration: const Duration(milliseconds: 200),
      backgroundColor: Colors.transparent,
    );

    if (!mounted) return;
    if (confirmed) {
      // Proceed directly to payment screen after confirmation
      _proceedToPaymentWithUsernameRecipient(selectedUser, accountNumber, isSaved, isFavorite, alias);
    }
  }

  /// Proceed directly to payment screen with username recipient
  /// without showing them on the form first
  void _proceedToPaymentWithUsernameRecipient(
      UserSearchResultEntity selectedUser,
      String? accountNumber,
      bool isSaved,
      bool isFavorite,
      String? alias) {
    // Get active country from profile preferences
    String? countryCode;
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      countryCode = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    // Create temporary recipient model — do NOT save to backend yet.
    // Recipient will be saved after successful transfer + PIN verification.
    final recipient = RecipientModel(
      id: selectedUser.userId,
      name: selectedUser.fullName,
      accountNumber: accountNumber ?? '@${selectedUser.username}',
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
      countryCode: countryCode,
      currency: CountryConfigs.getByCode(countryCode ?? 'NG')?.currency ?? 'NGN',
      email: selectedUser.email.isNotEmpty ? selectedUser.email : null,
      type: 'internal', // Explicitly set type for Lazervault users
      internalUserId: selectedUser.userId,
    );

    // Short flow (embedded): hand the recipient back to the host screen to
    // continue amount → PIN → receipt inline, instead of navigating.
    if (widget.onRecipientSelected != null) {
      widget.onRecipientSelected!(recipient);
      return;
    }

    // Navigate directly to send funds with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: {
        'recipient': recipient,
        'isTemporary': true,
        'shouldSaveOnSuccess': isSaved || isFavorite, // Save if user chose to save or favorite
      },
    );
  }

  Widget _buildContactsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Device Contacts',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Add recipients from your phone contacts',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 24.h),

        // Access Contacts Button
              Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                Color.fromARGB(255, 95, 20, 225).withValues(alpha: 0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.contacts_outlined,
                  color: Color.fromARGB(255, 78, 3, 208),
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Access Contacts',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Browse your contacts and add their banking details',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              ElevatedButton.icon(
                onPressed: _showContactSelection,
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                ),
                icon: Icon(Icons.search, size: 18.sp),
                label: Text(
                  'Browse Contacts',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),

        // Info Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.green[100]!),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security_outlined,
                color: Colors.green[600],
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Your contacts are processed locally and never stored on our servers',
                  style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(RecipientState state) {
    final isLoading = state is RecipientLoading || _isVerifying;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 78, 3, 208),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 0,
        minimumSize: Size(double.infinity, 56.h),
      ),
      onPressed: isLoading ? null : _handleAddRecipient,
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LazerVaultLoader.small(),
                SizedBox(width: 12.w),
                Text(
                  _isVerifying ? 'Verifying...' : 'Processing...',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : Text(
              _getActionButtonText(),
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }

  String _getActionButtonText() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        // Show "Verify Recipient" if verification hasn't been done yet
        if (_verificationResult == null) {
          return 'Verify Recipient';
        }
        return 'Proceed to Payment';
      case AddRecipientMethod.lazervaultUser:
        return 'Add Recipient';
      case AddRecipientMethod.contacts:
        return 'Browse Contacts';
    }
  }

  void _handleAddRecipient() {
    switch (_selectedMethod) {
      case AddRecipientMethod.bankDetails:
        // If verification hasn't been done yet, verify first
        if (_verificationResult == null) {
          _handleVerifyAccount();
        } else {
          // Verification already done, proceed to payment
          _proceedToPayment(_verificationResult!, false, _isFavorite, null);
        }
        break;
      case AddRecipientMethod.lazervaultUser:
        _addUsernameRecipient();
        break;
      case AddRecipientMethod.contacts:
        _showContactSelection();
        break;
    }
  }

  void _addUsernameRecipient() {
    // Check if a user was selected from search
    if (_selectedUser == null) {
      Get.snackbar(
        'No User Selected',
        'Please search and select a user first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Get active country from profile preferences
    String? countryCode;
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      countryCode = profileState.preferences.activeCountry.isNotEmpty
          ? profileState.preferences.activeCountry
          : null;
    }

    // Create temporary recipient model — do NOT save to backend yet.
    // Recipient will be saved after successful transfer + PIN verification.
    final recipient = RecipientModel(
      id: _selectedUser!.userId,
      name: _selectedUser!.fullName,
      accountNumber: '@${_selectedUser!.username}',
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      countryCode: countryCode,
      currency: CountryConfigs.getByCode(countryCode ?? 'NG')?.currency ?? 'NGN',
      email: _selectedUser!.email.isNotEmpty ? _selectedUser!.email : null,
      type: 'internal', // Explicitly set type for Lazervault users
      internalUserId: _selectedUser!.userId,
    );

    // Navigate directly to send funds with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: {
        'recipient': recipient,
        'isTemporary': true,
        'shouldSaveOnSuccess': true,
      },
    );
  }

  void _showContactSelection() {
    final contactService = serviceLocator<ContactService>();
    Timer? searchDebounce;

    // State variables hoisted outside StatefulBuilder so they persist across rebuilds
    List<DeviceContact> allContacts = [];
    List<DeviceContact> filteredContacts = [];
    String searchQuery = '';
    bool isLoading = true;
    bool permissionDenied = false;
    bool permissionPermanentlyDenied = false;
    String? errorMessage;
    bool initialLoadTriggered = false;
    final searchController = TextEditingController();

    // Tracks whether we just deep-linked the user into system settings, so the
    // app-resume handler only auto-rechecks when it's actually relevant.
    bool awaitingSettingsReturn = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            void loadContacts() {
              setSheetState(() {
                isLoading = true;
                permissionDenied = false;
                permissionPermanentlyDenied = false;
                errorMessage = null;
              });

              _loadContactsForSheet(
                contactService: contactService,
                onContactsLoaded: (contacts) {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      allContacts = contacts;
                      filteredContacts = contacts;
                      searchQuery = '';
                      searchController.clear();
                      isLoading = false;
                    });
                  }
                },
                onPermissionDenied: () {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      permissionDenied = true;
                    });
                  }
                },
                onPermissionPermanentlyDenied: () {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      permissionPermanentlyDenied = true;
                    });
                  }
                },
                onError: (message) {
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      isLoading = false;
                      errorMessage = message;
                    });
                  }
                },
              );
            }

            // Explicitly (re)request the OS permission, then branch on the
            // precise outcome. This is what the "Grant Permission" CTA invokes —
            // it must actually trigger the system prompt (not just reload the
            // gate), and escalate to the settings screen when the OS will no
            // longer prompt (permanently denied / restricted).
            Future<void> requestAndLoad() async {
              setSheetState(() {
                isLoading = true;
                permissionDenied = false;
                permissionPermanentlyDenied = false;
                errorMessage = null;
              });

              final result = await contactService.requestPermissionDetailed();
              if (!bottomSheetContext.mounted) return;

              switch (result) {
                case ContactPermissionResult.granted:
                  loadContacts();
                  break;
                case ContactPermissionResult.denied:
                  setSheetState(() {
                    isLoading = false;
                    permissionDenied = true;
                  });
                  break;
                case ContactPermissionResult.permanentlyDenied:
                  setSheetState(() {
                    isLoading = false;
                    permissionPermanentlyDenied = true;
                  });
                  break;
              }
            }

            // Deep-link to system settings and arm the app-resume re-check so we
            // proceed automatically when the user comes back having granted it.
            Future<void> openSettingsAndAwaitReturn() async {
              awaitingSettingsReturn = true;
              _onResumeContactPermissionCheck = () async {
                if (!awaitingSettingsReturn) return;
                final granted = await contactService.hasPermission();
                if (granted && bottomSheetContext.mounted) {
                  awaitingSettingsReturn = false;
                  loadContacts();
                }
              };
              await contactService.openSettings();
            }

            // Trigger initial load once
            if (!initialLoadTriggered) {
              initialLoadTriggered = true;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                loadContacts();
              });
            }

            return _buildContactSheetContent(
              allContacts: allContacts,
              filteredContacts: filteredContacts,
              searchQuery: searchQuery,
              isLoading: isLoading,
              permissionDenied: permissionDenied,
              permissionPermanentlyDenied: permissionPermanentlyDenied,
              errorMessage: errorMessage,
              searchController: searchController,
              onRetry: loadContacts,
              onGrantPermission: requestAndLoad,
              onOpenSettings: openSettingsAndAwaitReturn,
              onSearchChanged: (query) {
                searchDebounce?.cancel();
                searchDebounce = Timer(const Duration(milliseconds: 300), () {
                  final filtered = query.isEmpty
                      ? allContacts
                      : allContacts.where((c) => c.matchesQuery(query)).toList();
                  if (bottomSheetContext.mounted) {
                    setSheetState(() {
                      searchQuery = query;
                      filteredContacts = filtered;
                    });
                  }
                });
              },
              onContactTap: (contact) {
                searchDebounce?.cancel();
                Navigator.pop(bottomSheetContext);
                _showAddContactAsRecipientDialog(contact);
              },
            );
          },
        );
      },
    ).whenComplete(() {
      searchDebounce?.cancel();
      searchController.dispose();
      _onResumeContactPermissionCheck = null;
    });
  }

  Future<void> _loadContactsForSheet({
    required ContactService contactService,
    required void Function(List<DeviceContact>) onContactsLoaded,
    required VoidCallback onPermissionDenied,
    required VoidCallback onPermissionPermanentlyDenied,
    required void Function(String) onError,
  }) async {
    try {
      final status = await contactService.getPermissionStatus();

      // Already granted — go straight to loading, skipping the gate.
      if (!status.isGranted) {
        final result = await contactService.requestPermissionDetailed();
        switch (result) {
          case ContactPermissionResult.granted:
            break; // fall through to load
          case ContactPermissionResult.denied:
            onPermissionDenied();
            return;
          case ContactPermissionResult.permanentlyDenied:
            onPermissionPermanentlyDenied();
            return;
        }
      }

      final contacts = await contactService.getContactsWithPhone();
      onContactsLoaded(contacts);
    } catch (e) {
      debugPrint('Error loading contacts: $e');
      onError('Failed to load contacts. Please try again.');
    }
  }

  Widget _buildContactSheetContent({
    required List<DeviceContact> allContacts,
    required List<DeviceContact> filteredContacts,
    required String searchQuery,
    required bool isLoading,
    required bool permissionDenied,
    required bool permissionPermanentlyDenied,
    required String? errorMessage,
    required TextEditingController searchController,
    required VoidCallback onRetry,
    required VoidCallback onGrantPermission,
    required VoidCallback onOpenSettings,
    required void Function(String) onSearchChanged,
    required void Function(DeviceContact) onContactTap,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Row(
              children: [
                Text(
                  'Device Contacts',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const Spacer(),
                if (!isLoading && !permissionDenied && !permissionPermanentlyDenied && errorMessage == null)
                  Text(
                    searchQuery.isEmpty
                        ? '${allContacts.length} contacts'
                        : '${filteredContacts.length} results',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey[500],
                    ),
                  ),
              ],
            ),
          ),

          // Search bar (only when contacts loaded)
          if (!isLoading && !permissionDenied && !permissionPermanentlyDenied && errorMessage == null && allContacts.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                decoration: InputDecoration(
                  hintText: 'Search by name or phone number',
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey[400], size: 18.sp),
                          onPressed: () {
                            searchController.clear();
                            onSearchChanged('');
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                ),
              ),
            ),

          Divider(height: 1, color: Colors.grey[200]),

          // Content area
          Expanded(
            child: _buildContactSheetBody(
              filteredContacts: filteredContacts,
              searchQuery: searchQuery,
              isLoading: isLoading,
              permissionDenied: permissionDenied,
              permissionPermanentlyDenied: permissionPermanentlyDenied,
              errorMessage: errorMessage,
              allContactsEmpty: allContacts.isEmpty,
              onRetry: onRetry,
              onGrantPermission: onGrantPermission,
              onOpenSettings: onOpenSettings,
              onContactTap: onContactTap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSheetBody({
    required List<DeviceContact> filteredContacts,
    required String searchQuery,
    required bool isLoading,
    required bool permissionDenied,
    required bool permissionPermanentlyDenied,
    required String? errorMessage,
    required bool allContactsEmpty,
    required VoidCallback onRetry,
    required VoidCallback onGrantPermission,
    required VoidCallback onOpenSettings,
    required void Function(DeviceContact) onContactTap,
  }) {
    // Loading state
    if (isLoading) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LazerVaultLoader.small(),
            SizedBox(height: 16.h),
            Text(
              'Loading contacts...',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    // Permission denied
    if (permissionDenied) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.contacts, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'Contacts Access Required',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Lazervault needs access to your contacts to find people you can send money to.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onGrantPermission,
                icon: Icon(Icons.lock_open, size: 18.sp),
                label: const Text('Grant Permission'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              // Escape hatch: if the OS has stopped showing the prompt, the user
              // can still enable access from system settings.
              TextButton(
                onPressed: onOpenSettings,
                child: Text(
                  'Open Settings instead',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Color.fromARGB(255, 78, 3, 208),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Permission permanently denied
    if (permissionPermanentlyDenied) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.settings, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'Permission Required',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'Contacts permission was denied. Please enable it in your device settings to browse contacts.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onOpenSettings,
                icon: Icon(Icons.settings, size: 18.sp),
                label: const Text('Open Settings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Error state
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, size: 48.sp, color: Colors.red[300]),
              SizedBox(height: 16.h),
              Text(
                errorMessage,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: Icon(Icons.refresh, size: 18.sp),
                label: const Text('Try Again'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 78, 3, 208),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    // Empty contacts
    if (allContactsEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_off, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'No Contacts Found',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'No contacts with phone numbers were found on your device.',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Search no results
    if (filteredContacts.isEmpty && searchQuery.isNotEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(32.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.search_off, size: 48.sp, color: Colors.grey[400]),
              SizedBox(height: 16.h),
              Text(
                'No Results',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text(
                'No contacts match "$searchQuery"',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Contact list
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        return _buildContactListItem(contact: contact, onTap: onContactTap);
      },
    );
  }

  Widget _buildContactListItem({
    required DeviceContact contact,
    required void Function(DeviceContact) onTap,
  }) {
    return InkWell(
      onTap: () => onTap(contact),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Row(
          children: [
            // Avatar with initials
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 78, 3, 208),
                    Color.fromARGB(255, 120, 40, 240),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  contact.initials,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            SizedBox(width: 14.w),
            // Name and phone
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (contact.phoneNumber != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      contact.phoneNumber!,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[500],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
          ],
        ),
      ),
    );
  }

  // Contact bank verification state
  String? _contactSelectedBankCode;
  String? _contactSelectedBankName;
  AccountVerificationResult? _contactVerificationResult;

  void _showAddContactAsRecipientDialog(DeviceContact contact) {
    // Reset contact verification state
    _contactSelectedBankCode = null;
    _contactSelectedBankName = null;
    _contactVerificationResult = null;

    // First check if contact is a Lazervault user by phone number
    _checkIfLazerVaultUser(contact);
  }

  /// Check if contact is a Lazervault user via phone number lookup
  Future<void> _checkIfLazerVaultUser(DeviceContact contact) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LazerVaultLoader.small(),
              SizedBox(height: 16.h),
              Text(
                'Checking if ${contact.name} is on Lazervault...',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    try {
      final contactSyncCubit = context.read<ContactSyncCubit>();

      // Extract phone numbers from contact
      final phoneNumbers = contact.phoneNumbers.isNotEmpty
          ? contact.phoneNumbers
          : contact.phoneNumber != null ? [contact.phoneNumber!] : <String>[];

      // Extract emails
      final emails = contact.emails.isNotEmpty
          ? contact.emails
          : contact.email != null ? [contact.email!] : <String>[];

      if (phoneNumbers.isEmpty && emails.isEmpty) {
        // No contact info to lookup, show bank selection
        Navigator.pop(context); // Close loading dialog
        _showContactBankSelectionSheet(contact);
        return;
      }

      // Find Lazervault user by phone/email
      await contactSyncCubit.findLazerVaultUsers(
        phoneNumbers: phoneNumbers,
        emails: emails,
      );

      // Check result
      final state = contactSyncCubit.state;
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog

      if (state is ContactSyncUsersFound && state.matchedUsers.isNotEmpty) {
        // Found a Lazervault user - show confirmation and proceed
        final matchedUser = state.matchedUsers.first;
        _showLazerVaultUserFoundDialog(contact, matchedUser);
      } else {
        // Not a Lazervault user — offer to invite them (referral code + logo)
        // or fall back to a bank transfer.
        _showOffPlatformContactOptions(contact);
      }
    } catch (e) {
      if (!mounted) return;
      Navigator.pop(context); // Close loading dialog
      debugPrint('Error checking Lazervault user: $e');
      // On error, fallback to bank selection
      _showContactBankSelectionSheet(contact);
    }
  }

  /// Show dialog when contact is found to be a Lazervault user
  void _showLazerVaultUserFoundDialog(DeviceContact contact, LazerVaultUserMatchModel matchedUser) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle Bar
              Container(
                margin: EdgeInsets.only(bottom: 24.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Success Icon
              Container(
                width: 72.w,
                height: 72.h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 78, 3, 208),
                      Color.fromARGB(255, 95, 20, 225),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 36.sp,
                ),
              ),

              SizedBox(height: 24.h),

              Text(
                '${contact.name} is on Lazervault!',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 8.h),

              Text(
                'You can send money instantly to their personal account',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 24.h),

              // User Card
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    // Avatar
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: matchedUser.profilePhotoUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: Image.network(
                                matchedUser.profilePhotoUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Center(
                                  child: Text(
                                    matchedUser.name.isNotEmpty
                                        ? matchedUser.name.substring(0, 1).toUpperCase()
                                        : '?',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 78, 3, 208),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(
                                matchedUser.name.isNotEmpty
                                    ? matchedUser.name.substring(0, 1).toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 78, 3, 208),
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                matchedUser.name,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              if (matchedUser.isVerified) ...[
                                SizedBox(width: 4.w),
                                Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 16.sp,
                                ),
                              ],
                            ],
                          ),
                          if (matchedUser.username.isNotEmpty)
                            Text(
                              '@${matchedUser.username}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Color.fromARGB(255, 78, 3, 208),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Buttons
              Row(
                children: [
                  // Use Different Bank Button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        _showContactBankSelectionSheet(contact);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Use Bank',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  // Send to LazerVault Button
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(bottomSheetContext);
                        _proceedWithLazerVaultUser(contact, matchedUser);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 78, 3, 208),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Send to Lazervault',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: MediaQuery.of(bottomSheetContext).padding.bottom + 16.h),
            ],
          ),
        );
      },
    );
  }

  /// Proceed to payment with Lazervault user
  void _proceedWithLazerVaultUser(DeviceContact contact, LazerVaultUserMatchModel matchedUser) {
    final authState = context.read<AuthenticationCubit>().state;
    final profileState = context.read<ProfileCubit>().state;

    if (authState is! AuthenticationSuccess) {
      Get.snackbar(
        'Error',
        'Please log in to continue',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    final accessToken = authState.profile.session.accessToken;
    final countryCode = profileState is ProfileLoaded
        ? profileState.preferences.activeCountry
        : 'NG';

    // Create recipient with LazerVault details
    final recipient = RecipientModel(
      id: matchedUser.userId,
      name: matchedUser.name,
      accountNumber: '@${matchedUser.username}', // Use username as account identifier
      bankName: 'LazerVault',
      sortCode: '',
      isFavorite: false,
      isSaved: false,
      countryCode: countryCode,
      type: 'internal', // Explicitly set type for Lazervault users
      internalUserId: matchedUser.userId,
    );

    // Flow-aware continue: in the embedded (short) flow the parent wired
    // `onRecipientSelected`, so hand the recipient back and let it run its
    // inline amount → PIN → receipt sequence. Standalone (long) flow has no
    // callback and routes to the full initiate-send-funds screen. Previously
    // this always pushed the long-flow screen, which broke the short flow.
    if (widget.onRecipientSelected != null) {
      widget.onRecipientSelected!(recipient);
    } else {
      Get.toNamed(
        AppRoutes.initiateSendFunds,
        arguments: {
          'recipient': recipient,
          'accessToken': accessToken,
          'isLazerVaultUser': true,
          'lazerVaultUserId': matchedUser.userId,
        },
      );
    }
  }

  /// Share a Lazervault invite with an off-platform contact: the signed-in
  /// user's referral code + our logo, via the system share sheet. Any open
  /// contact/search sheet is closed by the caller before this runs.
  Future<void> _inviteContact(DeviceContact contact) async {
    // Resolve the signed-in user's referral code (best-effort — the invite
    // still shares without a code if the lookup fails).
    String? code;
    try {
      final result = await serviceLocator<GetMyReferralCodeUseCase>().call();
      code = result.fold((_) => null, (c) => c.code);
    } catch (_) {
      code = null;
    }

    final firstName =
        contact.name.trim().isNotEmpty ? contact.name.trim().split(' ').first : 'there';
    final message = (code != null && code.isNotEmpty)
        ? 'Hi $firstName, join me on Lazervault! Use my invite code $code when '
            'you sign up so we both get rewarded. Download: https://lazervault.app'
        : 'Hi $firstName, join me on Lazervault — the smarter way to send and '
            'manage money. Download: https://lazervault.app';

    // Attach our logo to the share (copied from the bundled asset to a temp
    // file, since share_plus shares files by path). Falls back to text-only.
    final files = <XFile>[];
    try {
      final data =
          await rootBundle.load('assets/images/logos/lazervault-full-logo.png');
      final dir = await getTemporaryDirectory();
      final f = File('${dir.path}/lazervault_invite.png');
      await f.writeAsBytes(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
      files.add(XFile(f.path));
    } catch (_) {
      // logo optional — share text only
    }

    await SharePlus.instance.share(
      ShareParams(
        text: message,
        subject: 'Join me on Lazervault',
        files: files.isEmpty ? null : files,
      ),
    );
  }

  /// Shown when a picked contact is confirmed NOT on Lazervault: invite them
  /// (share referral code + logo) or continue with a bank transfer.
  void _showOffPlatformContactOptions(DeviceContact contact) {
    const brand = Color.fromARGB(255, 78, 3, 208);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24.w,
            16.h,
            24.w,
            MediaQuery.of(sheetContext).padding.bottom + 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                '${contact.name} isn\'t on Lazervault yet',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Invite them to join with your code, or send to their bank account instead.',
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 20.h),
              // Primary: Invite to Lazervault
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _inviteContact(contact);
                  },
                  icon: Icon(Icons.person_add_alt_1, size: 18.sp, color: Colors.white),
                  label: Text(
                    'Invite to Lazervault',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: brand,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              // Secondary: Send to their bank
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                    _showContactBankSelectionSheet(contact);
                  },
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    side: BorderSide(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'Send to their bank',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Step 1: Show bank selection for contact
  Future<void> _showContactBankSelectionSheet(DeviceContact contact) async {
    // Same shared sheet (light). Replaces the old inline picker that created a
    // TextEditingController inside its builder and never disposed it — the
    // source of the `dependents.isEmpty` framework assertion.
    final bank = await BankPickerSheet.show(
      context,
      country: _currentCountry,
      selectedBankCode: _contactSelectedBankCode,
      theme: BankPickerTheme.light(),
    );
    if (!mounted || bank == null) return;
    _contactSelectedBankCode = bank['code'];
    _contactSelectedBankName = bank['name'];
    _showContactAccountNumberSheet(contact);
  }

  /// Step 2: Show account number entry for contact
  void _showContactAccountNumberSheet(DeviceContact contact) {
    final accountController = TextEditingController();
    bool isVerifying = false;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return BlocListener<AccountVerificationCubit,
                AccountVerificationState>(
              listener: (context, verificationState) {
                if (verificationState is AccountVerificationLoading) {
                  setSheetState(() {
                    isVerifying = true;
                  });
                } else if (verificationState is AccountVerificationSuccess) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  // Store verification result
                  _contactVerificationResult = AccountVerificationResult(
                    accountNumber: verificationState.accountNumber,
                    accountName: verificationState.accountName,
                    bankName: verificationState.bankName,
                    bankCode: verificationState.bankCode,
                    verificationStatus: verificationState.verificationStatus,
                  );
                  // Close account number sheet and show confirmation
                  Navigator.pop(bottomSheetContext);
                  _showContactConfirmationSheet(contact);
                } else if (verificationState is AccountVerificationFailure) {
                  setSheetState(() {
                    isVerifying = false;
                  });
                  Get.snackbar(
                    'Verification Failed',
                    verificationState.userMessage,
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red.withValues(alpha: 0.8),
                    colorText: Colors.white,
                  );
                }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle Bar
                      Center(
                        child: Container(
                          width: 40.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),

                      // Header
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: _getBankGradientColors(
                                    _contactSelectedBankName ?? ''),
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              _getBankInitials(_contactSelectedBankName ?? ''),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  contact.name,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  _contactSelectedBankName ?? '',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.sp,
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
                                color: Colors.grey[100],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.close,
                                color: Colors.grey[600],
                                size: 20.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 32.h),

                      // Account Number Label
                      Text(
                        'Account Number',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Account Number Field
                      TextField(
                        controller: accountController,
                        keyboardType: TextInputType.number,
                        maxLength: 10,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[50],
                          hintText: 'Enter 10-digit account number',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          prefixIcon: Icon(Icons.account_balance_wallet_rounded,
                              color: _kBrandPurple),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey[200]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 78, 3, 208),
                              width: 2,
                            ),
                          ),
                          counterText: '',
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {
                          setSheetState(() {});
                        },
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'Enter the 10-digit account number for ${contact.name}',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 12.sp,
                        ),
                      ),

                      Spacer(),

                      // Verify Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isVerifying ||
                                  accountController.text.length != 10
                              ? null
                              : () {
                                  // Verify account
                                  this
                                      .context
                                      .read<AccountVerificationCubit>()
                                      .verifyAccount(
                                        bankCode: _contactSelectedBankCode!,
                                        accountNumber: accountController.text,
                                        bankName: _contactSelectedBankName!,
                                      );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 78, 3, 208),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            disabledBackgroundColor: Colors.grey[300],
                          ),
                          child: isVerifying
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LazerVaultLoader.small(),
                                    SizedBox(width: 12.w),
                                    Text(
                                      'Verifying...',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  'Verify Account',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).padding.bottom + 16.h),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Step 3: Show confirmation with verified account name
  void _showContactConfirmationSheet(DeviceContact contact) {
    bool isSaved = false;
    bool isFavorite = false;
    String? alias;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Handle Bar
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Success Icon
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 48.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    Center(
                      child: Text(
                        'Account Verified!',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    // Account Details Card
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: [
                          _buildDetailRow(
                            'Account Name',
                            _contactVerificationResult?.accountName ?? '',
                            isHighlighted: true,
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Account Number',
                            _contactVerificationResult?.accountNumber ?? '',
                          ),
                          Divider(height: 24.h, color: Colors.grey[200]),
                          _buildDetailRow(
                            'Bank',
                            _contactVerificationResult?.bankName ?? '',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Save Recipient Toggle
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4E03D0).withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                isSaved ? Icons.bookmark : Icons.bookmark_outline,
                                color: isSaved ? const Color(0xFF4E03D0) : Colors.grey[600],
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Save Recipient',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Switch(
                                value: isSaved,
                                onChanged: (value) {
                                  setSheetState(() {
                                    isSaved = value;
                                    if (!value) isFavorite = false;
                                  });
                                },
                                activeThumbColor: const Color(0xFF4E03D0),
                              ),
                            ],
                          ),
                          if (isSaved) ...[
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(
                                  isFavorite ? Icons.star : Icons.star_border,
                                  color: isFavorite ? const Color(0xFFF59E0B) : Colors.grey[600],
                                  size: 24.sp,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text(
                                    'Add to Favorites',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Switch(
                                  value: isFavorite,
                                  onChanged: (value) {
                                    setSheetState(() {
                                      isFavorite = value;
                                    });
                                  },
                                  activeThumbColor: const Color(0xFFF59E0B),
                                ),
                              ],
                            ),
                          ],
                          // Alias input when saved
                          if (isSaved) ...[
                            SizedBox(height: 12.h),
                            TextField(
                              onChanged: (value) {
                                alias = value.isEmpty ? null : value;
                              },
                              decoration: InputDecoration(
                                hintText: 'Nickname (optional)',
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 14.sp,
                                ),
                                prefixIcon: Icon(
                                  Icons.edit_outlined,
                                  color: Colors.grey[500],
                                  size: 20.sp,
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                  borderSide: const BorderSide(color: Color(0xFF4E03D0)),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                              ),
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    Spacer(),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              // Reset state
                              _contactVerificationResult = null;
                            },
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              side: BorderSide(color: Colors.grey[300]!),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(bottomSheetContext);
                              // Proceed to payment with verified contact
                              _proceedToPaymentWithContact(
                                  contact, isSaved, isFavorite, alias);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 78, 3, 208),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Text(
                              'Proceed to Payment',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 16.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value,
      {bool isHighlighted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              color: isHighlighted ? Colors.green[700] : Colors.black87,
              fontSize: isHighlighted ? 16.sp : 14.sp,
              fontWeight: isHighlighted ? FontWeight.w700 : FontWeight.w600,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  /// Proceed to payment with verified contact
  void _proceedToPaymentWithContact(DeviceContact contact, bool isSaved, bool isFavorite, String? alias) {
    if (_contactVerificationResult == null) return;

    // Create temporary recipient model (not saved to DB yet)
    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _contactVerificationResult!.accountName,
      accountNumber: _contactVerificationResult!.accountNumber,
      bankName: _contactVerificationResult!.bankName,
      sortCode: _contactVerificationResult!.bankCode,
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
      type: 'external', // Explicitly set type for external bank recipients
    );

    // Short flow (embedded): hand back to the host screen instead of navigating.
    if (widget.onRecipientSelected != null) {
      widget.onRecipientSelected!(temporaryRecipient);
      return;
    }

    // Navigate to payment screen with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: temporaryRecipient,
    );
  }

  // ===== Account-number-first bank suggestions =====

  /// Account-number field change handler. Clears any prior verification, then
  /// (once a full 10-digit number is entered) debounces a backend suggestion
  /// call. Shorter/edited numbers immediately clear suggestions.
  /// Standalone "Scan Account" button rendered beside the account-number field
  /// (see the field builder). Brand-tinted so it reads as a tappable action;
  /// height is matched to the field via the enclosing IntrinsicHeight/stretch.
  Widget _buildScanAccountButton() {
    return Material(
      color: _kBrandPurple.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: widget.onScanAccount,
        child: Container(
          width: 62.w,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: _kBrandPurple.withValues(alpha: 0.25)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.document_scanner_outlined,
                  color: _kBrandPurple, size: 20.w),
              SizedBox(height: 2.h),
              Text(
                'Scan',
                style: TextStyle(
                  color: _kBrandPurple,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// A recipient account is "complete" at a 10-digit NUBAN OR an 11-digit wallet
  /// phone with a leading zero (OPay/PalmPay/Moniepoint) — the backend
  /// normalises the latter to its 10-digit NUBAN for resolution + suggestions.
  static bool _isAccountNumberComplete(String v) =>
      v.length == 10 || (v.length == 11 && v.startsWith('0'));

  void _onAccountNumberChanged(String value) {
    _suggestDebounce?.cancel();
    final complete = _isAccountNumberComplete(value);
    setState(() {
      if (_verificationResult != null) _verificationResult = null;
      if (!complete) {
        _bankSuggestions = [];
        _loadingSuggestions = false;
      }
    });
    if (complete) {
      setState(() => _loadingSuggestions = true);
      _suggestDebounce = Timer(
        const Duration(milliseconds: 400),
        () => _fetchBankSuggestions(value),
      );
    }
    _syncSuggestOverlay();
  }

  /// Fetch bank suggestions for a complete account number. Guards against stale
  /// responses (user kept typing) and never surfaces errors — suggestions are
  /// purely additive over the manual bank picker.
  Future<void> _fetchBankSuggestions(String accountNumber) async {
    if (!mounted) return;
    try {
      final suggestions = await context
          .read<AccountVerificationCubit>()
          .suggestBanks(accountNumber: accountNumber, country: _currentCountry);
      // Discard if the account number changed while we were waiting.
      if (!mounted || _accountController.text != accountNumber) return;
      setState(() {
        _bankSuggestions = suggestions;
        _loadingSuggestions = false;
      });
      _syncSuggestOverlay();
    } catch (_) {
      if (!mounted) return;
      setState(() => _loadingSuggestions = false);
      _syncSuggestOverlay();
    }
  }

  /// User tapped a suggested bank. Prefill the bank + code and reuse the already
  /// resolved holder name (no second verify round-trip), then open the same
  /// confirmation sheet the manual verify path uses.
  void _selectSuggestion(AccountSuggestion s) {
    setState(() {
      _bankController.text = s.bankName;
      _selectedBankCode = s.bankCode;
      _bankSuggestions = [];
      _loadingSuggestions = false;
      _verificationResult = AccountVerificationResult(
        accountNumber: s.accountNumber,
        accountName: s.accountName,
        bankName: s.bankName,
        bankCode: s.bankCode,
        verificationStatus: 'verified',
      );
    });
    _syncSuggestOverlay(); // hide the tooltip now that a bank is chosen
    _showAccountConfirmationBottomSheet(_verificationResult!);
  }

  /// Anchored bank-prediction tooltip. Floats just below the account-number
  /// field (via CompositedTransformFollower + LayerLink) so it overlays content
  /// instead of pushing the Bank field down, and follows the field on scroll.
  /// A full-screen transparent catcher behind it dismisses on tap-outside.
  Widget _buildSuggestionOverlay(BuildContext context) {
    // Nothing to show once a bank is verified, or when idle with no matches.
    if (_verificationResult != null ||
        (!_loadingSuggestions && _bankSuggestions.isEmpty)) {
      return const SizedBox.shrink();
    }
    // Match the field's width; fall back to the form width on the first frame
    // before the leader has reported its size.
    final double width = _accountFieldLink.leaderSize?.width ??
        (MediaQuery.of(context).size.width - 48.w);
    return Stack(
      children: [
        // Tap-outside dismiss.
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: _suggestOverlay.hide,
          ),
        ),
        CompositedTransformFollower(
          link: _accountFieldLink,
          showWhenUnlinked: false,
          targetAnchor: Alignment.bottomLeft,
          followerAnchor: Alignment.topLeft,
          offset: Offset(0, 6.h),
          child: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: width,
              child: Material(
                color: Colors.transparent,
                child: _buildSuggestionCard(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// The tooltip's inner card: a compact loading row while resolving, then a
  /// slim "Suggested bank(s)" label over the tappable matches (logo + resolved
  /// holder name + bank name).
  Widget _buildSuggestionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _kBrandPurple.withValues(alpha: 0.25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: _loadingSuggestions
          ? Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 16.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(_kBrandPurple),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Finding the bank…',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12.5.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 6.h),
                  child: Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded,
                          size: 14.sp, color: _kBrandPurple),
                      SizedBox(width: 6.w),
                      Text(
                        _bankSuggestions.length == 1
                            ? 'Suggested bank'
                            : 'Suggested banks',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < _bankSuggestions.length; i++) ...[
                  if (i > 0)
                    Divider(
                        height: 1,
                        color: Colors.grey[200],
                        indent: 12.w,
                        endIndent: 12.w),
                  _buildSuggestionRow(_bankSuggestions[i]),
                ],
              ],
            ),
    );
  }

  Widget _buildSuggestionRow(AccountSuggestion s) {
    return InkWell(
      onTap: () => _selectSuggestion(s),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            BankLogo(
              bankName: s.bankName,
              bankCode: s.bankCode,
              country: _currentCountry,
              size: 40,
              borderRadius: 10,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    s.accountName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    s.bankName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: _kBrandPurple, size: 20.sp),
          ],
        ),
      ),
    );
  }

  Future<void> _showBankSelectionBottomSheet() async {
    // Shared bank-search sheet (BankLogo + initials fallback, owns/disposes its
    // own controller). Light variant for the send-funds / add-recipient surface.
    final bank = await BankPickerSheet.show(
      context,
      country: _currentCountry,
      selectedBankCode: _selectedBankCode,
      theme: BankPickerTheme.light(),
    );
    if (!mounted || bank == null) return;
    setState(() {
      _bankController.text = bank['name'] ?? '';
      _selectedBankCode = bank['code']; // stored for verification
      _verificationResult = null; // a new bank invalidates any prior name check
      // Manually picking a bank supersedes the prediction tooltip — drop its
      // (now-irrelevant) matches so it can't re-appear over the chosen bank.
      _bankSuggestions = [];
      _loadingSuggestions = false;
    });
    _syncSuggestOverlay();
  }

  List<Color> _getBankGradientColors(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return [Color(0xFFFF6600), Color(0xFFCC5200)];
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return [Color(0xFFFF6600), Color(0xFFCC4400)];
    if (lowerName.contains('first bank')) return [Color(0xFF003366), Color(0xFF002244)];
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('zenith')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('kuda')) return [Color(0xFF6B47ED), Color(0xFF5533CC)];
    if (lowerName.contains('opay')) return [Color(0xFF00C853), Color(0xFF009624)];
    if (lowerName.contains('palmpay')) return [Color(0xFF6C63FF), Color(0xFF5046E5)];
    if (lowerName.contains('fidelity')) return [Color(0xFF006B3F), Color(0xFF004D2D)];
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return [Color(0xFF6B2D7B), Color(0xFF4A1F55)];
    if (lowerName.contains('sterling')) return [Color(0xFFCC0000), Color(0xFF990000)];
    if (lowerName.contains('stanbic')) return [Color(0xFF0033A1), Color(0xFF002277)];
    if (lowerName.contains('ecobank')) return [Color(0xFF004C91), Color(0xFF003366)];
    if (lowerName.contains('union bank')) return [Color(0xFF003087), Color(0xFF002266)];
    if (lowerName.contains('wema') || lowerName.contains('alat')) return [Color(0xFF6B2D7B), Color(0xFF4A1F55)];
    if (lowerName.contains('polaris')) return [Color(0xFF003399), Color(0xFF002266)];
    if (lowerName.contains('keystone')) return [Color(0xFF0066CC), Color(0xFF004488)];
    if (lowerName.contains('heritage')) return [Color(0xFF006633), Color(0xFF004422)];
    if (lowerName.contains('moniepoint')) return [Color(0xFF0066FF), Color(0xFF0044CC)];
    if (lowerName.contains('carbon')) return [Color(0xFF00C9A7), Color(0xFF00A386)];

    // UK Banks
    if (lowerName.contains('barclays')) return [Color(0xFF0071CE), Color(0xFF004A8F)];
    if (lowerName.contains('hsbc')) return [Color(0xFFDB0011), Color(0xFFB8000E)];
    if (lowerName.contains('lloyds')) return [Color(0xFF006A4E), Color(0xFF004D3A)];
    if (lowerName.contains('natwest')) return [Color(0xFF5D2A8F), Color(0xFF4A1F75)];
    if (lowerName.contains('santander')) return [Color(0xFFEC0000), Color(0xFFD10000)];
    if (lowerName.contains('monzo')) return [Color(0xFFFF5A5F), Color(0xFFE64850)];
    if (lowerName.contains('starling')) return [Color(0xFF6935D3), Color(0xFF5229A8)];
    if (lowerName.contains('revolut')) return [Color(0xFF0073E6), Color(0xFF005BB5)];

    // Default gradient
    return [Color(0xFF78039C), Color(0xFF5F14E1)];
  }

  String _getBankInitials(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'AB';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return 'GT';
    if (lowerName.contains('first bank')) return 'FB';
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return 'UBA';
    if (lowerName.contains('zenith')) return 'ZB';
    if (lowerName.contains('kuda')) return 'KD';
    if (lowerName.contains('opay')) return 'OP';
    if (lowerName.contains('palmpay')) return 'PP';
    if (lowerName.contains('fidelity')) return 'FD';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return 'FC';
    if (lowerName.contains('sterling')) return 'SB';
    if (lowerName.contains('stanbic')) return 'SI';
    if (lowerName.contains('ecobank')) return 'EB';
    if (lowerName.contains('union bank')) return 'UB';
    if (lowerName.contains('wema')) return 'WB';
    if (lowerName.contains('alat')) return 'AL';
    if (lowerName.contains('polaris')) return 'PB';
    if (lowerName.contains('keystone')) return 'KB';
    if (lowerName.contains('heritage')) return 'HB';
    if (lowerName.contains('moniepoint')) return 'MP';
    if (lowerName.contains('carbon')) return 'CB';

    // UK Banks
    if (lowerName.contains('barclays')) return 'BC';
    if (lowerName.contains('hsbc')) return 'HS';
    if (lowerName.contains('lloyds')) return 'LB';
    if (lowerName.contains('natwest')) return 'NW';
    if (lowerName.contains('santander')) return 'SU';
    if (lowerName.contains('monzo')) return 'MZ';
    if (lowerName.contains('starling')) return 'SL';
    if (lowerName.contains('revolut')) return 'RV';

    // Default: first two characters
    if (bankName.length >= 2) {
      return bankName.substring(0, 2).toUpperCase();
    }
    return bankName.toUpperCase();
  }

  String _getBankDescription(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'Personal & Business Banking';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return 'Digital Banking Leader';
    if (lowerName.contains('first bank')) return 'Nigeria\'s First Bank';
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return 'Africa\'s Global Bank';
    if (lowerName.contains('zenith')) return 'In Your Best Interest';
    if (lowerName.contains('kuda')) return 'Bank of the Free';
    if (lowerName.contains('opay')) return 'Digital Payments';
    if (lowerName.contains('palmpay')) return 'Mobile Money Services';
    if (lowerName.contains('fidelity')) return 'Truly Dependable';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return 'My Bank and I';
    if (lowerName.contains('sterling')) return 'Your One-Customer Bank';
    if (lowerName.contains('stanbic')) return 'Moving Forward';
    if (lowerName.contains('ecobank')) return 'Pan-African Banking';
    if (lowerName.contains('union bank')) return 'Big. Strong. Reliable';
    if (lowerName.contains('wema') || lowerName.contains('alat')) return 'Digital Banking';
    if (lowerName.contains('moniepoint')) return 'Financial Services';
    if (lowerName.contains('carbon')) return 'Digital Finance';

    // UK Banks
    if (lowerName.contains('barclays')) return 'Personal & Business Banking';
    if (lowerName.contains('hsbc')) return 'Global Banking Services';
    if (lowerName.contains('lloyds')) return 'Everyday Banking Solutions';
    if (lowerName.contains('natwest')) return 'Royal Bank of Scotland Group';
    if (lowerName.contains('santander')) return 'Consumer & Business Banking';
    if (lowerName.contains('monzo')) return 'Smart Money Management';
    if (lowerName.contains('starling')) return 'Digital Banking';
    if (lowerName.contains('revolut')) return 'Financial Super App';

    return 'Banking Services';
  }

  // ========== New Account Verification Methods ==========

  /// Handle account verification via Paystack API
  Future<void> _handleVerifyAccount() async {
    final accountNumber = _accountController.text.trim();
    final bankName = _bankController.text;

    // Validate bank selection
    if (bankName == "Select Bank") {
      Get.snackbar(
        'Bank Required',
        'Please select a bank first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Validate account number
    if (accountNumber.isEmpty) {
      Get.snackbar(
        'Account Number Required',
        'Please enter the account number',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Validate 10 digits for Nigerian accounts
    if (accountNumber.length != 10 || !RegExp(r'^\d+$').hasMatch(accountNumber)) {
      Get.snackbar(
        'Invalid Account Number',
        'Account number must be exactly 10 digits',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    if (_selectedBankCode == null) {
      Get.snackbar(
        'Error',
        'Bank code not found. Please reselect the bank.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    // Funnel: the long-flow recipient bank-account verification step.
    AnalyticsService.instance.trackSendFundsScreen('recipient_verify', 'long');

    // Call verification cubit
    await context.read<AccountVerificationCubit>().verifyAccount(
          bankCode: _selectedBankCode!,
          accountNumber: accountNumber,
          bankName: bankName,
        );
  }

  /// Show manual account name entry when auto-verification is unavailable (rate limit)
  void _showManualAccountNameBottomSheet() {
    final nameController = TextEditingController();
    final accountNumber = _accountController.text.trim();
    final bankName = _bankController.text;
    final bankCode = _selectedBankCode ?? '';

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (sheetContext) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * 0.55,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
            ),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.edit_note, color: Colors.orange, size: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Enter Account Name',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Auto-verification temporarily unavailable',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  // Bank & account info
                  Container(
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bank', style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                            Text(bankName, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Account', style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
                            Text(accountNumber, style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600, letterSpacing: 1)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Name input
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    textCapitalization: TextCapitalization.words,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    decoration: InputDecoration(
                      hintText: 'Account holder full name',
                      hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.08),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(color: Colors.deepPurple.withValues(alpha: 0.6)),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Confirm button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final name = nameController.text.trim();
                        if (name.isEmpty) {
                          Get.snackbar('Name Required', 'Please enter the account holder name',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange.withValues(alpha: 0.8),
                              colorText: Colors.white);
                          return;
                        }
                        Navigator.pop(sheetContext);

                        // Create result with manually entered name
                        final result = AccountVerificationResult(
                          accountNumber: accountNumber,
                          accountName: name,
                          bankName: bankName,
                          bankCode: bankCode,
                          verificationStatus: 'manual',
                        );
                        _verificationResult = result;
                        _showAccountConfirmationBottomSheet(result);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4E03D0),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Show account confirmation bottomsheet after successful verification
  void _showAccountConfirmationBottomSheet(AccountVerificationResult result) {
    // Any confirmation sheet means a bank is chosen — the prediction tooltip
    // must not float over/behind it (covers the manual-name fallback path,
    // which sets _verificationResult without going through _syncSuggestOverlay).
    if (_suggestOverlay.isShowing) _suggestOverlay.hide();
    final sheetKey = GlobalKey<AccountConfirmationBottomSheetState>();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
      builder: (sheetContext) {
        return AccountConfirmationBottomSheet(
          key: sheetKey,
          accountNumber: result.accountNumber,
          accountName: result.accountName,
          bankName: result.bankName,
          bankCode: result.bankCode,
          onConfirm: () {
            // Get save/favorite/alias status from bottomsheet via GlobalKey
            final sheetState = sheetKey.currentState;
            final isSaved = sheetState?.isSaved ?? false;
            final isFavorite = sheetState?.isFavorite ?? false;
            final alias = sheetState?.alias;

            // Close bottomsheet
            Navigator.pop(sheetContext);

            // Proceed to payment WITHOUT saving to DB (Lemfi-style)
            _proceedToPayment(result, isSaved, isFavorite, alias);
          },
          onCancel: () {
            // Close bottomsheet and reset verification
            Navigator.pop(sheetContext);
            setState(() {
              _verificationResult = null;
            });
            _syncSuggestOverlay();
          },
        );
      },
    );
  }

  /// Proceed to payment screen without saving recipient to database
  /// (Lemfi-style: only save after successful payment)
  void _proceedToPayment(AccountVerificationResult result, bool isSaved, bool isFavorite, String? alias) {
    // Create temporary recipient model (not saved to DB yet)
    final temporaryRecipient = RecipientModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
      name: result.accountName,
      accountNumber: result.accountNumber,
      bankName: result.bankName,
      sortCode: result.bankCode, // Use bank code as sort code for Nigerian banks
      isFavorite: isFavorite,
      isSaved: isSaved,
      alias: alias,
      countryCode: 'NG',
      currency: 'NGN',
      type: 'external', // Explicitly set type for external bank recipients
    );

    // Short flow (embedded): hand back to the host screen instead of navigating.
    if (widget.onRecipientSelected != null) {
      widget.onRecipientSelected!(temporaryRecipient);
      return;
    }

    // Navigate to payment screen with temporary recipient
    Get.offNamed(
      AppRoutes.initiateSendFunds,
      arguments: temporaryRecipient,
    );
  }
}
