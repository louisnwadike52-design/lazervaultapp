import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../cubit/create_invoice_cubit.dart';
import '../cubit/create_invoice_state.dart';
import '../cubit/invoice_cubit.dart';
import '../cubit/invoice_state.dart';
import '../../../authentication/cubit/authentication_cubit.dart';
import '../../../authentication/cubit/authentication_state.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_cubit.dart';
import '../../../account_cards_summary/cubit/account_cards_summary_state.dart';
import '../../domain/entities/invoice_entity.dart';
import 'package:lazervault/core/utils/logger.dart';
import '../widgets/create_invoice/invoice_type_basic_info_screen.dart';
import '../widgets/create_invoice/recipient_details_screen.dart';
import '../widgets/create_invoice/payer_details_screen.dart';
import '../widgets/create_invoice/items_amounts_screen.dart';
import '../widgets/create_invoice/invoice_review_screen.dart';
import '../../../../../core/theme/invoice_theme_colors.dart';
import '../../../../../core/types/app_routes.dart';
import '../../../../../core/services/endpoint_registry.dart';
import '../../data/services/invoice_image_upload_service.dart';
import 'package:get_it/get_it.dart';
import '../notifiers/invoice_refresh_notifier.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'create_invoice_carousel_widgets.dart';

/// Main carousel controller for invoice creation
///
/// Manages a progressive 3-screen flow:
/// Screen 1: Type & Basic Info (required) + optional Recipient/Payer via chips
/// Screen 2: Items & Amounts (required) + optional Tax/Discount/Notes via chips
/// Screen 3: Review & Confirm
class CreateInvoiceCarousel extends StatefulWidget {
  final String? serviceFeeRef;

  /// When set, the carousel EDITS this invoice instead of creating a new one:
  /// the form is hydrated from it and saving calls updateInvoice.
  final Invoice? editInvoice;

  const CreateInvoiceCarousel(
      {super.key, this.serviceFeeRef, this.editInvoice});

  @override
  State<CreateInvoiceCarousel> createState() => _CreateInvoiceCarouselState();
}

class _CreateInvoiceCarouselState extends State<CreateInvoiceCarousel> {
  late PageController _pageController;
  int _currentPage = 0;
  final int _totalPages = 5;

  final List<String> _pageNames = [
    'Basic Info',
    'From (You)',
    'Bill To',
    'Items & Amounts',
    'Review & Confirm',
  ];

  // Track which optional sections are visible
  final Set<String> _visibleOptionalFields = {};
  bool _showFieldChipsRecipient = false;
  bool _showFieldChipsPayer = false;
  bool _showFieldChipsItems = false;
  bool _isCreating = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    // Initialize form with user data and set user ID on InvoiceCubit
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authState = context.read<AuthenticationCubit>().state;
      if (authState is AuthenticationSuccess) {
        context.read<InvoiceCubit>().setUserId(authState.profile.user.id);
        final createCubit = context.read<CreateInvoiceCubit>();
        createCubit.initializeWithUserData(authState.profile.user);
        // Hydrate AFTER the user defaults, so the invoice's own values win.
        // Doing it the other way round would let the issuer defaults overwrite
        // what is actually on the invoice being edited.
        if (widget.editInvoice != null) {
          createCubit.loadForEdit(widget.editInvoice!);
        }
      }

      // Initialize invoice currency from active account if not already set
      final createCubit = context.read<CreateInvoiceCubit>();
      if (createCubit.invoiceCurrency.isEmpty) {
        try {
          final acctState = context.read<AccountCardsSummaryCubit>().state;
          if (acctState is AccountCardsSummaryLoaded &&
              acctState.accountSummaries.isNotEmpty) {
            final acctCurrency = acctState.accountSummaries.first.currency;
            createCubit.updateInvoiceCurrency(acctCurrency);
            // Derive country from currency
            const currencyToCountry = {
              'NGN': 'NG',
              'USD': 'US',
              'GBP': 'GB',
              'CAD': 'CA',
              'INR': 'IN',
              'EUR': 'DE',
              'ZAR': 'ZA',
              'AUD': 'AU',
              'JPY': 'JP',
            };
            final country = currencyToCountry[acctCurrency];
            if (country != null) {
              createCubit.updateInvoiceCountry(country);
            }
          }
        } catch (_) {}
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    final cubit = context.read<CreateInvoiceCubit>();

    // Validate current page
    bool isValid = false;
    switch (_currentPage) {
      case 0:
        isValid = cubit.validateScreen1(); // Basic info
        break;
      case 1:
        isValid = cubit.validateScreen2(required: true); // Recipient
        break;
      case 2:
        isValid = cubit.validateScreen3(required: true); // Payer
        break;
      case 3:
        isValid = cubit.validateScreen4(); // Items
        break;
      case 4:
        isValid = cubit.validateScreen5(); // Review
        break;
    }

    if (!isValid) {
      if (cubit.state is CreateInvoiceValidationError) {
        final errorState = cubit.state as CreateInvoiceValidationError;
        _showErrorSnackBar(errorState.message);
      }
      return;
    }

    if (_currentPage < _totalPages - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Last page - create invoice
      _createInvoice();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _createInvoice() async {
    if (_isCreating) return;
    setState(() => _isCreating = true);

    final authState = context.read<AuthenticationCubit>().state;
    if (authState is! AuthenticationSuccess) {
      _showErrorSnackBar('Authentication required');
      setState(() => _isCreating = false);
      return;
    }

    try {
      final cubit = context.read<CreateInvoiceCubit>();

      // Validate the split before submitting: at least one payer and (custom
      // mode) amounts that sum to the invoice total.
      if (cubit.splitMode && !cubit.splitIsValid) {
        _showErrorSnackBar(cubit.splitPayers.isEmpty
            ? 'Add at least one person to split with.'
            : 'Split amounts must add up to the invoice total.');
        setState(() => _isCreating = false);
        return;
      }

      // Upload the customer (payer) and issuer (recipient) logos via the
      // canonical storage-service pipeline (core-gateway presigned PUT, same as
      // profile pictures). Each returns a public_url we persist on the invoice
      // and render later with Image.network. Non-fatal: a failed logo upload
      // never blocks invoice creation.
      String? payerLogoUrl;
      String? recipientLogoUrl;
      final uploader = InvoiceImageUploadService(endpoints: endpointRegistry);

      // Failures here used to be swallowed whole. The invoice was created with
      // no logo and the user was told nothing, so the only symptom was a logo
      // that had "definitely been uploaded" never appearing on the preview or
      // the PDF, with nothing anywhere to say why. Still non-fatal, because a
      // logo is not worth losing a completed invoice over, but no longer
      // silent: the user is told, and the reason reaches the logs.
      final failedLogos = <String>[];

      Future<String?> uploadLogo(File? file, String label) async {
        if (file == null) return null;
        try {
          if (!await file.exists()) {
            failedLogos.add(label);
            AppLogger.warning(
                'invoice: $label logo file missing at ${file.path}');
            return null;
          }
          return (await uploader.uploadFromFile(file)).publicUrl;
        } catch (e) {
          failedLogos.add(label);
          AppLogger.error('invoice: $label logo upload failed', error: e);
          return null;
        }
      }

      // A File is a NEW pick that needs uploading; a URL is a logo already on
      // the invoice. Falling back to the stored URL is what stops an edit that
      // never touched the logos from clearing them.
      payerLogoUrl = await uploadLogo(cubit.payerImage, 'customer') ??
          (cubit.payerLogoUrl.isNotEmpty ? cubit.payerLogoUrl : null);
      recipientLogoUrl = await uploadLogo(cubit.recipientImage, 'business') ??
          (cubit.recipientLogoUrl.isNotEmpty ? cubit.recipientLogoUrl : null);

      if (failedLogos.isNotEmpty && mounted) {
        _showErrorSnackBar(
          failedLogos.length == 1
              ? 'We could not upload the ${failedLogos.first} logo, so the invoice was saved without it.'
              : 'We could not upload the logos, so the invoice was saved without them.',
        );
      }

      // The logo uploads above are awaited, so this State can be gone by now.
      // Just leave: setState on an unmounted State throws, and there is no
      // spinner left to clear.
      if (!mounted) return;
      final invoiceCubit = context.read<InvoiceCubit>();

      // EDIT: same form, different verb. buildEditedInvoice keeps the id and
      // status that buildInvoice would blank out, so the update addresses the
      // invoice actually being edited.
      if (cubit.isEditing) {
        final edited =
            cubit.buildEditedInvoice(authState.profile.user.id).copyWith(
                  payerLogoUrl: payerLogoUrl,
                  recipientLogoUrl: recipientLogoUrl,
                );
        await _saveEdit(invoiceCubit, edited);
        return;
      }

      var invoice = cubit.buildInvoice(authState.profile.user.id);
      invoice = invoice.copyWith(
        payerLogoUrl: payerLogoUrl,
        recipientLogoUrl: recipientLogoUrl,
      );

      // Listen for the state change via a stream subscription so we don't
      // miss it due to subsequent state emissions (e.g. loadInvoices).
      final stateCompleter = Completer<InvoiceState>();
      late final StreamSubscription<InvoiceState> sub;
      sub = invoiceCubit.stream
          .where((s) =>
              s is InvoiceOperationSuccess ||
              s is InvoiceError ||
              s is InvoiceCreationQueued)
          .listen((s) {
        if (!stateCompleter.isCompleted) {
          stateCompleter.complete(s);
        }
        sub.cancel();
      });

      // Cancel subscription if widget unmounts before completion
      if (!mounted) {
        sub.cancel();
        return;
      }

      invoiceCubit.createInvoice(
        title: invoice.title,
        description: invoice.description,
        items: invoice.items,
        type: invoice.type,
        toEmail: cubit.splitMode
            ? null
            : invoice.payerDetails?.email ?? invoice.recipientDetails?.email,
        toName: cubit.splitMode
            ? _splitPayerNames(cubit.splitPayers)
            : invoice.payerDetails?.contactName ??
                invoice.recipientDetails?.contactName,
        dueDate: invoice.dueDate,
        taxAmount: invoice.taxAmount,
        discountAmount: invoice.discountAmount,
        notes: invoice.notes,
        sendImmediately: false,
        recipientDetails: invoice.recipientDetails != null
            ? AddressDetails(
                companyName: invoice.recipientDetails!.companyName,
                contactName: invoice.recipientDetails!.contactName,
                email: invoice.recipientDetails!.email,
                phone: invoice.recipientDetails!.phone,
                addressLine1: invoice.recipientDetails!.addressLine1,
                addressLine2: invoice.recipientDetails!.addressLine2,
                city: invoice.recipientDetails!.city,
                state: invoice.recipientDetails!.state,
                postcode: invoice.recipientDetails!.postcode,
                country: invoice.recipientDetails!.country,
              )
            : null,
        payerDetails: (cubit.splitMode || invoice.payerDetails == null)
            ? null
            : AddressDetails(
                companyName: invoice.payerDetails!.companyName,
                contactName: invoice.payerDetails!.contactName,
                email: invoice.payerDetails!.email,
                phone: invoice.payerDetails!.phone,
                addressLine1: invoice.payerDetails!.addressLine1,
                addressLine2: invoice.payerDetails!.addressLine2,
                city: invoice.payerDetails!.city,
                state: invoice.payerDetails!.state,
                postcode: invoice.payerDetails!.postcode,
                country: invoice.payerDetails!.country,
              ),
        currency: invoice.currency,
        payerLogoUrl: invoice.payerLogoUrl,
        recipientLogoUrl: invoice.recipientLogoUrl,
        serviceFeeRef: widget.serviceFeeRef,
        // Split payment: the tagged app users + whether amounts are custom.
        splitPayers: cubit.splitMode ? cubit.splitPayers : const [],
        customSplit: cubit.splitMode && cubit.splitCustom,
      );

      final resultState = await stateCompleter.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          sub.cancel();
          return const InvoiceError(message: 'Invoice creation timed out');
        },
      );

      if (!mounted) {
        sub.cancel();
        return;
      }

      if (resultState is InvoiceCreationQueued) {
        _showErrorSnackBar(resultState.message);
        if (mounted) setState(() => _isCreating = false);
        return;
      }

      if (resultState is! InvoiceOperationSuccess ||
          resultState.invoice == null) {
        final errorMsg = resultState is InvoiceError
            ? resultState.message
            : 'Failed to create invoice';
        _showErrorSnackBar(errorMsg);
        if (mounted) setState(() => _isCreating = false);
        return;
      }

      // Merge form address details into created invoice since backend
      // doesn't return full address details in the response.
      final createdInvoice = resultState.invoice!.copyWith(
        recipientDetails: invoice.recipientDetails,
        payerDetails: invoice.payerDetails,
        payerLogoUrl: resultState.invoice!.payerLogoUrl ?? invoice.payerLogoUrl,
        recipientLogoUrl:
            resultState.invoice!.recipientLogoUrl ?? invoice.recipientLogoUrl,
      );

      cubit.reset();

      // Notify the shared notifier so the home screen reloads on return
      GetIt.I<InvoiceRefreshNotifier>().notifyRefresh();

      // Navigate to payment screen for service fee unlock, then processing, then preview
      Get.offNamed(
        AppRoutes.invoicePayment,
        arguments: {
          'invoice': createdInvoice,
          'isPrePayment': true,
        },
      );
    } catch (e) {
      _showErrorSnackBar('Failed to create invoice: ${e.toString()}');
      if (mounted) setState(() => _isCreating = false);
    }
  }

  /// Saves an edited invoice and returns to the list.
  ///
  /// Mirrors the create path's completer pattern: InvoiceCubit emits through a
  /// stream and loadInvoices() fires straight after, so awaiting the cubit
  /// state directly would race with the refresh and miss the result.
  Future<void> _saveEdit(InvoiceCubit invoiceCubit, Invoice edited) async {
    final completer = Completer<InvoiceState>();
    late final StreamSubscription<InvoiceState> sub;
    sub = invoiceCubit.stream
        .where((s) => s is InvoiceOperationSuccess || s is InvoiceError)
        .listen((s) {
      if (!completer.isCompleted) completer.complete(s);
      sub.cancel();
    });

    if (!mounted) {
      sub.cancel();
      return;
    }

    invoiceCubit.updateInvoice(edited);

    final result = await completer.future.timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        sub.cancel();
        return const InvoiceError(message: 'Saving your changes timed out');
      },
    );

    if (!mounted) return;

    if (result is! InvoiceOperationSuccess) {
      _showErrorSnackBar(
        result is InvoiceError ? result.message : 'Could not save your changes',
      );
      setState(() => _isCreating = false);
      return;
    }

    setState(() => _isCreating = false);
    Get.back(result: true);
  }

  void _showErrorSnackBar(String message) {
    // MUST guard: _goToNextPage is async, so by the time a validation error
    // comes back this State can be deactivated — and ScaffoldMessenger.of on a
    // deactivated context THROWS ("Looking up a deactivated widget's ancestor
    // is unsafe").
    //
    // The failure mode was invisible and awful: validation would correctly
    // reject the form, the app would try to say why, the snackbar would throw,
    // the zone swallowed it, and the user was left tapping a Continue button
    // that did nothing and explained nothing.
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
        margin: EdgeInsets.all(16.w),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          _buildProgressIndicators(),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (page) {
                setState(() => _currentPage = page);
              },
              children: [
                _buildBasicInfoScreen(),
                _buildRecipientScreen(),
                _buildPayerScreen(),
                _buildItemsScreen(),
                const InvoiceReviewScreen(),
              ],
            ),
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  /// Screen 1: Basic Info only
  Widget _buildBasicInfoScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const InvoiceTypeBasicInfoScreen(),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  /// Screen 2: Recipient Details (you — the invoice creator, prefilled)
  Widget _buildRecipientScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          RecipientDetailsScreen(
            showPhone: _visibleOptionalFields.contains('recipientPhone'),
            showAddress: _visibleOptionalFields.contains('recipientAddress'),
          ),
          _buildAddMoreFieldsWidget(
            fields: [
              if (!_visibleOptionalFields.contains('recipientPhone'))
                _ChipField('recipientPhone', 'Phone', Icons.phone_outlined),
              if (!_visibleOptionalFields.contains('recipientAddress'))
                _ChipField(
                    'recipientAddress', 'Address', Icons.location_on_outlined),
            ],
            showChips: _showFieldChipsRecipient,
            onToggle: () => setState(
                () => _showFieldChipsRecipient = !_showFieldChipsRecipient),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  /// Screen 3: Payer Details (the other person who will pay)
  Widget _buildPayerScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          PayerDetailsScreen(
            showPhone: _visibleOptionalFields.contains('payerPhone'),
            showAddress: _visibleOptionalFields.contains('payerAddress'),
          ),
          // When the invoice is split among tagged people there is no single
          // payer to hold a phone or address — those chips only repeated what
          // was already captured on the previous slide.
          _buildAddMoreFieldsWidget(
            fields: [
              if (!context.read<CreateInvoiceCubit>().splitMode) ...[
                if (!_visibleOptionalFields.contains('payerPhone'))
                  _ChipField('payerPhone', 'Phone', Icons.phone_outlined),
                if (!_visibleOptionalFields.contains('payerAddress'))
                  _ChipField(
                      'payerAddress', 'Address', Icons.location_on_outlined),
              ],
            ],
            showChips: _showFieldChipsPayer,
            onToggle: () =>
                setState(() => _showFieldChipsPayer = !_showFieldChipsPayer),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  /// Screen 4: Items + optional Tax/Discount/Notes sections
  Widget _buildItemsScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          ItemsAmountsScreen(
            showTax: _visibleOptionalFields.contains('tax'),
            showDiscount: _visibleOptionalFields.contains('discount'),
            showNotes: _visibleOptionalFields.contains('notes'),
          ),
          _buildAddMoreFieldsWidget(
            fields: [
              if (!_visibleOptionalFields.contains('tax'))
                _ChipField('tax', 'Tax', Icons.receipt_long_outlined),
              if (!_visibleOptionalFields.contains('discount'))
                _ChipField('discount', 'Discount', Icons.discount_outlined),
              if (!_visibleOptionalFields.contains('notes'))
                _ChipField('notes', 'Notes', Icons.note_alt_outlined),
            ],
            showChips: _showFieldChipsItems,
            onToggle: () =>
                setState(() => _showFieldChipsItems = !_showFieldChipsItems),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  Widget _buildAddMoreFieldsWidget({
    required List<_ChipField> fields,
    required bool showChips,
    required VoidCallback onToggle,
  }) {
    if (fields.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    showChips
                        ? Icons.remove_circle_outline
                        : Icons.add_circle_outline,
                    color: const Color(0xFF60A5FA),
                    size: 22.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    showChips ? 'Hide options' : 'Add more fields',
                    style: GoogleFonts.inter(
                      color: const Color(0xFF60A5FA),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: fields.map((field) {
                  return ActionChip(
                    avatar: Icon(field.icon,
                        size: 16.sp, color: const Color(0xFF60A5FA)),
                    label: Text(
                      field.label,
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    backgroundColor: const Color(0xFF1E293B),
                    side: BorderSide.none,
                    elevation: 4,
                    shadowColor: Colors.black.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    onPressed: () {
                      setState(() {
                        _visibleOptionalFields.add(field.key);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            crossFadeState: showChips
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: InvoiceThemeColors.primaryBackground,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 24.sp,
        ),
        onPressed: _goToPreviousPage,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'New Invoice',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            'Step ${_currentPage + 1} of $_totalPages - ${_pageNames[_currentPage]}',
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: () {
            // Close carousel and return to invoice home/landing page
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _buildProgressIndicators() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 4.h,
                width: (MediaQuery.of(context).size.width - 40.w) *
                    ((_currentPage + 1) / _totalPages),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _currentPage == _totalPages - 1
                        ? [Colors.green, Colors.green.shade700]
                        : [
                            const Color(0xFF3B82F6),
                            const Color.fromARGB(255, 78, 3, 208)
                          ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _totalPages,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: _currentPage == index ? 24.w : 8.w,
                height: 8.h,
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? const Color(0xFF3B82F6)
                      : Colors.white.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    final isLastPage = _currentPage == _totalPages - 1;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: InvoiceThemeColors.primaryBackground,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (_currentPage > 0)
              Expanded(
                child: GestureDetector(
                  onTap: _goToPreviousPage,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F1F1F),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Back',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (_currentPage > 0) SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: _goToNextPage,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (isLastPage && _isCreating) LazerVaultLoader.small(),
                        if (isLastPage && _isCreating) SizedBox(width: 8.w),
                        Text(
                          isLastPage
                              ? (_isCreating ? 'Creating...' : 'Create Invoice')
                              : 'Continue',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        if (!isLastPage) ...[
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders the split payers as a readable "Bill To" line.
///
/// This value is PERSISTED as the invoice's recipient name, so it is what every
/// downstream surface shows: the details screen, the preview, the shared PDF
/// and the receipt. It used to be the literal placeholder
/// "Split among N person", which told the recipient of a shared invoice
/// nothing about who it was actually shared with — and read as a bug on a
/// document people forward to each other.
///
/// Falls back to the count only when no payer has a usable name (an external
/// tag can be an email or phone with no profile attached), because an empty
/// "Bill To" is worse than an imprecise one.
String _splitPayerNames(List<TaggedUserInfo> payers) {
  final names = <String>[];
  for (final p in payers) {
    final full = '${p.firstName} ${p.lastName}'.trim();
    if (full.isNotEmpty) {
      names.add(full);
    } else if (p.username.isNotEmpty) {
      names.add('@${p.username}');
    } else if ((p.tagValue ?? '').isNotEmpty) {
      // External tag: the email/phone is the only identity we have.
      names.add(p.tagValue!);
    }
  }
  if (names.isEmpty) {
    final n = payers.length;
    return 'Split among $n ${n == 1 ? 'person' : 'people'}';
  }
  // Keep the line readable on a PDF: name every payer up to three, then
  // summarise the tail rather than wrapping across the box.
  if (names.length <= 3) return names.join(', ');
  final rest = names.length - 3;
  return '${names.take(3).join(', ')} +$rest more';
}
