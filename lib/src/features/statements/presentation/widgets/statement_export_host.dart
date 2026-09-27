import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lazervault/core/services/injection_container.dart';
import 'package:lazervault/src/features/account_cards_summary/cubit/account_cards_summary_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/cubit/statement_cubit.dart';
import 'package:lazervault/src/features/statements/presentation/widgets/statement_export_panel.dart';

/// Wires the two cubits [StatementExportPanel] needs.
///
/// Every host used to do this itself, and they did not agree: the settings
/// route built a StatementCubit, the export route built an AccountActionsCubit
/// instead, and the account sheet had neither and pushed a named route. One
/// wrapper means a new surface cannot get the wiring subtly wrong.
class StatementExportHost extends StatelessWidget {
  final String? initialAccountId;
  final bool lockAccount;
  final bool dark;
  final EdgeInsetsGeometry? padding;

  const StatementExportHost({
    super.key,
    this.initialAccountId,
    this.lockAccount = false,
    this.dark = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<StatementCubit>()),
        BlocProvider(create: (_) => serviceLocator<AccountCardsSummaryCubit>()),
      ],
      child: StatementExportPanel(
        initialAccountId: initialAccountId,
        lockAccount: lockAccount,
        dark: dark,
        padding: padding,
      ),
    );
  }
}

/// Opens the export panel as a bottom sheet — used from surfaces that are
/// already a sheet (the account-details sheet's Documents tab), where pushing
/// a full route would bury the sheet the user is standing in.
Future<void> showStatementExportSheet(
  BuildContext context, {
  String? accountId,
  bool dark = true,
}) {
  final background = dark ? const Color(0xFF151515) : Colors.white;
  final onBackground = dark ? Colors.white : const Color(0xFF1F2937);
  final handle = dark ? const Color(0xFF2F2F2F) : const Color(0xFFE5E7EB);

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: background,
    isScrollControlled: true,
    useSafeArea: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetCtx) => DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          SizedBox(height: 12.h),
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: handle,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Account statement',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: onBackground,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: onBackground, size: 20.sp),
                  onPressed: () => Navigator.pop(sheetCtx),
                ),
              ],
            ),
          ),
          Expanded(
            child: PrimaryScrollController(
              // Hands the panel's own SingleChildScrollView to the drag
              // sheet, so dragging the content resizes the sheet instead of
              // fighting it.
              controller: scrollController,
              child: StatementExportHost(
                initialAccountId: accountId,
                lockAccount: accountId != null && accountId.isNotEmpty,
                dark: dark,
                padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
