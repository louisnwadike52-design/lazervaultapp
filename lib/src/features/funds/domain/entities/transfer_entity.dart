import 'package:equatable/equatable.dart';
import 'package:fixnum/fixnum.dart'; // For Int64

class TransferEntity extends Equatable {
  final String transferId;  // Changed to String for UUID support
  final String status;
  final Int64 amount; // Minor units
  final Int64 fee; // Minor units
  final Int64 totalAmount; // Minor units
  final DateTime createdAt;

  const TransferEntity({
    required this.transferId,
    required this.status,
    required this.amount,
    required this.fee,
    required this.totalAmount,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        transferId,
        status,
        amount,
        fee,
        totalAmount,
        createdAt,
      ];
}
