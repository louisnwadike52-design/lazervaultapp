import 'package:flutter_contacts/flutter_contacts.dart' as fc;

/// Device contact model representing a contact from the user's phone
///
/// This model is used throughout the app for displaying and selecting
/// contacts from the device's contact list for various operations like
/// sending funds, batch transfers, or selling gift cards.
class DeviceContact {
  /// Unique identifier for the contact
  final String id;

  /// Display name of the contact
  final String name;

  /// Primary phone number (if available)
  final String? phoneNumber;

  /// Email address (if available)
  final String? email;

  /// Display photo/avatar URL or base64 (if available)
  final String? photoUrl;

  /// Initials derived from the contact name (for avatar fallback)
  final String initials;

  /// All available phone numbers for this contact
  final List<String> phoneNumbers;

  /// All available email addresses for this contact
  final List<String> emails;

  const DeviceContact({
    required this.id,
    required this.name,
    this.phoneNumber,
    this.email,
    this.photoUrl,
    required this.initials,
    this.phoneNumbers = const [],
    this.emails = const [],
  });

  /// Creates a DeviceContact from flutter_contacts Contact
  factory DeviceContact.fromFlutterContact(fc.Contact contact) {
    // Extract first phone number
    final phone = contact.phones.isNotEmpty ? contact.phones.first.number : null;

    // Extract first email`
    final emailAddress = contact.emails.isNotEmpty ? contact.emails.first.address : null;

    // Extract all phone numbers
    final allPhones = contact.phones.map((p) => p.number).toList();

    // Extract all emails
    final allEmails = contact.emails.map((e) => e.address).toList();

    // Generate initials from display name
    final initials = _generateInitials(contact.displayName);

    // Get photo if available
    String? photoUrl;
    if (contact.photo != null && contact.photo!.isNotEmpty) {
      // Photo is available as bytes, we'll convert to base64 for display
      photoUrl = 'data:image/png;base64,${_bytesToBase64(contact.photo!)}';
    }

    return DeviceContact(
      id: contact.id,
      name: contact.displayName,
      phoneNumber: phone,
      email: emailAddress,
      photoUrl: photoUrl,
      initials: initials,
      phoneNumbers: allPhones,
      emails: allEmails,
    );
  }

  /// Generates initials from a full name
  static String _generateInitials(String name) {
    if (name.isEmpty) return '?';

    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '?';

    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }

    return (parts[0][0] + parts[parts.length - 1][0]).toUpperCase();
  }

  /// Converts bytes to base64 string
  static String _bytesToBase64(List<int> bytes) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    final result = StringBuffer();

    for (var i = 0; i < bytes.length; i += 3) {
      final b1 = bytes[i];
      final b2 = i + 1 < bytes.length ? bytes[i + 1] : 0;
      final b3 = i + 2 < bytes.length ? bytes[i + 2] : 0;

      final triplet = (b1 << 16) | (b2 << 8) | b3;

      result.write(chars[(triplet >> 18) & 0x3F]);
      result.write(chars[(triplet >> 12) & 0x3F]);
      result.write(i + 1 < bytes.length ? chars[(triplet >> 6) & 0x3F] : '=');
      result.write(i + 2 < bytes.length ? chars[triplet & 0x3F] : '=');
    }

    return result.toString();
  }

  /// Creates a copy with updated fields
  DeviceContact copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? email,
    String? photoUrl,
    String? initials,
    List<String>? phoneNumbers,
    List<String>? emails,
  }) {
    return DeviceContact(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      initials: initials ?? this.initials,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      emails: emails ?? this.emails,
    );
  }

  /// Checks if this contact matches a search query
  bool matchesQuery(String query) {
    final lowerQuery = query.toLowerCase();
    return name.toLowerCase().contains(lowerQuery) ||
           (phoneNumber?.contains(query) ?? false) ||
           (email?.toLowerCase().contains(lowerQuery) ?? false);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeviceContact && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'DeviceContact(id: $id, name: $name, phone: $phoneNumber, email: $email)';
  }
}
