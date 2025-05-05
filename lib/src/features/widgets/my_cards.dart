import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/src/features/widgets/card_details.dart';
import 'package:lazervault/src/features/widgets/card_settings.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [CardDetails(), SizedBox(height: 16.h), CardSettings()]));
  }
}
