import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import './globals.dart';

class Ground extends IsometricTileMapComponent {
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
    destTileSize = Vector2.all(kDestTileSize);
    tileHeight = tileHeight;
  }
}
