import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/insurance_service.dart';
import '../cubit/insurance_cubit.dart';

class InsuranceProvider extends StatelessWidget {
  final Widget child;
  final String userId;

  const InsuranceProvider({
    super.key,
    required this.child,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InsuranceCubit>(
      create: (context) => InsuranceService.getCubit(userId),
      child: child,
    );
  }
}

class InsuranceMultiProvider extends StatelessWidget {
  final Widget child;
  final String userId;

  const InsuranceMultiProvider({
    super.key,
    required this.child,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InsuranceCubit>(
          create: (context) => InsuranceService.getCubit(userId),
        ),
      ],
      child: child,
    );
  }
} 