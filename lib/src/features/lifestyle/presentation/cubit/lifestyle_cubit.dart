import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/lifestyle/domain/repositories/i_lifestyle_repository.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';

class LifestyleCubit extends Cubit<LifestyleState> {
  final ILifestyleRepository _repository;

  LifestyleCubit(this._repository) : super(LifestyleInitial());

  Future<void> loadCategories({String currency = ''}) async {
    emit(LifestyleLoading());
    try {
      final categories = await _repository.getCategories();

      // Also load cheap flights for the deals section
      List cheapFlights = [];
      try {
        cheapFlights = await _repository.getCheapFlights(
          origin: 'LOS', // Default to Lagos
          currency: currency,
          limit: 5,
        );
      } catch (_) {
        // Non-critical, continue without deals
      }

      emit(LifestyleCategoriesLoaded(
        categories: categories,
        cheapFlights: cheapFlights.cast(),
      ));
    } catch (e) {
      emit(LifestyleError('Failed to load categories: $e'));
    }
  }

  Future<void> searchFlights({
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
    emit(FlightsLoading());
    try {
      final flights = await _repository.searchFlights(
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
      emit(FlightsLoaded(flights: flights));
    } catch (e) {
      emit(LifestyleError('Flight search failed: $e'));
    }
  }

  Future<void> searchHotels({
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
    emit(HotelsLoading());
    try {
      final hotels = await _repository.searchHotels(
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
      emit(HotelsLoaded(hotels: hotels));
    } catch (e) {
      emit(LifestyleError('Hotel search failed: $e'));
    }
  }

  Future<void> searchTours({
    required String location,
    String currency = '',
    String sortBy = 'price',
    int limit = 10,
    String category = '',
  }) async {
    emit(ToursLoading());
    try {
      final tours = await _repository.searchTours(
        location: location,
        currency: currency,
        sortBy: sortBy,
        limit: limit,
        category: category,
      );
      emit(ToursLoaded(tours: tours));
    } catch (e) {
      emit(LifestyleError('Tour search failed: $e'));
    }
  }
}
