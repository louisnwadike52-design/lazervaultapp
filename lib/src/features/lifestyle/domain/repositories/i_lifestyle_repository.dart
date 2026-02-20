import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/hotel_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/tour_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';

abstract class ILifestyleRepository {
  Future<List<LifestyleCategory>> getCategories();

  Future<List<FlightResult>> searchFlights({
    required String origin,
    required String destination,
    required String departDate,
    String returnDate = '',
    int adults = 1,
    String cabinClass = 'economy',
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
  });

  Future<List<FlightResult>> getCheapFlights({
    required String origin,
    String destination = '',
    String month = '',
    String currency = '',
    int limit = 10,
  });

  Future<List<HotelResult>> searchHotels({
    required String location,
    required String checkIn,
    required String checkOut,
    int adults = 2,
    int rooms = 1,
    String currency = '',
    int minStars = 0,
    String sortBy = 'price',
    int limit = 10,
  });

  Future<List<TourResult>> searchTours({
    required String location,
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
    String category = '',
  });
}
