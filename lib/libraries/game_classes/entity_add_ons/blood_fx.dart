

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
final ColorTween bloodTween = ColorTween(begin: Colors.red.shade900, end: Colors.red.shade900); //const Color(0xff8f1b15)

void bloodFX({required FlameGame theGame, required Entity entity,required int count}){
  theGame.world.add(bloodParticle(entity: entity, count: count));
  theGame.world.addAll(bloodSplat(entity: entity, count: count));
}


ParticleSystemComponent bloodParticle({required Entity entity,required int count}){
  return ParticleSystemComponent(
    position: entity.center,
    priority: entity.priority,
    particle: Particle.generate(
      lifespan: 0.5,
      applyLifespanToChildren: true,
      count: count, //gunComponent.bloodSplatCount, //100
      generator: (i) =>
          AcceleratedParticle(
            speed: randomVector2(),
            acceleration: Vector2(0, 600),
            child: ComponentParticle(
              component:  RectangleComponent(
                  angle: Tools.randomRange(0,100).toDouble(),
                  scale: entity.scale * .325,
                  size: Vector2(Tools.randomRange(1,3).toDouble() ,Tools.randomRange(1,3).toDouble()),
                  paint:  Paint()..color = bloodTween.transform(random.nextDouble())!.withOpacity(1.0)!),
            ),
          ),
    ),
  );
}


List<CircleComponent> bloodSplat({required Entity entity,required int count}) {
  List<CircleComponent> circles = [];
  bool xBool = random.nextBool();
  bool yBool = random.nextBool();
  bool bigBlood = Tools.probabilityBoolean(.3);
  for (var i = 0; i < count; i++) {
    circles.add(
        CircleComponent(
            position: Vector2( xBool ? entity.center.x + Tools.randomRange(0,35) : entity.center.x - Tools.randomRange(0,35) , yBool ? entity.center.y + Tools.randomRange(0,35) : entity.center.y - Tools.randomRange(0,35)), //center + randomVector2(),
            priority: 0,
            radius: bigBlood ? random.nextInt(2) + 1 : random.nextInt(2 - 1) + 1,
            paint:  Paint()..color = bloodTween.transform(random.nextDouble())!.withOpacity(1.0)!)..add(
          RemoveEffect(
            delay: 35.0,
            onComplete: () {},
          ),
        )
    );
  }
  return circles;
}