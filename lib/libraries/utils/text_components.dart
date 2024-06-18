import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';


import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameText extends TextComponent {
  String val;
  Color color;
  final double fontSize;
  final double strokeWidth;
  late TextComponent foregroundTextComponent;

  GameText({
    required this.val,
    required this.color,
    required this.fontSize,
    this.strokeWidth = 1,
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Create the outline text renderer
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'PIXEL CRAFT',
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = Colors.black,
      ),
    );

    // Create the foreground text renderer
    final foregroundTextRenderer = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'PIXEL CRAFT',
        color: color,
      ),
    );

    // Set the text and anchor for the outline
    text = val;
    anchor = Anchor.center;

    // Create the foreground TextComponent
    foregroundTextComponent = TextComponent(
      text: text,
      textRenderer: foregroundTextRenderer,
    );

    // Add the foreground TextComponent to the GameText
    add(foregroundTextComponent);
  }

  // Method to update the text
  void updateText(String newText) {
    text = newText;
    foregroundTextComponent.text = newText;
  }

  // Method to update the color
  void updateColor(Color newColor) {
    color = newColor;
    foregroundTextComponent.textRenderer = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'PIXEL CRAFT',
        color: color,
      ),
    );
  }

  @override
  void update(double dt) {}
}

class GameTextTemp extends TextComponent {
  final String val;
  final Color color;
  final double fontSize;
  final double strokeWidth;
  final int durationSeconds;
  GameTextTemp({required this.val,required this.color, required this.fontSize, this.strokeWidth = 1,required this.durationSeconds});

  @override
  FutureOr<void> onLoad() {

    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: 'PIXEL CRAFT',
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = Colors.black,
      ),
    );
    final foregroundTextRenderer = TextPaint(
      style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'PIXEL CRAFT',
          color: color  //Colors.white, //Color(0xffaea69f),//  //(damage + rarity) > (maxBulletDamage + rarity) ? Colors.orange : Colors.white,
      ),
    );
    text = val;
    anchor = Anchor.center;

    add(TextComponent(
      text: text,
      textRenderer: foregroundTextRenderer,
    ));

    Future.delayed(Duration(seconds: durationSeconds), () {removeFromParent();});

  }

  @override
  void update(double dt) {}
}



// class CardAbilityText extends PositionComponent {
//   final String val;
//   CardAbilityText({required this.val,});
//
//   final backgroundGroundTextRenderer =  TextPaint(
//     style: TextStyle(
//       fontSize: 60,
//       fontFamily: 'PIXEL CRAFT',
//       fontWeight: FontWeight.bold,
//       foreground: Paint()
//         ..style = PaintingStyle.stroke
//         ..strokeWidth = 15
//         ..color = Colors.black,
//     ),
//   );
//
//   final foregroundTextRenderer =   TextPaint(
//     style: TextStyle(
//       fontSize: 60,
//       fontFamily: 'PIXEL CRAFT',
//       color: Colors.white, //Color(0xffaea69f),//  //(damage + rarity) > (maxBulletDamage + rarity) ? Colors.orange : Colors.white,
//     ),
//   );
//
//
//   @override
//   Future<void> onLoad() async {
//
//     if(val.length > 25){
//       await  add(TextBoxComponent(
//           align: Anchor.center,
//           text: val,
//           textRenderer: backgroundGroundTextRenderer,
//           size: Vector2(PZGame.cardWidth * .85, PZGame.cardHeight / 6.5),
//           anchor: Anchor.center
//
//       ));
//
//       await  add(TextBoxComponent(
//           align: Anchor.center,
//           text: val,
//           textRenderer: foregroundTextRenderer,
//           size: Vector2(PZGame.cardWidth *.85, PZGame.cardHeight / 6.5),
//           anchor: Anchor.center
//
//       ));
//
//     } else{
//       add(TextComponent(
//           text: val,
//           textRenderer: backgroundGroundTextRenderer,
//           size: Vector2(PZGame.cardWidth * .85, PZGame.cardHeight / 6.5),
//           anchor: Anchor.center
//
//       ));
//
//       add(TextComponent(
//           text: val,
//           textRenderer: foregroundTextRenderer,
//           size: Vector2(PZGame.cardWidth *.85, PZGame.cardHeight / 6.5),
//           anchor: Anchor.center
//
//       ));
//
//     }
//
//      position.setFrom(Vector2(PZGame.cardWidth * .50, PZGame.cardHeight - 470));
//
//
//
//
//   }
//
//   @override
//   void update(double dt) {}
// }

