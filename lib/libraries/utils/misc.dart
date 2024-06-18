// // import 'dart:math';
// // import 'package:flame/camera.dart';
// // import 'package:flame/components.dart';
// // import 'package:flame/flame.dart';
// // import 'package:flame/game.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:bean_codebase/game/utils/tools.dart';
// //
// // import '../../main.dart';
// // import '../environment/buildings/building_component.dart';
// // import '../environment/buildings/building_enum.dart';
// // import '../environment/street_light/street_light_component.dart';
// // import '../environment/street_light/street_light_enum.dart';
// // import 'load_images_cache.dart';
// //
// // class CityGridGame extends FlameGame {
// //   static const double cellSize = 32.0;
// //   static const int blockHeightCells = 7;
// //   static const int gridRows = 3;
// //   static const int gridCols = 3;
// //   static const double gap = 32 * 3.5;
// //   static Vector2 roadLineSize = Vector2(38, 3);
// //   static Vector2 crossWalkSize = Vector2(48, 104); // Size of the crosswalk
// //
// //   final List<Rect> crossWalkAreas = [];
// //
// //   @override
// //   Future<void> onLoad() async {
// //     super.onLoad();
// //
// //     await Flame.images.loadAll(loadImagesCache);
// //
// //     camera.viewport = FixedResolutionViewport(resolution: size);
// //     camera.viewfinder.zoom = 0.25;
// //
// //     final List<BuildingType> tempBuildingTypes = [
// //       BuildingType.building_2,
// //       BuildingType.building_2,
// //     ];
// //
// //     double blockWidth = CityBlockComponent.calculateBlockSize(tempBuildingTypes).x;
// //     double blockHeight = blockHeightCells * cellSize;
// //     double totalGridWidth = gridCols * blockWidth + (gridCols - 1) * gap;
// //     double totalGridHeight = gridRows * blockHeight + (gridRows - 1) * gap;
// //
// //     // Create a grid of CityBlockComponent with RoadLineComponents in between
// //     for (int row = 0; row < gridRows; row++) {
// //       for (int col = 0; col < gridCols; col++) {
// //         double xPosition = (col * (blockWidth + gap));
// //         double yPosition = (row * (blockHeight + gap));
// //
// //         // Add CityBlockComponent
// //         world.add(CityBlockComponent(
// //           position: Vector2(xPosition, yPosition),
// //           buildingTypes: tempBuildingTypes,
// //         ));
// //
// //         // Add CrossWalkComponent at the intersections
// //         if (col < gridCols - 1 && row < gridRows - 1) {
// //           double crossWalkX = xPosition + blockWidth + gap / 2;
// //           double crossWalkY = yPosition + blockHeight + gap / 2;
// //
// //           // Add four crosswalks at each intersection
// //           crossWalkAreas.add(Rect.fromLTWH(
// //             crossWalkX - crossWalkSize.x - 4,
// //             crossWalkY - gap / 2,
// //             crossWalkSize.x,
// //             crossWalkSize.y,
// //           ));
// //           crossWalkAreas.add(Rect.fromLTWH(
// //             crossWalkX - crossWalkSize.x - 4,
// //             crossWalkY + gap,
// //             crossWalkSize.x,
// //             crossWalkSize.y,
// //           ));
// //           crossWalkAreas.add(Rect.fromLTWH(
// //             crossWalkX + gap / 2,
// //             crossWalkY - crossWalkSize.y / 2,
// //             crossWalkSize.x,
// //             crossWalkSize.y,
// //           ));
// //           crossWalkAreas.add(Rect.fromLTWH(
// //             crossWalkX - gap / 2 - crossWalkSize.x,
// //             crossWalkY - crossWalkSize.y / 2,
// //             crossWalkSize.x,
// //             crossWalkSize.y,
// //           ));
// //
// //           world.add(CrossWalkComponent(
// //             position: Vector2(crossWalkX - crossWalkSize.x - 4, crossWalkY - gap / 2),
// //             size: crossWalkSize,
// //           )..angle = -pi / 2);
// //           world.add(CrossWalkComponent(
// //             position: Vector2(crossWalkX - crossWalkSize.x - 4, crossWalkY + gap),
// //             size: crossWalkSize,
// //           )..angle = -pi / 2);
// //           world.add(CrossWalkComponent(
// //             position: Vector2(crossWalkX + gap / 2, crossWalkY - crossWalkSize.y / 2),
// //             size: crossWalkSize,
// //           ));
// //           world.add(CrossWalkComponent(
// //             position: Vector2(crossWalkX - gap / 2 - crossWalkSize.x, crossWalkY - crossWalkSize.y / 2),
// //             size: crossWalkSize,
// //           ));
// //         }
// //
// //         // Add RoadLineComponent between CityBlockComponents vertically
// //         if (row < gridRows - 1) {
// //           double startX = xPosition + roadLineSize.x;
// //           double endX = xPosition + blockWidth - roadLineSize.x;
// //
// //           for (double x = startX; x <= endX; x += roadLineSize.x * 2) {
// //             Vector2 roadLinePosition = Vector2(
// //               x - roadLineSize.x / 2,
// //               yPosition + blockHeight + gap / 2 - roadLineSize.y / 2,
// //             );
// //             if (!_overlapsWithCrosswalk(roadLinePosition, roadLineSize)) {
// //               world.add(RoadLineComponent(
// //                 position: roadLinePosition,
// //                 size: roadLineSize,
// //               ));
// //             }
// //           }
// //         }
// //
// //         // Add RoadLineComponent between CityBlockComponents horizontally
// //         if (col < gridCols - 1) {
// //           double startY = yPosition + roadLineSize.x;
// //           double endY = yPosition + blockHeight - roadLineSize.x;
// //
// //           for (double y = startY; y <= endY; y += roadLineSize.x * 2) {
// //             Vector2 roadLinePosition = Vector2(
// //               xPosition + blockWidth + gap / 2 - roadLineSize.y / 2,
// //               y + roadLineSize.x / 2,
// //             );
// //             if (!_overlapsWithCrosswalk(roadLinePosition, Vector2(roadLineSize.y, roadLineSize.x))) {
// //               world.add(RoadLineComponent(
// //                 position: roadLinePosition,
// //                 size: Vector2(roadLineSize.y, roadLineSize.x),
// //               ));
// //             }
// //           }
// //         }
// //       }
// //     }
// //   }
// //
// //   bool _overlapsWithCrosswalk(Vector2 position, Vector2 size) {
// //     final roadLineRect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
// //     for (final crossWalkArea in crossWalkAreas) {
// //       if (roadLineRect.overlaps(crossWalkArea)) {
// //         return true;
// //       }
// //     }
// //     return false;
// //   }
// // }
// //
// // class CityBlockComponent extends PositionComponent {
// //   static const double cellSize = 32.0;
// //   static const int blockHeightCells = 7;
// //   static double betweenBuildingGap = 1;
// //   final List<BuildingType> buildingTypes;
// //   double distributionGapEvenly = 1.0;
// //
// //   CityBlockComponent({required Vector2 position, required this.buildingTypes})
// //       : super(position: position, size: calculateBlockSize(buildingTypes));
// //
// //   @override
// //   Future<void> onLoad() async {
// //     super.onLoad();
// //
// //     distributionGapEvenly = (buildingTypes.length.isEven ? 1.5 : 1.0);
// //     int blockWidthCells = (size.x / cellSize).ceil();
// //
// //     // Create the sidewalk cells
// //     for (int y = 0; y < blockHeightCells; y++) {
// //       for (int x = 0; x < blockWidthCells; x++) {
// //         add(SidewalkComponent(
// //           position: Vector2((x * cellSize), (y * cellSize)),
// //           size: Vector2(cellSize, cellSize),
// //         ));
// //       }
// //     }
// //
// //     // Add street lights on the sides in the middle
// //     int middleHeightCell = blockHeightCells ~/ 2;
// //    add(StreetLightComponent(
// //       position: Vector2(0, (middleHeightCell * cellSize)),
// //       size: Vector2(cellSize, cellSize),
// //       streetLightType: StreetLightType.street_light_left,
// //     ));
// //     add(StreetLightComponent(
// //       position: Vector2(((blockWidthCells - 1) * cellSize) + 32, (middleHeightCell * cellSize)),
// //       size: Vector2(cellSize, cellSize),
// //       streetLightType: StreetLightType.street_light_right,
// //     ));
// //
// //     // Add street lights every 4th tile for the width, but avoid the corners
// //     for (int x = 5; x < blockWidthCells - 5; x += 5) {
// //       add(StreetLightComponent(
// //         position: Vector2((x * cellSize), -8),
// //         size: Vector2(cellSize, cellSize),
// //         streetLightType: StreetLightType.street_light_up,
// //       ));
// //       add(StreetLightComponent(
// //         position: Vector2((x * cellSize), ((blockHeightCells - 1) * cellSize) + 14),
// //         size: Vector2(cellSize / 4, cellSize /4),
// //         streetLightType: StreetLightType.street_light_down,
// //       ));
// //     }
// //
// //     // Add stop signs at the corners
// //     add(StopSignComponent(
// //       position: Vector2(0, 0),
// //       size: Vector2(cellSize, cellSize),
// //     ));
// //     add(StopSignComponent(
// //       position: Vector2((blockWidthCells - 1) * cellSize, 0),
// //       size: Vector2(cellSize, cellSize),
// //     ));
// //     add(StopSignComponent(
// //       position: Vector2(0, (blockHeightCells - 1) * cellSize),
// //       size: Vector2(cellSize, cellSize),
// //     ));
// //     add(StopSignComponent(
// //       position: Vector2((blockWidthCells - 1) * cellSize, (blockHeightCells - 1) * cellSize),
// //       size: Vector2(cellSize, cellSize),
// //     ));
// //
// //     // Add buildings based on building types
// //     double totalWidth = size.x;
// //     double requiredWidth = calculateRequiredWidth(buildingTypes);
// //     double extraSpace = totalWidth - requiredWidth;
// //     double sideGap = cellSize * distributionGapEvenly;
// //
// //     if (extraSpace > distributionGapEvenly * cellSize) {
// //       sideGap += extraSpace / 2;
// //     }
// //
// //     double x = sideGap;
// //     for (BuildingType type in buildingTypes) {
// //       Vector2 buildingSize = type.size;
// //       add(BuildingComponent(
// //           position: Vector2(
// //               x + buildingSize.x / 2, (blockHeightCells * cellSize) - (2 * cellSize)),
// //           size: buildingSize,
// //           buildingType: type
// //       ));
// //       x += buildingSize.x + (betweenBuildingGap * cellSize); // Add gap of 2 cells between buildings
// //     }
// //   }
// //
// //   static Vector2 calculateBlockSize(List<BuildingType> buildingTypes) {
// //     double totalWidth = calculateRequiredWidth(buildingTypes);
// //     // Ensure there is a minimum gap of 2 cells on both sides
// //     totalWidth += 4 * cellSize;
// //     return Vector2(totalWidth, blockHeightCells * cellSize);
// //   }
// //
// //   static double calculateRequiredWidth(List<BuildingType> buildingTypes) {
// //     double totalWidth = 0;
// //     for (BuildingType type in buildingTypes) {
// //       totalWidth += type.size.x + (betweenBuildingGap * cellSize);
// //     }
// //     return totalWidth;
// //   }
// //
// //   static Vector2 calculateHorizontalMidpoint(Vector2 position1, double width1, Vector2 position2, double width2) {
// //     double leftBlockRightEdgeX = position1.x + width1;
// //     double rightBlockLeftEdgeX = position2.x;
// //     double midpointX = (leftBlockRightEdgeX + rightBlockLeftEdgeX) / 2;
// //     return Vector2(midpointX, position1.y); // Assuming same y-coordinate for simplicity
// //   }
// // }
// //
//
// //
// // class StopSignComponent extends PositionComponent {
// //   StopSignComponent({required Vector2 position, required Vector2 size})
// //       : super(position: position, size: size);
// //
// //   @override
// //   void render(Canvas canvas) {
// //     super.render(canvas);
// //     final paint = Paint()..color = Colors.purple;
// //     canvas.drawRect(size.toRect(), paint);
// //   }
// // }
// //
// // class RoadLineComponent extends PositionComponent {
// //   RoadLineComponent({required Vector2 position, required Vector2 size, double angle = 0})
// //       : super(position: position, size: size, angle: angle);
// //
// //   @override
// //   void render(Canvas canvas) {
// //     super.render(canvas);
// //     final paint = Paint()..color = Colors.yellow;
// //     canvas.drawRect(size.toRect(), paint);
// //   }
// // }
// //
//
//
//
//
//
//
// import 'dart:ui';
//
// import 'package:flame/camera.dart';
// import 'package:flame/components.dart';
// import 'package:flame/flame.dart';
// import 'package:flame/game.dart';
// import 'package:flutter/material.dart';
//
// import '../environment/buildings/building_component.dart';
// import '../environment/buildings/building_enum.dart';
// import '../environment/street_light/street_light_component.dart';
// import '../environment/street_light/street_light_enum.dart';
// import 'load_images_cache.dart';
//
//
//
//
//
//
// class CityGridGame extends FlameGame {
//   static const double cellSize = 32.0;
//   static const int blockHeightCells = 7;
//   static const int gridRows = 4;
//   static const int gridCols = 4;
//   static const double gap = cellSize * 4;
//   static Vector2 roadLineSize = Vector2(38, 3);
//   static Vector2 crossWalkSize = Vector2(48, 104); // Size of the crosswalk
//
//   final List<Rect> crossWalkAreas = [];
//
//   @override
//   Future<void> onLoad() async {
//     super.onLoad();
//
//     await Flame.images.loadAll(loadImagesCache);
//
//     camera.viewport = FixedResolutionViewport(resolution: size);
//     camera.viewfinder.zoom = 0.25;
//
//     final List<BuildingType> tempBuildingTypes = [
//       BuildingType.building_2,
//       BuildingType.building_2,
//       BuildingType.building_3,
//       BuildingType.building_3,
//       BuildingType.building_4,
//     ];
//
//     double blockWidth = CityBlockComponent.calculateBlockSize(tempBuildingTypes).x;
//     double blockHeight = blockHeightCells * cellSize;
//
//     // Create a grid of components
//     for (int row = 0; row < gridRows; row++) {
//       for (int col = 0; col < gridCols; col++) {
//         double xPosition = (col * (blockWidth + (gap)));
//         double yPosition = (row * (blockHeight + gap));
//
//         // Add CityBlockComponent (now only for positioning purposes)
//         Vector2 cityBlockPosition = Vector2(xPosition, yPosition);
//
//         // Add SidewalkComponents
//         int blockWidthCells = (blockWidth / cellSize).ceil();
//         for (int y = 0; y < blockHeightCells; y++) {
//           for (int x = 0; x < blockWidthCells; x++) {
//             // world.add(SidewalkComponent(
//             //   position: Vector2(xPosition + (x * cellSize), yPosition + (y * cellSize)),
//             //   size: Vector2(cellSize, cellSize),
//             // ));
//           }
//         }
//
//         // Add StreetLights on the sides in the middle
//         int middleHeightCell = blockHeightCells ~/ 2;
//         world.add(StreetLightComponent(
//           position: Vector2(xPosition, yPosition + (middleHeightCell * cellSize)),
//           size: Vector2(cellSize, cellSize),
//           streetLightType: StreetLightType.street_light_left,
//         ));
//         world.add(StreetLightComponent(
//           position: Vector2(xPosition + ((blockWidthCells - 1) * cellSize) + 32, yPosition + (middleHeightCell * cellSize)),
//           size: Vector2(cellSize, cellSize),
//           streetLightType: StreetLightType.street_light_right,
//         ));
//
//         // Add StreetLights every 4th tile for the width, but avoid the corners
//         for (int x = 5; x < blockWidthCells - 5; x += 5) {
//           world.add(StreetLightComponent(
//             position: Vector2(xPosition + (x * cellSize), yPosition - 8),
//             size: Vector2(cellSize, cellSize),
//             streetLightType: StreetLightType.street_light_up,
//           ));
//           world.add(StreetLightComponent(
//             position: Vector2(xPosition + (x * cellSize), yPosition + ((blockHeightCells - 1) * cellSize) + 14),
//             size: Vector2(cellSize / 4, cellSize / 4),
//             streetLightType: StreetLightType.street_light_down,
//           ));
//         }
//
//         // // Add StopSigns at the corners
//         // world.add(StopSignComponent(
//         //   position: Vector2(xPosition, yPosition),
//         //   size: Vector2(cellSize, cellSize),
//         // ));
//         // world.add(StopSignComponent(
//         //   position: Vector2(xPosition + (blockWidthCells - 1) * cellSize, yPosition),
//         //   size: Vector2(cellSize, cellSize),
//         // ));
//         // world.add(StopSignComponent(
//         //   position: Vector2(xPosition, yPosition + (blockHeightCells - 1) * cellSize),
//         //   size: Vector2(cellSize, cellSize),
//         // ));
//         // world.add(StopSignComponent(
//         //   position: Vector2(xPosition + (blockWidthCells - 1) * cellSize, yPosition + (blockHeightCells - 1) * cellSize),
//         //   size: Vector2(cellSize, cellSize),
//         // ));
//
//         // Add Buildings based on building types
//         double totalWidth = blockWidth;
//         double requiredWidth = CityBlockComponent.calculateRequiredWidth(tempBuildingTypes);
//         double extraSpace = totalWidth - requiredWidth;
//         double sideGap = cellSize * 1.5;
//         if (extraSpace > 1.5 * cellSize) {
//           sideGap += extraSpace / 2;
//         }
//         double x = sideGap;
//         for (BuildingType type in tempBuildingTypes) {
//           Vector2 buildingSize = type.size;
//           world.add(BuildingComponent(
//             position: Vector2(
//               xPosition + x + buildingSize.x / 2,
//               yPosition + (blockHeightCells * cellSize) - (2 * cellSize),
//             ),
//             size: buildingSize,
//             buildingType: type,
//           ));
//           x += buildingSize.x + (CityBlockComponent.betweenBuildingGap * cellSize);
//         }
//
//         // Add CrossWalkComponent at the intersections
//         if (col < gridCols - 1 && row < gridRows - 1) {
//           double crossWalkX = xPosition + blockWidth + gap / 2;
//           double crossWalkY = yPosition + blockHeight + gap / 2;
//
//           // Add four crosswalks at each intersection
//           crossWalkAreas.add(Rect.fromLTWH(
//             crossWalkX - crossWalkSize.x - 4,
//             crossWalkY - gap / 2,
//             crossWalkSize.x,
//             crossWalkSize.y,
//           ));
//           crossWalkAreas.add(Rect.fromLTWH(
//             crossWalkX - crossWalkSize.x - 4,
//             crossWalkY + gap,
//             crossWalkSize.x,
//             crossWalkSize.y,
//           ));
//           crossWalkAreas.add(Rect.fromLTWH(
//             crossWalkX + gap / 2,
//             crossWalkY - crossWalkSize.y / 2,
//             crossWalkSize.x,
//             crossWalkSize.y,
//           ));
//           crossWalkAreas.add(Rect.fromLTWH(
//             crossWalkX - gap / 2 - crossWalkSize.x,
//             crossWalkY - crossWalkSize.y / 2,
//             crossWalkSize.x,
//             crossWalkSize.y,
//           ));
//
//           world.add(CrossWalkComponent(
//             position: Vector2(crossWalkX + gap / 2, crossWalkY - crossWalkSize.y / 2),
//             size: crossWalkSize,
//           ));
//           world.add(CrossWalkComponent(
//             position: Vector2(crossWalkX - gap / 2 - crossWalkSize.x / 1.5, crossWalkY - crossWalkSize.y / 2),
//             size: crossWalkSize,
//           ));
//         }
//
//         // Add RoadLineComponent between CityBlockComponents vertically
//         if (row < gridRows - 1) {
//           double startX = xPosition + roadLineSize.x;
//           double endX = xPosition + blockWidth - roadLineSize.x;
//
//           for (double x = startX; x <= endX; x += roadLineSize.x * 2) {
//             Vector2 roadLinePosition = Vector2(
//               x - roadLineSize.x / 2,
//               yPosition + blockHeight + gap / 2 - roadLineSize.y / 2,
//             );
//             if (!_overlapsWithCrosswalk(roadLinePosition, roadLineSize)) {
//               world.add(RoadLineComponent(
//                 position: roadLinePosition,
//                 size: roadLineSize,
//               ));
//             }
//           }
//         }
//
//         // Add RoadLineComponent between CityBlockComponents horizontally
//         if (col < gridCols - 1) {
//           double startY = yPosition + roadLineSize.x;
//           double endY = yPosition + blockHeight - roadLineSize.x;
//
//           for (double y = startY; y <= endY; y += roadLineSize.x * 2) {
//             Vector2 roadLinePosition = Vector2(
//               xPosition + blockWidth + gap / 2,
//               y + roadLineSize.x / 2,
//             );
//             if (!_overlapsWithCrosswalk(roadLinePosition, Vector2(roadLineSize.y, roadLineSize.x))) {
//               world.add(RoadLineComponent(
//                 position: roadLinePosition,
//                 size: Vector2(roadLineSize.y, roadLineSize.x),
//               ));
//             }
//           }
//         }
//       }
//     }
//   }
//
//   bool _overlapsWithCrosswalk(Vector2 position, Vector2 size) {
//     final roadLineRect = Rect.fromLTWH(position.x, position.y, size.x, size.y);
//     for (final crossWalkArea in crossWalkAreas) {
//       if (roadLineRect.overlaps(crossWalkArea)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
//
//
// // class CrossWalkComponent extends PositionComponent {
// //   CrossWalkComponent({required Vector2 position, required Vector2 size})
// //       : super(position: position, size: size);
// //
// //   @override
// //   void render(Canvas canvas) {
// //     super.render(canvas);
// //     final paint = Paint()..color = Colors.blue;
// //     canvas.drawRect(size.toRect(), paint);
// //   }
// // }
//
//
// // class SidewalkComponent extends PositionComponent {
// //   SidewalkComponent({required Vector2 position, required Vector2 size})
// //       : super(position: position, size: size);
// //
// //   @override
// //   void render(Canvas canvas) {
// //     super.render(canvas);
// //     final paint = Paint()..color = Colors.grey;
// //     canvas.drawRect(size.toRect(), paint);
// //   }
// // }
//
//
//
