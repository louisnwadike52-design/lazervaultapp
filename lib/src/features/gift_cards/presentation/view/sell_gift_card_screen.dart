import 'dart:io';

import 'package:flutter/material.dart';
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
  double? _selectedDenomination;
  SellRate? _currentRate;
  GiftCardSale? _submittedSale;
  bool _isUploadingImage = false;
  String _selectedCountry = 'US';
  String _selectedFormat = 'ecode'; // "ecode" or "physical"
  String _selectedCategory = '';
  String? _cardNumberError;
  String? _cardPinError;

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
    if (widget.preselectedCard != null) {
      _selectedCard = widget.preselectedCard;
      _currentStep = 1;
    }
    context.read<GiftCardCubit>().loadSellableCards(countryCode: _selectedCountry);
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardPinController.dispose();
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
        actions: [
          if (_currentStep < 3)
            IconButton(
              onPressed: () => Get.toNamed(AppRoutes.mySales),
              icon: Icon(Icons.history, color: const Color(0xFF3B82F6), size: 22.sp),
            ),
        ],
      ),
      body: BlocConsumer<GiftCardCubit, GiftCardState>(
        listener: _onStateChanged,
        builder: (context, state) {
          if (state is SellableCardsLoading && _currentStep == 0) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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
        return 'Confirm Sale';
      case 3:
        return 'Submitted';
      default:
        return 'Sell Gift Card';
    }
  }

  void _onBack() {
    if (_currentStep > 0 && _currentStep < 3) {
      setState(() {
        if (_currentStep == 1) {
          _selectedCard = null;
          _selectedFormat = 'ecode';
          _selectedDenomination = null;
          _currentRate = null;
          _ocrBrand = '';
          _ocrCardNumber = '';
          _ocrPin = '';
          _ocrDenomination = 0;
          _ocrCurrency = '';
          _ocrConfidence = 0;
          _cardNumberController.clear();
          _cardPinController.clear();
          _cardNumberError = null;
          _cardPinError = null;
          _uploadedImageUrls.clear();
          _uploadedImageKeys.clear();
          _localImageFiles.clear();
          context.read<GiftCardCubit>().loadSellableCards(countryCode: _selectedCountry);
        }
        _currentStep--;
      });
    } else if (_currentStep == 3) {
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
    } else if (state is OCRExtracted) {
      setState(() {
        _ocrBrand = state.brand;
        _ocrCardNumber = state.cardNumber;
        _ocrPin = state.pin;
        _ocrDenomination = state.denomination;
        _ocrCurrency = state.currency;
        _ocrConfidence = state.confidence;
        _cardNumberController.text = state.cardNumber;
        _cardPinController.text = state.pin;
        if (_selectedCard != null && state.denomination > 0) {
          final match = _selectedCard!.denominations
              .where((d) => d == state.denomination)
              .firstOrNull;
          _selectedDenomination = match ?? state.denomination;
        }
        // Stay on step 1 — fields are now populated, user verifies
      });
      Get.snackbar('Card Scanned', 'Details extracted. Please verify and complete the form.',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else if (state is OCRFailed) {
      Get.snackbar('Scan Failed', 'Card scan failed. Please enter details manually.',
        backgroundColor: const Color(0xFFFB923C),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      // Stay on step 1 for manual entry
    } else if (state is SellRateLoaded) {
      setState(() => _currentRate = state.rate);
    } else if (state is SellSubmitted) {
      setState(() {
        _submittedSale = state.sale;
        _currentStep = 3;
      });
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
      case 0:
        return _buildStep0CardSelection(state);
      case 1:
        return _buildStep1CardDetailsAndImages();
      case 2:
        return _buildStep3Confirm();
      case 3:
        return _buildStep4Success();
      default:
        return const SizedBox();
    }
  }

  // ============================================
  // STEP 0: Select Card Brand
  // ============================================

  Widget _buildStep0CardSelection(GiftCardState state) {
    if (state is SellableCardsLoaded) {
      return _buildCardGridWithFilter(state.cards);
    }
    if (state is SellableCardsEmpty) {
      return _buildEmptyState();
    }
    if (state is GiftCardNetworkError) {
      return _buildErrorState(state.message);
    }
    return const Center(
      child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
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
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D),
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
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
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

  Widget _buildCategorySelector() {
    return Container(
      height: 40.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _sellCategories.length,
        itemBuilder: (context, index) {
          final cat = _sellCategories[index];
          final isSelected = _selectedCategory == cat['slug'];
          return GestureDetector(
            onTap: () {
              setState(() => _selectedCategory = cat['slug']!);
            },
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                    : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                cat['label']!,
                style: GoogleFonts.inter(
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF),
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
        _buildCategorySelector(),
        SizedBox(height: 8.h),
        Expanded(
          child: filteredCards.isEmpty
              ? Center(
                  child: Text(
                    'No cards in this category',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14.sp,
                    ),
                  ),
                )
              : _buildCardGrid(filteredCards),
        ),
      ],
    );
  }

  Widget _buildCardGrid(List<SellableCard> cards) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GiftCardCubit>().loadSellableCards(countryCode: _selectedCountry);
      },
      color: const Color(0xFF3B82F6),
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
                      color: const Color(0xFF3B82F6),
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
                      color: _selectedFormat == 'ecode' ? const Color(0xFF3B82F6).withValues(alpha: 0.2) : const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: _selectedFormat == 'ecode' ? const Color(0xFF3B82F6) : const Color(0xFF2D2D2D)),
                    ),
                    child: Column(children: [
                      Icon(Icons.qr_code_rounded, color: _selectedFormat == 'ecode' ? const Color(0xFF3B82F6) : const Color(0xFF9CA3AF), size: 22.sp),
                      SizedBox(height: 4.h),
                      Text('E-Code', style: GoogleFonts.inter(color: _selectedFormat == 'ecode' ? const Color(0xFF3B82F6) : Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600)),
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
            onChanged: (_) {
              if (_cardNumberError != null) setState(() => _cardNumberError = null);
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
            ],
            onChanged: (_) {
              if (_cardPinError != null) setState(() => _cardPinError = null);
            },
          ),
          SizedBox(height: 24.h),

          // Card Photos section
          Text('Card Photos', style: GoogleFonts.inter(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600)),
          SizedBox(height: 4.h),
          Text(
            _selectedFormat == 'physical'
                ? 'Upload clear photos of the front and back of your card'
                : 'Upload a screenshot showing the gift card code',
            style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 13.sp),
          ),
          SizedBox(height: 12.h),
          if (_selectedFormat == 'physical') ...[
            // Physical: front + back
            Row(
              children: [
                Expanded(child: _buildImageSlot(0, 'Front')),
                SizedBox(width: 12.w),
                Expanded(child: _buildImageSlot(1, 'Back')),
              ],
            ),
          ] else ...[
            // E-code: single screenshot
            Row(
              children: [
                Expanded(child: _buildImageSlot(0, 'Screenshot')),
                SizedBox(width: 12.w),
                // Optional second image for e-codes
                Expanded(
                  child: _localImageFiles.isNotEmpty
                      ? _buildImageSlot(1, 'Extra (optional)')
                      : Container(
                          height: 160.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F1F1F).withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: const Color(0xFF2D2D2D).withValues(alpha: 0.3)),
                          ),
                          child: Center(
                            child: Text(
                              'Optional',
                              style: GoogleFonts.inter(color: const Color(0xFF4B5563), fontSize: 12.sp),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
          SizedBox(height: 8.h),
          // Hint about AI auto-fill
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14.sp, color: const Color(0xFF3B82F6).withValues(alpha: 0.7)),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Upload card images to unlock AI auto-fill for card details above',
                  style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 11.sp, fontStyle: FontStyle.italic),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Scan Card with AI button (optional, only when images uploaded)
          if (_uploadedImageUrls.isNotEmpty)
            SizedBox(
              width: double.infinity,
              height: 44.h,
              child: OutlinedButton.icon(
                onPressed: !_isUploadingImage ? _onScanCardWithDialog : null,
                icon: Icon(Icons.auto_awesome, size: 18.sp),
                label: Text('Auto-fill with AI Scan', style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600)),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF3B82F6),
                  side: const BorderSide(color: Color(0xFF3B82F6)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
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
                backgroundColor: const Color(0xFF3B82F6),
                disabledBackgroundColor: const Color(0xFF2D2D2D),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
              child: Text(
                _canGetRate()
                    ? 'Get Rate'
                    : 'Fill all details + upload ${_requiredImageCount == 1 ? "screenshot" : "2 photos"}',
                style: GoogleFonts.inter(
                  color: _canGetRate() ? Colors.white : const Color(0xFF6B7280),
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

  Widget _buildImageSlot(int index, String label) {
    final hasImage = index < _localImageFiles.length;
    final isUploading = _isUploadingImage && index == _localImageFiles.length;

    return GestureDetector(
      onTap: isUploading ? null : () => _showImagePickerOptions(index),
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
            : isUploading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF3B82F6),
                      strokeWidth: 2,
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
                leading: const Icon(Icons.camera_alt, color: Color(0xFF3B82F6)),
                title: Text('Take Photo',
                    style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera, slotIndex);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Color(0xFF3B82F6)),
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
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );
      if (picked == null) return;

      final file = File(picked.path);
      final bytes = await file.readAsBytes();
      final filename = picked.name;

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
      if (!mounted) return;
      Get.snackbar('Error', 'Failed to pick image. Please try again.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
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
            Icon(Icons.auto_awesome, color: const Color(0xFF3B82F6), size: 22.sp),
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
              backgroundColor: const Color(0xFF3B82F6),
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
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              'AI',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
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

    // Physical cards: require 2 images (front + back)
    // E-codes: require 1 image (screenshot of code)
    final requiredImages = _selectedFormat == 'physical' ? 2 : 1;
    return _uploadedImageUrls.length >= requiredImages;
  }

  int get _requiredImageCount => _selectedFormat == 'physical' ? 2 : 1;

  bool _validateCardFields() {
    bool valid = true;
    final cardNum = _cardNumberController.text.replaceAll('-', '').trim();
    final cardPin = _cardPinController.text.trim();

    if (cardNum.isEmpty) {
      _cardNumberError = 'Card number is required';
      valid = false;
    } else if (cardNum.length < 4) {
      _cardNumberError = 'Card number is too short';
      valid = false;
    }

    if (cardPin.isEmpty) {
      _cardPinError = 'Card PIN is required';
      valid = false;
    } else if (cardPin.length < 3) {
      _cardPinError = 'Card PIN must be at least 3 characters';
      valid = false;
    }

    if (!valid) setState(() {});
    return valid;
  }

  void _onGetRate() {
    if (!_validateCardFields()) return;

    context.read<GiftCardCubit>().getSellRate(
      cardType: _selectedCard!.cardType,
      denomination: _selectedDenomination!,
    );
    setState(() => _currentStep = 2);
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
                      color: Color(0xFF3B82F6),
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
          // Submit button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: _currentRate != null ? _onSubmitSell : null,
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
                  color: _currentRate != null ? Colors.white : const Color(0xFF6B7280),
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
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_outline,
                  color: const Color(0xFF10B981), size: 48.sp),
            ),
            SizedBox(height: 24.h),
            Text(
              'Submitted for Review',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Your gift card has been submitted. You\'ll be notified once it\'s reviewed.',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0xFF9CA3AF),
                fontSize: 14.sp,
              ),
            ),
            if (_submittedSale != null) ...[
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'Ref: ${_submittedSale!.reference}',
                  style: GoogleFonts.inter(
                    color: const Color(0xFF3B82F6),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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
                      colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
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
        border: Border.all(color: const Color(0xFF3B82F6).withValues(alpha: 0.3)),
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
              color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'Step ${_currentStep + 1}/4',
              style: GoogleFonts.inter(
                color: const Color(0xFF3B82F6),
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
                  ? const Color(0xFF3B82F6).withValues(alpha: 0.2)
                  : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF3B82F6)
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
                    color: isSelected ? const Color(0xFF3B82F6) : Colors.white,
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
                color: hasError ? const Color(0xFFEF4444) : const Color(0xFF3B82F6),
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
              color: const Color(0xFF3B82F6),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sell_outlined, size: 48.sp, color: const Color(0xFF6B7280)),
          SizedBox(height: 16.h),
          Text(
            'No Cards Available',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'No gift card types are available for selling right now',
            style: GoogleFonts.inter(
              color: const Color(0xFF9CA3AF),
              fontSize: 14.sp,
            ),
          ),
        ],
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
            _currentStep = 2;
          });
          return;
        }
      } catch (_) {
        // If date parsing fails, proceed - server will validate
      }
    }

    final transactionId = 'SELL-${DateTime.now().millisecondsSinceEpoch}';
    final payoutAmount = _currentRate?.payoutAmount ?? _selectedDenomination!;

    await validateTransactionPin(
      context: context,
      transactionId: transactionId,
      transactionType: 'gift_card_sell',
      amount: payoutAmount,
      currency: 'NGN',
      title: 'Confirm Gift Card Sale',
      message: 'Sell ${_selectedCard!.displayName} ${_selectedCard!.currencies.isNotEmpty ? _selectedCard!.currencies.first : "USD"} ${_selectedDenomination!.toStringAsFixed(0)} card for ${_formatCurrency(payoutAmount)}?',
      onPinValidated: (verificationToken) async {
        await context.read<GiftCardCubit>().sellGiftCard(
          cardType: _selectedCard!.cardType,
          cardNumber: _cardNumberController.text.trim(),
          cardPin: _cardPinController.text.trim(),
          denomination: _selectedDenomination!,
          transactionId: transactionId,
          verificationToken: verificationToken,
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
      },
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
