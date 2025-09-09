import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/chat_list_item.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              child: Row(
                children: [
                  const Text(
                    'Community Chat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  // Search Icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search,
                        color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),

            // Chat List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingMedium),
                itemCount: _getChatItems().length,
                itemBuilder: (context, index) {
                  final chatItem = _getChatItems()[index];
                  return Padding(
                    padding: const EdgeInsets.only(
                        bottom: AppConstants.paddingSmall),
                    child: ChatListItem(
                      profileImage: chatItem['profileImage'],
                      name: chatItem['name'],
                      lastMessage: chatItem['lastMessage'],
                      timestamp: chatItem['timestamp'],
                      isGroup: chatItem['isGroup'],
                      unreadCount: chatItem['unreadCount'],
                      isOnline: chatItem['isOnline'],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewChatOptions(context);
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  List<Map<String, dynamic>> _getChatItems() {
    return [
      {
        'profileImage': 'https://picsum.photos/50/50?random=1',
        'name': 'Chef Maria Rodriguez',
        'lastMessage': 'Thanks for trying my pasta recipe! 🍝',
        'timestamp': '2m ago',
        'isGroup': false,
        'unreadCount': 2,
        'isOnline': true,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=2',
        'name': 'Vegetarian Recipes',
        'lastMessage': 'Sarah: Just posted a new quinoa bowl recipe!',
        'timestamp': '15m ago',
        'isGroup': true,
        'unreadCount': 5,
        'isOnline': false,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=3',
        'name': 'Gordon Ramsay',
        'lastMessage': 'The secret is in the seasoning timing',
        'timestamp': '1h ago',
        'isGroup': false,
        'unreadCount': 0,
        'isOnline': false,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=4',
        'name': 'Quick Meals',
        'lastMessage': 'Mike: 15-minute dinner ideas anyone?',
        'timestamp': '2h ago',
        'isGroup': true,
        'unreadCount': 12,
        'isOnline': false,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=5',
        'name': 'Julia Chen',
        'lastMessage': 'Your dumplings look amazing! Recipe please? 🥟',
        'timestamp': '3h ago',
        'isGroup': false,
        'unreadCount': 1,
        'isOnline': true,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=6',
        'name': 'Baking Masters',
        'lastMessage': 'Emma: Sourdough starter tips in comments',
        'timestamp': '5h ago',
        'isGroup': true,
        'unreadCount': 0,
        'isOnline': false,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=7',
        'name': 'Anthony Bourdain Fan',
        'lastMessage': 'Just tried that Vietnamese pho recipe',
        'timestamp': '1d ago',
        'isGroup': false,
        'unreadCount': 0,
        'isOnline': false,
      },
      {
        'profileImage': 'https://picsum.photos/50/50?random=8',
        'name': 'Dessert Lovers',
        'lastMessage': 'Lisa: Chocolate lava cake success! 🍫',
        'timestamp': '2d ago',
        'isGroup': true,
        'unreadCount': 3,
        'isOnline': false,
      },
    ];
  }

  void _showNewChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.radiusLarge),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppConstants.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppConstants.paddingLarge),

            // Options
            _buildChatOption(
              icon: Icons.person_add,
              title: 'Start New Conversation',
              subtitle: 'Chat with a recipe creator',
              onTap: () {
                Navigator.pop(context);
                // Navigate to user search
              },
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildChatOption(
              icon: Icons.group_add,
              title: 'Join Cooking Group',
              subtitle: 'Find groups by cuisine or skill level',
              onTap: () {
                Navigator.pop(context);
                // Navigate to group discovery
              },
            ),
            const SizedBox(height: AppConstants.paddingMedium),
            _buildChatOption(
              icon: Icons.create,
              title: 'Create Cooking Group',
              subtitle: 'Start your own cooking community',
              onTap: () {
                Navigator.pop(context);
                // Navigate to group creation
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppConstants.paddingMedium),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.paddingMedium),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(width: AppConstants.paddingMedium),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios,
                size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}
