import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recipe.dart';

class AIRecipeCard extends StatelessWidget {
  final Recipe recipe;
  final List<String> userIngredients;
  final VoidCallback? onTap;

  const AIRecipeCard({
    super.key,
    required this.recipe,
    required this.userIngredients,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final availableIngredients = _getAvailableIngredients();
    final missingIngredients = _getMissingIngredients();

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe Image with AI Badge
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      recipe.imageUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // AI Generated Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: Colors.white,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'AI Generated',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Cooking Time Badge
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${recipe.cookingTimeMinutes} mins',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Recipe Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recipe Title
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Ingredient Match Info
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.secondary.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle,
                                color: AppColors.success,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Uses: ${availableIngredients.join(", ")}',
                                style: TextStyle(
                                  color: AppColors.success,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (missingIngredients.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.add_shopping_cart,
                                  color: AppColors.warning,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    'Need: ${missingIngredients.take(3).join(", ")}${missingIngredients.length > 3 ? " (+${missingIngredients.length - 3} more)" : ""}',
                                    style: TextStyle(
                                      color: AppColors.warning,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Rating and Action Row
                    Row(
                      children: [
                        // Rating Stars
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < recipe.rating.floor()
                                  ? Icons.star
                                  : index < recipe.rating
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: AppColors.warning,
                              size: 16,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${recipe.rating}/5',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),

                        // Quick Actions
                        Row(
                          children: [
                            _QuickActionButton(
                              icon: Icons.favorite_border,
                              color: AppColors.textLight,
                              onPressed: () {},
                            ),
                            const SizedBox(width: 12),
                            _QuickActionButton(
                              icon: Icons.bookmark_border,
                              color: AppColors.textLight,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getAvailableIngredients() {
    return recipe.ingredients
        .where((ingredient) => userIngredients.any((userIng) =>
            ingredient.toLowerCase().contains(userIng.toLowerCase())))
        .map((ingredient) => _extractIngredientName(ingredient))
        .toList();
  }

  List<String> _getMissingIngredients() {
    return recipe.ingredients
        .where((ingredient) => !userIngredients.any((userIng) =>
            ingredient.toLowerCase().contains(userIng.toLowerCase())))
        .map((ingredient) => _extractIngredientName(ingredient))
        .toList();
  }

  String _extractIngredientName(String ingredient) {
    // Extract just the ingredient name from "1 cup tomato" -> "tomato"
    final parts = ingredient.split(' ');
    if (parts.length > 2) {
      return parts.skip(2).join(' ');
    } else if (parts.length == 2) {
      return parts[1];
    }
    return ingredient;
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _QuickActionButton({
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
}
