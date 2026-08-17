part of 'pay_split_bill_screen.dart';

class PaySplitBillScreen extends StatelessWidget {
  const PaySplitBillScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<SplitBillCubit>(),
      child: const _PaySplitBillView(),
    );
  }
}

class _PaySplitBillView extends StatefulWidget {
  const _PaySplitBillView();

  @override
  State<_PaySplitBillView> createState() => _PaySplitBillViewState();
}
