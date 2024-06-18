import 'package:flame/components.dart';
import 'package:flutter/material.dart';


//
// Offset worldToGridOffset(Vector2 mapLocation) {
//   var block = gameRef.base.getBlock(mapLocation);
//   return Offset(block.x.toDouble() + 1, block.y.toDouble());
// }
// Vector2 gridOffsetToWorld(Offset gridOffset) {
//   var block = Block(gridOffset.dx.toInt(), gridOffset.dy.toInt());
//   var worldPosition = (gameRef.topLeft + gameRef.base.getBlockRenderPosition(block));
//   return Vector2(worldPosition.x, worldPosition.y);
// }