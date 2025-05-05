import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazervault/core/services/injection_container.dart'; 

// Import AI Chat Cubit 
import '../../cubit/ai_chat_cubit.dart';
// Import the content widget
import '../widgets/ai_chat_content.dart'; 

// No longer needs Get, ImagePicker, dart:io, Auth Cubit/State, entity, or local ChatMessage

// Can potentially be StatelessWidget now, unless other screen-level state is needed
class AiChats extends StatelessWidget { 
  const AiChats({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide the Cubit using GetIt instance factory
    return BlocProvider(
      // Cubit instance is created here and available to AiChatContent
      create: (_) => serviceLocator<AIChatCubit>(), 
      child: const AiChatContent(), // Display the content widget
    );
  }
}

// Remove the large _AiChatsState class and local ChatMessage definition
