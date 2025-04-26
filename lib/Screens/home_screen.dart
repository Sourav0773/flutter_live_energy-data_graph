import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stream_builder/Screens/history_screen.dart';
import 'package:stream_builder/Widgets/energy_graph.dart';
import 'package:stream_builder/Provider/web_socket_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WebSocketProvider>(context);
    final data = provider.latestData;

    if (data == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.teal)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('IOT Energy Graph'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        toolbarHeight: 70,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            EnergyLineChart(
              spots: provider.spots
                  .map((e) => FlSpot(e['x']!, e['y']!))
                  .toList(),
              xMin: provider.xMin,
              xMax: provider.xMax,
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
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Value: ${data.value} kWh",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: data.value.toDouble() < 30
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 130),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      HistoryScreen(history: provider.history),
                ),
              ),
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.teal,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 106, 105, 105),
                      offset: Offset(3, 5),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Energy History',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
      ),
    );
  }
}
