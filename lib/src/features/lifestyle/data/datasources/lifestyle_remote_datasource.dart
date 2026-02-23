import 'package:dio/dio.dart';
import 'package:lazervault/src/features/lifestyle/data/models/flight_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/hotel_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/tour_result_model.dart';
import 'package:lazervault/src/features/lifestyle/data/models/lifestyle_category_model.dart';

class LifestyleRemoteDataSource {
  final Dio _dio;

  LifestyleRemoteDataSource(this._dio);

  Future<List<LifestyleCategoryModel>> getCategories() async {
    try {
      final response = await _dio.get('/api/v1/lifestyle/categories');
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];
      final categories = data['categories'] as List<dynamic>? ?? [];
      return categories
          .whereType<Map<String, dynamic>>()
          .map((json) => LifestyleCategoryModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load categories');
    }
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

    try {
      final response = await _dio.get('/api/v1/lifestyle/flights/search', queryParameters: params);
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];
      final flights = data['flights'] as List<dynamic>? ?? [];
      return flights
          .whereType<Map<String, dynamic>>()
          .map((json) => FlightResultModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'search flights');
    }
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

    try {
      final response = await _dio.get('/api/v1/lifestyle/flights/cheap', queryParameters: params);
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];
      final flights = data['flights'] as List<dynamic>? ?? [];
      return flights
          .whereType<Map<String, dynamic>>()
          .map((json) => FlightResultModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'load deals');
    }
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

    try {
      final response = await _dio.get('/api/v1/lifestyle/hotels/search', queryParameters: params);
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];
      final hotels = data['hotels'] as List<dynamic>? ?? [];
      return hotels
          .whereType<Map<String, dynamic>>()
          .map((json) => HotelResultModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'search hotels');
    }
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

    try {
      final response = await _dio.get('/api/v1/lifestyle/tours/search', queryParameters: params);
      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];
      final tours = data['tours'] as List<dynamic>? ?? [];
      return tours
          .whereType<Map<String, dynamic>>()
          .map((json) => TourResultModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw _mapDioError(e, 'search tours');
    }
  }

  /// Maps DioException to a user-friendly exception message.
  Exception _mapDioError(DioException e, String operation) {
    final statusCode = e.response?.statusCode;

    if (statusCode == 401) {
      return Exception('Session expired. Please log in again.');
    }
    if (statusCode == 403) {
      return Exception('You do not have permission to $operation.');
    }
    if (statusCode == 404) {
      return Exception('Service not available. Please try again later.');
    }
    if (statusCode != null && statusCode >= 500) {
      return Exception('Server error. Please try again later.');
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return Exception('Connection timed out. Please check your internet and try again.');
      case DioExceptionType.connectionError:
        return Exception('Unable to connect. Please check your internet connection.');
      default:
        // Extract server error message if available
        final data = e.response?.data;
        if (data is Map && data['error'] != null) {
          return Exception('${data['error']}');
        }
        return Exception('Failed to $operation. Please try again.');
    }
  }
}
