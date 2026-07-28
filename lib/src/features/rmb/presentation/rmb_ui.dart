import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lazervault/src/generated/rmb.pbenum.dart';

/// Shared RMB theme + helpers. Matches the crypto / group-funds design language
/// (dark palette, purple gradient hero).
class RmbUi {
  RmbUi._();

  static const Color bg = Color(0xFF0A0A0A);
  static const Color card = Color(0xFF1F1F1F);
  static const Color border = Color(0xFF2D2D2D);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color label = Color(0xFF8E8E93);
  static const Color accent = Color.fromARGB(255, 78, 3, 208);
  static const Color rmbRed = Color(0xFFE60012);
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF2C3E50), accent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final RegExp _cjk = RegExp(r'[㐀-䶿一-鿿豈-﫿]');

  /// Recipient name in natural order — Chinese convention is surname (姓) then
  /// given (名): no separator for Hanzi (张伟), a space for Pinyin/Latin
  /// ("Zhang Wei"). Falls back to [fallback] (the stored display name) when the
  /// split parts are empty. Shared by the send flow, landing, history and
  /// receipt so the name format is identical everywhere.
  static String recipientName({
    required String surname,
    required String given,
    String fallback = '',
  }) {
    final s = surname.trim();
    final g = given.trim();
    if (s.isNotEmpty || g.isNotEmpty) {
      return _cjk.hasMatch('$s$g') ? '$s$g' : '$s $g'.trim();
    }
    return fallback.trim();
  }

  static String railLabel(RmbRail rail) {
    switch (rail) {
      case RmbRail.ALIPAY:
        return 'Alipay';
      case RmbRail.WECHAT:
        return 'WeChat Pay';
      case RmbRail.UNIONPAY:
        return 'UnionPay card';
      case RmbRail.BANK:
        return 'Chinese bank';
      default:
        return 'Unknown';
    }
  }

  static IconData railIcon(RmbRail rail) {
    switch (rail) {
      case RmbRail.ALIPAY:
        return Icons.account_balance_wallet_outlined;
      case RmbRail.WECHAT:
        return Icons.chat_bubble_outline;
      case RmbRail.UNIONPAY:
        return Icons.credit_card;
      case RmbRail.BANK:
        return Icons.account_balance_outlined;
      default:
        return Icons.help_outline;
    }
  }

  /// Official brand SVG for rails that have one bundled (Alipay, WeChat).
  /// Null for rails that fall back to a Material glyph (UnionPay, bank).
  static String? railAsset(RmbRail rail) {
    switch (rail) {
      case RmbRail.ALIPAY:
        return 'assets/images/logos/rmb_alipay.svg';
      case RmbRail.WECHAT:
        return 'assets/images/logos/rmb_wechat.svg';
      default:
        return null;
    }
  }

  /// Rail glyph — the official brand logo when bundled, else a themed Material
  /// icon. Use everywhere a rail is shown (method cards, tiles, receipt).
  static Widget railGlyph(RmbRail rail, {required double size}) {
    final asset = railAsset(rail);
    if (asset != null) {
      return SvgPicture.asset(asset, width: size, height: size);
    }
    return Icon(railIcon(rail), color: railColor(rail), size: size);
  }

  static Color railColor(RmbRail rail) {
    switch (rail) {
      case RmbRail.ALIPAY:
        return const Color(0xFF1677FF); // Alipay blue
      case RmbRail.WECHAT:
        return const Color(0xFF07C160); // WeChat green
      case RmbRail.UNIONPAY:
        return const Color(0xFFE21836); // UnionPay red
      case RmbRail.BANK:
        return const Color(0xFF3B82F6);
      default:
        return textSecondary;
    }
  }

  /// Format NGN minor (kobo) as ₦#,##0.00.
  static String ngn(int minor) =>
      '₦${NumberFormat('#,##0.00').format(minor / 100.0)}';

  /// Format CNY minor (fen) as ¥#,##0.00.
  static String cny(int minor) =>
      '¥${NumberFormat('#,##0.00').format(minor / 100.0)}';
}
