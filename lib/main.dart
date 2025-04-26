import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_builder/Provider/web_socket_provider.dart';
import 'package:stream_builder/Screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => WebSocketProvider()),
      ],
      child: const IOTEnergyMonitoringApp(),
    ),
  );
}

class IOTEnergyMonitoringApp extends StatelessWidget {
  const IOTEnergyMonitoringApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
