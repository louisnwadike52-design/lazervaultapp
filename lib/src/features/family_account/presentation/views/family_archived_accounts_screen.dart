import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:lazervault/core/shared_widgets/lazer_vault_loader.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';
import 'package:lazervault/src/features/family_account/domain/entities/family_account_entities.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_cubit.dart';
import 'package:lazervault/src/features/family_account/presentation/cubit/family_account_state.dart';

/// The accounts a creator has closed — kept, not erased.
///
/// Closing a Family & Friends account returns the pool balance, frees a slot
/// against the per-creator cap, and sets the row to `archived`. Archived rows are
/// excluded from every other read — the carousel, the pickers, the list screen —
/// so without this screen the data was retained and unreachable, which is
/// indistinguishable from having been deleted.
///
/// Read-only by design. Re-opening an archived account would silently consume a
/// slot the creator has already been given back, and the members' access was
/// revoked on close, so "restore" is a different feature with its own consent
/// questions rather than a button here.
class FamilyArchivedAccountsScreen extends StatefulWidget {
  const FamilyArchivedAccountsScreen({super.key});

  @override
  State<FamilyArchivedAccountsScreen> createState() =>
      _FamilyArchivedAccountsScreenState();
}

class _FamilyArchivedAccountsScreenState
    extends State<FamilyArchivedAccountsScreen> {
  static const _bg = Color(0xFF0A0A0A);
  static const _card = Color(0xFF16161F);
  static const _border = Color(0xFF26262F);
  static const _muted = Color(0xFF8A8AA3);

  /// The status the SERVER filters on. Sent through to the RPC rather than
  /// filtered locally: an unfiltered read already excludes archived rows, so a
  /// client-side filter for them could only ever return nothing.
  static const _archivedStatus = 'archived';

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    context
        .read<FamilyAccountCubit>()
        .loadFamilyAccounts(statusFilter: _archivedStatus);
  }

  /// Matches the rest of the family feature, which formats with the ACTIVE
  /// account's symbol rather than a per-account one. The family proto does carry
  /// `currency` (field 19), but no Flutter layer maps it through, so inventing a
  /// per-account symbol here would be the only place in the feature claiming to
  /// know something the app never actually read.
  String _money(double v) =>
      '${CurrencySymbols.currentSymbol}${NumberFormat('#,##0.00').format(v)}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Previous accounts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<FamilyAccountCubit, FamilyAccountState>(
        builder: (context, state) {
          if (state is FamilyAccountLoading) {
            return const Center(child: LazerVaultLoader.medium());
          }
          if (state is FamilyAccountError) {
            return _buildError(state.message);
          }
          if (state is FamilyAccountsLoaded) {
            // Belt and braces: the server filters, and this drops anything a
            // stale or older server might still send through. Showing a LIVE
            // account on a screen titled "Previous accounts" would be worse than
            // showing none.
            final archived = state.familyAccounts
                .where((a) => a.status == FamilyAccountStatus.archived)
                .toList();
            if (archived.isEmpty) return _buildEmpty();
            return RefreshIndicator(
              onRefresh: () async => _load(),
              color: const Color(0xFF4F46E5),
              backgroundColor: _card,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
                itemCount: archived.length + 1,
                itemBuilder: (context, i) {
                  if (i == 0) return _buildHeaderNote(archived.length);
                  return _buildArchivedCard(archived[i - 1]);
                },
              ),
            );
          }
          return const Center(child: LazerVaultLoader.medium());
        },
      ),
    );
  }

  Widget _buildHeaderNote(int count) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Text(
        // Says what the list is and what it is not, so nobody taps expecting to
        // spend from one of these.
        '$count closed account${count == 1 ? '' : 's'}. Their balances were '
        'returned when you closed them and their slots are free to reuse. '
        'Kept here for your records.',
        style: TextStyle(color: _muted, fontSize: 12.sp, height: 1.45),
      ),
    );
  }

  Widget _buildArchivedCard(FamilyAccount account) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: _card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(Icons.archive_outlined,
                    color: const Color(0xFF9CA3AF), size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      account.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.5.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      _subtitleFor(account),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: _muted, fontSize: 11.5.sp),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF9CA3AF).withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'Closed',
                  style: TextStyle(
                    color: const Color(0xFF9CA3AF),
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Divider(color: _border, height: 1),
          SizedBox(height: 10.h),
          _line('Opened', DateFormat('d MMM yyyy').format(account.createdAt)),
          // updated_at IS the close date for these rows: archiving is the last
          // write an account receives, and every later read and write path
          // excludes archived rows. The proto carries no archived_at, and
          // showing a date the server never sent would be worse on a record kept
          // for the user's own documentation.
          _line('Closed', DateFormat('d MMM yyyy').format(account.updatedAt)),
          _line('Balance returned on close', _money(account.totalBalance)),
        ],
      ),
    );
  }

  String _subtitleFor(FamilyAccount account) {
    final count = account.members.length;
    final members = '$count member${count == 1 ? '' : 's'}';
    final note = (account.description ?? '').trim();
    return note.isEmpty ? members : '$members · $note';
  }

  Widget _line(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: _muted, fontSize: 12.sp)),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.archive_outlined, size: 44.sp, color: _muted),
            SizedBox(height: 14.h),
            Text(
              'No closed accounts',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              'When you close a Family & Friends account it moves here, with '
              'its history, and its slot frees up.',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, fontSize: 12.5.sp, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline_rounded,
                size: 42.sp, color: const Color(0xFFEF4444)),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, fontSize: 13.sp),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _load,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
