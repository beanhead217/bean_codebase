
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

final double physicalHeight = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.height;
final double physicalWidth = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;
final double devicePixelRatio = WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;
final double getHeight = physicalHeight / devicePixelRatio;
final double getWidth = physicalWidth / devicePixelRatio;


double relativeValue = 16.0;
double mapWidth = 1000;
double mapHeight = 1000;


