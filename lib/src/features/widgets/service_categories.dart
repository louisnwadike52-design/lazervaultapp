import 'package:flutter/material.dart';

/// Centralized service category definitions matching backend mappings
/// from statistics-service/internal/seeds/categories.go
class ServiceCategories {
  // Color definitions matching backend
  static const Color colorFood = Color(0xFFFF6B6B);
  static const Color colorShopping = Color(0xFF45B7D1);
  static const Color colorRent = Color(0xFFBB8FCE);
  static const Color colorGifts = Color(0xFFFF6B9D);
  static const Color colorTransport = Color(0xFF4ECDC4);
  static const Color colorHealthcare = Color(0xFFFECA57);
  static const Color colorEducation = Color(0xFFDDA0DD);
  static const Color colorEntertainment = Color(0xFFA29BFE);
  static const Color colorOther = Color(0xFF95A5A6);
  static const Color colorBills = Color(0xFF96CEB4);
  static const Color colorElectricity = Color(0xFF00B04F);
  static const Color colorWater = Color(0xFF3B82F6);
  static const Color colorCableTv = Color(0xFFEF4444);
  static const Color colorInternet = Color(0xFF9B59B6);
  static const Color colorGenerator = Color(0xFFF39C12);
  static const Color colorStocks = Color(0xFF52B788);
  static const Color colorCrypto = Color(0xFFF59E0B);
  static const Color colorMutualFunds = Color(0xFF3498DB);
  static const Color colorBonds = Color(0xFF1ABC9C);
  static const Color colorGiftCard = Color(0xFFE91E63);
  static const Color colorInvoice = Color(0xFF607D8B);
  static const Color colorQrPayment = Color(0xFF9C27B0);

  /// All service categories with their mappings
  /// Use BudgetCubit.loadServiceCategories() to fetch from backend instead.
  @Deprecated('Use BudgetCubit.loadServiceCategories() for dynamic categories from backend')
  static const List<ServiceCategory> allCategories = [
    // Transfer subcategories
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'food',
      displayName: 'Food Transfer',
      icon: Icons.restaurant,
      color: colorFood,
      budgetCategory: 1,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'shopping',
      displayName: 'Shopping Transfer',
      icon: Icons.shopping_bag,
      color: colorShopping,
      budgetCategory: 3,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'rent',
      displayName: 'Rent Payment',
      icon: Icons.home,
      color: colorRent,
      budgetCategory: 10,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'gifts',
      displayName: 'Gift Transfer',
      icon: Icons.card_giftcard,
      color: colorGifts,
      budgetCategory: 13,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'transport',
      displayName: 'Transport Transfer',
      icon: Icons.directions_car,
      color: colorTransport,
      budgetCategory: 2,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'healthcare',
      displayName: 'Healthcare Transfer',
      icon: Icons.medical_services,
      color: colorHealthcare,
      budgetCategory: 6,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'education',
      displayName: 'Education Transfer',
      icon: Icons.school,
      color: colorEducation,
      budgetCategory: 7,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'entertainment',
      displayName: 'Entertainment Transfer',
      icon: Icons.movie,
      color: colorEntertainment,
      budgetCategory: 4,
    ),
    ServiceCategory(
      serviceName: 'transfer',
      subCategoryName: 'other',
      displayName: 'Other Transfer',
      icon: Icons.category,
      color: colorOther,
      budgetCategory: 16,
    ),

    // Bill payment subcategories
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'airtime',
      displayName: 'Airtime Top-up',
      icon: Icons.phone_android,
      color: colorBills,
      budgetCategory: 5,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'electricity',
      displayName: 'Electricity Bill',
      icon: Icons.bolt,
      color: colorElectricity,
      budgetCategory: 5,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'water',
      displayName: 'Water Bill',
      icon: Icons.water_drop,
      color: colorWater,
      budgetCategory: 5,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'cable_tv',
      displayName: 'Cable TV',
      icon: Icons.tv,
      color: colorCableTv,
      budgetCategory: 4,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'internet',
      displayName: 'Internet',
      icon: Icons.router,
      color: colorInternet,
      budgetCategory: 15,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'education_pin',
      displayName: 'Education PINs',
      icon: Icons.school,
      color: colorEducation,
      budgetCategory: 7,
    ),
    ServiceCategory(
      serviceName: 'bill_payment',
      subCategoryName: 'generator_fuel',
      displayName: 'Generator Fuel',
      icon: Icons.local_gas_station,
      color: colorGenerator,
      budgetCategory: 5,
    ),

    // Investment subcategories
    ServiceCategory(
      serviceName: 'investment',
      subCategoryName: 'stocks',
      displayName: 'Stocks',
      icon: Icons.trending_up,
      color: colorStocks,
      budgetCategory: 12,
    ),
    ServiceCategory(
      serviceName: 'investment',
      subCategoryName: 'crypto',
      displayName: 'Cryptocurrency',
      icon: Icons.currency_bitcoin,
      color: colorCrypto,
      budgetCategory: 12,
    ),
    ServiceCategory(
      serviceName: 'investment',
      subCategoryName: 'mutual_funds',
      displayName: 'Mutual Funds',
      icon: Icons.account_balance,
      color: colorMutualFunds,
      budgetCategory: 12,
    ),
    ServiceCategory(
      serviceName: 'investment',
      subCategoryName: 'bonds',
      displayName: 'Bonds',
      icon: Icons.description,
      color: colorBonds,
      budgetCategory: 12,
    ),

    // Commerce subcategories
    ServiceCategory(
      serviceName: 'commerce',
      subCategoryName: 'gift_card',
      displayName: 'Gift Card',
      icon: Icons.card_giftcard,
      color: colorGiftCard,
      budgetCategory: 3,
    ),
    ServiceCategory(
      serviceName: 'commerce',
      subCategoryName: 'invoice_payment',
      displayName: 'Invoice Payment',
      icon: Icons.receipt,
      color: colorInvoice,
      budgetCategory: 16,
    ),
    ServiceCategory(
      serviceName: 'commerce',
      subCategoryName: 'qr_payment',
      displayName: 'QR Payment',
      icon: Icons.qr_code_2,
      color: colorQrPayment,
      budgetCategory: 16,
    ),
  ];

  /// Get categories by service name
  static List<ServiceCategory> getByService(String serviceName) {
    return allCategories.where((cat) => cat.serviceName == serviceName).toList();
  }

  /// Get category by subcategory name
  static ServiceCategory? getBySubCategory(String subCategoryName) {
    for (final cat in allCategories) {
      if (cat.subCategoryName == subCategoryName) {
        return cat;
      }
    }
    return null;
  }

  /// Get category display name with fallback
  static String getDisplayName(String serviceName, String subCategoryName) {
    final cat = getBySubCategory(subCategoryName);
    if (cat != null) return cat.displayName;

    // Fallback to formatted name
    return subCategoryName
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) => word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
        .join(' ');
  }

  /// Get category color
  static Color getColor(String subCategoryName) {
    final cat = getBySubCategory(subCategoryName);
    return cat?.color ?? colorOther;
  }

  /// Get category icon
  static IconData getIcon(String subCategoryName) {
    final cat = getBySubCategory(subCategoryName);
    return cat?.icon ?? Icons.category;
  }

  /// Budget category enum matching backend
  static const int budgetCategoryFoodDining = 1;
  static const int budgetCategoryTransportation = 2;
  static const int budgetCategoryShopping = 3;
  static const int budgetCategoryEntertainment = 4;
  static const int budgetCategoryBillsUtilities = 5;
  static const int budgetCategoryHealthcare = 6;
  static const int budgetCategoryEducation = 7;
  static const int budgetCategoryRentMortgage = 10;
  static const int budgetCategoryInvestments = 12;
  static const int budgetCategoryGiftsDonations = 13;
  static const int budgetCategorySubscriptions = 15;
  static const int budgetCategoryOther = 16;

  /// Get budget category name for display
  static String getBudgetCategoryName(int budgetCategory) {
    return switch (budgetCategory) {
      budgetCategoryFoodDining => 'Food & Dining',
      budgetCategoryTransportation => 'Transportation',
      budgetCategoryShopping => 'Shopping',
      budgetCategoryEntertainment => 'Entertainment',
      budgetCategoryBillsUtilities => 'Bills & Utilities',
      budgetCategoryHealthcare => 'Healthcare',
      budgetCategoryEducation => 'Education',
      budgetCategoryRentMortgage => 'Rent & Mortgage',
      budgetCategoryInvestments => 'Investments',
      budgetCategoryGiftsDonations => 'Gifts & Donations',
      budgetCategorySubscriptions => 'Subscriptions',
      budgetCategoryOther => 'Other',
      _ => 'Category $budgetCategory',
    };
  }

  /// Get chart colors for budget categories
  static Color getBudgetCategoryColor(int budgetCategory) {
    return switch (budgetCategory) {
      budgetCategoryFoodDining => colorFood,
      budgetCategoryTransportation => colorTransport,
      budgetCategoryShopping => colorShopping,
      budgetCategoryEntertainment => colorEntertainment,
      budgetCategoryBillsUtilities => colorBills,
      budgetCategoryHealthcare => colorHealthcare,
      budgetCategoryEducation => colorEducation,
      budgetCategoryRentMortgage => colorRent,
      budgetCategoryInvestments => colorStocks,
      budgetCategoryGiftsDonations => colorGifts,
      budgetCategorySubscriptions => colorInternet,
      budgetCategoryOther => colorOther,
      _ => colorOther,
    };
  }
}

/// Represents a service category mapping
class ServiceCategory {
  final String serviceName;
  final String subCategoryName;
  final String displayName;
  final IconData icon;
  final Color color;
  final int budgetCategory;

  const ServiceCategory({
    required this.serviceName,
    required this.subCategoryName,
    required this.displayName,
    required this.icon,
    required this.color,
    required this.budgetCategory,
});
}
