import 'package:flutter/material.dart';
import 'TransitionPage.dart';

class ScaleTransitionPage extends TransitionPage {
  const ScaleTransitionPage(
      {required super.screen, required super.transitionKey});

  @override
  Route createRoute(BuildContext context) => PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const curve = Curves.easeInOut;

          return ScaleTransition(
            alignment: Alignment.bottomCenter,
            scale: CurvedAnimation(
              parent: animation,
              curve: const Interval(0.00, 0.50, curve: curve),
            ),
            child: child,
          );
        },
      );
}