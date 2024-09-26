import 'package:flutter/material.dart';

class Message {
  final messageType type;
  final String titre;
  final String content;

  Message(this.type, this.titre, this.content);
}

enum eventStyle { snack, popup }
enum messageType { error, success, info, warning }

class MessageEvent implements Exception {
  final Message message;
  final eventStyle style;
  Function()? onBtnPressed;
  String? btnActionTexte;
  final bool canceled;
  BuildContext? context;

  MessageEvent(this.message,
      {this.style = eventStyle.snack,
      this.btnActionTexte,
      this.onBtnPressed,
      this.canceled = false,
      this.context});

  show() {
    throw this;
  }
}
