import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/booking_webview_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/tour_result_card.dart';

class TourSearchScreen extends StatefulWidget {
  const TourSearchScreen({super.key});

  @override
  State<TourSearchScreen> createState() => _TourSearchScreenState();
}

class _TourSearchScreenState extends State<TourSearchScreen> {
  final _locationController = TextEditingController();
  bool _showResults = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _search() {
    if (_locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a location'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() => _showResults = true);

    context.read<LifestyleCubit>().searchTours(
      location: _locationController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Tours & Activities', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _locationController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Destination',
                hintText: 'e.g., Lagos, London, Dubai',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: const Icon(Icons.explore, color: Color(0xFF9CA3AF)),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
              ),
              onSubmitted: (_) => _search(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _search,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Search Tours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (_showResults) ...[
              const SizedBox(height: 24),
              BlocBuilder<LifestyleCubit, LifestyleState>(
                builder: (context, state) {
                  if (state is ToursLoading) {
                    return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator(color: Color(0xFF3B82F6))));
                  }
                  if (state is ToursLoaded) {
                    if (state.tours.isEmpty) {
                      return const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No tours found', style: TextStyle(color: Color(0xFF9CA3AF)))));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.tours.length} tours found', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                        const SizedBox(height: 12),
                        ...state.tours.map((tour) => TourResultCard(
                          tour: tour,
                          onBook: () {
                            if (tour.affiliateUrl.isNotEmpty) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => BookingWebViewScreen(url: tour.affiliateUrl, title: tour.title),
                              ));
                            }
                          },
                        )),
                      ],
                    );
                  }
                  if (state is LifestyleError) {
                    return Padding(padding: const EdgeInsets.all(32), child: Center(child: Text(state.message, style: const TextStyle(color: Color(0xFFEF4444)))));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
