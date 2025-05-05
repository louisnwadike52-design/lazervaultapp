import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  /// Empty constructor for testing or default values
  const LoginParams.empty()
      : email = '',
        password = '';

  @override
  List<Object?> get props => [email, password];
} 