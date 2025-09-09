class Message {
  final String id;
  final String content;
  final bool isFromCurrentUser;
  final DateTime timestamp;
  final String? senderName;

  const Message({
    required this.id,
    required this.content,
    required this.isFromCurrentUser,
    required this.timestamp,
    this.senderName,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      isFromCurrentUser: json['isFromCurrentUser'],
      timestamp: DateTime.parse(json['timestamp']),
      senderName: json['senderName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'isFromCurrentUser': isFromCurrentUser,
      'timestamp': timestamp.toIso8601String(),
      'senderName': senderName,
    };
  }
}
