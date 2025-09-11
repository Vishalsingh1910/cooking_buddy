import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recipe.dart';

class CookingRecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onCookedIt;
  final VoidCallback? onTap;

  const CookingRecipeCard({
    super.key,
    required this.recipe,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onCookedIt,
    this.onTap,
  });

  @override
  State<CookingRecipeCard> createState() => _CookingRecipeCardState();
}

class _CookingRecipeCardState extends State<CookingRecipeCard>
    with TickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  late AnimationController _swipeAnimationController;
  late Animation<double> _likeAnimation;
  late Animation<Offset> _swipeAnimation;
  bool _showHeartAnimation = false;
  bool _isLiked = false;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.recipe.isLiked;
    _isSaved = widget.recipe.isSaved;

    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _likeAnimationController, curve: Curves.elasticOut),
    );

    _swipeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _swipeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.3, 0),
    ).animate(CurvedAnimation(
      parent: _swipeAnimationController,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    _swipeAnimationController.dispose();
    super.dispose();
  }

  void _handleSwipeRight() {
    if (!_isLiked) {
      setState(() {
        _isLiked = true;
        _showHeartAnimation = true;
      });

      _swipeAnimationController.forward().then((_) {
        _swipeAnimationController.reverse();
      });

      _likeAnimationController.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _showHeartAnimation = false;
            });
            _likeAnimationController.reset();
          }
        });
      });

      widget.onLike?.call();
      HapticFeedback.lightImpact();
    }
  }

  String _getDifficultyText() {
    if (widget.recipe.cookingTimeMinutes <= 15) return 'Quick';
    if (widget.recipe.cookingTimeMinutes <= 30) return 'Easy';
    if (widget.recipe.cookingTimeMinutes <= 60) return 'Medium';
    return 'Advanced';
  }

  Color _getDifficultyColor() {
    if (widget.recipe.cookingTimeMinutes <= 15) return AppColors.secondary;
    if (widget.recipe.cookingTimeMinutes <= 30) return AppColors.success;
    if (widget.recipe.cookingTimeMinutes <= 60) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          _handleSwipeRight();
        }
      },
      child: AnimatedBuilder(
        animation: _swipeAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: _swipeAnimation.value * 100,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Image with Overlay Tags
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                          child: Image.network(
                            widget.recipe.imageUrl,
                            width: double.infinity,
                            height: 240,
                            fit: BoxFit.cover,
                          ),
                        ),

                        // Time Badge
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${widget.recipe.cookingTimeMinutes} mins',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // Difficulty Badge
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: _getDifficultyColor(),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getDifficultyText(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        // Heart Animation Overlay
                        if (_showHeartAnimation)
                          Positioned.fill(
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _likeAnimation,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _likeAnimation.value,
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color:
                                            Colors.black.withValues(alpha: 0.3),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.favorite,
                                        color: AppColors.primary,
                                        size: 60,
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

                  // Recipe Info Section
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Recipe Title
                        Text(
                          widget.recipe.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Author and Stats
                        Row(
                          children: [
                            Text(
                              'by ${widget.recipe.authorName}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Text(
                              ' • ',
                              style: TextStyle(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${(widget.recipe.likesCount / 1000).toStringAsFixed(1)}k likes',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Rating Stars
                        Row(
                          children: [
                            ...List.generate(5, (index) {
                              return Icon(
                                index < widget.recipe.rating.floor()
                                    ? Icons.star
                                    : index < widget.recipe.rating
                                        ? Icons.star_half
                                        : Icons.star_border,
                                color: AppColors.warning,
                                size: 16,
                              );
                            }),
                            const SizedBox(width: 8),
                            Text(
                              '${widget.recipe.rating}/5',
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Action Buttons Row
                        Row(
                          children: [
                            // Like Button
                            _CookingActionButton(
                              icon: _isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              label: 'Like',
                              color: _isLiked
                                  ? AppColors.primary
                                  : AppColors.textLight,
                              onPressed: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                                widget.onLike?.call();
                              },
                            ),
                            const SizedBox(width: 16),

                            // Tips & Reviews Button
                            _CookingActionButton(
                              icon: Icons.chat_bubble_outline,
                              label: 'Tips & Reviews',
                              color: AppColors.textLight,
                              onPressed: widget.onComment,
                            ),
                            const Spacer(),

                            // Save Button (Fork & Spoon Style)
                            _CookingActionButton(
                              icon: _isSaved
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              label: '',
                              color: _isSaved
                                  ? AppColors.secondary
                                  : AppColors.textLight,
                              onPressed: () {
                                setState(() {
                                  _isSaved = !_isSaved;
                                });
                                widget.onSave?.call();
                              },
                            ),
                            const SizedBox(width: 8),

                            // Cooked It Button
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: GestureDetector(
                                onTap: widget.onCookedIt,
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.restaurant,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Cooked it!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
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

class _CookingActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onPressed;

  const _CookingActionButton({
    required this.icon,
    required this.label,
    required this.color,
    this.onPressed,
  });

  @override
  State<_CookingActionButton> createState() => _CookingActionButtonState();
}

class _CookingActionButtonState extends State<_CookingActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) => _controller.reverse());
        widget.onPressed?.call();
        HapticFeedback.lightImpact();
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  widget.icon,
                  color: widget.color,
                  size: 20,
                ),
                if (widget.label.isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Text(
                    widget.label,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
