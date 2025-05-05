import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/types/electricity_bill_details.dart';
import 'package:lazervault/core/types/screen.dart';
import 'package:lazervault/src/features/widgets/review_electricity_bill_payment.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart';

class ReviewElectricityBillsScreen extends StatefulWidget {
  const ReviewElectricityBillsScreen(
      {super.key, required this.electricityBillDetails});

  final ElectricityBillDetails electricityBillDetails;

  @override
  State<ReviewElectricityBillsScreen> createState() =>
      _ReviewElectricityBillsScreenState();
}

class _ReviewElectricityBillsScreenState
    extends State<ReviewElectricityBillsScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is UserCreated) {
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Get.back();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("No route to go back.")),
                  );
                }
              },
            ),
            title: Text(ScreenName.reviewElectricityBills.displayName),
            centerTitle: true,
          ),
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  ? ReviewElectricityBillPayment(
                      electricityBillDetails: widget.electricityBillDetails)
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
