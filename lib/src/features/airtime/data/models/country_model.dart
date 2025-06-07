import '../../domain/entities/country.dart';

class CountryModel extends Country {
  const CountryModel({
    required super.id,
    required super.name,
    required super.code,
    required super.dialCode,
    required super.flag,
    required super.currency,
    required super.currencySymbol,
    super.isActive,
    super.popularPrefixes,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      id: json['id'] as String? ?? json['code'] as String,
      name: json['name'] as String,
      code: json['code'] as String,
      dialCode: json['dialCode'] as String,
      flag: json['flag'] as String,
      currency: json['currency'] as String,
      currencySymbol: json['currencySymbol'] as String,
      isActive: json['isActive'] as bool? ?? true,
      popularPrefixes: List<String>.from(json['popularPrefixes'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'flag': flag,
      'dialCode': dialCode,
      'currency': currency,
      'currencySymbol': currencySymbol,
      'popularPrefixes': popularPrefixes,
      'isActive': isActive,
    };
  }

  @override
  CountryModel copyWith({
    String? id,
    String? name,
    String? code,
    String? dialCode,
    String? flag,
    String? currency,
    String? currencySymbol,
    bool? isActive,
    List<String>? popularPrefixes,
  }) {
    return CountryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
      flag: flag ?? this.flag,
      currency: currency ?? this.currency,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      isActive: isActive ?? this.isActive,
      popularPrefixes: popularPrefixes ?? this.popularPrefixes,
    );
  }
} 