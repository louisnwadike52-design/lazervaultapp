import 'package:equatable/equatable.dart';

class CountryRewardConfigEntity extends Equatable {
  final int id;
  final String countryCode;
  final String currency;
  final int referrerReward;
  final int refereeReward;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CountryRewardConfigEntity({
    required this.id,
    required this.countryCode,
    required this.currency,
    required this.referrerReward,
    required this.refereeReward,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  CountryRewardConfigEntity copyWith({
    int? id,
    String? countryCode,
    String? currency,
    int? referrerReward,
    int? refereeReward,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CountryRewardConfigEntity(
      id: id ?? this.id,
      countryCode: countryCode ?? this.countryCode,
      currency: currency ?? this.currency,
      referrerReward: referrerReward ?? this.referrerReward,
      refereeReward: refereeReward ?? this.refereeReward,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        countryCode,
        currency,
        referrerReward,
        refereeReward,
        isActive,
        createdAt,
        updatedAt,
      ];

  @override
  String toString() {
    return 'CountryRewardConfigEntity(id: $id, countryCode: $countryCode, currency: $currency, referrerReward: $referrerReward, refereeReward: $refereeReward, isActive: $isActive)';
  }
}
