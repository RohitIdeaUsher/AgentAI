import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/chat_room_controller.dart';
import '../model/chat_message.dart';

class ChatRoomView extends GetView<ChatRoomController> {
  const ChatRoomView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).chipTheme.surfaceTintColor,
      // floatingActionButton:
      //     FloatingActionButton(onPressed: () => Get.to(const VoiceToText())),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
            onPressed: Get.back,
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white)),
        centerTitle: true,
        title: Text(
          "CRANEL AI",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
      body: chatWidget(context),
    );
  }

  Widget chatWidget(BuildContext context) {
    return
        // controller.model != null
        //     ?
        Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Obx(() {
          if (controller.messagesList.isEmpty) {
            return Text("Ask your query.",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge); //UtilWidgets.noDataFound(title: "Messages");
          }
          return Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: controller.messagesList.length,
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              itemBuilder: (context, index) {
                ChatMessage model = controller.messagesList[index];

                return messageTile(context, model);
              },
            ),
          );
        }),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
              color: Theme.of(context).chipTheme.checkmarkColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24.h),
                  topRight: Radius.circular(24.h))),
          padding: const EdgeInsets.all(8.0),
          child: inputOptions(context),
        ),
      ],
    );
    // : UtilWidgets.noDataFound(title: "No Conversation Found.");
  }

  Obx inputOptions(BuildContext context) {
    return Obx(
      () => controller.disableInputOption.value
          ? Center(
              child: Text("Generating response....",
                  style: Theme.of(context).textTheme.bodyLarge),
            )
          : Row(
              children: [
                Expanded(
                  child: TextFormField(
                      controller: controller.messageText,
                      style: Theme.of(context).textTheme.titleSmall,
                      decoration: InputDecoration(
                        labelStyle:
                            Theme.of(context).inputDecorationTheme.labelStyle,
                        fillColor:
                            Theme.of(context).inputDecorationTheme.fillColor,
                        floatingLabelStyle: Theme.of(context)
                            .inputDecorationTheme
                            .floatingLabelStyle,
                        filled: true,
                        isDense: true,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30.h)),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30.h)),
                        ),
                        hintText: "Message",
                        // hintStyle:
                        //     Theme.of(context).inputDecorationTheme.hintStyle,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        border: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(30.h)),
                        ),
                      )),
                ),
                SizedBox(width: 8.w),
                GestureDetector(
                  onTap: () {
                    String message = controller.messageText.text.trim();
                    controller.messageText.clear();
                    if (message.isNotEmpty) {
                      controller.sendMessage(message);
                    }
                  },
                  child: CircleAvatar(
                    radius: 20.h,
                    backgroundColor: Colors.blueGrey,
                    child: Icon(
                      Icons.send_outlined,
                      size: 22.h,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  ListTile messageTile(BuildContext context, ChatMessage model) {
    bool sendByMe = model.role == "user";

    return ListTile(
      contentPadding: EdgeInsets.zero,
      dense: true,
      title: Align(
        alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
            constraints: model.isloading
                ? BoxConstraints(maxWidth: 65.w)
                : BoxConstraints(maxWidth: 275.w),
            padding: model.isloading
                ? EdgeInsets.all(4.w)
                : EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
            decoration: sendByMe
                ? BoxDecoration(
                    color: Colors.grey,
                    // gradient: AppColor.indicator,
                    borderRadius: BorderRadius.circular(20),
                  )
                : model.isloading
                    ? null
                    : BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(20),
                      ),
            child: model.isloading
                ? progressIndicator() //Lottie.asset(AppImages.AILOADER3, height: 40.h, width: 40.h)
                : messageType(context, model.message, sendByMe: sendByMe)),
      ),
    );
  }

  Widget progressIndicator() {
    return LottieBuilder.asset(
      "assets/animations/ailoader5.json",
    );
  }

  Widget messageType(BuildContext context, String message,
      {bool sendByMe = false}) {
    return Text(
      message,
      style: TextStyle(fontSize: 14, color: Colors.white),
    );
  }
}
