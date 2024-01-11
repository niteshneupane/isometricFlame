import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class InvizHitbox extends PositionComponent {
//  final  Vector2 size;

  InvizHitbox({
    required Vector2 size,
    required Vector2 position,
  }) : super(
          size: size,
          position: position,
        );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(RectangleHitbox(
      size: size,
      position: position,
    ));
    debugMode = true;
    debugColor = Colors.black;
  }
}
