enum Rarity {
  common,
  uncommon,
  rare,
  epic,
  legendary;

String toJson() => name;
static Rarity fromJson(String json) => values.byName(json);
}


enum MovementState {
  idle,
  run,
  dead
}

enum EntityType {
  character,
  object,
  passive
}

// ignore: constant_identifier_names
enum ReceivesAttackFromEnum { ALL, ENEMY, PLAYER_AND_ALLY, NONE }

// ignore: constant_identifier_names
enum AttackFromEnum { ENEMY, PLAYER_OR_ALLY, WORLD }









