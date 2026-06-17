import 'package:flutter/material.dart';
import 'package:lazervault/core/types/app_routes.dart';
import 'package:lazervault/src/features/widgets/add_card_form.dart';
import 'package:lazervault/src/features/widgets/card_details.dart';
import 'package:get/get.dart';

class NewCard extends StatefulWidget {
  const NewCard({super.key});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 16.0,
        ),
        child: SizedBox(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [CardDetails(isNewCard: true), AddCardForm()],
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white),
                    onPressed: () {
                      // Navigate to virtual card creation form
                      Get.toNamed(
                        AppRoutes.cardCreationForm,
                        arguments: {
                          'cardType': 'virtual',
                        },
                      );
                    },
                    child: Text("Add Virtual Card"))
              ]),
        ));
  }
}
