import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:isometrictest/characters/farmer.dart';
import 'package:isometrictest/components/land_component.dart';
import 'package:isometrictest/components/unwalkable_component.dart';
import 'package:isometrictest/farm_game.dart';
import 'package:isometrictest/utils/globals.dart';
import 'package:isometrictest/utils/utils.dart';

import 'controls/joystick.dart';

class FarmWorld extends World with HasGameRef<FarmGame> {
  FarmWorld({super.children});

  late Vector2 size;
  // final unwalkableComponentEdges = <Line>[];
  late final Farmer farmer;
  final Random rnd = Random();

  late TiledComponent map;

  @override
  Future<void> onLoad() async {
    map = await TiledComponent.load(
      "level.tmx",
      Vector2(tileSizeX * worldScale, tileSizeY * worldScale),
    );
    size = Vector2(
      map.tileMap.map.width * worldTileSizeX,
      map.tileMap.map.height * worldTileSizeY,
    );

    add(map);

    final objectLayer = map.tileMap.getLayer<ObjectGroup>('wall')!;
    for (final TiledObject object in objectLayer.objects) {
      if (!object.isPolygon) continue;
      // if (!object.properties.byName.containsKey('blocksMovement')) return;
      final vertices = <Vector2>[];

      for (final point in object.polygon) {
        // var objectIso = Point(x: object.x, y: object.y).isoPoints;
        Vector2 nextPoint = Vector2((point.x + object.x) * worldScale,
                (point.y + object.y) * worldScale)
            .isoPoint(offset: Vector2(size.x * 0.625, 0));
        vertices.add(nextPoint);
      }

      if (object.name == "land") {
        add(
          LandComponents(
            vertices,
            landId: object.id,
          ),
        );
      } else {
        add(UnwalkableComponent(vertices));
      }
    }

    final joyStick = JoyStick();
    farmer = Farmer(
      joyStick,
      position: size * 0.5,
    );

    add(farmer);

    // Set up Camera
    gameRef.cameraComponent.follow(farmer);

    // Set Up JoyStick
    gameRef.cameraComponent.viewport.add(joyStick);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    setCameraBounds(size);
  }

  void setCameraBounds(Vector2 gameSize) {
    gameRef.cameraComponent.setBounds(
      Rectangle.fromLTRB(
        gameSize.x / 2,
        gameSize.y / 2,
        size.x - gameSize.x / 2,
        size.y - gameSize.y / 2,
      ),
    );
  }
}
