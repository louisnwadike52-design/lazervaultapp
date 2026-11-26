class ServerException implements Exception {
  final String? message;

  /// The gRPC status code the server answered with, when this was built from a
  /// [GrpcError].
  ///
  /// WHY IT HAD TO BE CARRIED. Wrapping a GrpcError in a ServerException threw
  /// the code away, and the code is the only thing that separates "we refused
  /// this on its merits" (FailedPrecondition — a limit, a cap, an allowance,
  /// an account state) from "the call did not complete" (Unavailable,
  /// DeadlineExceeded). Send funds lost it at the data source, so
  /// TransferCubit's `on GrpcError` branch — the one that sets isSpendRefusal
  /// and the KYC flag — was unreachable for the one call that needed it most,
  /// and every screen downstream had to re-derive the distinction by searching
  /// the message text for English words.
  ///
  /// Null when the exception did not come from a gRPC call.
  final int? code;

  ServerException({this.message, this.code});

  @override
  String toString() {
    return message ?? 'ServerException';
  }
}
