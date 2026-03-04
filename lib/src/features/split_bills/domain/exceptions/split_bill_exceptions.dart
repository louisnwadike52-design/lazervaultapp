class SplitBillNotFoundException implements Exception {
  final String message;
  const SplitBillNotFoundException(this.message);

  @override
  String toString() => message;
}

class SplitBillPermissionDeniedException implements Exception {
  final String message;
  const SplitBillPermissionDeniedException(this.message);

  @override
  String toString() => message;
}

class SplitBillStateException implements Exception {
  final String message;
  const SplitBillStateException(this.message);

  @override
  String toString() => message;
}

class SplitBillServiceUnavailableException implements Exception {
  final String message;
  const SplitBillServiceUnavailableException(this.message);

  @override
  String toString() => message;
}
