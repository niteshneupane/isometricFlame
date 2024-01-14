import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/components/crop_component.dart';
import 'package:isometrictest/farm_game.dart';

class Tomato extends CropComponent with HasGameReference<FarmGame> {
  Tomato({
    super. position,
    super.show,
  });

  @override
  FutureOr<void> onLoad() {
    super.onLoad();
    final image = game.images.fromCache(
      "assets/images/crops.png",
    );
    final spriteSheet = SpriteSheet(
      image: image,
      srcSize: Vector2(64, 81),
      
    );

    sprite = spriteSheet.getSprite(6, 2);
    // size = Vector2(64*4, 81*4);
    // position = Vector2.zero();
    // position = Vector2(-6, 8);

    // debugMode = true;
  }
}
