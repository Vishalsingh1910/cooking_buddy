// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0x00000000),
//       ),
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Detail Screen')),
//         body: Center(child: Text("message")),
//       ),
//     );
//   }
// }

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

// 1. Welcome Screen
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Welcome')),
      backgroundColor: Colors.red[800],
      body: Column(
        children: [
          ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/selection');
          },
          child: const Text('Start'),
        ),
        ]
      ),
    );
  }

  const WelcomeScreen({super.key});
}

// 2. Item Selection Screen
class ItemSelectionScreen extends StatelessWidget {
  const ItemSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select an Item')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Pasta'),
            onTap: () {
              Navigator.pushNamed(context, '/result', arguments: 'Pasta Recipe: Boil pasta, add sauce, enjoy!');
            },
          ),
          ListTile(
            title: const Text('Salad'),
            onTap: () {
              Navigator.pushNamed(context, '/result', arguments: 'Salad Recipe: Chop veggies, mix, and serve fresh!');
            },
          ),
          ListTile(
            title: const Text('Sandwich'),
            onTap: () {
              Navigator.pushNamed(context, '/result', arguments: 'Sandwich Recipe: Take bread, add fillings, toast, and serve!');
            },
          ),
        ],
      ),
    );
  }
}

// 3. Result Screen
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String message = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: const Text('Recipe Result')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/thankyou');
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

// 4. Thank You Screen
class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thank You')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Thank you for using the app!', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
