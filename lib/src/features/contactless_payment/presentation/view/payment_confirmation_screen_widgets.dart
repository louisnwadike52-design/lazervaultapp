part of 'payment_confirmation_screen.dart';

class PaymentConfirmationScreen extends StatelessWidget {
  final PaymentSessionEntity session;

  const PaymentConfirmationScreen({
    super.key,
    required this.session,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      )..acknowledgeSessionRead(session.id),
      child: _PaymentConfirmationView(session: session),
    );
  }
}

class _PaymentConfirmationView extends StatefulWidget {
  final PaymentSessionEntity session;

  const _PaymentConfirmationView({required this.session});

  @override
  State<_PaymentConfirmationView> createState() =>
      _PaymentConfirmationViewState();
}
