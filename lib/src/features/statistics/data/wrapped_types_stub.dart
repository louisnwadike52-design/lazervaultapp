// Temporary stub types for Financial Wrapped feature
// TODO: Replace with generated proto types when available

enum WrappedPeriod {
  wrappedPeriodUnspecified,
  wrappedPeriodMonthly,
  wrappedPeriodYearly,
}

class FinancialWrapped {
  final int year;
  final WrappedSummary? summary;
  final WrappedTrends? trends;
  final List<WrappedCategoryRanking> topCategories;
  final List<WrappedMerchantRanking> topMerchants;
  final WrappedAIInsights? aiInsights;
  final List<WrappedFunFact> funFacts;
  final List<WrappedAchievement> achievements;

  FinancialWrapped({
    this.year = 2024,
    this.summary,
    this.trends,
    this.topCategories = const [],
    this.topMerchants = const [],
    this.aiInsights,
    this.funFacts = const [],
    this.achievements = const [],
  });
}

class WrappedSummary {
  final double totalSpent;
  final double totalIncome;
  final double totalEarned;
  final double totalSaved;
  final double netSavings;
  final double averageTransaction;
  final double savingsRate;
  final int transactionCount;
  final String periodLabel;

  WrappedSummary({
    this.totalSpent = 0,
    this.totalIncome = 0,
    this.totalEarned = 0,
    this.totalSaved = 0,
    this.netSavings = 0,
    this.averageTransaction = 0,
    this.savingsRate = 0,
    this.transactionCount = 0,
    this.periodLabel = '',
  });
}

class WrappedTrends {
  final List<WrappedMonthlyTrend> monthlyTrends;
  final double averageMonthlySpending;
  final String highestSpendingMonth;
  final String lowestSpendingMonth;
  final String spendingTrendDescription;
  final List<String> improvingCategories;
  final List<String> watchCategories;

  WrappedTrends({
    this.monthlyTrends = const [],
    this.averageMonthlySpending = 0,
    this.highestSpendingMonth = '',
    this.lowestSpendingMonth = '',
    this.spendingTrendDescription = '',
    this.improvingCategories = const [],
    this.watchCategories = const [],
  });
}

class WrappedMonthlyTrend {
  final String monthLabel;
  final double amount;

  WrappedMonthlyTrend({
    this.monthLabel = '',
    this.amount = 0,
  });
}

class WrappedCategoryRanking {
  final String categoryName;
  final String categoryIcon;
  final String emoji;
  final double amount;
  final int rank;
  final double percentageOfTotal;
  final double percentage;
  final int transactionCount;
  final String trend;
  final double trendPercentage;

  WrappedCategoryRanking({
    this.categoryName = '',
    this.categoryIcon = '',
    this.emoji = '',
    this.amount = 0,
    this.rank = 0,
    this.percentageOfTotal = 0,
    this.percentage = 0,
    this.transactionCount = 0,
    this.trend = '',
    this.trendPercentage = 0,
  });
}

class WrappedMerchantRanking {
  final String merchantName;
  final String merchantLogo;
  final String emoji;
  final String category;
  final double amount;
  final int rank;
  final int transactionCount;
  final int visitCount;
  final double percentage;

  WrappedMerchantRanking({
    this.merchantName = '',
    this.merchantLogo = '',
    this.emoji = '',
    this.category = '',
    this.amount = 0,
    this.rank = 0,
    this.transactionCount = 0,
    this.visitCount = 0,
    this.percentage = 0,
  });
}

class WrappedAIInsights {
  final String summary;
  final String overallSummary;
  final String encouragement;
  final String financialPersona;
  final List<String> highlights;
  final List<String> recommendations;
  final List<String> personalizedInsights;
  final List<String> personalityTraits;

  WrappedAIInsights({
    this.summary = '',
    this.overallSummary = '',
    this.encouragement = '',
    this.financialPersona = '',
    this.highlights = const [],
    this.recommendations = const [],
    this.personalizedInsights = const [],
    this.personalityTraits = const [],
  });
}

class WrappedFunFact {
  final String title;
  final String description;
  final String icon;
  final String emoji;
  final String comparison;

  WrappedFunFact({
    this.title = '',
    this.description = '',
    this.icon = '',
    this.emoji = '',
    this.comparison = '',
  });
}

class WrappedAchievement {
  final String name;
  final String title;
  final String description;
  final String icon;
  final String emoji;
  final String tier;
  final double progress;
  final bool unlocked;

  WrappedAchievement({
    this.name = '',
    this.title = '',
    this.description = '',
    this.icon = '',
    this.emoji = '',
    this.tier = '',
    this.progress = 0,
    this.unlocked = false,
  });
}
