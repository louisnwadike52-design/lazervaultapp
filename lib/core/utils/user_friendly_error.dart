import 'dart:async';
import 'package:grpc/grpc.dart';
import '../cache/swr_cache_manager.dart';

/// Converts any error/exception into a natural, user-friendly message.
///
/// Use this instead of `e.toString()` or `error.toString()` when emitting
/// error states that will be displayed to users.
String getUserFriendlyErrorMessage(Object? error, {String? fallback}) {
  if (error == null) {
    return fallback ?? 'Something went wrong. Please try again.';
  }

  // CacheError from SWR cache manager
  if (error is CacheError) {
    return _cacheErrorMessage(error);
  }

  // gRPC errors
  if (error is GrpcError) {
    return _grpcErrorMessage(error);
  }

  // Timeout
  if (error is TimeoutException) {
    return 'This is taking too long. Please check your connection and try again.';
  }

  // API failures from our own error types
  final errorStr = error.toString();

  // Network / connection errors
  if (_isConnectionError(errorStr)) {
    return 'Unable to connect. Please check your internet connection and try again.';
  }

  // Auth errors
  if (errorStr.contains('Unauthenticated') ||
      errorStr.contains('token') && errorStr.contains('expired')) {
    return 'Your session has expired. Please log in again.';
  }

  if (errorStr.contains('PermissionDenied') ||
      errorStr.contains('permission denied')) {
    return "You don't have permission to do this.";
  }

  // Not found
  if (errorStr.contains('NotFound') || errorStr.contains('not found')) {
    return "We couldn't find what you're looking for. It may have been removed.";
  }

  // Server errors
  if (errorStr.contains('Internal') ||
      errorStr.contains('500') ||
      errorStr.contains('server error')) {
    return "Something went wrong on our end. Please try again in a moment.";
  }

  // Rate limiting
  if (errorStr.contains('ResourceExhausted') ||
      errorStr.contains('rate limit') ||
      errorStr.contains('too many requests')) {
    return "You're doing that too quickly. Please wait a moment and try again.";
  }

  // PIN errors
  if (errorStr.contains('invalid') && errorStr.contains('pin')) {
    return 'Incorrect PIN. Please try again.';
  }

  return fallback ?? 'Something went wrong. Please try again.';
}

String _cacheErrorMessage(CacheError error) {
  switch (error.type) {
    case CacheErrorType.fetchError:
      // Check if the original error gives more context
      final original = error.originalError;
      if (original != null) {
        if (original is GrpcError) return _grpcErrorMessage(original);
        if (original is TimeoutException) {
          return 'This is taking too long. Please check your connection and try again.';
        }
        if (_isConnectionError(original.toString())) {
          return 'Unable to connect. Please check your internet connection and try again.';
        }
      }
      return "Couldn't load the latest data. Pull down to refresh.";
    case CacheErrorType.storageFull:
      return 'Your device storage is full. Please free up some space.';
    case CacheErrorType.corruption:
    case CacheErrorType.serializationError:
    case CacheErrorType.deserializationError:
      return "Something went wrong loading saved data. Please try refreshing.";
    case CacheErrorType.storageError:
      return "Couldn't save data to your device. Please try again.";
    case CacheErrorType.unknown:
      return 'Something went wrong. Please try again.';
  }
}

String _grpcErrorMessage(GrpcError error) {
  switch (error.code) {
    case StatusCode.unavailable:
      return 'Service is temporarily unavailable. Please try again in a moment.';
    case StatusCode.deadlineExceeded:
      return 'This is taking too long. Please check your connection and try again.';
    case StatusCode.unauthenticated:
      return 'Your session has expired. Please log in again.';
    case StatusCode.permissionDenied:
      return "You don't have permission to do this.";
    case StatusCode.notFound:
      return "We couldn't find what you're looking for.";
    case StatusCode.alreadyExists:
      return 'This already exists. Please check and try again.';
    case StatusCode.resourceExhausted:
      return "You're doing that too quickly. Please wait a moment and try again.";
    case StatusCode.invalidArgument:
      return 'Please check your input and try again.';
    case StatusCode.failedPrecondition:
      return "This action can't be completed right now. Please try again later.";
    case StatusCode.cancelled:
      return 'Request was cancelled. Please try again.';
    default:
      // If the gRPC error has a meaningful message, check it
      final msg = error.message ?? '';
      if (msg.isNotEmpty && !msg.contains('Exception') && msg.length < 100) {
        return msg;
      }
      return 'Something went wrong. Please try again.';
  }
}

bool _isConnectionError(String errorStr) {
  final lower = errorStr.toLowerCase();
  return lower.contains('socketexception') ||
      lower.contains('connection refused') ||
      lower.contains('connection reset') ||
      lower.contains('connection closed') ||
      lower.contains('network is unreachable') ||
      lower.contains('no route to host') ||
      lower.contains('connection timed out') ||
      lower.contains('host not found') ||
      lower.contains('dns') ||
      lower.contains('no internet') ||
      lower.contains('failed host lookup');
}
