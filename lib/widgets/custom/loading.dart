// ignore_for_file: deprecated_member_use

import 'package:atelier_so/core/theme/theme_images.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class LoadingDialog extends StatefulWidget {
  static void show(BuildContext context, {Key? key, String? title}) =>
      showDialog<void>(
        context: context,
        useRootNavigator: true,
        barrierDismissible: true,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: SizedBox.square(
          dimension: 60,
          child: Image.asset(
            Images.loading,
            fit: BoxFit.contain,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (_controller.isAnimating) {
                return child;
              } else {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _controller.forward(from: 0);
                  },
                  child: child,
                );
              }
            },
            semanticLabel: 'GIF',
          ),
        ),
      ),
    );
  }
}
