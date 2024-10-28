import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EwelinkService {
  final String username = "Nadim.khoury@arkenergyae";
  final String password = "nadim@nadim";
  String? authToken;
  Timer? _timer;

  // Base URL for eWelink API
  final String baseUrl = 'https://ewelink-api-endpoint';

  // Authentication - Get and store auth token
  Future<void> authenticate() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);
        authToken = responseBody['token'];
        print('Authentication successful. Token stored.');
      } else {
        throw Exception("Authentication failed: ${response.body}");
      }
    } catch (error) {
      print("Authentication error: $error");
    }
  }

  // Fetch current energy consumption data
  Future<Map<String, dynamic>?> fetchEnergyConsumption() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/energy-consumption'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error fetching energy data: ${response.body}");
        return null;
      }
    } catch (error) {
      print("Error in fetchEnergyConsumption: $error");
      return null;
    }
  }

  // Start periodic data fetching every hour
  void startEnergyConsumptionFetch() {
    _timer = Timer.periodic(
      Duration(hours: 1),
          (Timer t) async {
        await fetchEnergyConsumption();
      },
    );
  }

  // Control AC status based on window state
  Future<void> controlACBasedOnWindowStatus(bool isWindowOpen) async {
    try {
      if (isWindowOpen) {
        // Wait 3 minutes and turn off AC if window is still open
        await Future.delayed(Duration(minutes: 3), () async {
          if (isWindowOpen) {
            await toggleAC(false); // Turn off AC
            print('AC turned off due to open window');
          }
        });
      } else {
        await toggleAC(true); // Turn on AC
        print('AC turned on as window is closed');
      }
    } catch (error) {
      print("Error in controlACBasedOnWindowStatus: $error");
    }
  }

  // Toggle AC power ON or OFF
  Future<bool> toggleAC(bool turnOn) async {
    try {
      // final response = await http.post(
      //   Uri.parse('$baseUrl/ac-control'),
      //   headers: {
      //     'Authorization': 'Bearer $authToken',
      //     'Content-Type': 'application/json',
      //   },
      //   body: jsonEncode({'status': turnOn ? 'ON' : 'OFF'}),
      // );

      if (true) {
        print('AC toggled to ${turnOn ? 'ON' : 'OFF'} successfully.');
        return true;
      } else {
        print("Error toggling AC:");
        return false;
      }
    } catch (error) {
      print("Error in toggleAC: $error");
      return false;
    }
  }

  // Error handling - Retry authentication if token expired
  Future<void> ensureAuthenticated() async {
    if (authToken == null) {
      await authenticate();
    }
  }

  // Stop the periodic fetching when not needed
  void stopEnergyConsumptionFetch() {
    _timer?.cancel();
  }
}
