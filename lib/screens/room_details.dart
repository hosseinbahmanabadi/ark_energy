import 'package:energy_monitoring_app/models/device_type.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/device_provider.dart';
import '../widgets/custom_back_button.dart';

class RoomDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE9F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFCCE5E5),
        leading: CustomBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 460, // Centered container width
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(5, 5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Monthly expenses',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: 178 / 500,
                              backgroundColor: Colors.grey[300],
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFFED85D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () {
                              // See all expenses logic
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$178'),
                          Text('\$500'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Room Tabs
                Wrap(
                  spacing: 8.0,
                  children: [
                    _buildRoomTab(context, 'Living room', true),
                    _buildRoomTab(context, 'Bathroom', false),
                    _buildRoomTab(context, 'Kitchen', false),
                    _buildRoomTab(context, 'Bedroom', false),
                  ],
                ),
                const SizedBox(height: 24),

                // Device Cards
                // Device Cards from Provider
                Consumer<DeviceProvider>(
                  builder: (context, deviceProvider, child) {
                    return Wrap(
                      spacing: 16.0,
                      runSpacing: 16.0,
                      children: deviceProvider.devices.map((device) {
                        // Determine the status and usage based on device properties
                        String status = _getDeviceStatus(device);
                        String usage = _getDeviceUsage(device);

                        return DeviceCard(
                          icon: _getDeviceIcon(device.type),
                          color: _getDeviceColor(device.type),
                          deviceName: device.name,
                          status: status,
                          usage: usage,
                          deviceIndex: device.type.index,
                        );
                      }).toList(),
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Add Device Button
                Center(
                  child: FloatingActionButton(
                    onPressed: () {
                      // Add device logic
                    },
                    backgroundColor: Color(0xFFFED85D),
                    child: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function to get the icon for each device type
  IconData _getDeviceIcon(DeviceType type) {
    switch (type) {
      case DeviceType.mainLight:
        return Icons.lightbulb_outline;
      case DeviceType.airCondition:
        return Icons.ac_unit;
      case DeviceType.window:
        return Icons.sensor_window;
      default:
        return Icons.device_unknown;
    }
  }

  // Helper function to get color for each device type
  Color _getDeviceColor(DeviceType type) {
    switch (type) {
      case DeviceType.mainLight:
        return Color(0xFFCCE5E5);
      case DeviceType.airCondition:
        return Color(0xFFFEDBB1);
      case DeviceType.window:
        return Color(0xFFFED1D7);
      default:
        return Colors.grey;
    }
  }

  // Helper function to get the status for each device
  String _getDeviceStatus(Device device) {
    switch (device.type) {
      case DeviceType.mainLight:
        return device.modes?['ON/OFF'] ?? false ? 'ON' : 'OFF';
      case DeviceType.airCondition:
        return device.modes?['ON/OFF'] ?? false ? 'ON' : 'OFF';
      case DeviceType.window:
        return device.isOpen == true ? 'Open' : 'Close';
      default:
        return 'Unknown';
    }
  }

  // Helper function to get usage or other details for each device
  String _getDeviceUsage(Device device) {
    if (device.type == DeviceType.mainLight || device.type == DeviceType.airCondition) {
      return '${(device.intensity ?? 0.0) * 100}%';
    }
    return ''; // No usage for window or other devices
  }

  // Helper widget for building room tabs
  Widget _buildRoomTab(BuildContext context, String roomName, bool isSelected) {
    return ChoiceChip(
      label: Text(roomName),
      selected: isSelected,
      selectedColor: Colors.black,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
      onSelected: (selected) {
        // Handle room tab switch
      },
    );
  }
}

// Device Card Widget
class DeviceCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String deviceName;
  final String status;
  final String usage;
  final int deviceIndex;


  const DeviceCard({super.key,
    required this.icon,
    required this.color,
    required this.deviceName,
    required this.status,
    required this.usage,
    required this.deviceIndex,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          '/deviceDetail',
          arguments: deviceIndex, // Pass the appropriate device type here
        );
      },
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset(5, 5),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon and Color Background
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.black),
            ),
            const SizedBox(height: 16),
            // Device Name and Status
            Text(
              deviceName,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (status == 'ON' || status == 'Open') ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  usage,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
