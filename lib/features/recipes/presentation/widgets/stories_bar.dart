import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StoriesBar extends StatelessWidget {
  const StoriesBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _stories.length,
        itemBuilder: (context, index) {
          final story = _stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          story.isYou ? AppColors.primary : AppColors.secondary,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(story.imageUrl),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  story.name,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Story {
  final String id;
  final String name;
  final String imageUrl;
  final bool isYou;

  Story({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.isYou = false,
  });
}

final List<Story> _stories = [
  Story(
    id: '1',
    name: 'You',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=150&h=150&fit=crop&crop=face',
    isYou: true,
  ),
  Story(
    id: '2',
    name: 'Chef Ana',
    imageUrl:
        'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150&h=150&fit=crop&crop=face',
  ),
  Story(
    id: '3',
    name: 'Mario',
    imageUrl:
        'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face',
  ),
  Story(
    id: '4',
    name: 'Sarah',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=150&h=150&fit=crop&crop=face',
  ),
  Story(
    id: '5',
    name: 'Gordon',
    imageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
  ),
];
