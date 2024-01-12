import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class UnwalkableComponent extends PolygonComponent with CollisionCallbacks {
  UnwalkableComponent(super._vertices) : v = _vertices;
  final List<Vector2> v;
  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    paint = Paint()..color = Colors.transparent;

    final hitbok = PolygonHitbox(
      v,
      position: Vector2.zero(),
    );

    add(hitbok);
  }
}
