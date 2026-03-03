import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';
import '../../cubit/microservice_chat_cubit.dart';
import '../../domain/usecases/send_microservice_chat_message_usecase.dart';
import '../widgets/microservice_chat_content.dart';

class MicroserviceChatScreen extends StatelessWidget {
  const MicroserviceChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, String>? ?? {};
    final serviceName = arguments['serviceName'] ?? 'Service';
    final sourceContext = arguments['sourceContext'] ?? 'dashboard';

    // Read auth cubit from the widget tree (the actual authenticated instance),
    // NOT from serviceLocator which creates a new unauthenticated factory instance.
    final authCubit = context.read<AuthenticationCubit>();

    return BlocProvider(
      create: (_) => MicroserviceChatCubit(
        sendMessageUseCase: serviceLocator<SendMicroserviceChatMessageUseCase>(),
        authCubit: authCubit,
        sourceContext: sourceContext,
      )..initializeChat(),
      child: MicroserviceChatContent(
        serviceName: serviceName,
        sourceContext: sourceContext,
      ),
    );
  }
}
