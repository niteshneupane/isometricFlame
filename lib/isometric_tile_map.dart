import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/globals.dart';
import 'package:isometrictest/joystick.dart';
import 'package:isometrictest/macho_player.dart';

class IsometricTileMap extends FlameGame with MouseMovementDetector {
  static const scale = 2.0;
  static const srcTileSize = 32.0;
  static const destTileSize = scale * srcTileSize;
  static const tileHeight = scale * (8.0);

  late Vector2 topLeft;
  late IsometricTileMapComponent base;
  @override
  Future<void> onLoad() async {
    // For Tile
    topLeft = Vector2(size.x * 0.5, -size.y * 0.5);
    final tilesetImage = await images.load('tile_maps/tiles.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );

    world.add(
      base = IsometricTileMapComponent(
        tileset,
        matrix,
        destTileSize: Vector2.all(destTileSize),
        tileHeight: tileHeight,
        position: topLeft,
      ),
    );

    final joyStick = JoyStick();

    final player = MachoPlayer(joyStick);
    world.add(player);
    camera.follow(player);
    camera.viewport.add(joyStick);
  }
}

// class Player extends SpriteComponent {
//   bool show = true;

//   Player(double s, Image image)
//       : super(
//           sprite: Sprite(image, srcSize: Vector2.all(32.0)),
//           size: Vector2.all(s),
//         );

//   @override
//   void render(Canvas canvas) {
//     if (!show) {
//       return;
//     }

//     super.render(canvas);
//   }
// }
