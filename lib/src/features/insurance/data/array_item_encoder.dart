import 'dart:convert';

import '../domain/entities/insurance_product_entity.dart';

/// Default cargo item schema used when a structured-array field ships no
/// `itemFields` (Marine `item_details`, Home Content `items`, etc.). The
/// backend now also sends this explicitly for those fields; this is the
/// client-side fallback so the widget renders identically if it's absent.
const List<InsuranceProductFormItemField> kCargoItemSchema = [
  InsuranceProductFormItemField(
      name: 'name', label: 'Item Name', type: 'text', required: true),
  InsuranceProductFormItemField(
      name: 'value', label: 'Value (NGN)', type: 'monetary', required: true),
  InsuranceProductFormItemField(
      name: 'quantity', label: 'Quantity', type: 'number'),
  InsuranceProductFormItemField(
      name: 'image_url', label: 'Item Photo', type: 'image', required: true),
  // description is required by MyCover (min 5 chars) — mark it required so the
  // UI shows it as mandatory and validation blocks an empty/short entry before
  // the purchase reaches the backend.
  InsuranceProductFormItemField(
      name: 'description', label: 'Description', type: 'text', required: true),
];

/// Minimum per-item rules MyCover enforces on `items` / `item_details`
/// arrays — kept in sync with the backend validator `validateInsuredItems`
/// (financial-products-service `financial_products_handler.go`). Surfacing
/// these client-side stops a purchase that would otherwise fail at the
/// backend with e.g. "item 1: description must be at least 5 characters".
const int kInsuredItemMinValue = 50000; // naira, NOT kobo
const int kInsuredItemMinDescLen = 5;

/// Field keys that carry a MyCover-validated insured-items array.
bool isInsuredItemsField(String fieldName) =>
    fieldName == 'items' || fieldName == 'item_details';

/// Validates the JSON-encoded insured-items array against MyCover's per-item
/// rules, returning a user-friendly message on the FIRST failure or null when
/// every item is valid. Mirrors the backend so the user fixes the entry in the
/// form instead of hitting a rejected purchase after PIN entry.
///
/// Only the cargo-style fields the backend checks are enforced, and only when
/// the item schema actually carries them (so benefit/beneficiary arrays with a
/// different shape are untouched).
String? validateInsuredItems(
    List<InsuranceProductFormItemField> schema, String rawJson) {
  final names = schema.map((s) => s.name).toSet();
  final hasImage = names.contains('image_url');
  final hasDesc = names.contains('description');
  final hasValue = names.contains('value');
  if (!hasImage && !hasDesc && !hasValue) return null;

  List<dynamic> items;
  try {
    final parsed = jsonDecode(rawJson.isEmpty ? '[]' : rawJson);
    if (parsed is! List) return null;
    items = parsed;
  } catch (_) {
    return null; // malformed — let the backend/regex path surface it
  }

  for (var i = 0; i < items.length; i++) {
    final entry = items[i];
    if (entry is! Map) continue;
    final n = i + 1;
    if (hasImage) {
      final img = (entry['image_url'] ?? '').toString().trim();
      if (img.isEmpty) return 'Item $n: add a photo of the item';
    }
    if (hasDesc) {
      final desc = (entry['description'] ?? '').toString().trim();
      if (desc.length < kInsuredItemMinDescLen) {
        return 'Item $n: description must be at least '
            '$kInsuredItemMinDescLen characters';
      }
    }
    if (hasValue) {
      final v = num.tryParse((entry['value'] ?? '').toString());
      if (v == null || v < kInsuredItemMinValue) {
        return 'Item $n: value must be at least '
            '₦${kInsuredItemMinValue.toString()}';
      }
    }
  }
  return null;
}

/// Resolves the per-item schema for a structured-array field: the
/// backend-supplied [InsuranceProductFormField.itemFields] when present,
/// else the cargo default.
List<InsuranceProductFormItemField> itemSchemaFor(
        InsuranceProductFormField field) =>
    field.itemFields.isNotEmpty ? field.itemFields : kCargoItemSchema;

bool _isNumeric(String type) => type == 'number' || type == 'monetary';

/// Encodes structured-array [rows] (each a sub-field-name → string map)
/// into the MyCover-valid JSON array string for the given [schema].
///
/// This is the SINGLE source of truth for the wire shape, shared by the
/// `ArrayFormField` widget and the e2e test so both produce byte-identical
/// payloads. Rules:
///  - Drop a row unless every `required` sub-field is present (and any
///    numeric required sub-field parses) — discards half-filled drafts.
///  - `number`/`monetary` sub-fields are emitted as JSON numbers; a
///    sub-field named `quantity` defaults to 1 when blank.
///  - `text`/`select`/`image` sub-fields are emitted as strings, omitted
///    when empty and not required.
///  - Local-only keys (anything not in [schema], e.g. `_image_filename`)
///    are never emitted.
String encodeArrayItems(
    List<InsuranceProductFormItemField> schema, List<Map<String, String>> rows) {
  final cleaned = <Map<String, Object?>>[];
  for (final row in rows) {
    var keep = true;
    for (final sf in schema) {
      if (!sf.required) continue;
      final v = (row[sf.name] ?? '').trim();
      if (v.isEmpty || (_isNumeric(sf.type) && num.tryParse(v) == null)) {
        keep = false;
        break;
      }
    }
    if (!keep) continue;

    final obj = <String, Object?>{};
    for (final sf in schema) {
      final v = (row[sf.name] ?? '').trim();
      if (_isNumeric(sf.type)) {
        final n = num.tryParse(v);
        if (sf.name == 'quantity') {
          obj[sf.name] = (n ?? 1).toInt();
        } else if (n != null) {
          obj[sf.name] = n;
        }
      } else if (v.isNotEmpty) {
        obj[sf.name] = v;
      }
    }
    cleaned.add(obj);
  }
  return jsonEncode(cleaned);
}
