import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart' as picker;

import '../../../data/array_item_encoder.dart';
import '../../../domain/entities/insurance_product_entity.dart';
import 'monetary_form_field.dart';
import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
part 'array_form_field_widgets.dart';


/// Renders MyCover.ai `array`-type form fields (e.g. `item_details`
/// for Marine cargo, `items` for Home Content) as a repeating
/// {name, value, description} record list.
///
/// MyCover docs don't ship a per-item schema — each item is just
/// "details of each shipment item" — so we ship a sensible default
/// shape that covers both Marine cargo and Home Content lists:
///
/// ```json
/// [
///   {"name": "MacBook Pro 14\"", "value": 2500000, "description": "Laptop"},
///   {"name": "iPhone 15", "value": 950000, "description": "Phone"}
/// ]
/// ```
///
/// The serialized JSON is written into formData[field.name] via
/// [onChanged] so the backend hands it straight to MyCover.
class ArrayFormField extends StatefulWidget {
  final InsuranceProductFormField field;
  final String currencyCode;
  final String currencySymbol;

  /// JSON-encoded list of items previously stored in formData. Empty
  /// string starts a fresh list with one editable row.
  final String initialJson;

  /// External validation error (e.g. "at least one item required").
  final String? errorText;

  /// Called with the JSON-encoded array string after every change.
  final ValueChanged<String> onChanged;

  /// Stages a per-item image upload and returns the deterministic
  /// public URL the array writes into the item's `image_url` slot.
  /// Wired from the parent form to `CreatePolicyCubit.stageArrayItemImage`
  /// so the upload runs through the same pre-construct-URL flow used
  /// for top-level file fields. May be null if the parent doesn't
  /// support uploads — the row falls back to a plain text input then.
  final Future<String> Function({
    required List<int> bytes,
    required String filename,
    required String contentType,
  })? stageItemImage;

  const ArrayFormField({
    super.key,
    required this.field,
    required this.currencyCode,
    required this.currencySymbol,
    required this.initialJson,
    required this.onChanged,
    this.errorText,
    this.stageItemImage,
  });

  @override
  State<ArrayFormField> createState() => _ArrayFormFieldState();
}

class _ArrayFormFieldState extends State<ArrayFormField> {
  /// Mutable list of items, each a sub-field-name → string map (plus the
  /// local-only `_image_filename` side-channel for image sub-fields).
  late List<Map<String, String>> _items;

  /// Per-item sub-field schema, backend-driven (field.itemFields) with a
  /// cargo-shape fallback. Drives both rendering and encoding.
  List<InsuranceProductFormItemField> get _schema =>
      itemSchemaFor(widget.field);

  @override
  void initState() {
    super.initState();
    _items = _decode(widget.initialJson);
    if (_items.isEmpty) {
      _items = [_emptyItem()];
    }
  }

  Map<String, String> _emptyItem() {
    final m = <String, String>{};
    for (final sf in _schema) {
      // quantity is the one numeric field MyCover wants ≥ 1; seed it so
      // single-item cargo lists submit without the user touching it.
      m[sf.name] = sf.name == 'quantity' ? '1' : '';
    }
    return m;
  }

  List<Map<String, String>> _decode(String raw) {
    if (raw.isEmpty) return [];
    try {
      final parsed = jsonDecode(raw);
      if (parsed is List) {
        return parsed
            .whereType<Map>()
            .map((m) => m.map((k, v) => MapEntry(k.toString(), v?.toString() ?? '')))
            .toList();
      }
    } catch (_) {
      // Fall through — surface as empty list rather than crash.
    }
    return [];
  }

  /// Re-encodes the list via the shared [encodeArrayItems] so the wire
  /// shape is byte-identical to what the e2e test produces. Numeric
  /// sub-fields become JSON numbers, half-filled rows (missing a
  /// required sub-field) are dropped, and local-only keys never leak.
  void _emit() {
    widget.onChanged(encodeArrayItems(_schema, _items));
  }

  void _addItem() {
    setState(() => _items.add(_emptyItem()));
    _emit();
  }

  void _removeItem(int idx) {
    if (_items.length <= 1) {
      // Keep at least one editable row so the user can always start
      // typing — but emit an empty array so validation can flag it.
      setState(() => _items[idx] = _emptyItem());
    } else {
      setState(() => _items.removeAt(idx));
    }
    _emit();
  }

  void _updateField(int idx, String key, String value) {
    _items[idx][key] = value;
    _emit();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Flexible(
              child: Text(widget.field.label,
                  style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
            ),
            if (widget.field.required)
              Text(' *',
                  style: GoogleFonts.inter(
                      fontSize: 13.sp, color: const Color(0xFFEF4444))),
          ]),
          if (widget.field.description.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 2.h, bottom: 6.h),
              child: Text(widget.field.description,
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: const Color(0xFF9CA3AF))),
            ),
          SizedBox(height: 8.h),
          for (int i = 0; i < _items.length; i++) _buildItemCard(i),
          SizedBox(height: 4.h),
          GestureDetector(
            onTap: _addItem,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                    color: const Color(0xFF6366F1).withValues(alpha: 0.4)),
              ),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.add_circle_outline,
                    color: const Color(0xFF6366F1), size: 18.sp),
                SizedBox(width: 8.w),
                Text('Add another item',
                    style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF6366F1))),
              ]),
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 6.h, left: 4.w),
              child: Text(widget.errorText!,
                  style: GoogleFonts.inter(
                      fontSize: 11.sp, color: const Color(0xFFEF4444))),
            ),
        ],
      ),
    );
  }

  Widget _buildItemCard(int idx) {
    final item = _items[idx];
    final children = <Widget>[
      Row(children: [
        Text('Item ${idx + 1}',
            style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF9CA3AF))),
        const Spacer(),
        GestureDetector(
          onTap: () => _removeItem(idx),
          child: Icon(Icons.delete_outline,
              color: const Color(0xFFEF4444).withValues(alpha: 0.8),
              size: 18.sp),
        ),
      ]),
      SizedBox(height: 10.h),
    ];

    // Render each sub-field from the (backend-driven) item schema. This
    // is what makes benefit_details show a benefit dropdown + sum_insured
    // while item_details shows name/value/quantity/image/description —
    // no hardcoded per-product shapes.
    for (var i = 0; i < _schema.length; i++) {
      final sf = _schema[i];
      children.add(_buildSubField(idx, sf, item));
      if (i < _schema.length - 1) children.add(SizedBox(height: 8.h));
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _buildSubField(
      int idx, InsuranceProductFormItemField sf, Map<String, String> item) {
    final hint = sf.placeholder.isNotEmpty
        ? sf.placeholder
        : (sf.required ? '${sf.label} *' : sf.label);
    switch (sf.type) {
      case 'monetary':
        return MonetaryFormField(
          currencyCode: widget.currencyCode,
          currencySymbol: widget.currencySymbol,
          initialRawValue: item[sf.name] ?? '',
          label: sf.required ? '${sf.label} *' : sf.label,
          required: sf.required,
          onChanged: (raw) => _updateField(idx, sf.name, raw),
        );
      case 'number':
        return TextFormField(
          initialValue: item[sf.name],
          onChanged: (v) => _updateField(idx, sf.name, v),
          keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            LengthLimitingTextInputFormatter(12),
          ],
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          decoration: _innerDecoration(hint),
        );
      case 'select':
        return _buildSubSelect(idx, sf, item);
      case 'image':
        return _buildItemImagePicker(idx, item, sf.name);
      case 'text':
      default:
        return TextFormField(
          initialValue: item[sf.name],
          onChanged: (v) => _updateField(idx, sf.name, v),
          inputFormatters: [LengthLimitingTextInputFormatter(160)],
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          decoration: _innerDecoration(hint),
        );
    }
  }

  /// A select sub-field rendered as a dark-theme dropdown reading its
  /// options from the backend schema (e.g. benefit, relationship).
  Widget _buildSubSelect(
      int idx, InsuranceProductFormItemField sf, Map<String, String> item) {
    final current = (item[sf.name] ?? '').isEmpty ? null : item[sf.name];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: const Color(0xFF2D2D2D)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: current,
          isExpanded: true,
          dropdownColor: const Color(0xFF1F1F1F),
          hint: Text(sf.required ? '${sf.label} *' : sf.label,
              style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.6))),
          icon: const Icon(Icons.keyboard_arrow_down,
              color: Color(0xFF9CA3AF)),
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
          items: sf.options
              .map((o) => DropdownMenuItem<String>(
                    value: o,
                    child: Text(o,
                        style: GoogleFonts.inter(
                            fontSize: 14.sp, color: Colors.white)),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) _updateField(idx, sf.name, v);
          },
        ),
      ),
    );
  }

  // 10MB cap — matches the file-upload limit in the main form widget
  // and the MyCover endpoint's documented size limit.
  static const int _maxItemImageBytes = 10 * 1024 * 1024;

  // Tracks the in-flight stage call per item index so the tile shows
  // a spinner while the URL pair is being resolved.
  final Set<int> _stagingItem = <int>{};

  /// Replaces the legacy plain-text `image_url` field with an upload
  /// tile. Renders three states:
  ///   • empty — "Tap to attach photo"
  ///   • staging — spinner while the backend hands back the URL pair
  ///   • attached — green tile with filename + "Uploads on purchase"
  ///
  /// Falls back to a text input when the parent didn't wire
  /// [widget.stageItemImage] (used in non-cubit contexts).
  Widget _buildItemImagePicker(
      int idx, Map<String, String> item, String fieldName) {
    final filenameKey = '${fieldName}__filename';
    if (widget.stageItemImage == null) {
      // No upload pipeline available — keep the legacy text input so
      // an admin pasting a known URL still works.
      return TextFormField(
        initialValue: item[fieldName],
        onChanged: (v) => _updateField(idx, fieldName, v),
        style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white),
        decoration: _innerDecoration('Item image URL (upload UUID)'),
      );
    }

    final url = (item[fieldName] ?? '').trim();
    final filename = (item[filenameKey] ?? '').trim();
    final isStaging = _stagingItem.contains(idx);
    final hasImage = url.isNotEmpty;

    return GestureDetector(
      onTap: isStaging ? null : () => _showItemImageSourceSheet(idx, fieldName),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF0A0A0A),
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: hasImage
                ? const Color(0xFF10B981).withValues(alpha: 0.6)
                : const Color(0xFF2D2D2D),
          ),
        ),
        child: Row(children: [
          Icon(
            hasImage
                ? Icons.check_circle
                : isStaging
                    ? Icons.cloud_upload_outlined
                    : Icons.photo_camera_outlined,
            color: hasImage
                ? const Color(0xFF10B981)
                : const Color(0xFF6366F1),
            size: 18.sp,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isStaging
                      ? 'Preparing upload…'
                      : hasImage
                          ? (filename.isEmpty ? 'Photo attached' : filename)
                          : 'Tap to attach a photo of this item',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: hasImage ? const Color(0xFF10B981) : Colors.white,
                  ),
                ),
                if (hasImage)
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: Text(
                      'Uploads on purchase',
                      style: GoogleFonts.inter(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isStaging)
            LazerVaultLoader(size: 14)
          else if (hasImage)
            IconButton(
              tooltip: 'Remove photo',
              onPressed: () {
                _updateField(idx, fieldName, '');
                _updateField(idx, filenameKey, '');
              },
              icon: Icon(Icons.delete_outline_rounded,
                  color: const Color(0xFFEF4444), size: 18.sp),
            ),
        ]),
      ),
    );
  }

  /// Bottom sheet with three sources (camera / gallery / file). Mirrors
  /// the top-level _showUploadSourceSheet so the UX is the same on
  /// nested item rows.
  Future<void> _showItemImageSourceSheet(int idx, String fieldName) async {
    final choice = await showModalBottomSheet<_ItemImageSource>(
      context: context,
      backgroundColor: const Color(0xFF1F1F1F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetCtx) => SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 12.h),
              _sourceTile(sheetCtx, Icons.photo_camera_outlined, 'Take Photo',
                  _ItemImageSource.camera),
              _sourceTile(sheetCtx, Icons.photo_library_outlined,
                  'Choose from Gallery', _ItemImageSource.gallery),
              _sourceTile(sheetCtx, Icons.file_open_outlined, 'Upload File',
                  _ItemImageSource.file),
            ],
          ),
        ),
      ),
    );
    if (choice == null || !mounted) return;
    switch (choice) {
      case _ItemImageSource.camera:
        await _pickItemImageFromCamera(idx, fieldName, picker.ImageSource.camera);
        break;
      case _ItemImageSource.gallery:
        await _pickItemImageFromCamera(idx, fieldName, picker.ImageSource.gallery);
        break;
      case _ItemImageSource.file:
        await _pickItemImageFromFile(idx, fieldName);
        break;
    }
  }

  ListTile _sourceTile(BuildContext sheetCtx, IconData icon, String label,
      _ItemImageSource src) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF6366F1)),
      title: Text(label,
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.white)),
      onTap: () => Navigator.pop(sheetCtx, src),
    );
  }

  Future<void> _pickItemImageFromCamera(
      int idx, String fieldName, picker.ImageSource src) async {
    try {
      final shot = await picker.ImagePicker().pickImage(
        source: src,
        maxWidth: 2048,
        imageQuality: 80,
      );
      if (shot == null) return;
      final bytes = await File(shot.path).readAsBytes();
      await _stageItemImage(idx, fieldName, bytes, shot.name);
    } catch (e) {
      _showItemImageError("Couldn't capture image: $e");
    }
  }

  Future<void> _pickItemImageFromFile(int idx, String fieldName) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        withData: true,
      );
      if (result == null || result.files.isEmpty) return;
      final file = result.files.first;
      if (file.bytes == null) return;
      await _stageItemImage(idx, fieldName, file.bytes!.toList(), file.name);
    } catch (e) {
      _showItemImageError("Couldn't pick file: $e");
    }
  }

  Future<void> _stageItemImage(
      int idx, String fieldName, List<int> bytes, String filename) async {
    if (bytes.length > _maxItemImageBytes) {
      _showItemImageError('File too large. Maximum size is 10 MB.');
      return;
    }
    if (!mounted) return;
    setState(() => _stagingItem.add(idx));
    try {
      final contentType = _sniffContentType(filename);
      final url = await widget.stageItemImage!(
        bytes: bytes,
        filename: filename,
        contentType: contentType,
      );
      if (!mounted) return;
      setState(() {
        // Replace the row's image fields so any previous filename/url
        // is cleared cleanly. Calling _emit() at the end re-encodes
        // the array and notifies the parent.
        if (idx < _items.length) {
          _items[idx][fieldName] = url;
          _items[idx]['${fieldName}__filename'] = filename;
        }
      });
      _emit();
    } catch (e) {
      _showItemImageError("Couldn't prepare upload — tap to retry");
    } finally {
      if (mounted) setState(() => _stagingItem.remove(idx));
    }
  }

  void _showItemImageError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
      ),
    );
  }

  String _sniffContentType(String filename) {
    final lower = filename.toLowerCase();
    if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
    if (lower.endsWith('.png')) return 'image/png';
    if (lower.endsWith('.webp')) return 'image/webp';
    if (lower.endsWith('.heic')) return 'image/heic';
    if (lower.endsWith('.pdf')) return 'application/pdf';
    return 'application/octet-stream';
  }

  InputDecoration _innerDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.inter(
          fontSize: 13.sp,
          color: const Color(0xFF9CA3AF).withValues(alpha: 0.6)),
      isDense: true,
      filled: true,
      fillColor: const Color(0xFF0A0A0A),
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF2D2D2D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: const BorderSide(color: Color(0xFF6366F1)),
      ),
    );
  }
}
