part of 'mycover_claim_bottom_sheet.dart';

/// Distinguishes the two hosted MyCover flows (claim vs renewal) so the
/// sheet can pick the right copy without duplicating the entire WebView
/// scaffolding. Both flows are identical at the runtime level — a
/// MyCover-hosted form opened in-app — only the user-facing labels
/// differ.
enum MyCoverHostedFlowKind { claim, renew, buy, manage }
