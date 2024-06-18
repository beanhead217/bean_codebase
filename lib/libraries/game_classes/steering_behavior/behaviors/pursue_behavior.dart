import 'dart:ui';

import 'package:flame/components.dart';
import 'package:bean_codebase/libraries/game_classes/steering_behavior/behaviors/steering_behavior.dart';
import '../../entity_component/entity.dart';
import '../../mixins/steerable.dart';
import '../steering/pursue.dart';

/// {@template pursue_behavior}
/// Pursue steering behavior.
/// {@endtemplate}
 class PursueBehavior<Parent extends Steerable>
    extends SteeringBehavior<Parent> {
  /// {@macro pursue_behavior}
  PursueBehavior(
    this.target, {
    required this.pursueRange,
    this.maxPrediction = 1,
     required this.maxVelocityPursuit,
  });

  /// The target to pursue.
  final Entity target;

  /// The maximum prediction time.
  final double maxPrediction;

  /// The character max velocity when in pursuit.
  final double maxVelocityPursuit;

  /// The range in which the goblin will pursue the player.
  final double pursueRange;


  @override
  void update(double dt) {
    final distanceToTarget = target.distance(parent);

    if (distanceToTarget < pursueRange) {
      steer(Pursue(target, maxPrediction: maxPrediction, maxVelocityPursuit: maxVelocityPursuit), dt);
    }
    // else{
    //    if(parent.maxVelocity != parent.maxVelocityOriginal){
    //      parent.maxVelocity = parent.maxVelocityOriginal;
    //    }
    // }
  }

  @override
  void renderDebugMode(Canvas canvas) {
    canvas.drawCircle(
      (parent.size / 2).toOffset(),
      pursueRange,
      debugPaint,
    );
    super.renderDebugMode(canvas);
  }
}
