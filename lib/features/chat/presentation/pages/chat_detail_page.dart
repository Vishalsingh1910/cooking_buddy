import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/message.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/timestamp_chip.dart';
import '../widgets/chat_input_bar.dart';

class ChatDetailPage extends StatefulWidget {
  final String recipientName;
  final String? recipientAvatar;

  const ChatDetailPage({
    super.key,
    required this.recipientName,
    this.recipientAvatar,
  });

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage>
    with TickerProviderStateMixin {
  final List<Message> _messages = [];
  final ScrollController _scrollController = ScrollController();
  late AnimationController _messageAnimationController;

  @override
  void initState() {
    super.initState();
    _messageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _loadSampleMessages();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _messageAnimationController.dispose();
    super.dispose();
  }

  void _loadSampleMessages() {
    // Sample messages for demonstration
    final sampleMessages = [
      Message(
        id: '1',
        content: 'Hey! How\'s your cooking going today?',
        isFromCurrentUser: false,
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        senderName: widget.recipientName,
      ),
      Message(
        id: '2',
        content: 'Great! Just finished making that pasta recipe you shared 🍝',
        isFromCurrentUser: true,
        timestamp:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
      ),
      Message(
        id: '3',
        content: 'Awesome! How did it turn out? Did you add the extra herbs?',
        isFromCurrentUser: false,
        timestamp:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 30)),
        senderName: widget.recipientName,
      ),
      Message(
        id: '4',
        content: 'Yes! The basil made such a difference. Thanks for the tip!',
        isFromCurrentUser: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];

    setState(() {
      _messages.addAll(sampleMessages);
    });
  }

  void _sendMessage(String content) {
    final newMessage = Message(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      content: content,
      isFromCurrentUser: true,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(newMessage);
    });

    // Animate new message
    _messageAnimationController.forward().then((_) {
      _messageAnimationController.reset();
    });

    // Scroll to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  bool _shouldShowTimestamp(int index) {
    if (index == 0) return true;

    final currentMessage = _messages[index];
    final previousMessage = _messages[index - 1];

    final timeDifference =
        currentMessage.timestamp.difference(previousMessage.timestamp);
    return timeDifference.inMinutes > 30;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Column(
                  children: [
                    if (_shouldShowTimestamp(index))
                      TimestampChip(timestamp: message.timestamp),
                    AnimatedBuilder(
                      animation: _messageAnimationController,
                      builder: (context, child) {
                        if (index == _messages.length - 1 &&
                            _messageAnimationController.isAnimating) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.3),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _messageAnimationController,
                              curve: Curves.easeOut,
                            )),
                            child: FadeTransition(
                              opacity: _messageAnimationController,
                              child: ChatBubble(message: message),
                            ),
                          );
                        }
                        return ChatBubble(message: message);
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          ChatInputBar(onSendMessage: _sendMessage),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.1),
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF2C3E50),
          size: 20,
        ),
      ),
      title: Text(
        widget.recipientName,
        style: const TextStyle(
          color: Color(0xFF2C3E50),
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // TODO: Implement phone call
          },
          icon: const Icon(
            Icons.phone,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement video call
          },
          icon: const Icon(
            Icons.videocam,
            color: AppColors.primary,
            size: 24,
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
