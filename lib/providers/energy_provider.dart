import 'dart:async';
import 'package:flutter/material.dart';
import '../services/eWelinkService.dart';

class EnergyProvider with ChangeNotifier {
  final EwelinkService _ewelinkService;

  double _todayConsumption = 0.0;
  double _monthlyConsumption = 0.0;

  Timer? _timer;

  EnergyProvider(this._ewelinkService) {
    _startPeriodicFetch();
  }

  double get todayConsumption => _todayConsumption;
  double get monthlyConsumption => _monthlyConsumption;

  Future<void> fetchEnergyConsumption() async {
    try {
      final response = await _ewelinkService.fetchEnergyConsumption();

      double consumption = response?['today'] as double? ?? 0.0;
      _todayConsumption = consumption;
      _monthlyConsumption = consumption * 30;

      notifyListeners();
    } catch (error) {
      print('Error fetching energy data: $error');
    }
  }

  void _startPeriodicFetch() {
    _timer = Timer.periodic(Duration(hours: 1), (timer) => fetchEnergyConsumption());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
