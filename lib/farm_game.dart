import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:isometrictest/farm_world.dart';

//  <image source="assets/images/tile_maps/tile_large.png" width="64" height="64"/>
//  <image source="../images/tile_maps/tile_large.png" width="64" height="64"/>

class FarmGame extends FlameGame
    with
        HasKeyboardHandlerComponents,
        HasCollisionDetection,
        RiverpodGameMixin {
  FarmGame() : world = FarmWorld() {
    cameraComponent = CameraComponent(world: world);
    images.prefix = '';
  }

  late final CameraComponent cameraComponent;
  @override
  final FarmWorld world;

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      "assets/images/walking_man.png",
      "assets/images/crops.png",
      // "assets/images/backdrop.png",
    ]);
    // cameraComponent.backdrop.add(
    //   SpriteComponent.fromImage(
    //     images.fromCache("assets/images/backdrop.png"),
    //   ),
    // );
    addAll([cameraComponent, world]);
    // debugMode = true;
  }
}
