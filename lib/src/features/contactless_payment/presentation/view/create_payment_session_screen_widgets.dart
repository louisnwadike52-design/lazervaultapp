part of 'create_payment_session_screen.dart';

class CreatePaymentSessionScreen extends StatelessWidget {
  const CreatePaymentSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _CreatePaymentSessionView(),
    );
  }
}

class _CreatePaymentSessionView extends StatefulWidget {
  const _CreatePaymentSessionView();

  @override
  State<_CreatePaymentSessionView> createState() =>
      _CreatePaymentSessionViewState();
}
