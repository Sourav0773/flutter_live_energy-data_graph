import 'package:flutter/material.dart';
import 'package:stream_builder/SCREENS/HISTORY_SCREEN/HistoryScreenWidget/energyTile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => HistoryScreenState();
}

class HistoryScreenState extends State<HistoryScreen> {
  // Mock data for demonstration
  final List<Map<String, dynamic>> historyData = List.generate(
    10,
    (index) => {
      "serial": index + 1,
      "timestamp": DateTime.now().subtract(Duration(minutes: index * 3)),
      "value": (15 + index * 7).toStringAsFixed(1), // e.g., "15.0", "22.0"...
      "isLow": index % 3 == 0, // Randomly mark some as "LOW"
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy History'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        toolbarHeight: 70,
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width * 0.93,
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: ListView.builder(
          itemCount: historyData.length,
          itemBuilder: (context, index) {
            final item = historyData[index];
            return EnergyHistoryTile(
              serialNumber: item['serial'],
              timestamp: item['timestamp'],
              value: item['value'],
              isLow: item['isLow'],
            );
          },
        ),
      ),
    );
  }
}
