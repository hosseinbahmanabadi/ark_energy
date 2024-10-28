import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/device_provider.dart';
import '../providers/energy_provider.dart';

class GlobalErrorListener extends StatelessWidget {
  final Widget child;

  GlobalErrorListener({required this.child});

  @override
  Widget build(BuildContext context) {
    // Wrap child in a Stack so that dialogs are triggered independently
    return Stack(
      children: [
        child, // Main widget content

        // DeviceProvider Error Listener
        Consumer<DeviceProvider>(
          builder: (context, deviceProvider, _) {
            if (deviceProvider.error != null) {
              // Trigger error dialog using Future.microtask to avoid build cycle issues
              Future.microtask(() {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(deviceProvider.error!),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          deviceProvider.clearError(); // Clear error after displaying
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              });
            }
            return SizedBox.shrink(); // Empty widget if no error
          },
        ),

        // EnergyProvider Error Listener
        Consumer<EnergyProvider>(
          builder: (context, energyProvider, _) {
            if (energyProvider.error != null) {
              Future.microtask(() {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Error'),
                    content: Text(energyProvider.error!),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          energyProvider.clearError(); // Clear error after displaying
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              });
            }
            return SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
