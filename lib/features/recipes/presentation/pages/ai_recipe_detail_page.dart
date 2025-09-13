import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recipe.dart';

class AIRecipeDetailPage extends StatefulWidget {
  final Recipe recipe;
  final List<String> userIngredients;

  const AIRecipeDetailPage({
    super.key,
    required this.recipe,
    required this.userIngredients,
  });

  @override
  State<AIRecipeDetailPage> createState() => _AIRecipeDetailPageState();
}

class _AIRecipeDetailPageState extends State<AIRe