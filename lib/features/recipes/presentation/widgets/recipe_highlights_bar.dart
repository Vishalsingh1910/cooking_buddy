import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RecipeHighlightsBar extends StatefulWidget {
  final Function(String)? onCategorySelected;

  const RecipeHighlightsBar({super.key, this.onCategorySelected});

  @override
  State<RecipeHighlightsBar> createState() => _RecipeHighlightsBarState();
}

class _RecipeHighlightsBarState extends State<RecipeHighlightsBar> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = selectedCategory == category.name;

          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = category.name;
                });
                widget.onCategorySelected?.call(category.name);
              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            category.imageUrl,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                                stops: const [0.4, 1.0],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 8,
                            right: 8,
                            child: Text(
                              '${category.name} ${category.emoji}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 3,
                    width: 100,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecipeCategory {
  final String name;
  final String emoji;
  final String imageUrl;

  RecipeCategory({
    required this.name,
    required this.emoji,
    required this.imageUrl,
  });
}

final List<RecipeCategory> _categories = [
  RecipeCategory(
    name: 'All',
    emoji: '🍽️',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Desserts',
    emoji: '🍰',
    imageUrl:
        'https://images.unsplash.com/photo-1551024506-0bccd828d307?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Quick Meals',
    emoji: '⏱️',
    imageUrl:
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Vegan',
    emoji: '🌱',
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Breakfast',
    emoji: '🥞',
    imageUrl:
        'https://images.unsplash.com/photo-1551782450-a2132b4ba21d?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Healthy',
    emoji: '🥗',
    imageUrl:
        'https://images.unsplash.com/photo-1540420773420-3366772f4999?w=200&h=160&fit=crop',
  ),
  RecipeCategory(
    name: 'Comfort Food',
    emoji: '🍲',
    imageUrl:
        'https://images.unsplash.com/photo-1574484284002-952d92456975?w=200&h=160&fit=crop',
  ),
];
