import 'package:equatable/equatable.dart';

/// The account holder's postal address.
///
/// Modelled as one value object rather than six loose strings on [User]: it
/// travels as a unit everywhere it is used (the profile form submits the whole
/// block, statements print the whole block), and splitting it across the user
/// entity would have added six fields to the constructor, copyWith and props
/// of a class touched by most of the app.
class PostalAddress extends Equatable {
  final String line1;
  final String line2;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  const PostalAddress({
    this.line1 = '',
    this.line2 = '',
    this.city = '',
    this.state = '',
    this.postalCode = '',
    this.country = '',
  });

  static const PostalAddress empty = PostalAddress();

  /// Line 1 alone is enough to count as an address. Demanding every field
  /// would leave most users with none, and a partial address on a statement
  /// is still better than a blank space.
  bool get isSet => line1.trim().isNotEmpty;

  bool get isBlank => line1.trim().isEmpty &&
      line2.trim().isEmpty &&
      city.trim().isEmpty &&
      state.trim().isEmpty &&
      postalCode.trim().isEmpty &&
      country.trim().isEmpty;

  /// How the address reads on a document: one entry per line, blanks dropped,
  /// city/state/postcode collapsed onto a single line. Mirrors the server-side
  /// renderer so what the user previews is what the PDF prints.
  List<String> get lines {
    final out = <String>[];
    void add(String s) {
      final t = s.trim();
      if (t.isNotEmpty) out.add(t);
    }

    add(line1);
    add(line2);

    final locality = <String>[];
    if (city.trim().isNotEmpty) locality.add(city.trim());
    if (state.trim().isNotEmpty) locality.add(state.trim());
    var localityLine = locality.join(', ');
    if (postalCode.trim().isNotEmpty) {
      localityLine = localityLine.isEmpty
          ? postalCode.trim()
          : '$localityLine ${postalCode.trim()}';
    }
    add(localityLine);
    add(country);
    return out;
  }

  /// One-line rendering for compact surfaces (a settings row, a summary tile).
  String get singleLine => lines.join(', ');

  PostalAddress copyWith({
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? postalCode,
    String? country,
  }) {
    return PostalAddress(
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      city: city ?? this.city,
      state: state ?? this.state,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  @override
  List<Object?> get props => [line1, line2, city, state, postalCode, country];
}
