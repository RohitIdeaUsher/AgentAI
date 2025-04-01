import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualagentchat/app/modules/ChatRoom/model/chat_message.dart';
import 'package:virtualagentchat/app/modules/HomePage/model/chat_session.dart';
import 'package:virtualagentchat/app/services/gemini_aiservice.dart';

class ChatRoomController extends GetxController {
  TextEditingController messageText = TextEditingController();
  // RxList<ChatModel> messagesList = <ChatModel>[].obs;
  RxList<ChatMessage> messagesList = <ChatMessage>[].obs;
  ChatSession? argument;

  String userId = "";

  RxString typing = "".obs;
  RxBool disableInputOption = false.obs;

  String currentSessionId = '';
  @override
  void onInit() {
    super.onInit();
    // currentSessionId = Get.arguments;
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
    // print("3a02416d-b8db-4a6c-b3e0-31e1a192b387");
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

  // void updateLastmessage() async {
  //   if (messagesList.isNotEmpty) {
  //     Get.find<HomePageController>().refresh();
  //   }
  // }

  @override
  void onClose() {
    // updateLastmessage();
    super.onClose();
  }
}
