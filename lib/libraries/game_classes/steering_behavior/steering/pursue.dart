import 'package:flame/extensions.dart';
import 'package:bean_codebase/libraries/game_classes/steering_behavior/steering/steering_core.dart';
import '../../entity_component/entity.dart';
import '../../mixins/steerable.dart';

/// {@template pursue}
/// Pursue steering algorithm.
/// {@endtemplate}
class Pursue extends SteeringCore {
  /// {@macro pursue}
  const Pursue(
    this.target, {
    required this.maxPrediction,
    required this.maxVelocityPursuit,
  });

  /// The target to pursue.
  final Entity target;

  /// The maximum prediction time.
  final double maxPrediction;

  /// The character max velocity when in pursuit.
  final double maxVelocityPursuit;



  @override
  Vector2 getSteering(Steerable parent) {
    final displacement = target.position - parent.position;
    final distance = displacement.length;

    final speed = parent.velocity.length;
    final double prediction;
    if (speed <= distance / maxPrediction) {
      prediction = maxPrediction;
    } else {
      prediction = distance / speed;
    }

    parent.maxVelocity =  maxVelocityPursuit;


    final explicitTarget = target.position.clone();
      // ..add(parent.velocity);
      // ..multiply(Vector2.all(prediction));
    /// MADE THE ABOVE UPDATE TO HAVE A MORE ACCURATE FOLLOWING

    return seek(parent, explicitTarget);
  }
}
