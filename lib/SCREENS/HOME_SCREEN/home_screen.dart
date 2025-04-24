import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:stream_builder/SCREENS/HISTORY_SCREEN/energy_history_screen.dart';
import 'package:stream_builder/WEBSOCKET_API/websocket_service.dart';
import 'package:stream_builder/WEBSOCKET_MODEL/data_model.dart';
import 'package:stream_builder/SCREENS/HOME_SCREEN/HomeScreenWidgets/energy_line_chart.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final List<FlSpot> spots = [];
  double xValue = 0;
  final double windowSize = 10;

  double get xMin => xValue > windowSize ? xValue - windowSize : 0;
  double get xMax => xValue;

  void addNewDataPoint(double yValue) {
    xValue += 1;
    spots.add(FlSpot(xValue, yValue));
    // Remove old data points
    spots.removeWhere((spot) => spot.x < xMin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IOT Energy Graph'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        toolbarHeight: 70,
      ),
      body: StreamBuilder(
        stream: webSocket.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            try {
              final raw = snapshot.data.toString();
              final decoded = jsonDecode(raw);
              final data = DataModel.fromJson(decoded);
              final y = double.tryParse(data.value.toString());

              if (y != null) {
                addNewDataPoint(y);
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    //from energy_line_chart.dart
                    EnergyLineChart(
                      spots: spots,
                      xMin: xMin,
                      xMax: xMax,
                    ),
                    const SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date & Time: ${data.timestamp.toLocal()}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0)
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Value: ${data.value} kWh",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: data.value.toDouble() < 30 ? Colors.red : Colors.green,
                          ),
                        ),
                      ]
                    ),
                    SizedBox(height: 130),
                    GestureDetector(
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                                      const HistoryScreen(),
                            ),
                          ),
                      child: Container(
                        height: 70,
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.teal,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              offset: Offset(4, 5),
                              blurRadius: 8
                            )
                          ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Energy History',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(width: 15),
                            Icon(Icons.history, color: Colors.white, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } catch (_) {
              return const Center(child: Text('Error parsing data'));
            }
          }

          return const Center(
            child: CircularProgressIndicator(color: Colors.teal),
          );
        },
      ),
    );
  }
}
