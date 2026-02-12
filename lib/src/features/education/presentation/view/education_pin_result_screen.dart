import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../../core/types/app_routes.dart';
import '../../domain/entities/education_pin_entity.dart';
import '../../domain/entities/education_provider_entity.dart';
import '../../domain/entities/education_purchase_entity.dart';
import '../../services/education_pdf_service.dart';

class EducationPinResultScreen extends StatefulWidget {
  const EducationPinResultScreen({super.key});

  @override
  State<EducationPinResultScreen> createState() =>
      _EducationPinResultScreenState();
}

class _EducationPinResultScreenState extends State<EducationPinResultScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  late EducationPurchaseEntity _purchase;
  EducationProviderEntity? _provider;
  bool _isDownloading = false;
  bool _isSharing = false;

  @override
  void initState() {
    super.initState();
    _loadArguments();
    _setupAnimations();
  }

  void _loadArguments() {
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _purchase = args['purchase'] as EducationPurchaseEntity;
      _provider = args['provider'] as EducationProviderEntity?;
    }
  }

  void _setupAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _copyPin(String pin) {
    Clipboard.setData(ClipboardData(text: pin));
    Get.snackbar(
      'Copied',
      'PIN copied to clipboard',
      backgroundColor: const Color(0xFF10B981),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _shareAllPins() async {
    if (_isSharing) return;
    setState(() => _isSharing = true);
    try {
      await EducationPdfService.shareReceipt(
        purchase: _purchase,
        provider: _provider,
      );
    } catch (e) {
      // Fallback to text share
      final buffer = StringBuffer();
      buffer.writeln('Education PINs - ${_provider?.name ?? 'Purchase'}');
      buffer.writeln('Reference: ${_purchase.reference}');
      buffer.writeln('');

      for (var i = 0; i < _purchase.pins.length; i++) {
        final pin = _purchase.pins[i];
        buffer.writeln('PIN ${i + 1}:');
        buffer.writeln('  PIN: ${pin.pin}');
        buffer.writeln('  Serial: ${pin.serial}');
        buffer.writeln('  Expires: ${pin.expiresAt}');
        buffer.writeln('');
      }

      buffer.writeln('Purchased via LazerVault');

      SharePlus.instance.share(ShareParams(text: buffer.toString()));
    } finally {
      if (mounted) setState(() => _isSharing = false);
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading) return;
    setState(() => _isDownloading = true);
    try {
      final path = await EducationPdfService.downloadReceipt(
        purchase: _purchase,
        provider: _provider,
      );
      Get.snackbar(
        'Download Complete',
        'Receipt saved: ${path.split('/').last}',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Could not download receipt.',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 3),
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.offAllNamed(AppRoutes.educationHome),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          'Your PINs',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                  child: Column(
                    children: [
                      // Success icon
                      _buildSuccessHeader(),

                      SizedBox(height: 24.h),

                      // Purchase info
                      _buildPurchaseInfo(),

                      SizedBox(height: 20.h),

                      // PIN cards
                      ..._purchase.pins.asMap().entries.map(
                            (entry) => _buildPinCard(entry.key, entry.value),
                          ),

                      SizedBox(height: 16.h),

                      // Message from server
                      if (_purchase.message.isNotEmpty)
                        _buildMessageCard(),
                    ],
                  ),
                ),
              ),
            ),

            // Bottom actions
            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xFF10B981),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Purchase Successful!',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '${_purchase.pins.length} ${_purchase.pins.length == 1 ? 'PIN' : 'PINs'} generated successfully',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseInfo() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFF2D2D2D),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow('Provider', _provider?.name ?? _purchase.billType),
          SizedBox(height: 8.h),
          _buildInfoRow('Reference', _purchase.reference),
          SizedBox(height: 8.h),
          _buildInfoRow('Amount Paid', '\u20A6${_formatAmount(_purchase.amount)}'),
          if (_purchase.newBalance > 0) ...[
            SizedBox(height: 8.h),
            _buildInfoRow(
              'New Balance',
              '\u20A6${_formatAmount(_purchase.newBalance)}',
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPinCard(int index, EducationPinEntity pin) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFF3B82F6).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28.w,
                    height: 28.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'PIN ${index + 1}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _copyPin(pin.pin),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.copy,
                        size: 14.sp,
                        color: const Color(0xFF3B82F6),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'Copy PIN',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF3B82F6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // PIN number (large, prominent)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: const Color(0xFF0A0A0A),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xFF2D2D2D),
                width: 1,
              ),
            ),
            child: SelectableText(
              pin.pin,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 2.0,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 12.h),

          // Serial and expiry
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Serial Number',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      pin.serial,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Expires',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      pin.expiresAt,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFB923C).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: const Color(0xFFFB923C).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 18.sp,
            color: const Color(0xFFFB923C),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              _purchase.message,
              style: TextStyle(
                fontSize: 13.sp,
                color: const Color(0xFFFB923C),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2D2D2D),
            width: 1,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Share and Download row
          Row(
            children: [
              // Share all PINs button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isSharing ? null : _shareAllPins,
                  icon: _isSharing
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(Icons.share, size: 18.sp),
                  label: Text(
                    'Share PINs',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3B82F6),
                    disabledBackgroundColor:
                        const Color(0xFF3B82F6).withValues(alpha: 0.4),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Download PDF button
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isDownloading ? null : _downloadReceipt,
                  icon: _isDownloading
                      ? SizedBox(
                          width: 18.sp,
                          height: 18.sp,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Icon(Icons.download, size: 18.sp),
                  label: Text(
                    'Download PDF',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    disabledBackgroundColor:
                        const Color(0xFF10B981).withValues(alpha: 0.4),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Back to Home button
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.educationHome),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2D2D2D)),
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAmount(double amount) {
    if (amount >= 1000) {
      final intAmount = amount.toInt();
      final result = StringBuffer();
      final str = intAmount.toString();
      for (var i = 0; i < str.length; i++) {
        if (i > 0 && (str.length - i) % 3 == 0) {
          result.write(',');
        }
        result.write(str[i]);
      }
      return result.toString();
    }
    return amount.toStringAsFixed(0);
  }
}
