import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/call/controller/call_controller.dart';
import 'package:pavann27/features/chat_started/controller/chat_started_controller.dart';

class ChatStartedScreen extends StatelessWidget {
  final controller = Get.put(ChatStartedController());
  final callController = Get.find<CallController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FF),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    return _buildChatBubble(controller.messages[index]);
                  },
                )),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.back(),
      ),
      title: Row(
        children: [
          Obx(() => CircleAvatar(
                backgroundImage: callController.call.value.allyImage.startsWith('assets/')
                    ? AssetImage(callController.call.value.allyImage) as ImageProvider
                    : NetworkImage(callController.call.value.allyImage),
              )),
          const SizedBox(width: 10),
          Obx(() => Text(callController.call.value.allyName,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
          const SizedBox(width: 5),
          const Icon(Icons.verified, color: Colors.deepPurpleAccent, size: 16),
        ],
      ),
      actions: [
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.deepPurple.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Obx(() => Text(
                  callController.call.value.formattedTime,
                  style: const TextStyle(color: Colors.deepPurple),
                )),
          ),
        ),
        TextButton(
            onPressed: () => callController.endCall(),
            child: const Text("End", style: TextStyle(color: Colors.red))),
        const Icon(Icons.more_vert, color: Colors.grey),
      ],
    );
  }

  Widget _buildChatBubble(message) {
    bool isSender = message.isSender;
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(maxWidth: Get.width * 0.7),
        decoration: BoxDecoration(
          color: isSender ? const Color(0xFF6A1B9A) : Colors.white,
          borderRadius: BorderRadius.circular(15).copyWith(
            bottomRight: isSender ? Radius.zero : const Radius.circular(15),
            bottomLeft: isSender ? const Radius.circular(15) : Radius.zero,
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: isSender ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.textController,
              decoration: InputDecoration(
                hintText: "type here",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: controller.sendMessage,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF6A1B9A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}