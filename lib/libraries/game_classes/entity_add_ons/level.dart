import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import '../../utils/text_components.dart';
import '../entity_component/entity.dart';


class Level extends PositionComponent {

  final Entity myParent;

  Level({required this.myParent});

  @override
  Future<void> onLoad() async {
    await addAll(
      [
        // RectangleComponent(
        //   size: Vector2(8, 8),
        //   anchor: Anchor.center,
        //   paint: BasicPalette.red.paint(),
        // ),
        GameText(val: myParent.level.toString(), color: Colors.white, fontSize: 6, )
      ]
    );

    myParent.level.toString().length > 2 ? position.setFrom(Vector2(-6.2, -6.3)) : position.setFrom(Vector2(-4.8, -6.3));
  }


  @override
  void update(double dt) {
   //  myParent.level.toString().length > 2 ? position.setFrom(Vector2(-6.2, -6.3)) : position.setFrom(Vector2(-4.8, -6.3));
  }
}
