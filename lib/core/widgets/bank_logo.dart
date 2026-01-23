import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lazervault/core/utilities/banks_data.dart';

/// A widget that displays a bank logo with fallback to gradient initials.
///
/// Displays a gradient container with the bank's initials.
/// All bank data comes from local configuration - no remote calls.
class BankLogo extends StatelessWidget {
  final String bankName;
  final String? bankCode;
  final String country;
  final double size;
  final double borderRadius;

  const BankLogo({
    super.key,
    required this.bankName,
    this.bankCode,
    this.country = 'NG',
    this.size = 44,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        boxShadow: [
          BoxShadow(
            color: _getBankGradientColors(bankName)[0].withValues(alpha: 0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: _buildFallback(),
      ),
    );
  }

  Widget _buildFallback() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _getBankGradientColors(bankName),
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          _getBankInitials(bankName),
          style: TextStyle(
            color: Colors.white,
            fontSize: (size * 0.35).sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  List<Color> _getBankGradientColors(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return [const Color(0xFFFF6600), const Color(0xFFCC5200)];
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return [const Color(0xFFFF6600), const Color(0xFFCC4400)];
    if (lowerName.contains('first bank')) return [const Color(0xFF003366), const Color(0xFF002244)];
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('zenith')) return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('kuda')) return [const Color(0xFF6B47ED), const Color(0xFF5533CC)];
    if (lowerName.contains('opay')) return [const Color(0xFF00C853), const Color(0xFF009624)];
    if (lowerName.contains('palmpay')) return [const Color(0xFF6C63FF), const Color(0xFF5046E5)];
    if (lowerName.contains('fidelity')) return [const Color(0xFF006B3F), const Color(0xFF004D2D)];
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return [const Color(0xFF6B2D7B), const Color(0xFF4A1F55)];
    if (lowerName.contains('sterling')) return [const Color(0xFFCC0000), const Color(0xFF990000)];
    if (lowerName.contains('stanbic')) return [const Color(0xFF0033A1), const Color(0xFF002277)];
    if (lowerName.contains('ecobank')) return [const Color(0xFF004C91), const Color(0xFF003366)];
    if (lowerName.contains('union bank')) return [const Color(0xFF003087), const Color(0xFF002266)];
    if (lowerName.contains('wema') || lowerName.contains('alat')) return [const Color(0xFF6B2D7B), const Color(0xFF4A1F55)];
    if (lowerName.contains('polaris')) return [const Color(0xFF003399), const Color(0xFF002266)];
    if (lowerName.contains('keystone')) return [const Color(0xFF0066CC), const Color(0xFF004488)];
    if (lowerName.contains('heritage')) return [const Color(0xFF006633), const Color(0xFF004422)];
    if (lowerName.contains('moniepoint')) return [const Color(0xFF0066FF), const Color(0xFF0044CC)];
    if (lowerName.contains('carbon')) return [const Color(0xFF00C9A7), const Color(0xFF00A386)];

    // UK Banks
    if (lowerName.contains('barclays')) return [const Color(0xFF0071CE), const Color(0xFF004A8F)];
    if (lowerName.contains('hsbc')) return [const Color(0xFFDB0011), const Color(0xFFB8000E)];
    if (lowerName.contains('lloyds')) return [const Color(0xFF006A4E), const Color(0xFF004D3A)];
    if (lowerName.contains('natwest')) return [const Color(0xFF5D2A8F), const Color(0xFF4A1F75)];
    if (lowerName.contains('santander')) return [const Color(0xFFEC0000), const Color(0xFFD10000)];
    if (lowerName.contains('monzo')) return [const Color(0xFFFF5A5F), const Color(0xFFE64850)];
    if (lowerName.contains('starling')) return [const Color(0xFF6935D3), const Color(0xFF5229A8)];
    if (lowerName.contains('revolut')) return [const Color(0xFF0073E6), const Color(0xFF005BB5)];

    // Default gradient
    return [const Color(0xFF78039C), const Color(0xFF5F14E1)];
  }

  String _getBankInitials(String bankName) {
    final lowerName = bankName.toLowerCase();

    // Nigerian Banks
    if (lowerName.contains('access')) return 'AB';
    if (lowerName.contains('gtbank') || lowerName.contains('guaranty trust')) return 'GT';
    if (lowerName.contains('first bank')) return 'FB';
    if (lowerName.contains('uba') || lowerName.contains('united bank for africa')) return 'UBA';
    if (lowerName.contains('zenith')) return 'ZB';
    if (lowerName.contains('kuda')) return 'KD';
    if (lowerName.contains('opay')) return 'OP';
    if (lowerName.contains('palmpay')) return 'PP';
    if (lowerName.contains('fidelity')) return 'FD';
    if (lowerName.contains('fcmb') || lowerName.contains('first city monument')) return 'FC';
    if (lowerName.contains('sterling')) return 'SB';
    if (lowerName.contains('stanbic')) return 'SI';
    if (lowerName.contains('ecobank')) return 'EB';
    if (lowerName.contains('union bank')) return 'UB';
    if (lowerName.contains('wema')) return 'WB';
    if (lowerName.contains('alat')) return 'AL';
    if (lowerName.contains('moniepoint')) return 'MP';
    if (lowerName.contains('carbon')) return 'CB';

    // UK Banks
    if (lowerName.contains('barclays')) return 'BC';
    if (lowerName.contains('hsbc')) return 'HS';
    if (lowerName.contains('lloyds')) return 'LB';
    if (lowerName.contains('natwest')) return 'NW';
    if (lowerName.contains('santander')) return 'SU';
    if (lowerName.contains('monzo')) return 'MZ';
    if (lowerName.contains('starling')) return 'SL';
    if (lowerName.contains('revolut')) return 'RV';

    // Default: first letters of first two words
    if (bankName.isEmpty) return '??';
    final words = bankName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return bankName.length >= 2
        ? bankName.substring(0, 2).toUpperCase()
        : bankName.toUpperCase();
  }
}
