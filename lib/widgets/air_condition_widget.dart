import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device_type.dart';
import '../providers/device_provider.dart';

class AirConditionWidget extends StatelessWidget {
  final Device device;

  AirConditionWidget({required this.device});

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
              color: Color(0xFFFED85D),
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
              'Air Condition',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Temperature control (only if temperature is available)
        if (device.temperature != null) ...[
          Text(
            'Temperature',
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
                  if ((device.temperature ?? 0) > 0) {
                    deviceProvider.updateTemperature(device, (device.temperature ?? 0) - 1);
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
                  '${device.temperature}', // Display temperature value from provider
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  deviceProvider.updateTemperature(device, (device.temperature ?? 0) + 1);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],

        // Mode toggles (only if modes are defined)
        if (device.modes != null) ...[
          _buildToggleRow(context, deviceProvider, Icons.power_settings_new, 'ON/OFF'),
          _buildToggleRow(context, deviceProvider, Icons.water_drop, 'Dry'),
          _buildToggleRow(context, deviceProvider, Icons.ac_unit, 'Cool'),
          _buildToggleRow(context, deviceProvider, Icons.local_fire_department, 'Heat'),
          _buildToggleRow(context, deviceProvider, Icons.recycling, 'Eco mode'),
        ],
      ],
    );
  }

  Widget _buildToggleRow(
      BuildContext context,
      DeviceProvider deviceProvider,
      IconData icon,
      String label,
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
          value: device.modes?[label] ?? false,
          onChanged: (value) {
            deviceProvider.toggleMode(device, label);
          },
        ),
      ],
    );
  }
}
