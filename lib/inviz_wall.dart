import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class InvizWall extends PositionComponent with CollisionCallbacks {
  InvizWall(
    Vector2 position,
  ) : super(
          position: position,
          size: Vector2(50, 50),
        );

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    add(RectangleHitbox());
    debugMode = true;
    debugColor = Colors.red;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    print("Collidedd $other");
  }
}
