import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/greeting_section.dart';
import '../widgets/smart_ingredient_input.dart';
import '../widgets/quick_filter_chips.dart';
import '../widgets/recipe_feed.dart';
import '../widgets/context_banner.dart';
import '../providers/home_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(recipeFeedProvider.notifier).refreshRecipes();
        },
        child: CustomScrollView(
          slivers: [
            const HomeAppBar(),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GreetingSection(),
                  const SizedBox(height: 24),
                  const SmartIngredientInput(),
                  const SizedBox(height: 20),
                  const QuickFilterChips(),
                  const SizedBox(height: 16),
                  const ContextBanner(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const RecipeFeed(),
          ],
        ),
      ),
    );
  }
}
