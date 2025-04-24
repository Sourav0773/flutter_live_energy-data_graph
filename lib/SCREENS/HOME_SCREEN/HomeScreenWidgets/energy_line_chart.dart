import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EnergyLineChart extends StatelessWidget {
  final List<FlSpot> spots;
  final double xMin;
  final double xMax;

  const EnergyLineChart({
    super.key,
    required this.spots,
    required this.xMin,
    required this.xMax,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 400,
        width: MediaQuery.sizeOf(context).width * 0.93,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LineChart(
            LineChartData(
              clipData: FlClipData.all(),
              minY: 0,
              maxY: 100,
              minX: xMin,
              maxX: xMax,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Colors.teal,
                  barWidth: 2,
                  dotData: FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [
                        Colors.teal.withOpacity(0.4),
                        Colors.teal.withOpacity(0.1),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
              gridData: FlGridData(show: false),
              borderData: FlBorderData(
                show: true,
                border: const Border(
                  left: BorderSide(color: Colors.black, width: 1),
                  bottom: BorderSide(color: Colors.black, width: 1),
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
