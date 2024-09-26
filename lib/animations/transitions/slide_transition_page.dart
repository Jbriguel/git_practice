import 'package:flutter/widgets.dart';

import 'TransitionPage.dart'; 

class SlideTransitionPage extends TransitionPage {
  final Offset offset;

  const SlideTransitionPage({
    required super.screen,
    required ValueKey<String> super.transitionKey,
    this.offset = const Offset(1, 0),
  });

  @override
  Route createRoute(BuildContext context) => PageRouteBuilder<TransitionPage>(
        settings: this,
        pageBuilder: (
          context,
          animation,
          secondaryAnimation,
        ) =>
            screen,
        transitionsBuilder: (
          context,
          animation,
          secondaryAnimation,
          child,
        ) {
          Offset transitionOffset = offset;
          const offsetBase = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: transitionOffset, end: offsetBase)
              .chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      );
}