import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class JoyStick extends JoystickComponent {
  JoyStick({
    Paint? knobPaint,
    Paint? backgroundPaint,
  }) : super(
          knob: CircleComponent(
              radius: 20,
              paint: knobPaint ?? BasicPalette.blue.withAlpha(200).paint()),
          background: CircleComponent(
              radius: 40,
              paint:
                  backgroundPaint ?? BasicPalette.blue.withAlpha(100).paint()),
          margin: const EdgeInsets.only(
            left: 40,
            bottom: 40,
          ),
        );


        @override
  FutureOr<void> onLoad() {
    super.onLoad();
    anchor = Anchor.bottomCenter;
  }
}
