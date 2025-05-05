import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utilities/responsive_controller.dart';
import 'package:lazervault/src/features/widgets/build_form_field.dart';

class AddCardForm extends StatefulWidget {
  const AddCardForm({super.key});

  @override
  State<AddCardForm> createState() => _AddCardFormState();
}

class _AddCardFormState extends State<AddCardForm> {
  @override
  Widget build(BuildContext context) {
    final responsiveController = ResponsiveController(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 20.0.h,
        children: [
          BuildFormField(
              name: "cardNumber",
              labelText: "Card Number",
              placeholder: "xxxx-xxxx-xxxx-xxxx"),
          BuildFormField(
              name: "card_holder_name",
              labelText: "Card Holder Name",
              placeholder: "Your Name"),
          SizedBox(
            height: responsiveController.isMobile ? 150.0.h : 200.0.h,
            child: Row(
              spacing: 20.0.w,
              children: [
                Flexible(
                    child: BuildFormField(
                  name: "Exp_date",
                  labelText: "Exp Date",
                  placeholder: "MM/YY",
                  width: 100.0.w,
                )),
                Flexible(
                    child: BuildFormField(
                  name: "cvv",
                  labelText: "Cvv",
                  placeholder: "xxx",
                  width: 100.0.w,
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
