import 'package:lazervault/src/features/sprayme/domain/entities/spray_gift.dart';

/// Rich default gift catalog for the SprayMe feature.
///
/// When the backend returns empty categories (especially luxury/legendary),
/// this local catalog fills in so users always see an exciting selection.
class GiftCatalogDefaults {
  GiftCatalogDefaults._();

  // ---------------------------------------------------------------------------
  // Free gifts (price: 0 kobo)
  // ---------------------------------------------------------------------------
  static const _freeGifts = <SprayGift>[
    SprayGift(
      id: 'default_rose',
      name: 'Rose',
      emoji: '\u{1F339}',
      description: 'A beautiful rose to brighten their day',
      category: 'free',
      sortOrder: 0,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_thumbs_up',
      name: 'Thumbs Up',
      emoji: '\u{1F44D}',
      description: 'Show your appreciation',
      category: 'free',
      sortOrder: 1,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_fire',
      name: 'Fire',
      emoji: '\u{1F525}',
      description: 'This creator is on fire!',
      category: 'free',
      sortOrder: 2,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_clap',
      name: 'Clap',
      emoji: '\u{1F44F}',
      description: 'Round of applause',
      category: 'free',
      sortOrder: 3,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_party_popper',
      name: 'Party Popper',
      emoji: '\u{1F389}',
      description: 'Let the party begin!',
      category: 'free',
      sortOrder: 4,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_star',
      name: 'Star',
      emoji: '\u2B50',
      description: 'You are a star!',
      category: 'free',
      sortOrder: 5,
      animationType: 'glow',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Basic gifts (500 - 2 000 kobo = NGN 5 - 20)
  // ---------------------------------------------------------------------------
  static const _basicGifts = <SprayGift>[
    SprayGift(
      id: 'default_heart',
      name: 'Heart',
      emoji: '\u2764\uFE0F',
      description: 'Send some love',
      price: 500,
      category: 'basic',
      sortOrder: 0,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_kiss',
      name: 'Kiss',
      emoji: '\u{1F48B}',
      description: 'Blow a kiss',
      price: 500,
      category: 'basic',
      sortOrder: 1,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_sunflower',
      name: 'Sunflower',
      emoji: '\u{1F33B}',
      description: 'Brighten their day',
      price: 700,
      category: 'basic',
      sortOrder: 2,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_rainbow',
      name: 'Rainbow',
      emoji: '\u{1F308}',
      description: 'Spread some color',
      price: 800,
      category: 'basic',
      sortOrder: 3,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_balloon',
      name: 'Balloon',
      emoji: '\u{1F388}',
      description: 'Float away!',
      price: 500,
      category: 'basic',
      sortOrder: 4,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_ice_cream',
      name: 'Ice Cream',
      emoji: '\u{1F366}',
      description: 'Sweet treat',
      price: 800,
      category: 'basic',
      sortOrder: 5,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_pizza',
      name: 'Pizza',
      emoji: '\u{1F355}',
      description: 'Pizza time!',
      price: 1000,
      category: 'basic',
      sortOrder: 6,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_music',
      name: 'Music',
      emoji: '\u{1F3B5}',
      description: 'Feel the rhythm',
      price: 1000,
      category: 'basic',
      sortOrder: 7,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_trophy',
      name: 'Trophy',
      emoji: '\u{1F3C6}',
      description: 'Winner winner!',
      price: 1500,
      category: 'basic',
      sortOrder: 8,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_crown',
      name: 'Crown',
      emoji: '\u{1F451}',
      description: 'Royalty vibes',
      price: 1500,
      category: 'basic',
      sortOrder: 9,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_diamond',
      name: 'Diamond',
      emoji: '\u{1F48E}',
      description: 'Shine bright',
      price: 2000,
      category: 'basic',
      sortOrder: 10,
      animationType: 'float_up',
    ),
    SprayGift(
      id: 'default_butterfly',
      name: 'Butterfly',
      emoji: '\u{1F98B}',
      description: 'Graceful beauty',
      price: 1200,
      category: 'basic',
      sortOrder: 11,
      animationType: 'float_up',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Premium gifts (5 000 - 20 000 kobo = NGN 50 - 200)
  // ---------------------------------------------------------------------------
  static const _premiumGifts = <SprayGift>[
    SprayGift(
      id: 'default_teddy_bear',
      name: 'Teddy Bear',
      emoji: '\u{1F9F8}',
      description: 'Cuddly and warm',
      price: 5000,
      category: 'premium',
      sortOrder: 0,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_rocket',
      name: 'Rocket',
      emoji: '\u{1F680}',
      description: 'To the moon!',
      price: 8000,
      category: 'premium',
      sortOrder: 1,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_sports_car',
      name: 'Sports Car',
      emoji: '\u{1F3CE}\uFE0F',
      description: 'Living in the fast lane',
      price: 15000,
      category: 'premium',
      sortOrder: 2,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_champagne',
      name: 'Champagne',
      emoji: '\u{1F37E}',
      description: 'Pop the bubbly!',
      price: 10000,
      category: 'premium',
      sortOrder: 3,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_ring',
      name: 'Ring',
      emoji: '\u{1F48D}',
      description: 'A token of affection',
      price: 12000,
      category: 'premium',
      sortOrder: 4,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_bouquet',
      name: 'Bouquet',
      emoji: '\u{1F490}',
      description: 'A beautiful arrangement',
      price: 8000,
      category: 'premium',
      sortOrder: 5,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_fireworks',
      name: 'Fireworks',
      emoji: '\u{1F386}',
      description: 'Light up the sky!',
      price: 10000,
      category: 'premium',
      sortOrder: 6,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_dancing',
      name: 'Dancing',
      emoji: '\u{1F483}',
      description: 'Dance like nobody is watching',
      price: 7000,
      category: 'premium',
      sortOrder: 7,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_money_bag',
      name: 'Money Bag',
      emoji: '\u{1F4B0}',
      description: 'Big money energy',
      price: 15000,
      category: 'premium',
      sortOrder: 8,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_gemstone',
      name: 'Gemstone',
      emoji: '\u{1F48E}',
      description: 'Rare and precious',
      price: 18000,
      category: 'premium',
      sortOrder: 9,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_perfume',
      name: 'Perfume',
      emoji: '\u{1F9F4}',
      description: 'Smells like success',
      price: 12000,
      category: 'premium',
      sortOrder: 10,
      animationType: 'burst',
    ),
    SprayGift(
      id: 'default_sparkles',
      name: 'Sparkles',
      emoji: '\u2728',
      description: 'Pure magic',
      price: 20000,
      category: 'premium',
      sortOrder: 11,
      animationType: 'burst',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Luxury gifts (50 000 - 200 000 kobo = NGN 500 - 2 000)
  // ---------------------------------------------------------------------------
  static const _luxuryGifts = <SprayGift>[
    SprayGift(
      id: 'default_lion',
      name: 'Lion',
      emoji: '\u{1F981}',
      description: 'King of the jungle',
      price: 50000,
      category: 'luxury',
      sortOrder: 0,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_dragon',
      name: 'Dragon',
      emoji: '\u{1F409}',
      description: 'Unleash the dragon!',
      price: 80000,
      category: 'luxury',
      sortOrder: 1,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_castle',
      name: 'Castle',
      emoji: '\u{1F3F0}',
      description: 'A fortress fit for royalty',
      price: 100000,
      category: 'luxury',
      sortOrder: 2,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_mansion',
      name: 'Mansion',
      emoji: '\u{1F3E0}',
      description: 'Living large',
      price: 120000,
      category: 'luxury',
      sortOrder: 3,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_universe',
      name: 'Universe',
      emoji: '\u{1F30C}',
      description: 'The entire cosmos for you',
      price: 150000,
      category: 'luxury',
      sortOrder: 4,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_hotel',
      name: 'Hotel',
      emoji: '\u{1F3E8}',
      description: 'Five-star luxury',
      price: 100000,
      category: 'luxury',
      sortOrder: 5,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_cow',
      name: 'Cow',
      emoji: '\u{1F404}',
      description: 'Moo-ving gift!',
      price: 50000,
      category: 'luxury',
      sortOrder: 6,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_dog',
      name: 'Dog',
      emoji: '\u{1F415}',
      description: 'Man\'s best friend',
      price: 50000,
      category: 'luxury',
      sortOrder: 7,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_cat',
      name: 'Cat',
      emoji: '\u{1F408}',
      description: 'Purrfect companion',
      price: 50000,
      category: 'luxury',
      sortOrder: 8,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_owl',
      name: 'Owl',
      emoji: '\u{1F989}',
      description: 'Wise and mysterious',
      price: 60000,
      category: 'luxury',
      sortOrder: 9,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_bat',
      name: 'Bat',
      emoji: '\u{1F987}',
      description: 'Creature of the night',
      price: 60000,
      category: 'luxury',
      sortOrder: 10,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_eagle',
      name: 'Eagle',
      emoji: '\u{1F985}',
      description: 'Soar above the rest',
      price: 80000,
      category: 'luxury',
      sortOrder: 11,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_whale',
      name: 'Whale',
      emoji: '\u{1F40B}',
      description: 'A whale of a gift!',
      price: 150000,
      category: 'luxury',
      sortOrder: 12,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_unicorn',
      name: 'Unicorn',
      emoji: '\u{1F984}',
      description: 'Magical and majestic',
      price: 120000,
      category: 'luxury',
      sortOrder: 13,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_phoenix',
      name: 'Phoenix',
      emoji: '\u{1F525}',
      description: 'Rise from the ashes',
      price: 150000,
      category: 'luxury',
      sortOrder: 14,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_elephant',
      name: 'Elephant',
      emoji: '\u{1F418}',
      description: 'Never forgets, never forgettable',
      price: 80000,
      category: 'luxury',
      sortOrder: 15,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_horse',
      name: 'Horse',
      emoji: '\u{1F40E}',
      description: 'Gallop to greatness',
      price: 70000,
      category: 'luxury',
      sortOrder: 16,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_tiger',
      name: 'Tiger',
      emoji: '\u{1F405}',
      description: 'Fierce and fearless',
      price: 80000,
      category: 'luxury',
      sortOrder: 17,
      animationType: 'rain',
    ),
    SprayGift(
      id: 'default_wolf',
      name: 'Wolf',
      emoji: '\u{1F43A}',
      description: 'Leader of the pack',
      price: 60000,
      category: 'luxury',
      sortOrder: 18,
      animationType: 'rain',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Legendary gifts (500 000 - 5 000 000 kobo = NGN 5 000 - 50 000)
  // ---------------------------------------------------------------------------
  static const _legendaryGifts = <SprayGift>[
    SprayGift(
      id: 'default_private_jet',
      name: 'Private Jet',
      emoji: '\u2708\uFE0F',
      description: 'Flying in style',
      price: 500000,
      category: 'legendary',
      sortOrder: 0,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_yacht',
      name: 'Yacht',
      emoji: '\u{1F6E5}\uFE0F',
      description: 'Sailing the high seas',
      price: 1000000,
      category: 'legendary',
      sortOrder: 1,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_planet_earth',
      name: 'Planet Earth',
      emoji: '\u{1F30D}',
      description: 'Give them the world',
      price: 1500000,
      category: 'legendary',
      sortOrder: 2,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_galaxy',
      name: 'Galaxy',
      emoji: '\u{1F320}',
      description: 'A whole galaxy, just for you',
      price: 2000000,
      category: 'legendary',
      sortOrder: 3,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_crown_jewels',
      name: 'Crown Jewels',
      emoji: '\u{1F451}',
      description: 'The ultimate symbol of wealth',
      price: 2500000,
      category: 'legendary',
      sortOrder: 4,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_treasure_chest',
      name: 'Treasure Chest',
      emoji: '\u{1F5DD}\uFE0F',
      description: 'Unlock the treasure',
      price: 1000000,
      category: 'legendary',
      sortOrder: 5,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_space_station',
      name: 'Space Station',
      emoji: '\u{1F6F8}',
      description: 'Out of this world',
      price: 3000000,
      category: 'legendary',
      sortOrder: 6,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_diamond_ring',
      name: 'Diamond Ring',
      emoji: '\u{1F48D}',
      description: 'The ultimate expression of love',
      price: 5000000,
      category: 'legendary',
      sortOrder: 7,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_golden_dragon',
      name: 'Golden Dragon',
      emoji: '\u{1F432}',
      description: 'Legendary beast of fortune',
      price: 4000000,
      category: 'legendary',
      sortOrder: 8,
      animationType: 'glow',
    ),
    SprayGift(
      id: 'default_royal_palace',
      name: 'Royal Palace',
      emoji: '\u{1F3EF}',
      description: 'A palace fit for a king',
      price: 3500000,
      category: 'legendary',
      sortOrder: 9,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_volcano',
      name: 'Volcano',
      emoji: '\u{1F30B}',
      description: 'Explosive energy!',
      price: 800000,
      category: 'legendary',
      sortOrder: 10,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_lightning',
      name: 'Lightning',
      emoji: '\u26A1',
      description: 'Strike with power',
      price: 700000,
      category: 'legendary',
      sortOrder: 11,
      animationType: 'shake',
    ),
    SprayGift(
      id: 'default_comet',
      name: 'Comet',
      emoji: '\u2604\uFE0F',
      description: 'Once in a lifetime',
      price: 1500000,
      category: 'legendary',
      sortOrder: 12,
      animationType: 'glow',
    ),
  ];

  // ---------------------------------------------------------------------------
  // Public API
  // ---------------------------------------------------------------------------

  /// All default gifts across every category, sorted by category then sortOrder.
  static List<SprayGift> get allGifts => <SprayGift>[
        ..._freeGifts,
        ..._basicGifts,
        ..._premiumGifts,
        ..._luxuryGifts,
        ..._legendaryGifts,
      ];

  /// Returns default gifts for a single [category].
  static List<SprayGift> getByCategory(String category) {
    switch (category) {
      case 'free':
        return List.unmodifiable(_freeGifts);
      case 'basic':
        return List.unmodifiable(_basicGifts);
      case 'premium':
        return List.unmodifiable(_premiumGifts);
      case 'luxury':
        return List.unmodifiable(_luxuryGifts);
      case 'legendary':
        return List.unmodifiable(_legendaryGifts);
      default:
        return const [];
    }
  }

  /// Merges backend gifts with local defaults.
  ///
  /// - If [backendGifts] is empty, all defaults are returned.
  /// - If a category has no backend gifts, the defaults for that category are
  ///   used instead.
  /// - Backend gifts always take precedence within a category.
  static List<SprayGift> mergeWithBackend(List<SprayGift> backendGifts) {
    if (backendGifts.isEmpty) return allGifts;

    const categories = ['free', 'basic', 'premium', 'luxury', 'legendary'];

    final backendByCategory = <String, List<SprayGift>>{};
    for (final gift in backendGifts) {
      backendByCategory.putIfAbsent(gift.category, () => []).add(gift);
    }

    final merged = <SprayGift>[];
    for (final category in categories) {
      final backendCategoryGifts = backendByCategory[category];
      if (backendCategoryGifts != null && backendCategoryGifts.isNotEmpty) {
        merged.addAll(backendCategoryGifts);
      } else {
        merged.addAll(getByCategory(category));
      }
    }

    return merged;
  }

  static const _animationTypeToLottie = <String, String>{
    'burst': 'assets/animations/sprayme/burst.json',
    'rain': 'assets/animations/sprayme/rain.json',
    'glow': 'assets/animations/sprayme/glow.json',
    'shake': 'assets/animations/sprayme/shake.json',
  };

  /// Returns the Lottie animation asset path for a gift based on its animation type.
  /// Free and basic gifts (float_up) have no Lottie animation.
  static String? getLottieAsset(String giftId) {
    final gift = allGifts.cast<SprayGift?>().firstWhere(
          (g) => g!.id == giftId,
          orElse: () => null,
        );
    if (gift == null) return null;
    return _animationTypeToLottie[gift.animationType];
  }

  static const _categorySoundMap = <String, String>{
    'basic': 'assets/sounds/sprayme/pop.mp3',
    'premium': 'assets/sounds/sprayme/chime.mp3',
    'luxury': 'assets/sounds/sprayme/swoosh.mp3',
    'legendary': 'assets/sounds/sprayme/fanfare.mp3',
  };

  /// Returns the sound-effect asset path for a gift based on its category.
  ///
  /// Free gifts have no sound effect (returns `null`).
  static String? getSoundAsset(String giftId) {
    final gift = allGifts.cast<SprayGift?>().firstWhere(
          (g) => g!.id == giftId,
          orElse: () => null,
        );
    if (gift == null) return null;
    return _categorySoundMap[gift.category];
  }
}
