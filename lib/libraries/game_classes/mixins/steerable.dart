import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import '../entity_component/entity.dart';


/// {@template steerable}
/// Mixin that makes an [Entity] steerable.
/// {@endtemplate}


mixin Steerable on Entity {
  /// The max velocity of the entity.
  ///
  /// Used for clamping the [velocity] distance.
  double maxVelocity = 0.0;
  double speed = 1.0;

  /// The current velocity of the entity.
  Vector2 velocity = Vector2.zero();


  @override
  @mustCallSuper
  void update(double dt) {
    final velocityDelta = (velocity * speed) * dt;

    position.add(velocityDelta);
    velocity.sub(velocityDelta);
    super.update(dt);
  }


}
