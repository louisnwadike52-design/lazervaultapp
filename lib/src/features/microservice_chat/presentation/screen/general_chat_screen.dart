import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../cubit/chat_sessions_cubit.dart';
import '../../cubit/general_chat_cubit.dart';
import '../widgets/general_chat_content.dart';

/// General Chat Screen - Accessed from Bottom Nav
///
/// Flows through the Chat Agent Gateway which:
/// - Uses LLM to intelligently route to appropriate service
/// - Maintains conversation state across services
/// - Allows multi-service conversations in one session
///
/// ChatGPT-style multi-tab UX:
/// - Left drawer lists all chat sessions (newest first)
/// - "+ New chat" creates a fresh session and switches to it
/// - Long-press a row to Rename / Delete
/// - Current session id persisted in SecureStorage so app relaunches
///   land back on the same conversation
class GeneralChatScreen extends StatelessWidget {
  const GeneralChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Drawer + session-list state. `initialize()` restores the
        // last-active session id and pulls the drawer list.
        BlocProvider<ChatSessionsCubit>(
          create: (_) => serviceLocator<ChatSessionsCubit>()..initialize(),
        ),
        // Chat-content cubit. `initializeChat()` subscribes to the
        // session manager's currentSessionIdStream, so it auto-reloads
        // when the drawer switches tabs.
        BlocProvider<GeneralChatCubit>(
          create: (_) => serviceLocator<GeneralChatCubit>()
            ..initializeChat()
            ..loadHistory(),
        ),
      ],
      child: const GeneralChatContent(),
    );
  }
}
