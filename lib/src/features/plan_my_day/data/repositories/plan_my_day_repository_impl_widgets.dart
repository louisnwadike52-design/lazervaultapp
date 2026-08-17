part of 'plan_my_day_repository_impl.dart';

// ==================== EXCEPTIONS ====================

class PlanMyDayException implements Exception {
  final String message;
  PlanMyDayException(this.message);

  @override
  String toString() => message;
}

class PlanMyDayNetworkException extends PlanMyDayException {
  PlanMyDayNetworkException(super.message);
}

class PlanMyDayAuthException extends PlanMyDayException {
  PlanMyDayAuthException(super.message);
}

class PlanMyDayValidationException extends PlanMyDayException {
  final dynamic details;
  PlanMyDayValidationException(super.message, {this.details});
}

class PlanMyDayNotFoundException extends PlanMyDayException {
  PlanMyDayNotFoundException(super.message);
}

class PlanMyDayParseException extends PlanMyDayException {
  PlanMyDayParseException(super.message);
}

class PlanMyDayApiException extends PlanMyDayException {
  final int statusCode;
  PlanMyDayApiException(super.message, {this.statusCode = 500});
}
