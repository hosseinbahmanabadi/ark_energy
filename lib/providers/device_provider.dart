import 'dart:async';
import 'package:flutter/material.dart';
import '../models/device_type.dart';
import '../services/eWelinkService.dart';

class DeviceProvider with ChangeNotifier {
  final EwelinkService _ewelinkService;
  List<Device> _devices = [
    Device(
      name: 'Main Light',
      type: DeviceType.mainLight,
      color: Colors.white,
      intensity: 0.5,
      modes: {
        'Reading': false,
        'Timer': false,
        'ON/OFF': false,
      },
    ),
    Device(
      name: 'Air Condition',
      type: DeviceType.airCondition,
      temperature: 23,
      modes: {
        'ON/OFF': false,
        'Dry': false,
        'Cool': false,
        'Heat': false,
        'Eco mode': false,
      },
    ),
    Device(
      name: 'Window',
      type: DeviceType.window,
      isOpen: false,
      timerDuration: 3,
    ),
  ];

  List<Device> get devices => _devices;
  Timer? _windowTimer;
  Timer? _windowMonitorTimer;
  bool _isAcOn = true;

  DeviceProvider(this._ewelinkService) {
    _monitorWindowStatus();
  }

  // Color and Intensity Management for Lights
  void updateColor(Device device, Color color) {
    if (device.type == DeviceType.mainLight) {
      device.color = color;
      notifyListeners();
    }
  }

  void updateIntensity(Device device, double intensity) {
    if (device.type == DeviceType.mainLight) {
      device.intensity = intensity;
      notifyListeners();
    }
  }

  // Temperature Management for AC
  void updateTemperature(Device device, int newTemperature) {
    if (device.type == DeviceType.airCondition) {
      device.temperature = newTemperature;
      notifyListeners();
    }
  }

  // Mode Toggles for AC and Lights
  void toggleMode(Device device, String mode) {
    if (device.modes?.containsKey(mode) ?? false) {
      device.modes![mode] = !device.modes![mode]!;
      notifyListeners();
    }
  }

  // Window Open/Close Logic with Timer
  void toggleWindow(Device device) {
    if (device.type == DeviceType.window) {
      device.isOpen = !(device.isOpen ?? false);
      notifyListeners();
    }
  }

  void openWindow(Device device) {
    if (device.type == DeviceType.window) {
      device.isOpen = true;
      _startWindowTimer(device);
      notifyListeners();
    }
  }

  void closeWindow(Device device) {
    if (device.type == DeviceType.window) {
      device.isOpen = false;
      _cancelWindowTimer();
      notifyListeners();
    }
  }

  // Toggle on/off for AC or Main Light
  Future<void> toggleDeviceStatus(Device device, bool turnOn) async {
    if (device.type == DeviceType.airCondition) {
      bool success = await _ewelinkService.toggleAC(turnOn);
      if (success) {
        _isAcOn = turnOn;
        device.modes?['ON/OFF'] = turnOn;
        notifyListeners();
      }
    }
  }

  // Automated Window Monitoring
  void _monitorWindowStatus() {
    _windowMonitorTimer = Timer.periodic(Duration(minutes: 1), (timer) async {
      final window = _devices.firstWhere((device) => device.type == DeviceType.window);
      if (window.isOpen==true) {
        await toggleDeviceStatus(_devices.firstWhere((device) => device.type == DeviceType.airCondition), false);
      } else if (!_isAcOn) {
        await toggleDeviceStatus(_devices.firstWhere((device) => device.type == DeviceType.airCondition), true);
      }
    });
  }

  void _startWindowTimer(Device device) {
    _cancelWindowTimer();
    int duration = device.timerDuration ?? 3;
    _windowTimer = Timer(Duration(minutes: duration), () {
      closeWindow(device);
    });
  }

  void _cancelWindowTimer() {
    _windowTimer?.cancel();
    _windowTimer = null;
  }

  @override
  void dispose() {
    _cancelWindowTimer();
    _windowMonitorTimer?.cancel();
    super.dispose();
  }
}
