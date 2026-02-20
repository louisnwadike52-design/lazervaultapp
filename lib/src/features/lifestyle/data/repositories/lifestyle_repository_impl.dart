import 'package:lazervault/src/features/lifestyle/data/datasources/lifestyle_remote_datasource.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/hotel_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/tour_result.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';
import 'package:lazervault/src/features/lifestyle/domain/repositories/i_lifestyle_repository.dart';

class LifestyleRepositoryImpl implements ILifestyleRepository {
  final LifestyleRemoteDataSource _dataSource;

  LifestyleRepositoryImpl(this._dataSource);

  @override
  Future<List<LifestyleCategory>> getCategories() {
    return _dataSource.getCategories();
  }

  @override
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
  }) {
    return _dataSource.searchFlights(
      origin: origin,
      destination: destination,
      departDate: departDate,
      returnDate: returnDate,
      adults: adults,
      cabinClass: cabinClass,
      currency: currency,
      sortBy: sortBy,
      limit: limit,
    );
  }

  @override
  Future<List<FlightResult>> getCheapFlights({
    required String origin,
    String destination = '',
    String month = '',
    String currency = '',
    int limit = 10,
  }) {
    return _dataSource.getCheapFlights(
      origin: origin,
      destination: destination,
      month: month,
      currency: currency,
      limit: limit,
    );
  }

  @override
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
  }) {
    return _dataSource.searchHotels(
      location: location,
      checkIn: checkIn,
      checkOut: checkOut,
      adults: adults,
      rooms: rooms,
      currency: currency,
      minStars: minStars,
      sortBy: sortBy,
      limit: limit,
    );
  }

  @override
  Future<List<TourResult>> searchTours({
    required String location,
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
    String category = '',
  }) {
    return _dataSource.searchTours(
      location: location,
      currency: currency,
      sortBy: sortBy,
      limit: limit,
      category: category,
    );
  }
}
