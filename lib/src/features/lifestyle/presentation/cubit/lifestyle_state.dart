import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/hotel_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/tour_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';

sealed class LifestyleState {}

class LifestyleInitial extends LifestyleState {}

class LifestyleLoading extends LifestyleState {}

class LifestyleCategoriesLoaded extends LifestyleState {
  final List<LifestyleCategory> categories;
  final List<FlightResult> cheapFlights;

  LifestyleCategoriesLoaded({
    required this.categories,
    this.cheapFlights = const [],
  });
}

class FlightsLoading extends LifestyleState {}

class FlightsLoaded extends LifestyleState {
  final List<FlightResult> flights;
  final String searchId;

  FlightsLoaded({required this.flights, this.searchId = ''});
}

class HotelsLoading extends LifestyleState {}

class HotelsLoaded extends LifestyleState {
  final List<HotelResult> hotels;
  final String searchId;

  HotelsLoaded({required this.hotels, this.searchId = ''});
}

class ToursLoading extends LifestyleState {}

class ToursLoaded extends LifestyleState {
  final List<TourResult> tours;
  final String searchId;

  ToursLoaded({required this.tours, this.searchId = ''});
}

class LifestyleError extends LifestyleState {
  final String message;

  LifestyleError(this.message);
}
