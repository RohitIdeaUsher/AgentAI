import 'package:hive_flutter/hive_flutter.dart';
import 'package:virtualagentchat/app/modules/ChatRoom/model/chat_message.dart';

import '../modules/HomePage/model/chat_session.dart';

class HiveService {
  static const String _boxName = 'chatsessions';
  late Box _box;

  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  Future<void> init() async {
    if (!Hive.isBoxOpen(_boxName)) {
      _box = await Hive.openBox(_boxName);
    } else {
      _box = Hive.box(_boxName);
    }
  }

  Future<ChatSession> createNewSession(String sessionId) async {
    final newSession = ChatSession(
        id: sessionId,
        createdAt: DateTime.now().toIso8601String(),
        messages: []);

    await _box.put(sessionId, newSession);
    return newSession;
  }

  void updateSession(String sessionId, List<ChatMessage> messages) async {
    if (!_box.containsKey(sessionId)) {
      final newSession = ChatSession(
          id: sessionId,
          createdAt: DateTime.now().toIso8601String(),
          messages: messages);

      await _box.put(sessionId, newSession);
    }
  }

  Future<List<ChatSession>> getAllSessions() async {
    final allKeys = _box.keys.toList();

    List<ChatSession> sessions = [];
    for (var key in allKeys) {
      final sessionData = _box.get(key);

      if (sessionData != null) {
        sessions.add(sessionData);
      }
    }

    return sessions;
  }

  Future<void> updateSessionMessages(
      String sessionId, List<ChatMessage> newMessage) async {
    if (_box.containsKey(sessionId)) {
      final sessionData = _box.get(sessionId);

      ChatSession session = sessionData;

      session.messages.clear();
      session.messages.addAll(newMessage);

      sessionData['messages'] =
          session.messages.map((msg) => msg.toJson()).toList();

      await _box.put(sessionId, sessionData);
    }
  }

  Future<void> deleteSession(String sessionId) async {
    await _box.delete(sessionId);
  }

  Future<void> clearAllSessions() async {
    await _box.clear();
  }
}
