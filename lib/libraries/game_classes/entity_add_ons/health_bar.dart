import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flutter/material.dart' as material;
import '../entity_component/entity.dart';





class HealthBar extends PositionComponent {
  HealthBar({required this.myParent});
final Entity myParent;

Paint barLiveBgPaint = Paint();
Paint barLivePaint = Paint();
Paint barLiveBorderPaint = Paint();




@override
void onLoad()  {
  position.setValues(position.x , position.y - 2);
}

  @override
  void render(Canvas canvas) {
  if(myParent.showHealthBar && !myParent.showEntityText) {
    drawDefaultLifeBar(
        canvas,
        borderWidth: 1
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
        Color backgroundColor = const Color(0xFF000000),
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

    double currentBarLife = (myParent.health * w) / myParent.maxHealth;

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
                const Color(0xFFF44336),
                const Color(0xFFFFEB3B),
                const Color(0xFF4CAF50),
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



