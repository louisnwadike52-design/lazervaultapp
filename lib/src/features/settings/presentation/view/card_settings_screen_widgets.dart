part of 'card_settings_screen.dart';

class CardSettingsScreen extends StatelessWidget {
  const CardSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<CardSettingsCubit>(),
        ),
      ],
      child: const _CardSettingsView(),
    );
  }
}

class _CardSettingsView extends StatefulWidget {
  const _CardSettingsView();

  @override
  State<_CardSettingsView> createState() => _CardSettingsViewState();
}
