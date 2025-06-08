import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:lazervault/core/types/app_routes.dart';

class BatchTransferReceiptScreen extends StatefulWidget {
  const BatchTransferReceiptScreen({super.key});

  @override
  State<BatchTransferReceiptScreen> createState() => _BatchTransferReceiptScreenState();
}

class _BatchTransferReceiptScreenState extends State<BatchTransferReceiptScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _checkAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _checkAnimation;

  Map<String, dynamic> batchTransferDetails = {};

  @override
  void initState() {
    super.initState();
    _initializeData();
    _setupAnimations();
  }

  void _initializeData() {
    batchTransferDetails = Get.arguments as Map<String, dynamic>? ?? {};
  }

  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    _checkAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    
    _checkAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _checkAnimationController, curve: Curves.easeInOut),
    );
    
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _checkAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _checkAnimationController.dispose();
    super.dispose();
  }

  // Navigate to dashboard - used for all back navigation
  void _navigateToDashboard() {
    Get.offAllNamed('/home');
  }

  Future<void> _downloadBatchReceipt() async {
    try {
      final pdf = await _generatePDF();
      await _savePDFToDevice(pdf);
      
      Get.snackbar(
        'Download Complete',
        'Batch transfer receipt saved to Downloads',
        backgroundColor: Colors.green[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Download Failed',
        'Unable to download receipt: ${e.toString()}',
        backgroundColor: Colors.red[600],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  Future<void> _shareReceipt() async {
    try {
      final pdf = await _generatePDF();
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/batch_transfer_receipt.pdf');
      await file.writeAsBytes(await pdf.save());

      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Batch Transfer Receipt - LazerVault',
        subject: 'Batch Transfer Receipt',
      );
    } catch (e) {
      // Fallback to text sharing if PDF sharing fails
      final shareText = _generateShareText();
      await Share.share(
        shareText,
        subject: 'Batch Transfer Receipt - LazerVault',
      );
    }
  }

  Future<pw.Document> _generatePDF() async {
    final pdf = pw.Document();
    
    // Mock data - replace with actual data from batchTransferDetails
    final batchId = batchTransferDetails['batchId'] ?? 'BTX${DateTime.now().millisecondsSinceEpoch}';
    final totalAmount = batchTransferDetails['totalAmount'] ?? 250.00;
    final totalFee = batchTransferDetails['totalFee'] ?? 2.50;
    final timestamp = DateTime.now();
    
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Column(
                  children: [
                    pw.Text(
                      'LazerVault',
                      style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      'Batch Transfer Receipt',
                      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 30),
              
              // Transfer Details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Batch ID: $batchId'),
                      pw.SizedBox(height: 5),
                      pw.Text('Date: ${DateFormat('MMM dd, yyyy HH:mm').format(timestamp)}'),
                      pw.SizedBox(height: 5),
                      pw.Text('Status: Completed'),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Total Amount: £${totalAmount.toStringAsFixed(2)}'),
                      pw.SizedBox(height: 5),
                      pw.Text('Total Fee: £${totalFee.toStringAsFixed(2)}'),
                      pw.SizedBox(height: 5),
                      pw.Text('Grand Total: £${(totalAmount + totalFee).toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 30),
              
              // Transfer Results
              pw.Text(
                'Transfer Results',
                style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 15),
              
              // Mock transfer results table
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Recipient', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Status', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                      ),
                    ],
                  ),
                  // Mock data rows
                  ...List.generate(3, (index) => pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Recipient ${index + 1}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('£${(75.0 + index * 25).toStringAsFixed(2)}'),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text('Completed'),
                      ),
                    ],
                  )),
                ],
              ),
              
              pw.Spacer(),
              
              // Footer
              pw.Container(
                alignment: pw.Alignment.center,
                child: pw.Text(
                  'Thank you for using LazerVault',
                  style: pw.TextStyle(fontSize: 12, color: PdfColors.grey600),
                ),
              ),
            ],
          );
        },
      ),
    );
    
    return pdf;
  }

  Future<void> _savePDFToDevice(pw.Document pdf) async {
    if (Platform.isAndroid) {
      // For Android, save to Downloads directory
      final directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      final file = File('${directory.path}/batch_transfer_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
    } else {
      // For iOS, use the documents directory
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/batch_transfer_receipt_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
    }
  }

  String _generateShareText() {
    final batchId = batchTransferDetails['batchId'] ?? 'BTX${DateTime.now().millisecondsSinceEpoch}';
    final totalAmount = batchTransferDetails['totalAmount'] ?? 250.00;
    final totalFee = batchTransferDetails['totalFee'] ?? 2.50;
    final timestamp = DateTime.now();
    
    return '''
LazerVault - Batch Transfer Receipt

Batch ID: $batchId
Date: ${DateFormat('MMM dd, yyyy HH:mm').format(timestamp)}
Status: Completed

Total Amount: £${totalAmount.toStringAsFixed(2)}
Total Fee: £${totalFee.toStringAsFixed(2)}
Grand Total: £${(totalAmount + totalFee).toStringAsFixed(2)}

Thank you for using LazerVault!
''';
  }

  void _startAnotherTransfer() {
    Get.offAllNamed(AppRoutes.batchTransfer);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          _navigateToDashboard();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F23),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A3E),
                const Color(0xFF0F0F23),
                const Color(0xFF0A0A1A),
              ],
            ),
          ),
          child: SafeArea(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        children: [
                          _buildSuccessCard(),
                          SizedBox(height: 24.h),
                          _buildBatchSummary(),
                          SizedBox(height: 24.h),
                          _buildTransferResults(),
                          SizedBox(height: 24.h),
                          _buildActionButtons(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: _navigateToDashboard,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batch Transfer Complete',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Your batch transfer has been processed',
                  style: GoogleFonts.inter(
                    color: Colors.grey[400],
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _navigateToDashboard,
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
              ),
              child: Icon(
                Icons.home,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessCard() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green[600]!.withValues(alpha: 0.2), Colors.green[400]!.withValues(alpha: 0.1)],
          ),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            AnimatedBuilder(
              animation: _checkAnimation,
              builder: (context, child) {
                return Container(
                  width: 80.w,
                  height: 80.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.green[600]!, Colors.green[400]!],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Transform.scale(
                    scale: _checkAnimation.value,
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 40.sp,
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16.h),
            Text(
              'Transfer Successful!',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'All transfers in your batch have been processed successfully',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: Colors.grey[300],
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchSummary() {
    // Mock data - replace with actual data from batchTransferDetails
    final batchId = batchTransferDetails['batchId'] ?? 'BTX${DateTime.now().millisecondsSinceEpoch}';
    final totalAmount = batchTransferDetails['totalAmount'] ?? 250.00;
    final totalFee = batchTransferDetails['totalFee'] ?? 2.50;
    final recipientCount = batchTransferDetails['recipientCount'] ?? 3;
    final timestamp = DateTime.now();

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Batch Summary',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          
          _buildSummaryRow('Batch ID', batchId),
          _buildSummaryRow('Date & Time', DateFormat('MMM dd, yyyy • HH:mm').format(timestamp)),
          _buildSummaryRow('Recipients', '$recipientCount transfers'),
          _buildSummaryRow('Total Amount', '£${totalAmount.toStringAsFixed(2)}'),
          _buildSummaryRow('Total Fee', '£${totalFee.toStringAsFixed(2)}'),
          
          Divider(color: Colors.white.withValues(alpha: 0.2), height: 24.h),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '£${(totalAmount + totalFee).toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  color: Colors.green[400],
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.grey[400],
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferResults() {
    // Mock results - replace with actual data from batchTransferDetails
    final mockResults = [
      {'name': 'John Doe', 'account': '••• 1234', 'amount': 75.00, 'status': 'Completed'},
      {'name': 'Jane Smith', 'account': '••• 5678', 'amount': 100.00, 'status': 'Completed'},
      {'name': 'Bob Johnson', 'account': '••• 9012', 'amount': 75.00, 'status': 'Completed'},
    ];

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transfer Results',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.h),
          
          ...mockResults.asMap().entries.map((entry) {
            final index = entry.key;
            final result = entry.value;
            
            return Container(
              margin: EdgeInsets.only(bottom: index < mockResults.length - 1 ? 16.h : 0),
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.green[600],
                    radius: 20.r,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          result['name'] as String,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          result['account'] as String,
                          style: GoogleFonts.inter(
                            color: Colors.grey[400],
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '£${(result['amount'] as double).toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.green[600],
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          result['status'] as String,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // Top row - Download and Share
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _downloadBatchReceipt,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.green[500]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.download_rounded, 
                        color: Colors.green[400], 
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Download',
                        style: GoogleFonts.inter(
                          color: Colors.green[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: _shareReceipt,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.blue[500]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share_rounded, 
                        color: Colors.blue[400], 
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Share',
                        style: GoogleFonts.inter(
                          color: Colors.blue[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        
        SizedBox(height: 12.h),
        
        // Bottom row - Another Transfer and Dashboard
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: _startAnotherTransfer,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.purple[500]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.send_rounded, 
                        color: Colors.purple[400], 
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'New Transfer',
                        style: GoogleFonts.inter(
                          color: Colors.purple[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: GestureDetector(
                onTap: _navigateToDashboard,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: Colors.orange[500]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard_rounded, 
                        color: Colors.orange[400], 
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Dashboard',
                        style: GoogleFonts.inter(
                          color: Colors.orange[400],
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
} 