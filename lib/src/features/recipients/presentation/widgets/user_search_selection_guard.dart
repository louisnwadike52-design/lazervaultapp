import 'dart:async';

/// What a guarded selection ended as.
enum SelectionOutcome {
  /// The work succeeded while the sheet was still there: close with the value.
  complete,

  /// The work failed (returned false or threw): the row returns to normal and
  /// the sheet stays open so the caller's own error surface can be read.
  stayOpen,

  /// Nothing should happen: the tap landed while another row was busy, the
  /// sheet was dismissed before the work finished, or a newer selection took
  /// over. The caller must not navigate.
  discarded,
}

/// Serialises "tap a row, do the pre-navigation work, then close" for a picker
/// sheet, so the sheet can keep a spinner on the tapped row while a backend
/// call is in flight and never hands a result to a screen that is gone.
///
/// One instance per sheet. It tracks which row is busy and a sequence token:
/// - a second tap while busy is ignored,
/// - a result that lands after [cancel] (the sheet was disposed) or after a
///   newer selection is discarded,
/// - the work's own outcome decides whether the sheet closes.
class SelectionGuard {
  int _seq = 0;
  Object? _busyKey;

  /// Whether some row's work is in flight.
  bool get isBusy => _busyKey != null;

  /// Whether the row identified by [key] is the one in flight.
  bool isBusyFor(Object key) => _busyKey == key;

  /// Runs [work] for the row identified by [key].
  ///
  /// [isAlive] is read after the work settles; false means the host is gone
  /// and the outcome is [SelectionOutcome.discarded]. [onChanged] fires when
  /// the busy row changes so the host can rebuild (only while it is alive).
  Future<SelectionOutcome> run({
    required Object key,
    required Future<bool> Function() work,
    required bool Function() isAlive,
    required void Function() onChanged,
  }) async {
    if (isBusy) return SelectionOutcome.discarded;
    final seq = ++_seq;
    _busyKey = key;
    onChanged();
    bool ok;
    try {
      ok = await work();
    } catch (_) {
      ok = false;
    }
    // Cancelled or superseded while awaiting: whoever did that owns the state.
    if (seq != _seq) return SelectionOutcome.discarded;
    _busyKey = null;
    if (!isAlive()) return SelectionOutcome.discarded;
    onChanged();
    return ok ? SelectionOutcome.complete : SelectionOutcome.stayOpen;
  }

  /// Forget any in-flight work. Call from the host's dispose so a late result
  /// can never complete a selection on a sheet that no longer exists.
  void cancel() {
    _seq++;
    _busyKey = null;
  }
}
