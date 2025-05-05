import 'package:flutter/material.dart';
// Import for SystemUiOverlayStyle
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/extensions/app_colors.dart';
import 'package:lazervault/src/features/authentication/domain/entities/user.dart';
import 'package:lazervault/src/features/widgets/send_fund.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_state.dart';
import 'package:lazervault/src/features/widgets/loading_column.dart';

class SendFundScreen extends StatefulWidget {
  const SendFundScreen({super.key, required this.recipient});

  final User recipient;

  @override
  State<SendFundScreen> createState() => _SendFundScreenState();
}

class _SendFundScreenState extends State<SendFundScreen> {

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
      
          body: state is GettingUsers
              ? const LoadingColumn(message: "Fetching Users")
              : state is UsersLoaded
                  ? Column(
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0.h),
                          color: AppColors.backgroundColor,
                          child: SafeArea(
                            child: SendFund(recipient: widget.recipient),
                          ),
                        )),
                      ],
                    )
                  : const SizedBox.shrink(),
        );
      },
    );
  }
}
