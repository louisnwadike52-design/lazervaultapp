// Statement export — backend-rendered account statements.
//
// The user picks an account, a date range and a format (PDF / CSV); the app
// calls accounts-service GenerateStatement, which renders the file
// server-side, uploads it to storage-service and returns a public URL plus a
// SHA-256 digest. The file is then pulled to disk, verified against that
// digest, and offered to open / print / share.
//
// Distinct from the local ExportBottomSheet behind the history AppBar's
// download icon, which serialises whatever the in-app feed already holds. The
// backend export is the canonical, audit-ready document.
//
// The screen itself is a frame: all of the behaviour lives in
// StatementExportHost, shared with Settings → Download statements and with
// the Documents tab of the account-details sheet. It used to be a second
// 815-line implementation that skipped the digest check and could only hand
// the URL to the browser.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/statements/presentation/widgets/statement_export_host.dart';

class StatementExportScreen extends StatelessWidget {
  /// Pre-selects the account when opened from a per-account surface.
  /// Null lets the user pick.
  final String? initialAccountId;

  const StatementExportScreen({super.key, this.initialAccountId});

  /// Route helper, so callers do not have to know the route name or the
  /// argument shape.
  static void open(BuildContext context, {String? initialAccountId}) {
    Get.toNamed(
      '/transactions/statement-export',
      arguments: {'accountId': initialAccountId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1F2937)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Export statement',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: StatementExportHost(initialAccountId: initialAccountId),
    );
  }
}
