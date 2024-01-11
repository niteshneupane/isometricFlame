import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:isometrictest/utils/utils.dart';
import '../utils/globals.dart';

class BrickWall extends IsometricTileMapComponent with CollisionCallbacks {
  BrickWall(
    super.tileset,
    super.matrix, {
    required Vector2? position,
  }) : super(
          position: position,
        );

  @override
  Future<FutureOr<void>> onLoad() async {
    super.onLoad();
    // size = Vector2.all(kDestTileSize);
    destTileSize = Vector2.all(kDestTileSize);
    tileHeight = kScale * kLargeTileHeight;
    add(
      RectangleHitbox(
        isSolid: true,
        size: Vector2(200, 10),
        position: Vector2(
          32,
          14,
        ),
        angle: -(26.5).toRadian,
        anchor: Anchor.bottomRight,
      ),
    );
    debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    print("Collidedd $other");
  }
}
