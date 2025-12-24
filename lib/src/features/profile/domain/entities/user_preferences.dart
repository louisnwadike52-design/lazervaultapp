import 'package:equatable/equatable.dart';

class UserPreferences extends Equatable {
  final String userId;
  final bool pushNotifications;
  final bool emailNotifications;
  final bool smsNotifications;
  final bool darkMode;
  final String language;
  final String currency;
  final String country;
  final List<String> preferredCountries;
  final String activeCountry;

  const UserPreferences({
    required this.userId,
    this.pushNotifications = true,
    this.emailNotifications = true,
    this.smsNotifications = false,
    this.darkMode = false,
    this.language = 'en',
    this.currency = 'GBP',
    this.country = 'United Kingdom',
    this.preferredCountries = const [],
    this.activeCountry = '',
  });

  @override
  List<Object?> get props => [
        userId,
        pushNotifications,
        emailNotifications,
        smsNotifications,
        darkMode,
        language,
        currency,
        country,
        preferredCountries,
        activeCountry,
      ];

  UserPreferences copyWith({
    String? userId,
    bool? pushNotifications,
    bool? emailNotifications,
    bool? smsNotifications,
    bool? darkMode,
    String? language,
    String? currency,
    String? country,
    List<String>? preferredCountries,
    String? activeCountry,
  }) {
    return UserPreferences(
      userId: userId ?? this.userId,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
      smsNotifications: smsNotifications ?? this.smsNotifications,
      darkMode: darkMode ?? this.darkMode,
      language: language ?? this.language,
      currency: currency ?? this.currency,
      country: country ?? this.country,
      preferredCountries: preferredCountries ?? this.preferredCountries,
      activeCountry: activeCountry ?? this.activeCountry,
    );
  }
}
