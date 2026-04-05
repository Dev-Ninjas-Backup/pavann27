import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pavann27/features/chat_started/model/chat_started_model.dart';

class ChatStartedController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  // Observable list of messages
  var messages = <ChatMessage>[
    ChatMessage(text: "Hi there. How are you?", isSender: true, timestamp: DateTime.now()),
    ChatMessage(text: "Hi, I'm glad you reached out. I'm fine.", isSender: false, timestamp: DateTime.now()),
    ChatMessage(text: "How are you feeling today?", isSender: false, timestamp: DateTime.now()),
    ChatMessage(text: "Fine. Can we talk?", isSender: true, timestamp: DateTime.now()),
    ChatMessage(text: "I understand. It takes courage to talk about these things.", isSender: false, timestamp: DateTime.now()),
  ].obs;

  void sendMessage() {
    if (textController.text.trim().isNotEmpty) {
      messages.add(ChatMessage(
        text: textController.text.trim(),
        isSender: true,
        timestamp: DateTime.now(),
      ));
      textController.clear();
      scrollToBottom();
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }
}