

import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/particles.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../../utils/tools.dart';
import '../entity_component/entity.dart';

var random = Random();
Vector2 randomVector2() => Vector2((random.nextDouble() * 200) - 100, -random.nextDouble() * 200);
final ColorTween debrisTween = ColorTween(begin: Colors.grey.shade700, end: Colors.grey.shade800); //const Color(0xff8f1b15)
final ColorTween bulletWholeTween = ColorTween(begin: Colors.grey.shade900, end: Colors.grey.shade900); //const Color(0xff8f1b15)
void debrisFX({required FlameGame theGame, required PositionComponent bullet, required Vector2 objectPosition}){
  theGame.world.add(debrisParticle(entity: bullet, objectPosition: objectPosition));

}

ParticleSystemComponent debrisParticle({required PositionComponent entity, required Vector2 objectPosition}){
  final direction = entity.position - objectPosition;
  return ParticleSystemComponent(
    position: objectPosition + direction,
    priority: entity.priority,
    particle: Particle.generate(
      lifespan: 0.5,
      applyLifespanToChildren: true,
      count: 5,
      generator: (i) =>
          AcceleratedParticle(
            speed: randomVector2(),
            acceleration: Vector2(0, 600),
            child: ComponentParticle(
              component:  RectangleComponent(
                  angle: Tools.randomRange(0,100).toDouble(),
                  scale: entity.scale * .325,
                  size: Vector2(Tools.randomRange(1,3).toDouble() ,Tools.randomRange(1,3).toDouble()),
                  paint:  Paint()..color = debrisTween.transform(random.nextDouble())!.withOpacity(1.0)!),
            ),
          ),
    ),
  );
}


