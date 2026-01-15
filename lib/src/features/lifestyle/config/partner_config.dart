/// Partner service configuration for lifestyle features
/// Maps categories to verified partner websites based on locale
class PartnerConfig {
  final String categoryId;
  final String name;
  final String icon;
  final Map<String, LocaleConfig> locales;
  final bool requiresAuth;

  const PartnerConfig({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.locales,
    this.requiresAuth = false,
  });
}

class LocaleConfig {
  final String url;
  final String? deepLink;
  final bool supportsWebView;

  const LocaleConfig({
    required this.url,
    this.deepLink,
    this.supportsWebView = true,
  });
}

/// Partner services configuration by category
/// Similar to Revolut's Points/Perks integration with partner websites
class LifestylePartners {
  static const List<PartnerConfig> partners = [
    // Flights & Travel
    PartnerConfig(
      categoryId: 'flights',
      name: 'Flights',
      icon: 'flight',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.expedia.com',
          deepLink: 'expedia://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.expedia.co.uk',
          deepLink: 'expedia://',
        ),
        'CA': LocaleConfig(
          url: 'https://www.expedia.ca',
          deepLink: 'expedia://',
        ),
        'AU': LocaleConfig(
          url: 'https://www.expedia.com.au',
          deepLink: 'expedia://',
        ),
        'DE': LocaleConfig(
          url: 'https://www.expedia.de',
          deepLink: 'expedia://',
        ),
        'FR': LocaleConfig(
          url: 'https://www.expedia.fr',
          deepLink: 'expedia://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.expedia.com',
          deepLink: 'expedia://',
        ),
      },
    ),

    // Hotels & Accommodation
    PartnerConfig(
      categoryId: 'hotels',
      name: 'Hotels',
      icon: 'hotel',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.booking.com',
          deepLink: 'booking://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.booking.com',
          deepLink: 'booking://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.booking.com',
          deepLink: 'booking://',
        ),
      },
    ),

    // Movies & Entertainment
    PartnerConfig(
      categoryId: 'movies',
      name: 'Movies',
      icon: 'movie',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.fandango.com',
          deepLink: 'fandango://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.cineworld.co.uk',
          deepLink: 'cineworld://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.imdb.com',
        ),
      },
    ),

    // Gift Cards
    PartnerConfig(
      categoryId: 'gift_cards',
      name: 'Gift Cards',
      icon: 'card_giftcard',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.amazon.com/gift-cards',
        ),
        'UK': LocaleConfig(
          url: 'https://www.amazon.co.uk/gift-cards',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.amazon.com/gift-cards',
        ),
      },
    ),

    // Dining & Restaurants
    PartnerConfig(
      categoryId: 'dining',
      name: 'Dining',
      icon: 'restaurant',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.opentable.com',
          deepLink: 'opentable://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.bookatable.com',
          deepLink: 'bookatable://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.opentable.com',
        ),
      },
    ),

    // Wellness & Spa
    PartnerConfig(
      categoryId: 'wellness',
      name: 'Wellness',
      icon: 'spa',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.spaweek.com',
        ),
        'UK': LocaleConfig(
          url: 'https://www.spabreaks.com',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.bookspa.com',
        ),
      },
    ),

    // Shopping
    PartnerConfig(
      categoryId: 'shopping',
      name: 'Shopping',
      icon: 'shopping_bag',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.amazon.com',
          deepLink: 'com.amazon.mobile.shopping://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.amazon.co.uk',
          deepLink: 'com.amazon.mobile.shopping://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.amazon.com',
        ),
      },
    ),

    // Premium & VIP
    PartnerConfig(
      categoryId: 'premium',
      name: 'Premium',
      icon: 'diamond',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.luxurycard.com',
        ),
        'UK': LocaleConfig(
          url: 'https://www.luxurycard.com',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.luxurycard.com',
        ),
      },
      requiresAuth: true,
    ),

    // Sports & Events
    PartnerConfig(
      categoryId: 'sports',
      name: 'Sports',
      icon: 'sports_soccer',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.stubhub.com',
          deepLink: 'stubhub://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.ticketmaster.co.uk',
          deepLink: 'ticketmaster://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.ticketmaster.com',
        ),
      },
    ),

    // Fitness
    PartnerConfig(
      categoryId: 'fitness',
      name: 'Fitness',
      icon: 'fitness_center',
      locales: {
        'US': LocaleConfig(
          url: 'https://www.classpass.com',
          deepLink: 'classpass://',
        ),
        'UK': LocaleConfig(
          url: 'https://www.classpass.com',
          deepLink: 'classpass://',
        ),
        'DEFAULT': LocaleConfig(
          url: 'https://www.classpass.com',
        ),
      },
    ),

    // Education
    PartnerConfig(
      categoryId: 'education',
      name: 'Education',
      icon: 'school',
      locales: {
        'DEFAULT': LocaleConfig(
          url: 'https://www.coursera.org',
          deepLink: 'coursera://',
        ),
      },
    ),
  ];

  /// Get partner config by category ID
  static PartnerConfig? getPartner(String categoryId) {
    try {
      return partners.firstWhere((p) => p.categoryId == categoryId);
    } catch (e) {
      return null;
    }
  }

  /// Get partner URL for specific locale
  static String? getPartnerUrl(String categoryId, String locale) {
    final partner = getPartner(categoryId);
    if (partner == null) return null;

    final config = partner.locales[locale] ?? partner.locales['DEFAULT'];
    return config?.url;
  }

  /// Get all available partners for a locale
  static List<PartnerConfig> getPartnersForLocale(String locale) {
    return partners.where((p) => p.locales.containsKey(locale) || p.locales.containsKey('DEFAULT')).toList();
  }
}
