import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/controls/joystick.dart';

class MachoPlayer extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 100.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();

  final JoyStick joystick;
  late SpriteAnimation walkingLeftAnimation;
  late SpriteAnimation walkingRightAnimation;
  late SpriteAnimation walkingUpAnimation;
  late SpriteAnimation walkingDownAnimation;
  late SpriteAnimation idleAnimation;

  JoystickDirection? walkingDirection;

  MachoPlayer(this.joystick)
      : super(
          size: Vector2.all(64),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // sprite = await game.loadSprite('layers/player.png');

    // For Walking
    // Up 8
    // left 9
    // Down 10
    // right 11

    final spriteSheet = SpriteSheet(
      image: await game.images.load('macho_pig.png'),
      srcSize: Vector2.all(64),
    );

    walkingUpAnimation =
        spriteSheet.createAnimation(row: 8, stepTime: 0.1, to: 9);
    walkingLeftAnimation =
        spriteSheet.createAnimation(row: 9, stepTime: 0.1, to: 9);
    walkingDownAnimation =
        spriteSheet.createAnimation(row: 10, stepTime: 0.1, to: 9);
    walkingRightAnimation =
        spriteSheet.createAnimation(row: 11, stepTime: 0.1, to: 9);
    idleAnimation =
        spriteSheet.createAnimation(row: 14, stepTime: 0.8, from: 1, to: 3);

    animation = idleAnimation;
    position = Vector2(size.x * 0.6, size.y * 0.5);

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
      _lastSize.setFrom(size);
      _lastTransform.setFrom(transform);
      walkingDirection = joystick.direction;
      position.add(joystick.relativeDelta * maxSpeed * dt);
    } else {
      walkingDirection = null;
    }
    animation = changeAnimation();
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    transform.setFrom(_lastTransform);
    size.setFrom(_lastSize);
  }

  SpriteAnimation changeAnimation() {
    switch (walkingDirection) {
      case JoystickDirection.upLeft:
        return walkingLeftAnimation;
      case JoystickDirection.up:
        return walkingUpAnimation;

      case JoystickDirection.upRight:
        return walkingRightAnimation;

      case JoystickDirection.right:
        return walkingRightAnimation;

      case JoystickDirection.downRight:
        return walkingRightAnimation;

      case JoystickDirection.down:
        return walkingDownAnimation;

      case JoystickDirection.downLeft:
        return walkingLeftAnimation;

      case JoystickDirection.left:
        return walkingLeftAnimation;

      default:
        return idleAnimation;
    }
  }
}
