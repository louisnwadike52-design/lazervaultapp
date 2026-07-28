import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc/grpc.dart';
import 'package:http/http.dart' as http;

import 'package:lazervault/core/config/api_config.dart';
import 'package:lazervault/core/services/locale_manager.dart';
import 'package:lazervault/core/services/secure_storage_service.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/core/errors/failures.dart';
import '../../domain/entities/insurance_entity.dart';
import '../../domain/entities/insurance_product_entity.dart';
import '../../domain/entities/insurance_document_upload_url.dart';
import '../../data/array_item_encoder.dart';
import '../../domain/repositories/insurance_repository.dart';
import '../../../authentication/domain/entities/user.dart';
import '../../../../../core/cache/cache_config.dart';
import '../../../../../core/cache/swr_cache_manager.dart';
import '../../../../core/utils/form_field_validators.dart';
import 'create_policy_state.dart';

/// Cubit for managing insurance policy creation via MyCover.ai marketplace
class CreatePolicyCubit extends Cubit<CreatePolicyState> {
  final InsuranceRepository _repository;
  final SWRCacheManager _cacheManager;
  final LocaleManager? _localeManager;

  CreatePolicyCubit({
    required InsuranceRepository repository,
    required SWRCacheManager cacheManager,
    LocaleManager? localeManager,
  })  : _repository = repository,
        _cacheManager = cacheManager,
        _localeManager = localeManager,
        super(const CreatePolicyInitial());

  // Marketplace state
  String _locale = 'NG';
  InsuranceProductCategory? _selectedCategory;
  InsuranceCategoryInfo? _selectedCategoryInfo;
  List<InsuranceProduct> _products = [];
  List<InsuranceCategoryInfo> _categories = [];

  // Slice 4 race guard. Every call to loadProductsPaginated bumps this
  // counter; the awaited response only emits if the counter is unchanged.
  // Prevents stale category products from landing in state when the user
  // taps categories fast (tap A → tap B → A's RPC completes last).
  int _productsLoadGeneration = 0;
  InsuranceProduct? _selectedProduct;
  Map<String, String> _formData = {};
  InsuranceQuote? _quote;
  String? _selectedAccountId;
  bool _agreedToTerms = false;
  bool _quotePending = false;
  bool _isPurchasing = false;
  String? _lastIdempotencyKey;

  // Cached admin-set terms link, fetched lazily when the user opens the
  // terms bottom sheet. Null = not yet resolved; "" = fetched but admin
  // has not configured a link (UI shows "unavailable").
  String? _cachedTermsLink;

  /// Lazily fetch the admin-set hosted Terms & Conditions link. Used by
  /// the in-app webview bottom sheet. Returns `null` when no link is
  /// configured so the sheet can render an "unavailable" state.
  Future<String?> resolveTermsLink() async {
    if (_cachedTermsLink != null) {
      return _cachedTermsLink!.isEmpty ? null : _cachedTermsLink;
    }
    final link = await _repository.getInsuranceTermsLink(locale: _locale);
    _cachedTermsLink = link;
    return link.isEmpty ? null : link;
  }

  /// Deferred file uploads — populated when the user picks a document
  /// on the form (`stagePendingFile`) and drained when the purchase
  /// saga begins (`_uploadPendingFiles`). Keeping the bytes off the
  /// network until purchase commit means the user can preview / replace
  /// the file without burning MyCover upload quota, and the actual
  /// upload happens INSIDE the processing screen so the form step
  /// feels instant.
  ///
  /// Keys are form-field names (`identification_url`, `device_photo`,
  /// `proof_of_purchase`, …). Values include the bytes, filename, and
  /// the MyCover-compatible document_type so the saga step uploads with
  /// the right metadata.
  final Map<String, _PendingFileUpload> _pendingUploads = {};

  /// Public read of a single staged file. Returns null when the field
  /// has no pending upload. Used by the form widget to render preview
  /// thumbnails + the full-screen viewer without leaking the private
  /// `_PendingFileUpload` class.
  StagedInsuranceFile? stagedFile(String fieldName) {
    final p = _pendingUploads[fieldName];
    if (p == null) return null;
    return StagedInsuranceFile._(
      bytes: p.bytes,
      filename: p.filename,
      contentType: p.contentType,
      isImage: p.isImage,
    );
  }

  /// Marker sentinel stored in `_formData` for fields whose upload is
  /// deferred to the purchase saga. Exposed so the form widget can
  /// detect the staged state without having to redeclare the constant.
  static const String pendingUploadMarker = _kPendingUploadMarker;

  // Legacy form data (kept for backward compat)
  InsuranceType _insuranceType = InsuranceType.health;
  String _provider = '';
  String _policyHolderName = '';
  // Split first/last from the user profile so a MyCover form that
  // ships separate first_name + last_name fields gets the right
  // half in each, not the concatenated full name in both. Falls back
  // to the full name when only one half is available.
  String _policyHolderFirstName = '';
  String _policyHolderLastName = '';
  String _policyHolderEmail = '';
  String _policyHolderPhone = '';
  double? _premiumAmount;
  double? _coverageAmount;
  String _currency = 'NGN';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 365));
  DateTime _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
  List<String> _beneficiaries = [];
  List<String> _features = [];
  Map<String, dynamic> _optionalFields = {};
  bool _isAutoFilled = false;

  // Marketplace getters
  String get locale => _locale;
  InsuranceProductCategory? get selectedCategory => _selectedCategory;
  InsuranceCategoryInfo? get selectedCategoryInfo => _selectedCategoryInfo;
  List<InsuranceProduct> get products => List.unmodifiable(_products);
  List<InsuranceCategoryInfo> get categories => List.unmodifiable(_categories);
  InsuranceProduct? get selectedProduct => _selectedProduct;
  Map<String, String> get formData => Map.unmodifiable(_formData);
  InsuranceQuote? get quote => _quote;
  String? get selectedAccountId => _selectedAccountId;
  bool get agreedToTerms => _agreedToTerms;

  // Legacy getters
  InsuranceType get insuranceType => _insuranceType;
  String get provider => _provider;
  String get policyHolderName => _policyHolderName;
  String get policyHolderEmail => _policyHolderEmail;
  String get policyHolderPhone => _policyHolderPhone;
  double? get premiumAmount => _premiumAmount;
  double? get coverageAmount => _coverageAmount;
  String get currency => _currency;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  DateTime get nextPaymentDate => _nextPaymentDate;
  List<String> get beneficiaries => List.unmodifiable(_beneficiaries);
  List<String> get features => List.unmodifiable(_features);
  Map<String, dynamic> get optionalFields => Map.unmodifiable(_optionalFields);
  bool get isAutoFilled => _isAutoFilled;

  // ============================================================
  // MyCover.ai Marketplace Methods
  // ============================================================

  /// The active currency from LocaleManager (reactive source of truth from dashboard)
  String get activeCurrency => _localeManager?.currentCurrency ?? _currency;

  /// Initialize with user data - derives locale and loads categories
  void initializeWithUserData(User user) {
    if (isClosed) return;
    emit(const CreatePolicyLoading());

    // Use LocaleManager as primary source (reflects dashboard locale picker)
    final lm = _localeManager;
    if (lm != null) {
      _currency = lm.currentCurrency;
      _locale = lm.currentCountry;
    } else {
      // Fallback to user profile
      _currency = user.currency ?? 'NGN';
      _locale = _deriveLocale(_currency);
    }

    // Auto-fill legacy form fields
    _policyHolderFirstName = user.firstName.trim();
    _policyHolderLastName = user.lastName.trim();
    _policyHolderName = '${user.firstName} ${user.lastName}'.trim();
    _policyHolderEmail = user.email;
    _policyHolderPhone = user.phoneNumber ?? '';
    _isAutoFilled = true;

    // Load categories for the derived locale
    loadCategories();
  }

  /// Derive locale code from currency
  String _deriveLocale(String currency) {
    switch (currency.toUpperCase()) {
      case 'NGN':
        return 'NG';
      case 'USD':
        return 'US';
      case 'GBP':
        return 'GB';
      case 'EUR':
        return 'EU';
      case 'GHS':
        return 'GH';
      case 'KES':
        return 'KE';
      case 'ZAR':
        return 'ZA';
      default:
        return 'NG'; // Default to Nigeria (MyCover.ai primary market)
    }
  }

  /// Load insurance categories
  Future<void> loadCategories() async {
    if (isClosed) return;

    try {
      _categories = await _repository.getInsuranceCategories(locale: _locale);
      if (isClosed) return;
      emit(InsuranceCategoriesLoaded(categories: _categories, locale: _locale));
    } on GrpcError catch (e) {
      if (isClosed) return;
      if (e.code == StatusCode.failedPrecondition) {
        emit(const CreatePolicyError(
          message: 'Insurance marketplace is not available at this time. Please try again later or contact support.',
        ));
      } else if (e.code == StatusCode.unavailable) {
        emit(const CreatePolicyError(
          message: 'Unable to connect to insurance service. Please check your connection and try again.',
        ));
      } else {
        emit(CreatePolicyError(message: friendlyGrpcError(e, 'Failed to load categories')));
      }
    } catch (e) {
      if (isClosed) return;
      final errorStr = e.toString();
      if (errorStr.contains('not available') ||
          errorStr.contains('not configured') ||
          errorStr.contains('marketplace')) {
        emit(const CreatePolicyError(
          message: 'Insurance marketplace is not available at this time. Please try again later or contact support.',
        ));
      } else if (errorStr.contains('temporarily unavailable')) {
        emit(const CreatePolicyError(
          message: 'Unable to connect to insurance service. Please check your connection and try again.',
        ));
      } else {
        emit(CreatePolicyError(message: 'Failed to load categories: $errorStr'));
      }
    }
  }

  /// Load products for a category with SWR caching. Prefer passing
  /// [info] (the backend-resolved CategoryInfo with UUID) — the
  /// enum-only form is kept for backwards compatibility but is lossy:
  /// multiple backend categories can map to the same enum (e.g. both
  /// `Agency Banking` and `Credit Life` resolve to `.other`), and
  /// firstWhere then picks the wrong one. When [info] is supplied,
  /// the UUID round-trips exactly to the backend.
  Future<void> loadProducts({
    InsuranceCategoryInfo? info,
    InsuranceProductCategory? category,
  }) async {
    if (isClosed) return;

    // Clear selected product when changing categories to avoid stale UI
    _selectedProduct = null;

    if (info != null) {
      // Caller supplied the backend-resolved object — use it directly.
      // This is the lossless path; the enum value below is only used
      // for the icon on the products screen.
      _selectedCategoryInfo = info;
      _selectedCategory = info.category;
    } else {
      // Legacy enum-only callers: resolve back to the first matching
      // CategoryInfo. Safe only for enum values that uniquely identify
      // a backend category (Auto/Health/Travel/Gadget/Marine — but
      // NOT `.other`, which is the catch-all).
      _selectedCategory = category;
      _selectedCategoryInfo = category != null
          ? _categories.cast<InsuranceCategoryInfo?>().firstWhere(
              (c) => c!.category == category,
              orElse: () => null,
            )
          : null;
    }

    emit(InsuranceProductsLoading(category: _selectedCategory));

    // Pass category UUID (id) to backend to avoid the extra GetCategories() call
    final categoryId = _selectedCategoryInfo?.id;
    final cacheKey = 'insurance_products_${_locale}_${categoryId ?? category?.name ?? 'all'}';

    try {
      await for (final result in _cacheManager.get<List<InsuranceProduct>>(
        key: cacheKey,
        fetcher: () => _repository.getInsuranceProducts(
          locale: _locale,
          category: categoryId ?? category?.name,
        ),
        config: CacheConfig.insuranceProducts,
        serializer: (products) => jsonEncode(
          products.map((p) => {
            'id': p.id,
            'name': p.name,
            'description': p.description,
            'category': p.category.name,
            'providerName': p.providerName,
            'providerLogo': p.providerLogo,
            'minPremium': p.minPremium,
            'maxPremium': p.maxPremium,
            'currency': p.currency,
            'benefits': p.benefits,
            'termsUrl': p.termsUrl,
            'metadata': p.metadata,
            'formFields': p.formFields.map((f) => {
              'name': f.name,
              'label': f.label,
              'type': f.type,
              'required': f.required,
              'options': f.options,
              'defaultValue': f.defaultValue,
              'validationRegex': f.validationRegex,
              'placeholder': f.placeholder,
              'description': f.description,
            }).toList(),
            'isActive': p.isActive,
            'purchaseRoute': p.purchaseRoute,
            'providerId': p.providerId,
            'basePrice': p.basePrice,
            'howItWorks': p.howItWorks,
            'fullBenefits': p.fullBenefits,
            'isRenewable': p.isRenewable,
            'isClaimable': p.isClaimable,
          }).toList(),
        ),
        deserializer: (json) {
          final list = jsonDecode(json) as List;
          return list.map((j) {
            final map = j as Map<String, dynamic>;
            return InsuranceProduct(
              id: map['id'] as String,
              name: map['name'] as String,
              description: map['description'] as String,
              category: InsuranceProductCategory.fromString(map['category'] as String),
              providerName: map['providerName'] as String,
              providerLogo: (map['providerLogo'] as String?) ?? '',
              minPremium: (map['minPremium'] as num).toDouble(),
              maxPremium: (map['maxPremium'] as num).toDouble(),
              currency: map['currency'] as String,
              benefits: List<String>.from(map['benefits'] as List? ?? []),
              termsUrl: (map['termsUrl'] as String?) ?? '',
              metadata: Map<String, String>.from(map['metadata'] as Map? ?? {}),
              formFields: (map['formFields'] as List? ?? []).map((f) {
                final fm = f as Map<String, dynamic>;
                return InsuranceProductFormField(
                  name: fm['name'] as String? ?? '',
                  label: fm['label'] as String? ?? '',
                  type: fm['type'] as String? ?? 'text',
                  required: fm['required'] as bool? ?? false,
                  options: List<String>.from(fm['options'] as List? ?? []),
                  defaultValue: fm['defaultValue'] as String? ?? '',
                  validationRegex: fm['validationRegex'] as String? ?? '',
                  placeholder: fm['placeholder'] as String? ?? '',
                  description: fm['description'] as String? ?? '',
                );
              }).toList(),
              isActive: (map['isActive'] as bool?) ?? true,
              purchaseRoute: (map['purchaseRoute'] as String?) ?? '',
              providerId: (map['providerId'] as String?) ?? '',
              basePrice: (map['basePrice'] as num?)?.toDouble() ?? 0,
              howItWorks: (map['howItWorks'] as String?) ?? '',
              fullBenefits: (map['fullBenefits'] as String?) ?? '',
              isRenewable: (map['isRenewable'] as bool?) ?? false,
              isClaimable: (map['isClaimable'] as bool?) ?? false,
            );
          }).toList();
        },
      )) {
        if (isClosed) return;
        // If user already selected a product, don't overwrite that state
        // with a late SWR revalidation emission
        if (_selectedProduct != null) return;
        if (result.data != null) {
          _products = result.data!;
          emit(InsuranceProductsLoaded(
            products: _products,
            categories: _categories,
            selectedCategory: _selectedCategory,
            locale: _locale,
            isStale: result.isStale,
          ));
        }
      }
    } catch (e) {
      if (isClosed) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('connection') || msg.contains('unavailable') || msg.contains('socket')) {
        emit(const CreatePolicyError(message: 'Unable to connect. Please check your connection and try again.'));
      } else if (msg.contains('timeout') || msg.contains('deadline')) {
        emit(const CreatePolicyError(message: 'Request timed out. Please try again.'));
      } else {
        emit(const CreatePolicyError(message: 'Failed to load insurance products. Please try again.'));
      }
    }
  }

  /// Slice 4: paginated entry point. Used by screens that want
  /// scroll-to-bottom infinite scroll. Replaces the legacy
  /// loadProducts(info: …) path that fetched all products at once.
  ///
  /// First call resets the list to page 1. Subsequent loadMoreProducts()
  /// calls append next pages.
  Future<void> loadProductsPaginated({
    InsuranceCategoryInfo? info,
    InsuranceProductCategory? category,
    int limit = 15,
  }) async {
    if (isClosed) return;
    _selectedProduct = null;
    if (info != null) {
      _selectedCategoryInfo = info;
      _selectedCategory = info.category;
    } else {
      _selectedCategory = category;
      _selectedCategoryInfo = category != null
          ? _categories.cast<InsuranceCategoryInfo?>().firstWhere(
              (c) => c!.category == category,
              orElse: () => null,
            )
          : null;
    }
    // Clear stale products from a previous category before emitting
    // Loading. Without this, the screen renders the new Loading
    // indicator on top of the *old* category's product tiles for a
    // frame, which looks like a glitch when switching categories fast.
    _products = const [];
    emit(InsuranceProductsLoading(category: _selectedCategory));

    // Slice 4 race guard: bump generation so any in-flight previous call's
    // emit is dropped when it lands.
    _productsLoadGeneration++;
    final myGeneration = _productsLoadGeneration;
    final categoryId = _selectedCategoryInfo?.id;
    try {
      final page = await _repository.getInsuranceProductsPage(
        locale: _locale,
        category: categoryId ?? category?.name,
        page: 1,
        limit: limit,
      );
      if (isClosed) return;
      if (myGeneration != _productsLoadGeneration) return; // superseded
      _products = page.products;
      emit(InsuranceProductsLoaded(
        products: _products,
        categories: _categories,
        selectedCategory: _selectedCategory,
        locale: _locale,
        isStale: false,
        hasMore: page.hasMore,
        isLoadingMore: false,
        currentPage: 1,
      ));
    } catch (e) {
      developer.log('[loadProductsPaginated] threw: runtimeType=${e.runtimeType} '
          'message=${e.toString()}');
      if (isClosed) return;
      if (myGeneration != _productsLoadGeneration) return; // superseded
      final msg = e.toString().toLowerCase();
      if (msg.contains('connection') ||
          msg.contains('unavailable') ||
          msg.contains('socket')) {
        emit(const CreatePolicyError(
          message:
              'Unable to connect. Please check your connection and try again.',
        ));
      } else if (msg.contains('timeout') || msg.contains('deadline')) {
        emit(const CreatePolicyError(
          message: 'Request timed out. Please try again.',
        ));
      } else {
        emit(const CreatePolicyError(
          message: 'Failed to load insurance products. Please try again.',
        ));
      }
    }
  }

  /// Slice 4: fetch the next page of products and append to the loaded
  /// list. No-op when there's no more, an in-flight load, or the state
  /// isn't InsuranceProductsLoaded.
  Future<void> loadMoreProducts() async {
    if (isClosed) return;
    final current = state;
    if (current is! InsuranceProductsLoaded) return;
    if (!current.hasMore || current.isLoadingMore) return;

    // Optimistic state — show footer spinner.
    emit(current.copyWith(isLoadingMore: true));

    // Race guard: if the user taps another category mid-load-more, the
    // generation bumps and we abandon this fetch's emit.
    final myGeneration = _productsLoadGeneration;
    final categoryId = _selectedCategoryInfo?.id;
    final nextPage = current.currentPage + 1;
    try {
      final page = await _repository.getInsuranceProductsPage(
        locale: _locale,
        category: categoryId ?? _selectedCategory?.name,
        page: nextPage,
        limit: 15,
      );
      if (isClosed) return;
      if (myGeneration != _productsLoadGeneration) return;
      // Re-read latest state in case it was rebuilt between optimistic
      // emit and now (pull-to-refresh etc).
      final latest = state;
      if (latest is! InsuranceProductsLoaded) return;
      _products = [...latest.products, ...page.products];
      emit(latest.copyWith(
        products: _products,
        isLoadingMore: false,
        currentPage: nextPage,
        hasMore: page.hasMore,
        isStale: false,
      ));
    } catch (e) {
      if (isClosed) return;
      if (myGeneration != _productsLoadGeneration) return;
      // On load-more failure, drop the in-flight flag and keep the
      // existing page intact so the user can retry by scrolling again.
      final latest = state;
      if (latest is InsuranceProductsLoaded) {
        emit(latest.copyWith(isLoadingMore: false));
      }
    }
  }

  /// Navigate back to the category grid without losing loaded categories
  void backToCategories() {
    if (isClosed) return;
    _selectedProduct = null;
    _selectedCategory = null;
    _selectedCategoryInfo = null;
    _products = [];
    emit(InsuranceCategoriesLoaded(categories: _categories, locale: _locale));
  }

  /// Select a product and prepare for form filling
  void selectProduct(InsuranceProduct product) {
    if (isClosed) return;
    _selectedProduct = product;
    _formData = {};

    // Pre-fill default values from form fields. Boolean fields get a
    // schema-aware default when the product doesn't ship one so that an
    // unflipped toggle doesn't trip the "fill required fields" error.
    //
    // The "buying for self" family (`bought_for_self`, `buying_for_self`,
    // `for_self`) defaults to TRUE — buying for yourself is the happy
    // path, and MyCover rejects the purchase with HTTP 400 when this is
    // false unless the form also collects `insured_first_name`,
    // `insured_email`, etc. (which our schema doesn't ship). Defaulting
    // to true keeps the happy path clean while still letting the user
    // flip the switch if they're buying for someone else.
    //
    // Everything else (consent toggles, terms acceptance, optional
    // add-ons) defaults to FALSE — the user must take an explicit
    // action to opt in.
    for (final field in product.formFields) {
      if (field.defaultValue.isNotEmpty) {
        _formData[field.name] = field.defaultValue;
      } else if (field.type.toLowerCase() == 'boolean') {
        _formData[field.name] =
            _isBuyingForSelfField(field.name) ? 'true' : 'false';
      }
    }

    // Belt-and-suspenders: MyCover's Sanlam underwriter rejects an
    // empty `bought_for_self` with a generic "External: Internal Server
    // Error". When the product schema doesn't declare the field as a
    // boolean (so the loop above missed it), seed it to "true" so the
    // wire payload always carries a valid value. Wire format matches
    // the Switch widget's `true.toString()` output.
    _formData.putIfAbsent('bought_for_self', () => 'true');

    // Auto-fill common fields from user data. For person-name fields
    // we route to the right half: `first_name`/`firstname` → first
    // name only; `last_name`/`lastname`/`surname` → last name only;
    // everything else in the whitelist (`name`, `full_name`, etc.)
    // gets the concatenated full name. This stops the previous bug
    // where MyCover received "Finance Nwadike" in BOTH first_name
    // and last_name fields.
    for (final field in product.formFields) {
      final name = field.name.toLowerCase();
      if (name.contains('email') && _policyHolderEmail.isNotEmpty) {
        _formData[field.name] = _policyHolderEmail;
      } else if (name.contains('phone') && _policyHolderPhone.isNotEmpty) {
        _formData[field.name] = _policyHolderPhone;
      } else if (_isPersonNameField(name)) {
        final v = _autoFillNameValue(name);
        if (v.isNotEmpty) _formData[field.name] = v;
      }
    }

    emit(InsuranceProductSelected(product: product, formData: _formData));
    // BVN / NIN auto-fill runs async because secure storage I/O is
    // platform-bridged. We emit the product-selected state synchronously
    // first so the form renders immediately, then patch in the identity
    // numbers when they arrive. Fields stay editable — the user can
    // overwrite both during typing and via updateFormField.
    _autoFillIdentityNumbers(product);
  }

  /// Prefill the verified NIN / BVN (and date of birth) from the user's KYC
  /// record and merge into the form. Only writes when a matching form field
  /// exists AND the field isn't already filled — preserving any value the
  /// user has typed (and supporting "buying for someone else").
  ///
  /// The raw NIN/BVN are NOT held on the device — Mono collects them
  /// server-side during KYC — so we fetch the caller's OWN verified identity
  /// from the backend prefill endpoint. Field-name matching handles MyCover's
  /// product-specific schema variations (`bvn`, `bvn_number`, `nin`,
  /// `national_id`, `date_of_birth`, …). On any failure the fields stay
  /// editable/empty and financial-products-service still auto-fills them from
  /// the same KYC record at purchase time (defence in depth).
  Future<void> _autoFillIdentityNumbers(InsuranceProduct product) async {
    final hasBvnField = product.formFields.any(
        (f) => _isBvnField(f.name) && (_formData[f.name] ?? '').isEmpty);
    final hasNinField = product.formFields.any(
        (f) => _isNinField(f.name) && (_formData[f.name] ?? '').isEmpty);
    final hasDobField = product.formFields.any(
        (f) => _isDobField(f.name) && (_formData[f.name] ?? '').isEmpty);
    if (!hasBvnField && !hasNinField && !hasDobField) return;

    final prefill = await _fetchInsurancePrefill();
    if (isClosed || prefill == null) return;
    final bvn = (prefill['bvn'] ?? '').toString();
    final nin = (prefill['nin'] ?? '').toString();
    final dob =
        (prefill['dateOfBirth'] ?? prefill['date_of_birth'] ?? '').toString();
    if (bvn.isEmpty && nin.isEmpty && dob.isEmpty) return;

    var mutated = false;
    for (final f in product.formFields) {
      if ((_formData[f.name] ?? '').isNotEmpty) continue; // never clobber
      if (_isBvnField(f.name) && bvn.isNotEmpty) {
        _formData[f.name] = bvn;
        mutated = true;
      } else if (_isNinField(f.name) && nin.isNotEmpty) {
        _formData[f.name] = nin;
        mutated = true;
      } else if (_isDobField(f.name) && dob.isNotEmpty) {
        _formData[f.name] = dob;
        mutated = true;
      }
    }
    if (mutated && _selectedProduct != null) {
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: Map<String, String>.from(_formData),
      ));
    }
  }

  /// Fetch the authenticated user's OWN verified identity (name/email/phone/
  /// dob + raw nin/bvn) for prefill. Returns null on any failure so the form
  /// degrades gracefully — fields stay editable and the backend auto-fill is
  /// the safety net at purchase time.
  Future<Map<String, dynamic>?> _fetchInsurancePrefill() async {
    try {
      final storage = serviceLocator<SecureStorageService>();
      final token = await storage.getAccessToken();
      if (token == null || token.isEmpty) return null;
      final resp = await http.get(
        Uri.parse(
            '${ApiConfig.coreGatewayUrl}/api/v1/auth/me/insurance-prefill'),
        headers: {'Authorization': 'Bearer $token'},
      ).timeout(const Duration(seconds: 10));
      if (resp.statusCode != 200) return null;
      final decoded = jsonDecode(resp.body);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (_) {
      // GetIt unavailable (unit tests), network error, parse error — skip.
      return null;
    }
  }

  bool _isDobField(String name) {
    final n = name.toLowerCase();
    return n == 'dob' ||
        n.contains('date_of_birth') ||
        n.contains('dateofbirth') ||
        n.contains('birth_date') ||
        n.contains('birthdate');
  }

  /// Picks the right half of the policy-holder's name to drop into a
  /// MyCover form field. The form schema can ship `first_name`,
  /// `last_name`, OR a unified `full_name`/`name`; we hand back the
  /// matching slice. Empty string when the user profile has no name.
  String _autoFillNameValue(String fieldNameLower) {
    final first = _policyHolderFirstName;
    final last = _policyHolderLastName;
    final full = _policyHolderName;
    if (fieldNameLower == 'first_name' || fieldNameLower == 'firstname') {
      return first.isNotEmpty ? first : full;
    }
    if (fieldNameLower == 'last_name' ||
        fieldNameLower == 'lastname' ||
        fieldNameLower == 'surname') {
      return last.isNotEmpty ? last : full;
    }
    // `name`, `full_name`, `policy_holder_name`, `insured_name`, etc.
    return full;
  }

  // Tight whitelist for "auto-fill the policy holder's name into this
  // field". Substring matching on `name` was too greedy and was landing
  // the full name into fields like `identification_name` (whose label
  // is "Identification Type" — a select), `bank_name`, `nok_full_name`,
  // etc. Match only the canonical names MyCover uses for the buyer's
  // own name.
  bool _isPersonNameField(String n) {
    return n == 'name' ||
        n == 'full_name' ||
        n == 'first_name' ||
        n == 'firstname' ||
        n == 'last_name' ||
        n == 'lastname' ||
        n == 'surname' ||
        n == 'customer_name' ||
        n == 'policy_holder_name' ||
        n == 'holder_name' ||
        n == 'insured_name';
  }

  /// Returns true when the `bought_for_self` form value is the
  /// canonical "false" (or one of the forgiving aliases the cubit also
  /// accepts: "0", "no"). Treated as false everywhere else — that
  /// matches the Switch's `false.toString()` output and the backend
  /// validator at `PurchaseMarketplaceInsurance`.
  bool _isBoughtForSelfFalse(String? raw) {
    if (raw == null) return false;
    final v = raw.trim().toLowerCase();
    return v == 'false' || v == '0' || v == 'no';
  }

  // Matches the MyCover boolean field that toggles between "I'm buying
  // for myself" (true) and "I'm buying for someone else" (false).
  // Currently `bought_for_self` per the v2 schema; we also match a few
  // legacy / variant spellings (`buying_for_self`, `for_self`) so the
  // default flip doesn't depend on exact field naming.
  bool _isBuyingForSelfField(String name) {
    final n = name.toLowerCase();
    return n == 'bought_for_self' ||
        n == 'buying_for_self' ||
        n == 'buy_for_self' ||
        n == 'for_self';
  }

  bool _isBvnField(String name) {
    final n = name.toLowerCase();
    return n == 'bvn' || n.startsWith('bvn_') || n.endsWith('_bvn') ||
        n.contains('bvn_number');
  }

  bool _isNinField(String name) {
    final n = name.toLowerCase();
    return n == 'nin' || n.startsWith('nin_') || n.endsWith('_nin') ||
        n.contains('nin_number') || n == 'national_id' ||
        n == 'national_identification_number';
  }

  /// Update a form field value
  /// Fields whose value changes the premium — editing any of them
  /// after a quote was loaded must invalidate the cached quote so
  /// the user re-quotes instead of paying with a stale premium.
  static const _premiumDrivingFields = <String>{
    // Auto / Gadget
    'value', 'vehicle_value',
    // Health / Hospicash
    'payment_plan',
    // Package / Content / Riders
    'total_value', 'sum_insured', 'item_details', 'items',
    // Travel
    'num_of_passengers', 'departure_date', 'arrival_date',
    'destination', 'nationality',
    // Property
    'property_value', 'contents_value',
    // Life
    'benefits', 'benefit_details', 'beneficiaries',
    'repayment_amount', 'repayment_plan',
    // Content variant
    'plan',
  };

  void updateFormField(String name, String value) {
    if (isClosed) return;

    // Trim text values (not dropdowns/booleans)
    final trimmedValue = (value == 'true' || value == 'false') ? value : value.trim();
    final previous = _formData[name];
    _formData = {..._formData, name: trimmedValue};

    // Clear dependent vehicle_model when vehicle_make changes
    if (name == 'vehicle_make' || name == 'make') {
      _formData.remove('vehicle_model');
      _formData.remove('model');
    }

    // Invalidate any cached quote when a premium-driving input
    // actually changes — otherwise the user could see a fresh quote
    // for ₦52,500 then edit `vehicle_value` from 1M to 5M and
    // submit at the stale premium. The user has to re-tap "Get
    // Quote" after such an edit.
    if (_quote != null
        && previous != null
        && previous != trimmedValue
        && _premiumDrivingFields.contains(name)) {
      _quote = null;
      _lastIdempotencyKey = null; // fresh quote ⇒ fresh idempotency key
    }

    if (_selectedProduct != null) {
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: _formData,
      ));
    }
  }

  /// Returns true when [raw] is a JSON-encoded empty array, or an
  /// array whose entries are all empty maps / strings (e.g. `"[]"`,
  /// `"[{}]"`, `"[\"\"]"`, `"[{\"name\":\"\"}]"`). Used to catch the
  /// "added a row but didn't fill anything" submission path.
  static bool _isEmptyJsonArray(String raw) {
    if (raw.isEmpty) return true;
    try {
      final parsed = jsonDecode(raw);
      if (parsed is! List) return false;
      if (parsed.isEmpty) return true;
      // Every entry must have at least one non-empty scalar.
      return parsed.every((entry) {
        if (entry == null) return true;
        if (entry is String) return entry.trim().isEmpty;
        if (entry is Map) {
          return entry.values.every((v) {
            if (v == null) return true;
            if (v is String) return v.trim().isEmpty;
            return false;
          });
        }
        return false;
      });
    } catch (_) {
      // Malformed JSON — let the existing regex/required check handle it.
      return false;
    }
  }

  /// Validate dynamic form fields and return true if valid.
  ///
  /// Array-typed fields (`items`, `item_details`, `benefits`,
  /// `beneficiaries`, `benefit_details`) are stored as JSON-encoded
  /// strings — `"[]"`, `"[{}]"`, and `"[{\"name\":\"\"}]"` would all
  /// pass the simple `value.isEmpty` check while violating the
  /// required contract. Detect those cases explicitly.
  bool validateFormFields() {
    if (_selectedProduct == null) return false;

    // `bought_for_self` decides whether the `insured_*` family of
    // fields is required. MyCover marks them optional at the schema
    // level because they're conditionally-required at the API level —
    // only when the toggle is off. Mirror that contract here so the
    // Flutter form doesn't block the happy path AND doesn't let an
    // empty submission slip through to MyCover when the toggle is off.
    final boughtForSelf = !_isBoughtForSelfFalse(_formData['bought_for_self']);

    final errors = <String, String>{};
    for (final field in _selectedProduct!.formFields) {
      final value = _formData[field.name] ?? '';
      final isArray = field.type.toLowerCase() == 'array';
      final isInsuredField = field.name.startsWith('insured_');

      // Skip insured_* fields entirely when buying for self — they're
      // hidden on the form and irrelevant to the submission.
      if (isInsuredField && boughtForSelf) continue;

      // Treat insured_* as required when buying for someone else, even
      // though the schema marks them optional. Otherwise honor the
      // schema's required flag.
      final required = field.required || (isInsuredField && !boughtForSelf);

      if (required && value.isEmpty) {
        errors[field.name] = '${field.label} is required';
      } else if (required && isArray && _isEmptyJsonArray(value)) {
        errors[field.name] = 'Add at least one ${field.label.toLowerCase()} entry';
      } else if (isArray && isInsuredItemsField(field.name) && value.isNotEmpty) {
        // Per-item content rules MyCover enforces (image, description ≥ 5,
        // value ≥ ₦50,000). Catch them here so the user fixes the entry in
        // the form instead of failing the purchase right after PIN entry.
        final itemErr = validateInsuredItems(itemSchemaFor(field), value);
        if (itemErr != null) errors[field.name] = itemErr;
      } else if (value.isNotEmpty &&
          field.name.toLowerCase() == 'value' &&
          _selectedProduct?.category == InsuranceProductCategory.gadget) {
        // Gadget device `value` must be ≥ ₦100,000 (MyCover minimum that isn't
        // in the discovered schema). Block at the Continue gate so the user
        // fixes it before PIN/pay instead of failing at MyCover.
        final n = num.tryParse(value.replaceAll(RegExp(r'[^0-9.]'), ''));
        if (n == null || n < 100000) {
          errors[field.name] = 'Must be at least ₦100,000';
        }
      } else if (value.isNotEmpty &&
          field.name.toLowerCase() == 'serial_number' &&
          value.trim().length < 10) {
        // MyCover: "/serial_number must NOT have fewer than 10 characters".
        errors[field.name] = 'Must be at least 10 characters';
      } else if (value.isNotEmpty && field.validationRegex.isNotEmpty) {
        try {
          final regex = RegExp(field.validationRegex);
          if (!regex.hasMatch(value)) {
            errors[field.name] = 'Invalid ${field.label.toLowerCase()}';
          }
        } catch (_) {
          // Malformed regex from provider - skip regex validation
        }
      }
    }

    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: _formData,
        formErrors: errors,
      ));
      return false;
    }

    return true;
  }

  /// Get a quote for the selected product with current form data
  Future<void> getQuote() async {
    developer.log('[getQuote] enter; closed=$isClosed product=${_selectedProduct?.id} pending=$_quotePending');
    if (isClosed || _selectedProduct == null) {
      developer.log('[getQuote] early return: isClosed/product-null');
      return;
    }
    if (_quotePending) {
      developer.log('[getQuote] early return: _quotePending=true (concurrent call)');
      return;
    }

    if (!validateFormFields()) {
      // After validateFormFields fails it emits InsuranceProductSelected
      // with formErrors. Read those out of the current state so the
      // log line names the offending fields.
      final s = state;
      final errs = s is InsuranceProductSelected ? s.formErrors : const <String, String>{};
      developer.log('[getQuote] early return: validateFormFields=false; '
          'errors=${errs.entries.map((e) => "${e.key}:${e.value}").join(", ")}; '
          'formDataKeys=${_formData.keys.toList()}');
      return;
    }

    _quotePending = true;
    developer.log('[getQuote] validation passed; firing gRPC. formDataKeys=${_formData.keys.toList()}');
    // Reset idempotency key when requesting a new quote (even if it fails)
    _lastIdempotencyKey = null;

    final product = _selectedProduct!;
    emit(InsuranceQuoteLoading(product: product));

    try {
      _quote = await _repository.getInsuranceQuote(
        productId: product.id,
        formData: _formData,
        locale: _locale,
      );

      if (isClosed) return;
      // Re-check _selectedProduct after async gap — user may have navigated away
      if (_selectedProduct == null || _quote == null) return;

      developer.log('[getQuote] success; emitting Loaded');
      emit(InsuranceQuoteLoaded(
        quote: _quote!,
        product: _selectedProduct!,
        formData: _formData,
      ));
    } catch (e) {
      developer.log('[getQuote] threw: $e');
      if (isClosed) return;
      final msg = e.toString().toLowerCase();
      if (msg.contains('connection') || msg.contains('unavailable') || msg.contains('socket')) {
        emit(const CreatePolicyError(message: 'Unable to connect. Please check your connection and try again.'));
      } else if (msg.contains('timeout') || msg.contains('deadline')) {
        emit(const CreatePolicyError(message: 'Quote request timed out. Please try again.'));
      } else if (msg.contains('not found')) {
        emit(const CreatePolicyError(message: 'This product is currently unavailable. Please try another plan.'));
      } else {
        emit(const CreatePolicyError(message: 'Failed to get quote. Please try again.'));
      }
    } finally {
      _quotePending = false;
    }
  }

  /// Set the selected account for payment
  void selectAccount(String accountId) {
    if (isClosed) return;
    _selectedAccountId = accountId;
    // Re-emit current state so UI can update
    if (_quote != null && _selectedProduct != null) {
      emit(InsuranceQuoteLoaded(
        quote: _quote!,
        product: _selectedProduct!,
        formData: _formData,
      ));
    }
  }

  /// Set terms agreement
  void setTermsAgreed(bool agreed) {
    _agreedToTerms = agreed;
  }

  /// Check if an error is a network/connectivity error
  bool _isNetworkError(dynamic error) {
    if (error is GrpcError) {
      return error.code == StatusCode.unavailable ||
          error.code == StatusCode.deadlineExceeded ||
          error.code == StatusCode.unknown;
    }
    final s = error.toString().toLowerCase();
    return s.contains('network') || s.contains('connection') || s.contains('socket');
  }

  /// Turns a purchase GrpcError into a clear, actionable message. The
  /// backend + MyCover surface field-level validation as FailedPrecondition /
  /// InvalidArgument with messages like "item_details: item 1: description
  /// must be at least 5 characters" or "invalid vehicle_plate_number". Those
  /// are exactly what the user needs to see, but `friendlyGrpcError` treats
  /// their field-key/underscore shape as "technical" and hides them behind a
  /// generic fallback. Clean the message (drop the leading field-key prefix,
  /// tidy underscores, capitalise) and surface it directly.
  String _friendlyPurchaseError(GrpcError e) {
    if (e.code == StatusCode.failedPrecondition ||
        e.code == StatusCode.invalidArgument) {
      var msg = (e.message ?? '').trim();
      // Strip a leading "Please review: " / "field_name: " prefix.
      msg = msg.replaceFirst(
          RegExp(r'^\s*please review:\s*', caseSensitive: false), '');

      // Missing-field errors — surface WHICH field(s) to provide. MyCover
      // phrases these three ways: AJV "must have required property 'X'"
      // (often several at once), "X is missing in body", and "X is required".
      final missing = <String>{};
      for (final m
          in RegExp(r"required property '([a-zA-Z0-9_]+)'").allMatches(msg)) {
        missing.add(m.group(1)!);
      }
      if (missing.isEmpty) {
        final m = RegExp(r'^([a-z0-9_]+)\s+is\s+(?:missing|required)\b',
                caseSensitive: false)
            .firstMatch(msg);
        if (m != null) missing.add(m.group(1)!);
      }
      if (missing.isNotEmpty) {
        final labels = missing.map(_humanizeFieldName).toList();
        return labels.length == 1
            ? 'Please provide your ${labels.first} to continue.'
            : 'Please provide these to continue: ${labels.join(', ')}.';
      }

      // Numeric-constraint errors, e.g. "/value must be >= 100000" — tell the
      // user the actual minimum/maximum (MyCover's per-product limits aren't in
      // our schema, so we can't pre-block them, but we can name them clearly).
      final numMatch = RegExp(
              r'/?([a-zA-Z0-9_]+)\s+must\s+be\s+(>=|<=|>|<)\s*([0-9]+)',
              caseSensitive: false)
          .firstMatch(msg);
      if (numMatch != null) {
        final field = _humanizeFieldName(numMatch.group(1)!).toLowerCase();
        final op = numMatch.group(2)!;
        final n = int.tryParse(numMatch.group(3)!) ?? 0;
        final phrase = op.startsWith('>') ? 'at least' : 'at most';
        return 'The $field must be $phrase ${_formatNaira(n)}.';
      }

      // Unreachable document upload, e.g. "URL is not reachable for property
      // 'certificate_of_origin_url': received status 404".
      final urlMatch = RegExp(
              r'''reachable for property\s+["']?([a-zA-Z0-9_]+)''',
              caseSensitive: false)
          .firstMatch(msg);
      if (urlMatch != null) {
        return 'Please re-attach your ${_humanizeFieldName(urlMatch.group(1)!)} and try again.';
      }

      // Provider-side lookup failure — the request passed field validation but
      // the insurer couldn't rate/match it (e.g. "External: There is no row at
      // position 0."). Usually an unsupported device make/model/type combo.
      final lower = msg.toLowerCase();
      if (lower.contains('no row at position') || lower.startsWith('external:')) {
        return "The insurer couldn't process these details. Please double-check "
            'your selections (e.g. device make, model and type) and try again.';
      }

      // Otherwise clean whatever field-level message came back.
      final firstColon = msg.indexOf(': ');
      if (firstColon > 0 &&
          firstColon < 24 &&
          !msg.substring(0, firstColon).contains(' ')) {
        msg = msg.substring(firstColon + 2).trim();
      }
      msg = msg.replaceAll('_', ' ').trim();
      if (msg.isNotEmpty) {
        msg = msg[0].toUpperCase() + msg.substring(1);
        if (!msg.endsWith('.')) msg = '$msg.';
        return msg;
      }
    }
    return friendlyGrpcError(e, 'Failed to purchase insurance');
  }

  /// Formats a plain integer as naira with thousands separators, e.g.
  /// 100000 → "₦100,000".
  String _formatNaira(int amount) {
    final s = amount.toString();
    final buf = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return '₦$buf';
  }

  /// "bill_of_lading_url" → "Bill of lading". Drops a trailing "_url", turns
  /// snake_case into words, and sentence-cases the result.
  String _humanizeFieldName(String name) {
    var n = name;
    if (n.endsWith('_url')) n = n.substring(0, n.length - 4);
    n = n.replaceAll('_', ' ').trim();
    if (n.isEmpty) return name;
    return n[0].toUpperCase() + n.substring(1);
  }

  /// Purchase insurance with the current quote
  Future<void> purchaseInsurance({
    required String accountId,
    required String transactionPin,
    String? transactionId,
  }) async {
    if (isClosed) return;
    if (_selectedProduct == null || _quote == null) {
      emit(const CreatePolicyError(message: 'Quote not available. Please go back and get a new quote.'));
      return;
    }

    // Check quote expiry BEFORE the isPurchasing guard so user always gets feedback
    if (_quote!.isExpired) {
      emit(const CreatePolicyError(message: 'Quote has expired. Please get a new quote.'));
      return;
    }

    if (_isPurchasing) return;
    _isPurchasing = true;

    _selectedAccountId = accountId;

    // Capture references before async gap — protects against null after await
    final quote = _quote!;
    final product = _selectedProduct!;

    // Reuse idempotency key on retry, generate new one for genuinely new purchases
    _lastIdempotencyKey ??= _generateIdempotencyKey(
      quote.quoteId,
      product.id,
      quote.premium,
    );
    final idempotencyKey = _lastIdempotencyKey!;

    // Emit initial processing state
    emit(InsurancePurchaseProcessing(
      step: InsuranceProcessingStep.validatingPin,
      product: product,
      quote: quote,
      progress: 0.25,
    ));

    try {
      // Step 1.5 — flush any deferred file uploads BEFORE the MyCover
      // buy call. Files staged on the form (preview only) get uploaded
      // here, their returned URLs stamped into form_data so the
      // payload MyCover sees carries real URLs, never the local
      // `__pending_upload__` marker. Runs in parallel for all staged
      // files so the wait time is bounded by the slowest upload, not
      // the sum. Failure here aborts the saga before any wallet hold
      // is created — protects the user's funds when an upload fails
      // mid-flow.
      if (_pendingUploads.isNotEmpty) {
        if (!isClosed) {
          emit(InsurancePurchaseProcessing(
            step: InsuranceProcessingStep.uploadingDocuments,
            product: product,
            quote: quote,
            progress: 0.35,
          ));
        }
        await _uploadPendingFiles();
      }

      // Emit holding funds/processing payment step
      if (!isClosed) {
        emit(InsurancePurchaseProcessing(
          step: InsuranceProcessingStep.holdingFunds,
          product: product,
          quote: quote,
          progress: 0.5,
        ));
      }

      final result = await _repository.purchaseInsurance(
        quoteId: quote.quoteId,
        productId: product.id,
        accountId: accountId,
        transactionPin: transactionPin,
        idempotencyKey: idempotencyKey,
        formData: _formData,
        locale: _locale,
        transactionId: transactionId,
      );

      if (isClosed) return;

      // Clear idempotency key after successful purchase
      _lastIdempotencyKey = null;

      // Emit completing step just before success
      emit(InsurancePurchaseProcessing(
        step: InsuranceProcessingStep.purchasingPolicy,
        product: product,
        quote: quote,
        progress: 0.9,
      ));

      emit(InsurancePurchaseSuccess(
        purchaseResult: result,
        product: product,
        quote: quote,
      ));

      // Invalidate product cache since user now has a policy
      _cacheManager.invalidatePattern('insurance_products_');
    } on GrpcError catch (e) {
      if (isClosed) return;
      // Financial operations should NOT be queued offline due to security risks
      // (stale balances, expired tokens, quote expiry, regulatory concerns).
      // Instead, show error and let user retry. Idempotency key prevents double-charging.
      if (_isNetworkError(e)) {
        emit(const CreatePolicyError(
          message: 'Network error. Please check your connection and try again.',
        ));
        _restoreQuoteState();
      } else {
        emit(CreatePolicyError(
          message: _friendlyPurchaseError(e),
          errorCode: e.code.toString(),
        ));
        _restoreQuoteState();
      }
    } catch (e) {
      if (isClosed) return;
      if (_isNetworkError(e)) {
        emit(const CreatePolicyError(
          message: 'Network error. Please check your connection and try again.',
        ));
        _restoreQuoteState();
      } else {
        final msg = e.toString().toLowerCase();
        if (msg.contains('insufficient') || msg.contains('balance')) {
          emit(const CreatePolicyError(message: 'Insufficient balance. Please fund your account and try again.'));
        } else if (msg.contains('pin') && (msg.contains('expired') || msg.contains('token'))) {
          // Auth-service stamps PIN-verification tokens with a 10-minute
          // TTL (DefaultPinConfig.TokenExpiry). If the user pauses on
          // the confirm screen past that, MyCover purchase fails with a
          // bare "invalid token" — surface a clearer recovery hint.
          emit(const CreatePolicyError(message: 'Your PIN session expired. Please re-enter your transaction PIN.'));
        } else if (msg.contains('pin') || msg.contains('permission')) {
          emit(const CreatePolicyError(message: 'Invalid transaction PIN. Please try again.'));
        } else if (msg.contains('quote') && (msg.contains('expired') || msg.contains('not found'))) {
          emit(const CreatePolicyError(message: 'Quote has expired. Please get a new quote and try again.'));
        } else {
          emit(const CreatePolicyError(message: 'Purchase failed. Please try again.'));
        }
        _restoreQuoteState();
      }
    } finally {
      _isPurchasing = false;
    }
  }

  /// Re-emit InsuranceQuoteLoaded after a purchase error so the confirm screen
  /// doesn't show "Quote not loaded". The user can retry from the same screen.
  void _restoreQuoteState() {
    if (_quote != null && _selectedProduct != null && !isClosed) {
      emit(InsuranceQuoteLoaded(
        quote: _quote!,
        product: _selectedProduct!,
        formData: _formData,
      ));
    }
  }

  /// Generate idempotency key from purchase parameters
  String _generateIdempotencyKey(String quoteId, String productId, double premium) {
    final now = DateTime.now();
    final minuteTruncated = DateTime(now.year, now.month, now.day, now.hour, now.minute);
    final input = '$quoteId:$productId:$premium:${minuteTruncated.toIso8601String()}';
    return sha256.convert(utf8.encode(input)).toString();
  }

  /// Check purchase status by reference
  Future<void> checkPurchaseStatus(String reference) async {
    if (isClosed) return;

    try {
      final result = await _repository.getInsurancePurchaseStatus(reference: reference);
      if (isClosed) return;

      if (result.isCompleted && _selectedProduct != null && _quote != null) {
        emit(InsurancePurchaseSuccess(
          purchaseResult: result,
          product: _selectedProduct!,
          quote: _quote!,
        ));
      }
    } catch (e) {
      developer.log('checkPurchaseStatus failed for reference=$reference: $e',
          name: 'CreatePolicyCubit');
    }
  }

  // ============================================================
  // Legacy Manual Form Methods (preserved for backward compat)
  // ============================================================

  void updateInsuranceType(InsuranceType type) {
    _insuranceType = type;
    _emitFormUpdated();
  }

  void updateProvider(String provider) {
    _provider = provider;
    _emitFormUpdated();
  }

  void updatePolicyHolderName(String name) {
    _policyHolderName = name;
    _emitFormUpdated();
  }

  void updatePolicyHolderEmail(String email) {
    _policyHolderEmail = email;
    _emitFormUpdated();
  }

  void updatePolicyHolderPhone(String phone) {
    _policyHolderPhone = phone;
    _emitFormUpdated();
  }

  void updatePremiumAmount(double? amount) {
    _premiumAmount = amount;
    _emitFormUpdated();
  }

  void updateCoverageAmount(double? amount) {
    _coverageAmount = amount;
    _emitFormUpdated();
  }

  void updateCurrency(String currency) {
    _currency = currency;
    _emitFormUpdated();
  }

  void updateStartDate(DateTime date) {
    _startDate = date;
    _emitFormUpdated();
  }

  void updateEndDate(DateTime date) {
    _endDate = date;
    _emitFormUpdated();
  }

  void updateNextPaymentDate(DateTime date) {
    _nextPaymentDate = date;
    _emitFormUpdated();
  }

  void addBeneficiary(String beneficiary) {
    if (beneficiary.isNotEmpty && !_beneficiaries.contains(beneficiary)) {
      _beneficiaries = [..._beneficiaries, beneficiary];
      _emitFormUpdated();
    }
  }

  void removeBeneficiary(String beneficiary) {
    _beneficiaries = _beneficiaries.where((b) => b != beneficiary).toList();
    _emitFormUpdated();
  }

  void updateBeneficiaries(List<String> beneficiaries) {
    _beneficiaries = List.from(beneficiaries);
    _emitFormUpdated();
  }

  void addFeature(String feature) {
    if (feature.isNotEmpty && !_features.contains(feature)) {
      _features = [..._features, feature];
      _emitFormUpdated();
    }
  }

  void removeFeature(String feature) {
    _features = _features.where((f) => f != feature).toList();
    _emitFormUpdated();
  }

  void updateFeatures(List<String> features) {
    _features = List.from(features);
    _emitFormUpdated();
  }

  void updateOptionalField(String key, dynamic value) {
    _optionalFields = {..._optionalFields, key: value};
    _emitFormUpdated();
  }

  void removeOptionalField(String key) {
    final newFields = Map<String, dynamic>.from(_optionalFields);
    newFields.remove(key);
    _optionalFields = newFields;
    _emitFormUpdated();
  }

  bool validateScreen1() {
    final errors = <String, String>{};
    if (_provider.isEmpty) {
      errors['provider'] = 'Please select an insurance provider';
    }
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please complete all required fields',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen2() {
    final errors = <String, String>{};
    final nameError = FormFieldValidators.validateName(_policyHolderName);
    if (nameError != null) errors['name'] = nameError;
    final emailError = FormFieldValidators.validateEmail(_policyHolderEmail);
    if (emailError != null) errors['email'] = emailError;
    final phoneError = FormFieldValidators.validatePhone(_policyHolderPhone);
    if (phoneError != null) errors['phone'] = phoneError;
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen3() {
    final errors = <String, String>{};
    final premiumError = FormFieldValidators.validateAmount(
      _premiumAmount?.toString(),
      fieldName: 'Premium amount',
      minValue: 0.01,
      maxValue: 1000000000,
    );
    if (premiumError != null) errors['premium'] = premiumError;
    final coverageError = FormFieldValidators.validateCoverageAmount(
      _coverageAmount?.toString(),
      _premiumAmount?.toString(),
    );
    if (coverageError != null) errors['coverage'] = coverageError;
    final dateRangeError = FormFieldValidators.validateDateRange(
      _startDate, _endDate, minDurationDays: 30,
    );
    if (dateRangeError != null) errors['dateRange'] = dateRangeError;
    final startDateError = FormFieldValidators.validateDateBounds(
      _startDate, fieldName: 'Start date', maxYearsInPast: 1, maxYearsInFuture: 10,
    );
    if (startDateError != null) errors['startDate'] = startDateError;
    final paymentDateError = FormFieldValidators.validatePaymentDate(
      _nextPaymentDate, _startDate, _endDate,
    );
    if (paymentDateError != null) errors['paymentDate'] = paymentDateError;
    if (errors.isNotEmpty) {
      if (isClosed) return false;
      emit(CreatePolicyValidationError(
        message: 'Please fix the errors in the form',
        fieldErrors: errors,
      ));
      return false;
    }
    return true;
  }

  bool validateScreen4() => true;

  bool validateScreen5() {
    return validateScreen1() && validateScreen2() && validateScreen3() && validateScreen4();
  }

  Insurance buildInsurance(String userId) {
    final policyNumber = _generatePolicyNumber();
    final coverageDetails = <String, dynamic>{
      'features': _features,
      ..._optionalFields,
    };
    return Insurance(
      id: '',
      policyNumber: policyNumber,
      policyHolderName: _policyHolderName,
      policyHolderEmail: _policyHolderEmail,
      policyHolderPhone: _policyHolderPhone,
      type: _insuranceType,
      provider: _provider,
      providerLogo: '',
      premiumAmount: _premiumAmount ?? 0,
      coverageAmount: _coverageAmount ?? 0,
      currency: _currency,
      startDate: _startDate,
      endDate: _endDate,
      nextPaymentDate: _nextPaymentDate,
      status: InsuranceStatus.pending,
      beneficiaries: _beneficiaries,
      coverageDetails: coverageDetails,
      description: _optionalFields['description'] as String?,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      userId: userId,
    );
  }

  String _generatePolicyNumber() {
    final random = Random();
    final randomNum = random.nextInt(9999);
    final date = DateTime.now();
    final dateStr =
        '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}';
    return 'INS-$dateStr-${randomNum.toString().padLeft(4, '0')}';
  }

  /// Reset form to initial state
  void reset() {
    _insuranceType = InsuranceType.health;
    _provider = '';
    _policyHolderName = '';
    _policyHolderEmail = '';
    _policyHolderPhone = '';
    _premiumAmount = null;
    _coverageAmount = null;
    _currency = 'USD';
    _startDate = DateTime.now();
    _endDate = DateTime.now().add(const Duration(days: 365));
    _nextPaymentDate = DateTime.now().add(const Duration(days: 30));
    _beneficiaries = [];
    _features = [];
    _optionalFields = {};
    _isAutoFilled = false;

    // Reset marketplace state
    _selectedCategory = null;
    _selectedCategoryInfo = null;
    _products = [];
    _selectedProduct = null;
    _formData = {};
    _quote = null;
    _selectedAccountId = null;
    _agreedToTerms = false;

    if (isClosed) return;
    emit(const CreatePolicyInitial());
  }

  void _emitFormUpdated() {
    if (isClosed) return;
    emit(CreatePolicyFormUpdated(
      insuranceType: _insuranceType,
      provider: _provider,
      policyHolderName: _policyHolderName,
      policyHolderEmail: _policyHolderEmail,
      policyHolderPhone: _policyHolderPhone,
      premiumAmount: _premiumAmount,
      coverageAmount: _coverageAmount,
      currency: _currency,
      startDate: _startDate,
      endDate: _endDate,
      nextPaymentDate: _nextPaymentDate,
      beneficiaries: _beneficiaries,
      features: _features,
      optionalFields: _optionalFields,
      isAutoFilled: _isAutoFilled,
    ));
  }

  /// Stage a file the user picked for an upload field. The bytes stay
  /// in memory until purchase tap — no network call here, so the form
  /// step feels instant and we don't burn MyCover upload quota on
  /// re-pickers or back-button flows.
  ///
  /// Stages a file and pre-constructs its public URL via the backend
  /// (`GetInsuranceDocumentUploadURL`). The deterministic public URL
  /// is stamped into form_data IMMEDIATELY so MyCover sees a real URL
  /// at submit time, and the actual PUT to the upload URL runs in the
  /// background. By the time MyCover's downstream insurer fetches the
  /// URL, the bytes have landed.
  ///
  /// While the URL pair is being fetched (round-trip < 1s typically)
  /// the marker sits in form_data so validation passes. The marker is
  /// overwritten with the real URL once the resolver returns.
  ///
  /// Errors at resolver-time bubble up via state; the background PUT
  /// keeps a Future on the pending entry that the purchase saga awaits
  /// in `_uploadPendingFiles` — that guarantees we never submit before
  /// the bytes are at the URL.
  Future<void> stagePendingFile({
    required String fieldName,
    required List<int> bytes,
    required String filename,
    required String contentType,
  }) async {
    if (isClosed) return;
    // Initial entry with marker — keeps validation green while we
    // resolve the URL pair.
    _pendingUploads[fieldName] = _PendingFileUpload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
    );
    _formData[fieldName] = _kPendingUploadMarker;
    if (_selectedProduct != null) {
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: Map<String, String>.from(_formData),
      ));
    }

    // Resolve the URL pair, then start the background PUT.
    try {
      final urls = await _repository.getInsuranceDocumentUploadURL(
        filename: filename,
        contentType: contentType,
        documentType: _documentTypeForField(fieldName),
      );
      if (isClosed || !_pendingUploads.containsKey(fieldName)) {
        // User dropped the file (or the cubit closed) before the
        // resolver returned. Skip.
        return;
      }
      // Stamp the deterministic public URL into form_data so the
      // purchase request carries a real URL even if the user fires
      // Continue while the PUT is still in flight.
      _formData[fieldName] = urls.publicUrl;
      final updated = _pendingUploads[fieldName]!.withResolvedURL(urls);
      _pendingUploads[fieldName] = updated;
      if (_selectedProduct != null && !isClosed) {
        emit(InsuranceProductSelected(
          product: _selectedProduct!,
          formData: Map<String, String>.from(_formData),
        ));
      }
      // Kick off the actual upload. Stored on the pending entry so the
      // saga can await it.
      updated.startBackgroundPut(_repository);
    } catch (e) {
      // Surface the error inside the form, but keep the marker in
      // place so the user can retry by tapping the field again. We
      // intentionally don't clear `_pendingUploads` — the form
      // preview stays so the user doesn't lose their selection.
      if (_selectedProduct != null && !isClosed) {
        emit(InsuranceProductSelected(
          product: _selectedProduct!,
          formData: Map<String, String>.from(_formData),
          formErrors: {fieldName: "Couldn't prepare upload — tap to retry"},
        ));
      }
    }
  }

  /// Stages a per-item image upload (e.g. `item_details[i].image_url`
  /// in Marine Cover) and returns the deterministic public URL the
  /// caller writes into the array item's `image_url` slot.
  ///
  /// Same lifecycle as [stagePendingFile] — fetches the URL pair from
  /// the backend, kicks off the background PUT, tracks the in-flight
  /// future so the purchase saga's `_uploadPendingFiles` step awaits
  /// it before submitting to MyCover. Uses a synthetic key (`__item_image:<storage_key>`)
  /// to register the pending upload without colliding with top-level
  /// form fields; the saga special-cases these so it doesn't write
  /// the public URL into form_data (the array item already has it).
  ///
  /// Throws on resolver-time errors; the caller surfaces those in-line.
  Future<String> stageArrayItemImage({
    required List<int> bytes,
    required String filename,
    required String contentType,
  }) async {
    final urls = await _repository.getInsuranceDocumentUploadURL(
      filename: filename,
      contentType: contentType,
      documentType: 'item_image',
    );
    final p = _PendingFileUpload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      resolvedUrls: urls,
    );
    p.startBackgroundPut(_repository);
    _pendingUploads['__item_image:${urls.storageKey}'] = p;
    return urls.publicUrl;
  }

  /// Drop a staged file before purchase (e.g. user tapped "Remove").
  void clearPendingFile(String fieldName) {
    if (isClosed) return;
    _pendingUploads.remove(fieldName);
    if (_formData[fieldName] == _kPendingUploadMarker) {
      _formData.remove(fieldName);
    }
    if (_selectedProduct != null) {
      emit(InsuranceProductSelected(
        product: _selectedProduct!,
        formData: Map<String, String>.from(_formData),
      ));
    }
  }

  /// Drain `_pendingUploads`: await each background PUT that
  /// `stagePendingFile` kicked off, so MyCover never fetches a public
  /// URL whose bytes haven't landed yet. The public URLs are already
  /// in `_formData` (stamped at stage time) — we just wait for the
  /// in-flight PUTs to finish.
  ///
  /// If a pending entry has no resolved URL yet (the resolver
  /// round-trip is still in flight, or it failed), or has no
  /// in-flight PUT (which means stage was called but resolver hadn't
  /// returned), we fall back to the legacy synchronous-upload path
  /// using the existing `uploadInsuranceDocument` RPC. That keeps the
  /// saga robust against transient backend errors during stage.
  Future<void> _uploadPendingFiles() async {
    if (_pendingUploads.isEmpty) return;
    final entries = List<MapEntry<String, _PendingFileUpload>>.from(
        _pendingUploads.entries);
    final futures = entries.map((entry) async {
      final fieldName = entry.key;
      final p = entry.value;

      // Happy path — URL was pre-constructed at stage time. Await
      // the background PUT (started in stagePendingFile) and we're
      // done. Public URL is already in _formData.
      final inflight = p.inflightPut;
      if (inflight != null) {
        await inflight;
        return MapEntry(fieldName, _formData[fieldName] ?? '');
      }

      // Fallback — resolver-time error left the marker in place. Hit
      // the legacy direct-upload RPC and use whatever URL it returns.
      final url = await _repository.uploadInsuranceDocument(
        fileData: p.bytes,
        filename: p.filename,
        documentType: _documentTypeForField(fieldName),
      );
      return MapEntry(fieldName, url);
    });
    final results = await Future.wait(futures);
    for (final r in results) {
      // Synthetic per-item-image keys are bookkeeping only — the
      // array item already carries the public URL (stamped at stage
      // time). Just drain the pending map without rewriting form data.
      if (!r.key.startsWith('__item_image:')) {
        _formData[r.key] = r.value;
      }
      _pendingUploads.remove(r.key);
    }
  }

  static String _documentTypeForField(String fieldName) {
    final n = fieldName.toLowerCase();
    if (n.contains('id') || n.contains('identification')) return 'id_document';
    if (n.contains('proof')) return 'proof_of_purchase';
    if (n.contains('claim')) return 'claim_evidence';
    return 'device_photo';
  }
}

/// Marker stored in `_formData` for fields whose upload hasn't run yet.
/// The form widget detects this marker to show the preview thumbnail
/// instead of treating the field as "no value". Stripped (replaced
/// with the real URL) inside `_uploadPendingFiles` before the purchase
/// payload is sent to MyCover.
const String _kPendingUploadMarker = '__pending_upload__';

/// Holds the bytes + metadata for a file the user has selected but not
/// yet uploaded. Lives on the cubit only — flushed when the purchase
/// saga starts. Never persisted.
///
/// `resolvedUrls` and `inflightPut` are populated once
/// `stagePendingFile` has called the backend's
/// GetInsuranceDocumentUploadURL RPC and kicked off the background
/// PUT. Both are null while the resolver is in flight (the field's
/// form_data value is `__pending_upload__` during that window).
class _PendingFileUpload {
  final List<int> bytes;
  final String filename;
  final String contentType;
  InsuranceDocumentUploadURL? resolvedUrls;
  // Future tracking the in-flight PUT to the upload URL. Stays null
  // until startBackgroundPut() is called by the cubit once the URL
  // resolver returns. The purchase saga awaits this so MyCover never
  // fetches the public URL before the PUT lands.
  Future<void>? inflightPut;

  _PendingFileUpload({
    required this.bytes,
    required this.filename,
    required this.contentType,
    this.resolvedUrls,
    this.inflightPut,
  });

  /// Best-effort sniff of file kind for the preview UI. Anything starting
  /// with `image/` renders as an Image.memory; otherwise we show a
  /// document icon + filename.
  bool get isImage => contentType.startsWith('image/');

  /// Returns a copy with the resolved URL pair attached. The caller
  /// then calls `startBackgroundPut` to begin the actual upload.
  _PendingFileUpload withResolvedURL(InsuranceDocumentUploadURL urls) {
    return _PendingFileUpload(
      bytes: bytes,
      filename: filename,
      contentType: contentType,
      resolvedUrls: urls,
      inflightPut: inflightPut,
    );
  }

  /// Begins the actual PUT to the upload URL. Idempotent — calling
  /// twice keeps the first in-flight future.
  void startBackgroundPut(InsuranceRepository repository) {
    final urls = resolvedUrls;
    if (urls == null || inflightPut != null) return;
    inflightPut = _putBytes(urls.uploadUrl, bytes, contentType);
  }
}

Future<void> _putBytes(
  String uploadUrl,
  List<int> bytes,
  String contentType,
) async {
  // Plain HTTP PUT — works for both the GCS V4-signed URL and the
  // dev /assets/insurance route. We use `package:http` so the call
  // goes through the same client as the rest of the app.
  final resp = await http.put(
    Uri.parse(uploadUrl),
    headers: {'Content-Type': contentType},
    body: bytes,
  );
  if (resp.statusCode < 200 || resp.statusCode >= 300) {
    throw Exception('upload PUT failed: HTTP ${resp.statusCode}');
  }
}

/// Public read-only view of a staged file. Returned by
/// [CreatePolicyCubit.stagedFile] so the form widget can render the
/// preview thumbnail + full-screen viewer without touching the
/// private `_PendingFileUpload` class.
class StagedInsuranceFile {
  final List<int> bytes;
  final String filename;
  final String contentType;
  final bool isImage;

  const StagedInsuranceFile._({
    required this.bytes,
    required this.filename,
    required this.contentType,
    required this.isImage,
  });
}
