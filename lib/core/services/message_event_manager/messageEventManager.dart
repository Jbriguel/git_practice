import 'package:atelier_so/widgets/custom/eventWidgets/message_popUp.dart';
import 'package:flutter/material.dart';

import '../../modeles/message_event/message_event.dart';

class ErrorMessageManager implements Exception {
  static void showMessage(
      MessageEvent event, StackTrace stackTrace, BuildContext context) {
    switch (event.style) {
      case eventStyle.snack:
        showSnack(event.message, context);
        break;
      case eventStyle.popup:
        showPopup(event, context);
        break;
      default:
        showSnack(event.message, context);
    }
  }

  static void showPopup(MessageEvent event, BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => ShowMessagePopUp(
            message: event.message.content,
            titre: event.message.titre,
            typeMessage: event.message.type,
            btnText: event.btnActionTexte ?? "Fermer",
            showBackBtn: event.canceled,
            btnClickaction: event.onBtnPressed ?? () {}));
  }

  static void showSnack(Message message, BuildContext context) {
    // Affichez le message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.content,
          textAlign: TextAlign.start,
          style: const TextStyle(
              fontFamily: "Speedee", fontSize: 12, color: Colors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 1.0,
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        dismissDirection: DismissDirection.horizontal,
        backgroundColor: getColor(message.type),
      ),
    );
  }

  static getColor(messageType type) {
    switch (type) {
      case messageType.error:
        return Colors.grey.shade700;
      case messageType.warning:
        return Colors.orange.shade400;
      case messageType.info:
        return Colors.blue.shade400;
      case messageType.success:
        return Colors.green.shade400;
      default:
        return Colors.grey.shade400;
    }
  }
}
