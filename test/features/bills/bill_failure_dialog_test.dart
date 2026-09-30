import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:lazervault/src/features/bills/presentation/widgets/bill_failure_dialog.dart';

void main() {
  group('classifyBillFailure', () {
    test('our-fault codes are never blamed on the customer', () {
      // The backend deliberately returns Unavailable for a starved provider
      // float, an unrecognised service id and revoked credentials — all of them
      // OURS. If any of these read as correctable the app would tell a customer
      // to fix something they cannot touch, and for a float it would say
      // "add funds" while it is our own wallet that is empty.
      for (final code in [
        StatusCode.unavailable,
        StatusCode.deadlineExceeded,
        StatusCode.internal,
        StatusCode.resourceExhausted,
      ]) {
        expect(
          classifyBillFailure(GrpcError.custom(code, '')),
          BillFailureKind.unavailable,
          reason: 'code $code must read as ours',
        );
      }
    });

    test('ALREADY_EXISTS is an in-flight purchase, not a failure', () {
      expect(
        classifyBillFailure(GrpcError.alreadyExists('')),
        BillFailureKind.alreadyProcessing,
      );
    });

    test('codes the customer can act on are correctable', () {
      for (final code in [
        StatusCode.invalidArgument,
        StatusCode.failedPrecondition,
        StatusCode.notFound,
        StatusCode.permissionDenied,
      ]) {
        expect(
          classifyBillFailure(GrpcError.custom(code, '')),
          BillFailureKind.correctable,
          reason: 'code $code is the customer to resolve',
        );
      }
    });

    test('a non-gRPC error is treated as ours, not as bad input', () {
      // A socket error, a timeout, a thrown string. Blaming the user for
      // something we cannot classify is the worse of the two mistakes.
      expect(classifyBillFailure(Exception('boom')),
          BillFailureKind.unavailable);
      expect(classifyBillFailure(null), BillFailureKind.unavailable);
    });
  });

  group('billFailureForbidsRetry — the money guard', () {
    test('forbids retry ONLY for an already-accepted purchase', () {
      // ePINs has no requery endpoint, so a retry after code 104 is how one
      // purchase silently becomes two with nothing downstream to catch it.
      expect(billFailureForbidsRetry(StatusCode.alreadyExists), isTrue);

      for (final code in [
        StatusCode.unavailable,
        StatusCode.invalidArgument,
        StatusCode.failedPrecondition,
        StatusCode.internal,
        StatusCode.deadlineExceeded,
      ]) {
        expect(billFailureForbidsRetry(code), isFalse,
            reason: 'code $code is safe to retry and must keep the control');
      }
    });

    test('a missing or non-numeric code still allows a retry', () {
      // An unknown shape must not strand the user with no way forward on a
      // purchase that probably never happened.
      expect(billFailureForbidsRetry(null), isFalse);
      expect(billFailureForbidsRetry('Network Error'), isFalse);
    });
  });
}
