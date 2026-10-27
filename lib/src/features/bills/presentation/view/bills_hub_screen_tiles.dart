part of 'bills_hub_screen.dart';

// Moved verbatim from the hub State so the screen file stays readable; a
// `part` shares the library's private scope, so nothing else changed.
// Static tile registry — the type→(icon, route, copy) map is a client
// concern and never comes from the backend. `type` matches the bill-service
// catalogue's type string (see GetBillServices); `defaultVisible` is the
// tile's visibility when the catalogue can't be consulted (fetch error /
// timeout) or when the catalogue doesn't govern this type at all.
//
// The catalogue only governs: electricity, airtime, data, cable_tv,
// internet, water, education. ePIN and betting are NOT in the catalogue, so
// they are always shown (defaultVisible = true) regardless of the response.
// THE SHIPPED PRODUCT IS AIRTIME, DATA, ELECTRICITY AND CABLE TV.
//
// Only those four default visible. Internet, Water, Education, ePIN and
// betting are built but not launched, so they appear ONLY when the
// catalogue explicitly reports them enabled — a fetch failure or timeout
// must not re-surface an unlaunched product, which is what a `true` default
// did.
//
// ePIN and betting additionally had no catalogue entry at all, so
// _catalogueAllows fell through to this default and showed them
// unconditionally with no admin toggle able to reach them. They are now in
// billServiceCatalogue (utility-payments-service) with DefaultEnabled
// false, so `service_epin_enabled` / `service_betting_enabled` govern them
// like every other type.
const List<_BillType> _allTiles = [
  _BillType(
    type: 'airtime',
    icon: Icons.phone_android,
    title: 'Airtime',
    description: 'Top up any network',
    route: AppRoutes.airtime,
  ),
  _BillType(
    type: 'data',
    icon: Icons.wifi,
    title: 'Data Bundles',
    description: 'MTN, Airtel, Glo, 9mobile',
    route: AppRoutes.dataBundlesHome,
  ),
  _BillType(
    type: 'electricity',
    icon: Icons.electric_bolt,
    title: 'Electricity',
    description: 'Prepaid & postpaid bills',
    route: AppRoutes.electricityBillHome,
  ),
  _BillType(
    type: 'cable_tv',
    icon: Icons.tv,
    title: 'Cable TV',
    description: 'DStv, GOtv, Startimes',
    route: AppRoutes.cableTVHome,
  ),
  _BillType(
    type: 'internet',
    icon: Icons.router,
    title: 'Internet',
    description: 'Smile, Spectranet & more',
    route: AppRoutes.internetBillHome,
    defaultVisible: false,
  ),
  _BillType(
    type: 'water',
    icon: Icons.water_drop,
    title: 'Water Bill',
    description: 'Water corporation bills',
    route: AppRoutes.waterBillHome,
    defaultVisible: false,
  ),
  _BillType(
    type: 'education',
    icon: Icons.school,
    title: 'Education PINs',
    description: 'WAEC, NECO & JAMB PINs',
    route: AppRoutes.educationHome,
    defaultVisible: false,
  ),
  _BillType(
    type: 'epin',
    icon: Icons.confirmation_number,
    title: 'Recharge card printing',
    description: 'Generate airtime PINs',
    route: AppRoutes.epinHome,
    defaultVisible: false,
  ),
  _BillType(
    type: 'betting',
    icon: Icons.sports_soccer,
    title: 'Fund betting account',
    description: 'Top up your betting wallet',
    route: AppRoutes.bettingHome,
    defaultVisible: false,
  ),
];

Widget _billsHubHeaderCard() {
  return Container(
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          InvoiceThemeColors.primaryPurple,
          InvoiceThemeColors.primaryPurple.withValues(alpha: 0.8),
        ],
      ),
      borderRadius: BorderRadius.circular(16.r),
      boxShadow: [
        BoxShadow(
          color: InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.receipt_long,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pay any bill, any time',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Fast, secure & reliable bill payments',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _BillType {
  /// Bill-service catalogue type string (matches GetBillServices `type`).
  final String type;
  final IconData icon;
  final String title;
  final String description;
  final String route;

  /// Visibility when the catalogue can't be consulted (fetch error/timeout)
  /// or doesn't govern this type. Only the four launched types default to
  /// shown; everything built-but-unlaunched defaults hidden.
  final bool defaultVisible;

  const _BillType({
    required this.type,
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
    this.defaultVisible = true,
  });
}

class _BillTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  /// False when an admin has switched this bill type off.
  ///
  /// The tile stays in the grid and stays TAPPABLE — tapping opens the
  /// explanation. A control that disappears during an outage looks like a bug
  /// and costs a support ticket; one that is dimmed and says why does not.
  final bool enabled;

  const _BillTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
    this.enabled = true,
  });

  @override
  State<_BillTile> createState() => _BillTileState();
}

class _BillTileState extends State<_BillTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: Opacity(
        opacity: widget.enabled ? 1.0 : 0.45,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: InvoiceThemeColors.secondaryBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: _pressed
                  ? InvoiceThemeColors.primaryPurple
                  : InvoiceThemeColors.borderColor,
              width: _pressed ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _pressed
                    ? InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.1),
                blurRadius: _pressed ? 15 : 8,
                offset: _pressed ? const Offset(0, 6) : const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      InvoiceThemeColors.primaryPurple.withValues(alpha: 0.2),
                      InvoiceThemeColors.primaryPurple.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    size: 22.sp,
                    color: InvoiceThemeColors.primaryPurple,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 10.sp,
                  color: InvoiceThemeColors.textGray400,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
