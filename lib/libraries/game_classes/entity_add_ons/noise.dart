import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../entity_component/entity.dart';



class Noise extends PositionComponent with CollisionCallbacks {
  final Entity myParent;
  Noise({required this.myParent});

  // @override
  // Color debugColor = Color(0xfffcf536);

  @override
  Anchor get anchor => Anchor.center;
  @override
  int priority = 1;

  late CircleComponent shape;
  late CircleHitbox noiseHitBox;
  double radius = 100;


  // Initial opacity (255 is fully opaque)
  int _opacity = 255;
  // Time in seconds to fully fade out
  double fadeOutTimer = 0.35;
  // Timer to track fading progress
  double _fadeTimer = 0;


  Paint paint = Paint()..color = Colors.grey;
  Paint paintExpand = Paint()..color = Colors.grey.withOpacity(0.3);
  bool fadeOut  = false;




  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is RectangleComponent) {
      //enemyTakeDamage(other);
      //print("HIT RECTANGLE");
    }
    if (other is CircleComponent) {
      //enemyTakeDamage(other);
     // print("HIT CIRCLE");
    }
  }

  @override
  FutureOr<void> onLoad() {
    //scale = scale * 2;
    position = myParent.position;
   // print(position);
    shape = CircleComponent(
      radius: 1,
      paint: paintExpand,
      anchor: Anchor.center
    );
    shape.add(
      SizeEffect.to(
        Vector2.all(radius),
        EffectController(duration:fadeOutTimer),
        onComplete: (){fadeOut = true;}
      ),
    );
    noiseHitBox = CircleHitbox(radius: 1)..anchor = Anchor.center;
    add(shape);
    add(noiseHitBox);
    add(CircleComponent(
        radius: radius / 2,
        paint: paint..style = PaintingStyle.stroke..strokeWidth = 1,
        anchor: Anchor.center
    ));
  }


  @override
  void update(double dt) {
    super.update(dt);
    noiseHitBox.radius = shape.radius * 2;
    // Update the timer
     if(fadeOut){
      _fadeTimer += dt ;
      // Calculate new opacity
      double progress = _fadeTimer / fadeOutTimer;
      _opacity = (255 * (1 - progress)).toInt();
      // Update the paint color with the new opacity
      paint.color = paint.color.withAlpha(_opacity);
      paintExpand.color = paintExpand.color.withAlpha(_opacity ~/ 3);
      // Check if completely faded
      if (_opacity <= 0) {
        // Optionally remove or hide the component
        removeFromParent();
      }
    }
  }



}
