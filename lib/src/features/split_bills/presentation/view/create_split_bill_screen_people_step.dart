part of 'create_split_bill_screen.dart';

/// STEP 2 (PEOPLE), REDESIGNED.
///
/// What was wrong with it:
///
///   * the share input was a 60–100px box floating in the middle of a row,
///     with a bare "%" and no label. It is the ONLY thing on the screen the
///     user has to fill in, and it read as a decoration;
///   * nothing showed what a typed percentage came to in money. "5 %" and
///     "Too small: Nnaemeka Ezeke (₦25.00)" were in different parts of the
///     screen, so the fix for the error was never next to the error;
///   * the summary sat behind a 1px #4834D4 hairline — the same almost
///     invisible border this file's own participant card had already
///     replaced with elevation, and the comment explaining why was three
///     hundred lines further down;
///   * the labels were terse to the point of being wrong. "Co-payers 2"
///     when one co-payer is listed is only true because it counts YOU, and
///     "Your Share" does not say that under percentage and custom it is the
///     leftover rather than a number anyone chose.
///
/// No new state: everything here reads the same fields the old widgets did.

/// A co-payer row: who they are, what they pay, and what that comes to.
Widget buildCoPayerCard({
  required Key key,
  required String initial,
  required String primary,
  required String? handle,
  required SplitShareInput input,
  required double amount,
  required String currencySymbol,
  required bool belowFloor,
  required double floor,
  required String? initialValue,
  required ValueChanged<String> onChanged,
  required VoidCallback onRemove,
}) {
  final money = '$currencySymbol${NumberFormat('#,##0.00').format(amount)}';

  return Container(
    key: key,
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.fromLTRB(14, 14, 14, 14),
    decoration: BoxDecoration(
      color: const Color(0xFF1F1F1F),
      borderRadius: BorderRadius.circular(16),
      // Elevation, not a hairline. A 1px #2D2D2D line on #1F1F1F is almost
      // invisible and does nothing to separate the card from the page.
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF4834D4).withValues(alpha: 0.2),
              child: Text(
                initial,
                style: const TextStyle(
                  color: Color(0xFF8B5CF6),
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    primary,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (handle != null && handle.isNotEmpty)
                    Text(
                      handle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 13,
                      ),
                    ),
                ],
              ),
            ),
            // Remove: a 44px target, not a bare 20px glyph.
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: Color(0xFFEF4444), size: 20),
              tooltip: 'Remove $primary',
              splashRadius: 22,
            ),
          ],
        ),
        if (input == SplitShareInput.none)
          // Equal split: there is nothing to type, so say the figure plainly
          // instead of rendering a disabled-looking box.
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Row(
              children: [
                const Text('They pay',
                    style: TextStyle(color: Color(0xFF9CA3AF), fontSize: 13)),
                const Spacer(),
                Text(money,
                    style: const TextStyle(
                      color: Color(0xFF10B981),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          )
        else ...[
          const SizedBox(height: 14),
          Text(
            input == SplitShareInput.percent
                ? 'Their share of the bill'
                : 'What they pay',
            style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 13),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // The field is the job of this screen, so it gets the width
              // and the height to look like one.
              SizedBox(
                width: 132,
                child: TextFormField(
                  initialValue: initialValue,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: const TextStyle(color: Color(0xFF4B5563)),
                    prefixText:
                        input == SplitShareInput.amount ? currencySymbol : null,
                    prefixStyle:
                        const TextStyle(color: Color(0xFF9CA3AF), fontSize: 20),
                    suffixText: input == SplitShareInput.percent ? '%' : null,
                    suffixStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 14),
                    filled: true,
                    fillColor: const Color(0xFF111111),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: belowFloor
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFF3A3A3A),
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Color(0xFF8B5CF6), width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: onChanged,
                ),
              ),
              const SizedBox(width: 14),
              // THE ANSWER, NEXT TO THE QUESTION. A percentage means nothing
              // to someone checking whether a share clears the bank floor;
              // the money it works out to is the thing they are deciding on.
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      amount > 0 ? money : '—',
                      style: TextStyle(
                        color: belowFloor
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFF10B981),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (belowFloor)
                      Padding(
                        padding: const EdgeInsets.only(top: 2),
                        child: Text(
                          'Below the $currencySymbol'
                          '${NumberFormat('#,##0').format(floor)} bank minimum',
                          style: const TextStyle(
                              color: Color(0xFFF59E0B), fontSize: 11),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ],
    ),
  );
}

/// One line of the summary: a label, an optional explanation under it, and
/// the figure.
Widget buildSplitSummaryRow(
  String label,
  String value, {
  String? note,
  bool emphasise = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 7),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CONTRAST. These sat at gray-400 (label) over gray-500 (note)
              // on a dark navy card, and the explanatory lines under each row
              // — the ones that say WHY "Split between" is 2 when one
              // co-payer is listed — were the hardest text on the screen to
              // read. Both tiers move one step lighter (gray-300 / gray-400)
              // so the note is legible while staying visibly secondary to its
              // label; making them the same colour would have fixed the
              // contrast and lost the hierarchy.
              Text(
                label,
                style: TextStyle(
                  color: emphasise ? Colors.white : const Color(0xFFD1D5DB),
                  fontSize: 14,
                  fontWeight: emphasise ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              // The explanation goes UNDER the label, not in a tooltip or a
              // help sheet: "Co-payers 2" with one co-payer listed is only
              // true because it counts the organiser, and nothing said so.
              if (note != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2, right: 12),
                  child: Text(
                    note,
                    style: const TextStyle(
                        color: Color(0xFF9CA3AF), fontSize: 12, height: 1.35),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.white,
            fontSize: emphasise ? 17 : 14,
            fontWeight: emphasise ? FontWeight.w700 : FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

/// The summary block. Elevation and a tinted ground instead of the 1px
/// #4834D4 hairline it used to wear — the same change this file already made
/// to the participant card, for the same reason.
Widget buildSplitSummaryCard({required List<Widget> rows}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
    decoration: BoxDecoration(
      color: const Color(0xFF17132B),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.35),
          blurRadius: 14,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rows),
  );
}

/// A thin rule between the inputs and the totals, so the summary reads as a
/// consequence of what was typed rather than another thing to fill in.
Widget buildSummaryDivider() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(height: 1, color: const Color(0xFF2A2342)),
    );
