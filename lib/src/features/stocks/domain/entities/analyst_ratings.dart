class AnalystRatings {
  final String symbol;
  final String consensus;
  final double targetPrice;
  final int buyRating;
  final int holdRating;
  final int sellRating;
  final int analystCount;

  const AnalystRatings({
    required this.symbol,
    required this.consensus,
    required this.targetPrice,
    required this.buyRating,
    required this.holdRating,
    required this.sellRating,
    required this.analystCount,
  });
} 