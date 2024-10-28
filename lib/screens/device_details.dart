import 'package:energy_monitoring_app/widgets/global_error_listener.dart';
import 'package:energy_monitoring_app/widgets/window_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/device_type.dart';
import '../providers/device_provider.dart';
import '../widgets/air_condition_widget.dart';
import '../widgets/custom_back_button.dart';
import '../widgets/main_light_widget.dart';

class DeviceDetailScreen extends StatelessWidget {
  final int deviceIndex;

  DeviceDetailScreen({required this.deviceIndex});

  @override
  Widget build(BuildContext context) {

    final deviceProvider = Provider.of<DeviceProvider>(context);
    final device = deviceProvider.devices[deviceIndex];
    return GlobalErrorListener(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFCCE5E5),
          title: Text(
            'Living room',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: CustomBackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Color(0xFFEDE9F5),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 58.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25))
              ),
              width: 460,
              child: Column(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60,),
                        // Display the correct widget based on the device type
                        if (device.type == DeviceType.mainLight) MainLightWidget(device: device),
                        if (device.type == DeviceType.airCondition) AirConditionWidget(device: device),
                        if(device.type == DeviceType.window) WindowWidget(device: device)
      
                      ],
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
