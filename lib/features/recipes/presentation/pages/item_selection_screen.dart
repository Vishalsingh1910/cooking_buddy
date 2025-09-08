import 'package:cooking_buddy/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemSelectionScreen extends StatefulWidget {
  const ItemSelectionScreen({super.key});

  @override
  State<ItemSelectionScreen> createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<Map<String, dynamic>> _allRecipes;
  late List<Map<String, dynamic>> _filteredRecipes;

  @override
  void initState() {
    super.initState();
    _allRecipes = _loadRecipes();
    _filteredRecipes = _allRecipes;
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _loadRecipes() {
    return [
      {
        'title': 'Classic Spaghetti Carbonara',
        'icon': Icons.restaurant,
        'recipe': {
          'description': 'Creamy Italian pasta with eggs, cheese, and pancetta',
          'prepTime': '20 mins',
          'difficulty': 'Medium',
          'servings': 4,
          'steps': [
            'Cook spaghetti in salted boiling water until al dente',
            'Fry pancetta until crispy and golden',
            'Whisk eggs with grated Parmesan cheese',
            'Toss hot pasta with pancetta and egg mixture',
            'Season with black pepper and serve immediately'
          ]
        }
      },
      {
        'title': 'Chicken Tikka Masala',
        'icon': Icons.local_fire_department,
        'recipe': {
          'description': 'Tender chicken in a rich, creamy tomato sauce',
          'prepTime': '45 mins',
          'difficulty': 'Hard',
          'servings': 6,
          'steps': [
            'Marinate chicken pieces in yogurt and spices',
            'Grill chicken until charred and cooked through',
            'Prepare tomato-based curry sauce with cream',
            'Add grilled chicken to the sauce',
            'Simmer and serve with basmati rice'
          ]
        }
      },
      {
        'title': 'Avocado Toast',
        'icon': Icons.breakfast_dining,
        'recipe': {
          'description': 'Simple and healthy breakfast with fresh avocado',
          'prepTime': '5 mins',
          'difficulty': 'Easy',
          'servings': 2,
          'steps': [
            'Toast bread slices until golden brown',
            'Mash ripe avocado with lime juice',
            'Spread avocado mixture on toast',
            'Season with salt, pepper, and red pepper flakes',
            'Garnish with cherry tomatoes if desired'
          ]
        }
      },
      {
        'title': 'Beef Stir Fry',
        'icon': Icons.ramen_dining,
        'recipe': {
          'description': 'Quick and flavorful Asian-inspired dish',
          'prepTime': '15 mins',
          'difficulty': 'Easy',
          'servings': 4,
          'steps': [
            'Slice beef thinly against the grain',
            'Heat oil in a wok or large skillet',
            'Stir-fry beef until browned',
            'Add vegetables and cook until tender-crisp',
            'Toss with soy sauce and serve over rice'
          ]
        }
      }
    ];
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = _allRecipes.where((recipe) {
        final title = recipe['title'].toString().toLowerCase();
        final description =
            recipe['recipe']['description'].toString().toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Recipe'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppTheme.lightOrange, Colors.white],
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildFilterChips(),
            Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredRecipes.length,
                  itemBuilder: (context, index) {
                    final recipe = _filteredRecipes[index];
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: _buildRecipeCard(
                            context: context,
                            title: recipe['title'],
                            icon: recipe['icon'],
                            recipe: recipe['recipe'],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search recipes...',
          hintStyle: GoogleFonts.poppins(color: AppTheme.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppTheme.primaryOrange),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterRecipes();
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _buildFilterChip('All', true),
          const SizedBox(width: 8),
          _buildFilterChip('Easy', false),
          const SizedBox(width: 8),
          _buildFilterChip('Medium', false),
          const SizedBox(width: 8),
          _buildFilterChip('Hard', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        // Add filter logic here
      },
      selectedColor: AppTheme.primaryOrange.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryOrange,
    );
  }

  Widget _buildRecipeCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Map<String, dynamic> recipe,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, '/result', arguments: recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryOrange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: AppTheme.primaryOrange, size: 24),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          recipe['description'],
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: AppTheme.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildInfoChip(Icons.timer, recipe['prepTime']),
                  const SizedBox(width: 12),
                  _buildInfoChip(Icons.people, '${recipe['servings']} servings'),
                  const SizedBox(width: 12),
                  _buildDifficultyChip(recipe['difficulty']),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.lightOrange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primaryOrange),
          const SizedBox(width: 4),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.primaryOrange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyChip(String difficulty) {
    Color color;
    switch (difficulty.toLowerCase()) {
      case 'easy':
        color = Colors.green;
        break;
      case 'medium':
        color = Colors.orange;
        break;
      case 'hard':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        difficulty,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
