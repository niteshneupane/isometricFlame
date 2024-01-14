
import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:isometrictest/utils/globals.dart';
import 'package:isometrictest/utils/utils.dart';

class CropComponent extends SpriteComponent {
  final bool _show;

  CropComponent({
    Sprite? sprite,
    Vector2? position,
    bool? show,
  })  : _show = show ?? true,
        super(
          sprite: sprite,
          size: Vector2(32, 81 * 0.5) * worldScale,
          position: Vector2(worldTileSizeX * 0.5, worldTileSizeY).isoPoint(),
          anchor: Anchor.bottomLeft,
        );

  @override
  void render(Canvas canvas) {
    if (!_show) {
      return;
    }
    super.render(canvas);
  }
}
