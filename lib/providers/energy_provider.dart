import 'dart:async';
import 'package:flutter/material.dart';
import '../services/eWelinkService.dart';

class EnergyProvider with ChangeNotifier {
  final EwelinkService _ewelinkService;
  double _todayConsumption = 0.0;
  double _monthlyConsumption = 0.0;
  String? _error; // Store error message

  Timer? _timer;

  EnergyProvider(this._ewelinkService) {
    _startPeriodicFetch();
  }

  double get todayConsumption => _todayConsumption;
  double get monthlyConsumption => _monthlyConsumption;
  String? get error => _error;

  Future<void> fetchEnergyConsumption() async {
    try {
      final response = await _ewelinkService.fetchEnergyConsumption();
      double consumption = response?['today'] as double? ?? 0.0;
      _todayConsumption = consumption;
      _monthlyConsumption = consumption * 30;
      _error = null; // Clear error if successful
    } catch (error) {
      _error = error.toString();
      print(_error); // Log error to console
    }
    notifyListeners();
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(hours: 1), (timer) => fetchEnergyConsumption());
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
