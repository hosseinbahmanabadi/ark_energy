import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device_type.dart';
import '../providers/device_provider.dart';

class WindowWidget extends StatelessWidget {
  final Device device;

  WindowWidget({required this.device});

  @override
  Widget build(BuildContext context) {
    final deviceProvider = Provider.of<DeviceProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFCCE5E5),
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Color(0xFF131313)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF131313),
                  offset: Offset(5, 4),
                ),
              ],
            ),
            child: Text(
              'Window',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Window Status Display
        Text(
          'Window Status: ${device.isOpen == true ? "Open" : "Closed"}',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Manual Open/Close Control
        _buildToggleRow(
          context,
          deviceProvider,
          Icons.sensor_window,
          'Window',
          device.isOpen ?? false,
              () => deviceProvider.toggleWindow(device),
        ),
        const SizedBox(height: 24),

        // Timer Duration Setting
        Text(
          'Auto-Close Timer (minutes)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                if ((device.timerDuration ?? 1) > 1) {
                  device.timerDuration = (device.timerDuration ?? 1) - 1;
                }
              },
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${device.timerDuration ?? 3}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                device.timerDuration = (device.timerDuration ?? 3) + 1;
              },
            ),
          ],
        ),
      ],
    );
  }
  Widget _buildToggleRow(
      BuildContext context,
      DeviceProvider deviceProvider,
      IconData icon,
      String label,
      bool value,
      VoidCallback onChanged,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Switch(
          value: value,
          onChanged: (_) => onChanged(),
        ),
      ],
    );
  }
}
