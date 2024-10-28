import 'package:flutter/material.dart';
import '../widgets/room_card.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/global_error_listener.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlobalErrorListener(
      child: Scaffold(
        backgroundColor: Color(0xFFEDE9F5),
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
                          icon: Icons.chair,
                          color: Color(0xFFCCE5E5),
                          roomName: 'Living Room',
                          deviceStatus: '3/5 devices ON',
                          temperature: '25°',
                          onTap: () {
                            Navigator.pushNamed(context, '/roomDetails');
                          },
                        ),
                        RoomCard(
                          icon: Icons.bathtub,
                          color: Color(0xFFE2D4F2),
                          roomName: 'Bathroom',
                          deviceStatus: '1/3 devices ON',
                          temperature: '21°',
                          onTap: () {
                            Navigator.pushNamed(context, '/roomDetails');
                          },
                        ),
                        RoomCard(
                          icon: Icons.bed,
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
        bottomNavigationBar: CustomBottomNavigationBar(
          onTap: (index) {
            if (index == 1) {
              // Open add room or center button action
            }
          },
        ),
      ),
    );
  }
}
