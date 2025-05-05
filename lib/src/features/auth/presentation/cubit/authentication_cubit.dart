import 'package:flutter_bloc/flutter_bloc.dart';

class Session {
  final String accessToken;
  final String refreshToken;

  const Session({
    required this.accessToken,
    required this.refreshToken,
  });
}

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final Session session;

  Authenticated({required this.session});
}

class Unauthenticated extends AuthenticationState {}

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(AuthenticationInitial());

  void login(String accessToken, String refreshToken) {
    emit(Authenticated(
      session: Session(
        accessToken: accessToken,
        refreshToken: refreshToken,
      ),
    ));
  }

  void logout() {
    emit(Unauthenticated());
  }
} 