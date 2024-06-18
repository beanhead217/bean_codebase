import '../../entity_component/behaviors/behavior.dart';
import '../../mixins/steerable.dart';
import '../../mixins/steering.dart';

/// {@template steering_behavior}
/// Abstract base class for steering behaviors.
/// {@endtemplate}
abstract class SteeringBehavior<Parent extends Steerable>
    extends Behavior<Parent> with Steering {}
