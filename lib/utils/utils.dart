import 'dart:math' as math;
extension Computations on num{
 double get toRadian{
  return this * math.pi / 180;
 }
}