import 'package:flutter/material.dart';

class TransitionPage extends Page {
  final Widget screen;

  final ValueKey transitionKey;

  const TransitionPage({
    required this.screen,
    required this.transitionKey,
  }) : super(key: transitionKey);

  @override
  Route createRoute(BuildContext context) {
    throw UnimplementedError();
  }
}