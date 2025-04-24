import 'package:flutter/material.dart';
import 'package:stream_builder/SCREENS/HOME_SCREEN/home_screen.dart';

void main() {
  runApp(IOTEnergyMonitoringApp());
}

class IOTEnergyMonitoringApp extends StatelessWidget {
  const IOTEnergyMonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
