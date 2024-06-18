import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../entity_component/entity.dart';



class HealText extends TextComponent {
  final int heal;
  final Entity target;

  HealText({
    required this.target,
    required this.heal,
  });

  @override
  FutureOr<void> onLoad() {
    priority = 10;
    x = target.x -
        target.size.x / 2 +
        Random().nextInt(target.size.x.toInt()).toDouble();
    y = target.y -
        target.size.y / 2 -
        Random().nextInt(target.size.y ~/ 4).toDouble();
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 28,
        fontFamily: 'monogram',
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = Colors.black,
      ),
    );
    final foregroundTextRenderer = TextPaint(
      style: const TextStyle(
        fontSize: 28,
        fontFamily: 'monogram',
        color: Colors.green,
      ),
    );
    text = '+$heal';
    anchor = Anchor.center;

    add(TextComponent(
      text: text,
      textRenderer: foregroundTextRenderer,
    ));

    Future.delayed(const Duration(milliseconds: 500), () {
      add(SequenceEffect([
        ScaleEffect.to(Vector2.zero(), EffectController(duration: 0.1)),
        RemoveEffect(),
      ]));
    });
  }

  @override
  void update(double dt) {
    y -= 24 * dt;
  }
}
