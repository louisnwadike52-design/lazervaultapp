import 'package:equatable/equatable.dart';
import './user.dart'; // Corrected import
import './session_entity.dart';

class ProfileEntity extends Equatable {
  final User user; // Use the correct User class
  final SessionEntity session;

  const ProfileEntity({
    required this.user,
    required this.session,
  });

  @override
  List<Object?> get props => [user, session];
} 