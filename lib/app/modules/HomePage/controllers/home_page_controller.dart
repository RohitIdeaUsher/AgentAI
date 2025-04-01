import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualagentchat/app/routes/app_pages.dart';
import 'package:virtualagentchat/app/services/hive_service.dart';
import 'package:virtualagentchat/app/services/uuid_token.dart';

import '../model/chat_session.dart';

class HomePageController extends GetxController {
  TextEditingController agentName = TextEditingController();
  RxList<ChatSession> sessionList = <ChatSession>[].obs;

  final HiveService _localService = HiveService();

  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadAllSessions();
  }

  void loadAllSessions() async {
    // sessionList.value = _hiveService.getAllSessionIds();
    sessionList.value = await _localService.getAllSessions();
  }

  // Create a new session with unique ID
  // void createNewSession() async {
  //   final newSessionId = Uuid().generateV4();
  //   await _hiveService.createSession(newSessionId);

  //   chatRoom(newSessionId);
  // }

  void createNew() async {
    final newSessionId = Uuid().generateV4();
    final newSession = await HiveService().createNewSession(newSessionId);
    sessionList.insert(0, newSession);
    // chatRoom(newSessionId);
    Get.toNamed(Routes.CHAT_ROOM, arguments: newSession);
  }

  void chatRoom(String id) => Get.toNamed(Routes.CHAT_ROOM, arguments: id);

  @override
  void onClose() {
    super.onClose();
  }
}
