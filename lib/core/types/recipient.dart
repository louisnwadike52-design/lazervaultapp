import 'package:equatable/equatable.dart';

class Recipient extends Equatable {
  final String? imageUri;
  final String name;
  final String username;
  final int accountNumber;

  const Recipient({
    this.imageUri,
    required this.name,
    required this.username,
    required this.accountNumber,
  });

  @override
  List<Object?> get props => [imageUri, name, username, accountNumber];
}
