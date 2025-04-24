import 'package:flutter/material.dart';

class EnergyHistoryTile extends StatelessWidget {
  final int serialNumber;
  final DateTime timestamp;
  final String value; // in kWh
  final bool isLow;

  const EnergyHistoryTile({
    super.key,
    required this.serialNumber,
    required this.timestamp,
    required this.value,
    required this.isLow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE6E3E3), width: 1.5),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Serial Box
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: const Color(0xFFE5E2E2),
            ),
            child: Center(
              child: Text(
                serialNumber.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 20),

          // Timestamp and Value
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Time: ${timestamp.toLocal()}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text("Value: $value kWh", style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),

          // Status
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isLow ? Colors.red.shade100 : Colors.green.shade100,
            ),
            child: Center(
              child: Text(
                isLow ? "LOW" : "OK",
                style: TextStyle(
                  color: isLow ? Colors.red : Colors.green,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
