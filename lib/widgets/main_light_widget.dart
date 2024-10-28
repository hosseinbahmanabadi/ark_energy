import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device_type.dart';
import '../providers/device_provider.dart';

class MainLightWidget extends StatelessWidget {
  final Device device;

  MainLightWidget({required this.device});

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
              'Main Light',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Color selection (only if color property is available)
        if (device.color != null) ...[
          Text(
            'Color',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildColorButton(context, Colors.purple[100]!, device),
              _buildColorButton(context, Colors.teal[100]!, device),
              _buildColorButton(context, Colors.yellow[100]!, device),
              _buildColorButton(context, Colors.red[100]!, device),
              _buildColorButton(context, Colors.green[100]!, device),
              _buildColorButton(context, Colors.orange[100]!, device),
            ],
          ),
          const SizedBox(height: 24),
        ],

        const SizedBox(height: 24),
        _buildToggleRow(context, deviceProvider, Icons.power_settings_new, 'ON/OFF'),
        const SizedBox(height: 24),


        // Intensity slider (only if intensity property is available)
        if (device.intensity != null) ...[
          Row(
            children: [
              Icon(Icons.tune, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                'Intensity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Slider(
            value: device.intensity ?? 0.5,
            onChanged: (value) {
              deviceProvider.updateIntensity(device, value);
            },
            activeColor: Colors.black,
            inactiveColor: Colors.grey[300],
          ),
          const SizedBox(height: 24),
        ],

        // Mode buttons (only if modes are defined)
        if (device.modes != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildModeButton(context, deviceProvider, 'Reading', device.modes?['Reading'] ?? false, device),
              const SizedBox(width: 16),
              _buildModeButton(context, deviceProvider, 'Timer', device.modes?['Timer'] ?? false, device),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildColorButton(BuildContext context, Color color, Device device) {
    final deviceProvider = Provider.of<DeviceProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        deviceProvider.updateColor(device, color);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: device.color == color ? Colors.black : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, DeviceProvider deviceProvider, String label, bool isSelected, Device device) {
    return GestureDetector(
      onTap: () {
        // Toggle mode without passing `!isSelected` since the provider handles toggling
        deviceProvider.toggleMode(device, label);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
