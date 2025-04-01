import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/home_page_controller.dart';
import '../widget/chat_tile.dart';

class HomePageView extends GetView<HomePageController> {
  const HomePageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CRANEL AI',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      floatingActionButton: GestureDetector(
        onTap: controller.createNewSession,
        child: LottieBuilder.asset(
          "assets/animations/ailoader5.json",
          height: 80.h,
          width: 80.h,
        ),
      ),
      body: Obx(() => controller.sessionList.isNotEmpty
          ? ListView.builder(
              itemCount: controller.sessionList.length,
              itemBuilder: (_, index) {
                return ChatTile(model: controller.sessionList[index]);
              })
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_note_rounded,
                    color: Colors.grey,
                    size: 150.h,
                  ),
                  Text("No conversation yet.",
                      style: TextStyle(fontSize: 16.sp))
                ],
              ),
            )),
    );
  }
}
