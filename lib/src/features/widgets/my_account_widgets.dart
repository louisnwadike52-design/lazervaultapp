part of 'my_account.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    // Use global ProfileCubit - no need to create new instance
    // Profile is already loaded after authentication
    return const _MyAccountView();
  }
}

class _MyAccountView extends StatefulWidget {
  const _MyAccountView();

  @override
  State<_MyAccountView> createState() => _MyAccountViewState();
}
