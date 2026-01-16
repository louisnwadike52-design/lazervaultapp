// For Int64
// For Timestamp
// For potential date formatting
// Import the entity
import 'package:lazervault/src/features/funds/domain/entities/transfer_entity.dart';

// Correct class name to match usage (Model extends Entity)
class InitiateTransferResponseModel extends TransferEntity {

  // Constructor now calls super
  const InitiateTransferResponseModel({
    required super.transferId,
    required super.status,
    required super.amount, // Minor units
    required super.fee, // Minor units
    required super.totalAmount, // Minor units
    required super.createdAt,
  });

  // Factory constructor to create from gRPC response
  // Note: Use the specific generated proto type if available instead of dynamic
  factory InitiateTransferResponseModel.fromProto(dynamic protoResponse) {
    // Assuming 'protoResponse' is the generated gRPC response object (e.g., pb.InitiateTransferResponse)
    return InitiateTransferResponseModel(
      transferId: protoResponse.transferId,
      status: protoResponse.status,
      amount: protoResponse.amount,
      fee: protoResponse.fee,
      totalAmount: protoResponse.totalAmount,
      // Convert gRPC Timestamp to DateTime
      // Ensure protoResponse.createdAt is a Timestamp object
      createdAt: DateTime.fromMillisecondsSinceEpoch(
        protoResponse.createdAt.seconds.toInt() * 1000 +
            (protoResponse.createdAt.nanos / 1000000).round(),
        isUtc: true,
      ),
    );
  }

  // props getter is inherited from TransferEntity
} 