import 'package:flutter/material.dart';
import 'package:lazervault/core/types/countries.dart';
import 'package:lazervault/core/types/language.dart';

/// Onboarding slide data model
class OnboardingSlide {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });
}

abstract class AppData {
  AppData._();

  // ========== ONBOARDING SLIDES ==========
  // LazerVault onboarding content with proper fintech branding
  static const List<OnboardingSlide> onboardingSlides = [
    OnboardingSlide(
      title: 'Welcome to LazerVault',
      subtitle: 'Your secure gateway to seamless financial management. Send, receive, and manage your money with ease.',
      imagePath: 'assets/images/logos/lazervault-logo-only.png',
      backgroundColor: Color(0xFFF5F7FA), // Light gray-blue
      textColor: Color(0xFF1A1A2E), // Dark navy
      icon: Icons.account_balance_wallet,
    ),
    OnboardingSlide(
      title: '100% Secure Transactions',
      subtitle: 'Bank-grade encryption protects your money. Your security is our top priority.',
      imagePath: 'assets/images/dollar-money-send.png',
      backgroundColor: Color(0xFFE8F4FD), // Light blue
      textColor: Color(0xFF0D47A1), // Dark blue
      icon: Icons.security,
    ),
    OnboardingSlide(
      title: 'Multi-Currency Support',
      subtitle: 'Hold and exchange multiple currencies. Get the best rates with real-time conversion.',
      imagePath: 'assets/images/currencies/usa-flag.png',
      backgroundColor: Color(0xFFF0F4F8), // Soft gray
      textColor: Color(0xFF1A237E), // Navy
      icon: Icons.currency_exchange,
    ),
    OnboardingSlide(
      title: 'Crypto Investments',
      subtitle: 'Buy, sell, and track cryptocurrencies. Start your investment journey with confidence.',
      imagePath: 'assets/images/exchange.png',
      backgroundColor: Color(0xFFE8F5E9), // Light green
      textColor: Color(0xFF1B5E20), // Dark green
      icon: Icons.trending_up,
    ),
    OnboardingSlide(
      title: 'Start Your Journey',
      subtitle: 'Join thousands of users who trust LazerVault for their financial needs. Let\'s get started!',
      imagePath: 'assets/images/logos/lazervault-full-logo-no-background.png',
      backgroundColor: Color(0xFFF3E5F5), // Light purple
      textColor: Color(0xFF4A148C), // Dark purple
      icon: Icons.rocket_launch,
    ),
  ];

  // Legacy image lists (kept for backward compatibility)
  static final List<String> innerStyleImages = [
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/clothing-store-banner-design-template-e7332aaf6402c88cb4623bf8eb6f97e2_screen.jpg?ts=1620867237',
    'https://cdn.venngage.com/template/thumbnail/small/01b644bd-e75b-4e70-b476-3a786261f066.webp',
    'https://elements-cover-images-0.imgix.net/f67401c2-06cb-4344-979b-f3234d681768?auto=compress%2Cformat&w=900&fit=max&s=75495e228f330d5446b90794cd1319ca',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/online-fashion-sale-banner-template-design-cc34c2027d0bb5ccc2ff90231abaa242_screen.jpg?ts=1613395464',
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/fashion-store-facebook-ad-banner-design-template-754121190affdca4b258b77da2984528_screen.jpg?ts=1655421066',
    'https://elements-cover-images-0.imgix.net/4d1f9fd2-66a1-440c-9eaf-74bc09e949ce?auto=compress%2Cformat&w=900&fit=max&s=9cfa626fde5f76a7fdb6682aca7f9b68',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRTVu6fS_l1hSojzUagIa-lwFCSSeVND1mdz-KmGh0swNZU7hIiFVJXXfzpv1YKUhlxcrc&usqp=CAU',
  ];

  static final List<String> outerStyleImages = [
    'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/new-arrival-discount-offer-on-shoes-poster-ad-design-template-20e8be063593e460ec1eadf156df2a71_screen.jpg?ts=1607504280',
    'https://www.mall499.com/wp-content/uploads/2021/12/banner-skechers-1.png',
    'https://codecanyon.img.customer.envatousercontent.com/files/352931146/Preview.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=29e647d179d8704189dced38088fac34',
    // 'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/shoes-craze-sale-facebook-ad-design-template-b1d1738fd5e9e0f6e3152ec502a1c2e1_screen.jpg?ts=1567579016',
    // 'https://codecanyon.img.customer.envatousercontent.com/files/352468295/Preview.jpg?auto=compress%2Cformat&q=80&fit=crop&crop=top&max-h=8000&max-w=590&s=cea2b1e7878f5ef6b903f9b3625460fe',
    // 'https://rstatic.shoecarnival.com/domain/5265_508_20231225_Winter_Season_Store_Locator_Banner2_(1).jpg',
    // 'https://graphicsfamily.com/wp-content/uploads/2020/07/Shoes-Advertising-Banner-Design-Template-scaled.jpg',
  ];

  // ========== ASSETS ==========
  static const String appLogo = "assets/images/logos/lazervault-logo-only.png";
  static const String appLogoFull = "assets/images/logos/lazervault-full-logo-no-background.png";
  static const String defaultAvatar = "assets/images/users/default-avatar.png";
  static const String dp = "assets/images/dp.png";
  static const String dollarMoneySend = "assets/images/dollar-money-send.png";
  static const String dollarMoneyReceive =
      "assets/images/dollar-money-receive.png";
  static const String googleLogo = "assets/images/logos/google-logo.png";
  static const String appleLogo = "assets/images/logos/apple-logo-black.png";
  static const String orDivider = "assets/images/or-divider.png";

  // ========== BRANDING COLORS ==========
  static const Color primaryColor = Color(0xFF6C63FF); // Purple
  static const Color secondaryColor = Color(0xFF2D3436); // Dark gray
  static const Color accentColor = Color(0xFF00D4AA); // Teal
  static const Color backgroundColor = Color(0xFFF5F7FA); // Light background

  static List<Country> countries = [
    const Country(
        flag: "assets/images/flags/usa-flag.png",
        name: "United States",
        code: "USD",
        symbol: "USD"),
    const Country(
        flag: "assets/images/flags/usa-flag.png",
        name: "United States",
        code: "USD",
        symbol: "USD"),
    const Country(
        flag: "assets/images/flags/usa-flag.png",
        name: "European Union",
        code: "EUR",
        symbol: "EUR"),
    const Country(
        flag: "assets/images/flags/usa-flag.png",
        name: "United Kingdom",
        code: "GBP",
        symbol: "GBP"),
    const Country(
        flag: "assets/images/flags/usa-flag.png",
        name: "Japan",
        code: "JPY",
        symbol: "JPY"),
  ];

  static List<Language> languages = [
    const Language(
        name: "English(USA)",
        code: "en-us",
        flagPath: "assets/images/flags/usa-flag.png"),
    const Language(
        name: "English(UK)",
        code: "en-uk",
        flagPath: "assets/images/flags/uk-flag.png"),
    const Language(
        name: "French",
        code: "fr",
        flagPath: "assets/images/flags/france-flag.png"),
    const Language(
        name: "German",
        code: "de",
        flagPath: "assets/images/flags/german-flag.png"),
    const Language(
        name: "Chinese",
        code: "zh",
        flagPath: "assets/images/flags/chinese-flag.png"),
    const Language(
        name: "Italian",
        code: "es",
        flagPath: "assets/images/flags/italian-flag.png"),
    const Language(
        name: "Norwegian",
        code: "no",
        flagPath: "assets/images/flags/norway-flag.png"),
    const Language(
        name: "Korean",
        code: "nl",
        flagPath: "assets/images/flags/south-korean.png"),
    const Language(
        name: "Hindi",
        code: "hn",
        flagPath: "assets/images/flags/indian-flag.png"),
  ];
}
