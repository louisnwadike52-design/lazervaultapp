part of 'exchange_receipt_screen.dart';

// Refund flavour derived from failure_reason + status. The proto enum
// collapses all terminal-sad states to FAILED/CANCELLED, so we recover
// the richer label (Refunded / Refund Pending) from the reason string.
enum _RefundFlavour { none, refunded, refundPending }
