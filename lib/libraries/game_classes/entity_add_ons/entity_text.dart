import 'dart:math';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import '../../utils/text_components.dart';
import '../entity_component/entity.dart';


class EntityText extends PositionComponent {

  final Entity myParent;
  final Color color;
  final double fontSize;
  final String val;

  EntityText({required this.myParent, required this.val, this.color = Colors.white, this.fontSize = 16,});

  @override
  void onLoad() {
    myParent.showEntityText = true;
    add(GameText(val: val, color: color, fontSize: fontSize, strokeWidth: 2.0));
    position.setFrom(Vector2(8.5, -12));
    Future.delayed(const Duration(seconds: 7), () {
      removeFromParent();
      myParent.showEntityText = false;
    });
    
  }


  @override
  void update(double dt) {
    //position.setFrom(Vector2(8.5, -22));
    if( myParent.children.whereType<EntityText>().length > 1){
      myParent.children.whereType<EntityText>().first.removeFromParent();
    }
  }


}
