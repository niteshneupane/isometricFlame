import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/globals.dart';
import 'package:isometrictest/ground.dart';
import 'package:isometrictest/inviz_wall.dart';
import 'package:isometrictest/joystick.dart';
import 'package:isometrictest/man_player.dart';

class IsometricTileMap extends FlameGame with HasCollisionDetection {
  static const scale = 2.0;
  static const srcTileSize = 32.0;
  static const destTileSize = scale * srcTileSize;
  static const tileHeight = scale * (8.0);

  late Vector2 topLeft;
  late IsometricTileMapComponent base;
  @override
  Future<void> onLoad() async {
    // For Tile
    final tilesetImage = await images.load('tile_maps/tiles.png');
    final tileset = SpriteSheet(
      image: tilesetImage,
      srcSize: Vector2.all(srcTileSize),
    );

    final wallImage = await images.load('tile_maps/wall.png');
    final wallSet = SpriteSheet(
      image: wallImage,
      srcSize: Vector2.all(srcTileSize),
    );

    final walls = IsometricTileMapComponent(
      wallSet,
      matrix,
      destTileSize: Vector2.all(kDestTileSize),
      tileHeight: tileHeight,
      // position: Vector2(size.x * 0.5, -size.y * 0.5),
      position: Vector2(size.x * 0.6, size.y * 0.5),
    );
    world.add(walls);

    final ground = Ground(
      tileset,
      matrix,
      position: Vector2(size.x * 0.5, -size.y * 0.5),
    );
    world.add(ground);
    final joyStick = JoyStick();

    final wallPosition = Vector2(71, 177);
    print("${size / 2}");
    final wall = InvizWall(wallPosition);
    world.add(wall);

    final player = ManPlayer(joyStick);
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
