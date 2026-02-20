import 'package:dio/dio.dart';
import 'package:lazervault/src/features/lifestyle/data/models/flight_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/hotel_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/tour_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/lifestyle_category_model.dart';

class LifestyleRemoteDataSource {
  final Dio _dio;

  LifestyleRemoteDataSource(this._dio);

  Future<List<LifestyleCategoryModel>> getCategories() async {
    final response = await _dio.get('/api/v1/lifestyle/categories');
    final data = response.data;
    final categories = data['categories'] as List<dynamic>? ?? [];
    return categories
        .map((json) => LifestyleCategoryModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<FlightResultModel>> searchFlights({
    required String origin,
    required String destination,
    required String departDate,
    String returnDate = '',
    int adults = 1,
    String cabinClass = 'economy',
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
  }) async {
    final params = <String, dynamic>{
      'origin': origin,
      'destination': destination,
      'depart_date': departDate,
      'adults': adults,
      'sort_by': sortBy,
      'limit': limit,
    };
    if (returnDate.isNotEmpty) params['return_date'] = returnDate;
    if (cabinClass.isNotEmpty) params['cabin_class'] = cabinClass;
    if (currency.isNotEmpty) params['currency'] = currency;

    final response = await _dio.get('/api/v1/lifestyle/flights/search', queryParameters: params);
    final data = response.data;
    final flights = data['flights'] as List<dynamic>? ?? [];
    return flights
        .map((json) => FlightResultModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<FlightResultModel>> getCheapFlights({
    required String origin,
    String destination = '',
    String month = '',
    String currency = '',
    int limit = 10,
  }) async {
    final params = <String, dynamic>{
      'origin': origin,
      'limit': limit,
    };
    if (destination.isNotEmpty) params['destination'] = destination;
    if (month.isNotEmpty) params['month'] = month;
    if (currency.isNotEmpty) params['currency'] = currency;

    final response = await _dio.get('/api/v1/lifestyle/flights/cheap', queryParameters: params);
    final data = response.data;
    final flights = data['flights'] as List<dynamic>? ?? [];
    return flights
        .map((json) => FlightResultModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<HotelResultModel>> searchHotels({
    required String location,
    required String checkIn,
    required String checkOut,
    int adults = 2,
    int rooms = 1,
    String currency = '',
    int minStars = 0,
    String sortBy = 'price',
    int limit = 10,
  }) async {
    final params = <String, dynamic>{
      'location': location,
      'check_in': checkIn,
      'check_out': checkOut,
      'adults': adults,
      'rooms': rooms,
      'sort_by': sortBy,
      'limit': limit,
    };
    if (currency.isNotEmpty) params['currency'] = currency;
    if (minStars > 0) params['min_stars'] = minStars;

    final response = await _dio.get('/api/v1/lifestyle/hotels/search', queryParameters: params);
    final data = response.data;
    final hotels = data['hotels'] as List<dynamic>? ?? [];
    return hotels
        .map((json) => HotelResultModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<TourResultModel>> searchTours({
    required String location,
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
    String category = '',
  }) async {
    final params = <String, dynamic>{
      'location': location,
      'sort_by': sortBy,
      'limit': limit,
    };
    if (currency.isNotEmpty) params['currency'] = currency;
    if (category.isNotEmpty) params['category'] = category;

    final response = await _dio.get('/api/v1/lifestyle/tours/search', queryParameters: params);
    final data = response.data;
    final tours = data['tours'] as List<dynamic>? ?? [];
    return tours
        .map((json) => TourResultModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
