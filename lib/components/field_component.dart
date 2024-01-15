import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../farm_game.dart';
import '../utils/globals.dart';

class FieldComponent extends SpriteComponent
    with HasGameReference<FarmGame>, DragCallbacks {
  FieldComponent({super.size, super.position});

  final _paint = Paint();
  bool _isDragged = false;

  @override
  FutureOr<void> onLoad() {
    final image = game.images.fromCache(
      "assets/images/tile_maps/tile_large.png",
    );
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(tileSizeX, tileSizeY),
    );
    size = Vector2(worldTileSizeX, worldTileSizeY);

    // position = game.size * 0.4;
    sprite = spriteSheet.getSprite(0, 1);
    return super.onLoad();
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) => position += event.localDelta;

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _paint.color =
        _isDragged ? Colors.red.withOpacity(0.1) : Colors.transparent;
    canvas.drawRect(size.toRect(), _paint);
  }
}
