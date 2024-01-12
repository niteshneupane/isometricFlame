import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/components/crop_component.dart';
import 'package:isometrictest/farm_game.dart';

class Tomato extends CropComponent with HasGameReference<FarmGame> {
  Tomato({
    Vector2? position,
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
      srcSize: Vector2(66, 35),
      margin: 18,
      spacing: 14,
    );

    sprite = spriteSheet.getSprite(0, 2);
    position = Vector2(-6, 8);

    // debugMode = true;
  }
}
