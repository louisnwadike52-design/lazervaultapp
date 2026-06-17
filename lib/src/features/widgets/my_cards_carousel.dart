import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/card_details.dart';
import 'package:overlapped_carousel/overlapped_carousel.dart';

class MyCardsCarousel extends StatelessWidget {
  const MyCardsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtain the screen width
    final double screenWidth = MediaQuery.of(context).size.width;

    // Sample list of card widgets
    final List<Widget> cardWidgets = List.generate(
      5,
      (index) => SizedBox(
        width: screenWidth,
        height: 300.h,
        child: CardDetails(),
      ),
    );

    return OverlappedCarousel(
      widgets: cardWidgets,
      currentIndex: 0,
      onClicked: (index) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Clicked on card ${index + 1}')),
        );
      },
      obscure: 0.4, // Adjust to obscure non-focused cards
      skewAngle: 0.25, // Adjust for the desired skew effect
    );
  }
}
