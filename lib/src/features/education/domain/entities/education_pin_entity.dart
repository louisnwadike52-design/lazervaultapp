import 'package:equatable/equatable.dart';

class EducationPinEntity extends Equatable {
  final String pin;
  final String serial;
  final String expiresAt;

  const EducationPinEntity({
    required this.pin,
    required this.serial,
    required this.expiresAt,
  });

  @override
  List<Object?> get props => [pin, serial, expiresAt];
}
