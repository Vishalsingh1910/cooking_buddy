import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/home_providers.dart';
import '../../domain/models/ingredient_model.dart';

class SmartIngredientInput extends ConsumerStatefulWidget {
  const SmartIngredientInput({super.key});

  @override
  ConsumerState<SmartIngredientInput> createState() =>
      _SmartIngredientInputState();
}

class _SmartIngredientInputState extends ConsumerState<SmartIngredientInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Ingredient> _filteredSuggestions = [];

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filterSuggestions(String query) {
    final allIngredients = ref.read(ingredientSuggestionsProvider);
    if (query.isEmpty) {
      _filteredSuggestions = [];
    } else {
      _filteredSuggestions = allIngredients
          .where((ingredient) =>
              ingredient.name.toLowerCase().contains(query.toLowerCase()))
          .take(5)
          .toList();
    }
    setState(() {});
  }

  void _addIngredient(Ingredient ingredient) {
    ref.read(selectedIngredientsProvider.notifier).addIngredient(ingredient);
    _controller.clear();
    _filteredSuggestions = [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedIngredients = ref.watch(selectedIngredientsProvider);
    final recipeCount = ref.watch(recipeCountProvider);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title with icon
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.kitchen,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                "What's in your kitchen?",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Input field
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
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
              decoration: InputDecoration(
                hintText: 'Add ingredients...',
                hintStyle: GoogleFonts.poppins(
                  color: AppColors.textLight,
                  fontSize: 14,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textLight,
                  size: 20,
                ),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        // TODO: Implement camera
                      },
                      icon: const Icon(
                        Icons.camera_alt_outlined,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement voice input
                      },
                      icon: const Icon(
                        Icons.mic_outlined,
                        color: AppColors.textLight,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
              onChanged: _filterSuggestions,
            ),
          ),

          // Autocomplete suggestions
          if (_filteredSuggestions.isNotEmpty) ...[
            const SizedBox(height: 8),
            Container(
              constraints: const BoxConstraints(maxHeight: 120),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.surface),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredSuggestions.length,
                itemBuilder: (context, index) {
                  final ingredient = _filteredSuggestions[index];
                  return ListTile(
                    dense: true,
                    leading: const Icon(
                      Icons.add_circle_outline,
                      color: AppColors.primary,
                      size: 18,
                    ),
                    title: Text(
                      ingredient.name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      ingredient.category,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textLight,
                      ),
                    ),
                    onTap: () => _addIngredient(ingredient),
                  );
                },
              ),
            ),
          ],

          // Selected ingredient tags
          if (selectedIngredients.isNotEmpty) ...[
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedIngredients.map((ingredient) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        ingredient.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          ref
                              .read(selectedIngredientsProvider.notifier)
                              .removeIngredient(ingredient);
                        },
                        child: const Icon(
                          Icons.close,
                          size: 14,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],

          // Recipe count and generate button
          const SizedBox(height: 16),
          if (selectedIngredients.isNotEmpty) ...[
            Text(
              '$recipeCount recipes found!',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 12),
          ],

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: selectedIngredients.isNotEmpty
                  ? () {
                      // TODO: Navigate to generated recipes
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Generating recipes with ${selectedIngredients.length} ingredients!',
                          ),
                          backgroundColor: AppColors.primary,
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                disabledBackgroundColor: AppColors.textLight,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Generate Recipes',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
