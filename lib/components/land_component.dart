import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:isometrictest/components/crops/tomato.dart';
import 'package:isometrictest/farm_game.dart';
import 'package:isometrictest/provider/land_provider.dart';

enum SeedType {
  tomato;
}

class LandComponents extends PolygonComponent
    with HasGameReference<FarmGame>, RiverpodComponentMixin {
  LandComponents(
    super._vertices, {
    required int landId,
  })  : v = _vertices,
        id = landId;
  final List<Vector2> v;
  final int id;
  bool isSelected = false;

  late Tomato tomato;

  @override
  void onMount() {
    addToGameWidgetBuild(() {
      ref.listen(selectedLandProvider, (previous, value) {
        isSelected = (value == id);
        if (isSelected) {
          paint = Paint()..color = Colors.green;
        } else {
          paint = Paint()..color = Colors.transparent;
        }
      });
    });
    super.onMount();
  }

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    paint = Paint()..color = Colors.transparent;

    final hitbox = PolygonHitbox(
      v,
      position: Vector2.zero(),
      collisionType: CollisionType.passive,
      isSolid: true,
    );
    add(hitbox);

    final tomato = Tomato(
      position: Vector2.zero(),
      show: id == 15,
    );
    add(tomato);

    // debugMode = true;
  }
}
