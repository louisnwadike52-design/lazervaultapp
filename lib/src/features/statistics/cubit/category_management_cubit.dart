import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lazervault/src/features/statistics/data/financial_analytics_repository.dart';
import 'package:lazervault/src/generated/accounts.pb.dart' as accounts_pb;

// ===== States =====

sealed class CategoryManagementState extends Equatable {
  const CategoryManagementState();
  @override
  List<Object?> get props => [];
}

class CategoryManagementInitial extends CategoryManagementState {}

class CategoryManagementLoading extends CategoryManagementState {}

class CategoryManagementLoaded extends CategoryManagementState {
  final List<accounts_pb.UserCategoryMappingItem> mappings;
  final List<accounts_pb.CategoryBreakdownItem> allCategories;

  const CategoryManagementLoaded({
    required this.mappings,
    required this.allCategories,
  });

  @override
  List<Object?> get props => [mappings, allCategories];
}

class CategoryManagementError extends CategoryManagementState {
  final String message;
  const CategoryManagementError(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoryMappingUpdated extends CategoryManagementState {
  final String message;
  const CategoryMappingUpdated(this.message);
  @override
  List<Object?> get props => [message];
}

class CategoriesReordered extends CategoryManagementState {
  const CategoriesReordered();
}

// ===== Cubit =====

class CategoryManagementCubit extends Cubit<CategoryManagementState> {
  final FinancialAnalyticsRepository analyticsRepository;

  CategoryManagementCubit({
    required this.analyticsRepository,
  }) : super(CategoryManagementInitial());

  /// Load category mappings and all known categories
  Future<void> loadCategories() async {
    emit(CategoryManagementLoading());
    try {
      final results = await Future.wait([
        analyticsRepository.getUserCategoryMappings(),
        analyticsRepository.getCategoryAnalytics(),
      ]);

      final mappingsResponse =
          results[0] as accounts_pb.GetUserCategoryMappingsResponse;
      final categoryResponse =
          results[1] as accounts_pb.GetCategoryAnalyticsResponse;

      // Combine expense + income categories for the full list
      final allCategories = <accounts_pb.CategoryBreakdownItem>[
        ...categoryResponse.expenseCategories,
        ...categoryResponse.incomeCategories,
      ];

      // Deduplicate by category name
      final seen = <String>{};
      final uniqueCategories = allCategories.where((c) {
        final name = c.categoryName.toLowerCase();
        if (seen.contains(name)) return false;
        seen.add(name);
        return true;
      }).toList();

      emit(CategoryManagementLoaded(
        mappings: mappingsResponse.mappings.toList(),
        allCategories: uniqueCategories,
      ));
    } catch (e) {
      emit(CategoryManagementError('Failed to load categories: $e'));
    }
  }

  /// Rename a category
  Future<void> renameCategory({
    required String originalCategory,
    required String customCategory,
  }) async {
    try {
      await analyticsRepository.updateUserCategoryMapping(
        originalCategory: originalCategory,
        customCategory: customCategory,
      );
      emit(CategoryMappingUpdated(
          '"$originalCategory" renamed to "$customCategory"'));
      await loadCategories();
    } catch (e) {
      emit(CategoryManagementError('Failed to rename category: $e'));
    }
  }

  /// Move a category under a parent
  Future<void> moveCategory({
    required String originalCategory,
    required String parentCategory,
  }) async {
    try {
      await analyticsRepository.updateUserCategoryMapping(
        originalCategory: originalCategory,
        customCategory: originalCategory,
        parentCategory: parentCategory,
      );
      emit(CategoryMappingUpdated(
          '"$originalCategory" moved under "$parentCategory"'));
      await loadCategories();
    } catch (e) {
      emit(CategoryManagementError('Failed to move category: $e'));
    }
  }

  /// Reorder categories after drag-and-drop
  Future<void> reorderCategories(
      List<accounts_pb.CategoryOrderItem> orderings) async {
    try {
      await analyticsRepository.reorderCategories(orderings: orderings);
      emit(const CategoriesReordered());
      await loadCategories();
    } catch (e) {
      emit(CategoryManagementError('Failed to reorder categories: $e'));
    }
  }
}
