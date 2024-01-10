import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import './globals.dart';

class Ground extends IsometricTileMapComponent with CollisionCallbacks {
  Ground(
    super.tileset,
    super.matrix, {
    required Vector2 position,
  }) : super(
          position: position,
        );

        late RectangleHitbox hitbox;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    print(size);

    destTileSize = Vector2.all(kDestTileSize);
    tileHeight = tileHeight;

    final defaultPaint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill;
    hitbox = RectangleHitbox()
      ..paint = defaultPaint
      ..renderShape = true;
    
    add(hitbox);
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    // TODO: implement onCollision
    super.onCollision(intersectionPoints, other);
    print("Collideeeee");
  }
}
