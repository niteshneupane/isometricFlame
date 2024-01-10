import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:isometrictest/joystick.dart';

class ManPlayer extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 100.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();

  final JoyStick joystick;
  late SpriteAnimation walkingLeftAnimation;
  late SpriteAnimation walkingRightAnimation;
  late SpriteAnimation walkingUpAnimation;
  late SpriteAnimation walkingUpLeftAnimation;
  late SpriteAnimation walkingUpRightAnimation;

  late SpriteAnimation walkingDownAnimation;
  late SpriteAnimation walkingDownLeftAnimation;
  late SpriteAnimation walkingDownRightAnimation;

  late SpriteAnimation idleAnimation;

  JoystickDirection? walkingDirection;

  ManPlayer(this.joystick)
      : super(
          size: Vector2(64,120),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    // sprite = await game.loadSprite('layers/player.png');

    // For Walking
    // DL 0
    // D 1
    // DR 2
    // L 3,
    // R 4,
    // UL 5,
    // U 6 ,
    // UR 7

    final spriteSheet = SpriteSheet(
      image: await game.images.load('walking_man.png'),
      srcSize: Vector2(64,120),
    );

    walkingDownLeftAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 8);
    walkingDownAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.1, to: 8);
    walkingDownRightAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: 0.1, to: 8);
    walkingLeftAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: 0.1, to: 8);
    walkingRightAnimation =
        spriteSheet.createAnimation(row: 4, stepTime: 0.1, to: 8);
    walkingUpLeftAnimation =
        spriteSheet.createAnimation(row: 5, stepTime: 0.1, to: 8);
    walkingUpAnimation =
        spriteSheet.createAnimation(row: 6, stepTime: 0.1, to: 9);
    walkingUpRightAnimation =
        spriteSheet.createAnimation(row: 7, stepTime: 0.1, to: 9);
    idleAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: 0.8, to: 1);

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
    print("Other ${other}");

    transform.setFrom(_lastTransform);
    size.setFrom(_lastSize);
  }

  SpriteAnimation changeAnimation() {
    switch (walkingDirection) {
      case JoystickDirection.upLeft:
        return walkingUpLeftAnimation;
      case JoystickDirection.up:
        return walkingUpAnimation;

      case JoystickDirection.upRight:
        return walkingUpRightAnimation;

      case JoystickDirection.right:
        return walkingRightAnimation;

      case JoystickDirection.downRight:
        return walkingDownRightAnimation;

      case JoystickDirection.down:
        return walkingDownAnimation;

      case JoystickDirection.downLeft:
        return walkingDownLeftAnimation;

      case JoystickDirection.left:
        return walkingLeftAnimation;

      default:
        return idleAnimation;
    }
  }
}
