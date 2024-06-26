import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:bean_codebase/libraries/game_classes/entity_component/behaviors/behaviors.dart';
import 'package:bean_codebase/libraries/game_classes/mixins/steerable.dart';
import '../steering_behavior/steering/steering_core.dart';


/// {@template steering}
/// Mixin that turns a [Behavior] into a steering behavior for a [Steerable].
/// {@endtemplate}
mixin Steering<T extends Steerable> on Behavior<T> {
  /// The current velocity of the parent entity.
  Vector2 get velocity => parent.velocity;

  /// Updates the velocity by the given linear acceleration from [steering].
  void steer(SteeringCore steering, double dt) {
    final linearAcceleration = steering.getSteering(parent) * dt;
    velocity.add(linearAcceleration);

    if (velocity.length > parent.maxVelocity) {
      velocity.setFrom(velocity.normalized() * parent.maxVelocity);
    }
  }

  @override
  @mustCallSuper
  void renderDebugMode(Canvas canvas) {
    canvas.drawLine(
      (parent.size / 2).toOffset(),
      velocity.toOffset(),
      debugPaint,
    );
  }
}
