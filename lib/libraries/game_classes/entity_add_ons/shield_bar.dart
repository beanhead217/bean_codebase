import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/material.dart';
import '../../../../libraries/game_classes/entity_component/entity.dart';




class ShieldBar extends PositionComponent  {
  final Entity myParent;

  ShieldBar({required this.myParent});

  Paint barLiveBgPaint = Paint();
  Paint barLivePaint = Paint();
  Paint barLiveBorderPaint = Paint();


  @override
  void onLoad()  {
    position.setValues(position.x , position.y - 2);
  }

  @override
  void render(Canvas canvas) {
    if(myParent.showShieldBar && !myParent.showEntityText) {
      drawDefaultLifeBar(
          canvas,
          borderWidth: 0
      );
    }
  }



  void drawDefaultLifeBar(
      Canvas canvas, {
        Offset align = Offset.zero,
        bool drawInBottom = false,
        double margin = 2,
        double height = 3,
        double? width,
        List<Color>? colorsLife,
        Color backgroundColor = Colors.transparent,
        material.BorderRadius borderRadius = material.BorderRadius.zero,
        double borderWidth = 0,
        Color borderColor = const Color(0xFFFFFFFF),

      }) {
    double yPosition = (y - height) - margin;

    double xPosition = x + align.dx;

    if (drawInBottom) {
      yPosition = toRect().bottom + margin;
    }

    yPosition = yPosition - align.dy;

    final w = width ?? myParent.width;

    double currentBarLife = (myParent.shield * w) / myParent.maxShield;

    if (borderWidth > 0) {
      final RRect borderRect = borderRadius.toRRect(Rect.fromLTWH(
        xPosition,
        yPosition,
        w,
        height,
      ));

      canvas.drawRRect(
        borderRect,
        barLiveBorderPaint
          ..color = borderColor
          ..strokeWidth = borderWidth
          ..style = PaintingStyle.stroke,
      );
    }

    final RRect bgRect = borderRadius.toRRect(Rect.fromLTWH(
      xPosition,
      yPosition,
      w,
      height,
    ));

    canvas.drawRRect(

      bgRect,
      barLiveBgPaint
        ..color = backgroundColor
        ..style = PaintingStyle.fill,
    );

    final RRect lifeRect = borderRadius.toRRect(Rect.fromLTWH(
      xPosition,
      yPosition,
      currentBarLife,
      height,
    ));



    canvas.drawRRect(
      lifeRect,
      barLivePaint
        ..color = _getColorLife(
          currentBarLife,
          w,
          colorsLife ??
              [
                const Color(0xFF0096FF),
                const Color(0xFF0096FF),
                const Color(0xFF0096FF),
              ],
        )
        ..style = PaintingStyle.fill,
    );

  }

  Color _getColorLife(
      double currentBarLife,
      double maxWidth,
      List<Color> colors,
      ) {
    final parts = maxWidth / colors.length;
    int index = (currentBarLife / parts).ceil() - 1;
    if (index < 0) {
      return colors[0];
    }
    if (index > colors.length - 1) {
      return colors.last;
    }
    return colors[index];
  }


}



