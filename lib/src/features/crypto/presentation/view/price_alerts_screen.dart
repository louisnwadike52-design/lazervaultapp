import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../cubit/crypto_cubit.dart';
import '../../cubit/crypto_state.dart';
import '../../domain/entities/crypto_entity.dart';

class PriceAlertsScreen extends StatefulWidget {
  const PriceAlertsScreen({super.key});

  @override
  State<PriceAlertsScreen> createState() => _PriceAlertsScreenState();
}

class _PriceAlertsScreenState extends State<PriceAlertsScreen> {
  // Mock price alerts data
  final List<PriceAlert> _alerts = [
    PriceAlert(
      id: '1',
      cryptoSymbol: 'BTC',
      cryptoName: 'Bitcoin',
      targetPrice: 75000,
      currentPrice: 70000,
      alertType: AlertType.above,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
    PriceAlert(
      id: '2',
      cryptoSymbol: 'ETH',
      cryptoName: 'Ethereum',
      targetPrice: 1400,
      currentPrice: 1544,
      alertType: AlertType.below,
      isActive: false,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
    ),
    PriceAlert(
      id: '3',
      cryptoSymbol: 'SOL',
      cryptoName: 'Solana',
      targetPrice: 200,
      currentPrice: 156,
      alertType: AlertType.above,
      isActive: true,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E27),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActiveAlertsSection(),
                    SizedBox(height: 24.h),
                    _buildInactiveAlertsSection(),
                    SizedBox(height: 24.h),
                    _buildAlertStats(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateAlertBottomSheet,
        backgroundColor: const Color(0xFF6C5CE7),
        child: Icon(Icons.add_alert, color: Colors.white, size: 24.sp),
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
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: GestureDetector(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Text(
              'Price Alerts',
              style: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2746),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveAlertsSection() {
    final activeAlerts = _alerts.where((alert) => alert.isActive).toList();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Alerts (${activeAlerts.length})',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.notifications_active,
                color: const Color(0xFF6C5CE7),
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (activeAlerts.isEmpty)
            _buildEmptyState('No active alerts', 'Create your first price alert to get notified')
          else
            ...activeAlerts.map((alert) => _buildAlertCard(alert)),
        ],
      ),
    );
  }

  Widget _buildInactiveAlertsSection() {
    final inactiveAlerts = _alerts.where((alert) => !alert.isActive).toList();
    
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Inactive Alerts (${inactiveAlerts.length})',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.notifications_off,
                color: Colors.grey,
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          if (inactiveAlerts.isEmpty)
            _buildEmptyState('No inactive alerts', 'All your alerts are currently active')
          else
            ...inactiveAlerts.map((alert) => _buildAlertCard(alert)),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String title, String subtitle) {
    return Container(
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            Icons.notifications_none,
            color: Colors.white.withOpacity(0.3),
            size: 48.sp,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlertCard(PriceAlert alert) {
    final isTriggered = alert.alertType == AlertType.above 
        ? alert.currentPrice >= alert.targetPrice 
        : alert.currentPrice <= alert.targetPrice;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: alert.isActive 
            ? (isTriggered ? Colors.green.withOpacity(0.1) : const Color(0xFF0A0E27))
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Icon(
                  Icons.currency_bitcoin,
                  color: Colors.orange,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      alert.cryptoName,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${alert.alertType == AlertType.above ? 'Above' : 'Below'} £${alert.targetPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 12.sp,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '£${alert.currentPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (isTriggered)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'TRIGGERED',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12.w),
              Switch(
                value: alert.isActive,
                onChanged: (value) => _toggleAlert(alert.id, value),
                activeColor: const Color(0xFF6C5CE7),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Created ${_formatDate(alert.createdAt)}',
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.5),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _editAlert(alert),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C5CE7).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: const Color(0xFF6C5CE7),
                        size: 16.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => _deleteAlert(alert.id),
                    child: Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAlertStats() {
    final totalAlerts = _alerts.length;
    final activeAlerts = _alerts.where((alert) => alert.isActive).length;
    final triggeredAlerts = _alerts.where((alert) {
      final isTriggered = alert.alertType == AlertType.above 
          ? alert.currentPrice >= alert.targetPrice 
          : alert.currentPrice <= alert.targetPrice;
      return isTriggered && alert.isActive;
    }).length;

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alert Statistics',
            style: GoogleFonts.inter(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildStatCard('Total', totalAlerts.toString(), Icons.notifications)),
              SizedBox(width: 12.w),
              Expanded(child: _buildStatCard('Active', activeAlerts.toString(), Icons.notifications_active)),
              SizedBox(width: 12.w),
              Expanded(child: _buildStatCard('Triggered', triggeredAlerts.toString(), Icons.notification_important)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0A0E27),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6C5CE7), size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12.sp,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateAlertBottomSheet() {
    Get.bottomSheet(
      CreateAlertBottomSheet(
        onAlertCreated: (alert) {
          setState(() {
            _alerts.add(alert);
          });
        },
      ),
      isScrollControlled: true,
    );
  }

  void _toggleAlert(String alertId, bool isActive) {
    setState(() {
      final alertIndex = _alerts.indexWhere((alert) => alert.id == alertId);
      if (alertIndex != -1) {
        _alerts[alertIndex] = _alerts[alertIndex].copyWith(isActive: isActive);
      }
    });
  }

  void _editAlert(PriceAlert alert) {
    Get.bottomSheet(
      CreateAlertBottomSheet(
        alertToEdit: alert,
        onAlertCreated: (updatedAlert) {
          setState(() {
            final alertIndex = _alerts.indexWhere((a) => a.id == alert.id);
            if (alertIndex != -1) {
              _alerts[alertIndex] = updatedAlert;
            }
          });
        },
      ),
      isScrollControlled: true,
    );
  }

  void _deleteAlert(String alertId) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2746),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.orange,
                size: 48.sp,
              ),
              SizedBox(height: 16.h),
              Text(
                'Delete Alert',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Are you sure you want to delete this price alert?',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700],
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _alerts.removeWhere((alert) => alert.id == alertId);
                        });
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: GoogleFonts.inter(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    }
  }
}

class CreateAlertBottomSheet extends StatefulWidget {
  final PriceAlert? alertToEdit;
  final Function(PriceAlert) onAlertCreated;

  const CreateAlertBottomSheet({
    super.key,
    this.alertToEdit,
    required this.onAlertCreated,
  });

  @override
  State<CreateAlertBottomSheet> createState() => _CreateAlertBottomSheetState();
}

class _CreateAlertBottomSheetState extends State<CreateAlertBottomSheet> {
  final TextEditingController _priceController = TextEditingController();
  String _selectedCrypto = 'BTC';
  AlertType _selectedAlertType = AlertType.above;
  
  final List<Map<String, dynamic>> _cryptoOptions = [
    {'symbol': 'BTC', 'name': 'Bitcoin', 'price': 70000.0},
    {'symbol': 'ETH', 'name': 'Ethereum', 'price': 1544.0},
    {'symbol': 'SOL', 'name': 'Solana', 'price': 156.78},
    {'symbol': 'ADA', 'name': 'Cardano', 'price': 0.89},
  ];

  @override
  void initState() {
    super.initState();
    if (widget.alertToEdit != null) {
      _selectedCrypto = widget.alertToEdit!.cryptoSymbol;
      _selectedAlertType = widget.alertToEdit!.alertType;
      _priceController.text = widget.alertToEdit!.targetPrice.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2746),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.alertToEdit != null ? 'Edit Alert' : 'Create Price Alert',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.close, color: Colors.white, size: 24.sp),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildCryptoSelector(),
          SizedBox(height: 20.h),
          _buildAlertTypeSelector(),
          SizedBox(height: 20.h),
          _buildPriceInput(),
          SizedBox(height: 24.h),
          _buildCreateButton(),
        ],
      ),
    );
  }

  Widget _buildCryptoSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Cryptocurrency',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Container(
          height: 200.h,
          child: ListView.builder(
            itemCount: _cryptoOptions.length,
            itemBuilder: (context, index) {
              final crypto = _cryptoOptions[index];
              final isSelected = _selectedCrypto == crypto['symbol'];
              
              return GestureDetector(
                onTap: () => setState(() => _selectedCrypto = crypto['symbol']),
                child: Container(
                  margin: EdgeInsets.only(bottom: 8.h),
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF6C5CE7).withOpacity(0.2) : const Color(0xFF0A0E27),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Icon(Icons.currency_bitcoin, color: Colors.orange, size: 20.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              crypto['name'],
                              style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              crypto['symbol'],
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                color: Colors.white.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '£${crypto['price'].toStringAsFixed(2)}',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAlertTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alert Type',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedAlertType = AlertType.above),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: _selectedAlertType == AlertType.above 
                        ? const Color(0xFF6C5CE7).withOpacity(0.2) 
                        : const Color(0xFF0A0E27),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_upward,
                        color: Colors.green,
                        size: 24.sp,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Above',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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
                onTap: () => setState(() => _selectedAlertType = AlertType.below),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: _selectedAlertType == AlertType.below 
                        ? const Color(0xFF6C5CE7).withOpacity(0.2) 
                        : const Color(0xFF0A0E27),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
        
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.arrow_downward,
                        color: Colors.red,
                        size: 24.sp,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Below',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
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

  Widget _buildPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Target Price (GBP)',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 12.h),
        TextField(
          controller: _priceController,
          keyboardType: TextInputType.number,
          style: GoogleFonts.inter(
            fontSize: 18.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: '0.00',
            hintStyle: GoogleFonts.inter(
              fontSize: 18.sp,
              color: Colors.white.withOpacity(0.3),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 16.w, top: 16.h),
              child: Text(
                '£',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            filled: true,
            fillColor: const Color(0xFF0A0E27),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _createAlert,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5CE7),
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
        child: Text(
          widget.alertToEdit != null ? 'Update Alert' : 'Create Alert',
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _createAlert() {
    if (_priceController.text.isEmpty) return;
    
    final targetPrice = double.tryParse(_priceController.text);
    if (targetPrice == null) return;
    
    final selectedCryptoData = _cryptoOptions.firstWhere(
      (crypto) => crypto['symbol'] == _selectedCrypto,
    );
    
    final alert = PriceAlert(
      id: widget.alertToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      cryptoSymbol: _selectedCrypto,
      cryptoName: selectedCryptoData['name'],
      targetPrice: targetPrice,
      currentPrice: selectedCryptoData['price'],
      alertType: _selectedAlertType,
      isActive: true,
      createdAt: widget.alertToEdit?.createdAt ?? DateTime.now(),
    );
    
    widget.onAlertCreated(alert);
    Get.back();
  }
}

// Price Alert Model
class PriceAlert {
  final String id;
  final String cryptoSymbol;
  final String cryptoName;
  final double targetPrice;
  final double currentPrice;
  final AlertType alertType;
  final bool isActive;
  final DateTime createdAt;

  const PriceAlert({
    required this.id,
    required this.cryptoSymbol,
    required this.cryptoName,
    required this.targetPrice,
    required this.currentPrice,
    required this.alertType,
    required this.isActive,
    required this.createdAt,
  });

  PriceAlert copyWith({
    String? id,
    String? cryptoSymbol,
    String? cryptoName,
    double? targetPrice,
    double? currentPrice,
    AlertType? alertType,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return PriceAlert(
      id: id ?? this.id,
      cryptoSymbol: cryptoSymbol ?? this.cryptoSymbol,
      cryptoName: cryptoName ?? this.cryptoName,
      targetPrice: targetPrice ?? this.targetPrice,
      currentPrice: currentPrice ?? this.currentPrice,
      alertType: alertType ?? this.alertType,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

enum AlertType { above, below } 