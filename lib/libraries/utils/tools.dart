import 'dart:math';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../libraries/bonfire_help/direction.dart';

class Tools {

  static Uuid uuid = Uuid();
  //---------------------------------------------
  static final random = Random();
  static int randomRange(int min, int max) {
    return min + random.nextInt(max - min);
  }
  //---------------------------------------------

  static const PI_180 = (180 / pi);

  static double angleBetweenPoints(Vector2 p1, Vector2 p2) {
  return atan2(p2.y - p1.y, p2.x - p1.x);
  }

  static double angleBasedOnVelocity(Vector2 velocity) {
    double angle = atan2(velocity.y, velocity.x);
    return angle;
  }



  static Offset rotatePoint(Offset point, double angle, Offset center) {
  final s = sin(angle);
  final c = cos(angle);

  double x1 = point.dx - center.dx;
  double y1 = point.dy - center.dy;

  double x2 = x1 * c - y1 * s;
  double y2 = x1 * s + y1 * c;

  return Offset(x2 + center.dx, y2 + center.dy);
  }

  static Vector2 movePointByAngle(
  Vector2 point,
  double speed,
  double angle,
  ) {
  double nextX = speed * cos(angle);
  double nextY = speed * sin(angle);
  return Vector2(point.x + nextX, point.y + nextY);
  }



  static Vector2 diffMovePointByAngle(
  Vector2 point,
  double speed,
  double angle,
  ) {
  return movePointByAngle(point, speed, angle) - point;
  }


  Vector2 getDirectionByAngle(double angleRadians) {
    double x = cos(angleRadians);
    double y = sin(angleRadians);
    return Vector2(x, y);
  }

  static Vector2 vector2ByAngle(double angle, {double intensity = 1}) {
    var x = cos(angle) * intensity;
    var y = sin(angle) * intensity;
    if (x.abs() < 0.01) {
      x = 0;
    }
    if (y.abs() < 0.01) {
      y = 0;
    }
    return Vector2(x, y);
  }





  static moveFromAngle(double angle, {double? speed}) {
    var lastSpeed = 80.0;
    //lastSpeed = speed ?? this.speed;
    var velocity = vector2ByAngle(angle, intensity: lastSpeed);
    return velocity;
  }



  static bool probabilityBoolean(double probability){
    bool result = random.nextDouble() <= probability; //Gives a chance of 70% to get True result if the probability variable is 0.7
    return result;
  }



  static String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }


  static String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$secondsString';
  }


  static String itemTypeForUI(String type){
    var uiVal = type.split('.');
    return uiVal[1];
  }





static Direction getDirectionFromAngle(double angle) {
    double degrees = (angle - 1.5) * 180 / pi;

    if (degrees > -22.5 && degrees <= 22.5) {
      return Direction.right;
    }

    if (degrees > 22.5 && degrees <= 67.5) {
      return Direction.downRight;
    }

    if (degrees > 67.5 && degrees <= 112.5) {
      return Direction.down;
    }

    if (degrees > 112.5 && degrees <= 157.5) {
      return Direction.downLeft;
    }

    if ((degrees > 157.5 && degrees <= 180) ||
        (degrees >= -180 && degrees <= -157.5)) {
      return Direction.left;
    }

    if (degrees > -157.5 && degrees <= -112.5) {
      return Direction.upLeft;
    }

    if (degrees > -112.5 && degrees <= -67.5) {
      return Direction.up;
    }

    if (degrees > -67.5 && degrees <= -22.5) {
      return Direction.upRight;
    }
    return Direction.left;
  }


  static Vector2 getRandomVector2WithinRadius(Vector2 center, double radius, [Random? rng]) {
    rng ??= Random();
    double angle = 2 * pi * rng.nextDouble();  // Random angle
    double r = sqrt(rng.nextDouble()) * radius;  // Random radius, sqrt for uniform distribution

    // Convert polar coordinates to Cartesian coordinates
    double x = r * cos(angle);
    double y = r * sin(angle);

    // Create the random point as an offset from the center
    return Vector2(center.x + x, center.y + y);
  }


  static bool isPointWithinScaledBounds(Vector2 point, Vector2 origin, Vector2 size, Vector2 scale) {
    // Calculate scaled size
    Vector2 scaledSize = Vector2(size.x * scale.x, size.y * scale.y);

    // Check if the point is within the scaled bounds
    return point.x >= origin.x &&
        point.x <= origin.x + scaledSize.x &&
        point.y >= origin.y &&
        point.y <= origin.y + scaledSize.y;
  }


  static double getAngleFromVector2(Vector2 vector) {
    return atan2(vector.y, vector.x) ;
  }

// static double getAngleFromDirection(Direction direction) {
  //   switch (direction) {
  //     case Direction.left:
  //       return 180 / PI_180;
  //     case Direction.right:
  //     // we can't use 0 here because then no bonfire_help happens
  //     // we're just going as close to 0.0 without being exactly 0.0
  //     // if you have a better idea. Please be my guest
  //       return 0.0000001 / PI_180;
  //     case Direction.up:
  //       return -90 / PI_180;
  //     case Direction.down:
  //       return 90 / PI_180;
  //     case Direction.upLeft:
  //       return -135 / PI_180;
  //     case Direction.upRight:
  //       return -45 / PI_180;
  //     case Direction.downLeft:
  //       return 135 / PI_180;
  //     case Direction.downRight:
  //       return 45 / PI_180;
  //     default:
  //       return 0;
  //   }
  // }


}



