import 'package:flutter/material.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/widgets/flights/flights.dart';

class FlightsScreen extends StatefulWidget {
  const FlightsScreen({super.key});

  @override
  State<FlightsScreen> createState() => _FlightsScreenState();
}

    class _FlightsScreenState extends State<FlightsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:   AppColors.backgroundColor,
          body:  SafeArea(child:Flights()) 
    );
    }
} 