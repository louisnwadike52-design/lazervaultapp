import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/booking_webview_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/hotel_result_card.dart';

class HotelSearchScreen extends StatefulWidget {
  const HotelSearchScreen({super.key});

  @override
  State<HotelSearchScreen> createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  final _locationController = TextEditingController();
  DateTime? _checkIn;
  DateTime? _checkOut;
  int _adults = 2;
  int _rooms = 1;
  bool _showResults = false;

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: isCheckIn ? 7 : 10)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(primary: Color(0xFF3B82F6), surface: Color(0xFF1F1F1F)),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          _checkIn = picked;
        } else {
          _checkOut = picked;
        }
      });
    }
  }

  void _search() {
    if (_locationController.text.isEmpty || _checkIn == null || _checkOut == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in location, check-in, and check-out dates'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() => _showResults = true);

    context.read<LifestyleCubit>().searchHotels(
      location: _locationController.text.trim(),
      checkIn: DateFormat('yyyy-MM-dd').format(_checkIn!),
      checkOut: DateFormat('yyyy-MM-dd').format(_checkOut!),
      adults: _adults,
      rooms: _rooms,
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
        title: const Text('Search Hotels', style: TextStyle(color: Colors.white)),
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
                labelText: 'City or Location',
                hintText: 'e.g., London, Dubai, Lagos',
                labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: const Icon(Icons.location_on, color: Color(0xFF9CA3AF)),
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2D2D2D))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildDateTile('Check-in', _checkIn, () => _selectDate(context, true))),
                const SizedBox(width: 12),
                Expanded(child: _buildDateTile('Check-out', _checkOut, () => _selectDate(context, false))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildCounter('Adults', _adults, (v) => setState(() => _adults = v))),
                const SizedBox(width: 12),
                Expanded(child: _buildCounter('Rooms', _rooms, (v) => setState(() => _rooms = v))),
              ],
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
                child: const Text('Search Hotels', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),
            if (_showResults) ...[
              const SizedBox(height: 24),
              BlocBuilder<LifestyleCubit, LifestyleState>(
                builder: (context, state) {
                  if (state is HotelsLoading) {
                    return const Center(child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator(color: Color(0xFF3B82F6))));
                  }
                  if (state is HotelsLoaded) {
                    if (state.hotels.isEmpty) {
                      return const Padding(padding: EdgeInsets.all(32), child: Center(child: Text('No hotels found', style: TextStyle(color: Color(0xFF9CA3AF)))));
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${state.hotels.length} hotels found', style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                        const SizedBox(height: 12),
                        ...state.hotels.map((hotel) => HotelResultCard(
                          hotel: hotel,
                          onBook: () {
                            if (hotel.affiliateUrl.isNotEmpty) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => BookingWebViewScreen(url: hotel.affiliateUrl, title: hotel.hotelName),
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

  Widget _buildDateTile(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1F1F1F),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF2D2D2D)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Color(0xFF9CA3AF)),
            const SizedBox(width: 8),
            Text(
              date != null ? DateFormat('MMM d').format(date) : label,
              style: TextStyle(color: date != null ? Colors.white : const Color(0xFF9CA3AF), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounter(String label, int value, ValueChanged<int> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          Row(
            children: [
              IconButton(
                onPressed: value > 1 ? () => onChanged(value - 1) : null,
                icon: const Icon(Icons.remove_circle_outline, size: 20),
                color: const Color(0xFF9CA3AF),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('$value', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
              ),
              IconButton(
                onPressed: value < 10 ? () => onChanged(value + 1) : null,
                icon: const Icon(Icons.add_circle_outline, size: 20),
                color: const Color(0xFF3B82F6),
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
