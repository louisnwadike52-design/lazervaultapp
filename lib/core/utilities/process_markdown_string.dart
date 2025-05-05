String processMarkdownContent(String content) {
  return content.replaceAll(
      '{{account_number}}', '<span>{{account_number}}</span>');
}
