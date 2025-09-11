import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/recipe.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;
  final VoidCallback? onLike;
  final VoidCallback? onSave;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onLike,
    this.onSave,
    this.onComment,
    this.onShare,
    this.onTap,
  });

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;
  bool _showHeartAnimation = false;

  @override
  void initState() {
    super.initState();
    _likeAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _likeAnimationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  void _handleDoubleTap() {
    if (!widget.recipe.isLiked) {
      widget.onLike?.call();
      setState(() {
        _showHeartAnimation = true;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(widget.recipe.authorImageUrl),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.recipe.authorName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 14,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.textLight),
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),

          // Recipe Image
          GestureDetector(
            onDoubleTap: _handleDoubleTap,
            onTap: widget.onTap,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                    bottom: Radius.circular(8),
                  ),
                  child: Image.network(
                    widget.recipe.imageUrl,
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
                if (_showHeartAnimation)
                  Positioned.fill(
                    child: Center(
                      child: AnimatedBuilder(
                        animation: _likeAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _likeAnimation.value,
                            child: Icon(
                              Icons.favorite,
                              color: AppColors.primary,
                              size: 80,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Action Row
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                _ActionButton(
                  icon: widget.recipe.isLiked
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: widget.recipe.isLiked
                      ? AppColors.primary
                      : AppColors.textLight,
                  onPressed: widget.onLike,
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.textLight,
                  onPressed: widget.onComment,
                ),
                const SizedBox(width: 16),
                _ActionButton(
                  icon: Icons.share_outlined,
                  color: AppColors.textLight,
                  onPressed: widget.onShare,
                ),
                const Spacer(),
                _ActionButton(
                  icon: widget.recipe.isSaved
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  color: widget.recipe.isSaved
                      ? AppColors.secondary
                      : AppColors.textLight,
                  onPressed: widget.onSave,
                ),
              ],
            ),
          ),

          // Likes & Comments Preview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.recipe.likesCount > 0)
                  Text(
                    'Liked by ${widget.recipe.authorName} and ${widget.recipe.likesCount - 1} others',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                      fontSize: 13,
                    ),
                  ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.recipe.authorName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                      TextSpan(
                        text: ' ${widget.recipe.description}',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (widget.recipe.commentsCount > 0) ...[
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: widget.onComment,
                    child: Text(
                      'View all ${widget.recipe.commentsCount} comments',
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 4),
                Text(
                  timeago.format(widget.recipe.createdAt),
                  style: const TextStyle(
                    color: AppColors.textLight,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
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
      },
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 24,
            ),
          );
        },
      ),
    );
  }
}
