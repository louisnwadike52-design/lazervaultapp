import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lazervault/core/theme/invoice_theme_colors.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/gift_card_cubit.dart';
import '../../cubit/gift_card_state.dart';
import '../../domain/entities/gift_card_entity.dart';
import '../../domain/validation/gift_card_validation.dart';
import '../../../transaction_pin/mixins/transaction_pin_mixin.dart';
import '../../../transaction_pin/services/transaction_pin_service.dart';
import '../../../../../core/types/app_routes.dart';
import 'widgets/gift_card_error_widget.dart';

class SellGiftCardScreen extends StatefulWidget {
  final SellableCard? preselectedCard;

  const SellGiftCardScreen({super.key, this.preselectedCard});

  @override
  State<SellGiftCardScreen> createState() => _SellGiftCardScreenState();
}

class _SellGiftCardScreenState extends State<SellGiftCardScreen>
    with TransactionPinMixin {
  @override
  ITransactionPinService get transactionPinService =>
      GetIt.I<ITransactionPinService>();

  int _currentStep = 0;
  SellableCard? _selectedCard;
  final List<String> _uploadedImageUrls = [];
  final List<String> _uploadedImageKeys = [];
  final List<File> _localImageFiles = [];
  String _ocrBrand = '';
  String _ocrCardNumber = '';
  String _ocrPin = '';
  double _ocrDenomination = 0;
  String _ocrCurrency = '';
  double _ocrConfidence = 0;
  final _cardNumberController = TextEditingController();
  final _cardPinController = TextEditingController();
  // Used when the catalogue has no fixed denominations — user types
  // the value within the [minDenomination, maxDenomination] window.
  final _denominationController = TextEditingController();
  String? _denominationError;
  double? _selectedDenomination;
  SellRate? _currentRate;
  GiftCardSale? _submittedSale;
  // When SellRejected fires, step 4 renders a rejection-receipt view
  // instead of the "Submitted for review" success view. Reason text
  // comes from sale.rejectionReason (admin-typed for manual rejects,
  // Prestmit's reason for auto rejects). Empty string falls back to
  // a generic message at render time.
  String? _rejectionReason;
  bool _isUploadingImage = false;
  // Tracks the brief window between the user tapping Take Photo / Choose
  // from Gallery and the OS image picker actually returning. Without this
  // the UI looks frozen for ~1–3s on cold-start of the camera intent.
  bool _isPickingImage = false;
  ImageSource? _pickingSource;
  int? _activePickerSlotIndex;
  // Tracks an in-flight AI extraction call (OCRExtracting → OCRExtracted/OCRFailed).
  bool _isExtractingDetails = false;
  String _selectedCountry = 'US';
  String _selectedFormat = 'ecode'; // "ecode" or "physical"
  String _selectedCategory = '';
  String? _cardNumberError;
  String? _cardPinError;

  // Step 2 (NEW: payout-method picker). Backed by a live cubit fetch
  // from the active provider's GetPayoutMethods. The selected method is
  // sent verbatim as `payoutMethod` to /giftcard-trade/sell/create.
  String _selectedPayoutMethod = '';

  // Step 3 (Confirm): the legal/UX safety net. We can't validate the
  // card with the issuer (no public API exists), so explicit user
  // acceptance is the only sign-off the operator gets that the user
  // understood the terms before submitting. Backend rejects with
  // FailedPrecondition when this is false.
  bool _disclaimerAccepted = false;

  static const _sellCategories = [
    {'slug': '', 'label': 'All'},
    {'slug': 'gaming', 'label': 'Gaming'},
    {'slug': 'shopping', 'label': 'Shopping'},
    {'slug': 'entertainment', 'label': 'Entertainment'},
    {'slug': 'fashion', 'label': 'Fashion'},
    {'slug': 'electronics', 'label': 'Electronics'},
    {'slug': 'food', 'label': 'Food & Drink'},
    {'slug': 'transport', 'label': 'Transport'},
    {'slug': 'finance', 'label': 'Finance'},
  ];

  static const _sellCountries = [
    {'code': 'US', 'name': 'United States', 'flag': '🇺🇸'},
    {'code': 'GB', 'name': 'United Kingdom', 'flag': '🇬🇧'},
    {'code': 'NG', 'name': 'Nigeria', 'flag': '🇳🇬'},
    {'code': 'GH', 'name': 'Ghana', 'flag': '🇬🇭'},
    {'code': 'KE', 'name': 'Kenya', 'flag': '🇰🇪'},
    {'code': 'ZA', 'name': 'South Africa', 'flag': '🇿🇦'},
  ];

  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // The Gift Cards hub (GiftCardsScreen) is the canonical surface
    // for browsing, filtering, and selecting a card to sell. This
    // screen handles ONLY the post-selection flow (steps 1-4): card
    // details, payout method, confirm, and submitted. A preselected
    // card is therefore mandatory; if missing, send the user back to
    // the hub instead of rendering a duplicate browse view.
    if (widget.preselectedCard == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        Get.offAllNamed(AppRoutes.giftCards);
      });
      return;
    }
    _selectedCard = widget.preselectedCard;
    _currentStep = 1;
    // Auto-prefill the denomination so the Get-Rate CTA is reachable
    // without an extra tap. Many Prestmit subcategories ship with
    // ONLY a `minimum` (no fixed denominations[]); the user otherwise
    // has nothing to tap to set _selectedDenomination, which left the
    // button stuck disabled. Pick the first fixed denom if any, else
    // fall back to the catalogue's minimum.
    final fixed = _selectedCard?.denominations ?? const <double>[];
    if (fixed.isNotEmpty) {
      _selectedDenomination = fixed.first;
    } else if ((_selectedCard?.minDenomination ?? 0) > 0) {
      _selectedDenomination = _selectedCard!.minDenomination;
      _denominationController.text =
          _selectedCard!.minDenomination.toStringAsFixed(0);
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardPinController.dispose();
    _denominationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentStep == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _onBack();
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: _onBack,
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
        ),
        title: Text(
          _appBarTitle,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<GiftCardCubit, GiftCardState>(
        listener: _onStateChanged,
        builder: (context, state) {
          if (state is SellableCardsLoading && _currentStep == 0) {
            return const Center(
              child: CircularProgressIndicator(color: InvoiceThemeColors.primaryPurple),
            );
          }
          if (state is SellProcessing) {
            return _buildProcessingView(state);
          }
          return _buildCurrentStep(state);
        },
      ),
    ),
    );
  }

  String get _appBarTitle {
    switch (_currentStep) {
      case 0:
        return 'Select Card';
      case 1:
        return 'Card Details';
      case 2:
        return 'Payout Method';
      case 3:
        return 'Confirm Sale';
      case 4:
        return 'Submitted';
      default:
        return 'Sell Gift Card';
    }
  }

  void _onBack() {
    // Step 1 is the entry point now (card-selection step 0 lives on
    // the hub). Backing out of step 1 returns to the hub rather than
    // dropping into a (no-longer-rendered) step 0.
    if (_currentStep == 1) {
      Get.back();
      return;
    }
    if (_currentStep > 1 && _currentStep < 4) {
      setState(() {
        if (_currentStep == 3) {
          // Reset disclaimer when leaving the confirm step so the user
          // re-acknowledges if they edit anything upstream.
          _disclaimerAccepted = false;
        }
        _currentStep--;
      });
    } else if (_currentStep == 4) {
      Get.offAllNamed(AppRoutes.giftCards);
    } else {
      Get.back();
    }
  }

  void _onStateChanged(BuildContext context, GiftCardState state) {
    if (state is SellImageUploaded) {
      setState(() {
        _uploadedImageUrls.add(state.imageUrl);
        _uploadedImageKeys.add(state.imageKey);
        _isUploadingImage = false;
      });
    } else if (state is SellImageError) {
      setState(() => _isUploadingImage = false);
      Get.snackbar('Upload Error', friendlyGiftCardError(state.message),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (state is OCRExtracting) {
      if (!_isExtractingDetails) {
        setState(() => _isExtractingDetails = true);
      }
    } else if (state is OCRExtracted) {
      // Treat confidence=0 OR a totally-empty payload as a no-signal
      // result rather than a successful scan — the model returns this
      // shape when the image isn't a card or it can't read the code.
      // Falling into the success branch with empty strings used to
      // wipe out anything the user had already typed and showed a
      // misleading "Details extracted" snackbar.
      final hasAnySignal = state.confidence > 0 &&
          (state.cardNumber.trim().isNotEmpty ||
              state.pin.trim().isNotEmpty ||
              state.denomination > 0);
      if (!hasAnySignal) {
        setState(() => _isExtractingDetails = false);
        Get.snackbar(
          'Scan Failed',
          'We couldn\'t read the card from those images. Please enter details manually.',
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      // Brand mismatch advisory. The risk engine still gates this at
      // submit, but warning here lets the user double-check now
      // instead of having Get-Rate fail at the next step.
      String? brandWarning;
      if (state.brand.trim().isNotEmpty && _selectedCard != null) {
        final extracted = state.brand.toLowerCase().trim();
        final selected = _selectedCard!.displayName.toLowerCase().trim();
        final match = extracted == selected ||
            extracted.contains(selected) ||
            selected.contains(extracted);
        if (!match) {
          brandWarning =
              'AI detected "${state.brand}" but you picked "${_selectedCard!.displayName}". '
              'Verify before submitting.';
        }
      }

      setState(() {
        _isExtractingDetails = false;
        _ocrBrand = state.brand;
        _ocrCurrency = state.currency;
        _ocrConfidence = state.confidence;
        // Only overwrite controllers when the OCR has a non-empty
        // value to give. Preserves any pre-typed input so the user
        // never loses keystrokes to a partial scan.
        if (state.cardNumber.trim().isNotEmpty) {
          _ocrCardNumber = state.cardNumber;
          _cardNumberController.text = state.cardNumber;
        }
        if (state.pin.trim().isNotEmpty) {
          _ocrPin = state.pin;
          _cardPinController.text = state.pin;
        }
        if (state.denomination > 0) {
          _ocrDenomination = state.denomination;
          if (_selectedCard != null) {
            final match = _selectedCard!.denominations
                .where((d) => d == state.denomination)
                .firstOrNull;
            _selectedDenomination = match ?? state.denomination;
          }
        }
        // Stay on step 1 — fields are now populated, user verifies
      });

      if (brandWarning != null) {
        Get.snackbar('Brand mismatch', brandWarning,
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
      } else {
        Get.snackbar(
          'Card Scanned',
          'Details extracted${state.confidence < 0.6 ? ' (low confidence — please verify)' : '. Please verify and complete the form.'}',
          backgroundColor: state.confidence < 0.6
              ? const Color(0xFFFB923C)
              : const Color(0xFF10B981),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      }
    } else if (state is OCRFailed) {
      setState(() => _isExtractingDetails = false);
      Get.snackbar('Scan Failed', 'Card scan failed. Please enter details manually.',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      // Stay on step 1 for manual entry
    } else if (state is SellRateLoaded) {
      setState(() => _currentRate = state.rate);
    } else if (state is SellSubmitted) {
      // Manual-mode path (or unknown future intermediate state): show
      // the in-screen "Submitted for review" confirmation.
      setState(() {
        _submittedSale = state.sale;
        _currentStep = 4;
      });
    } else if (state is GiftCardSellAwaitingProvider) {
      // Auto-mode (Prestmit) path: row is at pending or reviewing —
      // hand off to the dedicated processing screen which subscribes
      // to the balance WebSocket and refetches on a giftcard_sale
      // terminal event matching this reference.
      Get.offNamed(
        AppRoutes.giftCardSellProcessing,
        arguments: state.sale,
      );
    } else if (state is GiftCardSellPaid) {
      // Auto-mode terminal success — Prestmit's webhook (or
      // instant-settle short-circuit) already credited the user.
      // Skip the in-screen "submitted for review" copy and route
      // straight to My Sales where the row shows status=paid.
      Get.offAllNamed(AppRoutes.mySales);
    } else if (state is SellRejected) {
      // Show a dedicated rejection receipt at step 4 instead of just
      // a transient snackbar. The reason text comes from the sale's
      // rejection_reason column — admin-typed for manual rejects,
      // Prestmit's reason for auto rejects. Both reach the user
      // identically here.
      setState(() {
        _submittedSale = state.sale;
        _rejectionReason = state.reason;
        _currentStep = 4;
      });
    } else if (state is SellEscalatedToManualReview) {
      // Auto-flow gave up after retries. Same operator-owned outcome
      // as the manual queue, so reuse the existing "submitted for
      // review" UX with adjusted copy.
      setState(() {
        _submittedSale = state.sale;
        _currentStep = 4;
      });
      Get.snackbar(
        'Switched to manual review',
        'Our team will take it from here.',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (state is PayoutMethodsLoaded) {
      // Pre-select sensibly: server-provided default → first available.
      final preferred = state.defaultMethodName;
      String pick = '';
      if (preferred.isNotEmpty &&
          state.methods.any((m) => m.name == preferred)) {
        pick = preferred;
      } else if (state.methods.isNotEmpty) {
        pick = state.methods.first.name;
      }
      if (pick.isNotEmpty && _selectedPayoutMethod.isEmpty) {
        setState(() => _selectedPayoutMethod = pick);
      }
    } else if (state is PayoutMethodsError) {
      Get.snackbar('Payout methods', state.message,
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (state is SellDisclaimerNotAccepted) {
      Get.snackbar('Confirm acceptance',
        'Please tick the acknowledgement before submitting.',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } else if (state is SellQueued) {
      Get.snackbar('Queued', state.message,
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 4),
      );
    } else if (state is SellError) {
      Get.snackbar('Error', friendlyGiftCardError(state.message),
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Widget _buildCurrentStep(GiftCardState state) {
    switch (_currentStep) {
      // Step 0 (card browse/select) was retired — the Gift Cards hub
      // owns that surface. Anyone who lands on this screen with
      // _currentStep=0 must have bypassed initState's redirect; pop
      // them back to the hub rather than render a stale duplicate.
      case 0:
        return const SizedBox();
      case 1:
        return _buildStep1CardDetailsAndImages();
      case 2:
        return _buildStep2PayoutMethod(state);
      case 3:
        return _buildStep3Confirm();
      case 4:
        return _buildStep4Success();
      default:
        return const SizedBox();
    }
  }

  // ============================================
  // STEP 0: Select Card Brand
  // ============================================

  Widget _buildStep0CardSelection(GiftCardState state) {
    // Stale-while-revalidate: keep the grid rendered if the cubit has
    // cached cards, even when the current state is Loading or unrelated.
    // The cubit re-emits SellableCardsLoaded once revalidation completes.
    final cached = context.read<GiftCardCubit>().cachedSellableCards;

    if (state is SellableCardsEmpty) {
      // Empty result has two flavours: (a) the user picked a country
      // that has no entries in Prestmit's catalogue (e.g. Nigeria,
      // which has zero rows in the sandbox); (b) the upstream catalog
      // is genuinely unavailable. We can tell the difference because
      // the user only sees this state AFTER selecting a filter — so
      // rendering a country-aware "no cards in {country}" message
      // with a CTA to switch country is the right call.
      return _buildEmptyForCountry(_selectedCountry);
    }
    if (state is SellableCardsLoaded) {
      return _buildCardGridWithFilter(state.cards);
    }
    if (cached.isNotEmpty) {
      return _buildCardGridWithFilter(cached);
    }
    if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message);
    }
    return const Center(
      child: CircularProgressIndicator(color: InvoiceThemeColors.primaryPurple),
    );
  }

  Widget _buildCountrySelector() {
    return Container(
      height: 44.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _sellCountries.length,
        itemBuilder: (context, index) {
          final country = _sellCountries[index];
          final isSelected = _selectedCountry == country['code'];
          return GestureDetector(
            onTap: () {
              setState(() => _selectedCountry = country['code']!);
              context.read<GiftCardCubit>().loadSellableCards(countryCode: country['code']!);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected ? InvoiceThemeColors.primaryPurple : const Color(0xFF2D2D2D),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(country['flag']!, style: TextStyle(fontSize: 16.sp)),
                  SizedBox(width: 6.w),
                  Text(
                    country['code']!,
                    style: GoogleFonts.inter(
                      color: isSelected ? InvoiceThemeColors.primaryPurple : Colors.white,
                      fontSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySelector(List<SellableCard> cards) {
    // Categories are derived from the LIVE catalogue, not from a
    // hardcoded slug list. Prestmit's catalogue surfaces real names
    // like "iTunes Gift Card v2" / "Amazon v2" — those are what each
    // card's `category` field holds, so the chip values must equal
    // them verbatim for the filter (`c.category == _selectedCategory`)
    // to match. The previous static slug list ("gaming", "shopping",
    // etc.) never matched anything → category filter was always empty.
    final unique = <String>{};
    for (final c in cards) {
      final raw = c.category.trim();
      if (raw.isNotEmpty) unique.add(raw);
    }
    final categories = unique.toList()..sort();
    // Prepend the "All" chip (slug "") so the user can always reset.
    final entries = [
      const MapEntry('', 'All'),
      ...categories.map((c) => MapEntry(c, c)),
    ];
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entries.length,
        itemBuilder: (context, index) {
          final entry = entries[index];
          final isSelected = _selectedCategory == entry.key;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = entry.key);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                entry.value,
                style: GoogleFonts.inter(
                  color: isSelected ? InvoiceThemeColors.primaryPurple : const Color(0xFF9CA3AF),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 13.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardGridWithFilter(List<SellableCard> cards) {
    final filteredCards = _selectedCategory.isEmpty
        ? cards
        : cards.where((c) => c.category == _selectedCategory).toList();

    return Column(
      children: [
        SizedBox(height: 8.h),
        _buildCountrySelector(),
        SizedBox(height: 8.h),
        // Pass the loaded `cards` so the chip set reflects what's
        // actually in the catalogue for this country, not a stale
        // hardcoded slug list.
        _buildCategorySelector(cards),
        SizedBox(height: 8.h),
        Expanded(
          child: filteredCards.isEmpty
              ? _buildEmptyForCategory(_selectedCategory, cards.length)
              : _buildCardGrid(filteredCards),
        ),
      ],
    );
  }

  // _buildEmptyForCategory renders inline (with country + category
  // selectors still visible above) when the catalog has cards but
  // none match the active category filter. Distinct from
  // _buildEmptyForCountry: the user has cards available — they just
  // narrowed too far. The CTA clears the category to put them back
  // on the full grid in one tap.
  Widget _buildEmptyForCategory(String categorySlug, int totalCards) {
    // Categories are now driven directly off the live catalogue —
    // `_selectedCategory` IS the display label, no slug lookup needed.
    final categoryLabel = categorySlug;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.search_off_rounded,
                size: 28.sp,
                color: InvoiceThemeColors.primaryPurple,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'No cards in $categoryLabel',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              '$totalCards other cards are available — clear the category to see them all.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),
            TextButton.icon(
              onPressed: () => setState(() => _selectedCategory = ''),
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('Clear filter'),
              style: TextButton.styleFrom(
                foregroundColor: InvoiceThemeColors.primaryPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardGrid(List<SellableCard> cards) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GiftCardCubit>().loadSellableCards(countryCode: _selectedCountry);
      },
      color: InvoiceThemeColors.primaryPurple,
      backgroundColor: const Color(0xFF1F1F1F),
      child: GridView.builder(
        padding: EdgeInsets.all(16.w),
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.95,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return GestureDetector(
            onTap: () => setState(() {
              _selectedCard = card;
              _selectedDenomination = null;
              _currentRate = null;
              _currentStep = 1;
            }),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF2D2D2D)),
              ),
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 48.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CachedNetworkImage(
                        imageUrl: card.logoUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => Icon(
                          Icons.image_rounded,
                          color: Colors.grey.shade400,
                          size: 24.sp,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.card_giftcard_rounded,
                          color: Colors.grey.shade400,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    card.displayName,
                    style: GoogleFonts.inter(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    card.currencies.join(', '),
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${card.currencies.isNotEmpty ? card.currencies.first : "USD"} ${card.minDenomination.toStringAsFixed(0)} - ${card.maxDenomination.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: InvoiceThemeColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================
  // STEP 1: Card Details + Image Upload (merged)
  // ============================================

  Widget _buildStep1CardDetailsAndImages() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSelectedCardHeader(),
          SizedBox(height: 20.h),

          // OCR confidence badge (if OCR was performed)
          if (_ocrConfidence > 0) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: _ocrConfidence >= 0.8
                    ? const Color(0xFF10B981).withValues(alpha: 0.1)
                    : const Color(0xFFFB923C).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: _ocrConfidence >= 0.8
                      ? const Color(0xFF10B981).withValues(alpha: 0.3)
                      : const Color(0xFFFB923C).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.auto_awesome,
                    color: _ocrConfidence >= 0.8
                        ? const Color(0xFF10B981)
                        : const Color(0xFFFB923C),
                    size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'AI Extracted - ${(_ocrConfidence * 100).toStringAsFixed(0)}% confidence. Verify below.',
                      style: GoogleFonts.inter(
                        color: _ocrConfidence >= 0.8
                            ? const Color(0xFF10B981)
                            : const Color(0xFFFB923C),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
          ],

          // Card format selection
          Text('Card Format', style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFormat = 'ecode'),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: _selectedFormat == 'ecode' ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2) : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: _selectedFormat == 'ecode' ? InvoiceThemeColors.primaryPurple : const Color(0xFF2D2D2D)),
                    ),
                    child: Column(children: [
                      Icon(Icons.qr_code_rounded, color: _selectedFormat == 'ecode' ? InvoiceThemeColors.primaryPurple : const Color(0xFF9CA3AF), size: 22.sp),
                      SizedBox(height: 4.h),
                      Text('E-Code', style: GoogleFonts.inter(color: _selectedFormat == 'ecode' ? InvoiceThemeColors.primaryPurple : Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedFormat = 'physical'),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: _selectedFormat == 'physical' ? const Color(0xFF10B981).withValues(alpha: 0.2) : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: _selectedFormat == 'physical' ? const Color(0xFF10B981) : const Color(0xFF2D2D2D)),
                    ),
                    child: Column(children: [
                      Icon(Icons.credit_card_rounded, color: _selectedFormat == 'physical' ? const Color(0xFF10B981) : const Color(0xFF9CA3AF), size: 22.sp),
                      SizedBox(height: 4.h),
                      Text('Physical Card', style: GoogleFonts.inter(color: _selectedFormat == 'physical' ? const Color(0xFF10B981) : Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Denomination selection
          Text('Select Denomination', style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 12.h),
          _buildDenominationChips(),
          SizedBox(height: 20.h),

          // Card number
          _buildFieldLabel('Card Number', hasOcr: _ocrCardNumber.isNotEmpty),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _cardNumberController,
            hintText: 'XXXX-XXXX-XXXX-XXXX',
            keyboardType: TextInputType.text,
            errorText: _cardNumberError,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-]')),
              _CardNumberFormatter(),
            ],
            // Live validation: re-evaluate on every keystroke so the
            // Get-Rate CTA + the inline error stay in sync with the
            // current input. Until the field is non-empty we suppress
            // the error to avoid yelling at users who haven't finished
            // typing yet.
            onChanged: (value) {
              setState(() {
                _cardNumberError = value.trim().isEmpty
                    ? null
                    : _validateCardNumberValue(value);
              });
            },
          ),
          SizedBox(height: 16.h),

          // Card PIN
          _buildFieldLabel('Card PIN', hasOcr: _ocrPin.isNotEmpty),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _cardPinController,
            hintText: 'Enter gift card PIN',
            keyboardType: TextInputType.text,
            errorText: _cardPinError,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
              LengthLimitingTextInputFormatter(_kCardPinMaxLen),
            ],
            onChanged: (value) {
              setState(() {
                _cardPinError =
                    value.trim().isEmpty ? null : _validateCardPinValue(value);
              });
            },
          ),
          SizedBox(height: 24.h),

          // Card Photos section — physical only.
          //
          // Ecode is just `card_number` + `card_pin` text fields. No
          // image is required to redeem the card or for the admin to
          // verify the trade. The AI auto-fill affordance still lives
          // here for ecode (a single OPTIONAL screenshot the user can
          // attach to skip typing), but the section label, helper
          // copy, and CTA stop talking about uploads being required.
          if (_selectedFormat == 'physical') ...[
            Text('Card Photos', style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
            SizedBox(height: 4.h),
            Text(
              'Upload clear photos of the front and back of your card',
              style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(child: _buildImageSlot(0, 'Front')),
                SizedBox(width: 12.w),
                Expanded(child: _buildImageSlot(1, 'Back')),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Icon(Icons.auto_awesome, size: 14.sp, color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.7)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Card images unlock AI auto-fill for card details above',
                    style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 11.sp, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ] else ...[
            // Ecode: image upload is purely optional and used only as
            // an autofill shortcut. Single compact slot; no "Card
            // Photos" heading because nothing is required.
            Row(
              children: [
                Icon(Icons.auto_awesome, size: 14.sp, color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.7)),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    'Optional: paste a code screenshot to auto-fill the fields',
                    style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12.sp, fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            SizedBox(
              width: 200.w,
              child: _buildImageSlot(0, 'Screenshot (optional)'),
            ),
            SizedBox(height: 12.h),
          ],

          // Scan Card with AI button (optional, only when images uploaded)
          if (_uploadedImageUrls.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton.icon(
                onPressed: (_isUploadingImage || _isExtractingDetails)
                    ? null
                    : _onScanCardWithDialog,
                icon: _isExtractingDetails
                    ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation(
                              InvoiceThemeColors.primaryPurple),
                        ),
                      )
                    : Icon(Icons.auto_awesome, size: 18.sp),
                label: Text(
                  _isExtractingDetails
                      ? 'Reading card with AI…'
                      : 'Auto-fill with AI Scan',
                  style: GoogleFonts.inter(
                      fontSize: 14.sp, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: InvoiceThemeColors.primaryPurple,
                  side: const BorderSide(color: InvoiceThemeColors.primaryPurple),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
          SizedBox(height: 24.h),

          // Get Rate button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: _canGetRate() ? _onGetRate : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                disabledBackgroundColor: const Color(0xFF2D2D2D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                'Get Rate',
                style: GoogleFonts.inter(
                  color: _canGetRate() ? Colors.white : const Color(0xFF6B7280),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          // Small subtitle under the CTA naming the FIRST blocker so
          // the user knows what to do next without the button itself
          // shouting nag copy. Only renders while the CTA is disabled.
          if (!_canGetRate()) ...[
            SizedBox(height: 8.h),
            Center(
              child: Text(
                _firstBlocker(),
                style: GoogleFonts.inter(
                  color: const Color(0xFF6B7280),
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildImageSlot(int index, String label) {
    final hasImage = index < _localImageFiles.length;
    final isUploading = _isUploadingImage && index == _localImageFiles.length;
    // Show the picker-launching spinner on the slot the user just tapped.
    final isPicking = _isPickingImage &&
        _activePickerSlotIndex == index &&
        !hasImage;
    final isBusy = isUploading || isPicking;

    return GestureDetector(
      onTap: isBusy ? null : () => _showImagePickerOptions(index),
      child: Container(
        height: 160.h,
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: hasImage
                ? const Color(0xFF10B981).withValues(alpha: 0.5)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: hasImage
            ? Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(11.r),
                    child: Image.file(
                      _localImageFiles[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 6.h,
                    right: 6.w,
                    child: GestureDetector(
                      onTap: () => _removeImage(index),
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.close, color: Colors.white, size: 14.sp),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 6.h,
                    left: 6.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        label,
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : isBusy
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(
                          color: InvoiceThemeColors.primaryPurple,
                          strokeWidth: 2,
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          isPicking
                              ? (_pickingSource == ImageSource.camera
                                  ? 'Opening camera…'
                                  : 'Opening gallery…')
                              : 'Uploading…',
                          style: GoogleFonts.inter(
                            color: const Color(0xFF9CA3AF),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_a_photo_outlined,
                          color: const Color(0xFF9CA3AF), size: 28.sp),
                      SizedBox(height: 8.h),
                      Text(
                        label,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF9CA3AF),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }

  void _showImagePickerOptions(int slotIndex) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: InvoiceThemeColors.primaryPurple),
                title: Text('Take Photo',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera, slotIndex);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: InvoiceThemeColors.primaryPurple),
                title: Text('Choose from Gallery',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery, slotIndex);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source, int slotIndex) async {
    setState(() {
      _isPickingImage = true;
      _pickingSource = source;
      _activePickerSlotIndex = slotIndex;
    });
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      // Clear the picker-launching spinner regardless of cancel/return.
      if (mounted) {
        setState(() {
          _isPickingImage = false;
          _pickingSource = null;
          _activePickerSlotIndex = null;
        });
      }
      if (picked == null) return;

      final file = File(picked.path);
      final bytes = await file.readAsBytes();
      final filename = picked.name;

      // Pre-upload validation against Prestmit's documented limits
      // (JPG/PNG only, ≤5MB per file). Magic-byte sniff catches the
      // common iOS HEIC-renamed-to-jpg case that would otherwise 422
      // at /sell/create. Reject inline so the user re-picks rather
      // than waiting through a wasted upload + Prestmit round-trip.
      final fmtCheck = GiftCardValidation.validateImageBytes(bytes);
      if (fmtCheck.isLeft()) {
        if (!mounted) return;
        final err = fmtCheck.fold(
          (l) => l,
          (_) => const GeneralValidationError("Invalid image"),
        );
        Get.snackbar('Image Rejected', err.message,
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );
        return;
      }

      // Per-submission attachment cap (≤20).
      final newCount = slotIndex < _localImageFiles.length
          ? _localImageFiles.length // replacing — no new slot
          : _localImageFiles.length + 1;
      final batchCheck = GiftCardValidation.validateImageBatch(newCount);
      if (batchCheck.isLeft()) {
        if (!mounted) return;
        final err = batchCheck.fold(
          (l) => l,
          (_) => const GeneralValidationError("Too many images"),
        );
        Get.snackbar('Image Limit', err.message,
          backgroundColor: const Color(0xFFFB923C),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      setState(() {
        if (slotIndex < _localImageFiles.length) {
          // Replace existing
          _localImageFiles[slotIndex] = file;
          if (slotIndex < _uploadedImageUrls.length) {
            _uploadedImageUrls.removeAt(slotIndex);
            _uploadedImageKeys.removeAt(slotIndex);
          }
        } else {
          _localImageFiles.add(file);
        }
        _isUploadingImage = true;
      });

      if (!mounted) return;
      context.read<GiftCardCubit>().uploadSellImage(
        imageBytes: bytes,
        filename: filename,
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
          _pickingSource = null;
          _activePickerSlotIndex = null;
        });
        Get.snackbar('Error', 'Failed to pick image. Please try again.',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _localImageFiles.removeAt(index);
      if (index < _uploadedImageUrls.length) {
        _uploadedImageUrls.removeAt(index);
        _uploadedImageKeys.removeAt(index);
      }
    });
  }

  void _onScanCardWithDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: Row(
          children: [
            Icon(Icons.auto_awesome, color: InvoiceThemeColors.primaryPurple, size: 22.sp),
            SizedBox(width: 10.w),
            Expanded(
              child: Text('AI Auto-fill',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        content: Text(
          'AI will read your card images and fill in the details automatically.\n\nPlease double-check all auto-filled values before submitting — AI extraction may not always be 100% accurate.',
          style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: GoogleFonts.inter(color: const Color(0xFF9CA3AF))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _onScanCard();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: InvoiceThemeColors.primaryPurple,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Scan Now', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  void _onScanCard() {
    context.read<GiftCardCubit>().extractCardDetails(
      imageUrls: _uploadedImageUrls,
    );
  }

  // Step 2 (old) merged into Step 1 above

  Widget _buildFieldLabel(String label, {bool hasOcr = false}) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (hasOcr) ...[
          SizedBox(width: 8.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'AI',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurple,
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }

  bool _canGetRate() {
    final hasDetails = _selectedDenomination != null &&
        _cardNumberController.text.trim().isNotEmpty &&
        _cardPinController.text.trim().isNotEmpty;
    if (!hasDetails) return false;

    // Physical cards: require 2 images (front + back) — operators
    // can't validate the card without seeing both sides.
    // E-codes: NO image requirement — the code itself IS the card.
    // The user already provided card_number + pin, which is the
    // complete redemption payload. Asking for a screenshot adds
    // friction without protecting the trade.
    if (_selectedFormat == 'physical') {
      return _uploadedImageUrls.length >= 2;
    }
    return true;
  }

  // Required image count for the slot UI. Physical needs 2 (front +
  // back), e-code needs 0 (optional screenshot). Other format
  // strings fall back to 1 for back-compat with legacy rows.
  int get _requiredImageCount {
    switch (_selectedFormat) {
      case 'physical':
        return 2;
      case 'ecode':
        return 0;
      default:
        return 1;
    }
  }

  // Validation rules — mirror what the backend's SellGiftCard handler
  // checks at the boundary, plus a few client-side niceties so the
  // user sees specific errors before round-tripping to the server.
  //
  //   Card number :
  //     - required
  //     - 4..50 chars (after stripping dashes/spaces)
  //     - alphanumeric only (the inputFormatter already restricts
  //       keystrokes; this catches paste of unsupported characters)
  //   Card PIN :
  //     - required (every brand we handle either uses one or accepts
  //       a placeholder; the backend requires the field non-empty)
  //     - 3..12 chars
  //     - digits or letters only (most PINs are numeric; we allow
  //       letters for brands that use alphanumeric scratch-off codes)
  static const _kCardNumberMinLen = 4;
  static const _kCardNumberMaxLen = 50;
  static const _kCardPinMinLen = 3;
  static const _kCardPinMaxLen = 12;
  static final _kAlnumPattern = RegExp(r'^[A-Za-z0-9]+$');

  String? _validateCardNumberValue(String raw) {
    // Dashes are formatting only; the actual code is the alnum payload.
    final v = raw.replaceAll('-', '').replaceAll(' ', '').trim();
    if (v.isEmpty) return 'Card number is required';
    if (v.length < _kCardNumberMinLen) {
      return 'Card number must be at least $_kCardNumberMinLen characters';
    }
    if (v.length > _kCardNumberMaxLen) {
      return 'Card number is too long (max $_kCardNumberMaxLen characters)';
    }
    if (!_kAlnumPattern.hasMatch(v)) {
      return 'Card number can only contain letters and numbers';
    }
    return null;
  }

  String? _validateCardPinValue(String raw) {
    final v = raw.trim();
    if (v.isEmpty) return 'Card PIN is required';
    if (v.length < _kCardPinMinLen) {
      return 'PIN must be at least $_kCardPinMinLen characters';
    }
    if (v.length > _kCardPinMaxLen) {
      return 'PIN is too long (max $_kCardPinMaxLen characters)';
    }
    if (!_kAlnumPattern.hasMatch(v)) {
      return 'PIN can only contain letters and numbers';
    }
    return null;
  }

  // _firstBlocker returns a short hint naming the FIRST missing /
  // invalid input on step 1, in priority order. Renders under the
  // Get-Rate CTA only while it's disabled, so the user always knows
  // what to address next without the button itself yelling nag copy.
  String _firstBlocker() {
    if (_selectedDenomination == null) return 'Pick a denomination';
    if (_cardNumberController.text.trim().isEmpty) return 'Enter the card number';
    if (_validateCardNumberValue(_cardNumberController.text) != null) {
      return 'Card number looks invalid';
    }
    if (_cardPinController.text.trim().isEmpty) return 'Enter the card PIN';
    if (_validateCardPinValue(_cardPinController.text) != null) {
      return 'PIN looks invalid';
    }
    if (_selectedFormat == 'physical' && _uploadedImageUrls.length < 2) {
      return 'Upload front and back photos';
    }
    return '';
  }

  bool _validateCardFields() {
    final numErr = _validateCardNumberValue(_cardNumberController.text);
    final pinErr = _validateCardPinValue(_cardPinController.text);
    setState(() {
      _cardNumberError = numErr;
      _cardPinError = pinErr;
    });
    return numErr == null && pinErr == null;
  }

  void _onGetRate() {
    if (!_validateCardFields()) return;

    // Kick off the rate fetch in parallel with the payout-method fetch
    // — both feed the eventual confirm step. The user lands on the new
    // payout-method picker (step 2); the rate result lands by the time
    // they advance to confirm (step 3).
    context.read<GiftCardCubit>().getSellRate(
      cardType: _selectedCard!.cardType,
      denomination: _selectedDenomination!,
    );
    context.read<GiftCardCubit>().loadPayoutMethods();
    setState(() => _currentStep = 2);
  }

  // ============================================
  // STEP 2: Payout Method
  // ============================================

  Widget _buildStep2PayoutMethod(GiftCardState state) {
    final isLoading = state is PayoutMethodsLoading;
    final List<PayoutMethodEntity> methods =
        state is PayoutMethodsLoaded ? state.methods : const [];
    final hasError = state is PayoutMethodsError;

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How would you like to be paid?',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Pick the wallet currency your payout lands in. Methods are sourced live from the gift-card processor — only options you can actually receive are shown.',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 12.sp,
              height: 1.4,
            ),
          ),
          SizedBox(height: 20.h),
          if (isLoading)
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32.h),
                child: const CircularProgressIndicator(
                  color: InvoiceThemeColors.primaryPurple,
                ),
              ),
            )
          else if (hasError)
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFEF4444)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Color(0xFFEF4444)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      state.message,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () =>
                        context.read<GiftCardCubit>().loadPayoutMethods(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          else if (methods.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Text(
                'No payout methods available right now. Please try again in a moment.',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 13.sp,
                ),
              ),
            )
          else
            Column(
              children: methods.map((m) {
                final selected = m.name == _selectedPayoutMethod;
                return GestureDetector(
                  onTap: () => setState(() => _selectedPayoutMethod = m.name),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.h),
                    padding: EdgeInsets.all(14.w),
                    decoration: BoxDecoration(
                      color: selected
                          ? InvoiceThemeColors.primaryPurple
                              .withValues(alpha: 0.15)
                          : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: selected
                            ? InvoiceThemeColors.primaryPurple
                            : const Color(0xFF2D2D2D),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          color: selected
                              ? InvoiceThemeColors.primaryPurple
                              : const Color(0xFF9CA3AF),
                          size: 22.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                m.name,
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (m.currency.isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(top: 2.h),
                                  child: Text(
                                    'Pays out in ${m.currency}',
                                    style: GoogleFonts.inter(
                                      color: const Color(0xFF9CA3AF),
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        if (selected)
                          const Icon(
                            Icons.check_circle_rounded,
                            color: InvoiceThemeColors.primaryPurple,
                          ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          SizedBox(height: 24.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedPayoutMethod.isEmpty
                  ? null
                  : () => setState(() => _currentStep = 3),
              style: ElevatedButton.styleFrom(
                backgroundColor: InvoiceThemeColors.primaryPurple,
                disabledBackgroundColor:
                    InvoiceThemeColors.primaryPurple.withValues(alpha: 0.4),
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Continue',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================
  // STEP 3: Rate & Confirm
  // ============================================

  Widget _buildStep3Confirm() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card summary
          _buildSelectedCardHeader(),
          SizedBox(height: 20.h),
          // Card details summary
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: const Color(0xFF2D2D2D)),
            ),
            child: Column(
              children: [
                _buildSummaryRow('Card Number', _cardNumberController.text.trim()),
                SizedBox(height: 10.h),
                _buildSummaryRow('Denomination',
                    '${_selectedCard!.currencies.isNotEmpty ? _selectedCard!.currencies.first : "USD"} ${_selectedDenomination?.toStringAsFixed(0) ?? "-"}'),
                if (_uploadedImageUrls.isNotEmpty) ...[
                  SizedBox(height: 10.h),
                  _buildSummaryRow('Images', '${_uploadedImageUrls.length} uploaded'),
                ],
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Rate card
          if (_currentRate != null) ...[
            _buildRateCard(),
            SizedBox(height: 24.h),
          ] else ...[
            // Loading rate
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: Column(
                  children: [
                    const CircularProgressIndicator(
                      color: InvoiceThemeColors.primaryPurple,
                      strokeWidth: 2,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Getting best rate...',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF9CA3AF),
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          // Image thumbnails
          if (_localImageFiles.isNotEmpty) ...[
            Text(
              'Card Photos',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
              height: 64.h,
              child: Row(
                children: _localImageFiles.map((file) => Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(file, width: 64.w, height: 64.h, fit: BoxFit.cover),
                  ),
                )).toList(),
              ),
            ),
            SizedBox(height: 24.h),
          ],
          // Legal disclaimer + acceptance gate. Mirrors the dark-theme
          // pattern from sell_crypto_screen.dart's _buildLegalDisclaimer.
          // Card validity can't be confirmed via any public API on the
          // issuer side (Apple/Amazon/Steam don't expose balance/PIN
          // lookups), so explicit user acceptance is the only sign-off
          // operators get that the user understood the terms before
          // submitting. Submit is disabled until the checkbox is ticked.
          _buildSellLegalDisclaimer(),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () => setState(() => _disclaimerAccepted = !_disclaimerAccepted),
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: _disclaimerAccepted
                      ? const Color(0xFF10B981)
                      : const Color(0xFF2D2D2D),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    _disclaimerAccepted
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: _disclaimerAccepted
                        ? const Color(0xFF10B981)
                        : const Color(0xFF9CA3AF),
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      'I confirm this gift card is valid, unused, and unexpired. I have read the responsibility notice above.',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 12.sp,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 18.h),
          // Submit button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: (_currentRate != null && _disclaimerAccepted)
                  ? _onSubmitSell
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF10B981),
                disabledBackgroundColor: const Color(0xFF2D2D2D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              child: Text(
                _currentRate != null
                    ? 'Sell for ${_formatCurrency(_currentRate!.payoutAmount)}'
                    : 'Sell Gift Card',
                style: GoogleFonts.inter(
                  color: (_currentRate != null && _disclaimerAccepted)
                      ? Colors.white
                      : const Color(0xFF6B7280),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  /// Legal/responsibility notice for the sell flow. Card validity
  /// can't be checked against the issuer (Apple/Amazon/Steam don't
  /// expose balance/PIN lookups via public APIs — that's a deliberate
  /// fraud-prevention design). The disclaimer is therefore the
  /// operator's only audit-trail-worthy sign-off that the user
  /// understood the terms before submitting. Style mirrors the crypto
  /// sell screen's _buildLegalDisclaimer (orange-gradient warning card).
  Widget _buildSellLegalDisclaimer() {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.withValues(alpha: 0.12),
            Colors.orange.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.orange, size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              'By submitting this card you confirm it is valid, unused, and unexpired. LazerVault is not liable for cards rejected by the gift-card processor due to incorrect, used, or expired details. Cards are reviewed and may take 5 minutes – 24 hours to verify. Once approved your wallet is credited automatically; if rejected you will be notified with the reason.',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.85),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            color: const Color(0xFF9CA3AF),
            fontSize: 14.sp,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // ============================================
  // STEP 4: Success
  // ============================================

  Widget _buildStep4Success() {
    // Capture into a non-null local so any later code path doesn't
    // need a null assertion. Empty/null both fall through to the
    // success variant — never a crash even if the rejection state
    // wasn't fully populated.
    final rejectionReason = (_rejectionReason ?? '').trim();
    final isRejected = rejectionReason.isNotEmpty;
    final accentColor = isRejected
        ? const Color(0xFFEF4444)
        : const Color(0xFF10B981);
    final headline = isRejected ? 'Sale rejected' : 'Submitted for review';
    final subline = isRejected
        ? "Your card was not accepted. The reason from our reviewer is shown below — if you believe this is an error, contact support and reference the ID below."
        : "Status: PENDING. Most gaming cards verify in 5 – 10 minutes; e-commerce cards can take up to 24 hours. We'll notify you the moment the status changes.";
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isRejected ? Icons.cancel_outlined : Icons.check_circle_outline,
                color: accentColor,
                size: 48.sp,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              headline,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              subline,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),
            // Rejection-reason block — rendered ONLY when the screen
            // is in the rejected variant. Mirrors the My Sales detail
            // sheet so the user sees the same operator-supplied copy
            // either way.
            if (isRejected) ...[
              SizedBox(height: 16.h),
              Container(
                key: const ValueKey('sell_rejection_reason_block'),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: accentColor.withValues(alpha: 0.30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reason for rejection',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: accentColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      rejectionReason,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            ...((){
              final sale = _submittedSale;
              if (sale == null) return const <Widget>[];
              return [
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Text(
                    'Ref: ${sale.reference}',
                    style: GoogleFonts.inter(
                      color: InvoiceThemeColors.primaryPurple,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ];
            }()),
            SizedBox(height: 32.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: GestureDetector(
                onTap: () => Get.offNamed(AppRoutes.mySales),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [InvoiceThemeColors.primaryPurple, Color(0xFF6366F1)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'View My Sales',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: TextButton(
                onPressed: () => Get.offAllNamed(AppRoutes.giftCards),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Back to Gift Cards',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================
  // SHARED WIDGETS
  // ============================================

  Widget _buildSelectedCardHeader() {
    if (_selectedCard == null) return const SizedBox();
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: _selectedCard!.logoUrl,
                fit: BoxFit.contain,
                errorWidget: (context, url, error) => Icon(
                  Icons.card_giftcard_rounded,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              _selectedCard!.displayName,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Step indicator
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'Step ${_currentStep + 1}/4',
              style: GoogleFonts.inter(
                color: InvoiceThemeColors.primaryPurple,
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDenominationChips() {
    final denominations = _selectedCard!.denominations;
    final ccy = _selectedCard!.currencies.isNotEmpty
        ? _selectedCard!.currencies.first
        : 'USD';
    // No fixed denominations — render a numeric input bounded by
    // min/max from the catalogue. Prestmit's v2 catalogue surfaces
    // many subcategories with only `minimum` set; without this path
    // the user had nothing to tap and the Get-Rate CTA stayed
    // disabled forever.
    if (denominations.isEmpty) {
      final min = _selectedCard!.minDenomination;
      final max = _selectedCard!.maxDenomination;
      final hint = max > 0
          ? 'Min $ccy ${min.toStringAsFixed(0)} · Max $ccy ${max.toStringAsFixed(0)}'
          : 'Min $ccy ${min.toStringAsFixed(0)}';
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(
            controller: _denominationController,
            hintText: hint,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            errorText: _denominationError,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            onChanged: (value) {
              final parsed = double.tryParse(value.trim());
              setState(() {
                if (parsed == null) {
                  _denominationError = value.trim().isEmpty
                      ? null
                      : 'Enter a valid number';
                  _selectedDenomination = null;
                  return;
                }
                if (min > 0 && parsed < min) {
                  _denominationError = 'Minimum is $ccy ${min.toStringAsFixed(0)}';
                  _selectedDenomination = null;
                  return;
                }
                if (max > 0 && parsed > max) {
                  _denominationError = 'Maximum is $ccy ${max.toStringAsFixed(0)}';
                  _selectedDenomination = null;
                  return;
                }
                _denominationError = null;
                _selectedDenomination = parsed;
              });
            },
          ),
        ],
      );
    }
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: denominations.map((denom) {
        final isSelected = _selectedDenomination == denom;
        final isOcrMatch = _ocrDenomination > 0 && denom == _ocrDenomination;
        return GestureDetector(
          onTap: () => setState(() => _selectedDenomination = denom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? InvoiceThemeColors.primaryPurple
                    : isOcrMatch
                        ? const Color(0xFF10B981).withValues(alpha: 0.5)
                        : const Color(0xFF2D2D2D),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${_selectedCard!.currencies.isNotEmpty ? _selectedCard!.currencies.first : "USD"} ${denom.toStringAsFixed(0)}',
                  style: GoogleFonts.inter(
                    color: isSelected ? InvoiceThemeColors.primaryPurple : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                if (isOcrMatch) ...[
                  SizedBox(width: 4.w),
                  Icon(Icons.auto_awesome,
                      color: const Color(0xFF10B981), size: 12.sp),
                ],
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRateCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF10B981).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Rate',
                style: GoogleFonts.inter(
                  color: const Color(0xFF9CA3AF),
                  fontSize: 14.sp,
                ),
              ),
              Text(
                '${_currentRate!.ratePercentage.toStringAsFixed(0)}%',
                style: GoogleFonts.inter(
                  color: const Color(0xFF10B981),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          // Manual mode: render the payout RANGE rather than a fixed
          // value, since the actual amount the user receives is set
          // by the admin at approval time (off-platform sale price
          // varies). hasRange returns false for legacy server builds
          // (range fields default to 0/0 on the wire) so the point-
          // estimate variant below remains the safe fallback.
          if (_currentRate!.hasRange) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "You'll receive between",
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  '${_formatCurrency(_currentRate!.payoutLowerBound)} – ${_formatCurrency(_currentRate!.payoutUpperBound)}',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Text(
              'Final amount confirmed after the card is verified.',
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 11.sp,
              ),
            ),
          ] else ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'You receive',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 14.sp,
                  ),
                ),
                Text(
                  _formatCurrency(_currentRate!.payoutAmount),
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    String? errorText,
    List<TextInputFormatter>? inputFormatters,
    ValueChanged<String>? onChanged,
  }) {
    final hasError = errorText != null && errorText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            letterSpacing: controller == _cardNumberController ? 1.5 : null,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: GoogleFonts.inter(
              color: const Color(0xFF6B7280),
              fontSize: 14.sp,
              letterSpacing: controller == _cardNumberController ? 1.5 : null,
            ),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFEF4444) : const Color(0xFF2D2D2D),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: hasError ? const Color(0xFFEF4444) : InvoiceThemeColors.primaryPurple,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 6.h),
          Text(
            errorText,
            style: GoogleFonts.inter(color: const Color(0xFFEF4444), fontSize: 12.sp),
          ),
        ],
      ],
    );
  }

  Widget _buildProcessingView(SellProcessing state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.w,
            height: 80.w,
            child: CircularProgressIndicator(
              value: state.progress,
              strokeWidth: 4,
              backgroundColor: const Color(0xFF2D2D2D),
              color: InvoiceThemeColors.primaryPurple,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            state.currentStep,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            '${(state.progress * 100).toInt()}%',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: const Color(0xFFFB923C).withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.cloud_off_rounded,
                size: 36.sp,
                color: const Color(0xFFFB923C),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Sell catalog temporarily unavailable',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "We couldn't load the list of cards available for sale. This usually clears in a few minutes.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            ElevatedButton.icon(
              onPressed: () => context
                  .read<GiftCardCubit>()
                  .loadSellableCards(countryCode: _selectedCountry),
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Try again'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3B82F6),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildEmptyForCountry renders when the catalogue API succeeds but
  // returns zero rows for the selected country (Prestmit doesn't list
  // any cards under that ISO, e.g. Nigeria in the current sandbox).
  // Distinct from _buildEmptyState (network/upstream failure) so the
  // user understands the filter is the cause and isn't pushed to keep
  // hitting "Try again" on a fundamentally empty result.
  Widget _buildEmptyForCountry(String countryCode) {
    final country = _sellCountries.firstWhere(
      (c) => c['code'] == countryCode,
      orElse: () => {'code': countryCode, 'name': countryCode, 'flag': '🌍'},
    );
    final flag = country['flag'] ?? '🌍';
    final name = country['name'] ?? countryCode;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(flag, style: TextStyle(fontSize: 32.sp)),
            ),
            SizedBox(height: 20.h),
            Text(
              'No cards available for $name',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "We don't currently buy gift cards from this region. Try a different country, or check back later as our partners onboard new card types.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
                height: 1.4,
              ),
            ),
            SizedBox(height: 24.h),
            // Most cards in Prestmit's catalogue are USA-issued, so
            // making "Switch to United States" the primary CTA gets
            // the user back to a populated grid in one tap. The
            // country selector at the top of the screen still lets
            // them pick anything else.
            if (countryCode != 'US')
              ElevatedButton.icon(
                onPressed: () {
                  setState(() => _selectedCountry = 'US');
                  context.read<GiftCardCubit>().loadSellableCards(countryCode: 'US');
                },
                icon: const Text('🇺🇸', style: TextStyle(fontSize: 18)),
                label: const Text('Switch to United States'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvoiceThemeColors.primaryPurple,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
              )
            else
              OutlinedButton.icon(
                onPressed: () => context
                    .read<GiftCardCubit>()
                    .loadSellableCards(countryCode: countryCode),
                icon: const Icon(Icons.refresh, size: 18),
                label: const Text('Try again'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF2D2D2D)),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return GiftCardErrorWidget.fromRaw(
      rawMessage: message,
      onRetry: () => context.read<GiftCardCubit>().loadSellableCards(countryCode: _selectedCountry),
    );
  }

  // ============================================
  // ACTIONS
  // ============================================

  void _onSubmitSell() async {
    // Check if rate is loaded and not expired
    if (_currentRate != null && _currentRate!.expiresAt.isNotEmpty) {
      try {
        final expiresAt = DateTime.parse(_currentRate!.expiresAt);
        if (DateTime.now().isAfter(expiresAt)) {
          Get.snackbar(
            'Rate Expired',
            'The sell rate has expired. Please go back and get a fresh rate.',
            backgroundColor: const Color(0xFFFB923C),
            colorText: Colors.white,
            snackPosition: SnackPosition.TOP,
          );
          setState(() {
            _currentRate = null;
            // Step numbering changed — send the user back to the
            // payout-method step (step 2) since the rate fetch is
            // re-issued from there. The user re-confirms their pick
            // and a fresh rate is requested by _onGetRate-equivalent
            // logic on advance to confirm.
            _currentStep = 2;
            _disclaimerAccepted = false;
          });
          return;
        }
      } catch (_) {
        // If date parsing fails, proceed - server will validate
      }
    }

    final transactionId = 'SELL-${DateTime.now().millisecondsSinceEpoch}';
    final payoutAmount = _currentRate?.payoutAmount ?? _selectedDenomination!;

    String? verificationToken;

    final success = await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'gift_card_sell',
      amount: payoutAmount,
      currency: 'NGN',
      title: 'Confirm Sale',
      message: 'Confirm gift card sale for NGN ${payoutAmount.toStringAsFixed(2)}',
      // Gift card sell: cubit.sellGiftCard runs *after* the modal closes
      // (line below), and either submits to Prestmit or queues for manual
      // review. The modal has nothing to wait on, so it should stop at
      // "PIN verified" rather than animating a fake "processing" phase.
      showProcessingPhase: false,
      onPinValidated: (token) async {
        verificationToken = token;
      },
    );

    if (!success || verificationToken == null) return;
    if (!mounted) return;

    // Doc-aligned `form` value (Title-case "Physical"|"Ecode") sent to
    // Prestmit. Use the selected card's authoritative form when present,
    // else fall back to the user's _selectedFormat toggle.
    final form = (_selectedCard?.form.isNotEmpty ?? false)
        ? _selectedCard!.form
        : (_selectedFormat == 'physical' ? 'Physical' : 'Ecode');

    // Subcategory id is the Prestmit numeric id used as `giftcard_id`.
    final subcategoryId = _selectedCard?.subcategoryId ?? '';

    // Execute sell AFTER modal is dismissed
    await context.read<GiftCardCubit>().sellGiftCard(
      cardType: _selectedCard!.cardType,
      cardNumber: _cardNumberController.text.trim(),
      cardPin: _cardPinController.text.trim(),
      denomination: _selectedDenomination!,
      transactionId: transactionId,
      verificationToken: verificationToken!,
      // Doc-aligned Prestmit fields:
      payoutMethod: _selectedPayoutMethod.isNotEmpty
          ? _selectedPayoutMethod
          : null,
      form: form,
      subcategoryId: subcategoryId.isNotEmpty ? subcategoryId : null,
      cardCode: _selectedFormat == 'ecode'
          ? _cardNumberController.text.trim()
          : null,
      disclaimerAccepted: _disclaimerAccepted,
      images: _uploadedImageUrls.isNotEmpty ? _uploadedImageUrls : null,
      providerName: _selectedCard!.providerName.isNotEmpty ? _selectedCard!.providerName : null,
      cardCountry: _selectedCountry,
      cardFormat: _selectedFormat,
      imageUrls: _uploadedImageUrls.isNotEmpty ? _uploadedImageUrls : null,
      imageKeys: _uploadedImageKeys.isNotEmpty ? _uploadedImageKeys : null,
      ocrBrand: _ocrBrand.isNotEmpty ? _ocrBrand : null,
      ocrCardNumber: _ocrCardNumber.isNotEmpty ? _ocrCardNumber : null,
      ocrPin: _ocrPin.isNotEmpty ? _ocrPin : null,
      ocrDenomination: _ocrDenomination > 0 ? _ocrDenomination : null,
      ocrCurrency: _ocrCurrency.isNotEmpty ? _ocrCurrency : null,
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000) {
      return 'NGN ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]},',
      )}';
    }
    return 'NGN ${amount.toStringAsFixed(2)}';
  }
}

/// Formats card number in groups of 4 with dashes (XXXX-XXXX-XXXX-XXXX)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('-', '');

    // Limit to 16 characters (typical gift card length)
    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    // Add dashes after every 4 characters
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write('-');
      }
      buffer.write(text[i]);
    }

    final formatted = buffer.toString();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
