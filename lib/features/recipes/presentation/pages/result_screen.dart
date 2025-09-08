import 'package:cooking_buddy/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<bool> completedSteps = [];
  int currentStep = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final recipe = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (completedSteps.isEmpty) {
      completedSteps = List.filled(recipe['steps'].length, false);
    }
  }

  void _toggleStep(int index) {
    setState(() {
      completedSteps[index] = !completedSteps[index];
      if (completedSteps[index] && index == currentStep) {
        currentStep = (currentStep + 1).clamp(0, completedSteps.length - 1);
      }
    });
  }

  double get progress {
    if (completedSteps.isEmpty) return 0.0;
    return completedSteps.where((step) => step).length / completedSteps.length;
  }

  @override
  Widget build(BuildContext context) {
    final recipe = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Steps'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                '${(progress * 100).round()}%',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
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
            _buildRecipeHeader(recipe),
            _buildProgressBar(),
            Expanded(
              child: _buildStepsList(recipe),
            ),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeHeader(Map<String, dynamic> recipe) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            recipe['description'],
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildInfoItem(Icons.timer, recipe['prepTime']),
              const SizedBox(width: 20),
              _buildInfoItem(Icons.people, '${recipe['servings']} servings'),
              const SizedBox(width: 20),
              _buildInfoItem(Icons.restaurant, recipe['difficulty']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppTheme.primaryOrange),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Progress',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppTheme.lightOrange,
            valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primaryOrange),
            minHeight: 8,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildStepsList(Map<String, dynamic> recipe) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: recipe['steps'].length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: _buildStepCard(recipe['steps'][index], index),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStepCard(String step, int index) {
    final isCompleted = completedSteps[index];
    final isCurrent = index == currentStep && !isCompleted;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isCurrent ? Border.all(color: AppTheme.primaryOrange, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _toggleStep(index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: isCompleted ? AppTheme.primaryOrange : AppTheme.lightOrange,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, color: Colors.white, size: 18)
                      : Text(
                          '${index + 1}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryOrange,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  step,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: isCompleted ? AppTheme.textSecondary : AppTheme.textPrimary,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryOrange),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Back to Recipes',
                style: GoogleFonts.poppins(
                  color: AppTheme.primaryOrange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              onPressed: progress == 1.0
                  ? () => Navigator.pushNamed(context, '/thankyou')
                  : null,
              child: Text(
                progress == 1.0 ? 'Complete!' : 'Finish Cooking',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}