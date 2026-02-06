import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/core/utils/currency_formatter.dart' as currency_formatter;
import '../../services/contactless_pdf_service.dart';
import '../../domain/entities/contactless_payment_entity.dart';

class PaymentSuccessScreen extends StatefulWidget {
  final double amount;
  final String currency;
  final String payerName;
  final String? referenceNumber;
  final bool isReceiver;
  final String? category;
  final String? description;
  final DateTime? transactionDate;
  final ContactlessTransactionEntity? transaction;
  final String? receiverName;
  final String? receiverUsername;
  final String? payerUsername;
  final String? accountNumber;

  const PaymentSuccessScreen({
    super.key,
    required this.amount,
    required this.currency,
    required this.payerName,
    this.referenceNumber,
    required this.isReceiver,
    this.category,
    this.description,
    this.transactionDate,
    this.transaction,
    this.receiverName,
    this.receiverUsername,
    this.payerUsername,
    this.accountNumber,
  });

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _checkController;
  late AnimationController _contentController;
  late AnimationController _confettiController;
  late Animation<double> _checkScale;
  late Animation<double> _checkOpacity;
  late Animation<double> _ringExpand;
  late Animation<double> _contentFade;
  late Animation<Offset> _contentSlide;

  final List<_ConfettiParticle> _particles = [];

  bool _isGeneratingPdf = false;
  bool _isDownloading = false;

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();

    _checkController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _contentController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _confettiController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );

    _checkScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _checkOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );

    _ringExpand = Tween<double>(begin: 0.5, end: 1.4).animate(
      CurvedAnimation(
        parent: _checkController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _contentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _contentSlide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _contentController, curve: Curves.easeOut),
    );

    _generateParticles();

    _checkController.forward().then((_) {
      _contentController.forward();
      _confettiController.forward();
    });
  }

  void _generateParticles() {
    final random = Random();
    const colors = [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
      Color(0xFF10B981),
      Color(0xFFF59E0B),
      Color(0xFFEC4899),
      Color(0xFF3B82F6),
    ];
    for (int i = 0; i < 30; i++) {
      _particles.add(_ConfettiParticle(
        color: colors[random.nextInt(colors.length)],
        startX: random.nextDouble(),
        startY: -0.1 - random.nextDouble() * 0.3,
        endX: random.nextDouble(),
        endY: 1.0 + random.nextDouble() * 0.2,
        size: 4 + random.nextDouble() * 6,
        rotation: random.nextDouble() * 2 * pi,
        rotationSpeed: (random.nextDouble() - 0.5) * 6,
      ));
    }
  }

  @override
  void dispose() {
    _checkController.dispose();
    _contentController.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  String get _formattedAmount {
    return currency_formatter.CurrencySymbols.formatAmountWithCurrency(widget.amount, widget.currency);
  }

  String get _formattedDate {
    final date = widget.transactionDate ?? DateTime.now();
    return DateFormat('MMM dd, yyyy • hh:mm a').format(date);
  }

  IconData get _categoryIcon {
    switch (widget.category?.toLowerCase()) {
      case 'food':
        return Icons.restaurant_rounded;
      case 'transport':
        return Icons.directions_car_rounded;
      case 'shopping':
        return Icons.shopping_bag_rounded;
      case 'services':
        return Icons.build_rounded;
      case 'bills':
        return Icons.receipt_long_rounded;
      default:
        return Icons.contactless_rounded;
    }
  }

  Future<void> _shareReceipt() async {
    if (_isGeneratingPdf) return;

    // If transaction entity is available, generate PDF
    if (widget.transaction != null) {
      setState(() => _isGeneratingPdf = true);
      try {
        if (widget.isReceiver) {
          // Receiver sharing receipt
          await ContactlessPdfService.shareReceiverReceipt(
            transaction: widget.transaction!,
            accountNumber: widget.accountNumber,
          );
        } else {
          // Payer sharing receipt
          await ContactlessPdfService.sharePayerReceipt(
            transaction: widget.transaction!,
            accountNumber: widget.accountNumber,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to share receipt: $e',
          backgroundColor: const Color(0xFFEF4444),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        if (mounted) setState(() => _isGeneratingPdf = false);
      }
    } else {
      // Fallback to text-based receipt
      final buffer = StringBuffer();
      buffer.writeln('LazerVault Payment Receipt');
      buffer.writeln('─────────────────────────');
      buffer.writeln('Amount: $_formattedAmount');
      buffer.writeln(
          '${widget.isReceiver ? "From" : "To"}: ${widget.payerName}');
      if (widget.description != null && widget.description!.isNotEmpty) {
        buffer.writeln('Description: ${widget.description}');
      }
      if (widget.category != null) {
        buffer.writeln('Category: ${widget.category}');
      }
      if (widget.referenceNumber != null) {
        buffer.writeln('Reference: ${widget.referenceNumber}');
      }
      buffer.writeln('Date: $_formattedDate');
      buffer.writeln('Status: Completed ✓');
      buffer.writeln('─────────────────────────');
      buffer.writeln('Powered by LazerVault');

      await SharePlus.instance.share(
          ShareParams(text: buffer.toString(), subject: 'Payment Receipt'));
    }
  }

  Future<void> _downloadReceipt() async {
    if (_isDownloading || widget.transaction == null) return;

    setState(() => _isDownloading = true);
    try {
      // File path is returned but not displayed directly
      await (widget.isReceiver
          ? ContactlessPdfService.downloadReceiverReceipt(
              transaction: widget.transaction!,
              accountNumber: widget.accountNumber,
            )
          : ContactlessPdfService.downloadPayerReceipt(
              transaction: widget.transaction!,
              accountNumber: widget.accountNumber,
            ));

      HapticFeedback.mediumImpact();
      Get.snackbar(
        'Downloaded',
        'Receipt saved to Downloads',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to download receipt: $e',
        backgroundColor: const Color(0xFFEF4444),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  void _copyReference() {
    if (widget.referenceNumber != null) {
      Clipboard.setData(ClipboardData(text: widget.referenceNumber!));
      HapticFeedback.lightImpact();
      Get.snackbar(
        'Copied',
        'Reference number copied to clipboard',
        backgroundColor: const Color(0xFF1F1F35),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.all(16.w),
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A3E), Color(0xFF0A0E27), Color(0xFF0F0F23)],
          ),
        ),
        child: Stack(
          children: [
            // Confetti
            AnimatedBuilder(
              animation: _confettiController,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  ),
                  painter: _ConfettiPainter(
                    particles: _particles,
                    progress: _confettiController.value,
                  ),
                );
              },
            ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    // Animated check icon
                    AnimatedBuilder(
                      animation: _checkController,
                      builder: (context, _) {
                        return Opacity(
                          opacity: _checkOpacity.value,
                          child: Transform.scale(
                            scale: _checkScale.value,
                            child: SizedBox(
                              width: 140.w,
                              height: 140.w,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Expanding ring
                                  Transform.scale(
                                    scale: _ringExpand.value,
                                    child: Container(
                                      width: 140.w,
                                      height: 140.w,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF10B981)
                                              .withValues(
                                                  alpha: 1.0 -
                                                      (_ringExpand.value - 0.5) /
                                                          0.9),
                                          width: 2.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Inner circle
                                  Container(
                                    width: 110.w,
                                    height: 110.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFF10B981),
                                          Color(0xFF059669),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF10B981)
                                              .withValues(alpha: 0.4),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.check_rounded,
                                      size: 56.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 32.h),

                    // Content
                    SlideTransition(
                      position: _contentSlide,
                      child: FadeTransition(
                        opacity: _contentFade,
                        child: Column(
                          children: [
                            Text(
                              widget.isReceiver
                                  ? 'Payment Received!'
                                  : 'Payment Successful!',
                              style: GoogleFonts.inter(
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              _formattedDate,
                              style: GoogleFonts.inter(
                                fontSize: 13.sp,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),

                    // Receipt card
                    Expanded(
                      child: SlideTransition(
                        position: _contentSlide,
                        child: FadeTransition(
                          opacity: _contentFade,
                          child: SingleChildScrollView(
                            child: _buildReceiptCard(),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // Action buttons
                    SlideTransition(
                      position: _contentSlide,
                      child: FadeTransition(
                        opacity: _contentFade,
                        child: Column(
                          children: [
                            // Download receipt button
                            if (widget.transaction != null) ...[
                              SizedBox(
                                width: double.infinity,
                                height: 52.h,
                                child: OutlinedButton.icon(
                                  onPressed: _isDownloading ? null : _downloadReceipt,
                                  icon: _isDownloading
                                      ? SizedBox(
                                          width: 18.sp,
                                          height: 18.sp,
                                          child: const CircularProgressIndicator(
                                            color: Color(0xFF8B5CF6),
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : Icon(Icons.download_rounded, size: 18.sp),
                                  label: Text(
                                    _isDownloading ? 'Downloading...' : 'Download Receipt',
                                    style: GoogleFonts.inter(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: const Color(0xFF8B5CF6),
                                    side: const BorderSide(
                                      color: Color(0xFF8B5CF6),
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(14.r),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                            // Share receipt
                            SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: OutlinedButton.icon(
                                onPressed: _isGeneratingPdf ? null : _shareReceipt,
                                icon: _isGeneratingPdf
                                    ? SizedBox(
                                        width: 18.sp,
                                        height: 18.sp,
                                        child: const CircularProgressIndicator(
                                          color: Color(0xFF8B5CF6),
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(Icons.share_rounded, size: 18.sp),
                                label: Text(
                                  _isGeneratingPdf ? 'Generating PDF...' : 'Share Receipt',
                                  style: GoogleFonts.inter(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF8B5CF6),
                                  side: const BorderSide(
                                    color: Color(0xFF8B5CF6),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12.h),

                            // Done button
                            SizedBox(
                              width: double.infinity,
                              height: 52.h,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF6366F1),
                                      Color(0xFF8B5CF6),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(14.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6366F1)
                                          .withValues(alpha: 0.4),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    HapticFeedback.mediumImpact();
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14.r),
                                    ),
                                  ),
                                  child: Text(
                                    'Done',
                                    style: GoogleFonts.inter(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReceiptCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2A2A3E), Color(0xFF1F1F35)],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        children: [
          // Amount section
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF10B981).withValues(alpha: 0.15),
                  const Color(0xFF059669).withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  _categoryIcon,
                  size: 32.sp,
                  color: const Color(0xFF10B981),
                ),
                SizedBox(height: 12.h),
                Text(
                  _formattedAmount,
                  style: GoogleFonts.inter(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF10B981),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Completed',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Dashed divider
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: List.generate(
                30,
                (index) => Expanded(
                  child: Container(
                    height: 1,
                    color: index.isEven
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.transparent,
                  ),
                ),
              ),
            ),
          ),

          // Details
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                _buildDetailRow(
                  widget.isReceiver ? 'From' : 'To',
                  widget.payerName,
                  icon: Icons.person_rounded,
                ),
                if (widget.description != null &&
                    widget.description!.isNotEmpty) ...[
                  SizedBox(height: 16.h),
                  _buildDetailRow(
                    'Description',
                    widget.description!,
                    icon: Icons.notes_rounded,
                  ),
                ],
                if (widget.category != null) ...[
                  SizedBox(height: 16.h),
                  _buildDetailRow(
                    'Category',
                    widget.category!,
                    icon: _categoryIcon,
                  ),
                ],
                SizedBox(height: 16.h),
                _buildDetailRow(
                  'Type',
                  'Contactless (NFC)',
                  icon: Icons.contactless_rounded,
                ),
                if (widget.referenceNumber != null) ...[
                  SizedBox(height: 16.h),
                  _buildReferenceRow(),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {IconData? icon}) {
    return Row(
      children: [
        if (icon != null) ...[
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 18.sp, color: const Color(0xFF8B5CF6)),
          ),
          SizedBox(width: 12.w),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReferenceRow() {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(Icons.tag_rounded,
              size: 18.sp, color: const Color(0xFF8B5CF6)),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reference',
                style: GoogleFonts.inter(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF9CA3AF),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                widget.referenceNumber!,
                style: GoogleFonts.inter(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: _copyReference,
          child: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.copy_rounded,
              size: 16.sp,
              color: const Color(0xFF8B5CF6),
            ),
          ),
        ),
      ],
    );
  }
}

class _ConfettiParticle {
  final Color color;
  final double startX;
  final double startY;
  final double endX;
  final double endY;
  final double size;
  final double rotation;
  final double rotationSpeed;

  _ConfettiParticle({
    required this.color,
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.size,
    required this.rotation,
    required this.rotationSpeed,
  });
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiParticle> particles;
  final double progress;

  _ConfettiPainter({required this.particles, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final x = size.width * (p.startX + (p.endX - p.startX) * progress);
      final y = size.height * (p.startY + (p.endY - p.startY) * progress);
      final opacity = (1.0 - progress).clamp(0.0, 1.0);

      final paint = Paint()
        ..color = p.color.withValues(alpha: opacity * 0.8)
        ..style = PaintingStyle.fill;

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(p.rotation + p.rotationSpeed * progress);
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: p.size, height: p.size * 0.5),
          const Radius.circular(1),
        ),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
