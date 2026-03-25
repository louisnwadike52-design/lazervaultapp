import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';

/// Screen 1: Browse insurance categories and products from MyCover.ai
class InsuranceCategoryProductsScreen extends StatefulWidget {
  const InsuranceCategoryProductsScreen({super.key});

  @override
  State<InsuranceCategoryProductsScreen> createState() => _InsuranceCategoryProductsScreenState();
}

class _InsuranceCategoryProductsScreenState extends State<InsuranceCategoryProductsScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePolicyCubit, CreatePolicyState>(
      builder: (context, state) {
        if (state is CreatePolicyLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF6366F1)),
          );
        }

        if (state is CreatePolicyError) {
          return _buildErrorState(context, state.message);
        }

        final cubit = context.read<CreatePolicyCubit>();

        if (state is InsuranceCategoriesLoaded) {
          return _buildCategoriesOnly(context, state.categories, cubit);
        }

        if (state is InsuranceProductsLoading) {
          return _buildWithProducts(context, cubit, [], true,
              selectedCategory: state.category);
        }

        if (state is InsuranceProductsLoaded) {
          return _buildWithProducts(context, cubit, state.products, false,
              selectedCategory: state.selectedCategory);
        }

        // When a product is selected, keep showing the products list
        // (user still sees Screen 1 until they tap Continue)
        if (state is InsuranceProductSelected) {
          return _buildWithProducts(context, cubit, cubit.products, false,
              selectedCategory: cubit.selectedCategory);
        }

        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    final cubit = context.read<CreatePolicyCubit>();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.w, height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(32.r)),
              child: Icon(Icons.cloud_off_outlined, color: const Color(0xFFEF4444), size: 32.sp),
            ),
            SizedBox(height: 16.h),
            Text(message, textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5)),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () {
                // Retry the appropriate action based on what we already have
                if (cubit.categories.isNotEmpty) {
                  cubit.loadProducts(category: cubit.selectedCategory);
                } else {
                  cubit.loadCategories();
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.refresh, color: Colors.white, size: 16.sp),
                    SizedBox(width: 6.w),
                    Text('Try Again',
                      style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoriesOnly(BuildContext context, List<InsuranceCategoryInfo> categories, CreatePolicyCubit cubit) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8.h),
          Text('Choose a Category',
            style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
          SizedBox(height: 4.h),
          Text('Select an insurance category to browse available plans',
            style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
          SizedBox(height: 20.h),
          _buildCategoryGrid(context, categories, cubit, null),
        ],
      ),
    );
  }

  Widget _buildWithProducts(BuildContext context, CreatePolicyCubit cubit, List<InsuranceProduct> products,
      bool isLoading, {InsuranceProductCategory? selectedCategory}) {
    final selectedProductId = cubit.selectedProduct?.id;
    // Find the category info for the header
    final categoryInfo = cubit.selectedCategoryInfo;
    return RefreshIndicator(
      onRefresh: () => cubit.loadProducts(category: selectedCategory),
      color: const Color(0xFF3B82F6),
      backgroundColor: const Color(0xFF1F1F1F),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            // Category header with back-to-categories option
            _buildSelectedCategoryHeader(context, cubit, selectedCategory, categoryInfo),
            SizedBox(height: 20.h),
            Text('Available Plans',
              style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 12.h),
            if (isLoading)
              ...List.generate(3, (_) => _buildProductSkeleton())
            else if (products.isEmpty)
              _buildEmptyProducts()
            else
              ...products.map((p) => _buildProductCard(context, p, cubit, isSelected: p.id == selectedProductId)),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, List<InsuranceCategoryInfo> categories,
      CreatePolicyCubit cubit, InsuranceProductCategory? selected) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, crossAxisSpacing: 12.w, mainAxisSpacing: 12.h, childAspectRatio: 1.0),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final cat = categories[index];
        final category = cat.category;
        final isSelected = selected == category;
        return GestureDetector(
          onTap: () => cubit.loadProducts(category: category),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.15) : const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
                width: isSelected ? 2 : 1),
            ),
            child: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(category.icon, size: 28.sp,
                        color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF9CA3AF)),
                      SizedBox(height: 8.h),
                      Text(cat.name, textAlign: TextAlign.center,
                        style: GoogleFonts.inter(fontSize: 12.sp,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          color: isSelected ? Colors.white : const Color(0xFF9CA3AF))),
                    ],
                  ),
                ),
                // Info button
                Positioned(
                  top: 4.w,
                  right: 4.w,
                  child: GestureDetector(
                    onTap: () => _showCategoryInfoSheet(context, cat),
                    child: Container(
                      width: 22.w,
                      height: 22.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                      child: Icon(Icons.info_outline, size: 13.sp, color: const Color(0xFF9CA3AF)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectedCategoryHeader(BuildContext context, CreatePolicyCubit cubit,
      InsuranceProductCategory? selected, InsuranceCategoryInfo? categoryInfo) {
    final categoryName = categoryInfo?.name ?? selected?.displayName ?? 'Insurance';
    final productCount = categoryInfo?.productCount ?? 0;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w, height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(selected?.icon ?? Icons.shield, size: 22.sp, color: const Color(0xFF6366F1)),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(categoryName,
                  style: GoogleFonts.inter(fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                if (productCount > 0) ...[
                  SizedBox(height: 2.h),
                  Text('$productCount plan${productCount > 1 ? 's' : ''} available',
                    style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: () => cubit.backToCategories(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.swap_horiz, size: 14.sp, color: const Color(0xFF9CA3AF)),
                  SizedBox(width: 4.w),
                  Text('Change',
                    style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF9CA3AF))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, InsuranceProduct product, CreatePolicyCubit cubit,
      {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => cubit.selectProduct(product),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6366F1).withValues(alpha: 0.1)
              : const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              // Product icon with selection state
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40.w, height: 40.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF6366F1).withValues(alpha: 0.2)
                      : const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r)),
                child: Center(child: Icon(product.category.icon, size: 22.sp,
                  color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF6366F1).withValues(alpha: 0.7))),
              ),
              SizedBox(width: 12.w),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.name, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600,
                  color: isSelected ? Colors.white : Colors.white),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h),
                Text(product.providerName, style: GoogleFonts.inter(fontSize: 12.sp,
                  color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.8) : const Color(0xFF9CA3AF))),
              ])),
              // Info button
              GestureDetector(
                onTap: () => _showProductInfoSheet(context, product),
                child: Container(
                  width: 30.w,
                  height: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.06),
                  ),
                  child: Icon(Icons.info_outline, color: const Color(0xFF9CA3AF), size: 18.sp),
                ),
              ),
              SizedBox(width: 4.w),
              // Selection indicator
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Icon(Icons.check_circle, color: const Color(0xFF6366F1), size: 22.sp, key: const ValueKey('check'))
                    : Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 20.sp, key: const ValueKey('chevron')),
              ),
            ]),
            SizedBox(height: 12.h),
            if (product.description.isNotEmpty) ...[
              if (product.description.contains('<') && product.description.contains('>'))
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 40.h),
                  child: HtmlWidget(
                    product.description,
                    textStyle: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                    customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'},
                  ),
                )
              else
                Text(product.description, style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
                  maxLines: 2, overflow: TextOverflow.ellipsis),
            ] else
              Text('Tap the info button for details', style: GoogleFonts.inter(
                fontSize: 12.sp, color: const Color(0xFF9CA3AF).withValues(alpha: 0.6), fontStyle: FontStyle.italic)),
            SizedBox(height: 12.h),
            Row(children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4.r)),
                child: Text(product.premiumRange, style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
              ),
              const Spacer(),
              if (product.benefits.isNotEmpty)
                Text('${product.benefits.length} benefit${product.benefits.length > 1 ? 's' : ''}',
                  style: GoogleFonts.inter(fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
            ]),
            // Selected indicator bar
            if (isSelected) ...[
              SizedBox(height: 10.h),
              Container(
                width: double.infinity,
                height: 3.h,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color.fromARGB(255, 78, 3, 208)],
                  ),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildProductSkeleton() {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w), height: 120.h,
      decoration: BoxDecoration(color: const Color(0xFF1F1F1F), borderRadius: BorderRadius.circular(12.r)),
      child: const Center(child: CircularProgressIndicator(color: Color(0xFF6366F1), strokeWidth: 2)),
    );
  }

  Widget _buildEmptyProducts() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Column(children: [
        Icon(Icons.search_off, size: 48.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(height: 12.h),
        Text('No products available',
          style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: const Color(0xFF9CA3AF))),
        SizedBox(height: 4.h),
        Text('Try selecting a different category',
          style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
      ]),
    );
  }

  // ============================================================
  // Info Bottom Sheets
  // ============================================================

  void _showCategoryInfoSheet(BuildContext context, InsuranceCategoryInfo cat) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.45),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w, height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2.r)),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 48.w, height: 48.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.r)),
                      child: Icon(cat.category.icon, size: 26.sp, color: const Color(0xFF6366F1)),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(cat.name, style: GoogleFonts.inter(
                        fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                      SizedBox(height: 2.h),
                      Text('Insurance Category', style: GoogleFonts.inter(
                        fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                    ])),
                  ]),
                  SizedBox(height: 20.h),
                  // Description or fallback
                  if (cat.description.isNotEmpty)
                    _buildSheetRichContent(cat.description)
                  else
                    Text(
                      'Browse ${cat.name.toLowerCase()} insurance products from trusted providers. '
                      'Compare plans, get instant quotes, and purchase coverage directly from the app.',
                      style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5),
                    ),
                  SizedBox(height: 16.h),
                  // Product count badge
                  if (cat.productCount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        Icon(Icons.inventory_2_outlined, size: 16.sp, color: const Color(0xFF10B981)),
                        SizedBox(width: 6.w),
                        Text('${cat.productCount} product${cat.productCount > 1 ? 's' : ''} available',
                          style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                      ]),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductInfoSheet(BuildContext context, InsuranceProduct product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.65,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1F1F1F),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w, height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2.r)),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    // Header
                    Row(children: [
                      Container(
                        width: 52.w, height: 52.w,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r)),
                        child: Icon(product.category.icon, size: 28.sp, color: const Color(0xFF6366F1)),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(product.name, style: GoogleFonts.inter(
                          fontSize: 18.sp, fontWeight: FontWeight.w700, color: Colors.white)),
                        SizedBox(height: 2.h),
                        Text(product.providerName, style: GoogleFonts.inter(
                          fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                      ])),
                    ]),
                    SizedBox(height: 16.h),

                    // Premium range + category badges
                    Row(children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.premiumRange, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF10B981))),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6.r)),
                        child: Text(product.category.displayName, style: GoogleFonts.inter(
                          fontSize: 13.sp, fontWeight: FontWeight.w600, color: const Color(0xFF6366F1))),
                      ),
                      const Spacer(),
                      if (product.isRenewable)
                        _buildFeatureBadge(Icons.autorenew, 'Renewable'),
                      if (product.isClaimable) ...[
                        SizedBox(width: 6.w),
                        _buildFeatureBadge(Icons.verified_user, 'Claimable'),
                      ],
                    ]),
                    SizedBox(height: 20.h),

                    // Description
                    if (product.description.isNotEmpty)
                      _buildSheetSection('About this Plan', child: _buildSheetRichContent(product.description))
                    else
                      _buildSheetSection('About this Plan', child: Text(
                        'Details for this insurance plan will be available after getting a quote. '
                        'Select the plan and fill in your details to see pricing and coverage information.',
                        style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5),
                      )),

                    // How It Works
                    if (product.howItWorks.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSheetSection('How It Works', child: _buildSheetRichContent(product.howItWorks)),
                    ],

                    // Benefits
                    if (product.benefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSheetSection('Benefits', child: Column(
                        children: product.benefits.map((b) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Icon(Icons.check_circle, size: 16.sp, color: const Color(0xFF10B981)),
                            SizedBox(width: 8.w),
                            Expanded(child: Text(b, style: GoogleFonts.inter(
                              fontSize: 13.sp, color: Colors.white, height: 1.4))),
                          ]),
                        )).toList(),
                      )),
                    ],

                    // Full Benefits (from MyCover.ai — may be HTML)
                    if (product.fullBenefits.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSheetSection('Full Coverage Details', child: _buildSheetRichContent(product.fullBenefits)),
                    ],

                    // Metadata
                    if (product.metadata.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSheetSection('Additional Info', child: Column(
                        children: product.metadata.entries.map((e) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                            Text(e.key, style: GoogleFonts.inter(fontSize: 13.sp, color: const Color(0xFF9CA3AF))),
                            Flexible(child: Text(e.value, textAlign: TextAlign.end,
                              style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w500, color: Colors.white))),
                          ]),
                        )).toList(),
                      )),
                    ],

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Shared Bottom Sheet Widgets
  // ============================================================

  Widget _buildSheetSection(String title, {required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.inter(
          fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.white)),
        SizedBox(height: 10.h),
        child,
      ],
    );
  }

  Widget _buildSheetRichContent(String content) {
    if (content.contains('<') && content.contains('>')) {
      return HtmlWidget(
        content,
        textStyle: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5),
        customStylesBuilder: (_) => {'color': 'rgba(156,163,175,1)', 'background-color': 'transparent'},
      );
    }
    return Text(content, style: GoogleFonts.inter(
      fontSize: 14.sp, color: const Color(0xFF9CA3AF), height: 1.5));
  }

  Widget _buildFeatureBadge(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4.r)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 12.sp, color: const Color(0xFF9CA3AF)),
        SizedBox(width: 3.w),
        Text(label, style: GoogleFonts.inter(fontSize: 10.sp, color: const Color(0xFF9CA3AF))),
      ]),
    );
  }
}
