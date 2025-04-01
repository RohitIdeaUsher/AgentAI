import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualagentchat/app/modules/ChatRoom/model/chat_message.dart';
import 'package:virtualagentchat/app/modules/HomePage/model/chat_session.dart';
import 'package:virtualagentchat/app/services/gemini_aiservice.dart';
import 'package:virtualagentchat/app/services/hive_service.dart';

class ChatRoomController extends GetxController {
  TextEditingController messageText = TextEditingController();
  RxList<ChatMessage> messagesList = <ChatMessage>[].obs;
  ChatSession? argument;
  RxString typing = "".obs;
  RxBool disableInputOption = false.obs;

  @override
  void onInit() {
    super.onInit();

    argument = Get.arguments;
  }

  @override
  void onReady() {
    super.onReady();
    _loadSession();
  }

  void _loadSession() {
    try {
      messagesList.value = argument?.messages ?? [];
    } catch (e) {
      log(e.toString());
    }
  }

  void sendMessage(String message) {
    typing.value = "";
    messagesList.insert(
        0,
        ChatMessage(
            message: message,
            timeStamp: DateTime.now().toIso8601String(),
            role: "user"));

    messagesList.insert(0,
        ChatMessage(role: "bot", message: "", timeStamp: "", isloading: true));
    sendMessagetoAI(message);
  }

  Future<void> sendMessagetoAI(String query) async {
    disableInputOption.value = true;
    try {
      String result = await GeminiService.generateResponse(query);
      result = result.trim();
      if (result.isNotEmpty) {
        messagesList.removeAt(0);
        messagesList.insert(
            0,
            ChatMessage(
                role: "bot",
                timeStamp: DateTime.now().toIso8601String(),
                message: result));
        disableInputOption.value = false;
        // storeSession();
      }
    } catch (e) {
      disableInputOption.value = false;
      messagesList.removeAt(0);
      log(e.toString());
    }
  }

  void updateLastmessage() async {
    if (messagesList.isNotEmpty) {
      HiveService().updateSessionMessages(argument?.id ?? "", messagesList);
    }
  }

  @override
  void onClose() {
    updateLastmessage();
    super.onClose();
  }
}
