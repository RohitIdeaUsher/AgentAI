import 'package:hive/hive.dart';
import 'package:virtualagentchat/app/modules/ChatRoom/model/chat_message.dart';
part 'chat_session.g.dart';

@HiveType(typeId: 1) // Unique typeId for ChatSession
class ChatSession {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String createdAt;

  @HiveField(2)
  final List<ChatMessage> messages;

  ChatSession({
    required this.id,
    required this.createdAt,
    required this.messages,
  });

  factory ChatSession.fromJson(Map<String, dynamic> json) {
    return ChatSession(
      id: json['id'],
      createdAt: json['createdAt'],
      messages: List<ChatMessage>.from(
          json['messages'].map((msg) => ChatMessage.fromJson(msg))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt,
      'messages': messages.map((msg) => msg.toJson()).toList(),
    };
  }
}
