import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../domain/entities/country.dart';
import '../../domain/entities/network_provider.dart';
import '../cubit/airtime_cubit.dart';
import '../cubit/airtime_state.dart';
import '../widgets/airtime_contact_picker_sheet.dart';

/// Consolidated airtime purchase screen.
///
/// Combines network selection + phone + amount in a single step, mirroring the
/// airtime-to-cash flow. Supports both "Buy for Self" and "Send to Others":
/// - isBuyForSelf=true: phone auto-fills from user profile and is locked. If
///   the user has no phone on file, the field becomes editable with a notice.
/// - isBuyForSelf=false: user types any recipient number; a name field shows.
/// Network is auto-detected from the phone prefix.
class AirtimePurchaseScreen extends StatefulWidget {
  const AirtimePurchaseScreen({super.key});

  @override
  State<AirtimePurchaseScreen> createState() => _AirtimePurchaseScreenState();
}

class _AirtimePurchaseScreenState extends State<AirtimePurchaseScreen> {
  // Display-only fallback providers shown while live list (synced from VTpass +
  // Reloadly) loads. operatorId is intentionally null — purchase is gated on a
  // live provider being loaded, since only the backend sync knows the correct
  // gateway-specific operator IDs.
  static List<NetworkProvider> _fallbackProviders() => [
        NetworkProvider(
          id: 'mtn',
          type: NetworkProviderType.mtn,
          name: NetworkProviderType.mtn.displayName,
          shortName: NetworkProviderType.mtn.shortName,
          logo: NetworkProviderType.mtn.logo,
          primaryColor: NetworkProviderType.mtn.primaryColor,
          prefixes: NetworkProviderType.mtn.prefixes,
          countryCode: 'NG',
        ),
        NetworkProvider(
          id: 'airtel',
          type: NetworkProviderType.airtel,
          name: NetworkProviderType.airtel.displayName,
          shortName: NetworkProviderType.airtel.shortName,
          logo: NetworkProviderType.airtel.logo,
          primaryColor: NetworkProviderType.airtel.primaryColor,
          prefixes: NetworkProviderType.airtel.prefixes,
          countryCode: 'NG',
        ),
        NetworkProvider(
          id: 'glo',
          type: NetworkProviderType.glo,
          name: NetworkProviderType.glo.displayName,
          shortName: NetworkProviderType.glo.shortName,
          logo: NetworkProviderType.glo.logo,
          primaryColor: NetworkProviderType.glo.primaryColor,
          prefixes: NetworkProviderType.glo.prefixes,
          countryCode: 'NG',
        ),
        NetworkProvider(
          id: '9mobile',
          type: NetworkProviderType.ninemobile,
          name: NetworkProviderType.ninemobile.displayName,
          shortName: NetworkProviderType.ninemobile.shortName,
          logo: NetworkProviderType.ninemobile.logo,
          primaryColor: NetworkProviderType.ninemobile.primaryColor,
          prefixes: NetworkProviderType.ninemobile.prefixes,
          countryCode: 'NG',
        ),
      ];

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _amountFocus = FocusNode();

  List<NetworkProvider> _providers = _fallbackProviders();
  NetworkProvider? _selectedProvider;
  Country _country = DefaultCountries.nigeria;
  double? _amount;

  bool _isBuyForSelf = false;
  bool _hasUserPhoneOnFile = false;
  bool _phoneFieldLocked = false;

  static const _quickAmounts = [100.0, 200.0, 500.0, 1000.0, 2000.0, 5000.0];

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _phoneController.addListener(_onPhoneChanged);
    // Load live providers in background — merge when available.
    context.read<AirtimeCubit>().loadNetworkProviders(_country.code);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _nameController.dispose();
    _phoneFocus.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  bool _isRepeat = false;

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _isBuyForSelf = args['isBuyForSelf'] as bool? ?? false;
      final argCountry = args['country'] as Country?;
      if (argCountry != null) _country = argCountry;

      // Repeat-purchase hand-off from the history sheet: prefill phone +
      // amount, lock the phone (the whole point of "repeat" is the same
      // recipient), leave amount editable so the user can adjust before
      // resending.
      _isRepeat = args['isRepeat'] as bool? ?? false;
      if (_isRepeat) {
        final phone = args['phoneNumber']?.toString() ?? '';
        if (phone.isNotEmpty) {
          var local = phone;
          if (local.startsWith('+234')) {
            local = '0${local.substring(4)}';
          } else if (local.startsWith('234') && local.length > 10) {
            local = '0${local.substring(3)}';
          }
          _phoneController.text = local;
          _phoneFieldLocked = true;
        }
        final amt = args['amount'];
        if (amt is num && amt > 0) {
          _amountController.text = amt.toStringAsFixed(0);
        }
        final networkType = args['networkType']?.toString();
        if (networkType != null && networkType.isNotEmpty) {
          // Run prefix detection on the prefilled phone so the network tile
          // is correctly pre-selected and locked.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _onPhoneChanged();
          });
        }
        // Repeat takes priority over buy-for-self auto-prefill below.
        return;
      }
    }

    if (_isBuyForSelf) {
      final auth = context.read<AuthenticationCubit>().state;
      String? userPhone;
      if (auth is AuthenticationAuthenticated) {
        userPhone = auth.profile.user.phoneNumber;
      }
      if (userPhone != null && userPhone.isNotEmpty) {
        // Normalize +234... and 234... to local 0...
        if (userPhone.startsWith('+234')) {
          userPhone = '0${userPhone.substring(4)}';
        } else if (userPhone.startsWith('234') && userPhone.length > 10) {
          userPhone = '0${userPhone.substring(3)}';
        }
        _phoneController.text = userPhone;
        _hasUserPhoneOnFile = true;
        _phoneFieldLocked = true;
        _nameController.text = 'Self';
      } else {
        _hasUserPhoneOnFile = false;
        _phoneFieldLocked = false;
      }
    }
  }

  /// True when the current selection came from prefix auto-detection.
  /// Locks the network grid so the user can't accidentally pick a different
  /// carrier than the one matching their phone number — every edit to the
  /// phone re-runs detection and overrides any previous manual choice.
  bool _networkAutoDetected = false;

  void _onPhoneChanged() {
    if (!mounted) return;
    final phone = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    NetworkProvider? detected;
    if (phone.length >= 4) {
      detected = _detectFromPrefix(phone);
    }
    setState(() {
      if (detected != null) {
        _selectedProvider = detected;
        _networkAutoDetected = true;
      } else if (phone.length < 4) {
        _selectedProvider = null;
        _networkAutoDetected = false;
      } else {
        // Phone is long enough but no prefix matched (unusual NG number) —
        // unlock manual selection so the user can still proceed.
        _networkAutoDetected = false;
      }
    });
  }

  /// Normalizes backend operator records into the 4 canonical Nigerian
  /// networks (MTN / Airtel / Glo / 9mobile), **consolidating both provider
  /// catalogs (VTpass + Reloadly) into a single tile per network**. Display
  /// names are forced to the local short name so the UI never shows provider
  /// marketing strings like "Globacom Nigeria" or "9mobile Nigeria".
  ///
  /// Guarantees: if any canonical network is missing from live data, it is
  /// filled in from [_fallbackProviders] so the user always sees all four.
  /// Backend retains the original operator_id / reloadly_operator_id for
  /// provider routing — this only rewrites presentation fields.
  List<NetworkProvider> _filterAndDedupe(List<NetworkProvider> providers) {
    if (_country.code != 'NG') {
      // Non-NG countries: keep whatever backend returned (minimal touch).
      return providers;
    }
    const canonical = <NetworkProviderType>[
      NetworkProviderType.mtn,
      NetworkProviderType.airtel,
      NetworkProviderType.glo,
      NetworkProviderType.ninemobile,
    ];

    /// Resolve a backend record to one of the 4 canonical types by inspecting
    /// both the type the model produced AND the raw name — this catches cases
    /// where backend labels ("T2", "Globacom Nigeria", "etisalat") don't map
    /// cleanly in the model layer.
    NetworkProviderType? resolve(NetworkProvider p) {
      if (canonical.contains(p.type)) return p.type;
      if (p.type == NetworkProviderType.etisalat) {
        return NetworkProviderType.ninemobile;
      }
      final n = '${p.name} ${p.shortName}'.toLowerCase();
      if (n.contains('mtn')) return NetworkProviderType.mtn;
      if (n.contains('airtel')) return NetworkProviderType.airtel;
      if (n.contains('glo') || n.contains('globacom')) {
        return NetworkProviderType.glo;
      }
      if (n.contains('9mobile') ||
          n.contains('9 mobile') ||
          n.contains('nine mobile') ||
          n.contains('etisalat')) {
        return NetworkProviderType.ninemobile;
      }
      return null;
    }

    // Keep the first backend record matched for each canonical type — that
    // preserves its ids/prefixes (needed for backend routing) while letting
    // us override display fields below.
    final matched = <NetworkProviderType, NetworkProvider>{};
    for (final p in providers) {
      final t = resolve(p);
      if (t == null) continue;
      matched.putIfAbsent(t, () => p);
    }

    // Assemble in canonical order, filling missing entries from the fallback
    // list so the user always sees all 4 networks regardless of which
    // provider's catalog is degraded.
    final fallback = {for (final p in _fallbackProviders()) p.type: p};
    final result = <NetworkProvider>[];
    for (final t in canonical) {
      final src = matched[t] ?? fallback[t];
      if (src == null) continue;
      // Force clean, local display names — drops "Nigeria" / "Globacom" etc.
      // Preserve operatorId/reloadlyOperatorId from the live backend record so
      // BuyAirtime can route to the correct provider; without these the
      // backend rejects the purchase with "operator ID is required".
      result.add(NetworkProvider(
        id: src.id,
        type: t,
        name: t.shortName,
        shortName: t.shortName,
        logo: t.logo,
        primaryColor: t.primaryColor,
        prefixes: src.prefixes.isNotEmpty ? src.prefixes : t.prefixes,
        countryCode: 'NG',
        isActive: src.isActive,
        discount: src.discount,
        promoMessage: src.promoMessage,
        minAmount: src.minAmount,
        maxAmount: src.maxAmount,
        operatorId: src.operatorId,
        reloadlyOperatorId: src.reloadlyOperatorId,
      ));
    }
    return result;
  }

  /// Nigerian-prefix detection (first 4 digits). Independent of provider
  /// `prefixes` field format, which can differ between fallback and live data.
  NetworkProvider? _detectFromPrefix(String phone) {
    if (phone.length < 4) return null;
    final p = phone.substring(0, 4);
    const mtn = [
      '0803', '0806', '0810', '0813', '0814', '0816',
      '0903', '0906', '0913', '0916',
      '0703', '0706', '0704'
    ];
    const airtel = [
      '0802', '0808', '0812',
      '0701', '0708',
      '0901', '0902', '0904', '0907', '0912'
    ];
    const glo = ['0805', '0807', '0811', '0815', '0705', '0905', '0915'];
    const mobile9 = ['0809', '0817', '0818', '0819', '0908', '0909'];

    NetworkProviderType? type;
    if (mtn.contains(p)) {
      type = NetworkProviderType.mtn;
    } else if (airtel.contains(p)) {
      type = NetworkProviderType.airtel;
    } else if (glo.contains(p)) {
      type = NetworkProviderType.glo;
    } else if (mobile9.contains(p)) {
      type = NetworkProviderType.ninemobile;
    }
    if (type == null) return null;

    // Match by type against current provider list (live or fallback).
    for (final provider in _providers) {
      if (provider.type == type) return provider;
      // etisalat and ninemobile are effectively the same carrier
      if (type == NetworkProviderType.ninemobile &&
          provider.type == NetworkProviderType.etisalat) {
        return provider;
      }
    }
    return null;
  }

  bool get _phoneValid {
    final digits = _phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length == 11 && digits.startsWith('0');
  }

  bool get _amountValid =>
      _amount != null && _amount! >= 50 && _amount! <= 50000;

  // Continue activates as soon as the user has a valid phone, amount,
  // and a selected network. The live operatorId/reloadlyOperatorId
  // enrichment happens asynchronously after backend providers arrive —
  // gating on it here previously meant Continue stayed disabled on
  // repeat-purchase prefill until the user touched the amount field
  // (any keystroke triggered a rebuild that re-evaluated the gate
  // against the by-then-loaded providers). _proceed re-resolves the
  // selection against the live list at submit time so the operator
  // routing fields are always present on the wire.
  bool get _canProceed =>
      _phoneValid && _amountValid && _selectedProvider != null;

  void _proceed() {
    if (!_canProceed) return;
    final phone = _phoneController.text.trim();
    final recipientName =
        _isBuyForSelf ? 'Self' : _nameController.text.trim();

    // Late binding: prefer the live `_providers` entry of the same
    // type so the backend record (with operatorId / reloadlyOperatorId)
    // is what reaches the review screen. Falls back to the prefix-
    // detected provider if no live record matches (degraded backend).
    final selected = _selectedProvider!;
    final live = _providers.firstWhere(
      (p) => p.type == selected.type,
      orElse: () => selected,
    );
    final hasIds = (live.operatorId ?? '').isNotEmpty ||
        (live.reloadlyOperatorId ?? '').isNotEmpty;
    if (!hasIds) {
      // Live providers haven't arrived yet — show a soft banner and
      // wait. This should be rare (the cubit pre-fetches in initState),
      // but we'd rather surface the wait than navigate to a review
      // that the backend would reject with "operator ID is required".
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Loading network details… please retry in a moment.'),
          backgroundColor: const Color(0xFFFB923C),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(16.w),
          duration: const Duration(seconds: 2),
        ),
      );
      // Re-trigger the load so the screen recovers without a manual nudge.
      context.read<AirtimeCubit>().loadNetworkProviders(_country.code);
      return;
    }

    context.read<AirtimeCubit>().prepareTransactionReview(
          country: _country,
          provider: live,
          phoneNumber: phone,
          recipientName: recipientName,
          amount: _amount!,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AirtimeCubit, AirtimeState>(
      listener: (context, state) {
        if (state is AirtimeNetworkProvidersLoaded &&
            state.countryCode == _country.code &&
            state.providers.isNotEmpty) {
          setState(() {
            _providers = _filterAndDedupe(state.providers);
            if (_selectedProvider != null) {
              final updated = _providers.firstWhere(
                (p) => p.type == _selectedProvider!.type,
                orElse: () => _selectedProvider!,
              );
              _selectedProvider = updated;
            } else {
              _onPhoneChanged();
            }
          });
        } else if (state is AirtimeNetworkProvidersError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Couldn\'t load live networks: ${state.message}. Using defaults.',
              ),
              backgroundColor: const Color(0xFFFB923C),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.w),
            ),
          );
        } else if (state is AirtimeTransactionReviewReady) {
          Get.toNamed(AppRoutes.airtimeReview, arguments: {
            'country': state.country,
            'provider': state.provider,
            'phoneNumber': state.phoneNumber,
            'recipientName': state.recipientName,
            'amount': state.amount,
            'fee': state.fee,
            'totalAmount': state.totalAmount,
          });
        } else if (state is AirtimeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: const Color(0xFFEF4444),
              behavior: SnackBarBehavior.floating,
              margin: EdgeInsets.all(16.w),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      _buildInfoBanner(),
                      SizedBox(height: 20.h),
                      Text(
                        'Select Network',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      _buildNetworkGrid(),
                      SizedBox(height: 20.h),
                      _buildPhoneInput(),
                      if (!_isBuyForSelf) ...[
                        SizedBox(height: 16.h),
                        _buildNameInput(),
                      ],
                      SizedBox(height: 16.h),
                      _buildAmountInput(),
                      SizedBox(height: 12.h),
                      _buildQuickAmounts(),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
              _buildContinueButton(),
            ],
          ),
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
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 18.sp),
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
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _isBuyForSelf
                      ? 'Top up your registered phone number'
                      : 'Send airtime to anyone in a flash',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isBuyForSelf
              ? const [Color(0xFF4E03D0), Color(0xFF1E40AF)]
              : const [Color(0xFF10B981), Color(0xFF059669)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              _isBuyForSelf ? Icons.phone_android : Icons.send,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _isBuyForSelf
                  ? 'Enter an amount — we\'ll auto-detect your network from your phone number.'
                  : 'Enter the recipient\'s phone number and amount — network is detected automatically.',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 10.h,
      childAspectRatio: 0.95,
      children: _providers.map(_buildNetworkTile).toList(),
    );
  }

  Widget _buildNetworkTile(NetworkProvider p) {
    final isSelected = _selectedProvider?.id == p.id;
    final color = p.type.color;
    final locked = _networkAutoDetected;
    final dimmed = locked && !isSelected;
    return GestureDetector(
      // When auto-detect locks the grid, non-selected tiles are already
      // dimmed/disabled visually — no need for a snackbar on tap.
      onTap: locked ? null : () => setState(() => _selectedProvider = p),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withValues(alpha: 0.2)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        foregroundDecoration: dimmed
            ? BoxDecoration(
                color: const Color(0xFF0A0A0A).withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(12.r),
              )
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36.w,
              height: 36.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10.r),
              ),
              alignment: Alignment.center,
              child: Text(
                p.shortName.isNotEmpty ? p.shortName[0] : '?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              p.shortName,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openContactPicker() {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AirtimeContactPickerSheet(
        onPicked: (name, phone) {
          setState(() {
            _phoneController.text = phone;
            if (!_isBuyForSelf) _nameController.text = name;
          });
        },
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Phone Number',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            if (!_isBuyForSelf || !_phoneFieldLocked)
              GestureDetector(
                onTap: _openContactPicker,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4E03D0).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: const Color(0xFF4E03D0).withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.contacts_outlined,
                          size: 14.sp, color: const Color(0xFF4E03D0)),
                      SizedBox(width: 6.w),
                      Text(
                        'Load from Contacts',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF4E03D0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: TextField(
            controller: _phoneController,
            focusNode: _phoneFocus,
            readOnly: _phoneFieldLocked,
            enabled: !_phoneFieldLocked,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(11),
            ],
            style: TextStyle(
              fontSize: 16.sp,
              color: _phoneFieldLocked
                  ? const Color(0xFF9CA3AF)
                  : Colors.white,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '08012345678',
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF).withValues(alpha: 0.5),
                fontSize: 16.sp,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
                child: Text(
                  _country.dialCode,
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: const Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              suffixIcon: (_isBuyForSelf && _hasUserPhoneOnFile)
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          _phoneFieldLocked = !_phoneFieldLocked;
                        });
                        if (!_phoneFieldLocked) {
                          _phoneFocus.requestFocus();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Icon(
                          _phoneFieldLocked
                              ? Icons.edit_outlined
                              : Icons.check,
                          color: _phoneFieldLocked
                              ? const Color(0xFF4E03D0)
                              : const Color(0xFF10B981),
                          size: 20.sp,
                        ),
                      ),
                    )
                  : (_phoneValid
                      ? Icon(Icons.check_circle,
                          color: const Color(0xFF10B981), size: 20.sp)
                      : null),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
        // Notice when self has no phone on file → offer a quick path to add
        // it in profile settings, plus a fallback note that they can still
        // enter a number below for a one-off purchase.
        if (_isBuyForSelf && !_hasUserPhoneOnFile) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFB923C).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: const Color(0xFFFB923C).withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline,
                        color: const Color(0xFFFB923C), size: 14.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        'No phone number on your profile. Add it once and '
                        'we\'ll pre-fill it here every time you buy for yourself.',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: const Color(0xFFFB923C),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    SizedBox(
                      height: 32.h,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          await Get.toNamed(AppRoutes.myAccount);
                          if (!mounted) return;
                          // Re-read profile when returning — if the user
                          // added a number, lock the field and prefill.
                          _loadArguments();
                          setState(() {});
                        },
                        icon: Icon(Icons.person_add_alt_1, size: 14.sp),
                        label: Text(
                          'Add phone in profile',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFB923C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Or type a number below for just this purchase.',
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color(0xFFFB923C).withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        // Hint for self with phone: edit icon toggles override for this purchase.
        if (_isBuyForSelf && _hasUserPhoneOnFile) ...[
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.info_outline,
                  color: Colors.white.withValues(alpha: 0.45), size: 12.sp),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  _phoneFieldLocked
                      ? 'Using your registered number. Tap the pencil to use a different number for this purchase only.'
                      : 'Editing for this purchase only — your profile number won\'t change.',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.white.withValues(alpha: 0.55),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ],
        // Detected network chip
        if (_selectedProvider != null &&
            _phoneController.text.length >= 4) ...[
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: _selectedProvider!.type.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle,
                    color: const Color(0xFF10B981), size: 14.sp),
                SizedBox(width: 6.w),
                Text(
                  'Detected: ${_selectedProvider!.shortName}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF10B981),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildNameInput() {
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
              prefixIcon: Icon(Icons.person_outline,
                  color: const Color(0xFF9CA3AF), size: 20.sp),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Amount',
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
            controller: _amountController,
            focusNode: _amountFocus,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            onChanged: (v) {
              setState(() {
                _amount = v.isNotEmpty ? double.tryParse(v) : null;
              });
            },
            style: TextStyle(
              fontSize: 22.sp,
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                child: Text(
                  _country.currencySymbol,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              prefixIconConstraints: const BoxConstraints(),
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          'Min: ${_country.currencySymbol}50  •  Max: ${_country.currencySymbol}50,000',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white.withValues(alpha: 0.45),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAmounts() {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _quickAmounts.map((amt) {
        final isSelected = _amount == amt;
        return GestureDetector(
          onTap: () {
            setState(() => _amount = amt);
            _amountController.text = amt.toStringAsFixed(0);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF4E03D0)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '${_country.currencySymbol}${amt.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _canProceed ? _proceed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _canProceed
                ? const Color(0xFF4E03D0)
                : const Color(0xFF1F1F1F),
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
            elevation: 0,
          ),
          child: Text(
            'Continue to Review',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color:
                  _canProceed ? Colors.white : const Color(0xFF9CA3AF),
            ),
          ),
        ),
      ),
    );
  }
}
