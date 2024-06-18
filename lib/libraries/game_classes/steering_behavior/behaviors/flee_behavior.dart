import 'package:flame/extensions.dart';
import 'package:bean_codebase/libraries/game_classes/steering_behavior/behaviors/steering_behavior.dart';
// import 'package:flame_behaviors/flame_behaviors.dart';
import '../../entity_component/entity.dart';
import '../../mixins/steerable.dart';
import '../steering/flee.dart';

/// {@template flee_behavior}
/// Flee steering behavior.
/// {@endtemplate}
 class FleeBehavior<Parent extends Steerable> extends SteeringBehavior<Parent> {
  /// {@macro flee_behavior}
  FleeBehavior(
    this.target, {
    required this.maxAcceleration,
    required this.panicDistance,
  });

  /// The target to flee from.
  final Entity target;

  /// The maximum acceleration of the entity.
  final double maxAcceleration;

  /// The maximum distance between the target and entity for the entity to
  /// panic.
  final double panicDistance;

  @override
  void update(double dt) {
    final distanceToTarget = target.distance(parent);

    if (distanceToTarget < panicDistance) {
      steer(
        Flee(
          target,
          maxAcceleration: maxAcceleration,
        ),
        dt,
      );
    }
  }

  @override
  void renderDebugMode(Canvas canvas) {
    canvas.drawCircle((parent.size / 2).toOffset(), panicDistance, debugPaint);
    super.renderDebugMode(canvas);
  }
}
