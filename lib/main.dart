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

class ItemSelectionScreen extends StatelessWidget {
  const ItemSelectionScreen({super.key});

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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildRecipeCard(
              context: context,
              title: 'Creamy Pasta Alfredo',
              icon: Icons.local_dining,
              recipe: {
                'description': 'A rich and creamy pasta dish',
                'prepTime': '15 min',
                'steps': [
                  'Boil pasta in salted water until al dente (8-10 min)',
                  'Melt butter and sauté garlic in a pan',
                  'Add heavy cream and parmesan cheese',
                  'Mix in cooked pasta and season with salt & pepper',
                  'Serve hot with fresh parsley'
                ]
              },
            ),
            _buildRecipeCard(
              context: context,
              title: 'Mediterranean Salad',
              icon: Icons.local_florist,
              recipe: {
                'description': 'Fresh and healthy salad bowl',
                'prepTime': '10 min',
                'steps': [
                  'Chop tomatoes, cucumbers, and red onions',
                  'Add feta cheese and olives',
                  'Mix olive oil, lemon juice, and herbs for dressing',
                  'Toss all ingredients with dressing',
                  'Serve fresh with pita bread'
                ]
              },
            ),
            _buildRecipeCard(
              context: context,
              title: 'Grilled Chicken Sandwich',
              icon: Icons.fastfood,
              recipe: {
                'description': 'Juicy and flavorful sandwich',
                'prepTime': '20 min',
                'steps': [
                  'Marinate chicken with spices and olive oil',
                  'Grill chicken until fully cooked (8-10 min)',
                  'Toast bread and spread mayo',
                  'Layer with lettuce, tomato, and chicken',
                  'Serve with fries or salad'
                ]
              },
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

// Enhanced Result Screen
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
