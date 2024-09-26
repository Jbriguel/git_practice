import 'package:flutter/material.dart';

void showSnack(String message, String typeMessage, BuildContext context) {
  // Affichez le message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontFamily: 'Speedee',
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 1.0,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      dismissDirection: DismissDirection.horizontal,
      backgroundColor: getColor(typeMessage),
    ),
  );
}

Color getColor(String typeMessage) {
  switch (typeMessage) {
    case 'erreur':
      return Colors.grey.shade700; //red.shade400.withOpacity(0.7);
    case 'info':
      return Colors.blue.shade400;
    case 'alert':
      return Colors.orange.shade400;
    case 'success':
      return Colors.green.shade400;
    default:
      return Colors.grey.shade700;
  }
}
