import 'package:flutter/material.dart';
import 'package:wechat_app/resources/dimension.dart';

class TweenAnimatedOpacityAnimation extends StatelessWidget {
  const TweenAnimatedOpacityAnimation(
      {Key? key,
      required this.child,
       this.begin=0.0,
       this.end=1.0,
       this.duration=kDurationInOneSecond})
      : super(key: key);
  final Widget child;
  final double begin;
  final double end;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: begin, end: end),
      duration: duration,
      builder: (context, double opacity, child) => Opacity(
        opacity: opacity,
        child: child,
      ),
      child: child,
    );
  }
}
