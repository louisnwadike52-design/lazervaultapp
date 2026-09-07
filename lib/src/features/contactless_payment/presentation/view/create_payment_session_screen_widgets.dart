part of 'create_payment_session_screen.dart';

class CreatePaymentSessionScreen extends StatelessWidget {
  const CreatePaymentSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
        // Realtime session updates — without this the cubit fell back to
        // 1s polling because the DI-registered wsService was bypassed here.
        wsService: GetIt.instance<ContactlessWebSocketService>(),
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
