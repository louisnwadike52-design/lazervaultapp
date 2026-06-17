import 'package:lazervault/src/features/profile/domain/entities/user_preferences.dart';
import 'package:lazervault/src/generated/user.pb.dart' as user_pb;

class UserPreferencesModel extends UserPreferences {
  const UserPreferencesModel({
    required super.userId,
    super.pushNotifications,
    super.emailNotifications,
    super.smsNotifications,
    super.darkMode,
    super.language,
    super.currency,
    super.country,
    super.preferredCountries,
    super.activeCountry,
  });

  factory UserPreferencesModel.fromProto(user_pb.UserPreferences proto) {
    return UserPreferencesModel(
      userId: proto.userId,
      pushNotifications: proto.pushNotifications,
      emailNotifications: proto.emailNotifications,
      smsNotifications: proto.smsNotifications,
      darkMode: proto.darkMode,
      language: proto.language.isNotEmpty ? proto.language : 'en',
      currency: proto.currency.isNotEmpty ? proto.currency : 'GBP',
      country: proto.country.isNotEmpty ? proto.country : 'United Kingdom',
      preferredCountries: proto.preferredCountries.toList(),
      activeCountry: proto.activeCountry.isNotEmpty ? proto.activeCountry : '',
    );
  }

  user_pb.UserPreferences toProto() {
    return user_pb.UserPreferences(
      userId: userId,
      pushNotifications: pushNotifications,
      emailNotifications: emailNotifications,
      smsNotifications: smsNotifications,
      darkMode: darkMode,
      language: language,
      currency: currency,
      country: country,
      preferredCountries: preferredCountries,
      activeCountry: activeCountry,
    );
  }
}
