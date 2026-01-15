import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart';
import '../../cubit/general_chat_cubit.dart';
import '../widgets/general_chat_content.dart';

/// General Chat Screen - Accessed from Bottom Nav
///
/// This screen flows through the Chat Agent Gateway which:
/// - Uses LLM to intelligently route to appropriate service
/// - Maintains conversation state across services
/// - Allows multi-service conversations in one session
///
/// Example conversation flow:
/// User: "What's my balance?" → Gateway routes to Accounts agent
/// User: "Create an insurance policy" → Gateway routes to Financial Products agent
class GeneralChatScreen extends StatelessWidget {
  const GeneralChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<GeneralChatCubit>()..initializeChat(),
      child: const GeneralChatContent(),
    );
  }
}
