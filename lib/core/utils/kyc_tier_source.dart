import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/authentication/cubit/authentication_cubit.dart';

/// The signed-in customer's KYC tier, for surfaces that need it outside a
/// cubit of their own.
///
/// WHY A FLOOR OF 1 RATHER THAN 0. Every caller uses this to decide what to
/// OFFER — "you are on tier N, verifying moves you to N+1". A 0 would be read
/// as a real tier and offer an upgrade to tier 1, which is not a thing: the
/// canonical ladder (shared/kyctiers) starts at 1 and DeriveTier never returns
/// less. 0 here only ever means "the profile is not loaded yet", and the
/// honest reading of that is "assume the lowest real tier", which offers the
/// upgrade that is almost certainly correct.
///
/// Never throws: it is called from error paths, and a failure to read a tier
/// must not replace the error the customer was actually being shown.
int currentKycTier() {
  try {
    final tier =
        serviceLocator<AuthenticationCubit>().currentProfile?.user.kycTier ?? 0;
    if (tier < 1) return 1;
    if (tier > 3) return 3;
    return tier;
  } catch (_) {
    return 1;
  }
}
