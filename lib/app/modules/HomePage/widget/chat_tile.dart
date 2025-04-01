import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:virtualagentchat/app/modules/HomePage/model/chat_session.dart';
import 'package:virtualagentchat/app/routes/app_pages.dart';
import 'package:virtualagentchat/app/services/datetime_callbacks.dart';

class ChatTile extends StatelessWidget {
  const ChatTile({
    super.key,
    required this.model,
  });
  final ChatSession model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CHAT_ROOM, arguments: model);
      },
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(
              model.id,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              model.messages.firstOrNull?.message ??
                  "Tap to start conversation",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
              ),
            ),
            trailing: Text(DatetimeCallback.formatDateTime(
                DateTime.parse(model.createdAt))),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
