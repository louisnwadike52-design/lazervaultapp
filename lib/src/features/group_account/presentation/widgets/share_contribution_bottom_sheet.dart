import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/group_entities.dart';
import '../../services/group_account_pdf_service.dart';
import '../../utils/group_export_helper.dart';

enum SharePlatform {
  whatsapp,
  telegram,
  email,
  sms,
  copyLink,
  other,
}

enum ShareFormat {
  summaryText,
  pdfReport,
  csvSpreadsheet,
}

class ShareContributionBottomSheet extends StatefulWidget {
  final Contribution contribution;
  final String groupName;
  final List<GroupMember> members;
  final List<ContributionPayment> payments;

  const ShareContributionBottomSheet({
    super.key,
    required this.contribution,
    required this.groupName,
    required this.members,
    required this.payments,
  });

  @override
  State<ShareContributionBottomSheet> createState() => _ShareContributionBottomSheetState();
}

class _ShareContributionBottomSheetState extends State<ShareContributionBottomSheet> {
  SharePlatform? _selectedPlatform;
  ShareFormat _selectedFormat = ShareFormat.summaryText;
  bool _isGenerating = false;
  String? _generatedContent;
  File? _generatedFile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 24.h),
                _buildFormatSelector(),
                SizedBox(height: 24.h),
                _buildPreview(),
                SizedBox(height: 24.h),
                _buildPlatformSelector(),
                SizedBox(height: 24.h),
                _buildShareButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.share,
            color: const Color.fromARGB(255, 78, 3, 208),
            size: 24.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Share Contribution',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                widget.contribution.title,
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 14.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.close,
            color: Colors.grey[400],
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildFormatSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Format',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            _buildFormatOption(
              format: ShareFormat.summaryText,
              icon: Icons.text_snippet,
              label: 'Summary',
            ),
            SizedBox(width: 12.w),
            _buildFormatOption(
              format: ShareFormat.pdfReport,
              icon: Icons.picture_as_pdf,
              label: 'PDF Report',
            ),
            SizedBox(width: 12.w),
            _buildFormatOption(
              format: ShareFormat.csvSpreadsheet,
              icon: Icons.table_chart,
              label: 'Spreadsheet',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFormatOption({
    required ShareFormat format,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedFormat == format;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedFormat = format;
            _generatedContent = null;
            _generatedFile = null;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromARGB(255, 78, 3, 208).withValues(alpha: 0.2)
                : const Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? const Color.fromARGB(255, 78, 3, 208)
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected
                    ? const Color.fromARGB(255, 78, 3, 208)
                    : Colors.grey[400],
                size: 24.sp,
              ),
              SizedBox(height: 8.h),
              Text(
                label,
                style: GoogleFonts.inter(
                  color: isSelected ? Colors.white : Colors.grey[400],
                  fontSize: 12.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2D2D),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.visibility,
                color: Colors.grey[400],
                size: 16.sp,
              ),
              SizedBox(width: 8.w),
              Text(
                'Preview',
                style: GoogleFonts.inter(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            _getPreviewText(),
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 13.sp,
              height: 1.5,
            ),
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Share via',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: [
            _buildPlatformChip(
              platform: SharePlatform.whatsapp,
              icon: Icons.chat,
              label: 'WhatsApp',
              color: const Color(0xFF25D366),
            ),
            _buildPlatformChip(
              platform: SharePlatform.telegram,
              icon: Icons.send,
              label: 'Telegram',
              color: const Color(0xFF0088CC),
            ),
            _buildPlatformChip(
              platform: SharePlatform.email,
              icon: Icons.email,
              label: 'Email',
              color: const Color(0xFFEA4335),
            ),
            _buildPlatformChip(
              platform: SharePlatform.sms,
              icon: Icons.sms,
              label: 'SMS',
              color: const Color(0xFF34A853),
            ),
            _buildPlatformChip(
              platform: SharePlatform.copyLink,
              icon: Icons.copy,
              label: 'Copy',
              color: Colors.grey[600]!,
            ),
            _buildPlatformChip(
              platform: SharePlatform.other,
              icon: Icons.more_horiz,
              label: 'More',
              color: const Color.fromARGB(255, 78, 3, 208),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlatformChip({
    required SharePlatform platform,
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final isSelected = _selectedPlatform == platform;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedPlatform = platform;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : const Color(0xFF2D2D2D),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[400],
              size: 18.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: GoogleFonts.inter(
                color: isSelected ? color : Colors.grey[400],
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareButton() {
    final canShare = _selectedPlatform != null;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canShare && !_isGenerating ? _handleShare : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 78, 3, 208),
          disabledBackgroundColor: Colors.grey[700],
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: _isGenerating
            ? SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Share',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  String _getPreviewText() {
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);
    final dateFormat = DateFormat('MMM d, yyyy');
    final c = widget.contribution;

    switch (_selectedFormat) {
      case ShareFormat.summaryText:
        final progress = c.targetAmount > 0
            ? ((c.currentAmount / c.targetAmount) * 100).toStringAsFixed(0)
            : '0';

        return '''${widget.groupName} - ${c.title}

Target: ${currencyFormat.format(c.targetAmount / 100)}
Collected: ${currencyFormat.format(c.currentAmount / 100)}
Progress: $progress%
Deadline: ${dateFormat.format(c.deadline)}
Members: ${widget.members.length}

Join us on LazerVault!''';

      case ShareFormat.pdfReport:
        return 'A detailed PDF report will be generated containing:\n\n'
            '\u2022 Contribution summary\n'
            '\u2022 Progress tracking\n'
            '\u2022 Member contributions breakdown\n'
            '\u2022 Payment history';

      case ShareFormat.csvSpreadsheet:
        return 'A CSV spreadsheet will be generated containing:\n\n'
            '\u2022 Member payment status\n'
            '\u2022 Amount paid by each member\n'
            '\u2022 Remaining balances\n'
            '\u2022 Last payment dates';
    }
  }

  Future<void> _handleShare() async {
    if (_selectedPlatform == null) return;

    setState(() {
      _isGenerating = true;
    });

    try {
      // Generate content based on format
      String? textContent;
      File? fileToShare;

      switch (_selectedFormat) {
        case ShareFormat.summaryText:
          textContent = _generateSummaryText();
          break;

        case ShareFormat.pdfReport:
          fileToShare = await GroupAccountPdfService.generateContributionReport(
            contribution: widget.contribution,
            payments: widget.payments,
            members: widget.members,
            groupName: widget.groupName,
          );
          break;

        case ShareFormat.csvSpreadsheet:
          fileToShare = await GroupExportHelper.exportPaidUnpaidSpreadsheet(
            contribution: widget.contribution,
            members: widget.members,
            payments: widget.payments,
          );
          break;
      }

      // Share based on platform
      await _shareToPlatform(_selectedPlatform!, textContent, fileToShare);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Shared successfully'),
            backgroundColor: const Color(0xFF10B981),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to share: ${e.toString()}'),
            backgroundColor: const Color(0xFFEF4444),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGenerating = false;
        });
      }
    }
  }

  String _generateSummaryText() {
    final currencyFormat = NumberFormat.currency(symbol: '\u20A6', decimalDigits: 0);
    final dateFormat = DateFormat('MMM d, yyyy');
    final c = widget.contribution;
    final progress = c.targetAmount > 0
        ? ((c.currentAmount / c.targetAmount) * 100).toStringAsFixed(0)
        : '0';

    return '''${widget.groupName}

${c.title}

Target: ${currencyFormat.format(c.targetAmount / 100)}
Collected: ${currencyFormat.format(c.currentAmount / 100)}
Progress: $progress%
Deadline: ${dateFormat.format(c.deadline)}
Members: ${widget.members.length}

Join us on LazerVault to contribute!
https://lazervault.app/groups''';
  }

  Future<void> _shareToPlatform(SharePlatform platform, String? text, File? file) async {
    switch (platform) {
      case SharePlatform.whatsapp:
        if (file != null) {
          await Share.shareXFiles([XFile(file.path)], text: text);
        } else if (text != null) {
          final encoded = Uri.encodeComponent(text);
          final url = Uri.parse('whatsapp://send?text=$encoded');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            // Fallback to system share
            await Share.share(text);
          }
        }
        break;

      case SharePlatform.telegram:
        if (file != null) {
          await Share.shareXFiles([XFile(file.path)], text: text);
        } else if (text != null) {
          final encoded = Uri.encodeComponent(text);
          final url = Uri.parse('tg://msg?text=$encoded');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            await Share.share(text);
          }
        }
        break;

      case SharePlatform.email:
        if (file != null) {
          await Share.shareXFiles(
            [XFile(file.path)],
            subject: 'Contribution Report: ${widget.contribution.title}',
            text: text,
          );
        } else if (text != null) {
          final subject = Uri.encodeComponent('Contribution: ${widget.contribution.title}');
          final body = Uri.encodeComponent(text);
          final url = Uri.parse('mailto:?subject=$subject&body=$body');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            await Share.share(text, subject: 'Contribution: ${widget.contribution.title}');
          }
        }
        break;

      case SharePlatform.sms:
        if (text != null) {
          final encoded = Uri.encodeComponent(text);
          final url = Uri.parse('sms:?body=$encoded');
          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          } else {
            await Share.share(text);
          }
        } else if (file != null) {
          await Share.shareXFiles([XFile(file.path)]);
        }
        break;

      case SharePlatform.copyLink:
        if (text != null) {
          await Clipboard.setData(ClipboardData(text: text));
        } else if (file != null) {
          await Clipboard.setData(ClipboardData(text: file.path));
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Copied to clipboard'),
              backgroundColor: const Color(0xFF10B981),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        break;

      case SharePlatform.other:
        if (file != null) {
          await Share.shareXFiles([XFile(file.path)], text: text);
        } else if (text != null) {
          await Share.share(text, subject: widget.contribution.title);
        }
        break;
    }
  }
}
