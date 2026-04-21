import 'package:equatable/equatable.dart';
import '../../../../../core/utils/pricing_helpers.dart';

class InternetPackageEntity extends Equatable {
  final String id;
  final String name;
  final String variationCode;
  // Raw catalog price from ISP/VTpass. UI should render [displayAmount];
  // the raw value is only used when calling PayInternetBill so VTpass
  // receives the real catalog price.
  final double amount;
  final String providerId;
  final String validity;

  const InternetPackageEntity({
    required this.id,
    required this.name,
    required this.variationCode,
    required this.amount,
    required this.providerId,
    required this.validity,
  });

  /// User-facing amount: catalog price rounded UP to the nearest ₦10.
  /// Mirrors the backend pricing_helpers.PresentationPricing.
  double get displayAmount => roundUpToNearestTen(amount);

  @override
  List<Object?> get props => [id, name, variationCode, amount, providerId, validity];
}
