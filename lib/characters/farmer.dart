import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:isometrictest/components/land_component.dart';
import 'package:isometrictest/components/unwalkable_component.dart';
import 'package:isometrictest/controls/joystick.dart';
import 'package:isometrictest/farm_game.dart';
import 'package:isometrictest/provider/land_provider.dart';

class Farmer extends SpriteAnimationComponent
    with
        HasGameReference<FarmGame>,
        CollisionCallbacks,
        RiverpodComponentMixin {
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

  // late TextComponent landIdTextComponent;

  int? currentSelectedLand;

  Farmer(
    this.joystick, {
    required Vector2 position,
  }) : super(
          size: Vector2(64, 120) * 0.9,
          anchor: Anchor.bottomCenter,
          position: position,
        );

  bool get dontWalk {
    if (activeCollisions.isEmpty) {
      if (currentSelectedLand!=null) {
        // landIdTextComponent.text = "";
        // currentSelectedLand = null;
        ref.invalidate(selectedLandProvider);
      }
      return false;
    }
    for (var element in activeCollisions) {
      return element is UnwalkableComponent;
    }
    return false;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final spriteSheet = SpriteSheet(
      image: game.images.fromCache(
        "assets/images/walking_man.png",
      ),
      srcSize: Vector2(64, 120),
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
        spriteSheet.createAnimation(row: 6, stepTime: 0.1, to: 8);
    walkingUpRightAnimation =
        spriteSheet.createAnimation(row: 7, stepTime: 0.1, to: 8);
    idleAnimation = spriteSheet.createAnimation(row: 1, stepTime: 0.8, to: 1);

    animation = idleAnimation;
    add(
      RectangleHitbox(
        size: Vector2(25, 20),
        position: Vector2(
          size.x * 0.5,
          size.y * 0.88,
        ),
        anchor: Anchor.bottomCenter,
      ),
    );

    // final style = TextStyle(color: BasicPalette.white.color);
    // final regular = TextPaint(style: style);
    // landIdTextComponent = TextBoxComponent(
    //   text: "",
    //   boxConfig: TextBoxConfig(
    //     margins: EdgeInsets.zero,
    //     growingBox: false,
    //     maxWidth: size.x,
    //   ),
    //   align: Anchor.center,
    //   textRenderer: regular,
    // );

    // add(landIdTextComponent);

    // debugMode = true;
    debugColor = Colors.amber;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (dontWalk) return;

    if (!joystick.delta.isZero()) {
      _lastSize.setFrom(size);
      _lastTransform.setFrom(transform);
      walkingDirection = joystick.direction;

      final movementThisFrame = joystick.relativeDelta * maxSpeed * dt;

      position.add(movementThisFrame);
    } else {
      walkingDirection = null;
    }
    animation = changeAnimation();
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is UnwalkableComponent) {
      transform.setFrom(_lastTransform);
      size.setFrom(_lastSize);
    } 
     if (other is LandComponents) {
      showLandTextOverlay(other.id);
    }
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

  void showLandTextOverlay(int id) {
    // landIdTextComponent.text = "$id";
    if (currentSelectedLand != id) {
      currentSelectedLand = id;
      ref.read(selectedLandProvider.notifier).update((state) => state = id);
    }
  }
}
