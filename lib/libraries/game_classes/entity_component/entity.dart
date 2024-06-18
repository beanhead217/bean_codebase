import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

import '../../utils/const.dart';
import '../../utils/interval_checker.dart';
import '../../utils/tools.dart';
import '../entity_add_ons/debris_fx.dart';
import 'behaviors/behavior.dart';
import 'entity_enums.dart';



/// {@template entity}
/// The entity is the building block of a game. It represents a visual game
/// object that can hold multiple `Behavior`s, which in turn define how the
/// entity behaves.
///
/// The visualization of the entity is defined by the [PositionComponent]s that are
/// attached to it.
/// {@endtemplate}
abstract class Entity extends PositionComponent with IntervalChecker{
  /// {@macro entity}
  Entity({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority,
    Iterable<Behavior>? behaviors,
  }) : assert(
          children?.whereType<Behavior>().isEmpty ?? true,
          'Behaviors cannot be added to as a child directly.',
        ) {
    children.register<Behavior>();
    _behaviors = children.query<Behavior>();

    if (behaviors != null) {
      addAll(behaviors);
    }
  }

  late final List<Behavior> _behaviors;

  ///Mixin & ADD ON Related Attributes
  bool showHealthBar = false;
  bool showShieldBar = false;
  bool showStaminaBar = false;
  bool showEntityText = false;
  bool showLight = true;
  bool isDead = false;

  /// Game Related Attributes
  String name = '';
  double health = 100;
  double maxHealth = 100;
  double shield = 1;
  double maxShield = 100;
  double stamina = 100;
  double maxStamina = 100;
  int strength = 0;
  int accuracy = 0;
  int level = 1;
  int exp = 1;
  int maxExp = 10;
  double lightRadius = 50;



  ///Helper Attributes
  MovementState movementState = MovementState.idle;
  EntityType entityType = EntityType.character;
  ReceivesAttackFromEnum receivesAttackFrom = ReceivesAttackFromEnum.NONE;
  AttackFromEnum attackFromEnum = AttackFromEnum.WORLD;
  RectangleHitbox myHitBox = RectangleHitbox(isSolid:true);
  late String id;

  //============================================================================ FUNCTIONS
  bool checkCanReceiveDamage(AttackFromEnum attacker) {
    switch (receivesAttackFrom) {
      case ReceivesAttackFromEnum.ALL:
        return true;
      case ReceivesAttackFromEnum.ENEMY:
        if (attacker == AttackFromEnum.ENEMY || attacker == AttackFromEnum.WORLD) {
          return true;
        }
        break;
      case ReceivesAttackFromEnum.PLAYER_AND_ALLY:
        if (attacker == AttackFromEnum.PLAYER_OR_ALLY ||
            attacker == AttackFromEnum.WORLD) {
          return true;
        }
        break;
      case ReceivesAttackFromEnum.NONE:
        return false;
    }

    return false;
  }


  // @override
  // int get priority => position.y.toInt();

//=============================================================================================================== STAY WITHING A CERTAIN AREA
  stayInBounds(){
    if (position.x < 0) {
      position.x = 0;
    }
    if (position.y < 0) {
      position.y = 0;
    }
    if (position.x > mapWidth) {
      position.x = mapWidth;
    }
    if (position.y > mapHeight - 20) {
      position.y = mapHeight - 20;
    }
  }

  //============================================================================================================= OBJECT COLLISION

  //
  // objectCollision(PositionComponent other){
  //   if (position.x > other.x) {
  //     position.x = other.x;
  //   }
  //   if (position.y > other.y) {
  //     position.y = other.y;
  //   }
  //   if (position.x < other.x + other.size.x) {
  //     position.x = other.x + other.size.x;
  //   }
  //   if (position.y < other.y + other.size.y) {
  //     position.y = other.y + other.size.y;
  //   }
  // }

  void onLoad() {
    super.onLoad();
    id  = Tools.uuid.v4();
    // add(myHitBox//..debugMode = true
    // );
     anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);


  }


  /// Returns a list of behaviors with the given type, that are attached to
  /// this entity.
  ///
  /// This will only return behaviors that have a completed lifecycle, aka they
  /// are fully mounted.
  Iterable<T> findBehaviors<T extends Behavior>() {
    return _behaviors.whereType<T>();
  }

  /// Returns the first found behavior with the given type, that is attached
  /// to this entity.
  ///
  /// This will only return a behavior that has a completed lifecycle, aka it
  /// is fully mounted. If no behavior is found, it will throw a [StateError].
  T findBehavior<T extends Behavior>() {
    final it = findBehaviors<T>().iterator;
    if (!it.moveNext()) {
      throw StateError('No behavior of type $T found.');
    }
    return it.current;
  }

  /// Checks if this entity has at least one behavior with the given type.
  ///
  ///
  /// This will only return true if the behavior with the type [T] has a
  /// completed lifecycle, aka it is fully mounted.
  bool hasBehavior<T extends Behavior>() {
    try {
      findBehavior<T>();
      return true;
    } catch (e) {
      if (e is StateError) {
        return false;
      }
      rethrow;
    }
  }
}
