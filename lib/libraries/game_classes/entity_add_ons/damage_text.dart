import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../entity_component/entity.dart';

class DamageText extends TextComponent {
  final int damage;
  final int maxDamage;
  final Entity target;
  final int damagePriority;

  DamageText({
    required this.target,
    required this.damage,
    required this.maxDamage,
    required this.damagePriority,
  });

  @override
  FutureOr<void> onLoad() {
    priority = damagePriority;
    x = target.x - target.size.x / 2 + Random().nextInt(target.size.x.toInt()).toDouble();
    y = target.y - target.size.y / 2 - Random().nextInt(target.size.y ~/ 4).toDouble();
    textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 6 * (1 + (damage / maxDamage)),
        fontFamily: 'PIXEL CRAFT',
        fontWeight: FontWeight.bold,
        foreground: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.black,
      ),
    );
    final foregroundTextRenderer = TextPaint(
      style: TextStyle(
        fontSize: 6 * (1 + (damage / maxDamage)),
        fontFamily: 'PIXEL CRAFT',
        color: damage > maxDamage ? Colors.orange : Colors.white,
      ),
    );
    text = damage.toString();
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
