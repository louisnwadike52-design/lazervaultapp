import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view/escrow_theme.dart';

/// Bottom sheet offering the two honest entry points of a standard two-sided
/// escrow. Returns 'sell_offer' | 'buy_request' | null (dismissed). The old
/// FAB dropped BOTH sides into a buyer-pays create flow — a seller tapping
/// "Create a Deal" on their own tab was asked to fund a purchase.
Future<String?> showEscrowDirectionChooser(BuildContext context) {
  return showModalBottomSheet<String>(
    context: context,
    backgroundColor: EscrowTheme.card,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
    builder: (ctx) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 14.h),
          Text('What would you like to do?',
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700)),
          SizedBox(height: 6.h),
          ListTile(
            leading: Icon(Icons.storefront_outlined,
                color: EscrowTheme.primary, size: 24.sp),
            title: Text('Sell something',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            subtitle: Text(
                'List the item with photos and price. Share it or offer it to a buyer.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            onTap: () => Navigator.pop(ctx, 'sell_offer'),
          ),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined,
                color: EscrowTheme.primary, size: 24.sp),
            title: Text('Request to buy',
                style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600)),
            subtitle: Text(
                'Ask a seller for something. You pay into escrow now; refunded if they decline or don\'t deliver.',
                style: GoogleFonts.inter(
                    color: EscrowTheme.textSecondary, fontSize: 11.5.sp)),
            onTap: () => Navigator.pop(ctx, 'buy_request'),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    ),
  );
}
