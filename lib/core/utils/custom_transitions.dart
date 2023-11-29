import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeftToRightTransition extends CustomTransitionPage {
  LeftToRightTransition({
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 1500),
          reverseTransitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return Align(
              alignment: Alignment.centerLeft,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            );
          },
        );
}

class CenterTransition extends CustomTransitionPage {
  CenterTransition({
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return Align(
              alignment: Alignment.center,
              child: SizeTransition(
                axis: Axis.horizontal,
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            );
          },
        );
}

class BottomToTopTransition extends CustomTransitionPage {
  BottomToTopTransition({
    required super.child,
  }) : super(
          transitionDuration: const Duration(milliseconds: 1700),
          reverseTransitionDuration: const Duration(milliseconds: 700),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
              curve: Curves.fastLinearToSlowEaseIn,
              parent: animation,
              reverseCurve: Curves.fastOutSlowIn,
            );
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                axisAlignment: 0,
                child: child,
              ),
            );
          },
        );
}
