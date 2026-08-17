part of 'nfc_reader_screen.dart';

class NfcReaderScreen extends StatelessWidget {
  const NfcReaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactlessPaymentCubit(
        repository: GetIt.instance<ContactlessPaymentRepository>(),
      ),
      child: const _NfcReaderView(),
    );
  }
}

class _NfcReaderView extends StatefulWidget {
  const _NfcReaderView();

  @override
  State<_NfcReaderView> createState() => _NfcReaderViewState();
}
