part of 'split_bill_home_screen.dart';

class SplitBillHomeScreen extends StatelessWidget {
  const SplitBillHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>()..loadIncomingBills(),
      child: const _SplitBillHomeView(),
    );
  }
}

class _SplitBillHomeView extends StatefulWidget {
  const _SplitBillHomeView();

  @override
  State<_SplitBillHomeView> createState() => _SplitBillHomeViewState();
}
