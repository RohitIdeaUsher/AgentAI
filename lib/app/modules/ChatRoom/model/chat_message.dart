import 'package:hive/hive.dart';

part 'chat_message.g.dart';

@HiveType(typeId: 0) // Unique typeId for ChatMessage
class ChatMessage {
  @HiveField(0)
  final String role; // 'user' or 'bot'

  @HiveField(1)
  final String message;

  @HiveField(2)
  final String timeStamp;

  @HiveField(3)
  bool isloading;

  ChatMessage({
    required this.role,
    required this.message,
    required this.timeStamp,
    this.isloading = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'message': message,
      'timeStamp': timeStamp,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      role: json['role'],
      message: json['message'],
      timeStamp: json['timeStamp'],
    );
  }
}
