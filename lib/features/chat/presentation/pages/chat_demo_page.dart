import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'chat_detail_page.dart';

class ChatDemoPage extends StatelessWidget {
  const ChatDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text('Chat Demo'),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF2C3E50),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chat Contacts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 20),
            _buildContactTile(
              context,
              name: 'Sarah Johnson',
              lastMessage: 'That recipe looks amazing! 🍰',
              time: '2:30 PM',
              avatar: '👩‍🍳',
            ),
            _buildContactTile(
              context,
              name: 'Mike Chen',
              lastMessage: 'Thanks for the cooking tips!',
              time: '1:15 PM',
              avatar: '👨‍🍳',
            ),
            _buildContactTile(
              context,
              name: 'Emma Wilson',
              lastMessage: 'Let\'s cook together this weekend',
              time: '11:45 AM',
              avatar: '👩‍🦰',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactTile(
    BuildContext context, {
    required String name,
    required String lastMessage,
    required String time,
    required String avatar,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
          child: Text(
            avatar,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF2C3E50),
          ),
        ),
        subtitle: Text(
          lastMessage,
          style: const TextStyle(
            color: Color(0xFF718096),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(
          time,
          style: const TextStyle(
            color: Color(0xFF95A5A6),
            fontSize: 12,
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatDetailPage(
                recipientName: name,
              ),
            ),
          );
        },
      ),
    );
  }
}
