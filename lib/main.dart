import 'package:energy_monitoring_app/providers/energy_provider.dart';
import 'package:energy_monitoring_app/services/eWelinkService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/auth_status.dart';
import 'providers/device_provider.dart';
import 'providers/auth_provider.dart';
import 'screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/room_details.dart';
import 'screens/device_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ewelinkService = EwelinkService();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()..checkLoginStatus()), // Check login status on app start
        ChangeNotifierProvider(create: (_) => DeviceProvider(ewelinkService)),
        ChangeNotifierProvider(create: (_) => EnergyProvider(ewelinkService)), // Directly provide EnergyProvider
      ],
      child: ArkEnergyApp(),
    ),
  );
}

class ArkEnergyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ark Energy',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          // Set initial screen based on login status
          initialRoute: authProvider.status == AuthStatus.authenticated ? '/home' : '/',
          routes: {
            '/': (context) => WelcomeScreen(),
            '/home': (context) => HomeScreen(),
            '/roomDetails': (context) => RoomDetailsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/deviceDetail') {
              final deviceIndex = settings.arguments as int;
              return MaterialPageRoute(
                builder: (context) => DeviceDetailScreen(deviceIndex: deviceIndex),
              );
            }
            return null;
          },
        );
      },
    );
  }
}
