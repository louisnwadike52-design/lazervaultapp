import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazervault/core/utils/currency_formatter.dart';

class SecureWalletScreen extends StatefulWidget {
  const SecureWalletScreen({super.key});

  @override
  State<SecureWalletScreen> createState() => _SecureWalletScreenState();
}

class _SecureWalletScreenState extends State<SecureWalletScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _biometricsEnabled = true;
  bool _twoFactorEnabled = true;
  bool _autoLockEnabled = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1F1F),
              const Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildSecurityStatus(),
              _buildTabBar(),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildWalletTab(),
                    _buildSecurityTab(),
                    _buildBackupTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1F1F1F),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 20.sp),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure Wallet',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Multi-layer security',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.security, color: const Color(0xFF6C5CE7), size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityStatus() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green.withValues(alpha: 0.2), const Color(0xFF1F1F1F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.shield_outlined, color: Colors.green, size: 32.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Wallet Security Status',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Excellent Protection',
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              '98%',
              style: GoogleFonts.inter(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: const Color(0xFF6C5CE7),
          borderRadius: BorderRadius.circular(12.r),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
        labelStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600),
        tabs: [
          Tab(text: 'Wallet'),
          Tab(text: 'Security'),
          Tab(text: 'Backup'),
        ],
      ),
    );
  }

  Widget _buildWalletTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildWalletAddressCard(),
          SizedBox(height: 20.h),
          _buildTransactionLimitsCard(),
          SizedBox(height: 20.h),
          _buildColdStorageCard(),
        ],
      ),
    );
  }

  Widget _buildSecurityTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildBiometricsCard(),
          SizedBox(height: 20.h),
          _buildTwoFactorCard(),
          SizedBox(height: 20.h),
          _buildAutoLockCard(),
          SizedBox(height: 20.h),
          _buildSecurityAuditCard(),
        ],
      ),
    );
  }

  Widget _buildBackupTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          _buildSeedPhraseCard(),
          SizedBox(height: 20.h),
          _buildCloudBackupCard(),
          SizedBox(height: 20.h),
          _buildRecoveryOptionsCard(),
        ],
      ),
    );
  }

  Widget _buildWalletAddressCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wallet Address',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '0x1A2B3C4D5E6F7890123456789ABCDEF',
                    style: GoogleFonts.robotoMono(
                      fontSize: 12.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _copyAddress,
                  icon: Icon(Icons.copy, color: const Color(0xFF6C5CE7), size: 20.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _showQRCode,
                  icon: Icon(Icons.qr_code, size: 16.sp),
                  label: Text('Show QR', style: GoogleFonts.inter(fontSize: 14.sp)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C5CE7),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _shareAddress,
                  icon: Icon(Icons.share, size: 16.sp),
                  label: Text('Share', style: GoogleFonts.inter(fontSize: 14.sp)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionLimitsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Transaction Limits',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: _editLimits,
                child: Text(
                  'Edit',
                  style: GoogleFonts.inter(color: const Color(0xFF6C5CE7)),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildLimitItem('Daily Limit', '${CurrencySymbols.currentSymbol}5,000', '${CurrencySymbols.currentSymbol}2,340 remaining'),
          _buildLimitItem('Per Transaction', '${CurrencySymbols.currentSymbol}1,000', 'Maximum'),
          _buildLimitItem('Monthly Limit', '${CurrencySymbols.currentSymbol}50,000', '${CurrencySymbols.currentSymbol}32,100 remaining'),
        ],
      ),
    );
  }

  Widget _buildColdStorageCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.blue, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Cold Storage',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            '95% of your funds are stored offline in our secure cold storage vaults for maximum security.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hot Wallet',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '${CurrencySymbols.currentSymbol}342.50 (5%)',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cold Storage',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        color: Colors.white.withValues(alpha: 0.6),
                      ),
                    ),
                    Text(
                      '${CurrencySymbols.currentSymbol}6,507.50 (95%)',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
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

  Widget _buildBiometricsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.fingerprint, color: Colors.green, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Biometric Authentication',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _biometricsEnabled,
                onChanged: (value) => setState(() => _biometricsEnabled = value),
                activeThumbColor: Colors.green,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Use fingerprint or face recognition to authenticate transactions and access your wallet.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoFactorCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.security, color: Colors.blue, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Two-Factor Authentication',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _twoFactorEnabled,
                onChanged: (value) => setState(() => _twoFactorEnabled = value),
                activeThumbColor: Colors.blue,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Add an extra layer of security with SMS or authenticator app verification.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
          if (_twoFactorEnabled) ...[
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: _setupAuthenticator,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(double.infinity, 40.h),
              ),
              child: Text(
                'Setup Authenticator App',
                style: GoogleFonts.inter(fontSize: 14.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAutoLockCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.lock_clock, color: Colors.orange, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Auto-Lock Wallet',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _autoLockEnabled,
                onChanged: (value) => setState(() => _autoLockEnabled = value),
                activeThumbColor: Colors.orange,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Automatically lock wallet after 5 minutes of inactivity.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecurityAuditCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security Audit',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildAuditItem('Last Security Scan', 'Passed', Colors.green),
          _buildAuditItem('Vulnerability Check', 'Clean', Colors.green),
          _buildAuditItem('Device Security', 'Secure', Colors.green),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _runSecurityScan,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              minimumSize: Size(double.infinity, 40.h),
            ),
            child: Text(
              'Run Security Scan',
              style: GoogleFonts.inter(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeedPhraseCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.key, color: Colors.amber, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Seed Phrase Backup',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.warning, color: Colors.amber, size: 20.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'Your seed phrase is the only way to recover your wallet. Keep it safe!',
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _viewSeedPhrase,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  child: Text('View Seed Phrase', style: GoogleFonts.inter(fontSize: 14.sp)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: _testRecovery,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text('Test Recovery', style: GoogleFonts.inter(fontSize: 14.sp)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCloudBackupCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cloud Backup',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildBackupOption('iCloud Backup', 'Enabled', Colors.blue, true),
          _buildBackupOption('Google Drive', 'Disabled', Colors.grey, false),
          _buildBackupOption('Dropbox', 'Disabled', Colors.grey, false),
        ],
      ),
    );
  }

  Widget _buildRecoveryOptionsCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F1F1F),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recovery Options',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          _buildRecoveryOption('Social Recovery', 'Set trusted contacts', Icons.people),
          _buildRecoveryOption('Hardware Key', 'Use physical security key', Icons.vpn_key),
          _buildRecoveryOption('Emergency Kit', 'Download recovery instructions', Icons.download),
        ],
      ),
    );
  }

  // Helper widgets
  Widget _buildLimitItem(String title, String limit, String remaining) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                remaining,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
          Text(
            limit,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6C5CE7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuditItem(String title, String status, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              status,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackupOption(String service, String status, Color color, bool enabled) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
          Row(
            children: [
              Text(
                status,
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: color,
                ),
              ),
              SizedBox(width: 8.w),
              Switch(
                value: enabled,
                onChanged: (value) {},
                activeThumbColor: color,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecoveryOption(String title, String description, IconData icon) {
    return GestureDetector(
      onTap: () => _handleRecoveryOption(title),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF6C5CE7), size: 24.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 12.sp,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.white.withValues(alpha: 0.5), size: 16.sp),
          ],
        ),
      ),
    );
  }

  // Action methods
  void _copyAddress() {
    Get.snackbar(
      'Copied!',
      'Wallet address copied to clipboard',
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _showQRCode() {
    Get.dialog(
      Dialog(
        backgroundColor: const Color(0xFF1F1F1F),
        child: Container(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Wallet QR Code',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.qr_code, size: 150.sp, color: Colors.black),
              ),
              SizedBox(height: 20.h),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                child: Text('Close', style: GoogleFonts.inter()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _shareAddress() {
    Get.snackbar(
      'Sharing...',
      'Opening share options',
      backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _editLimits() {
    Get.snackbar(
      'Edit Limits',
      'Transaction limits configuration',
      backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _setupAuthenticator() {
    Get.snackbar(
      'Setup Required',
      'Opening authenticator app setup',
      backgroundColor: Colors.blue.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _runSecurityScan() {
    Get.snackbar(
      'Security Scan',
      'Running comprehensive security check...',
      backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _viewSeedPhrase() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1F1F1F),
        title: Text(
          'Security Warning',
          style: GoogleFonts.inter(color: Colors.white),
        ),
        content: Text(
          'Make sure no one can see your screen. Your seed phrase provides full access to your wallet.',
          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel', style: GoogleFonts.inter(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Show seed phrase
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
            child: Text('I Understand', style: GoogleFonts.inter(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _testRecovery() {
    Get.snackbar(
      'Recovery Test',
      'Testing wallet recovery process...',
      backgroundColor: Colors.green.withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }

  void _handleRecoveryOption(String option) {
    Get.snackbar(
      option,
      'Setting up $option...',
      backgroundColor: const Color(0xFF6C5CE7).withValues(alpha: 0.2),
      colorText: Colors.white,
    );
  }
} 