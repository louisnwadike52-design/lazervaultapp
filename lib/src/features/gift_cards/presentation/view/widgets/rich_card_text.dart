import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

final RegExp _htmlTag = RegExp(r'<[a-zA-Z!/][^>]*>');
final RegExp _htmlEntity = RegExp(r'&(amp|lt|gt|quot|#39|apos|nbsp);');
final RegExp _mdSyntax = RegExp(r'[*_`#>]+|\[([^\]]*)\]\([^)]*\)');

/// A gift-card description/notes value may arrive as HTML (Prestmit sends
/// `<span>…</span>`), markdown, or plain text. [RichCardText] renders it properly
/// instead of dumping raw markup: HTML tags → HtmlWidget; otherwise MarkdownBody
/// (which also renders plain text). Use for full description blocks.
class RichCardText extends StatelessWidget {
  const RichCardText(this.text, {super.key, this.textStyle});

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final t = text.trim();
    if (t.isEmpty) return const SizedBox.shrink();
    if (_htmlTag.hasMatch(t)) {
      return HtmlWidget(t, textStyle: textStyle);
    }
    return MarkdownBody(
      data: t,
      styleSheet: MarkdownStyleSheet(
        p: textStyle,
        pPadding: EdgeInsets.zero,
      ),
    );
  }
}

/// Flattens HTML/markdown to plain text for the COMPACT one-line places (grid
/// tiles, search rows) where a full renderer would break the fixed layout — so a
/// `<span>Foo</span>` shows as "Foo", not the raw tag. Keeps the existing
/// maxLines/ellipsis Text widget intact.
String plainFromRichText(String input) {
  var s = input
      .replaceAll(_htmlTag, '')
      .replaceAllMapped(_htmlEntity, (m) {
    switch (m.group(1)) {
      case 'amp':
        return '&';
      case 'lt':
        return '<';
      case 'gt':
        return '>';
      case 'quot':
        return '"';
      case 'nbsp':
        return ' ';
      default:
        return "'";
    }
  });
  // Strip the most common markdown emphasis/heading/link syntax, keeping link text.
  s = s.replaceAllMapped(_mdSyntax, (m) => m.groupCount >= 1 && m.group(1) != null ? m.group(1)! : '');
  return s.replaceAll(RegExp(r'\s+'), ' ').trim();
}
