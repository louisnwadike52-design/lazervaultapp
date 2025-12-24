import 'dart:async';
import 'package:flutter_contacts/flutter_contacts.dart' as fc;
import 'package:permission_handler/permission_handler.dart';
import '../models/device_contact.dart';

/// Service for managing device contacts
///
/// Handles permission requests, contact loading, searching, and caching
/// for efficient contact access throughout the app.
class ContactService {
  static final ContactService _instance = ContactService._internal();
  factory ContactService() => _instance;
  ContactService._internal();

  /// Cached contacts to avoid repeated permission requests and loading
  List<DeviceContact>? _cachedContacts;

  /// Timestamp of last contact load
  DateTime? _lastLoadTime;

  /// Cache duration before reload (30 minutes)
  static const _cacheDuration = Duration(minutes: 30);

  /// Checks if contact permission is granted
  Future<bool> hasPermission() async {
    final status = await Permission.contacts.status;
    return status.isGranted;
  }

  /// Requests contact permission from the user
  ///
  /// Returns true if permission is granted, false otherwise
  Future<bool> requestPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  /// Gets all contacts from the device
  ///
  /// This method will:
  /// 1. Check if permission is granted (request if not)
  /// 2. Return cached contacts if available and fresh
  /// 3. Load contacts from device if cache is stale or empty
  ///
  /// Returns empty list if permission is denied or on error
  Future<List<DeviceContact>> getContacts({
    bool forceReload = false,
  }) async {
    // Check permission
    try {
      final hasPermission = await this.hasPermission();
      if (!hasPermission) {
        final granted = await requestPermission();
        if (!granted) {
          print('[ContactService] Permission denied');
          return [];
        }
      }
    } catch (e) {
      print('[ContactService] Error checking permission: $e');
      return [];
    }

    // Check cache
    if (!forceReload && _cachedContacts != null && _lastLoadTime != null) {
      final cacheAge = DateTime.now().difference(_lastLoadTime!);
      if (cacheAge < _cacheDuration) {
        return _cachedContacts!;
      }
    }

    // Load contacts from device with timeout
    try {
      final flutterContacts = await fc.FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          print('[ContactService] Contact loading timed out');
          throw TimeoutException('Contact loading timed out');
        },
      );

      // Validate and convert to DeviceContact model
      final validContacts = <DeviceContact>[];
      for (final contact in flutterContacts) {
        try {
          final deviceContact = DeviceContact.fromFlutterContact(contact);
          // Only include contacts with names
          if (deviceContact.name.trim().isNotEmpty) {
            validContacts.add(deviceContact);
          }
        } catch (e) {
          // Skip invalid contacts
          print('[ContactService] Skipping invalid contact: $e');
          continue;
        }
      }

      // Check for empty result
      if (validContacts.isEmpty) {
        print('[ContactService] No valid contacts found');
        _cachedContacts = [];
        _lastLoadTime = DateTime.now();
        return [];
      }

      // Sort by name (case-insensitive)
      validContacts.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

      // Limit cache size for memory efficiency (max 5000 contacts)
      if (validContacts.length > 5000) {
        print('[ContactService] Warning: Large contact list (${validContacts.length}), caching first 5000');
        _cachedContacts = validContacts.take(5000).toList();
      } else {
        _cachedContacts = validContacts;
      }

      _lastLoadTime = DateTime.now();

      return _cachedContacts!;
    } on TimeoutException catch (e) {
      print('[ContactService] Timeout loading contacts: $e');
      // Return cached contacts if available, even if stale
      return _cachedContacts ?? [];
    } catch (e) {
      print('[ContactService] Error loading contacts: $e');
      // Return cached contacts if available, even if stale
      return _cachedContacts ?? [];
    }
  }

  /// Searches contacts by name, phone number, or email
  ///
  /// Returns all contacts if query is empty
  Future<List<DeviceContact>> searchContacts(String query) async {
    try {
      if (query.trim().isEmpty) {
        return getContacts();
      }

      final allContacts = await getContacts();

      // Handle case where no contacts are available
      if (allContacts.isEmpty) {
        return [];
      }

      final results = allContacts.where((contact) => contact.matchesQuery(query)).toList();
      return results;
    } catch (e) {
      print('[ContactService] Error searching contacts: $e');
      return [];
    }
  }

  /// Gets a single contact by ID
  Future<DeviceContact?> getContactById(String id) async {
    try {
      if (id.trim().isEmpty) {
        return null;
      }

      final contacts = await getContacts();

      if (contacts.isEmpty) {
        return null;
      }

      return contacts.firstWhere(
        (contact) => contact.id == id,
        orElse: () => throw Exception('Contact not found'),
      );
    } catch (e) {
      print('[ContactService] Error getting contact by ID: $e');
      return null;
    }
  }

  /// Gets contacts that have phone numbers
  ///
  /// Useful for features that require a phone number (like sending SMS or calling)
  Future<List<DeviceContact>> getContactsWithPhone() async {
    final contacts = await getContacts();
    return contacts.where((contact) => contact.phoneNumber != null && contact.phoneNumber!.isNotEmpty).toList();
  }

  /// Gets contacts that have email addresses
  ///
  /// Useful for features that require an email
  Future<List<DeviceContact>> getContactsWithEmail() async {
    final contacts = await getContacts();
    return contacts.where((contact) => contact.email != null && contact.email!.isNotEmpty).toList();
  }

  /// Clears the contact cache
  ///
  /// Use this when you want to force a fresh load of contacts
  void clearCache() {
    _cachedContacts = null;
    _lastLoadTime = null;
  }

  /// Opens the device's contact picker
  ///
  /// Returns the selected contact, or null if cancelled or on error
  Future<DeviceContact?> pickContact() async {
    try {
      final hasPermission = await this.hasPermission();
      if (!hasPermission) {
        final granted = await requestPermission();
        if (!granted) {
          print('[ContactService] Permission denied for contact picker');
          return null;
        }
      }

      final contact = await fc.FlutterContacts.openExternalPick().timeout(
        const Duration(seconds: 60),
        onTimeout: () {
          print('[ContactService] Contact picker timed out');
          return null;
        },
      );

      if (contact == null) {
        print('[ContactService] No contact selected');
        return null;
      }

      // Load full contact details with timeout
      final fullContact = await fc.FlutterContacts.getContact(contact.id).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('[ContactService] Loading contact details timed out');
          return null;
        },
      );

      if (fullContact == null) {
        print('[ContactService] Could not load full contact details');
        return null;
      }

      return DeviceContact.fromFlutterContact(fullContact);
    } catch (e) {
      print('[ContactService] Error picking contact: $e');
      return null;
    }
  }

  /// Gets the permission status
  ///
  /// Useful for showing permission rationale before requesting
  Future<PermissionStatus> getPermissionStatus() async {
    return await Permission.contacts.status;
  }

  /// Opens the app settings if permission is permanently denied
  Future<bool> openSettings() async {
    return await openAppSettings();
  }

  /// Gets contact count without loading all contacts
  ///
  /// More efficient than loading all contacts just to check the count
  Future<int> getContactCount() async {
    if (_cachedContacts != null) {
      return _cachedContacts!.length;
    }

    // If not cached, we need to load them
    final contacts = await getContacts();
    return contacts.length;
  }

  /// Checks if the app has never requested contact permission
  Future<bool> isFirstTimeRequest() async {
    final status = await Permission.contacts.status;
    return !status.isGranted && !status.isDenied && !status.isPermanentlyDenied;
  }
}
