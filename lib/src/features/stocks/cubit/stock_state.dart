import 'package:equatable/equatable.dart';
import '../domain/entities/stock_entity.dart';
import '../domain/entities/analyst_ratings.dart';
import '../domain/entities/stock_event.dart';
part 'stock_state_widgets.dart';


class StockDetailsLoaded extends StockState {
  final Stock stock;
  final List<StockPrice> priceHistory;
  final StockAnalysis? analysis;
  final AnalystRatings? analystRatings;
  final List<StockEvent>? events;

  const StockDetailsLoaded({
    required this.stock,
    required this.priceHistory,
    this.analysis,
    this.analystRatings,
    this.events,
  });

  StockDetailsLoaded copyWith({
    Stock? stock,
    List<StockPrice>? priceHistory,
    StockAnalysis? analysis,
    AnalystRatings? analystRatings,
    List<StockEvent>? events,
  }) {
    return StockDetailsLoaded(
      stock: stock ?? this.stock,
      priceHistory: priceHistory ?? this.priceHistory,
      analysis: analysis ?? this.analysis,
      analystRatings: analystRatings ?? this.analystRatings,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [stock, priceHistory, analysis, analystRatings, events];
} 