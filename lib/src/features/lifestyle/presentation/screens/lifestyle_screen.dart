import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/lifestyle/domain/entities/lifestyle_category.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/flight_search_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/hotel_search_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/tour_search_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/category_card.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/flight_result_card.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/booking_webview_screen.dart';

class NewLifestyleScreen extends StatefulWidget {
  const NewLifestyleScreen({super.key});

  @override
  State<NewLifestyleScreen> createState() => _NewLifestyleScreenState();
}

class _NewLifestyleScreenState extends State<NewLifestyleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LifestyleCubit>().loadCategories();
  }

  Future<void> _refresh() async {
    await context.read<LifestyleCubit>().loadCategories();
  }

  void _onCategoryTap(LifestyleCategory category) {
    switch (category.id) {
      case 'flights':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: context.read<LifestyleCubit>(),
            child: const FlightSearchScreen(),
          )),
        );
      case 'hotels':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: context.read<LifestyleCubit>(),
            child: const HotelSearchScreen(),
          )),
        );
      case 'tours':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => BlocProvider.value(
            value: context.read<LifestyleCubit>(),
            child: const TourSearchScreen(),
          )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Lifestyle',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocConsumer<LifestyleCubit, LifestyleState>(
        listener: (context, state) {
          if (state is LifestyleError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is LifestyleLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
            );
          }

          if (state is LifestyleCategoriesLoaded) {
            return RefreshIndicator(
              onRefresh: _refresh,
              color: const Color(0xFF3B82F6),
              backgroundColor: const Color(0xFF1F1F1F),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                children: [
                  // Categories grid
                  const Text(
                    'Explore',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.9,
                    children: state.categories.map((cat) => CategoryCard(
                      category: cat,
                      onTap: () => _onCategoryTap(cat),
                    )).toList(),
                  ),

                  // Popular deals section
                  if (state.cheapFlights.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Popular Deals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Cheap flights from Lagos',
                      style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    ...state.cheapFlights.map((flight) => FlightResultCard(
                      flight: flight,
                      onBook: () {
                        if (flight.affiliateUrl.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BookingWebViewScreen(
                                url: flight.affiliateUrl,
                                title: '${flight.origin} to ${flight.destination}',
                              ),
                            ),
                          );
                        }
                      },
                    )),
                  ],
                ],
              ),
            );
          }

          // Initial/error state - show empty with pull to refresh
          return RefreshIndicator(
            onRefresh: _refresh,
            color: const Color(0xFF3B82F6),
            backgroundColor: const Color(0xFF1F1F1F),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.explore, size: 64, color: Color(0xFF9CA3AF)),
                        SizedBox(height: 16),
                        Text(
                          'Explore Travel & Lifestyle',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Pull down to refresh',
                          style: TextStyle(color: Color(0xFF9CA3AF)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
