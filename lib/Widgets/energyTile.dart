import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnergyHistoryTile extends StatelessWidget {
  final int serialNumber;
  final DateTime timestamp;
  final String value;
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
    final formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(timestamp);

    return Container(
      height: 95,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFE6E3E3), width: 1.2),
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
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 18),

          // Value and Timestamp
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Value: $value kWh",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isLow ? Colors.red : Colors.green[700],
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Date & Time: $formattedDate",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),

          // Status Badge
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isLow ? Colors.red.shade100 : Colors.green.shade100,
            ),
            child: Center(
              child: Text(
                isLow ? "LOW" : "OK",
                style: TextStyle(
                  color: isLow ? Colors.red : Colors.green[800],
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
