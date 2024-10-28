import 'package:flutter/material.dart';

enum DeviceType {
  mainLight,
  airCondition,
  window,
}

class Device {
  final String name;
  final DeviceType type;

  // Properties for lights
  Color? color; // Light color
  double? intensity; // Light intensity, value between 0.0 and 1.0

  // Properties for devices with modes (e.g., Air Condition, Fan)
  Map<String, bool>? modes; // Mode toggles, e.g., Reading, Timer

  // Property for temperature (used by devices like Air Condition)
  int? temperature;

  // Properties specific to the window device
  bool? isOpen; // Window open/close status
  int? timerDuration; // Duration (in minutes) for auto-closing the window

  Device({
    required this.name,
    required this.type,
    this.color,
    this.intensity,
    this.modes,
    this.temperature,
    this.isOpen,
    this.timerDuration,
  });
}
