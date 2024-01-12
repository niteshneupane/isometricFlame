import 'package:flame/components.dart';
import 'package:flame/image_composition.dart';
import 'package:isometrictest/utils/globals.dart';

class CropComponent extends SpriteComponent {
  final bool _show;

  CropComponent({
    Sprite? sprite,
    Vector2? position,
    bool? show,
  })  : _show = show ?? true,
        super(
          sprite: sprite,
          size: Vector2(worldTileSizeX, worldTileSizeY),
          position: position,
        );

  @override
  void render(Canvas canvas) {
    if (!_show) {
      return;
    }
    super.render(canvas);
  }
}
