import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE9F5), // Background color from the design
      appBar: AppBar(
        backgroundColor: Color(0xFFCCE5E5),
        elevation: 0,
        title: Text(
          'My rooms',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Center(
          child: SizedBox(
            width: 460,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      RoomCard(
                        icon: Icons.chair, // Placeholder, replace with image assets if available
                        color: Color(0xFFCCE5E5),
                        roomName: 'Living Room',
                        deviceStatus: '3/5 devices ON',
                        temperature: '25°',
                        onTap: () {
                          Navigator.pushNamed(context, '/roomDetails');
                        },
                      ),
                      RoomCard(
                        icon: Icons.bathtub, // Placeholder, replace with image assets if available
                        color: Color(0xFFE2D4F2),
                        roomName: 'Bathroom',
                        deviceStatus: '1/3 devices ON',
                        temperature: '21°',
                        onTap: () {
                          Navigator.pushNamed(context, '/roomDetails');
                        },
                      ),
                      RoomCard(
                        icon: Icons.bed, // Placeholder, replace with image assets if available
                        color: Color(0xFFF6E3B8),
                        roomName: 'Bedroom',
                        deviceStatus: '1/5 devices ON',
                        temperature: '22°',
                        onTap: () {
                          Navigator.pushNamed(context, '/roomDetails');
                        },
                      ),
                    ],
                  ),
                ),
                // Add Room Button
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFED85D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15),
                        shadowColor: Colors.black,
                        elevation: 4,
                      ),
                      onPressed: () {
                        // Add room logic here
                      },
                      child: Text(
                        '+ Add room',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFCCE5E5),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle, size: 40),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Members',
          ),
        ],
        onTap: (index) {
          // Handle bottom navigation tap
          if (index == 1) {
            // Open add room or center button action
          }
        },
      ),
    );
  }
}

class RoomCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String roomName;
  final String deviceStatus;
  final String temperature;
  final VoidCallback onTap;

  const RoomCard({
    required this.icon,
    required this.color,
    required this.roomName,
    required this.deviceStatus,
    required this.temperature,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
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
        child: Row(
          children: [
            // Icon section
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                size: 40,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 16),
            // Details section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    roomName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    deviceStatus,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            // Temperature display
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                temperature,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
