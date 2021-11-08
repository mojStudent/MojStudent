import 'package:flutter/material.dart';

class PageScaleTransition extends PageRouteBuilder {
  final Widget page;

  PageScaleTransition(this.page)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => page,
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  parent: animation,
                  reverseCurve: Curves.fastOutSlowIn);
              return ScaleTransition(
                alignment: Alignment.center,
                scale: animation,
                child: child,
              );
            });
}
