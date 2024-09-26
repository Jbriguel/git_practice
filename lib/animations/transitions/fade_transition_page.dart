import 'package:flutter/material.dart';

import 'TransitionPage.dart'; 

class FadeTransitionPage extends TransitionPage {
  const FadeTransitionPage(
      {required super.screen, required super.transitionKey});

  @override
  Route createRoute(BuildContext context) => PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
}