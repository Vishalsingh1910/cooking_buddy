// lib/navigation.dart
import 'package:cooking_buddy/features/recipes/presentation/pages/item_selection_screen.dart';
import 'package:flutter/material.dart';

// A helper function for navigation
void goToRecipeDetail(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ItemSelectionScreen(),
    ),
  );
}
