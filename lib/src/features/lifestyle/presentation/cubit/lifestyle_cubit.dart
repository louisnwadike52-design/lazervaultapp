import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/flight_result.dart';
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
      List<FlightResult> cheapFlights = [];
      try {
        cheapFlights = await _repository.getCheapFlights(
          origin: 'LOS', // Default to Lagos
          currency: currency,
          limit: 5,
        );
      } catch (_) {
        // Non-critical, continue without deals
      }

      if (isClosed) return;
      emit(LifestyleCategoriesLoaded(
        categories: categories,
        cheapFlights: cheapFlights,
      ));
    } catch (e) {
      if (isClosed) return;
      emit(LifestyleError(_cleanErrorMessage(e)));
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
      if (isClosed) return;
      emit(FlightsLoaded(flights: flights));
    } catch (e) {
      if (isClosed) return;
      emit(LifestyleError(_cleanErrorMessage(e)));
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
      if (isClosed) return;
      emit(HotelsLoaded(hotels: hotels));
    } catch (e) {
      if (isClosed) return;
      emit(LifestyleError(_cleanErrorMessage(e)));
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
      if (isClosed) return;
      emit(ToursLoaded(tours: tours));
    } catch (e) {
      if (isClosed) return;
      emit(LifestyleError(_cleanErrorMessage(e)));
    }
  }

  String _cleanErrorMessage(Object e) {
    var msg = e.toString();
    // Strip "Exception: " prefix from Dart exceptions
    if (msg.startsWith('Exception: ')) {
      msg = msg.substring(11);
    }
    // Truncate overly long error messages to prevent UI overflow
    if (msg.length > 150) {
      msg = '${msg.substring(0, 147)}...';
    }
    return msg;
  }
}
