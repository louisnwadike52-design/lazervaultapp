part of 'exchange_detail_screen.dart';

// Same three-way split as the receipt screen — kept private to each file
// so we don't leak a UI enum into the domain layer.
enum _RefundFlavour { none, refunded, refundPending }
