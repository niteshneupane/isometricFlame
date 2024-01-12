import 'dart:async';

import 'package:flame/components.dart';
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
    sprite = Sprite(
      image,
      srcPosition: Vector2.zero(),
      srcSize: Vector2(66, 32),
    );

    debugMode = true;
  }
}
