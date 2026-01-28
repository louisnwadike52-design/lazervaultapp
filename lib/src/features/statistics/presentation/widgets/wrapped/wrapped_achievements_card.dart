import 'package:flutter/material.dart';
import '../../../data/wrapped_types_stub.dart';
import 'wrapped_card_base.dart';

/// Card showing achievements/badges earned
class WrappedAchievementsCard extends StatelessWidget {
  final List<WrappedAchievement> achievements;

  const WrappedAchievementsCard({
    super.key,
    required this.achievements,
  });

  @override
  Widget build(BuildContext context) {
    return WrappedCardBase(
      gradientColors: WrappedColors.achievements,
      title: 'Your Achievements',
      subtitle: 'Badges you\'ve earned',
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: achievements.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return _AchievementItem(achievement: achievements[index]);
        },
      ),
    );
  }
}

class _AchievementItem extends StatelessWidget {
  final WrappedAchievement achievement;

  const _AchievementItem({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final tierColor = _getTierColor(achievement.tier);
    final isUnlocked = achievement.unlocked;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUnlocked
            ? Colors.white.withValues(alpha: 0.9)
            : Colors.white.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
        border: isUnlocked
            ? Border.all(color: tierColor, width: 3)
            : null,
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: tierColor.withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Achievement Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isUnlocked ? tierColor.withValues(alpha: 0.2) : Colors.grey.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                achievement.emoji.isEmpty ? achievement.name.substring(0, 1) : achievement.emoji,
                style: TextStyle(
                  fontSize: 24,
                  color: isUnlocked ? null : Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Achievement Name
          Text(
            achievement.name,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: isUnlocked ? const Color(0xFF2d3436) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Progress bar for locked achievements
          if (!isUnlocked) ...[
            LinearProgressIndicator(
              value: achievement.progress / 100,
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(tierColor),
            ),
            const SizedBox(height: 4),
            Text(
              '${achievement.progress.toStringAsFixed(0)}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
            ),
          ] else ...[
            // Tier badge for unlocked
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: tierColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                achievement.tier.toUpperCase(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _getTierColor(String tier) {
    switch (tier.toLowerCase()) {
      case 'platinum':
        return const Color(0xFF6B5B95);
      case 'gold':
        return const Color(0xFFFFD700);
      case 'silver':
        return const Color(0xFFC0C0C0);
      case 'bronze':
      default:
        return const Color(0xFFCD7F32);
    }
  }
}
