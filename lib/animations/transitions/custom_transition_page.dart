// ignore_for_file: always_specify_types

import "package:flutter/widgets.dart";

class CustomTransitionPage extends Page {
  final Widget screen;
  final ValueKey<String> transitionKey;

  const CustomTransitionPage({
    required this.screen,
    required this.transitionKey,
  }) : super(
          key: transitionKey,
        );

  @override
  Route<dynamic> createRoute(
    BuildContext context,
  ) =>
      PageRouteBuilder<dynamic>(
          settings: this,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              screen);
}