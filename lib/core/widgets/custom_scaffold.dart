import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final bool slidingPopScreen;
  final Color? backgroundColor;
  final VoidCallback? onHorizontalDragUpdate;
  final Future<bool> Function()? onWillPop;
  const CustomScaffold({
    super.key,
    this.body,
    this.appBar,
    this.slidingPopScreen = true,
    this.backgroundColor,
    this.onHorizontalDragUpdate,
    this.onWillPop,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx < -20 && slidingPopScreen) {
            if (onHorizontalDragUpdate == null) {
              context.pop();
            } else {
              onHorizontalDragUpdate!.call();
            }
          }
        },
        child: body,
      ),
    );
  }
}
