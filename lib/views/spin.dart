import 'package:flutter/material.dart';
import 'dart:math' as math;

class Spin extends StatefulWidget {
  Widget child;
  Spin({this.child, Key key}) : super(key: key);

  @override
  _SpinState createState() => _SpinState();
}

// 仅在当前tree触发时更新/触发的ticker?
class _SpinState extends State<Spin> with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Transform.rotate(
            angle: _controller.value * 2 * math.pi, child: child);
      },
    );
  }
}
