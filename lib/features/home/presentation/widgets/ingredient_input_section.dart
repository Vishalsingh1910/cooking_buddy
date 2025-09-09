import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class IngredientInputSection extends StatefulWidget {
  const IngredientInputSection({super.key});

  @override
  State<IngredientInputSection> createState() => _IngredientInputSectionState();
}

class _IngredientInputSectionState extends State<IngredientInputSection> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        border: Border(
          top: BorderSide(color: AppColors.surface, width: 1),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Ingredient Input Field
            Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
                border: Border.all(
                  color: _focusNode.hasFocus
                      ? AppColors.primary
                      : Colors.transparent,
                  width: 2,
                ),
              ),
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'Enter your ingredients...',
                  hintStyle: TextStyle(color: AppColors.textLight),
                  prefixIcon: Icon(Icons.search, color: AppColors.textLight),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium,
                    vertical: AppConstants.paddingMedium,
                  ),
                ),
                onChanged: (value) {
                  // Handle ingredient input changes
                },
              ),
            ),

            const SizedBox(height: AppConstants.paddingMedium),

            // Find Recipes Button
            ElevatedButton(
              onPressed: () {
                // Handle find recipes action
                _findRecipes();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.paddingMedium),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.radiusMedium),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.restaurant_menu, size: 20),
                  const SizedBox(width: AppConstants.paddingSmall),
                  const Text(
                    'Find Recipes',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Quick ingredient suggestions
            const SizedBox(height: AppConstants.paddingSmall),
            Wrap(
              spacing: AppConstants.paddingSmall,
              runSpacing: AppConstants.paddingSmall,
              children: [
                _buildIngredientChip('Chicken'),
                _buildIngredientChip('Tomatoes'),
                _buildIngredientChip('Pasta'),
                _buildIngredientChip('Garlic'),
                _buildIngredientChip('Onions'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIngredientChip(String ingredient) {
    return GestureDetector(
      onTap: () {
        _addIngredient(ingredient);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingMedium,
          vertical: AppConstants.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.accent,
          borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(
          ingredient,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _addIngredient(String ingredient) {
    final currentText = _controller.text;
    if (currentText.isEmpty) {
      _controller.text = ingredient;
    } else {
      _controller.text = '$currentText, $ingredient';
    }
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }

  void _findRecipes() {
    final ingredients = _controller.text;
    if (ingredients.isNotEmpty) {
      // Navigate to recipe search results or trigger search
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching recipes with: $ingredients'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }
}
