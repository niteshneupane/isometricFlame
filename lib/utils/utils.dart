import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

extension Computations on num {
  double get toRadian {
    return this * math.pi / 180;
  }
}

extension IsoConversion on Point {
  Point get isoPoints {
    var isoX = (x - y);
    var isoY = (x * 0.5 + y * 0.5);
    return Point(x: isoX, y: isoY);
  }
}

extension IsoConversionVector on Vector2 {
  Vector2 isoPoint({Vector2? offset}) {
    var isoX = (x - y) + (offset?.x ?? 0);
    var isoY = (x * 0.5 + y * 0.5) + (offset?.y ?? 0);
    return Vector2(isoX, isoY);
  }
}
