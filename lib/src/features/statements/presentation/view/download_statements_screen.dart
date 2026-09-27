import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/src/features/statements/presentation/widgets/statement_export_host.dart';

/// Settings → Download statements.
///
/// A frame around [StatementExportHost]. This screen used to carry its own
/// 877-line copy of the picker, the format toggle, the recents list and the
/// download/verify/share flow, which drifted from the copy behind the
/// dashboard's export route — different validation, different recents, and
/// only this one verified the file's digest. Both now render the same widget.
class DownloadStatementsScreen extends StatelessWidget {
  const DownloadStatementsScreen({super.key});

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
          'Download statements',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: const StatementExportHost(),
    );
  }
}
