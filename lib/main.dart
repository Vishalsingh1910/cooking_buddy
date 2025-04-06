import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe App',
      theme: ThemeData(primarySwatch: Colors.green),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/selection': (context) => const ItemSelectionScreen(),
        '/result': (context) => const ResultScreen(),
        '/thankyou': (context) => const ThankYouScreen(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // Optional: Add a background gradient
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Icon or Logo
                Icon(
                  Icons.restaurant_menu,
                  size: 100,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(height: 20),
                // Welcome Text
                Text(
                  'Welcome to Cooking Buddy!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Subtitle
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Your personal cooking assistant to explore recipes and master your culinary skills',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 40),
                // Navigation Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/selection');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemSelectionScreen extends StatefulWidget {
  const ItemSelectionScreen({super.key});

  @override
  State<ItemSelectionScreen> createState() => _ItemSelectionScreenState();
}

class _ItemSelectionScreenState extends State<ItemSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allRecipes = [];
  List<Map<String, dynamic>> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _allRecipes = [
      {
        'title': 'Paneer Tikka',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Spicy grilled paneer skewers',
          'prepTime': '25 min',
          'steps': [
            'Marinate paneer cubes with yogurt and spices',
            'Skewer paneer with bell peppers and onions',
            'Grill or bake until charred (15 min)',
            'Serve with mint chutney'
          ]
        }
      },
      {
        'title': 'Chole Masala',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Spicy chickpea curry',
          'prepTime': '35 min',
          'steps': [
            'Soak chickpeas overnight and boil until tender',
            'Sauté onions, tomatoes, and spices',
            'Add chickpeas and simmer for 20 min',
            'Garnish with cilantro and serve with bhature'
          ]
        }
      },
      {
        'title': 'Aloo Gobi',
        'icon': Icons.local_florist,
        'recipe': {
          'description': 'Potato and cauliflower stir-fry',
          'prepTime': '20 min',
          'steps': [
            'Chop potatoes and cauliflower into bite-sized pieces',
            'Sauté cumin seeds, turmeric, and ginger',
            'Add vegetables and cook until tender',
            'Season with garam masala and serve with roti'
          ]
        }
      },
      {
        'title': 'Dal Tadka',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Tempered lentil curry',
          'prepTime': '25 min',
          'steps': [
            'Boil yellow lentils with turmeric and salt',
            'Heat ghee and temper with cumin, garlic, and chilies',
            'Pour tempering over lentils',
            'Serve with rice or naan'
          ]
        }
      },
      {
        'title': 'Biryani',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Fragrant rice with spiced meat',
          'prepTime': '45 min',
          'steps': [
            'Marinate meat with yogurt and spices',
            'Parboil rice with whole spices',
            'Layer rice and meat in a pot, cook on low heat',
            'Garnish with fried onions and serve with raita'
          ]
        }
      },
      {
        'title': 'Palak Paneer',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Spinach and paneer curry',
          'prepTime': '25 min',
          'steps': [
            'Blanch spinach and blend into a puree',
            'Sauté onions, garlic, and spices',
            'Add spinach puree and paneer cubes',
            'Simmer and serve with naan'
          ]
        }
      },
      {
        'title': 'Samosa',
        'icon': Icons.fastfood,
        'recipe': {
          'description': 'Crispy fried pastry with spiced filling',
          'prepTime': '40 min',
          'steps': [
            'Prepare dough with flour, water, and oil',
            'Cook spiced potatoes and peas for filling',
            'Shape dough into cones, fill, and seal',
            'Deep fry until golden and serve with chutney'
          ]
        }
      },
      {
        'title': 'Rogan Josh',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Aromatic lamb curry',
          'prepTime': '50 min',
          'steps': [
            'Marinate lamb with yogurt and spices',
            'Sauté onions, ginger, and garlic',
            'Add lamb and simmer with tomatoes and spices',
            'Serve with rice or naan'
          ]
        }
      },
      {
        'title': 'Pav Bhaji',
        'icon': Icons.fastfood,
        'recipe': {
          'description': 'Spicy mashed vegetable curry with bread',
          'prepTime': '30 min',
          'steps': [
            'Boil and mash potatoes, peas, and carrots',
            'Sauté onions, tomatoes, and pav bhaji masala',
            'Mix in mashed vegetables and simmer',
            'Serve with buttered pav buns'
          ]
        }
      },
      {
        'title': 'Butter Chicken',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Creamy tomato-based chicken curry',
          'prepTime': '30 min',
          'steps': [
            'Marinate chicken with yogurt and spices for 1 hour',
            'Grill or sauté chicken until cooked',
            'Cook tomatoes, butter, and cream into a sauce',
            'Add chicken to sauce and simmer for 10 min',
            'Serve with naan or rice'
          ]
        }
      },
      {
        'title': 'Tandoori Chicken',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Spicy grilled chicken',
          'prepTime': '35 min',
          'steps': [
            'Marinate chicken with yogurt, spices, and red food color',
            'Grill or bake until charred (20-25 min)',
            'Squeeze lemon juice on top',
            'Serve with naan and chutney'
          ]
        }
      },
      {
        'title': 'Masala Dosa',
        'icon': Icons.fastfood,
        'recipe': {
          'description': 'Crispy pancake with potato filling',
          'prepTime': '40 min',
          'steps': [
            'Prepare batter with fermented rice and lentils',
            'Cook spiced potato filling with mustard seeds',
            'Spread batter on a hot pan and cook until crispy',
            'Add filling and serve with sambar and chutney'
          ]
        }
      },
      {
        'title': 'Rajma',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Kidney bean curry',
          'prepTime': '35 min',
          'steps': [
            'Soak kidney beans overnight and boil',
            'Sauté onions, tomatoes, and spices',
            'Add beans and simmer until thick',
            'Serve with rice'
          ]
        }
      },
      {
        'title': 'Kheer',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Creamy rice pudding',
          'prepTime': '30 min',
          'steps': [
            'Boil milk and soak rice for 20 min',
            'Cook rice in milk until soft',
            'Add sugar, cardamom, and nuts',
            'Serve warm or chilled'
          ]
        }
      },
      {
        'title': 'Fish Curry',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Spicy coconut-based fish curry',
          'prepTime': '25 min',
          'steps': [
            'Marinate fish with turmeric and salt',
            'Sauté mustard seeds, curry leaves, and onions',
            'Add coconut milk and spices, simmer with fish',
            'Serve with rice'
          ]
        }
      },
      {
        'title': 'Vegetable Pulao',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Fragrant rice with mixed vegetables',
          'prepTime': '20 min',
          'steps': [
            'Sauté whole spices in ghee',
            'Add chopped vegetables and rice',
            'Cook with water until rice is fluffy',
            'Serve with raita'
          ]
        }
      },
      {
        'title': 'Chicken Tikka Masala',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Grilled chicken in spiced tomato sauce',
          'prepTime': '40 min',
          'steps': [
            'Marinate chicken and grill until charred',
            'Sauté onions, tomatoes, and spices',
            'Add cream and grilled chicken, simmer',
            'Serve with naan'
          ]
        }
      },
      {
        'title': 'Gulab Jamun',
        'icon': Icons.local_dining,
        'recipe': {
          'description': 'Sweet milk dumplings in syrup',
          'prepTime': '30 min',
          'steps': [
            'Make dough with milk powder and flour',
            'Shape into balls and deep fry',
            'Soak in sugar syrup with cardamom',
            'Serve warm'
          ]
        }
      },
      {
        'title': 'Saag Aloo',
        'icon': Icons.local_florist,
        'recipe': {
          'description': 'Spinach and potato curry',
          'prepTime': '25 min',
          'steps': [
            'Blanch spinach and blend into a puree',
            'Sauté potatoes with cumin and spices',
            'Add spinach puree and simmer',
            'Serve with roti'
          ]
        }
      },
      {
        'title': 'Pani Puri',
        'icon': Icons.fastfood,
        'recipe': {
          'description': 'Crispy puris with spicy water',
          'prepTime': '30 min',
          'steps': [
            'Make dough and fry small puris',
            'Prepare spiced potato filling',
            'Mix tamarind, mint, and spices for water',
            'Serve with filling and spicy water'
          ]
        }
      },
    ];
    _filteredRecipes = _allRecipes;
    _searchController.addListener(_filterRecipes);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRecipes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredRecipes = _allRecipes.where((recipe) {
        final title = recipe['title'].toString().toLowerCase();
        final description = recipe['recipe']['description'].toString().toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Recipe'),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search recipes...',
                  prefixIcon: Icon(Icons.search, color: Colors.orange.shade700),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredRecipes.length,
                itemBuilder: (context, index) {
                  final recipe = _filteredRecipes[index];
                  return _buildRecipeCard(
                    context: context,
                    title: recipe['title'],
                    icon: recipe['icon'],
                    recipe: recipe['recipe'],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Map<String, dynamic> recipe,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('${recipe['description']} • ${recipe['prepTime']}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.pushNamed(context, '/result', arguments: recipe);
        },
      ),
    );
  }
}

// class ItemSelectionScreen extends StatelessWidget {
//   const ItemSelectionScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Choose Your Recipe'),
//         backgroundColor: Colors.orange.shade700,
//         elevation: 0,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.orange.shade50, Colors.white],
//           ),
//         ),
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildRecipeCard(
//               context: context,
//               title: 'Creamy Pasta Alfredo',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'A rich and creamy pasta dish',
//                 'prepTime': '15 min',
//                 'steps': [
//                   'Boil pasta in salted water until al dente (8-10 min)',
//                   'Melt butter and sauté garlic in a pan',
//                   'Add heavy cream and parmesan cheese',
//                   'Mix in cooked pasta and season with salt & pepper',
//                   'Serve hot with fresh parsley'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Mediterranean Salad',
//               icon: Icons.local_florist,
//               recipe: {
//                 'description': 'Fresh and healthy salad bowl',
//                 'prepTime': '10 min',
//                 'steps': [
//                   'Chop tomatoes, cucumbers, and red onions',
//                   'Add feta cheese and olives',
//                   'Mix olive oil, lemon juice, and herbs for dressing',
//                   'Toss all ingredients with dressing',
//                   'Serve fresh with pita bread'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Grilled Chicken Sandwich',
//               icon: Icons.fastfood,
//               recipe: {
//                 'description': 'Juicy and flavorful sandwich',
//                 'prepTime': '20 min',
//                 'steps': [
//                   'Marinate chicken with spices and olive oil',
//                   'Grill chicken until fully cooked (8-10 min)',
//                   'Toast bread and spread mayo',
//                   'Layer with lettuce, tomato, and chicken',
//                   'Serve with fries or salad'
//                 ]
//               },
//             ),
//             // Indian Dishes Start Here
//             _buildRecipeCard(
//               context: context,
//               title: 'Butter Chicken',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Creamy tomato-based chicken curry',
//                 'prepTime': '30 min',
//                 'steps': [
//                   'Marinate chicken with yogurt and spices for 1 hour',
//                   'Grill or sauté chicken until cooked',
//                   'Cook tomatoes, butter, and cream into a sauce',
//                   'Add chicken to sauce and simmer for 10 min',
//                   'Serve with naan or rice'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Paneer Tikka',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Spicy grilled paneer skewers',
//                 'prepTime': '25 min',
//                 'steps': [
//                   'Marinate paneer cubes with yogurt and spices',
//                   'Skewer paneer with bell peppers and onions',
//                   'Grill or bake until charred (15 min)',
//                   'Serve with mint chutney'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Chole Masala',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Spicy chickpea curry',
//                 'prepTime': '35 min',
//                 'steps': [
//                   'Soak chickpeas overnight and boil until tender',
//                   'Sauté onions, tomatoes, and spices',
//                   'Add chickpeas and simmer for 20 min',
//                   'Garnish with cilantro and serve with bhature'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Aloo Gobi',
//               icon: Icons.local_florist,
//               recipe: {
//                 'description': 'Potato and cauliflower stir-fry',
//                 'prepTime': '20 min',
//                 'steps': [
//                   'Chop potatoes and cauliflower into bite-sized pieces',
//                   'Sauté cumin seeds, turmeric, and ginger',
//                   'Add vegetables and cook until tender',
//                   'Season with garam masala and serve with roti'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Dal Tadka',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Tempered lentil curry',
//                 'prepTime': '25 min',
//                 'steps': [
//                   'Boil yellow lentils with turmeric and salt',
//                   'Heat ghee and temper with cumin, garlic, and chilies',
//                   'Pour tempering over lentils',
//                   'Serve with rice or naan'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Biryani',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Fragrant rice with spiced meat',
//                 'prepTime': '45 min',
//                 'steps': [
//                   'Marinate meat with yogurt and spices',
//                   'Parboil rice with whole spices',
//                   'Layer rice and meat in a pot, cook on low heat',
//                   'Garnish with fried onions and serve with raita'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Palak Paneer',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Spinach and paneer curry',
//                 'prepTime': '25 min',
//                 'steps': [
//                   'Blanch spinach and blend into a puree',
//                   'Sauté onions, garlic, and spices',
//                   'Add spinach puree and paneer cubes',
//                   'Simmer and serve with naan'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Samosa',
//               icon: Icons.fastfood,
//               recipe: {
//                 'description': 'Crispy fried pastry with spiced filling',
//                 'prepTime': '40 min',
//                 'steps': [
//                   'Prepare dough with flour, water, and oil',
//                   'Cook spiced potatoes and peas for filling',
//                   'Shape dough into cones, fill, and seal',
//                   'Deep fry until golden and serve with chutney'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Rogan Josh',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Aromatic lamb curry',
//                 'prepTime': '50 min',
//                 'steps': [
//                   'Marinate lamb with yogurt and spices',
//                   'Sauté onions, ginger, and garlic',
//                   'Add lamb and simmer with tomatoes and spices',
//                   'Serve with rice or naan'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Pav Bhaji',
//               icon: Icons.fastfood,
//               recipe: {
//                 'description': 'Spicy mashed vegetable curry with bread',
//                 'prepTime': '30 min',
//                 'steps': [
//                   'Boil and mash potatoes, peas, and carrots',
//                   'Sauté onions, tomatoes, and pav bhaji masala',
//                   'Mix in mashed vegetables and simmer',
//                   'Serve with buttered pav buns'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Tandoori Chicken',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Spicy grilled chicken',
//                 'prepTime': '35 min',
//                 'steps': [
//                   'Marinate chicken with yogurt, spices, and red food color',
//                   'Grill or bake until charred (20-25 min)',
//                   'Squeeze lemon juice on top',
//                   'Serve with naan and chutney'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Masala Dosa',
//               icon: Icons.fastfood,
//               recipe: {
//                 'description': 'Crispy pancake with potato filling',
//                 'prepTime': '40 min',
//                 'steps': [
//                   'Prepare batter with fermented rice and lentils',
//                   'Cook spiced potato filling with mustard seeds',
//                   'Spread batter on a hot pan and cook until crispy',
//                   'Add filling and serve with sambar and chutney'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Rajma',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Kidney bean curry',
//                 'prepTime': '35 min',
//                 'steps': [
//                   'Soak kidney beans overnight and boil',
//                   'Sauté onions, tomatoes, and spices',
//                   'Add beans and simmer until thick',
//                   'Serve with rice'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Kheer',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Creamy rice pudding',
//                 'prepTime': '30 min',
//                 'steps': [
//                   'Boil milk and soak rice for 20 min',
//                   'Cook rice in milk until soft',
//                   'Add sugar, cardamom, and nuts',
//                   'Serve warm or chilled'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Fish Curry',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Spicy coconut-based fish curry',
//                 'prepTime': '25 min',
//                 'steps': [
//                   'Marinate fish with turmeric and salt',
//                   'Sauté mustard seeds, curry leaves, and onions',
//                   'Add coconut milk and spices, simmer with fish',
//                   'Serve with rice'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Vegetable Pulao',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Fragrant rice with mixed vegetables',
//                 'prepTime': '20 min',
//                 'steps': [
//                   'Sauté whole spices in ghee',
//                   'Add chopped vegetables and rice',
//                   'Cook with water until rice is fluffy',
//                   'Serve with raita'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Chicken Tikka Masala',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Grilled chicken in spiced tomato sauce',
//                 'prepTime': '40 min',
//                 'steps': [
//                   'Marinate chicken and grill until charred',
//                   'Sauté onions, tomatoes, and spices',
//                   'Add cream and grilled chicken, simmer',
//                   'Serve with naan'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Gulab Jamun',
//               icon: Icons.local_dining,
//               recipe: {
//                 'description': 'Sweet milk dumplings in syrup',
//                 'prepTime': '30 min',
//                 'steps': [
//                   'Make dough with milk powder and flour',
//                   'Shape into balls and deep fry',
//                   'Soak in sugar syrup with cardamom',
//                   'Serve warm'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Saag Aloo',
//               icon: Icons.local_florist,
//               recipe: {
//                 'description': 'Spinach and potato curry',
//                 'prepTime': '25 min',
//                 'steps': [
//                   'Blanch spinach and blend into a puree',
//                   'Sauté potatoes with cumin and spices',
//                   'Add spinach puree and simmer',
//                   'Serve with roti'
//                 ]
//               },
//             ),
//             _buildRecipeCard(
//               context: context,
//               title: 'Pani Puri',
//               icon: Icons.fastfood,
//               recipe: {
//                 'description': 'Crispy puris with spicy water',
//                 'prepTime': '30 min',
//                 'steps': [
//                   'Make dough and fry small puris',
//                   'Prepare spiced potato filling',
//                   'Mix tamarind, mint, and spices for water',
//                   'Serve with filling and spicy water'
//                 ]
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecipeCard({
//     required BuildContext context,
//     required String title,
//     required IconData icon,
//     required Map<String, dynamic> recipe,
//   }) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.only(bottom: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: Colors.orange.shade100,
//           child: Icon(icon, color: Colors.orange.shade700),
//         ),
//         title: Text(
//           title,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//         subtitle: Text('${recipe['description']} • ${recipe['prepTime']}'),
//         trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//         onTap: () {
//           Navigator.pushNamed(context, '/result', arguments: recipe);
//         },
//       ),
//     );
//   }
// }

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> recipe =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recipe'),
        backgroundColor: Colors.orange.shade700,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                recipe['description'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Prep Time: ${recipe['prepTime']}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'Steps:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: recipe['steps'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.orange.shade700,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              recipe['steps'][index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Center(
                // child: ElevatedButton(
                //   onPressed: () {
                //     Navigator.pushNamed(context, '/thankyou');
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.orange.shade700,
                //     padding: const EdgeInsets.symmetric(
                //       horizontal: 40,
                //       vertical: 15,
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30),
                //     ),
                //   ),
                //   child: const Text(
                //     'Finish',
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to the next screen
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => NextScreen()),
                    // );
                    Navigator.pushNamed(context, '/thankyou');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thank You'),
        backgroundColor: Colors.orange.shade700),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.orange.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Thank you for using the app!', style: TextStyle(fontSize: 18)),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.popUntil(context, ModalRoute.withName('/'));
              //   },
              //   child: const Text('Go Home'),
              // ),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Go Home',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
