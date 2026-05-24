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
  InsuranceProductFormItemField(
      name: 'description', label: 'Description', type: 'text'),
];

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
