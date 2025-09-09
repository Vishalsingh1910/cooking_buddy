import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/home_providers.dart';
import 'recipe_card.dart';
import 'recipe_loading_shimmer.dart';

class RecipeFeed extends ConsumerWidget {
  const RecipeFeed({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recipeFeedState = ref.watch(recipeFeedProvider);

    return recipeFeedState.when(
      data: (recipes) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 375),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: index == recipes.length - 1 ? 100 : 16,
                    ),
                    child: RecipeCard(recipe: recipes[index]),
                  ),
                ),
              ),
            );
          },
          childCount: recipes.length,
        ),
      ),
      loading: () => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: index == 2 ? 100 : 16,
            ),
            child: const RecipeLoadingShimmer(),
          ),
          childCount: 3,
        ),
      ),
      error: (error, stackTrace) => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load recipes',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    ref.read(recipeFeedProvider.notifier).loadRecipes();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
