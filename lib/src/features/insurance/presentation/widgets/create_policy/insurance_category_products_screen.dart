import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import '../../cubit/create_policy_cubit.dart';
import '../../cubit/create_policy_state.dart';

/// Screen 1: Browse insurance categories and products from MyCover.ai
class InsuranceCategoryProductsScreen extends StatelessWidget {
  const InsuranceCategoryProductsScreen({super.key});

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
          return _buildWithProducts(context, cubit, [], true);
        }

        if (state is InsuranceProductsLoaded) {
          return _buildWithProducts(context, cubit, state.products, false,
              selectedCategory: state.selectedCategory);
        }

        return const Center(
          child: CircularProgressIndicator(color: Color(0xFF6366F1)),
        );
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: const Color(0xFFEF4444), size: 48.sp),
            SizedBox(height: 16.h),
            Text(message, textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 14.sp, color: const Color(0xFF9CA3AF))),
            SizedBox(height: 24.h),
            GestureDetector(
              onTap: () => context.read<CreatePolicyCubit>().loadCategories(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B82F6),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text('Retry',
                  style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white)),
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
            _buildCategoryChips(context, cubit, selectedCategory),
            SizedBox(height: 20.h),
            Text('Available Plans',
              style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w700, color: Colors.white)),
            SizedBox(height: 12.h),
            if (isLoading)
              ...List.generate(3, (_) => _buildProductSkeleton())
            else if (products.isEmpty)
              _buildEmptyProducts()
            else
              ...products.map((p) => _buildProductCard(context, p, cubit)),
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
        );
      },
    );
  }

  Widget _buildCategoryChips(BuildContext context, CreatePolicyCubit cubit, InsuranceProductCategory? selected) {
    final categories = cubit.categories;
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final bool isAll = index == 0;
          final bool isSelected = isAll ? selected == null : selected == categories[index - 1].category;
          final String label = isAll ? 'All' : categories[index - 1].name;

          return GestureDetector(
            onTap: () => isAll ? cubit.loadProducts() : cubit.loadProducts(category: categories[index - 1].category),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF1F1F1F),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: isSelected ? const Color(0xFF6366F1) : const Color(0xFF2D2D2D)),
              ),
              child: Center(
                child: Text(label,
                  style: GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF9CA3AF))),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, InsuranceProduct product, CreatePolicyCubit cubit) {
    return GestureDetector(
      onTap: () => cubit.selectProduct(product),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                width: 40.w, height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r)),
                child: Center(child: Icon(product.category.icon, size: 22.sp, color: const Color(0xFF6366F1))),
              ),
              SizedBox(width: 12.w),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.name, style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h),
                Text(product.providerName, style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF))),
              ])),
              Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 20.sp),
            ]),
            SizedBox(height: 12.h),
            Text(product.description, style: GoogleFonts.inter(fontSize: 12.sp, color: const Color(0xFF9CA3AF)),
              maxLines: 2, overflow: TextOverflow.ellipsis),
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
}
