import 'package:flame/components.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:isometrictest/buildings/inviz_hitbox.dart';
import 'package:isometrictest/controls/joystick.dart';
import 'package:isometrictest/characters/man_player.dart';

class IsometricTileMap extends FlameGame with HasCollisionDetection {
  late Vector2 topLeft;
  late IsometricTileMapComponent base;

  IsometricTileMap() : super();
  @override
  Future<void> onLoad() async {
    camera.viewfinder..zoom = 3;

    camera.setBounds(Rectangle.fromLTWH(250, 150, size.x-250, size.y-150));

    final mapComponent = await TiledComponent.load(
      "level.tmx",
      Vector2(32, 16),
      useAtlas: true,
    );
    world.add(mapComponent);


    final joyStick = JoyStick();
    final player = ManPlayer(joyStick);
    world.add(player);
    final objectGroup = mapComponent.tileMap.getLayer<ObjectGroup>('wall');

    for (final object in objectGroup!.objects) {
      world.add(
        InvizHitbox(
          size: Vector2.all(32),
          position: Vector2(object.x, object.y),
        ),
      );
    }

    camera.follow(player);
    camera.viewport.add(joyStick);

    debugMode = true;
  }
}
