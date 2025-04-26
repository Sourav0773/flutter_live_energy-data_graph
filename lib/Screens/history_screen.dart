import 'package:flutter/material.dart';
import 'package:stream_builder/Widgets/energyTile.dart';
import 'package:stream_builder/Model/data_model.dart';

class HistoryScreen extends StatelessWidget {
  final List<DataModel> history;

  const HistoryScreen({super.key, required this.history});

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
          itemCount: history.length,
          itemBuilder: (context, index) {
            final item = history.reversed.toList()[index]; // Show newest on top
            final value = double.tryParse(item.value.toString()) ?? 0;
            final istTime = item.timestamp.add(const Duration(hours: 5, minutes: 30)); 

            return EnergyHistoryTile(
              serialNumber: index + 1,
              timestamp: istTime,
              value: item.value.toString(),
              isLow: value < 30,
            );
          },
        ),
      ),
    );
  }
}
