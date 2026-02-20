import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_cubit.dart';
import 'package:lazervault/src/features/lifestyle/presentation/cubit/lifestyle_state.dart';
import 'package:lazervault/src/features/lifestyle/presentation/screens/booking_webview_screen.dart';
import 'package:lazervault/src/features/lifestyle/presentation/widgets/flight_result_card.dart';

class FlightSearchScreen extends StatefulWidget {
  const FlightSearchScreen({super.key});

  @override
  State<FlightSearchScreen> createState() => _FlightSearchScreenState();
}

class _FlightSearchScreenState extends State<FlightSearchScreen> {
  final _originController = TextEditingController();
  final _destController = TextEditingController();
  DateTime? _departDate;
  DateTime? _returnDate;
  int _adults = 1;
  String _cabinClass = 'economy';
  bool _showResults = false;

  @override
  void dispose() {
    _originController.dispose();
    _destController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isDeparture) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF3B82F6),
              surface: Color(0xFF1F1F1F),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isDeparture) {
          _departDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _search() {
    if (_originController.text.isEmpty || _destController.text.isEmpty || _departDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in origin, destination, and departure date'),
          backgroundColor: Color(0xFFEF4444),
        ),
      );
      return;
    }

    setState(() => _showResults = true);

    context.read<LifestyleCubit>().searchFlights(
      origin: _originController.text.trim().toUpperCase(),
      destination: _destController.text.trim().toUpperCase(),
      departDate: DateFormat('yyyy-MM-dd').format(_departDate!),
      returnDate: _returnDate != null ? DateFormat('yyyy-MM-dd').format(_returnDate!) : '',
      adults: _adults,
      cabinClass: _cabinClass,
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
        title: const Text('Search Flights', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search form
            _buildTextField(_originController, 'Origin (IATA)', 'e.g., LOS'),
            const SizedBox(height: 12),
            _buildTextField(_destController, 'Destination (IATA)', 'e.g., LHR'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildDatePicker('Departure', _departDate, () => _selectDate(context, true))),
                const SizedBox(width: 12),
                Expanded(child: _buildDatePicker('Return', _returnDate, () => _selectDate(context, false))),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildDropdown('Cabin', _cabinClass, ['economy', 'business', 'first'], (v) {
                    setState(() => _cabinClass = v!);
                  }),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildDropdown('Adults', _adults.toString(), ['1', '2', '3', '4'], (v) {
                    setState(() => _adults = int.parse(v!));
                  }),
                ),
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
                child: const Text('Search Flights', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              ),
            ),

            // Results
            if (_showResults) ...[
              const SizedBox(height: 24),
              BlocBuilder<LifestyleCubit, LifestyleState>(
                builder: (context, state) {
                  if (state is FlightsLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(color: Color(0xFF3B82F6)),
                      ),
                    );
                  }
                  if (state is FlightsLoaded) {
                    if (state.flights.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text('No flights found', style: TextStyle(color: Color(0xFF9CA3AF))),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.flights.length} flights found',
                          style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        ...state.flights.map((flight) => FlightResultCard(
                          flight: flight,
                          onBook: () {
                            if (flight.affiliateUrl.isNotEmpty) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (_) => BookingWebViewScreen(
                                  url: flight.affiliateUrl,
                                  title: '${flight.airline} - ${flight.origin} to ${flight.destination}',
                                ),
                              ));
                            }
                          },
                        )),
                      ],
                    );
                  }
                  if (state is LifestyleError) {
                    return Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Text(state.message, style: const TextStyle(color: Color(0xFFEF4444))),
                      ),
                    );
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

  Widget _buildTextField(TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: Color(0xFF9CA3AF)),
        hintStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF3B82F6)),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? date, VoidCallback onTap) {
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
              date != null ? DateFormat('MMM d, yyyy').format(date) : label,
              style: TextStyle(
                color: date != null ? Colors.white : const Color(0xFF9CA3AF),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          style: const TextStyle(color: Colors.white, fontSize: 14),
          items: items.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item[0].toUpperCase() + item.substring(1)),
          )).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
